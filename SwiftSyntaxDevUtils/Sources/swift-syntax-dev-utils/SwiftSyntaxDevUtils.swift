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

@main
struct SwiftSyntaxDevUtils: ParsableCommand {

  static var configuration: CommandConfiguration = CommandConfiguration(
    abstract: """
      Build and test script for SwiftSyntax.

      The build script can also drive the test suite included in the SwiftSyntax
      repo. This requires a custom build of the compiler project since it accesses
      test utilities that are not shipped as part of the toolchains. See the Testing
      section for arguments that need to be specified for this.
      """,
    subcommands: [
      Build.self,
      GenerateSourceCode.self,
      Test.self,
      VerifySourceCode.self,
    ]
  )
}
