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

private let generatedDirName = "generated"

private let swiftBasicFormatGeneratedDir = ["SwiftBasicFormat", generatedDirName]
private let swiftideUtilsGeneratedDir = ["SwiftIDEUtils", generatedDirName]
private let swiftParserGeneratedDir = ["SwiftParser", generatedDirName]
private let swiftParserDiagnosticsGeneratedDir = ["SwiftParserDiagnostics", generatedDirName]
private let swiftSyntaxGeneratedDir = ["SwiftSyntax", generatedDirName]
private let swiftSyntaxBuilderGeneratedDir = ["SwiftSyntaxBuilder", generatedDirName]
private let BASE_KIND_FILES: [SyntaxNodeKind: String] = [
  .decl: "SyntaxDeclNodes.swift",
  .expr: "SyntaxExprNodes.swift",
  .pattern: "SyntaxPatternNodes.swift",
  .stmt: "SyntaxStmtNodes.swift",
  .syntax: "SyntaxNodes.swift",
  .type: "SyntaxTypeNodes.swift",
]

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
    help: "The path to the source directory (i.e. 'swift-syntax/Sources') where the source files are to be generated"
  )
  var destination: String = {
    let sourcesURL = URL(fileURLWithPath: #filePath)
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .appendingPathComponent("Sources")
    return sourcesURL.path
  }()

  @Flag(help: "Enable verbose output")
  var verbose: Bool = false

  func run() async throws {
    let destination = URL(fileURLWithPath: self.destination).standardizedFileURL

    var fileSpecs: [GeneratedFileSpec] = [
      // SwiftParser
      GeneratedFileSpec(swiftParserGeneratedDir + ["ExperimentalFeatures.swift"], experimentalFeaturesFile),
      GeneratedFileSpec(swiftParserGeneratedDir + ["IsLexerClassified.swift"], isLexerClassifiedFile),
      GeneratedFileSpec(swiftParserGeneratedDir + ["LayoutNodes+Parsable.swift"], layoutNodesParsableFile),
      GeneratedFileSpec(swiftParserGeneratedDir + ["Parser+TokenSpecSet.swift"], parserTokenSpecSetFile),
      GeneratedFileSpec(swiftParserGeneratedDir + ["TokenSpecStaticMembers.swift"], tokenSpecStaticMembersFile),

      // SwiftParserDiagnostics
      GeneratedFileSpec(
        swiftParserDiagnosticsGeneratedDir + ["ChildNameForDiagnostics.swift"],
        childNameForDiagnosticFile
      ),
      GeneratedFileSpec(
        swiftParserDiagnosticsGeneratedDir + ["SyntaxKindNameForDiagnostics.swift"],
        syntaxKindNameForDiagnosticFile
      ),
      GeneratedFileSpec(
        swiftParserDiagnosticsGeneratedDir + ["TokenNameForDiagnostics.swift"],
        tokenNameForDiagnosticFile
      ),

      // SwiftSyntax
      GeneratedFileSpec(swiftSyntaxGeneratedDir + ["ConcreteSyntaxProperty.swift"], concreteSyntaxPropertyFile),
      GeneratedFileSpec(swiftSyntaxGeneratedDir + ["Keyword.swift"], keywordFile),
      GeneratedFileSpec(swiftSyntaxGeneratedDir + ["raw", "RawSyntaxValidation.swift"], rawSyntaxValidationFile),
      GeneratedFileSpec(
        swiftSyntaxGeneratedDir + ["RenamedChildrenCompatibility.swift"],
        renamedChildrenCompatibilityFile
      ),
      GeneratedFileSpec(swiftSyntaxGeneratedDir + ["RenamedNodesCompatibility.swift"], renamedSyntaxNodesFile),
      GeneratedFileSpec(swiftSyntaxGeneratedDir + ["SyntaxAnyVisitor.swift"], syntaxAnyVisitorFile),
      GeneratedFileSpec(swiftSyntaxGeneratedDir + ["SyntaxBaseNodes.swift"], syntaxBaseNodesFile),
      GeneratedFileSpec(swiftSyntaxGeneratedDir + ["SyntaxCollections.swift"], syntaxCollectionsFile),
      GeneratedFileSpec(swiftSyntaxGeneratedDir + ["SyntaxEnum.swift"], syntaxEnumFile),
      GeneratedFileSpec(swiftSyntaxGeneratedDir + ["SyntaxKind.swift"], syntaxKindFile),
      GeneratedFileSpec(swiftSyntaxGeneratedDir + ["SyntaxLayoutNodes.swift"], syntaxLayoutNodesFile),
      GeneratedFileSpec(swiftSyntaxGeneratedDir + ["SyntaxRewriter.swift"], syntaxRewriterFile),
      GeneratedFileSpec(swiftSyntaxGeneratedDir + ["SyntaxTraits.swift"], syntaxTraitsFile),
      GeneratedFileSpec(
        swiftSyntaxGeneratedDir + ["SyntaxVisitor.swift"],
        syntaxVisitorFile,
        format: CodeGenerationFormat(maxElementsOnSameLine: 4)
      ),
      GeneratedFileSpec(swiftSyntaxGeneratedDir + ["TokenKind.swift"], tokenKindFile),
      GeneratedFileSpec(swiftSyntaxGeneratedDir + ["Tokens.swift"], tokensFile),
      GeneratedFileSpec(swiftSyntaxGeneratedDir + ["TriviaPieces.swift"], triviaPiecesFile),
      GeneratedFileSpec(["SwiftSyntax", "Documentation.docc", "generated", "SwiftSyntax.md"], swiftSyntaxDoccIndex),

      // SwiftSyntaxBuilder
      GeneratedFileSpec(swiftSyntaxBuilderGeneratedDir + ["BuildableNodes.swift"], buildableNodesFile),
      GeneratedFileSpec(swiftSyntaxBuilderGeneratedDir + ["ResultBuilders.swift"], resultBuildersFile),
      GeneratedFileSpec(
        swiftSyntaxBuilderGeneratedDir + ["SyntaxExpressibleByStringInterpolationConformances.swift"],
        syntaxExpressibleByStringInterpolationConformancesFile
      ),
      GeneratedFileSpec(
        swiftSyntaxBuilderGeneratedDir + ["RenamedChildrenBuilderCompatibility.swift"],
        renamedChildrenBuilderCompatibilityFile
      ),
    ]
    // This split of letters produces files for the syntax nodes that have about equal size, which improves compile time

    fileSpecs += ["AB", "C", "D", "EF", "GHI", "JKLMN", "OP", "QRS", "TUVWXYZ"].flatMap {
      (letters: String) -> [GeneratedFileSpec] in
      [
        GeneratedFileSpec(
          swiftSyntaxGeneratedDir + ["syntaxNodes", "SyntaxNodes\(letters).swift"],
          syntaxNode(nodesStartingWith: Array(letters))
        ),
        GeneratedFileSpec(
          swiftSyntaxGeneratedDir + ["raw", "RawSyntaxNodes\(letters).swift"],
          rawSyntaxNodesFile(nodesStartingWith: Array(letters))
        ),
      ]
    }

    let modules = Set(fileSpecs.compactMap { $0.pathComponents.first })

    var previouslyGeneratedFiles = Set(
      modules.flatMap { (module) -> [URL] in
        let generatedDir =
          destination
          .appendingPathComponent(module)
          .appendingPathComponent("generated")
        return FileManager.default
          .enumerator(at: generatedDir, includingPropertiesForKeys: nil)!
          .compactMap { $0 as? URL }
          .filter { !$0.hasDirectoryPath }
          .map { $0.resolvingSymlinksInPath() }
      }
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
