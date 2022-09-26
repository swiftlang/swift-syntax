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
import SwiftSyntaxBuilder
import Utils

@main
struct GenerateSwiftSyntaxBuilder: ParsableCommand {
  @Argument(help: "The path to the destination directory where the source files are to be generated")
  var generatedPath: String

  @Flag(help: "Enable verbose output")
  var verbose: Bool = false

  func run() throws {
    try generateTemplates(
      templates: [
        (buildableBaseProtocolsFile, "BuildableBaseProtocols.swift"),
        (buildableCollectionNodesFile, "BuildableCollectionNodes.swift"),
        (buildableNodesFile, "BuildableNodes.swift"),
        (expressibleAsProtocolsFile, "ExpressibleAsProtocols.swift"),
        (tokenFile, "Token.swift"),
      ],
      destination: URL(fileURLWithPath: generatedPath),
      verbose: verbose
    )
  }
}
