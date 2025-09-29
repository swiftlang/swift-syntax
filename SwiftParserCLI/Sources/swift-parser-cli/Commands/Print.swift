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
import SwiftParser
import SwiftSyntax

struct Print: ParsableCommand, ParseCommand {
  static var configuration = CommandConfiguration(
    commandName: "print",
    abstract: "Print the parsed source file after applying any other arguments"
  )

  @OptionGroup
  var arguments: ParseArguments

  func run() throws {
    let (tree, _) = try parsedSourceFile(wantDiagnostics: false)
    print(tree.description)
  }
}
