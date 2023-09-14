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

struct BuildArguments: ParsableArguments {
  @Option(
    help: "The path to the toolchain that shall be used to build SwiftSyntax.",
    transform: URL.init(fileURLWithPath:)
  )
  var toolchain: URL

  @Option(
    help: """
      The directory in which build products shall be put. If omitted
      a directory named ".build" will be put in the swift-syntax
      directory.
      """,
    transform: URL.init(fileURLWithPath:)
  )
  var buildDir: URL?

  @Option(
    help: """
      Path to an Xcode workspace to create a unified build of SwiftSyntax with
      other projects.
      """,
    transform: URL.init(fileURLWithPath:)
  )
  var multirootDataFile: URL?

  @Flag(help: "Build in release mode.")
  var release: Bool = false

  @Flag(help: "Treat all warnings as errors.")
  var warningsAsErrors: Bool = false

  @Flag(help: "Enable verbose logging.")
  var verbose: Bool = false
}
