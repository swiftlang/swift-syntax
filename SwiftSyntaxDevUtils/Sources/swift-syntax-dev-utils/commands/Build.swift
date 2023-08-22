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

struct Build: ParsableCommand, BuildCommand {
  static var configuration: CommandConfiguration {
    return CommandConfiguration(
      abstract: "Build swift-syntax."
    )
  }

  @OptionGroup
  var arguments: BuildArguments

  func run() throws {
    try buildTarget(packageDir: Paths.packageDir, targetName: "SwiftSyntax-all")
    try buildTarget(packageDir: Paths.examplesDir, targetName: "Examples-all")
    try buildTarget(packageDir: Paths.swiftParserCliDir, targetName: "swift-parser-cli")
    try buildEditorExtension()
  }

  private func buildEditorExtension() throws {
    #if os(macOS)
    logSection("Building Editor Extension")
    try invokeXcodeBuild(projectPath: Paths.editorExtensionProjectPath, scheme: "SwiftRefactorExtension")
    #endif
  }
}
