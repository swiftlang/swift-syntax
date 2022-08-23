@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import XCTest

final class ExpressionTests: XCTestCase {
  func testTernary() throws {
    try AssertParse({ $0.parseSourceFile() }) {
      "let a ="
    }

    try AssertParse({ $0.parseExpression() }) {
       """
       a ? b : c ? d : e
       """
    }
  }

  func testClosureLiterals() throws {
    try AssertParse({ $0.parseClosureExpression() }) {
      #"""
      { @MainActor (a: Int) async -> Int in print("hi") }
      """#
    }

    try AssertParse({ $0.parseClosureExpression() }) {
      """
      { [weak self, weak weakB = b] foo in
        return 0
      }
      """
    }
  }

  func testTrailingClosures() throws {
    try AssertParse({ $0.parseSourceFile() }) {
      """
      var button =  View.Button[5, 4, 3
      ] {
        // comment #0
        Text("ABC")
      }
      """
    }

    try AssertParse({ $0.parseExpression() }) {
      """
      compactMap { (parserDiag) in }
      """
    }
  }

  func testSequenceExpressions() throws {
    try AssertParse({ $0.parseSequenceExpressionElement(.basic) }) {
     """
     await a()
     """
    }
  }

  func testNestedTypeSpecialization() throws {
    try AssertParse({ $0.parseExpression() }) {
      """
      Swift.Array<Array<Foo>>()
      """
    }
  }

  func testObjectLiterals() throws {
    try AssertParse({ $0.parseSourceFile() }) {
      """
      #colorLiteral()
      #colorLiteral(red: 1.0)
      #colorLiteral(red: 1.0, green: 1.0)
      #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      """
    }

    try AssertParse({ $0.parseSourceFile() }) {
      """
      #imageLiteral()
      #imageLiteral(resourceName: "foo.png")
      #imageLiteral(resourceName: "foo/bar/baz/qux.png")
      #imageLiteral(resourceName: "foo/bar/baz/quux.png")
      """
    }
  }

  func testKeypathExpression() throws {
    try AssertParse({ $0.parseExpression() }) {
      #"""
      children.filter(\.type.defaultInitialization.isEmpty)
      """#
    }
  }

  func testBasicLiterals() throws {
    try AssertParse({ $0.parseSourceFile() }) {
      """
      #file
      (#line)
      #column
      #function
      #dsohandle
      __FILE__
      __LINE__
      __COLUMN__
      __FUNCTION__
      __DSO_HANDLE__
      """
    }
  }

  func testRegexLiteral() throws {
    try AssertParse({ $0.parseExpression() }) {
       #"""
       /(?<identifier>[[:alpha:]]\w*) = (?<hex>[0-9A-F]+)/
       """#
    }
  }

  func testInitializerExpression() throws {
    try AssertParse({ $0.parseExpression() }) {
      """
      Lexer.Cursor(input: input, previous: 0)
      """
    }
  }

  func testCollectionLiterals() throws {
    try AssertParse({ $0.parseExpression() }) {
      "[Dictionary<String, Int>: Int]()"
    }

    try AssertParse({ $0.parseExpression() }) {
      "[(Int, Double) -> Bool]()"
    }

    try AssertParse({ $0.parseExpression() }) {
      "[(Int, Double) throws -> Bool]()"
    }

    try AssertParse({ $0.parseExpression() }) {
      "_ = [@convention(block) ()  -> Int]().count"
    }

    try AssertParse({ $0.parseExpression() }) {
      "A<@convention(c) () -> Int32>.c()"
    }

    try AssertParse({ $0.parseExpression() }) {
      "A<(@autoclosure @escaping () -> Int, Int) -> Void>.c()"
    }

    try AssertParse({ $0.parseExpression() }) {
      "_ = [String: (@escaping (A<B>) -> Int) -> Void]().keys"
    }

    try AssertParse({ $0.parseExpression() }) {
      """
      [
        condition ? firstOption : secondOption,
        bar(),
      ]
      """
    }

    try AssertParse({ $0.parseExpression() }, allowErrors: true) {
      "[,"
    }

    try AssertParse({ $0.parseExpression() }, allowErrors: true) {
      """
      ([1:)
      """
    }
  }

  func testInterpolatedStringLiterals() throws {
    try AssertParse({ $0.parseSourceFile() }) {
      #"""
      return "Fixit: \(range.debugDescription) Text: \"\(text)\""
      """#
    }
  }

  func testStringLiterals() throws {
    try AssertParse({ $0.parseExpression() }) {
      #"""
      ""
      """#
    }

    try AssertParse({ $0.parseExpression() }) {
      #"""
      """
      """
      """#
    }

    try AssertParse({ $0.parseExpression() }, allowErrors: true) {
      #"" >> \( abc } ) << ""#
    }

    try AssertParse({ $0.parseSourceFile() }) {
      ##"""


      #"Hello World"#

      "Hello World"


      """##
    }

    try AssertParse({ $0.parseExpression() }, allowErrors: true) {
      #""\","#
    }

    try AssertParse({ $0.parseExpression() }) {
      #"""
      "(?i)\\b((?:[a-z][\\w-]+:(?:/{1,3}|[a-z0-9%])|www\\d{0,3}[.]|[a-z0-9.\\-]+[.][a-z]{2,4}/)" +
      "(?:[^\\s()<>]+|\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\))+(?:\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*" +
      "\\)|[^\\s`!()\\[\\]{};:'\".,<>?«»“”‘’]))"
      """#
    }

    try AssertParse({ $0.parseExpression() }) {
      #"""
      """
          Custom(custom: \(interval),\
          Expr: \(pause?.debugDescription ?? "–"), \
          PlainWithContinuation: \(countdown), \
          Plain: \(units))"
      """
      """#
    }

    try AssertParse({ $0.parseExpression() }) {
      #"""
      "Founded: \(Date.appleFounding, format: 📆)"
      """#
    }

    try AssertParse({ $0.parseExpression()}) {
        """

        ""
        """
    }

    try AssertParse({ $0.parseExpression() }) {
      ##"""
      #"""#
      """##
    }

    try AssertParse({ $0.parseExpression() }) {
      ##"""
      #"""""#
      """##
    }

    try AssertParse({ $0.parseExpression() }) {
      ##"""
      #"""
      multiline raw
      """#
      """##
    }

    try AssertParse({ $0.parseExpression() }) {
      #"""
      "\(x)"
      """#
    }
  }

  func testRangeSubscript() throws {
    try AssertParse({ $0.parseExpression() }) {
      """
      text[...]
      """
    }
  }
}
