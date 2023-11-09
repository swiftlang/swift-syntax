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

import SwiftBasicFormat
import SwiftParser
import SwiftSyntax
@_spi(Testing) import SwiftSyntaxBuilder
import XCTest
import _SwiftSyntaxTestSupport

fileprivate func assertFormatted<T: SyntaxProtocol>(
  tree: T,
  expected: String,
  using format: BasicFormat = BasicFormat(indentationWidth: .spaces(4)),
  file: StaticString = #file,
  line: UInt = #line
) {
  assertStringsEqualWithDiff(tree.formatted(using: format).description, expected, file: file, line: line)
}

fileprivate func assertFormatted(
  source: String,
  expected: String,
  using format: BasicFormat = BasicFormat(indentationWidth: .spaces(4)),
  file: StaticString = #file,
  line: UInt = #line
) {
  assertFormatted(
    tree: Parser.parse(source: source),
    expected: expected,
    using: format,
    file: file,
    line: line
  )
}

final class BasicFormatTest: XCTestCase {
  func testNotIndented() {
    assertFormatted(
      source: """
        func foo() {
        someFunc(a: 1,
        b: 1)
        }
        """,
      expected: """
        func foo() {
            someFunc(a: 1,
                b: 1)
        }
        """
    )
  }

  func testPartialIndent() {
    assertFormatted(
      source: """
        func foo() {
        someFunc(a: 1,
                 b: 1)
        }
        """,
      expected: """
        func foo() {
            someFunc(a: 1,
                     b: 1)
        }
        """
    )
  }

  func testPartialIndentNested() {
    assertFormatted(
      source: """
        func outer() {
        func inner() {
        someFunc(a: 1,
                 b: 1)
        }
        }
        """,
      expected: """
        func outer() {
            func inner() {
                someFunc(a: 1,
                         b: 1)
            }
        }
        """
    )
  }

  func testAlreadyIndented() {
    let source = """
      func foo() {
        someFunc(a: 1,
                 b: 1)
      }
      """

    assertFormatted(source: source, expected: source)
  }

  func testAlreadyIndentedWithComment() {
    let source = """
      func foo() {
        // ABC
        someFunc(a: 1,
                 b: 1)
      }
      """

    assertFormatted(source: source, expected: source)
  }

  func testAlreadyIndentedWithComment2() {
    assertFormatted(
      source: """
        func foo() {
        // ABC
          someFunc(a: 1,
                   b: 1)
        }
        """,
      expected: """
        func foo() {
            // ABC
              someFunc(a: 1,
                       b: 1)
        }
        """
    )
  }

  func testClosureIndentationArgBefore() {
    assertFormatted(
      source: """
        someFunc(arg2: 1,
            closure: { arg in indented() })
        """,
      expected: """
        someFunc(arg2: 1,
            closure: { arg in
                indented()
            })
        """
    )
  }

  func testClosureIndentationAfter() {
    assertFormatted(
      source: """
        someFunc(closure: { arg in indented() },
            arg2: 1)
        """,
      expected: """
        someFunc(closure: { arg in
                indented()
            },
            arg2: 1)
        """
    )
  }

  func testLineWrappingInsideIndentedBlock() {
    assertFormatted(
      source: """
        public init?(errorCode: Int) {
          guard errorCode > 0 else { return nil }
          self.code = errorCode
        }
        """,
      expected: """
        public init?(errorCode: Int) {
          guard errorCode > 0 else {
              return nil
          }
          self.code = errorCode
        }
        """
    )
  }

  func testSelfCall1() {
    assertFormatted(
      source: "self(0)",
      expected: "self(0)"
    )
  }

  func testSelfCall2() {
    assertFormatted(
      source: "Self(0)",
      expected: "Self(0)"
    )
  }

  func testSelfSubscript1() {
    assertFormatted(
      source: "self[0]",
      expected: "self[0]"
    )
  }

  func testSelfSubscript2() {
    assertFormatted(
      source: "Self[0]",
      expected: "Self[0]"
    )
  }

  func testCustomIndentationInBlockThatDoesntHaveNewline() {
    assertFormatted(
      source: """
        extension MyType {func buildSyntax(format: Format) -> Syntax {
          return Syntax(buildTest(format: format))
        }}
        """,
      expected: """
        extension MyType {
            func buildSyntax(format: Format) -> Syntax {
              return Syntax(buildTest(format: format))
            }
        }
        """
    )
  }

  func testStringInterpolationAtStartOfMultiLineStringLiteral() {
    assertFormatted(
      source: #"""
        class Foo {
        func test() {
            assertionFailure("""
              ABC
              \(myVar)
              """)
        }
        }
        """#,
      expected: #"""
        class Foo {
            func test() {
                assertionFailure("""
                  ABC
                  \(myVar)
                  """)
            }
        }
        """#
    )
  }

  func testMultilineStringLiteral() {
    assertFormatted(
      source: #"""
        assertionFailure("""
          First line
          Second line
          """)
        """#,
      expected: #"""
        assertionFailure("""
          First line
          Second line
          """)
        """#
    )
  }

  func testMultilineStringLiteralWithBlankLines() {
    let source = #"""
      assertionFailure("""

        First line

        Second line

        """)
      """#
    assertFormatted(source: source, expected: source)
  }

  func testMultilineStringLiteralWithFirstLineBlank() {
    let source = #"""
      assertionFailure("""

        """)
      """#
    assertFormatted(source: source, expected: source)
  }

  func testNestedMultilineStringLiterals() {
    let source = #"""
      assertionFailure("""

        \("""
          First Line
        """)
      """)
      """#

    assertFormatted(source: source, expected: source)
  }

  func testIndentNestedMultilineStringLiterals() throws {
    let stringLiteral: ExprSyntax = #"""
      """

        \("""
          First Line
        """)
      """
      """#

    assertFormatted(tree: stringLiteral, expected: stringLiteral.description)

    let tree = try FunctionDeclSyntax("func test()") {
      stringLiteral
    }

    assertFormatted(
      tree: tree,
      expected: #"""
        func test() {
            """

              \("""
                First Line
              """)
            """
        }
        """#
    )
  }

  func testIndentNestedIndentedMultilineStringLiterals() throws {
    let stringLiteral: ExprSyntax = #"""
      _ = """

            \("""
              First Line
            """)
          """
      """#

    assertFormatted(tree: stringLiteral, expected: stringLiteral.description)

    let tree = try FunctionDeclSyntax("func test()") {
      stringLiteral
    }

    assertFormatted(
      tree: tree,
      expected: #"""
        func test() {
            _ = """

                  \("""
                    First Line
                  """)
                """
        }
        """#
    )
  }

  func testClosureInStringInterpolation() {
    let source = #"""
      """
      \(gen { (x) in
          return """
          case
      """
      })
      """
      """#

    assertFormatted(source: source, expected: source)
  }

  func testNestedUserDefinedIndentation() {
    assertFormatted(
      source: """
        class X {
        func test() {
            withTrailingClosure() {
                if true { return }
            }
        }
        }
        """,
      expected: """
        class X {
            func test() {
                withTrailingClosure() {
                    if true {
                        return
                    }
                }
            }
        }
        """
    )
  }

  func testDontInsertTrailingWhitespaceIfNextTokenStartsWithLeadingWhitespace() {
    let tree = VariableDeclSyntax(
      bindingSpecifier: .keyword(.var),
      bindings: PatternBindingListSyntax([
        PatternBindingSyntax(
          pattern: PatternSyntax(IdentifierPatternSyntax(identifier: .identifier("x"))),
          typeAnnotation: TypeAnnotationSyntax(
            colon: .colonToken(trailingTrivia: .space),
            type: TypeSyntax(IdentifierTypeSyntax(name: .identifier("Int")))
          ),
          accessorBlock: AccessorBlockSyntax(
            leftBrace: .leftBraceToken(leadingTrivia: .space),
            accessors: .accessors(AccessorDeclListSyntax([])),
            rightBrace: .rightBraceToken(leadingTrivia: .newline)
          )
        )
      ])
    )
    assertFormatted(
      tree: tree,
      expected: """
        var x: Int {
        }
        """
    )
  }

  func testAccessor() {
    let source = """
      struct Point {
        var computed: Int {
          get { 0 }
        }
      }
      """

    assertFormatted(
      source: source,
      expected: """
        struct Point {
          var computed: Int {
            get {
              0
            }
          }
        }
        """,
      using: BasicFormat(indentationWidth: .spaces(2))
    )
  }

  func testClosureExprParam() {
    let source = """
      _ = {foo in}
      """

    assertFormatted(
      source: source,
      expected: """
        _ = { foo in
        }
        """
    )
  }

  func testSubTreeNode() {
    let decl: DeclSyntax = """
      func test() {
          print(1)
      }
      """
    let body = decl.cast(FunctionDeclSyntax.self).body!

    assertFormatted(
      tree: body,
      expected: """
        {
            print(1)
        }
        """
    )
  }

  func testSubTreeNodeWithIndentedParentNode() {
    let decl: DeclSyntax = """
      struct X {
          func test() {
              print(1)
          }
      }
      """

    let body = decl.cast(StructDeclSyntax.self).memberBlock.members.first!.decl.cast(FunctionDeclSyntax.self).body!

    assertFormatted(
      tree: body,
      expected: """
            {
                print(1)
            }
        """
    )
  }

  func testUnexpectedIsNotFormatted() {
    withStringInterpolationParsingErrorsSuppressed {
      let expr: ExprSyntax = """
        let foo=1
        """

      assertFormatted(
        tree: expr,
        expected: """
          let foo=1
          """
      )
    }
  }

  func testRightAnglePeriodNotFormatted() {
    assertFormatted(
      tree: ExprSyntax("Foo<T>.bar"),
      expected: "Foo<T>.bar"
    )
  }

  func testPeriodAfterStringLiteral() {
    let source = """
      "test".lowercased()
      """
    assertFormatted(source: source, expected: source)
  }

  func testPeriodAfterRawStringLiteral() {
    let source = """
      #"test"#.lowercased()
      """
    assertFormatted(source: source, expected: source)
  }

  func testPeriodAfterRegexLiteral() {
    let source = """
      /test/.something
      """
    assertFormatted(source: source, expected: source)
  }

  func testPeriodAfterRawRegexLiteral() {
    let source = """
      /test/.something
      """
    assertFormatted(source: source, expected: source)
  }
}
