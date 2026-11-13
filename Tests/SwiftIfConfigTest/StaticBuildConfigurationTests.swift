//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation
import SwiftIfConfig
import XCTest

public class StaticBuildConfigurationTests: XCTestCase {
  func testEncodingIsDeterministic() throws {
    // Enough elements that iterating a set in hash order is practically never sorted.
    let names = (0..<20).map { "name\($0)" }
    let buildConfig = StaticBuildConfiguration(
      customConditions: Set(names),
      features: Set(names),
      attributes: Set(names),
      targetOSs: Set(names),
      targetArchitectures: Set(names),
      targetEnvironments: Set(names),
      targetRuntimes: Set(names),
      targetPointerAuthenticationSchemes: Set(names),
      targetObjectFileFormats: Set(names),
      languageVersion: VersionTuple(6),
      compilerVersion: VersionTuple(6, 2)
    )

    let encoded = try JSONSerialization.jsonObject(with: JSONEncoder().encode(buildConfig)) as! [String: Any]
    for key in [
      "customConditions", "features", "attributes", "targetOSs", "targetArchitectures", "targetEnvironments",
      "targetRuntimes", "targetPointerAuthenticationSchemes", "targetObjectFileFormats",
    ] {
      XCTAssertEqual(encoded[key] as? [String], names.sorted(), key)
    }

    let decoded = try JSONDecoder().decode(StaticBuildConfiguration.self, from: JSONEncoder().encode(buildConfig))
    XCTAssertEqual(decoded.attributes, buildConfig.attributes)
    XCTAssertEqual(decoded.targetPointerBitWidth, buildConfig.targetPointerBitWidth)
    XCTAssertEqual(decoded.endianness, buildConfig.endianness)
    XCTAssertEqual(decoded.languageMode, buildConfig.languageMode)
    XCTAssertEqual(decoded.compilerVersion, buildConfig.compilerVersion)
  }
}
