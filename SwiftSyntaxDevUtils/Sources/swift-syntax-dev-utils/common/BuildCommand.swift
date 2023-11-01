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

protocol BuildCommand {
  var arguments: BuildArguments { get }
}

extension BuildCommand {
  func buildProduct(productName: String) throws {
    logSection("Building product " + productName)
    try build(packageDir: Paths.packageDir, name: productName, isProduct: true)
  }

  func buildTarget(packageDir: URL, targetName: String) throws {
    logSection("Building target " + targetName)
    try build(packageDir: packageDir, name: targetName, isProduct: false)
  }

  @discardableResult
  func invokeSwiftPM(
    action: String,
    packageDir: URL,
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

    if let buildDir = arguments.buildDir?.path {
      args += ["--scratch-path", buildDir]
    }

    if self.arguments.warningsAsErrors {
      args += ["-Xswiftc", "-warnings-as-errors"]
    }

    #if !canImport(Darwin)
    args += ["--enable-test-discovery"]
    #endif

    if arguments.release {
      args += ["--configuration", "release"]
    }

    if let multirootDataFile = arguments.multirootDataFile?.path {
      args += ["--multiroot-data-file", multirootDataFile]
    }

    if arguments.verbose {
      args += ["--verbose"]
    }

    args += additionalArguments

    let processRunner = ProcessRunner(
      executableURL: arguments.toolchain.appendingPathComponent("bin").appendingPathComponent("swift"),
      arguments: args,
      additionalEnvironment: additionalEnvironment
    )

    let result = try processRunner.run(
      captureStdout: captureStdout,
      captureStderr: captureStderr,
      verbose: arguments.verbose
    )

    return result
  }

  @discardableResult
  func invokeXcodeBuild(projectPath: URL, scheme: String) throws -> ProcessResult {
    return try withTemporaryDirectory { tempDir in
      let processRunner = ProcessRunner(
        executableURL: try Paths.xcodebuildExec,
        arguments: [
          "-project", projectPath.path,
          "-scheme", scheme,
          "-derivedDataPath", tempDir.path,
        ],
        additionalEnvironment: [:]
      )

      let result = try processRunner.run(verbose: arguments.verbose)

      return result
    }
  }

  /// Environment variables that should be set when invoking `swift build` or
  /// `swift test`.
  var swiftPMEnvironmentVariables: [String: String] {
    var additionalEnvironment: [String: String] = [:]
    additionalEnvironment["SWIFT_BUILD_SCRIPT_ENVIRONMENT"] = "1"

    if arguments.enableRawSyntaxValidation {
      additionalEnvironment["SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION"] = "1"
    }

    if arguments.enableTestFuzzing {
      additionalEnvironment["SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION"] = "1"
    }

    // Tell other projects in the unified build to use local dependencies
    additionalEnvironment["SWIFTCI_USE_LOCAL_DEPS"] = "1"

    return additionalEnvironment
  }

  private func build(packageDir: URL, name: String, isProduct: Bool) throws {
    let args: [String]

    if isProduct {
      args = ["--product", name]
    } else {
      args = ["--target", name]
    }

    try invokeSwiftPM(
      action: "build",
      packageDir: packageDir,
      additionalArguments: args,
      additionalEnvironment: swiftPMEnvironmentVariables,
      captureStdout: false,
      captureStderr: false
    )
  }
}
