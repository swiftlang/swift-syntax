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

/// Executes body with a URL to a temporary directory that will be deleted after
/// the closure finishes executing.
func withTemporaryDirectory<T>(_ body: (URL) throws -> T) throws -> T {
  let tempDirURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
  try FileManager.default.createDirectory(at: tempDirURL, withIntermediateDirectories: true)
  defer {
    try? FileManager.default.removeItem(at: tempDirURL)
  }
  return try body(tempDirURL)
}

/// Infer the default toolchain using `xcrun`.
///
/// Returns `nil` on all platforms except for macOS.
func defaultToolchain() -> URL? {
  #if os(macOS)
  do {
    let swiftcPath = try ProcessRunner(executableURL: try Paths.xcrunExec, arguments: ["--find", "swiftc"])
      .run(verbose: false)
      .stdout
      .trimmingCharacters(in: .whitespacesAndNewlines)
    if swiftcPath.isEmpty {
      return nil
    }
    return URL(fileURLWithPath: swiftcPath).deletingLastPathComponent().deletingLastPathComponent()
  } catch {
    return nil
  }
  #else
  // Toolchain lookup not implemented without xcrun yet
  return nil
  #endif
}
