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

struct GenerateSourceCode: ParsableCommand, SourceCodeGeneratorCommand {
  static var configuration: CommandConfiguration {
    return CommandConfiguration(
      abstract: "Generate swift-syntax sources."
    )
  }

  @OptionGroup
  var arguments: SourceCodeGeneratorArguments

  func run() throws {
    try self.runCodeGeneration(sourceDir: Paths.sourcesDir)
  }
}
