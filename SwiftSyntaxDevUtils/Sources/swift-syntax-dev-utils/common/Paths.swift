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

enum Paths {
  static var packageDir: URL {
    URL(fileURLWithPath: #file)
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .deletingLastPathComponent()
  }

  static var sourcesDir: URL {
    packageDir
      .appendingPathComponent("Sources")
  }

  static var examplesDir: URL {
    packageDir
      .appendingPathComponent("Examples")
  }

  static var swiftParserCliDir: URL {
    packageDir
      .appendingPathComponent("SwiftParserCLI")
  }

  static var codeGenerationDir: URL {
    packageDir
      .appendingPathComponent("CodeGeneration")
  }

  static var editorExtensionProjectPath: URL {
    packageDir
      .appendingPathComponent("EditorExtension")
      .appendingPathComponent("SwiftRefactorExtension.xcodeproj")
  }

  static var workspaceDir: URL {
    packageDir
      .deletingLastPathComponent()
  }

  static var llvmDir: URL {
    workspaceDir
      .appendingPathComponent("llvm-project")
      .appendingPathComponent("llvm")
  }

  static var litExec: URL {
    llvmDir
      .appendingPathComponent("utils")
      .appendingPathComponent("lit")
      .appendingPathComponent("lit.py")
  }

  static var python3Exec: URL? {
    return lookupExecutable(for: "python3")
  }

  static var diffExec: URL? {
    return lookupExecutable(for: "diff")
  }

  static var xcodebuildExec: URL? {
    return lookupExecutable(for: "xcodebuild")
  }

  private static var envSearchPaths: [URL] {
    // Compute search paths from PATH variable.
    #if os(Windows)
    let pathSeparator: Character = ";"
    #else
    let pathSeparator: Character = ":"
    #endif
    return (paths ?? "")
      .split(separator: pathSeparator)
      .map(String.init)
      .compactMap { pathString in
        return URL(fileURLWithPath: pathString)
      }
  }

  private static var paths: String? {
    #if os(Windows)
    let pathArg = "Path"
    #else
    let pathArg = "PATH"
    #endif

    return ProcessInfo.processInfo.environment[pathArg]
  }

  private static func lookupExecutable(for filename: String) -> URL? {
    return envSearchPaths.map { $0.appendingPathComponent(filename) }
      .first(where: { $0.isExecutableFile })
  }
}

fileprivate extension URL {
  var isExecutableFile: Bool {
    return (self.isFile(path) || self.isSymlink(path)) && FileManager.default.isExecutableFile(atPath: path)
  }

  private func isFile(_ path: String) -> Bool {
    let attrs = try? FileManager.default.attributesOfItem(atPath: path)
    return attrs?[.type] as? FileAttributeType == .typeRegular
  }

  private func isSymlink(_ path: String) -> Bool {
    let attrs = try? FileManager.default.attributesOfItem(atPath: path)
    return attrs?[.type] as? FileAttributeType == .typeSymbolicLink
  }
}
