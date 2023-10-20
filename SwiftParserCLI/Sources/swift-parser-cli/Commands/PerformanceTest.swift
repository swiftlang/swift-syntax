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
import InstructionCounter
import SwiftParser
import SwiftSyntax

struct PerformanceTest: ParsableCommand {
  static var configuration = CommandConfiguration(
    commandName: "performance-test",
    abstract:
      "Parse all .swift files in '--directory' and its subdirectories '--iteration' times and output the average time (in milliseconds) one iteration took."
  )

  @Flag(name: .long, help: "Parse files incrementally")
  var incrementalParse: Bool = false

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

    var fileTransition: [Data: IncrementalParseTransition] = [:]

    if self.incrementalParse {
      /// The initial parse for incremental parsing
      for file in files {
        file.withUnsafeBytes { buf in
          let parseResult = Parser.parseIncrementally(
            source: buf.bindMemory(to: UInt8.self),
            parseTransition: nil
          )

          fileTransition[file] = IncrementalParseTransition(
            previousIncrementalParseResult: parseResult,
            edits: ConcurrentEdits(fromSequential: [])
          )
        }
      }
    }

    let start = Date()
    let startInstructions = getInstructionsExecuted()
    for _ in 0..<self.iterations {
      for file in files {
        file.withUnsafeBytes { buf in
          _ = Parser.parseIncrementally(
            source: buf.bindMemory(to: UInt8.self),
            parseTransition: fileTransition[file]
          )
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
