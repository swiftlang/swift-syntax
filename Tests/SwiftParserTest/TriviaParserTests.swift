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
@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) @_spi(Testing) import SwiftParser

final class TriviaParserTests: ParserTestCase {

  func testTriviaParsing() {

    XCTAssertEqual(
      TriviaParser.parseTrivia(
        """
        /* */
        /**/
        /* /** */ */
        /** /* */ */
        """,
        position: .leading
      ),
      [
        .blockComment("/* */"),
        .newlines(1),
        .blockComment("/**/"),
        .newlines(1),
        .blockComment("/* /** */ */"),
        .newlines(1),
        .docBlockComment("/** /* */ */"),
      ]
    )

    XCTAssertEqual(
      TriviaParser.parseTrivia(
        """
        #!/bin/env swift


        """,
        position: .leading
      ),
      [
        .shebang("#!/bin/env swift"),
        .newlines(2),
      ]
    )

    XCTAssertEqual(
      TriviaParser.parseTrivia(
        """
        #!/bin/env swift
        """,
        position: .trailing
      ),
      [
        .pounds(1),
        .unexpectedText("!/bin/env"),
        .spaces(1),
        .unexpectedText("swift"),
      ]
    )

    XCTAssertEqual(
      TriviaParser.parseTrivia("\r\n\r\r\n\r\n\n", position: .leading),
      [
        .carriageReturnLineFeeds(1),
        .carriageReturns(1),
        .carriageReturnLineFeeds(2),
        .newlines(1),
      ]
    )

    let bom: Unicode.Scalar = "\u{feff}"
    var bomStr = "\(bom)/// Foo\n"
    bomStr.withSyntaxText { triviaText in
      XCTAssertEqual(
        TriviaParser.parseTrivia(triviaText, position: .leading),
        [
          .unexpectedText("\u{feff}"),
          .docLineComment("/// Foo"),
          .newlines(1),
        ]
      )
    }

    XCTAssertEqual(
      TriviaParser.parseTrivia(
        """
        // diff3-style conflict markers

        <<<<<<< HEAD:conflict_markers.swift // expected-error {{source control conflict marker in source file}}
        var a : String = "A"
        var b : String = "b"
        =======
        var a : String = "a"
        var b : String = "B"
        >>>>>>> 18844bc65229786b96b89a9fc7739c0fc897905e:conflict_markers.swift

        """,
        position: .leading
      ),
      [
        .lineComment("// diff3-style conflict markers"),
        .newlines(2),
        .unexpectedText(
          """
          <<<<<<< HEAD:conflict_markers.swift // expected-error {{source control conflict marker in source file}}
          var a : String = "A"
          var b : String = "b"
          =======
          var a : String = "a"
          var b : String = "B"
          >>>>>>> 18844bc65229786b96b89a9fc7739c0fc897905e:conflict_markers.swift
          """
        ),
        .newlines(1),
      ]
    )

    XCTAssertEqual(
      TriviaParser.parseTrivia(
        """
        // Perforce-style conflict markers

        >>>> ORIGINAL
        var a : String = "A"
        var b : String = "B"
        ==== THEIRS
        var a : String = "A"
        var b : String = "b"
        ==== YOURS
        var a : String = "a"
        var b : String = "B"
        <<<<

        """,
        position: .leading
      ),
      [
        .lineComment("// Perforce-style conflict markers"),
        .newlines(2),
        .unexpectedText(
          """
          >>>> ORIGINAL
          var a : String = "A"
          var b : String = "B"
          ==== THEIRS
          var a : String = "A"
          var b : String = "b"
          ==== YOURS
          var a : String = "a"
          var b : String = "B"
          <<<<

          """
        ),
      ]
    )
  }

  func testRawSyntaxLazyTriviaPieces() {
    withParser(
      source: """
        /// Foo.
        func foo() {
        }
        """
    ) { parser in
      let fn = DeclSyntax.parse(from: &parser).cast(FunctionDeclSyntax.self)

      XCTAssertEqual(
        fn.funcKeyword.leadingTrivia,
        [
          .docLineComment("/// Foo."),
          .newlines(1),
        ]
      )
      XCTAssertEqual(
        fn.funcKeyword.trailingTrivia,
        [
          .spaces(1)
        ]
      )

      XCTAssertEqual(fn.body!.leftBrace.leadingTrivia, [])
      XCTAssertEqual(fn.body!.leftBrace.trailingTrivia, [])

      XCTAssertEqual(
        fn.body!.rightBrace.leadingTrivia,
        [
          .newlines(1)
        ]
      )
      XCTAssertEqual(fn.body!.rightBrace.trailingTrivia, [])
    }

  }

  func testSyntaxLazyTrivia() {
    let source = """
      /* comment only */

      """
    let sourceFileSyntax = Parser.parse(source: source)
    XCTAssertEqual(
      sourceFileSyntax.leadingTrivia,
      [
        .blockComment("/* comment only */"),
        .newlines(1),
      ]
    )
  }

  func testUnexpectedSplitting() {
    XCTAssertEqual(
      TriviaParser.parseTrivia("\u{fffe} ", position: .trailing),
      [
        .unexpectedText("\u{fffe}"),
        .spaces(1),
      ]
    )
  }
}
