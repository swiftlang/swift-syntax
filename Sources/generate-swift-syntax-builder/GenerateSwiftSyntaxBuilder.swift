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

/// SwiftSyntaxBuilder sources to be generated
private let sourceTemplates: [(SourceFile, String)] = [
  (buildableBaseProtocolsFile, "BuildableBaseProtocols.swift"),
  (buildableCollectionNodesFile, "BuildableCollectionNodes.swift"),
  (buildableNodesFile, "BuildableNodes.swift"),
  (expressibleAsProtocolsFile, "ExpressibleAsProtocols.swift"),
  (formatFile, "Format.swift"),
  (tokenFile, "Token.swift"),
]

@main
struct GenerateSwiftSyntaxBuilder: ParsableCommand {
  @Argument(help: "The path to the destination directory where the source files are to be generated")
  var generatedPath: String

  func run() throws {
    let generatedURL = URL(fileURLWithPath: generatedPath)
    let format = Format(indentWidth: 2)

    try FileManager.default.createDirectory(
      atPath: generatedURL.path,
      withIntermediateDirectories: true,
      attributes: nil
    )

    for (sourceFile, name) in sourceTemplates {
      let fileURL = generatedURL.appendingPathComponent(name)
      let syntax = sourceFile.buildSyntax(format: format)
      try "\(syntax)\n".write(to: fileURL, atomically: true, encoding: .utf8)
    }
  }
}
