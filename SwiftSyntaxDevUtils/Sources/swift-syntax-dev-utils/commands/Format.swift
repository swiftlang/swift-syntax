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

/// Directories that should not be formatted.
fileprivate let directoriesToExclude = [
  "lit_tests",
  "generated",
  "build",
  "Inputs",
  ".build",
  ".swift-format-build",
]

struct Format: ParsableCommand {
  static let configuration = CommandConfiguration(
    abstract: "Format files in SwiftSyntax using swift-format.",
    discussion: """
      This command automatically builds the '\(FormatExecutor.swiftFormatBranch)' branch \
      of swift-format in the '\(Paths.swiftFormatBuildDir.lastPathComponent)' \
      directory of this repository and uses the build to format the swift-syntax \
      sources.
      """
  )

  @Flag(help: "Update the sources of swift-format and rebuild swift-format")
  var update: Bool = false

  @Flag(
    help: """
      Instead of formatting in-place, verify that the files are correctly formatted. \
      Exit with 1 if files are not correctly formatted.
      """
  )
  var lint: Bool = false

  @Option(
    help: """
      Instead of building a local swift-format, use this swift-format executable. \
      Should primarily be used for CI, which has already built swift-format.
      """
  )
  var swiftFormat: String? = nil

  @Flag(help: "Enable verbose logging.")
  var verbose: Bool = false

  func run() throws {
    let executor = FormatExecutor(
      update: update,
      lint: lint,
      swiftFormat: swiftFormat,
      verbose: verbose
    )
    try executor.run()
  }
}

struct FormatExecutor {
  private enum Error: Swift.Error, CustomStringConvertible {
    case swiftFormatNotFound
    case lintFailed

    var description: String {
      switch self {
      case .swiftFormatNotFound:
        return "The locally built swift-format could not be found"
      case .lintFailed:
        return """
          The swift-syntax repo is not formatted according to the style guides.

          Run the following command to format swift-syntax

            ./swift-syntax-dev-utils format

          If the issue persists, try updating swift-format by running

            ./swift-syntax-dev-utils format --update

          Should that still fail, fix any remaining issues manually and verify they match the swift-format style using

            ./swift-syntax-dev-utils format --lint
          """
      }
    }
  }

  /// Update the sources of swift-format and rebuild swift-format
  private let update: Bool

  /// Instead of formatting in-place, verify that the files are correctly formatted.
  ///
  /// Exit with 1 if files are not correctly formatted.
  private let lint: Bool

  /// Instead of building a local swift-format, use this swift-format executable.
  ///
  /// Should primarily be used for CI, which has already built swift-format.
  private let swiftFormat: String?

  /// Enable verbose logging.
  private let verbose: Bool

  /// The branch of swift-format to build.
  static let swiftFormatBranch: String = "main"

  /// The configuration to build swift-format in.
  private static let swiftFormatBuildConfiguration: String = "release"

  /// Creates an Executor
  /// - Parameters:
  ///   - update: Update the sources of swift-format and rebuild swift-format
  ///   - lint: Instead of formatting in-place, verify that the files are correctly formatted.
  ///   - swiftFormat: Instead of building a local swift-format, use this swift-format executable.
  ///   - verbose: Enable verbose logging.
  init(
    update: Bool,
    lint: Bool = false,
    swiftFormat: String? = nil,
    verbose: Bool = false
  ) {
    self.update = update
    self.lint = lint
    self.swiftFormat = swiftFormat
    self.verbose = verbose
  }

  /// Run `git` in the .swift-format-build directory with the provided arguments.
  private func runGitCommand(_ arguments: String...) throws {
    try ProcessRunner(
      executableURL: Paths.gitExec,
      arguments: ["-C", Paths.swiftFormatBuildDir.path] + arguments
    ).run(
      captureStdout: false,
      captureStderr: false,
      verbose: verbose
    )
  }

  /// Run `swift` for the `.swift-format-build` package with the provided arguments.
  private func runSwiftCommand(_ action: String, _ arguments: String...) throws {
    try ProcessRunner(
      executableURL: Paths.swiftExec,
      arguments: [action, "--package-path", Paths.swiftFormatBuildDir.path] + arguments
    ).run(
      captureStdout: false,
      captureStderr: false,
      verbose: verbose
    )
  }

  /// Ensure that we have an up-to-date checkout of swift-format in `.swift-format-build`.
  private func cloneOrUpdateSwiftFormat() throws {
    if FileManager.default.fileExists(atPath: Paths.swiftFormatBuildDir.appendingPathComponent(".git").path) {
      try runGitCommand("checkout", Self.swiftFormatBranch)
      try runGitCommand("pull")
    } else {
      try FileManager.default.createDirectory(atPath: Paths.swiftFormatBuildDir.path, withIntermediateDirectories: true)
      try runGitCommand("clone", "https://github.com/swiftlang/swift-format.git", ".")
      try runGitCommand("checkout", Self.swiftFormatBranch)
    }
    try runSwiftCommand("package", "update")
  }

  /// Build the swift-format executable.
  private func buildSwiftFormat() throws {
    try runSwiftCommand("build", "--product", "swift-format", "--configuration", Self.swiftFormatBuildConfiguration)
  }

  /// Get the URL of the locally-built swift-format executable.
  private func findSwiftFormatExecutable() throws -> URL {
    if let swiftFormat = swiftFormat {
      return URL(fileURLWithPath: swiftFormat)
    }

    // We could run `swift build --show-bin-path` here but that takes 0.4s.
    // Since the path seems really stable, let’s build the path ourselves.
    let swiftFormatExec = URL(fileURLWithPath: Paths.swiftFormatBuildDir.path)
      .appendingPathComponent(".build")
      .appendingPathComponent(Self.swiftFormatBuildConfiguration)
      .appendingPathComponent("swift-format")
    if !swiftFormatExec.isExecutableFile {
      throw Error.swiftFormatNotFound
    }
    return swiftFormatExec
  }

  /// Get the list of files that should be formatted using swift-format.
  ///
  /// This excludes some files like generated files or test inputs.
  private func filesToFormat() -> [URL] {
    guard
      let enumerator = FileManager.default.enumerator(
        at: Paths.packageDir.resolvingSymlinksInPath(),
        includingPropertiesForKeys: [],
        options: []
      )
    else {
      return []
    }

    var result: [URL] = []
    for case let url as URL in enumerator {
      if directoriesToExclude.contains(url.lastPathComponent) {
        enumerator.skipDescendants()
      }
      if url.pathExtension == "swift" {
        result.append(url)
      }
    }

    return result
  }

  /// Format all files in the repo using the locally-built swift-format.
  private func formatFilesInRepo() throws {
    let swiftFormatExecutable = try findSwiftFormatExecutable()

    let filesToFormat = self.filesToFormat()

    try ProcessRunner(
      executableURL: swiftFormatExecutable,
      arguments: [
        "format",
        "--in-place",
        "--parallel",
      ] + filesToFormat.map { $0.path }
    )
    .run(
      captureStdout: false,
      captureStderr: false,
      verbose: verbose
    )
  }

  /// Lint all files in the repo using the locally-built swift-format.
  private func lintFilesInRepo() throws {
    let swiftFormatExecutable = try findSwiftFormatExecutable()

    let filesToFormat = self.filesToFormat()

    do {
      try ProcessRunner(
        executableURL: swiftFormatExecutable,
        arguments: [
          "lint",
          "--strict",
          "--parallel",
        ] + filesToFormat.map { $0.path }
      )
      .run(
        captureStdout: false,
        captureStderr: false,
        verbose: verbose
      )
    } catch is NonZeroExitCodeError {
      throw Error.lintFailed
    }
  }

  func run() throws {
    #if compiler(<5.10)
    print(
      "💡 You are building running the format script with Swift 5.9 or lower. Running it with SwiftPM 5.10 is about 10s faster."
    )
    #endif

    try run(updateAndBuild: update)
  }

  /// - Parameter updateAndBuild: Whether to update the locally checked out
  ///   swift-format sources and rebuild swift-format.
  private func run(updateAndBuild: Bool) throws {
    if updateAndBuild {
      try cloneOrUpdateSwiftFormat()
      try buildSwiftFormat()
    }
    do {
      if lint {
        try lintFilesInRepo()
      } else {
        try formatFilesInRepo()
      }
    } catch Error.swiftFormatNotFound {
      if !updateAndBuild {
        print(
          """
          No build of swift-format was found in '\(Paths.swiftFormatBuildDir.lastPathComponent)'.
          Building swift-format now. This may take a couple of minutes.
          Future invocations of this command will re-use the build and are much faster.

          """
        )

        // If swift-format cannot be found, try again, updating (aka cloning + building) swift-format this time
        try run(updateAndBuild: true)
      } else {
        throw Error.swiftFormatNotFound
      }
    }
  }
}
