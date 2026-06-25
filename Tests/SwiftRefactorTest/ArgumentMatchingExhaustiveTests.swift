//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation
import SwiftParser
import SwiftSyntax
import XCTest

final class ArgumentMatchingExhaustiveTests: XCTestCase {
  func testExhaustiveDifferentialAgainstCompiler() async throws {
    guard ProcessInfo.processInfo.environment["ARG_MATCH_EXHAUSTIVE"] == "1" else {
      throw XCTSkip("Set ARG_MATCH_EXHAUSTIVE=1 to run exhaustive argument matching differential tests")
    }

    // the maximum number of parameters the generated functions can have.
    let maxParameters = 4
    assert(maxParameters <= 6, "Exhaustive argument matching tests can grow very quickly with the number of parameters")
    // the maximum number of arguments that will be generated for variadic parameters.
    let maxVariadicCount = 2
    let includePacks = ProcessInfo.processInfo.environment["ARG_MATCH_EXHAUSTIVE_INCLUDE_PACKS"] != "0"
    let includeTrailingClosureDeclarations =
      ProcessInfo.processInfo.environment["ARG_MATCH_EXHAUSTIVE_INCLUDE_TRAILING_DECLS"] != "0"
    let includeClosureDeclarations =
      ProcessInfo.processInfo.environment["ARG_MATCH_EXHAUSTIVE_INCLUDE_CLOSURE_DECLS"] != "0"
    let workerCount = min(
      ProcessInfo.processInfo.activeProcessorCount,
      max(1, ProcessInfo.processInfo.environment["ARG_MATCH_EXHAUSTIVE_WORKERS"].flatMap(Int.init) ?? Int.max)
    )

    var declarationAndCalls = generateTestData(
      maxParameters: maxParameters,
      maxVariadicCount: maxVariadicCount,
      includePacks: includePacks,
      includeTrailingClosureDeclarations: includeTrailingClosureDeclarations,
      includeClosureDeclarations: includeClosureDeclarations
    )

    print("Generated \(declarationAndCalls.count) declarations with calls to test.")

    print("Running first compile in parallel with \(workerCount) workers...")
    let firstPassChunks = chunked(declarationAndCalls, chunkCount: workerCount)
    let firstPassResults = try await withThrowingTaskGroup(
      of: (Int, [(ExhaustiveDeclaration, [ExhaustiveCall], lineRange: Range<Int>)]).self
    ) { group in
      for (chunkIndex, chunk) in firstPassChunks.enumerated() {
        group.addTask {
          var localChunk = withRecalculatedLineRanges(chunk)
          let source = localChunk.map { (declaration, calls, _) in
            declaration.executableSourceWithoutBody(for: calls) + "\n"
          }.joined(separator: "\n")

          let runResult = try checkForErrors(source: source)
          if runResult.exitCode != 0 {
            try removeInvalidCalls(in: &localChunk, stderr: runResult.stderr)
          }

          return (chunkIndex, localChunk)
        }
      }

      var collected: [(Int, [(ExhaustiveDeclaration, [ExhaustiveCall], lineRange: Range<Int>)])] = []
      for try await result in group {
        collected.append(result)
      }
      return collected.sorted { $0.0 < $1.0 }.map { $0.1 }
    }
    declarationAndCalls = firstPassResults.flatMap { $0 }

    print("Running second compile in parallel...")

    let secondPassChunks = chunked(declarationAndCalls, chunkCount: workerCount)
    let secondPassResults = try await withThrowingTaskGroup(of: (Int, ExhaustiveProcessResult).self) { group in
      for (chunkIndex, chunk) in secondPassChunks.enumerated() {
        group.addTask {
          let source = chunk.map { (declaration, calls, _) in
            declaration.executableSource(for: calls)
          }.joined(separator: "\n")
          return (chunkIndex, try compileAndRun(source: source))
        }
      }

      var collected: [(Int, ExhaustiveProcessResult)] = []
      for try await result in group {
        collected.append(result)
      }
      return collected.sorted { $0.0 < $1.0 }.map { $0.1 }
    }

    if let firstFailed = secondPassResults.first(where: { $0.exitCode != 0 }) {
      XCTFail("Could not compile one of the generated chunks:\n\(firstFailed.stderr)")
      return
    }

    print("Extracting mappings from compiler output...")
    let compilerMappings = try secondPassResults.flatMap { try compilerMapping(from: $0.stdout) }
    let syntaxMappings = try declarationAndCalls.flatMap { (declaration, calls, _) in
      let declarationTree = Parser.parse(source: declaration.declarationWithoutBody)
      let functionDeclaration = try XCTUnwrap(
        declarationTree.statements.first?.item.as(FunctionDeclSyntax.self),
        "Expected generated declaration to parse as FunctionDeclSyntax"
      )
      return try calls.map { call in
        try getSyntaxMapping(declaration: functionDeclaration, call: call.callString)
      }
    }

    print("Comparing mappings...")

    let compilerByID = Dictionary(grouping: compilerMappings, by: \.id)
    let syntaxByID = Dictionary(grouping: syntaxMappings, by: \.id)

    for declaration in declarationAndCalls.map(\.0) {
      let id = declaration.id
      let compilerForID = compilerByID[id] ?? []
      let syntaxForID = syntaxByID[id] ?? []

      if compilerForID.count != syntaxForID.count {
        XCTFail(
          "Count mismatch for \(declaration.declarationWithoutBody): compiler=\(compilerForID.count), syntax=\(syntaxForID.count)"
        )
      }

      for index in compilerForID.indices {
        if compilerForID[index].mapping != syntaxForID[index].mapping {
          let call = syntaxForID[index].call ?? "<unknown>"
          XCTFail(
            """
            Mismatch for declaration \(declaration.declarationWithoutBody)
            with call \(call)
            Compiler: \(compilerForID[index].mapping)
            Swift-Syntax: \(syntaxForID[index].mapping)
            """
          )
        }
      }
    }

    print("Verified \(compilerMappings.count) matching mappings")
  }
}

private func generateTestData(
  maxParameters: Int,
  maxVariadicCount: Int,
  includePacks: Bool,
  includeTrailingClosureDeclarations: Bool,
  includeClosureDeclarations: Bool
) -> [(ExhaustiveDeclaration, [ExhaustiveCall], lineRange: Range<Int>)] {
  let labels = Array(["a", "b", "c", "d", "e", "f"].prefix(max(1, maxParameters)))
  var declarations = ExhaustiveGenerator.generateDeclarations(
    maxParameters: maxParameters,
    labels: labels,
    includePacks: includePacks
  )
  if includeTrailingClosureDeclarations {
    declarations += ExhaustiveGenerator.generateTrailingClosureDeclarations(
      maxParameters: maxParameters,
      labels: labels
    )
  }
  if includeClosureDeclarations {
    declarations += ExhaustiveGenerator.generateClosureDeclarations(maxParameters: maxParameters, labels: labels)
  }

  var lineOffsetInFile = 1  // 1 for being 1-indexed as the compiler error messages are
  var declarationAndCalls: [(ExhaustiveDeclaration, [ExhaustiveCall], lineRange: Range<Int>)] = []
  for declaration in declarations {
    let calls = ExhaustiveGenerator.generateCalls(for: declaration, maxVariadicCount: maxVariadicCount)

    let range = lineOffsetInFile..<(lineOffsetInFile + 1 + calls.count)
    declarationAndCalls.append((declaration, calls, lineRange: range))
    lineOffsetInFile += 1  // for the declaration
    lineOffsetInFile += calls.count
    lineOffsetInFile += 1  // for the empty line between declarations
  }

  return declarationAndCalls
}

private func chunked<T>(_ array: [T], chunkCount: Int) -> [[T]] {
  guard !array.isEmpty else { return [] }
  let safeChunkCount = max(1, min(chunkCount, array.count))
  let baseSize = array.count / safeChunkCount
  let remainder = array.count % safeChunkCount

  var chunks: [[T]] = []
  chunks.reserveCapacity(safeChunkCount)

  var start = array.startIndex
  for chunkIndex in 0..<safeChunkCount {
    let extra = chunkIndex < remainder ? 1 : 0
    let size = baseSize + extra
    let end = array.index(start, offsetBy: size)
    chunks.append(Array(array[start..<end]))
    start = end
  }
  return chunks
}

private func withRecalculatedLineRanges(
  _ declarations: [(ExhaustiveDeclaration, [ExhaustiveCall], lineRange: Range<Int>)]
) -> [(ExhaustiveDeclaration, [ExhaustiveCall], lineRange: Range<Int>)] {
  var lineOffset = 1
  var result: [(ExhaustiveDeclaration, [ExhaustiveCall], lineRange: Range<Int>)] = []
  result.reserveCapacity(declarations.count)

  for (declaration, calls, _) in declarations {
    let range = lineOffset..<(lineOffset + 1 + calls.count)
    result.append((declaration, calls, lineRange: range))
    lineOffset += 1
    lineOffset += calls.count
    lineOffset += 1
  }

  return result
}

private func removeInvalidCalls(
  in declarationAndCalls: inout [(ExhaustiveDeclaration, [ExhaustiveCall], lineRange: Range<Int>)],
  stderr: String
) throws {
  guard !declarationAndCalls.isEmpty else {
    return
  }

  var declarationIndex = declarationAndCalls.startIndex
  let regex = try Regex("Case\\.swift:(\\d+):\\d+: error:", as: (Substring, Substring).self)
  var offset = 0
  var processedLineNumbers = Set<Int>()

  for error in stderr.split(separator: "\n\n") {
    guard let match = error.firstMatch(of: regex) else {
      continue
    }
    let lineNumber = Int(match.1)!

    if processedLineNumbers.contains(lineNumber) {
      continue
    }
    processedLineNumbers.insert(lineNumber)

    while declarationIndex < declarationAndCalls.endIndex,
      declarationAndCalls[declarationIndex].2.upperBound <= lineNumber
    {
      declarationIndex = declarationAndCalls.index(after: declarationIndex)
      offset = 0
    }

    guard declarationIndex < declarationAndCalls.endIndex else {
      continue
    }

    let callsOffset = lineNumber - declarationAndCalls[declarationIndex].2.lowerBound - 1
    let index = callsOffset - offset

    if index < 0 || index >= declarationAndCalls[declarationIndex].1.count {
      continue
    }

    declarationAndCalls[declarationIndex].1.remove(at: index)
    offset += 1
  }
}

struct Mapping {
  let id: String
  let call: String?
  let mapping: [[Int]]
}

private func getSyntaxMapping(declaration: FunctionDeclSyntax, call: String) throws -> Mapping {
  let callTree = Parser.parse(source: call)
  let functionCall = try XCTUnwrap(
    callTree.statements.first?.item.as(FunctionCallExprSyntax.self),
    "Expected generated call to parse as FunctionCallExprSyntax"
  )

  let parameters = declaration.signature.parameterClause.parameters
  guard let result = functionCall.matchArguments(to: parameters) else {
    print("Failed to match arguments for call: \(call) to declaration: \(declaration.description)")
    return Mapping(id: declaration.name.text, call: call, mapping: [])
  }

  let m: [[Int]] = try parameters.map { parameter in
    let arguments = try XCTUnwrap(result.match(for: parameter).arguments)
    return arguments.compactMap { argument in
      if let labeledExpr = argument.as(LabeledExprSyntax.self) {
        if let value = Int(labeledExpr.expression.trimmedDescription) {
          return value
        }
        if let tupleExpr = labeledExpr.expression.as(TupleExprSyntax.self),
          let closureExpr = tupleExpr.elements.first?.expression.as(ClosureExprSyntax.self)
        {
          return trailingClosureValue(closureExpr)
        }
        return nil
      }
      if let closureExpr = argument.as(ClosureExprSyntax.self) {
        return trailingClosureValue(closureExpr)
      }
      if let trailingClosure = argument.as(MultipleTrailingClosureElementSyntax.self) {
        return trailingClosureValue(trailingClosure.closure)
      }
      return nil
    }
  }
  return Mapping(id: declaration.name.text, call: call, mapping: m)
}

private func trailingClosureValue(_ closure: ClosureExprSyntax) -> Int? {
  guard
    let integerExpr = closure.statements.first?.item.as(IntegerLiteralExprSyntax.self)
  else {
    return nil
  }
  return Int(integerExpr.literal.text)
}

private func compilerMapping(from stdout: String) throws -> [Mapping] {
  var mappings: [Mapping] = []
  for line in stdout.split(separator: "\n") {
    // MATCH|id|mapping
    let components = line.split(separator: "|", maxSplits: 2, omittingEmptySubsequences: false)

    let id = String(components[1])
    let m: [[Int]] = components[2].split(separator: ";", omittingEmptySubsequences: false).map { segment in
      if segment.isEmpty {
        return []
      }
      return segment.split(separator: ",").compactMap { Int($0) }
    }
    mappings.append(Mapping(id: id, call: nil, mapping: m))
  }
  return mappings
}

private func compileAndRun(source: String) throws -> ExhaustiveProcessResult {
  let directory = FileManager.default.temporaryDirectory.appendingPathComponent(
    "arg-match-exhaustive-compile-and-run-\(UUID().uuidString)",
    isDirectory: true
  )
  try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
  defer { try? FileManager.default.removeItem(at: directory) }

  let sourceFile = directory.appendingPathComponent("Case.swift")
  let executable = directory.appendingPathComponent("CaseExec")
  try source.write(to: sourceFile, atomically: true, encoding: .utf8)

  let compileResult = try runProcess(
    executable: URL(fileURLWithPath: "/usr/bin/env"),
    arguments: ["swiftc", sourceFile.path, "-o", executable.path]
  )
  guard compileResult.exitCode == 0 else {
    return compileResult
  }

  return try runProcess(executable: executable, arguments: [])
}

private func checkForErrors(source: String) throws -> ExhaustiveProcessResult {
  let directory = FileManager.default.temporaryDirectory.appendingPathComponent(
    "arg-match-exhaustive-typecheck-\(UUID().uuidString)",
    isDirectory: true
  )
  try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
  defer { try? FileManager.default.removeItem(at: directory) }

  let sourceFile = directory.appendingPathComponent("Case.swift")
  try source.write(to: sourceFile, atomically: true, encoding: .utf8)

  let compileResult = try runProcess(
    executable: URL(fileURLWithPath: "/usr/bin/env"),
    arguments: ["swiftc", "-typecheck", sourceFile.path]
  )

  return compileResult
}

private func runProcess(executable: URL, arguments: [String]) throws -> ExhaustiveProcessResult {
  let process = Process()
  process.executableURL = executable
  process.arguments = arguments

  let outputDirectory = FileManager.default.temporaryDirectory.appendingPathComponent(
    "arg-match-exhaustive-process-\(UUID().uuidString)",
    isDirectory: true
  )
  try FileManager.default.createDirectory(at: outputDirectory, withIntermediateDirectories: true)
  defer { try? FileManager.default.removeItem(at: outputDirectory) }

  let stdoutFile = outputDirectory.appendingPathComponent("stdout.txt")
  let stderrFile = outputDirectory.appendingPathComponent("stderr.txt")
  FileManager.default.createFile(atPath: stdoutFile.path, contents: nil)
  FileManager.default.createFile(atPath: stderrFile.path, contents: nil)

  let stdoutHandle = try FileHandle(forWritingTo: stdoutFile)
  let stderrHandle = try FileHandle(forWritingTo: stderrFile)
  defer {
    try? stdoutHandle.close()
    try? stderrHandle.close()
  }

  process.standardOutput = stdoutHandle
  process.standardError = stderrHandle

  try process.run()
  process.waitUntilExit()

  let stdout = try String(contentsOf: stdoutFile, encoding: .utf8)
  let stderr = try String(contentsOf: stderrFile, encoding: .utf8)

  return ExhaustiveProcessResult(exitCode: Int(process.terminationStatus), stdout: stdout, stderr: stderr)
}

private struct ExhaustiveProcessResult {
  let exitCode: Int
  let stdout: String
  let stderr: String
}

private enum ExhaustiveGenerator {
  static func generateDeclarations(maxParameters: Int, labels: [String], includePacks: Bool) -> [ExhaustiveDeclaration]
  {
    var all: [ExhaustiveDeclaration] = []
    var declarationCounter = 0

    for parameterCount in 1...maxParameters {
      var current: [ExhaustiveParameter] = []

      func recurse(parameterIndex: Int, labelIndex: Int, previousWasVariadicLike: Bool) {
        if parameterIndex == parameterCount {
          let declaration = ExhaustiveDeclaration(id: "decl_\(declarationCounter)", parameters: current)
          declarationCounter += 1
          all.append(declaration)
          return
        }

        var labelOptions: [ExhaustiveLabel] = []
        labelOptions.append(.named(labels[labelIndex]))
        if parameterIndex > 0 && labelIndex + 1 < labels.count {
          labelOptions.append(.named(labels[labelIndex + 1]))
        }
        if !previousWasVariadicLike {
          labelOptions.append(.unlabeled)
        }

        for label in labelOptions {
          // Int parameters: fixed/variadic + optional defaults for fixed.
          for isVariadic in [false, true] {
            let defaultOptions = isVariadic ? [false] : [false, true]
            for isDefaulted in defaultOptions {
              let parameter = ExhaustiveParameter(
                label: label,
                kind: .int,
                localName: "p\(parameterIndex)",
                isDefaulted: isDefaulted,
                isVariadic: isVariadic,
                defaultSentinel: -1000 - parameterIndex
              )
              current.append(parameter)
              let newLabelIndex = label == .unlabeled ? labelIndex + 1 : labelIndex
              recurse(
                parameterIndex: parameterIndex + 1,
                labelIndex: newLabelIndex,
                previousWasVariadicLike: isVariadic
              )
              _ = current.popLast()
            }
          }

          if includePacks {
            // Pack parameters are variadic-like for following-label rules.
            let packParameter = ExhaustiveParameter(
              label: label,
              kind: .pack,
              localName: "p\(parameterIndex)",
              isDefaulted: false,
              isVariadic: false,
              defaultSentinel: -1000 - parameterIndex
            )
            current.append(packParameter)
            let newLabelIndex = label == .unlabeled ? labelIndex + 1 : labelIndex
            recurse(
              parameterIndex: parameterIndex + 1,
              labelIndex: newLabelIndex,
              previousWasVariadicLike: true
            )
            _ = current.popLast()
          }
        }
      }

      recurse(parameterIndex: 0, labelIndex: 0, previousWasVariadicLike: false)
    }

    return all
  }

  static func generateTrailingClosureDeclarations(maxParameters: Int, labels: [String]) -> [ExhaustiveDeclaration] {
    var all: [ExhaustiveDeclaration] = []
    var declarationCounter = 0

    for closureCount in 1...2 {
      let intCount = maxParameters - closureCount
      var current: [ExhaustiveParameter] = []

      func recurseIntParameters(parameterIndex: Int, labelIndex: Int) {
        if parameterIndex == intCount {
          recurseClosureParameters(closureIndex: 0, labelIndex: labelIndex)
          return
        }

        let labelOptions: [ExhaustiveLabel] = [.named(labels[labelIndex]), .unlabeled]
        for label in labelOptions {
          current.append(
            ExhaustiveParameter(
              label: label,
              kind: .int,
              localName: "p\(parameterIndex)",
              isDefaulted: false,
              isVariadic: false,
              defaultSentinel: -1000 - parameterIndex
            )
          )
          let newLabelIndex = label == .unlabeled ? min(labelIndex + 1, labels.count - 1) : labelIndex
          recurseIntParameters(parameterIndex: parameterIndex + 1, labelIndex: newLabelIndex)
          _ = current.popLast()
        }
      }

      func recurseClosureParameters(closureIndex: Int, labelIndex: Int) {
        if closureIndex == closureCount {
          all.append(ExhaustiveDeclaration(id: "decl_trailing_\(declarationCounter)", parameters: current))
          declarationCounter += 1
          return
        }

        let parameterIndex = intCount + closureIndex
        let labelOptions: [ExhaustiveLabel]
        if closureIndex == 0 {
          labelOptions = [.named(labels[labelIndex]), .unlabeled]
        } else {
          let next = min(labelIndex + 1, labels.count - 1)
          labelOptions = [.named(labels[labelIndex]), .named(labels[next])]
        }

        for label in labelOptions {
          current.append(
            ExhaustiveParameter(
              label: label,
              kind: .trailingClosure,
              localName: "p\(parameterIndex)",
              isDefaulted: false,
              isVariadic: false,
              defaultSentinel: -1000 - parameterIndex
            )
          )
          let newLabelIndex: Int
          if case .named = label {
            newLabelIndex = labelIndex
          } else {
            newLabelIndex = min(labelIndex + 1, labels.count - 1)
          }
          recurseClosureParameters(closureIndex: closureIndex + 1, labelIndex: newLabelIndex)
          _ = current.popLast()
        }
      }

      recurseIntParameters(parameterIndex: 0, labelIndex: 0)
    }

    return all
  }

  static func generateClosureDeclarations(maxParameters: Int, labels: [String]) -> [ExhaustiveDeclaration] {
    // Closure-heavy declarations, generated systematically to mirror manual
    // closure/default/variadic/trailing scenarios while keeping runtime bounded.
    let closureParameterCount = min(3, maxParameters)
    var all: [ExhaustiveDeclaration] = []
    var declarationCounter = 0

    for parameterCount in 1...closureParameterCount {
      var current: [ExhaustiveParameter] = []

      func recurse(parameterIndex: Int, labelIndex: Int, previousWasVariadic: Bool) {
        if parameterIndex == parameterCount {
          all.append(ExhaustiveDeclaration(id: "decl_closure_\(declarationCounter)", parameters: current))
          declarationCounter += 1
          return
        }

        var labelOptions: [ExhaustiveLabel] = []
        labelOptions.append(.named(labels[labelIndex]))
        if parameterIndex > 0 && labelIndex + 1 < labels.count {
          labelOptions.append(.named(labels[labelIndex + 1]))
        }
        if !previousWasVariadic {
          labelOptions.append(.unlabeled)
        }

        for label in labelOptions {
          for isVariadic in [false, true] {
            let defaultOptions = isVariadic ? [false] : [false, true]
            for isDefaulted in defaultOptions {
              current.append(
                ExhaustiveParameter(
                  label: label,
                  kind: .closure,
                  localName: "p\(parameterIndex)",
                  isDefaulted: isDefaulted,
                  isVariadic: isVariadic,
                  defaultSentinel: -1000 - parameterIndex
                )
              )
              let newLabelIndex = label == .unlabeled ? min(labelIndex + 1, labels.count - 1) : labelIndex
              recurse(parameterIndex: parameterIndex + 1, labelIndex: newLabelIndex, previousWasVariadic: isVariadic)
              _ = current.popLast()
            }
          }
        }
      }

      recurse(parameterIndex: 0, labelIndex: 0, previousWasVariadic: false)
    }

    return all
  }

  static func generateCalls(for declaration: ExhaustiveDeclaration, maxVariadicCount: Int) -> [ExhaustiveCall] {
    var calls: [ExhaustiveCall] = []

    func recurse(
      parameterIndex: Int,
      nextValue: Int,
      accumulated: [String],
      firstTrailingClosure: String?,
      additionalTrailingClosures: [(String, String)]
    ) {
      if parameterIndex == declaration.parameters.count {
        calls.append(
          ExhaustiveCall(
            functionName: declaration.id,
            callArguments: accumulated,
            firstTrailingClosure: firstTrailingClosure,
            additionalTrailingClosures: additionalTrailingClosures
          )
        )
        return
      }

      let parameter = declaration.parameters[parameterIndex]

      if parameter.kind == .trailingClosure {
        let body = "{ \(nextValue) }"
        if firstTrailingClosure == nil {
          recurse(
            parameterIndex: parameterIndex + 1,
            nextValue: nextValue + 1,
            accumulated: accumulated,
            firstTrailingClosure: body,
            additionalTrailingClosures: additionalTrailingClosures
          )
        } else {
          guard case .named(let label) = parameter.label else {
            return
          }
          recurse(
            parameterIndex: parameterIndex + 1,
            nextValue: nextValue + 1,
            accumulated: accumulated,
            firstTrailingClosure: firstTrailingClosure,
            additionalTrailingClosures: additionalTrailingClosures + [(label, body)]
          )
        }
        return
      }

      if parameter.kind == .closure {
        func makeArgumentClosureExpr(_ value: Int) -> String {
          "({ \(value) })"
        }

        func makeTrailingClosureExpr(_ value: Int) -> String {
          "{ \(value) }"
        }

        if parameter.isVariadic {
          for variadicCount in 0...maxVariadicCount {
            var arguments = accumulated
            var value = nextValue
            for variadicIndex in 0..<variadicCount {
              let expr = makeArgumentClosureExpr(value)
              switch parameter.label {
              case .unlabeled:
                arguments.append(expr)
              case .named(let label):
                if variadicIndex == 0 {
                  arguments.append("\(label): \(expr)")
                } else {
                  arguments.append(expr)
                }
              }
              value += 1
            }

            recurse(
              parameterIndex: parameterIndex + 1,
              nextValue: value,
              accumulated: arguments,
              firstTrailingClosure: firstTrailingClosure,
              additionalTrailingClosures: additionalTrailingClosures
            )

            // Also explore consuming one extra closure via trailing syntax when
            // no trailing closure has started yet.
            if firstTrailingClosure == nil {
              recurse(
                parameterIndex: parameterIndex + 1,
                nextValue: value + 1,
                accumulated: arguments,
                firstTrailingClosure: makeTrailingClosureExpr(value),
                additionalTrailingClosures: additionalTrailingClosures
              )
            }
          }
          return
        }

        if parameter.isDefaulted {
          recurse(
            parameterIndex: parameterIndex + 1,
            nextValue: nextValue,
            accumulated: accumulated,
            firstTrailingClosure: firstTrailingClosure,
            additionalTrailingClosures: additionalTrailingClosures
          )
        }

        let argumentExpr = makeArgumentClosureExpr(nextValue)
        let trailingExpr = makeTrailingClosureExpr(nextValue)
        if firstTrailingClosure == nil {
          var withArgument = accumulated
          switch parameter.label {
          case .unlabeled:
            withArgument.append(argumentExpr)
          case .named(let label):
            withArgument.append("\(label): \(argumentExpr)")
          }
          recurse(
            parameterIndex: parameterIndex + 1,
            nextValue: nextValue + 1,
            accumulated: withArgument,
            firstTrailingClosure: firstTrailingClosure,
            additionalTrailingClosures: additionalTrailingClosures
          )

          recurse(
            parameterIndex: parameterIndex + 1,
            nextValue: nextValue + 1,
            accumulated: accumulated,
            firstTrailingClosure: trailingExpr,
            additionalTrailingClosures: additionalTrailingClosures
          )
        } else if case .named(let label) = parameter.label {
          recurse(
            parameterIndex: parameterIndex + 1,
            nextValue: nextValue + 1,
            accumulated: accumulated,
            firstTrailingClosure: firstTrailingClosure,
            additionalTrailingClosures: additionalTrailingClosures + [(label, trailingExpr)]
          )
        }
        return
      }

      if parameter.kind == .pack {
        for packCount in 0...maxVariadicCount {
          var arguments = accumulated
          var value = nextValue
          for packIndex in 0..<packCount {
            switch parameter.label {
            case .unlabeled:
              arguments.append("\(value)")
            case .named(let label):
              if packIndex == 0 {
                arguments.append("\(label): \(value)")
              } else {
                arguments.append("\(value)")
              }
            }
            value += 1
          }
          recurse(
            parameterIndex: parameterIndex + 1,
            nextValue: value,
            accumulated: arguments,
            firstTrailingClosure: firstTrailingClosure,
            additionalTrailingClosures: additionalTrailingClosures
          )
        }
        return
      }

      if parameter.isVariadic {
        for variadicCount in 0...maxVariadicCount {
          var arguments = accumulated
          var value = nextValue
          for variadicIndex in 0..<variadicCount {
            switch parameter.label {
            case .unlabeled:
              arguments.append("\(value)")
            case .named(let label):
              if variadicIndex == 0 {
                arguments.append("\(label): \(value)")
              } else {
                arguments.append("\(value)")
              }
            }
            value += 1
          }
          recurse(
            parameterIndex: parameterIndex + 1,
            nextValue: value,
            accumulated: arguments,
            firstTrailingClosure: firstTrailingClosure,
            additionalTrailingClosures: additionalTrailingClosures
          )
        }
        return
      }

      if parameter.isDefaulted {
        recurse(
          parameterIndex: parameterIndex + 1,
          nextValue: nextValue,
          accumulated: accumulated,
          firstTrailingClosure: firstTrailingClosure,
          additionalTrailingClosures: additionalTrailingClosures
        )
      }

      var withArgument = accumulated
      switch parameter.label {
      case .unlabeled:
        withArgument.append("\(nextValue)")
      case .named(let label):
        withArgument.append("\(label): \(nextValue)")
      }
      recurse(
        parameterIndex: parameterIndex + 1,
        nextValue: nextValue + 1,
        accumulated: withArgument,
        firstTrailingClosure: firstTrailingClosure,
        additionalTrailingClosures: additionalTrailingClosures
      )
    }

    recurse(
      parameterIndex: 0,
      nextValue: 1000,
      accumulated: [],
      firstTrailingClosure: nil,
      additionalTrailingClosures: []
    )
    return calls
  }
}

private struct ExhaustiveDeclaration {
  let id: String
  let parameters: [ExhaustiveParameter]

  private var packTypeNumberByParameterIndex: [Int: Int] {
    var map: [Int: Int] = [:]
    var nextPackNumber = 0
    for (index, parameter) in parameters.enumerated() {
      guard parameter.kind == .pack else {
        continue
      }
      map[index] = nextPackNumber
      nextPackNumber += 1
    }
    return map
  }

  private var params: String {
    parameters.enumerated().map { index, parameter in
      let labelText: String
      switch parameter.label {
      case .unlabeled:
        labelText = "_"
      case .named(let label):
        labelText = label
      }

      let typeText: String
      switch parameter.kind {
      case .int:
        typeText = parameter.isVariadic ? "Int..." : "Int"
      case .trailingClosure, .closure:
        typeText = parameter.isVariadic ? "(() -> Int)..." : "() -> Int"
      case .pack:
        typeText = "repeat each T\(packTypeNumberByParameterIndex[index]!)"
      }
      let defaultText: String
      if parameter.isDefaulted {
        switch parameter.kind {
        case .int:
          defaultText = " = \(parameter.defaultSentinel)"
        case .trailingClosure, .closure:
          defaultText = " = { \(parameter.defaultSentinel) }"
        case .pack:
          defaultText = ""
        }
      } else {
        defaultText = ""
      }
      return "\(labelText) \(parameter.localName): \(typeText)\(defaultText)"
    }.joined(separator: ", ")
  }

  private var genericClauseText: String {
    let packNumbers = parameters.enumerated().compactMap { index, parameter in
      parameter.kind == .pack ? packTypeNumberByParameterIndex[index] : nil
    }
    guard !packNumbers.isEmpty else {
      return ""
    }

    let genericParams = packNumbers.map { "each T\($0)" }.joined(separator: ", ")
    return "<\(genericParams)>"
  }

  private var whereClauseText: String {
    let packNumbers = parameters.enumerated().compactMap { index, parameter in
      parameter.kind == .pack ? packTypeNumberByParameterIndex[index] : nil
    }
    guard !packNumbers.isEmpty else {
      return ""
    }

    let requirements = packNumbers.map { "repeat each T\($0): BinaryInteger" }.joined(separator: ", ")
    return "where \(requirements)"
  }

  var declarationString: String {
    return "func \(id)\(genericClauseText)(\(params)) \(whereClauseText) { \(runtimeMappingBody) }"
  }

  var declarationWithoutBody: String {
    return "func \(id)\(genericClauseText)(\(params)) \(whereClauseText) {}"
  }

  var declarationSource: String {
    return """
      import Foundation
      \(declarationString)
      """
  }

  var shape: String {
    parameters.map { parameter in
      let labelPart: String
      switch parameter.label {
      case .unlabeled: labelPart = "_"
      case .named: labelPart = "l"
      }
      let defaultPart = parameter.isDefaulted ? "d" : "r"
      let variadicPart = parameter.isVariadic ? "v" : "f"
      return "\(labelPart)\(defaultPart)\(variadicPart)"
    }.joined(separator: "-")
  }

  func executableSource(for call: ExhaustiveCall) -> String {
    return """
      \(declarationString)
      \(call.callString)
      """
  }

  func executableSource(for calls: [ExhaustiveCall]) -> String {
    let callsSource = calls.map { $0.callString }.joined(separator: "\n")
    return """
      \(declarationString)
      \(callsSource)
      """
  }

  func executableSourceWithoutBody(for calls: [ExhaustiveCall]) -> String {
    let callsSource = calls.map { $0.callString }.joined(separator: "\n")
    return """
      \(declarationWithoutBody)
      \(callsSource)
      """
  }

  private var runtimeMappingBody: String {
    let bindings = parameters.map { parameter -> String in
      if parameter.kind == .trailingClosure {
        return "let m_\(parameter.localName): [Int] = [\(parameter.localName)()]"
      }
      if parameter.kind == .closure {
        if parameter.isVariadic {
          return "let m_\(parameter.localName): [Int] = \(parameter.localName).map { $0() }"
        }
        if parameter.isDefaulted {
          return
            "let m_\(parameter.localName): [Int] = \(parameter.localName)() == \(parameter.defaultSentinel) ? [] : [\(parameter.localName)()]"
        }
        return "let m_\(parameter.localName): [Int] = [\(parameter.localName)()]"
      }
      if parameter.kind == .pack {
        return
          "var m_\(parameter.localName): [Int] = []; for v in repeat each \(parameter.localName) { m_\(parameter.localName).append(Int(v)) }"
      }
      if parameter.isVariadic {
        return "let m_\(parameter.localName): [Int] = \(parameter.localName)"
      }
      if parameter.isDefaulted {
        return
          "let m_\(parameter.localName): [Int] = \(parameter.localName) == \(parameter.defaultSentinel) ? [] : [\(parameter.localName)]"
      }
      return "let m_\(parameter.localName): [Int] = [\(parameter.localName)]"
    }.joined(separator: "; ")

    let mappings = parameters.map { parameter in
      return
        #"let m_\#(parameter.localName)_mapped: String = m_\#(parameter.localName).map(String.init).joined(separator: ",")"#
    }.joined(separator: "; ")

    let mappedVariableNames = parameters.map { "m_\($0.localName)_mapped" }.joined(separator: ", ")
    let matchesVariable = "let matches: [String] = [\(mappedVariableNames)]"
    let matchString = "let matchString = matches.joined(separator: \";\")"

    return #"\#(bindings); \#(mappings); \#(matchesVariable); \#(matchString); print("MATCH|\#(id)|" + matchString)"#
  }
}

private struct ExhaustiveCall {
  let functionName: String
  let callArguments: [String]
  let firstTrailingClosure: String?
  let additionalTrailingClosures: [(String, String)]

  var callString: String {
    let base = "\(functionName)(\(callArguments.joined(separator: ", ")))"
    guard let firstTrailingClosure else {
      return base
    }
    let additional = additionalTrailingClosures.map { label, closure in
      "\(label): \(closure)"
    }.joined(separator: " ")

    if additional.isEmpty {
      return "\(base) \(firstTrailingClosure)"
    }
    return "\(base) \(firstTrailingClosure) \(additional)"
  }
}

private struct ExhaustiveParameter {
  let label: ExhaustiveLabel
  let kind: ExhaustiveParameterKind
  let localName: String
  let isDefaulted: Bool
  let isVariadic: Bool
  let defaultSentinel: Int
}

private enum ExhaustiveParameterKind {
  case int
  case trailingClosure
  case closure
  case pack
}

private enum ExhaustiveLabel: Equatable {
  case unlabeled
  case named(String)
}
