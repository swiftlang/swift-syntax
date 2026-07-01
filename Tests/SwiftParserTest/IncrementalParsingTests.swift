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

import SwiftParser
@_spi(RawSyntax) import SwiftSyntax
import XCTest
import _SwiftSyntaxTestSupport

class IncrementalParsingTests: ParserTestCase {

  public func testBrokenMemberFunction() {
    assertIncrementalParse(
      """
      struct A⏩️⏸️A⏪️ { func f() {
      """,
      reusedNodes: [
        ReusedNodeSpec("func f() {", kind: .memberBlockItem)
      ]
    )
  }

  public func testReusedNode() {
    assertIncrementalParse(
      """
      struct A⏩️⏸️A⏪️ {}
      struct B {}
      """,
      reusedNodes: [
        ReusedNodeSpec("struct B {}", kind: .codeBlockItem)
      ]
    )
  }

  public func testAddElse() {
    assertIncrementalParse(
      """
      #if false
        ⏩️⏸️#else⏪️
      """
    )
  }

  public func testInsertSpace() {
    assertIncrementalParse(
      """
      class AnimationType {
        func foo(x: Blah) {
          switch x {
          case (.

      extension AnimationType {
        public⏩️⏸️ ⏪️
      """
    )
  }

  public func testAddFuncParens() {
    assertIncrementalParse(
      """
      class InvalidFuncDecls {
        func parensAdded⏩️⏸️()⏪️ {
        }
      }
      """
    )
  }

  public func testAddOpeningBrace() {
    assertIncrementalParse(
      """
      class InvalidFuncDecls {
        func openingBraceAdded() ⏩️⏸️{⏪️
      }
      """
    )
  }

  public func testAddClosingBrace() {
    assertIncrementalParse(
      """
      class InvalidFuncDecls {
        func closingBraceAdded() {

        ⏩️⏸️}⏪️
      }
      """
    )
  }

  public func testRemoveFuncKeyword() {
    assertIncrementalParse(
      """
      class InvalidFuncDecls {
        ⏩️func⏸️⏪️ funcKeywordRemoved() {
        
        }
      }
      """
    )
  }

  public func testAddParamName() {
    assertIncrementalParse(
      """
      class InvalidFuncDecls {
        func addingParamName(⏩️⏸️arg⏪️) {
        
        }
      }
      """
    )
  }

  public func testAddParamColon() {
    assertIncrementalParse(
      """
      class InvalidFuncDecls {
        func addingParamColon(arg⏩️⏸️:⏪️) {
        }
      }
      """
    )
  }

  public func testAddingParamType() {
    assertIncrementalParse(
      """
      class InvalidFuncDecls {
        func addingParamType(arg:⏩️⏸️ String⏪️) {
        }
      }
      """
    )
  }

  public func testInsertTextIdentifier() {
    assertIncrementalParse(
      """
      self = ⏩️⏸️_                            _⏪️foo(1)[object1, object2] + bar(1)
      """
    )
  }

  public func testNestedInitializers() {
    assertIncrementalParse(
      """
      class NestedInitializers {
        ⏩️⏸️init() {⏪️
          init() {

          }
        ⏩️⏸️}⏪️
      }
      """
    )
  }

  public func testMultiEditMapping() {
    assertIncrementalParse(
      """
      let one: Int;let two: Int; let three: Int; ⏩️⏸️                      ⏪️⏩️⏸️   ⏪️let found: Int;let five: Int;
      """,
      reusedNodes: [
        ReusedNodeSpec("let one: Int;", kind: .codeBlockItem),
        ReusedNodeSpec("let two: Int;", kind: .codeBlockItem),
        ReusedNodeSpec("let five: Int;", kind: .codeBlockItem),
      ]
    )
  }

  public func testAddProperty() {
    assertIncrementalParse(
      """
      struct Foo {
        let a: Int
        let b: Int
        let c: Int
        let d: String
        ⏩️⏸️let e_newProp: String⏪️
        let f: Int
        let g: Int
      }
      """,
      reusedNodes: [
        ReusedNodeSpec("let a: Int", kind: .memberBlockItem),
        ReusedNodeSpec("let b: Int", kind: .memberBlockItem),
        ReusedNodeSpec("let c: Int", kind: .memberBlockItem),
        ReusedNodeSpec("let g: Int", kind: .memberBlockItem),
      ]
    )
  }

  public func testWarpInClass() {
    assertIncrementalParse(
      """
      ⏩️⏸️class Foo {⏪️
        func foo1() {
          print("Hello Foo!")
        }

        func foo2() {
          print("Hello again")
        }
      """,
      reusedNodes: [
        ReusedNodeSpec(
          """
          print("Hello Foo!")
          """,
          kind: .codeBlockItem
        ),
        ReusedNodeSpec(
          """
          print("Hello again")
          """,
          kind: .codeBlockItem
        ),
      ]
    )
  }

  public func testUnwarpClass() {
    assertIncrementalParse(
      """
      ⏩️class Bar {⏸️⏪️
        func bar1() {
          let pi = 3.1415
          print("Pi is (approximately) \\(pi)")
        }

        func bar2() {
          print("I can compute Pi as well:")
          bar1()
        }
      }
      """,
      reusedNodes: [
        ReusedNodeSpec(
          """
          let pi = 3.1415
          """,
          kind: .codeBlockItem
        ),
        ReusedNodeSpec(
          """
          print("Pi is (approximately) \\(pi)")
          """,
          kind: .codeBlockItem
        ),
        ReusedNodeSpec(
          """
          print("I can compute Pi as well:")
          """,
          kind: .codeBlockItem
        ),
        ReusedNodeSpec(
          """
          bar1()
          """,
          kind: .codeBlockItem
        ),
      ]
    )
  }

  public func testNextTokenCalculation() {
    assertIncrementalParse(
      """
          let a = "hello"
          let c = "⏩️ ⏸️⏪️world"
      """,
      reusedNodes: [
        ReusedNodeSpec("let a = \"hello\"", kind: .codeBlockItem)
      ]
    )
  }

  public func testReplace() {
    assertIncrementalParse(
      """
      func foo() {
      }

      _ = ⏩️6⏸️7⏪️
      """,
      reusedNodes: [
        ReusedNodeSpec(
          """
          func foo() {
          }
          """,
          kind: .codeBlockItem
        )
      ]
    )
  }

  public func testReplaceByLonger() {
    assertIncrementalParse(
      """
      _ = ⏩️6⏸️"Hello World"⏪️
      """
    )
  }

  public func testReplaceByShorter() {
    assertIncrementalParse(
      """
      _ = ⏩️"Hello again"⏸️"a"⏪️
      """
    )
  }

  public func testInsert() {
    assertIncrementalParse(
      """
      ⏩️⏸️foo()⏪️
      """
    )
  }

  public func testRemove() {
    assertIncrementalParse(
      """
      ⏩️print("abc")⏸️⏪️
      """
    )
  }

  public func testAttachToPrevNode() {
    assertIncrementalParse(
      """
      foo()
      ⏩️⏸️{}⏪️
      _ = 1
      """
    )
  }

  public func testClassSurrounding() {
    assertIncrementalParse(
      """
      ⏩️⏸️class C {⏪️
        func method1() {}
      """
    )
  }

  public func testMultiEdit() {
    assertIncrementalParse(
      """
      ⏩️⏸️class C {⏪️
        func method1() {}
      ⏩️⏸️}⏪️
      """
    )
  }

  public func testMultiEditSameLine() {
    assertIncrementalParse(
      """
      ⏩️_⏸️let x⏪️ = ⏩️1⏸️"hi"⏪️
      """
    )
  }

  public func testReplaceWithMultiByteChar() {
    assertIncrementalParse(
      """
      let x = "⏩️a⏸️👨‍👩‍👧‍👦⏪️"
      """
    )
  }

  public func testReplaceMultiByteCharWithShorter() {
    assertIncrementalParse(
      """
      let x = "⏩️👨‍👩‍👧‍👦⏸️🎉⏪️"
      """
    )
  }

  public func testLastCharOfStruct() {
    assertIncrementalParse(
      """
      private struc⏩️⏸️t⏪️ MyStruct {
      }
      """
    )
  }

  public func testAddArrayCloseBracket() {
    assertIncrementalParse(
      """
      var computedVar: [Int] {
        return [1
        ⏩️⏸️]⏪️
      }
      """
    )
  }

  public func testAddIfOpenBrace() {
    assertIncrementalParse(
      """
      if true ⏩️⏸️{⏪️
        _ = 5
      }
      """
    )
  }

  public func testExtendIdentifier() {
    assertIncrementalParse(
      """
      let y⏩️⏸️ou⏪️ = 42
      """
    )
  }

  public func testTrailingClosure() {
    assertIncrementalParse(
      """
      foo() {}
      trailingClosure: ⏩️switch x {
        default: break
      }⏸️{}⏪️
      """
    )
  }

  public func testMultiFunctionCall() {
    assertIncrementalParse(
      """
      foo() {}
      foo1() {}
      foo2() {}
      ⏩️⏸️foo3() {}⏪️
      """,
      reusedNodes: [
        ReusedNodeSpec("foo() {}", kind: .codeBlockItem),
        ReusedNodeSpec("foo1() {}", kind: .codeBlockItem),
      ]
    )
  }

  public func testDeclFollowedByLabeledStmt() {
    assertIncrementalParse(
      """
      class foo {}
      trailingClosure: ⏩️switch x {
        default: break
      }⏸️{}⏪️
      """,
      reusedNodes: [
        ReusedNodeSpec("class foo {}", kind: .codeBlockItem)
      ]
    )
  }

  // MARK: - Arena compaction

  /// A source file of `count` distinct top-level functions. Editing one function
  /// reuses the others from earlier arenas, so editing distinct functions in
  /// turn accumulates retained arenas.
  private func manyFunctions(_ count: Int) -> String {
    return (0..<count).map { "func f\($0)() -> Int { return \($0) }\n" }.joined()
  }

  /// Insert `text` at the start of `needle` in `source`, returning the new
  /// source and the corresponding edit.
  private func insert(
    _ text: String,
    before needle: String,
    in source: String
  ) -> (newSource: String, edit: SourceEdit) {
    let range = source.range(of: needle)!
    let offset = source.utf8.distance(from: source.utf8.startIndex, to: range.lowerBound.samePosition(in: source.utf8)!)
    var utf8 = Array(source.utf8)
    utf8.insert(contentsOf: Array(text.utf8), at: offset)
    let edit = SourceEdit(
      range: AbsolutePosition(utf8Offset: offset)..<AbsolutePosition(utf8Offset: offset),
      replacement: text
    )
    return (String(decoding: utf8, as: UTF8.self), edit)
  }

  /// Edits distinct functions in turn and returns the peak retained arena count
  /// observed across the edit sequence. Asserts every intermediate tree
  /// round-trips.
  private func peakRetainedArenas(functionCount: Int, edits: Int, compactArenaThreshold: Int?) throws -> Int {
    var source = manyFunctions(functionCount)
    var result = Parser.parseIncrementally(source: source, parseTransition: nil)
    var peak = result.tree.raw.arena.retainedArenaCount
    for i in 0..<edits {
      let (newSource, edit) = insert("  ", before: "return \(i % functionCount) ", in: source)
      let transition = IncrementalParseTransition(
        previousIncrementalParseResult: result,
        edits: try ConcurrentEdits(concurrent: [edit]),
        compactArenaThreshold: compactArenaThreshold
      )
      result = Parser.parseIncrementally(source: newSource, parseTransition: transition)
      XCTAssertEqual(result.tree.description, newSource, "tree did not round-trip after edit \(i)")
      peak = max(peak, result.tree.raw.arena.retainedArenaCount)
      source = newSource
    }
    return peak
  }

  /// With compaction disabled, editing distinct functions accumulates arenas
  /// well beyond a small bound — this validates that the compaction test below
  /// is actually exercising arena accumulation.
  public func testArenaCountAccumulatesWithoutCompaction() throws {
    let peak = try peakRetainedArenas(functionCount: 16, edits: 16, compactArenaThreshold: nil)
    // Each edit reuses the other functions from earlier arenas, so the retained
    // count grows by roughly one per edit (peak here is near `1 + edits` ≈ 17).
    // This is only a control asserting that accumulation happens at all, so use
    // a loose lower bound: comfortably above the compaction-bounded regime (the
    // test below caps at 4) yet well under the true peak, so it stays robust to
    // small variations in how nodes are pinned across arenas.
    XCTAssertGreaterThan(peak, 8, "expected arenas to accumulate without compaction")
  }

  /// With a low threshold, compaction keeps the retained arena count bounded by
  /// the threshold across a long edit sequence, while every tree still
  /// round-trips.
  public func testArenaCompactionBoundsRetainedArenaCount() throws {
    let threshold = 4
    let peak = try peakRetainedArenas(functionCount: 16, edits: 32, compactArenaThreshold: threshold)
    XCTAssertLessThanOrEqual(peak, threshold, "compaction should keep retained arenas at or below the threshold")
  }

  /// A tree produced by a compaction (full reparse) can still be used as the
  /// basis for a subsequent incremental parse that reuses nodes.
  public func testIncrementalParseAfterCompaction() throws {
    let source = manyFunctions(16)
    var result = Parser.parseIncrementally(source: source, parseTransition: nil)

    // Force a compaction on the next parse with threshold 1 (any incremental
    // parse's previous tree retains >= 1 arena, so `previous + 1 > 1` always
    // holds and forces a compaction).
    let (afterFirst, edit1) = insert("  ", before: "return 0 ", in: source)
    result = Parser.parseIncrementally(
      source: afterFirst,
      parseTransition: IncrementalParseTransition(
        previousIncrementalParseResult: result,
        edits: try ConcurrentEdits(concurrent: [edit1]),
        compactArenaThreshold: 1
      )
    )
    XCTAssertEqual(result.tree.raw.arena.retainedArenaCount, 1, "compaction should collapse to a single arena")
    XCTAssertEqual(result.tree.description, afterFirst)

    // The compacted tree drives a normal incremental parse that reuses nodes.
    var reusedCodeBlockItems = 0
    let (afterSecond, edit2) = insert("  ", before: "return 5 ", in: afterFirst)
    let result2 = Parser.parseIncrementally(
      source: afterSecond,
      parseTransition: IncrementalParseTransition(
        previousIncrementalParseResult: result,
        edits: try ConcurrentEdits(concurrent: [edit2]),
        reusedNodeCallback: { node in
          if node.kind == .codeBlockItem { reusedCodeBlockItems += 1 }
        },
        compactArenaThreshold: nil
      )
    )
    XCTAssertEqual(result2.tree.description, afterSecond)
    XCTAssertGreaterThan(reusedCodeBlockItems, 0, "incremental parse after compaction should reuse nodes")
  }
}
