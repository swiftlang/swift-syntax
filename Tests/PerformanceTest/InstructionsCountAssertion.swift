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

import XCTest
import _InstructionCounter

fileprivate var baselineURL: URL {
  if let baselineFile = ProcessInfo.processInfo.environment["BASELINE_FILE"] {
    return URL(fileURLWithPath: baselineFile)
  } else {
    return URL(fileURLWithPath: #file)
      .deletingLastPathComponent()
      .appendingPathComponent("baselines.json")
  }
}

func measureInstructions(_ baselineName: StaticString = #function, block: () -> Void, file: StaticString = #file, line: UInt = #line) throws {
  let startInstructions = getInstructionsExecuted()
  block()
  let endInstructions = getInstructionsExecuted()
  let numberOfInstructions = endInstructions - startInstructions
  let strippedBaselineName = "\(baselineName)".replacingOccurrences(of: "()", with: "")

  // Performance testing is only supported on macOS.
  // On all other platforms `getInstructionsExecuted` returns 0.
  #if os(macOS)
  // If the is no data, we just continue the test
  guard let data = try? Data(contentsOf: baselineURL) else {
    return
  }

  let jsonDecoder = JSONDecoder()
  let baselineMap = try jsonDecoder.decode([String: UInt64].self, from: data)

  guard let baseline = baselineMap[strippedBaselineName] else {
    XCTFail(
      """
      Missing baseline for \(strippedBaselineName)
      with number of instructions '\(numberOfInstructions)'
      """,
      file: file,
      line: line
    )
    return
  }

  let relativeDeviation = Double(numberOfInstructions) / Double(baseline) - 1
  let allowedDeviation = 0.01

  XCTAssertTrue(
    (-allowedDeviation..<allowedDeviation).contains(relativeDeviation),
    """
    Number of instructions '\(numberOfInstructions)' deviated from baseline by \(String(format: "%.4f", relativeDeviation * 100))%.
    The maximum allowed deviation for '\(strippedBaselineName)' is \(allowedDeviation * 100)% in either direction.
    """,
    file: file,
    line: line
  )
  #endif
}
