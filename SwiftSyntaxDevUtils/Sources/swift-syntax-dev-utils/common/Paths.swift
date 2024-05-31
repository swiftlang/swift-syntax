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
    URL(fileURLWithPath: #filePath)
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

  static var diffExec: URL {
    get throws {
      return try lookupExecutable(for: "diff")
    }
  }

  static var gitExec: URL {
    get throws {
      try lookupExecutable(for: "git")
    }
  }

  static var swiftExec: URL {
    get throws {
      try lookupExecutable(for: "swift")
    }
  }

  /// The directory in which swift-format should be built.
  static var swiftFormatBuildDir: URL {
    packageDir
      .appendingPathComponent(".swift-format-build")
  }

  static var xcodebuildExec: URL {
    get throws {
      return try lookupExecutable(for: "xcodebuild")
    }
  }

  static var xcrunExec: URL {
    get throws {
      return try lookupExecutable(for: "xcrun")
    }
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

  enum ExecutableLookupError: Error, CustomStringConvertible {
    case notFound(executableName: String)

    var description: String {
      switch self {
      case .notFound(executableName: let executableName):
        return "Executable \(executableName) not found in PATH"
      }
    }
  }

  private static func lookupExecutable(for filename: String) throws -> URL {
    let executable = envSearchPaths.map { $0.appendingPathComponent(filename) }
      .first(where: { $0.isExecutableFile })
    guard let executable else {
      throw ExecutableLookupError.notFound(executableName: filename)
    }
    return executable
  }
}

extension URL {
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
