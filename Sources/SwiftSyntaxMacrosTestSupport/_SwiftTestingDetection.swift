//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation

enum _SwiftTestingDetection {
  private static let _lock = NSLock()
  
  // 'nonisolated(unsafe)' is required for Swift 6 strict concurrency checks 
  // since we are manually synchronizing access via NSLock.
  nonisolated(unsafe) private static var _executed = false
  
  static func runOnce(file: StaticString, line: UInt) {
    _lock.lock()
    defer { _lock.unlock() }
    
    // Ensure the detection logic and warning only run once per process.
    if _executed { return }
    _executed = true

    let env = ProcessInfo.processInfo.environment

    // Allow users to explicitly silence this warning via environment variable.
    if env["SWIFTSYNTAX_TESTSUPPORT_SILENCE"] == "1" {
      return
    }
    
    // Safety check: If we are inside a legitimate XCTest environment, 
    // do not show the warning.
    let xctestEnvKeys = [
      "XCTestConfigurationFilePath",
      "XCTestBundlePath",
      "XCTestSessionIdentifier",
    ]
    if xctestEnvKeys.contains(where: { env[$0] != nil }) {
      return
    }
    
    // Detect Swift Testing via environment variables or command line arguments.
    let hasSwiftTestingEnv = env.keys.contains { $0.hasPrefix("SWIFT_TESTING_") }
    let hasSwiftTestingArg = CommandLine.arguments.contains("--swift-testing")
    let likelySwiftTesting = hasSwiftTestingEnv || hasSwiftTestingArg

    guard likelySwiftTesting else {
      return
    }

    // Strict mode: Treat the warning as a hard failure.
    let strict = env["SWIFTSYNTAX_TESTSUPPORT_STRICT"] == "1"

    let banner = """
    \n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    SwiftSyntaxMacrosTestSupport is XCTest-based and appears to be invoked under Swift Testing.
    This can cause silent failures and false positives (see #3190).
    Until full Swift Testing support lands (see #2720), use XCTest or Testing-compatible helpers.
    Controls: SWIFTSYNTAX_TESTSUPPORT_SILENCE=1 (silence), SWIFTSYNTAX_TESTSUPPORT_STRICT=1 (trap)
    Location: \(file):\(line)
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n
    """

    if strict {
      preconditionFailure("SwiftSyntaxMacrosTestSupport used under Swift Testing. See #3190, #2720.")
    } else {
      if let data = banner.data(using: .utf8) {
        // Use standard write(_:) for broad compatibility across macOS/Linux versions.
        FileHandle.standardError.write(data)
      }
    }
  }
}