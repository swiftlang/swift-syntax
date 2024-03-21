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
import SwiftSyntax
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
}
