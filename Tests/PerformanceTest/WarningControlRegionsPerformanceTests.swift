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

import SwiftIfConfig
import SwiftParser
import SwiftSyntax
import SwiftWarningControl
import XCTest
import _InstructionCounter
import _SwiftSyntaxTestSupport

/// Linear inheritance chain: g0 -> g1 -> g2 -> ... -> gN.
/// Exercises the BFS but the queue never exceeds 1 element (each level has 1 sub-group).
private func makeChain(depth: Int) -> DiagnosticGroupInheritanceTree {
  var subGroups: [DiagnosticGroupIdentifier: [DiagnosticGroupIdentifier]] = [:]
  for i in 0..<depth {
    subGroups[DiagnosticGroupIdentifier("g\(i)")] = [DiagnosticGroupIdentifier("g\(i + 1)")]
  }
  return try! DiagnosticGroupInheritanceTree(subGroups: subGroups)
}

/// Wide-and-shallow tree: one root with N direct sub-groups.
/// Exercises `Array.removeFirst()` shift cost on a large queue.
private func makeFan(width: Int) -> DiagnosticGroupInheritanceTree {
  var children: [DiagnosticGroupIdentifier] = []
  for i in 0..<width {
    children.append(DiagnosticGroupIdentifier("g\(i)"))
  }
  return try! DiagnosticGroupInheritanceTree(
    subGroups: [DiagnosticGroupIdentifier("root"): children]
  )
}

/// Diamond DAG: each level has 2 nodes; both point to both nodes at the next level.
/// Exercises de-duplication. Without de-dup at dequeue, the queue grows as 2^depth,
/// so even small depths blow up.
private func makeDiamondDAG(depth: Int) -> DiagnosticGroupInheritanceTree {
  var subGroups: [DiagnosticGroupIdentifier: [DiagnosticGroupIdentifier]] = [:]
  func id(_ level: Int, _ side: Int) -> DiagnosticGroupIdentifier {
    DiagnosticGroupIdentifier("l\(level)s\(side)")
  }
  for level in 0..<depth - 1 {
    subGroups[id(level, 0)] = [id(level + 1, 0), id(level + 1, 1)]
    subGroups[id(level, 1)] = [id(level + 1, 0), id(level + 1, 1)]
  }
  return try! DiagnosticGroupInheritanceTree(subGroups: subGroups)
}

final class WarningControlRegionsPerformanceTests: XCTestCase {

  /// Calls the public entry point with `globalControls` so we exercise
  /// `addWarningGroupControls` (which contains the BFS of interest).
  private func buildTree(seed: String, inheritance: DiagnosticGroupInheritanceTree) {
    let parsed = Parser.parse(source: "")
    _ = parsed.warningGroupControlRegionTree(
      configuredRegions: .empty,
      globalControls: [(DiagnosticGroupIdentifier(seed), .error)],
      groupInheritanceTree: inheritance
    )
  }

  private func runAndReport(
    label: String,
    inheritance: DiagnosticGroupInheritanceTree,
    seed: String,
    iterations: Int
  ) {
    for _ in 0..<3 {
      buildTree(seed: seed, inheritance: inheritance)
    }

    let startInstructions = getInstructionsExecuted()
    let t0 = Date()
    for _ in 0..<iterations {
      buildTree(seed: seed, inheritance: inheritance)
    }
    let wall = Date().timeIntervalSince(t0)
    let endInstructions = getInstructionsExecuted()
    let instructions = endInstructions - startInstructions

    print(
      "[BENCH] \(label) iters=\(iterations) wall=\(String(format: "%.3f", wall * 1000))ms "
        + "instructions=\(instructions) per-call=\(instructions / UInt64(iterations))"
    )
  }

  func testWarningControlChainBenchmark() throws {
    try XCTSkipIf(longTestsDisabled)
    print("--- chain (linear inheritance; queue stays tiny so this is mostly a baseline) ---")
    for depth in [50, 200, 800] {
      let inh = makeChain(depth: depth)
      runAndReport(label: "chain depth=\(depth)", inheritance: inh, seed: "g0", iterations: 20)
    }
  }

  func testWarningControlFanBenchmark() throws {
    try XCTSkipIf(longTestsDisabled)
    print("--- fan (root has N direct sub-groups; exercises removeFirst() shift cost) ---")
    for width in [50, 200, 800, 1600] {
      let inh = makeFan(width: width)
      runAndReport(label: "fan width=\(width)", inheritance: inh, seed: "root", iterations: 20)
    }
  }

  func testWarningControlDiamondBenchmark() throws {
    try XCTSkipIf(longTestsDisabled)
    // Note: keep depths small. Without the de-dup fix the queue grows as 2^depth so
    // even depth 10 takes too long for a unit-test run.
    print("--- diamond DAG (each level has 2 nodes pointing to both of next level) ---")
    for depth in [4, 6, 8] {
      let inh = makeDiamondDAG(depth: depth)
      runAndReport(label: "diamond depth=\(depth)", inheritance: inh, seed: "l0s0", iterations: 10)
    }
  }
}
