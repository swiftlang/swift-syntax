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

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder

/// SwiftSyntaxBuilder sources to be generated
let sourceTemplates = [
  (expressibleAsProtocolsFile, "ExpressibleAsProtocols.swift"),
  (tokensFile, "Tokens.swift"),
  (tokenSyntaxFile, "TokenSyntax.swift"),
]

guard CommandLine.arguments.count > 1 else {
    fatalError("Please add a destination as the first argument")
}

let destination = CommandLine.arguments[1]
let generatedPath = URL(fileURLWithPath: destination)

try FileManager.default.createDirectory(
  atPath: generatedPath.path,
  withIntermediateDirectories: true,
  attributes: nil
)

let format = Format(indentWidth: 2)

for (sourceFile, name) in sourceTemplates {
  let filePath = generatedPath.appendingPathComponent(name)
  let tokenSyntax = sourceFile.buildSyntax(format: format)
  try tokenSyntax.description.write(to: filePath, atomically: true, encoding: .utf8)
}

