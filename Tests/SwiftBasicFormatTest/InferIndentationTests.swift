//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftBasicFormat
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest

fileprivate func assertIndentation(
  of sourceFile: SourceFileSyntax,
  _ expected: Trivia?,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  let inferred = BasicFormat.inferIndentation(of: sourceFile)
  XCTAssertEqual(inferred, expected, file: file, line: line)
}

final class InferIndentationTests: XCTestCase {
  func testTwoSpaceIndentation() {
    assertIndentation(
      of: """
        class Foo {
          func bar() {
            print("hello world")
          }
        }
        """,
      .spaces(2)
    )
  }

  func testTwoSpaceIndentationWithMultipleFourSpaceLines() {
    assertIndentation(
      of: """
        class Foo {
          func bar() {
            print("hello world")
            print("test")
            print("another")
          }
        }
        """,
      .spaces(2)
    )
  }

  func testTabIndentation() {
    assertIndentation(
      of: """
        class Foo {
        \tfunc bar() {
        \tprint("hello world")
        \t}
        }
        """,
      .tabs(1)
    )
  }

  func testUseLineCommentsForInference() {
    assertIndentation(
      of: """
        class Foo {
          /// Some doc comment
          /// And another
          func bar() {
          }
        }
        """,
      .spaces(2)
    )
  }

  func testBlockCommentContentsDontCountForInference() {
    assertIndentation(
      of: """
        class Foo {
          /*
           * Test abc 
           */
          func bar() {}
        }
        """,
      nil
    )
  }

  func testWithBlockComment() {
    assertIndentation(
      of: """
        class Foo {
          /*
           * Test abc 
           */
          func bar() {
            print("test")
          }
        }
        """,
      .spaces(2)
    )
  }

  func testDontGetConfusedBySingleIncorrectIndentation() {
    assertIndentation(
      of: """
        class Foo {
            func bar() {
                print("1")
                print("2")
                print("3")
                print("4")
                print("5")
                print("6")
                print("7")
                print("8")
                print("9")
              print("10")
            }
        }
        """,
      .spaces(4)
    )
  }

  func testMixedTwoAndFourSpaceIndentation() {
    assertIndentation(
      of: """
        class Foo {
            func bar() {
                print("1")
                print("2")
                print("3")
                print("4")
                print("5")
              print("6")
              print("7")
              print("8")
              print("9")
              print("10")
            }
        }
        """,
      .spaces(2)
    )
  }

  func testMixedSpaceAndTabIndentation() {
    assertIndentation(
      of: """
        class Foo {
          func bar() {
              print("1")
              print("2")
              print("3")
              print("4")
              print("5")
        \t\tprint("6")
        \t\tprint("7")
        \t\tprint("8")
        \t\tprint("9")
        \t\tprint("10")
        \t}
        }
        """,
      nil
    )
  }

  func testMultilineStringLiteralWithInternalIndentation() {
    assertIndentation(
      of: #"""
        class Foo {
          func bar() {
            print("""
            To Do:
             - Ignore string literals
             - Infer indentation
            """)
          }
        }
        """#,
      .spaces(2)
    )
  }
}
