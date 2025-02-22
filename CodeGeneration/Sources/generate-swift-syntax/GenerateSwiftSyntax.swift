//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import ArgumentParser
import Dispatch
import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder
import SyntaxSupport
import Utils

struct GeneratedFileSpec {
  let pathComponents: [String]
  private let contentsGenerator: () -> String
  var contents: String {
    return self.contentsGenerator()
  }

  init(_ pathComponents: [String], _ contents: @escaping @autoclosure () -> String) {
    self.pathComponents = pathComponents
    self.contentsGenerator = contents
  }

  init(
    _ pathComponents: [String],
    _ contents: @escaping @autoclosure () -> SourceFileSyntax,
    format: CodeGenerationFormat = CodeGenerationFormat()
  ) {
    self.init(pathComponents, "\(contents().formatted(using: format))\n")
  }
}

struct TemplateSpec {
  let sourceFileGenerator: () -> SourceFileSyntax
  var sourceFile: SourceFileSyntax {
    return self.sourceFileGenerator()
  }
  let module: String
  let filename: String

  init(sourceFile: @escaping @autoclosure () -> SourceFileSyntax, module: String, filename: String) {
    self.sourceFileGenerator = sourceFile
    self.module = module
    self.filename = filename
  }
}

@main
struct GenerateSwiftSyntax: AsyncParsableCommand {
  @Argument(
    help:
      "The path to the generated source directory (i.e. 'swift-syntax/generatedSources') where the files are to be generated"
  )
  var destination: String = {
    let sourcesURL = URL(fileURLWithPath: #filePath)
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .appendingPathComponent("generatedSources")
    return sourcesURL.path
  }()

  @Flag(help: "Enable verbose output")
  var verbose: Bool = false

  func run() async throws {
    let destination = URL(fileURLWithPath: self.destination).standardizedFileURL

    var fileSpecs: [GeneratedFileSpec] = [
      // SwiftParser
      GeneratedFileSpec(["SwiftParser", "ExperimentalFeatures.swift"], experimentalFeaturesFile),
      GeneratedFileSpec(["SwiftParser", "IsLexerClassified.swift"], isLexerClassifiedFile),
      GeneratedFileSpec(["SwiftParser", "LayoutNodes+Parsable.swift"], layoutNodesParsableFile),
      GeneratedFileSpec(["SwiftParser", "Parser+TokenSpecSet.swift"], parserTokenSpecSetFile),
      GeneratedFileSpec(["SwiftParser", "TokenSpecStaticMembers.swift"], tokenSpecStaticMembersFile),

      // SwiftParserDiagnostics
      GeneratedFileSpec(["SwiftParserDiagnostics", "ChildNameForDiagnostics.swift"], childNameForDiagnosticFile),
      GeneratedFileSpec(
        ["SwiftParserDiagnostics", "SyntaxKindNameForDiagnostics.swift"],
        syntaxKindNameForDiagnosticFile
      ),
      GeneratedFileSpec(["SwiftParserDiagnostics", "TokenNameForDiagnostics.swift"], tokenNameForDiagnosticFile),

      // SwiftSyntax
      GeneratedFileSpec(["SwiftSyntax", "ChildNameForKeyPath.swift"], childNameForKeyPathFile),
      GeneratedFileSpec(["SwiftSyntax", "Keyword.swift"], keywordFile),
      GeneratedFileSpec(["SwiftSyntax", "raw", "RawSyntaxValidation.swift"], rawSyntaxValidationFile),
      GeneratedFileSpec(["SwiftSyntax", "RenamedChildrenCompatibility.swift"], renamedChildrenCompatibilityFile),
      GeneratedFileSpec(["SwiftSyntax", "RenamedNodesCompatibility.swift"], renamedSyntaxNodesFile),
      GeneratedFileSpec(["SwiftSyntax", "SyntaxAnyVisitor.swift"], syntaxAnyVisitorFile),
      GeneratedFileSpec(["SwiftSyntax", "SyntaxBaseNodes.swift"], syntaxBaseNodesFile),
      GeneratedFileSpec(["SwiftSyntax", "SyntaxCollections.swift"], syntaxCollectionsFile),
      GeneratedFileSpec(["SwiftSyntax", "SyntaxEnum.swift"], syntaxEnumFile),
      GeneratedFileSpec(["SwiftSyntax", "SyntaxKind.swift"], syntaxKindFile),
      GeneratedFileSpec(["SwiftSyntax", "SyntaxRewriter.swift"], syntaxRewriterFile),
      GeneratedFileSpec(["SwiftSyntax", "SyntaxTraits.swift"], syntaxTraitsFile),
      GeneratedFileSpec(
        ["SwiftSyntax", "SyntaxVisitor.swift"],
        syntaxVisitorFile,
        format: CodeGenerationFormat(maxElementsOnSameLine: 4)
      ),
      GeneratedFileSpec(["SwiftSyntax", "TokenKind.swift"], tokenKindFile),
      GeneratedFileSpec(["SwiftSyntax", "Tokens.swift"], tokensFile),
      GeneratedFileSpec(["SwiftSyntax", "TriviaPieces.swift"], triviaPiecesFile),
      GeneratedFileSpec(["SwiftSyntax", "Documentation.docc", "SwiftSyntax.md"], swiftSyntaxDoccIndex),

      // SwiftSyntaxBuilder
      GeneratedFileSpec(["SwiftSyntaxBuilder", "BuildableNodes.swift"], buildableNodesFile),
      GeneratedFileSpec(["SwiftSyntaxBuilder", "ResultBuilders.swift"], resultBuildersFile),
      GeneratedFileSpec(
        ["SwiftSyntaxBuilder", "SyntaxExpressibleByStringInterpolationConformances.swift"],
        syntaxExpressibleByStringInterpolationConformancesFile
      ),
      GeneratedFileSpec(
        ["SwiftSyntaxBuilder", "RenamedChildrenBuilderCompatibility.swift"],
        renamedChildrenBuilderCompatibilityFile
      ),
    ]
    // This split of letters produces files for the syntax nodes that have about equal size, which improves compile time

    fileSpecs += ["AB", "C", "D", "EF", "GHI", "JKLMN", "OP", "QRS", "TUVWXYZ"].flatMap {
      (letters: String) -> [GeneratedFileSpec] in
      [
        GeneratedFileSpec(
          ["SwiftSyntax", "syntaxNodes", "SyntaxNodes\(letters).swift"],
          syntaxNode(nodesStartingWith: Array(letters))
        ),
        GeneratedFileSpec(
          ["SwiftSyntax", "raw", "RawSyntaxNodes\(letters).swift"],
          rawSyntaxNodesFile(nodesStartingWith: Array(letters))
        ),
      ]
    }

    var previouslyGeneratedFiles = Set(
      FileManager.default
        .enumerator(at: destination, includingPropertiesForKeys: nil)!
        .compactMap { $0 as? URL }
        .filter { !$0.hasDirectoryPath }
        .map { $0.resolvingSymlinksInPath() }
    )

    await withTaskGroup(of: (url: URL, error: Error?).self) { group in
      for fileSpec in fileSpecs {
        group.addTask {
          do {
            var destination = destination
            for component in fileSpec.pathComponents {
              destination = destination.appendingPathComponent(component)
            }
            do {
              try generateFile(
                contents: fileSpec.contents,
                destination: destination,
                verbose: verbose
              )
            } catch {
              // If we throw from here, we'll lose the URL,
              // and we'll end up removing a file that is still
              // included in the files we intend to generate,
              // even if we failed to do so on this run.
              return (destination, error)
            }
            return (destination, nil)
          }
        }
      }
      for await result in group {
        _ = previouslyGeneratedFiles.remove(result.url)
        if let error = result.error {
          print("Error when generating file at \(result.url):", error)
        }
      }
    }

    for file in previouslyGeneratedFiles {
      // All files in `previouslyGeneratedFiles` that haven't been removed from
      // the set above no longer exist. Remove them.
      try FileManager.default.removeItem(at: file)
    }
  }

}

fileprivate func generateFile(
  contents: @autoclosure () -> String,
  destination: URL,
  verbose: Bool
) throws {
  try FileManager.default.createDirectory(
    atPath: destination.deletingLastPathComponent().path,
    withIntermediateDirectories: true,
    attributes: nil
  )

  if verbose {
    print("Generating \(destination.path)...")
  }
  let start = Date()
  try contents().write(to: destination, atomically: true, encoding: .utf8)
  if verbose {
    print("Generated \(destination.path) in \((Date().timeIntervalSince(start) * 1000).rounded() / 1000)s")
  }
}
