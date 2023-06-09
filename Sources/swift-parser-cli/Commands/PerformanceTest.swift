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

import _InstructionCounter
import ArgumentParser
import Foundation
import SwiftParser

struct PerformanceTest: ParsableCommand {
  static var configuration = CommandConfiguration(
    commandName: "performance-test",
    abstract:
      "Parse all .swift files in '--directory' and its subdirectories '--iteration' times and output the average time (in milliseconds) one iteration took."
  )

  @Option(help: "The directory in which all .swift files should be parsed")
  var directory: String

  @Option(help: "How many times should the directory be parsed?")
  var iterations: Int

  func run() throws {
    let sourceDir = URL(fileURLWithPath: self.directory)

    let files = try FileManager.default
      .enumerator(at: sourceDir, includingPropertiesForKeys: nil)!
      .compactMap({ $0 as? URL })
      .filter { $0.pathExtension == "swift" }
      .map { try Data(contentsOf: $0) }

    let start = Date()
    let startInstructions = getInstructionsExecuted()
    for _ in 0..<self.iterations {
      for file in files {
        file.withUnsafeBytes { buf in
          _ = Parser.parse(source: buf.bindMemory(to: UInt8.self))
        }
      }
    }
    let endInstructions = getInstructionsExecuted()
    let endDate = Date()

    print("Time:         \(endDate.timeIntervalSince(start) / Double(self.iterations) * 1000)ms")
    if endInstructions != startInstructions {
      // endInstructions == startInstructions only happens if we are on non-macOS
      // platforms that don't support `getInstructionsExecuted`. Don't display anything.
      print("Instructions: \(Double(endInstructions - startInstructions) / Double(self.iterations))")
    }
  }
}
