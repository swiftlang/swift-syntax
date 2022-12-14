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
import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder
import Utils

private let swiftBasicFormatDir: String = "SwiftBasicFormat"
private let IDEUtilsDir: String = "IDEUtils"
private let swiftParserDir: String = "SwiftParser"
private let swiftSyntaxDir: String = "SwiftSyntax"
private let swiftSyntaxBuilderDir: String = "SwiftSyntaxBuilder"

@main
struct GenerateSwiftSyntax: ParsableCommand {
  @Argument(help: "The path to the source directory where the source files are to be generated")
  var generatedPath: String

  @Flag(help: "Enable verbose output")
  var verbose: Bool = false
    
  func run() throws {
    let templates: [(sourceFile: SourceFileSyntax, module: String, filename: String)] = [
      (basicFormatFile, swiftBasicFormatDir, "BasicFormat.swift"),
      (syntaxClassificationFile, IDEUtilsDir, "SyntaxClassification.swift"),
      (declarationAttributeFile, swiftParserDir, "DeclarationAttribute.swift"),
      (declarationModifierFile, swiftParserDir, "DeclarationModifier.swift"),
      (parserEntryFile, swiftParserDir, "Parser+Entry.swift"),
      (typeAttributeFile, swiftParserDir, "TypeAttribute.swift"),
      (miscFile, swiftSyntaxDir, "Misc.swift"),
      (syntaxBaseNodesFile, swiftSyntaxDir, "SyntaxBaseNodes.swift"),
      (syntaxBaseNodesFile, swiftSyntaxDir, "SyntaxBaseNodes.swift"),
      (syntaxEnumFile, swiftSyntaxDir, "SyntaxEnum.swift"),
      (syntaxKindFile, swiftSyntaxDir, "SyntaxKind.swift"),
      (buildableCollectionNodesFile, swiftSyntaxBuilderDir, "BuildableCollectionNodes.swift"),
      (buildableNodesFile, swiftSyntaxBuilderDir, "BuildableNodes.swift"),
      (resultBuildersFile, swiftSyntaxBuilderDir, "ResultBuilders.swift"),
      (syntaxExpressibleByStringInterpolationConformancesFile, swiftSyntaxBuilderDir, "SyntaxExpressibleByStringInterpolationConformances.swift"),
      (tokenFile, swiftSyntaxBuilderDir, "Token.swift"),
      (typealiasesFile, swiftSyntaxBuilderDir, "Typealiases.swift"),
    ]
    
    for template in templates {
      try generateTemplate(
        sourceFile: template.sourceFile,
        module: template.module,
        filename: template.filename,
        destination: URL(fileURLWithPath: generatedPath),
        verbose: verbose)
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
