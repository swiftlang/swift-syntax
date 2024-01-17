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
import Foundation

struct SourceCodeGeneratorArguments: ParsableArguments {
  @Option(
    name: .customLong("toolchain"),
    help: "The path to the toolchain that shall be used to build SwiftSyntax.",
    transform: URL.init(fileURLWithPath:)
  )
  var _toolchain: URL? = defaultToolchain()

  var toolchain: URL {
    get throws {
      guard let toolchain = self._toolchain else {
        throw ScriptExectutionError(message: "Toolchain could not be inferred. Specify toolchain using --toolchain")
      }
      return toolchain
    }
  }

  @Flag(help: "Enable verbose logging.")
  var verbose: Bool = false
}
