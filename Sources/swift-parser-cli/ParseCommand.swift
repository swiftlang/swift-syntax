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

struct ParseArguments: ParsableArguments {
  @Argument(help: "The source file that should be parsed; if omitted, use stdin")
  var sourceFile: String?

  @Option(name: [.long, .short], help: "If passed, parse this source text instead of reading source file")
  var source: String?

  @Flag(name: .long, help: "Perform sequence folding with the standard operators")
  var foldSequences: Bool = false
}

/// A command  that has arguments to parse source code
protocol ParseCommand {
  var arguments: ParseArguments { get }
}

extension ParseCommand {
  /// The name of the source file that can can be displayed to users
  ///
  /// This is not necessarily a file path if the file contents are read from
  /// stdin or the command line arguments.
  var sourceFileName: String {
    return arguments.sourceFile ?? "stdin"
  }

  /// The contents of the source that should be parsed in UTF-8 bytes.
  var sourceFileContents: [UInt8] {
    get throws {
      if let source = arguments.source {
        return Array(source.utf8)
      }

      return try getContentsOfSourceFile(at: arguments.sourceFile)
    }
  }

  /// Whether sequence folding using standard operators should be performed
  var foldSequences: Bool { arguments.foldSequences }
}
