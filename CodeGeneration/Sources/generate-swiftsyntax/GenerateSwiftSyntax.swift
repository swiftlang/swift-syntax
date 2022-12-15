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
private let IDEUtilsDir: String = "IDEUtils"
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
  @Argument(help: "The path to the source directory where the source files are to be generated")
  var generatedPath: String

  @Flag(help: "Enable verbose output")
  var verbose: Bool = false
    
  func run() throws {
    let templates: [TemplateSpec] = [
      TemplateSpec(sourceFile: basicFormatFile, module: swiftBasicFormatDir, filename: "BasicFormat.swift"),
      TemplateSpec(sourceFile: syntaxClassificationFile, module: IDEUtilsDir, filename: "SyntaxClassification.swift"),
      TemplateSpec(sourceFile: declarationAttributeFile, module: swiftParserDir, filename: "DeclarationAttribute.swift"),
      TemplateSpec(sourceFile: declarationModifierFile, module: swiftParserDir, filename: "DeclarationModifier.swift"),
      TemplateSpec(sourceFile: parserEntryFile, module: swiftParserDir, filename: "Parser+Entry.swift"),
      TemplateSpec(sourceFile: typeAttributeFile, module: swiftParserDir, filename: "TypeAttribute.swift"),
      TemplateSpec(sourceFile: miscFile, module: swiftSyntaxDir, filename: "Misc.swift"),
      TemplateSpec(sourceFile: syntaxBaseNodesFile, module: swiftSyntaxDir, filename: "SyntaxBaseNodes.swift"),
      TemplateSpec(sourceFile: syntaxBaseNodesFile, module: swiftSyntaxDir, filename: "SyntaxBaseNodes.swift"),
      TemplateSpec(sourceFile: syntaxEnumFile, module: swiftSyntaxDir, filename: "SyntaxEnum.swift"),
      TemplateSpec(sourceFile: syntaxKindFile, module: swiftSyntaxDir, filename: "SyntaxKind.swift"),
      TemplateSpec(sourceFile: syntaxTraitsFile, module: swiftSyntaxDir, filename: "SyntaxTraits.swift"),
      TemplateSpec(sourceFile: buildableCollectionNodesFile, module: swiftSyntaxBuilderDir, filename: "BuildableCollectionNodes.swift"),
      TemplateSpec(sourceFile: buildableNodesFile, module: swiftSyntaxBuilderDir, filename: "BuildableNodes.swift"),
      TemplateSpec(sourceFile: resultBuildersFile, module: swiftSyntaxBuilderDir, filename: "ResultBuilders.swift"),
      TemplateSpec(sourceFile: syntaxExpressibleByStringInterpolationConformancesFile, module: swiftSyntaxBuilderDir, filename: "SyntaxExpressibleByStringInterpolationConformances.swift"),
      TemplateSpec(sourceFile: tokenFile, module: swiftSyntaxBuilderDir, filename: "Token.swift"),
      TemplateSpec(sourceFile: typealiasesFile, module: swiftSyntaxBuilderDir, filename: "Typealiases.swift"),
    ]

    var errors: [Error] = []
    DispatchQueue.concurrentPerform(iterations: templates.count) { index in
      let template = templates[index]
      do {
        try generateTemplate(
          sourceFile: template.sourceFile,
          module: template.module,
          filename: template.filename,
          destination: URL(fileURLWithPath: generatedPath),
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
  }
  
  private func generateTemplate(
    sourceFile: SourceFileSyntax,
    module: String,
    filename: String,
    destination: URL,
    verbose: Bool) throws {
      try FileManager.default.createDirectory(
        atPath: destination.path,
        withIntermediateDirectories: true,
        attributes: nil
      )
      
      let fileURL = destination
        .appendingPathComponent(module)
        .appendingPathComponent("generated")
        .appendingPathComponent(filename)
      
      if verbose {
        print("Generating \(fileURL.path)...")
      }
      let syntax = sourceFile.formatted(using: CodeGenerationFormat())
      try "\(syntax)\n".write(to: fileURL, atomically: true, encoding: .utf8)
    }
}
