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
import Utils

private let generatedDirName = "generated"

private let swiftBasicFormatGeneratedDir = ["SwiftBasicFormat", generatedDirName]
private let ideUtilsGeneratedDir = ["IDEUtils", generatedDirName]
private let swiftParserGeneratedDir = ["SwiftParser", generatedDirName]
private let swiftParserDiagnosticsGeneratedDir = ["SwiftParserDiagnostics", generatedDirName]
private let swiftSyntaxGeneratedDir = ["SwiftSyntax", generatedDirName]
private let swiftSyntaxBuilderGeneratedDir = ["SwiftSyntaxBuilder", generatedDirName]
private let BASE_KIND_FILES = [
  "Decl": "SyntaxDeclNodes.swift",
  "Expr": "SyntaxExprNodes.swift",
  "Pattern": "SyntaxPatternNodes.swift",
  "Stmt": "SyntaxStmtNodes.swift",
  "Syntax": "SyntaxNodes.swift",
  "Type": "SyntaxTypeNodes.swift",
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

  init(_ pathComponents: [String], _ contents: @escaping @autoclosure () -> SourceFileSyntax) {
    self.init(pathComponents, "\(contents().formatted(using: CodeGenerationFormat()))\n")
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
struct GenerateSwiftSyntax: ParsableCommand {
  @Argument(help: "The path to the source directory (i.e. 'swift-syntax/Sources') where the source files are to be generated")
  var destination: String

  @Flag(help: "Enable verbose output")
  var verbose: Bool = false

  func run() throws {
    let destination = URL(fileURLWithPath: self.destination).standardizedFileURL

    let fileSpecs: [GeneratedFileSpec] =
      [
        // SwiftBasicFormat
        GeneratedFileSpec(swiftBasicFormatGeneratedDir + ["BasicFormat+Extensions.swift"], basicFormatExtensionsFile),

        // IDEUtils
        GeneratedFileSpec(ideUtilsGeneratedDir + ["SyntaxClassification.swift"], syntaxClassificationFile),

        // SwiftParser
        GeneratedFileSpec(swiftParserGeneratedDir + ["DeclarationModifier.swift"], declarationModifierFile),
        GeneratedFileSpec(swiftParserGeneratedDir + ["IsLexerClassified.swift"], isLexerClassifiedFile),
        GeneratedFileSpec(swiftParserGeneratedDir + ["Parser+Entry.swift"], parserEntryFile),
        GeneratedFileSpec(swiftParserGeneratedDir + ["TokenSpecStaticMembers.swift"], tokenSpecStaticMembersFile),
        GeneratedFileSpec(swiftParserGeneratedDir + ["TypeAttribute.swift"], typeAttributeFile),

        // SwiftParserDiagnostics
        GeneratedFileSpec(swiftParserDiagnosticsGeneratedDir + ["ChildNameForDiagnostics.swift"], childNameForDiagnosticFile),
        GeneratedFileSpec(swiftParserDiagnosticsGeneratedDir + ["SyntaxKindNameForDiagnostics.swift"], syntaxKindNameForDiagnosticFile),
        GeneratedFileSpec(swiftParserDiagnosticsGeneratedDir + ["TokenNameForDiagnostics.swift"], tokenNameForDiagnosticFile),

        // SwiftSyntax
        GeneratedFileSpec(swiftSyntaxGeneratedDir + ["ChildNameForKeyPath.swift"], childNameForKeyPathFile),
        GeneratedFileSpec(swiftSyntaxGeneratedDir + ["Keyword.swift"], keywordFile),
        GeneratedFileSpec(swiftSyntaxGeneratedDir + ["raw", "RawSyntaxNodes.swift"], rawSyntaxNodesFile),
        GeneratedFileSpec(swiftSyntaxGeneratedDir + ["raw", "RawSyntaxValidation.swift"], rawSyntaxValidationFile),
        GeneratedFileSpec(swiftSyntaxGeneratedDir + ["SyntaxAnyVisitor.swift"], syntaxAnyVisitorFile),
        GeneratedFileSpec(swiftSyntaxGeneratedDir + ["SyntaxBaseNodes.swift"], syntaxBaseNodesFile),
        GeneratedFileSpec(swiftSyntaxGeneratedDir + ["SyntaxCollections.swift"], syntaxCollectionsFile),
        GeneratedFileSpec(swiftSyntaxGeneratedDir + ["SyntaxEnum.swift"], syntaxEnumFile),
        GeneratedFileSpec(swiftSyntaxGeneratedDir + ["SyntaxKind.swift"], syntaxKindFile),
        GeneratedFileSpec(swiftSyntaxGeneratedDir + ["SyntaxRewriter.swift"], syntaxRewriterFile),
        GeneratedFileSpec(swiftSyntaxGeneratedDir + ["SyntaxTraits.swift"], syntaxTraitsFile),
        GeneratedFileSpec(swiftSyntaxGeneratedDir + ["SyntaxTransform.swift"], syntaxTransformFile),
        GeneratedFileSpec(swiftSyntaxGeneratedDir + ["SyntaxVisitor.swift"], syntaxVisitorFile),
        GeneratedFileSpec(swiftSyntaxGeneratedDir + ["TokenKind.swift"], tokenKindFile),
        GeneratedFileSpec(swiftSyntaxGeneratedDir + ["Tokens.swift"], tokensFile),
        GeneratedFileSpec(swiftSyntaxGeneratedDir + ["TriviaPieces.swift"], triviaPiecesFile),

        // SwiftSyntaxBuilder
        GeneratedFileSpec(swiftSyntaxBuilderGeneratedDir + ["BuildableCollectionNodes.swift"], buildableCollectionNodesFile),
        GeneratedFileSpec(swiftSyntaxBuilderGeneratedDir + ["BuildableNodes.swift"], buildableNodesFile),
        GeneratedFileSpec(swiftSyntaxBuilderGeneratedDir + ["ResultBuilders.swift"], resultBuildersFile),
        GeneratedFileSpec(swiftSyntaxBuilderGeneratedDir + ["SyntaxExpressibleByStringInterpolationConformances.swift"], syntaxExpressibleByStringInterpolationConformancesFile),
      ]
      + BASE_KIND_FILES.map { baseKind in
        GeneratedFileSpec(swiftSyntaxGeneratedDir + ["syntaxNodes", baseKind.value], syntaxNode(emitKind: baseKind.key))
      } + [
        GeneratedFileSpec(["SwiftSyntax", "Documentation.docc", "generated", "SwiftSyntax.md"], swiftSyntaxDoccIndex)
      ]

    let modules = Set(fileSpecs.compactMap { $0.pathComponents.first })

    let previouslyGeneratedFilesLock = NSLock()
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

    var errors: [Error] = []
    DispatchQueue.concurrentPerform(iterations: fileSpecs.count) { index in
      let fileSpec = fileSpecs[index]
      do {
        var destination = destination
        for component in fileSpec.pathComponents {
          destination = destination.appendingPathComponent(component)
        }

        previouslyGeneratedFilesLock.lock();
        _ = previouslyGeneratedFiles.remove(destination)
        previouslyGeneratedFilesLock.unlock()

        try generateFile(
          contents: fileSpec.contents,
          destination: destination,
          verbose: verbose
        )
      } catch {
        errors.append(error)
      }
    }

    if let firstError = errors.first {
      // TODO: It would be nice if we could emit all errors
      throw firstError
    }

    for file in previouslyGeneratedFiles {
      // All files in `previouslyGeneratedFiles` that haven't been removed from
      // the set above no longer exist. Remove them.
      try FileManager.default.removeItem(at: file)
    }
  }

  private func generateFile(
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
}
