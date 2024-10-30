//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftBasicFormat
import SwiftParser
import SwiftSyntax
@_spi(Testing) import SwiftSyntaxBuilder
import XCTest
import _SwiftSyntaxTestSupport

fileprivate func assertIndented(
  by indentation: Trivia = .tab,
  indentFirstLine: Bool = true,
  source: String,
  expected: String,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  assertStringsEqualWithDiff(
    Parser.parse(source: source).indented(by: indentation, indentFirstLine: indentFirstLine).description,
    expected,
    file: file,
    line: line
  )
}

final class IndentTests: XCTestCase {
  func testNotIndented() {
    assertIndented(
      source: """
        func foo() {
          let bar = 2
        }
        """,
      expected: """
        \tfunc foo() {
        \t  let bar = 2
        \t}
        """
    )
  }

  func testSingleLineComments() {
    assertIndented(
      source: """
        func foo() {
          // This is a comment
          // that extends onto
          // multiple lines \\
          let bar = 2
          // and another one
        }
        """,
      expected: """
        \tfunc foo() {
        \t  // This is a comment
        \t  // that extends onto
        \t  // multiple lines \\
        \t  let bar = 2
        \t  // and another one
        \t}
        """
    )
  }

  func testMultiLineComments() {
    assertIndented(
      source: """
        func foo() {
          /* This is a multiline comment
                that extends onto
        multiple lines*/
          let bar = 2
          /* on a single line */
          let another = "Hello, world!" /* on a single line */
        }
        """,
      expected: """
        \tfunc foo() {
        \t  /* This is a multiline comment
        \t        that extends onto
        \tmultiple lines*/
        \t  let bar = 2
        \t  /* on a single line */
        \t  let another = "Hello, world!" /* on a single line */
        \t}
        """
    )
  }

  func testMultiLineString() {
    assertIndented(
      source: #"""
        func foo() {
          let page = """
            <h1>Hello, world!</h1>
            <p>This is my web site</p>
            """
        }
        """#,
      expected: #"""
        \#tfunc foo() {
        \#t  let page = """
        \#t    <h1>Hello, world!</h1>
        \#t    <p>This is my web site</p>
        \#t    """
        \#t}
        """#
    )
  }

  func testIndented() {
    assertIndented(
      source: """
          func foo() {
            let bar = 2
          }
        """,
      expected: """
        \t  func foo() {
        \t    let bar = 2
        \t  }
        """
    )
    assertIndented(
      source: """
        \tfunc foo() {
        \t  let bar = 2
        \t}
        """,
      expected: """
        \t\tfunc foo() {
        \t\t  let bar = 2
        \t\t}
        """
    )
  }

  func testIndentBySpaces() {
    assertIndented(
      by: .spaces(4),
      source: """
        func foo() {
          let bar = 2
        }
        """,
      expected: """
            func foo() {
              let bar = 2
            }
        """
    )
  }

  func testSkipFirstLine() {
    assertIndented(
      indentFirstLine: false,
      source: """
        \nfunc foo() {
          let bar = 2
        }
        """,
      expected: """
        \n\tfunc foo() {
        \t  let bar = 2
        \t}
        """
    )
    assertIndented(
      indentFirstLine: false,
      source: """
        func foo() {
          let bar = 2
        }
        """,
      expected: """
        func foo() {
        \t  let bar = 2
        \t}
        """
    )
  }
}
