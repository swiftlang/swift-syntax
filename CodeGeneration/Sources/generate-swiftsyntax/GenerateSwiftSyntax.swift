//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
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

private let swiftBasicFormatDir: String = "SwiftBasicFormat"
private let ideUtilsDir: String = "IDEUtils"
private let swiftParserDir: String = "SwiftParser"
private let swiftSyntaxDir: String = "SwiftSyntax"
private let swiftSyntaxBuilderDir: String = "SwiftSyntaxBuilder"

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
    let templates: [TemplateSpec] = [
      // SwiftBasicFormat
      TemplateSpec(sourceFile: basicFormatFile, module: swiftBasicFormatDir, filename: "BasicFormat.swift"),

      // IDEUtils
      TemplateSpec(sourceFile: syntaxClassificationFile, module: ideUtilsDir, filename: "SyntaxClassification.swift"),

      // SwiftParser
      TemplateSpec(sourceFile: declarationModifierFile, module: swiftParserDir, filename: "DeclarationModifier.swift"),
      TemplateSpec(sourceFile: parserEntryFile, module: swiftParserDir, filename: "Parser+Entry.swift"),
      TemplateSpec(sourceFile: typeAttributeFile, module: swiftParserDir, filename: "TypeAttribute.swift"),

      // SwiftSyntax
      TemplateSpec(sourceFile: keywordFile, module: swiftSyntaxDir, filename: "Keyword.swift"),
      TemplateSpec(sourceFile: miscFile, module: swiftSyntaxDir, filename: "Misc.swift"),
      TemplateSpec(sourceFile: syntaxAnyVisitorFile, module: swiftSyntaxDir, filename: "SyntaxAnyVisitor.swift"),
      TemplateSpec(sourceFile: syntaxBaseNodesFile, module: swiftSyntaxDir, filename: "SyntaxBaseNodes.swift"),
      TemplateSpec(sourceFile: syntaxCollectionsFile, module: swiftSyntaxDir, filename: "SyntaxCollections.swift"),
      TemplateSpec(sourceFile: syntaxEnumFile, module: swiftSyntaxDir, filename: "SyntaxEnum.swift"),
      TemplateSpec(sourceFile: syntaxKindFile, module: swiftSyntaxDir, filename: "SyntaxKind.swift"),
      TemplateSpec(sourceFile: syntaxRewriterFile, module: swiftSyntaxDir, filename: "SyntaxRewriter.swift"),
      TemplateSpec(sourceFile: syntaxTraitsFile, module: swiftSyntaxDir, filename: "SyntaxTraits.swift"),
      TemplateSpec(sourceFile: syntaxTransformFile, module: swiftSyntaxDir, filename: "SyntaxTransform.swift"),
      TemplateSpec(sourceFile: syntaxVisitorFile, module: swiftSyntaxDir, filename: "SyntaxVisitor.swift"),
      TemplateSpec(sourceFile: tokenKindFile, module: swiftSyntaxDir, filename: "TokenKind.swift"),
      TemplateSpec(sourceFile: tokensFile, module: swiftSyntaxDir, filename: "Tokens.swift"),

      // SwiftSyntaxBuilder
      TemplateSpec(sourceFile: buildableCollectionNodesFile, module: swiftSyntaxBuilderDir, filename: "BuildableCollectionNodes.swift"),
      TemplateSpec(sourceFile: buildableNodesFile, module: swiftSyntaxBuilderDir, filename: "BuildableNodes.swift"),
      TemplateSpec(sourceFile: resultBuildersFile, module: swiftSyntaxBuilderDir, filename: "ResultBuilders.swift"),
      TemplateSpec(sourceFile: syntaxExpressibleByStringInterpolationConformancesFile, module: swiftSyntaxBuilderDir, filename: "SyntaxExpressibleByStringInterpolationConformances.swift"),
    ]

    let modules = Set(templates.map(\.module))

    let previouslyGeneratedFilesLock = NSLock()
    var previouslyGeneratedFiles = Set(modules.flatMap { (module) -> [URL] in
      let generatedDir = URL(fileURLWithPath: destination)
        .appendingPathComponent(module)
        .appendingPathComponent("generated")
      return FileManager.default
        .enumerator(at: generatedDir, includingPropertiesForKeys: nil)!
        .compactMap { $0 as? URL}
        .filter { $0.pathExtension == "swift" }
    })

    var errors: [Error] = []
    DispatchQueue.concurrentPerform(iterations: templates.count) { index in
      let template = templates[index]
      do {
        let destination = URL(fileURLWithPath: destination)
          .appendingPathComponent(template.module)
          .appendingPathComponent("generated")
          .appendingPathComponent(template.filename)
        previouslyGeneratedFilesLock.withLock {
          _ = previouslyGeneratedFiles.remove(destination)
        }
        try generateTemplate(
          sourceFile: template.sourceFile,
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

  private func generateTemplate(
    sourceFile: SourceFileSyntax,
    destination: URL,
    verbose: Bool) throws {
      try FileManager.default.createDirectory(
        atPath: destination.deletingLastPathComponent().path,
        withIntermediateDirectories: true,
        attributes: nil
      )

      if verbose {
        print("Generating \(destination.path)...")
      }
      let syntax = sourceFile.formatted(using: CodeGenerationFormat())
      try "\(syntax)\n".write(to: destination, atomically: true, encoding: .utf8)
    }
}
