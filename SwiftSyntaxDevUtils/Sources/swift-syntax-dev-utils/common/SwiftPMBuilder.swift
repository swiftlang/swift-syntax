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

import Foundation

/// Wrapper around `swift build` and `swift test` to build and test SwiftPM packages.
struct SwiftPMBuilder {
  /// The path to the toolchain that shall be used to build SwiftSyntax.
  let toolchain: URL

  /// The directory in which build products shall be put.
  ///
  /// If omitted a directory named ".build" will be put in the swift-syntax directory.
  let buildDir: URL?

  /// Path to an Xcode workspace to create a unified build of SwiftSyntax with other projects.
  let multirootDataFile: URL?

  /// Build in release mode.
  let release: Bool

  /// When constructing RawSyntax nodes validate that their layout matches that
  /// defined in `CodeGeneration` and that TokenSyntax nodes have a `tokenKind`
  /// matching the ones specified in `CodeGeneration`.
  let enableRawSyntaxValidation: Bool

  /// For each `assertParse` test, perform mutations of the test case based on
  /// alternate token choices that the parser checks, validating that there are
  /// no round-trip or assertion failures.
  let enableTestFuzzing: Bool

  /// A flag indicating whether to use local dependencies during the build process.
  let useLocalDeps: Bool

  /// Enable verbose logging.
  let verbose: Bool

  init(
    toolchain: URL,
    buildDir: URL? = nil,
    multirootDataFile: URL? = nil,
    release: Bool = false,
    enableRawSyntaxValidation: Bool = false,
    enableTestFuzzing: Bool = false,
    useLocalDeps: Bool = true,
    verbose: Bool = false
  ) {
    self.toolchain = toolchain
    self.buildDir = buildDir
    self.multirootDataFile = multirootDataFile
    self.release = release
    self.enableRawSyntaxValidation = enableRawSyntaxValidation
    self.enableTestFuzzing = enableTestFuzzing
    self.useLocalDeps = useLocalDeps
    self.verbose = verbose
  }

  func buildTarget(packageDir: URL, targetName: String, warningsAsErrors: Bool = false) throws {
    logSection("Building target " + targetName)
    try build(packageDir: packageDir, name: targetName, isProduct: false)
  }

  @discardableResult
  func invokeSwiftPM(
    action: String,
    packageDir: URL,
    warningsAsErrors: Bool = false,
    additionalArguments: [String],
    additionalEnvironment: [String: String],
    captureStdout: Bool = true,
    captureStderr: Bool = true
  ) throws -> ProcessResult {
    var args = [action]
    if action == "test" {
      args += ["--disable-testable-imports"]
    }
    args += ["--package-path", packageDir.path]

    if let buildDir = buildDir?.path {
      args += ["--scratch-path", buildDir]
    }

    if warningsAsErrors {
      args += ["-Xswiftc", "-warnings-as-errors"]
    }

    if release {
      args += ["--configuration", "release"]
    }

    if let multirootDataFile = multirootDataFile?.path {
      args += ["--multiroot-data-file", multirootDataFile]
    }

    if verbose {
      args += ["--verbose"]
    }

    args += additionalArguments

    let processRunner = ProcessRunner(
      executableURL: toolchain.appendingPathComponent("bin").appendingPathComponent("swift"),
      arguments: args,
      additionalEnvironment: additionalEnvironment
    )

    let result = try processRunner.run(
      captureStdout: captureStdout,
      captureStderr: captureStderr,
      verbose: verbose
    )

    return result
  }

  /// Environment variables that should be set when invoking `swift build` or
  /// `swift test`.
  var swiftPMEnvironmentVariables: [String: String] {
    var additionalEnvironment: [String: String] = [:]
    additionalEnvironment["SWIFT_BUILD_SCRIPT_ENVIRONMENT"] = "1"

    if enableRawSyntaxValidation {
      additionalEnvironment["SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION"] = "1"
    }

    if enableTestFuzzing {
      additionalEnvironment["SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION"] = "1"
    }

    if useLocalDeps {
      // Tell other projects in the unified build to use local dependencies
      additionalEnvironment["SWIFTCI_USE_LOCAL_DEPS"] = "1"
    }

    return additionalEnvironment
  }

  private func build(packageDir: URL, name: String, isProduct: Bool, warningsAsErrors: Bool = false) throws {
    let args: [String]

    if isProduct {
      args = ["--product", name]
    } else {
      args = ["--target", name]
    }

    try invokeSwiftPM(
      action: "build",
      packageDir: packageDir,
      warningsAsErrors: warningsAsErrors,
      additionalArguments: args,
      additionalEnvironment: swiftPMEnvironmentVariables,
      captureStdout: false,
      captureStderr: false
    )
  }
}
