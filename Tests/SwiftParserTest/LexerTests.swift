//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import XCTest
@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser

private func lexeme(
  _ kind: RawTokenKind,
  _ wholeText: SyntaxText,
  leadingLength: Int = 0,
  trailingLength: Int = 0
) -> Lexer.Lexeme {
  return Lexer.Lexeme(
    tokenKind: kind,
    flags: [.isAtStartOfLine],
    start: wholeText.baseAddress!,
    leadingTriviaLength: leadingLength,
    textLength: wholeText.count - leadingLength - trailingLength,
    trailingTriviaLength: trailingLength
  )
}

public class LexerTests: XCTestCase {
  func testIdentifiers() {
    var data =
      """
      Hello World
      """
    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(
        lexemes,
        [
          lexeme(.identifier, "Hello ", trailingLength: 1),
          lexeme(.identifier, "World"),
          lexeme(.eof, ""),
        ]
      )
    }
  }

  func testEscapedIdentifiers() {
    var data =
      """
      `Hello` `World` `$`
      """
    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(
        lexemes,
        [
          lexeme(.identifier, "`Hello` ", trailingLength: 1),
          lexeme(.identifier, "`World` ", trailingLength: 1),
          lexeme(.identifier, "`$`"),
          lexeme(.eof, ""),
        ]
      )
    }
  }

  func testBlockComments() {
    do {
      var data =
        """
        /*/ */
        func not_doc5() {}
        """

      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(
          lexemes,
          [
            lexeme(.funcKeyword, "/*/ */\nfunc ", leadingLength: 7, trailingLength: 1),
            lexeme(.identifier, "not_doc5"),
            lexeme(.leftParen, "("),
            lexeme(.rightParen, ") ", trailingLength: 1),
            lexeme(.leftBrace, "{"),
            lexeme(.rightBrace, "}"),
            lexeme(.eof, ""),
          ]
        )
      }
    }

    do {
      var data =
        """
        /* */
        /**/
        /* /* */ */
        """

      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(
          lexemes,
          [
            lexeme(.eof, "/* */\n/**/\n/* /* */ */", leadingLength: 22)
          ]
        )
      }
    }
  }

  func testDeepTupleAccess() {
    var data =
      #"""
      x.1.0
      """#

    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(
        lexemes,
        [
          lexeme(.identifier, "x"),
          lexeme(.period, "."),
          lexeme(.integerLiteral, "1"),
          lexeme(.period, "."),
          lexeme(.integerLiteral, "0"),
          lexeme(.eof, ""),
        ]
      )
    }
  }

  func testUnicodeLiteral() {
    do {
      var data =
        #"""
        "\u{1234}"
        """#

      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(
          lexemes,
          [
            lexeme(.stringLiteral, #""\u{1234}""#),
            lexeme(.eof, ""),
          ]
        )
      }
    }

    do {
      var data =
        #"""
        "\u{12341234}"
        """#

      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(
          lexemes,
          [
            lexeme(.stringLiteral, #""\u{12341234}""#),
            lexeme(.eof, ""),
          ]
        )
      }
    }
  }

  func testNumberLiterals() {
    var data =
      """
      1234567890
      0b1010101
      0xABC
      1.0
      1.0e10
      1.0E10
      0xfeed_beef
      0xff.0p2
      -0xff.0p2
      +0xff.0p2
      0x1.921fb4p1
      """
    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(
        lexemes,
        [
          lexeme(.integerLiteral, "1234567890"),
          lexeme(.integerLiteral, "\n0b1010101", leadingLength: 1),
          lexeme(.integerLiteral, "\n0xABC", leadingLength: 1),
          lexeme(.floatingLiteral, "\n1.0", leadingLength: 1),
          lexeme(.floatingLiteral, "\n1.0e10", leadingLength: 1),
          lexeme(.floatingLiteral, "\n1.0E10", leadingLength: 1),
          lexeme(.integerLiteral, "\n0xfeed_beef", leadingLength: 1),
          lexeme(.floatingLiteral, "\n0xff.0p2", leadingLength: 1),
          lexeme(.prefixOperator, "\n-", leadingLength: 1),
          lexeme(.floatingLiteral, "0xff.0p2"),
          lexeme(.prefixOperator, "\n+", leadingLength: 1),
          lexeme(.floatingLiteral, "0xff.0p2"),
          lexeme(.floatingLiteral, "\n0x1.921fb4p1", leadingLength: 1),
          lexeme(.eof, ""),
        ]
      )
    }
  }

  func testRawStringLiterals() {
    do {
      var data =
        """
        ###"this is a ##"raw"## string"###
        """
      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(
          lexemes,
          [
            lexeme(.stringLiteral, ####"###"this is a ##"raw"## string"###"####),
            lexeme(.eof, ""),
          ]
        )
      }
    }

    do {
      var data =
        """
        #"#"abc"#
        """
      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(
          lexemes,
          [
            lexeme(.stringLiteral, ####"#"#"abc"#"####),
            lexeme(.eof, ""),
          ]
        )
      }
    }

    do {
      var data =
        """
        ###"##"abc"###
        """
      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(
          lexemes,
          [
            lexeme(.stringLiteral, ####"###"##"abc"###"####),
            lexeme(.eof, ""),
          ]
        )
      }
    }

    do {
      var data =
        #####"""
        ##"""abc"####
        """#####
      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(
          lexemes,
          [
            lexeme(.stringLiteral, ###"##"""abc"##"###),
            lexeme(.pound, "#"),
            lexeme(.pound, "#"),
            lexeme(.eof, ""),
          ]
        )
      }
    }
  }

  func testShebang() {
    var data =
      """
      #!/usr/bin/swiftc
      let x = 42
      """
    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(
        lexemes,
        [
          lexeme(.letKeyword, "#!/usr/bin/swiftc\nlet ", leadingLength: 18, trailingLength: 1),
          lexeme(.identifier, "x ", trailingLength: 1),
          lexeme(.equal, "= ", trailingLength: 1),
          lexeme(.integerLiteral, "42"),
          lexeme(.eof, ""),
        ]
      )
    }
  }

  func testDocComment() {
    var data =
      """
      /** hello */
      var x: Int
      /* regular comment */
      """
    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(
        lexemes,
        [
          lexeme(.varKeyword, "/** hello */\nvar ", leadingLength: 13, trailingLength: 1),
          lexeme(.identifier, "x"),
          lexeme(.colon, ": ", trailingLength: 1),
          lexeme(.identifier, "Int"),
          lexeme(.eof, "\n/* regular comment */", leadingLength: 22),
        ]
      )
    }
  }

  func testMain() {
    var data =
      """
      /* TestApp */
      @main struct TestApp {
        static func main() {
          print("Hello World")
        }
      }
      """
    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(
        lexemes,
        [
          lexeme(.atSign, "/* TestApp */\n@", leadingLength: 14),
          lexeme(.identifier, "main ", trailingLength: 1),
          lexeme(.structKeyword, "struct ", trailingLength: 1),
          lexeme(.identifier, "TestApp ", trailingLength: 1),
          lexeme(.leftBrace, "{"),
          lexeme(.staticKeyword, "\n  static ", leadingLength: 3, trailingLength: 1),
          lexeme(.funcKeyword, "func ", trailingLength: 1),
          lexeme(.identifier, "main"),
          lexeme(.leftParen, "("),
          lexeme(.rightParen, ") ", trailingLength: 1),
          lexeme(.leftBrace, "{"),
          lexeme(.identifier, "\n    print", leadingLength: 5),
          lexeme(.leftParen, "("),
          lexeme(.stringLiteral, "\"Hello World\""),
          lexeme(.rightParen, ")"),
          lexeme(.rightBrace, "\n  }", leadingLength: 3),
          lexeme(.rightBrace, "\n}", leadingLength: 1),
          lexeme(.eof, ""),
        ]
      )
    }
  }

  func testRegexLexing() {
    let fixtures: [(String, [Lexer.Lexeme])] = [
      (
        "/abc/",
        [
          lexeme(.regexLiteral, "/abc/"),
          lexeme(.eof, ""),
        ]
      ),
      (
        "#/abc/#",
        [
          lexeme(.regexLiteral, "#/abc/#"),
          lexeme(.eof, ""),
        ]
      ),
      (
        "###/abc/###",
        [
          lexeme(.regexLiteral, "###/abc/###"),
          lexeme(.eof, ""),
        ]
      ),
      (
        """
        #/
        a
        b
        /#
        """,
        [
          lexeme(.regexLiteral, "#/\na\nb\n/#"),
          lexeme(.eof, ""),
        ]
      ),
      (
        "#/ \na\nb\n  /#",
        [
          lexeme(.regexLiteral, "#/ \na\nb\n  /#"),
          lexeme(.eof, ""),
        ]
      ),
      (
        "##/ \na\nb\n  /##",
        [
          lexeme(.regexLiteral, "##/ \na\nb\n  /##"),
          lexeme(.eof, ""),
        ]
      ),
      (
        "#/abc/def/#",
        [
          lexeme(.regexLiteral, "#/abc/def/#"),
          lexeme(.eof, ""),
        ]
      ),
      (
        "#/abc\\/#def/#",
        [
          lexeme(.regexLiteral, "#/abc\\/#def/#"),
          lexeme(.eof, ""),
        ]
      ),
      (
        "#/abc|#def/#",
        [
          lexeme(.regexLiteral, "#/abc|#def/#"),
          lexeme(.eof, ""),
        ]
      ),
      (
        "#/abc\n/#",
        [
          lexeme(.pound, "#"),
          lexeme(.unspacedBinaryOperator, "/"),
          lexeme(.identifier, "abc"),
          lexeme(.prefixOperator, "\n/", leadingLength: 1),
          lexeme(.pound, "#"),
          lexeme(.eof, ""),
        ]
      ),
      (
        "#/abc\r/#",
        [
          lexeme(.pound, "#"),
          lexeme(.unspacedBinaryOperator, "/"),
          lexeme(.identifier, "abc"),
          lexeme(.prefixOperator, "\r/", leadingLength: 1),
          lexeme(.pound, "#"),
          lexeme(.eof, ""),
        ]
      ),
      (
        "/a)/",
        [
          lexeme(.prefixOperator, "/"),
          lexeme(.identifier, "a"),
          lexeme(.rightParen, ")"),
          lexeme(.postfixOperator, "/"),
          lexeme(.eof, ""),
        ]
      ),
    ]
    for (fixture, expectation) in fixtures {
      var fixture = fixture
      fixture.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(lexemes, expectation)
      }
    }
  }

  func testUnexpectedLexing() {
    var data = "static func �() {}"
    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(
        lexemes,
        [
          lexeme(.staticKeyword, "static ", trailingLength: 1),
          lexeme(.funcKeyword, "func �", trailingLength: 4),
          lexeme(.leftParen, "("),
          lexeme(.rightParen, ") ", trailingLength: 1),
          lexeme(.leftBrace, "{"),
          lexeme(.rightBrace, "}"),
          lexeme(.eof, ""),
        ]
      )
    }
  }

  func testBOMLexing() {
    let bom: Unicode.Scalar = "\u{feff}"
    var data =
      """
      \(bom)Hello
      """
    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(
        lexemes,
        [
          lexeme(.identifier, "\u{feff}Hello", leadingLength: 3),
          lexeme(.eof, ""),
        ]
      )
    }
  }

  func testConflictLexing() {
    do {
      var data = """
        // diff3-style conflict markers

        <<<<<<< HEAD:conflict_markers.swift // expected-error {{source control conflict marker in source file}}
        var a : String = "A"
        var b : String = "b"
        =======
        var a : String = "a"
        var b : String = "B"
        >>>>>>> 18844bc65229786b96b89a9fc7739c0fc897905e:conflict_markers.swift
        """
      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(
          lexemes,
          [
            lexeme(
              .eof,
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
              leadingLength: 300
            )
          ]
        )
      }

    }

    do {
      var data = """
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

        """
      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(
          lexemes,
          [
            lexeme(
              .eof,
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
              leadingLength: 204
            )
          ]
        )
      }
    }
  }

  func testUnicodeStringLiteralLexing() {
    do {
      var data =
        #"""
        "\\)|[^\\s`!()\\[\\]{};:'\".,<>?«»“”‘’]))"
        """#
      let lexemes = data.withUTF8 { buf in
        Lexer.lex(buf)
      }
      AssertEqualTokens(
        lexemes,
        [
          lexeme(.stringLiteral, #""\\)|[^\\s`!()\\[\\]{};:'\".,<>?«»“”‘’]))""#),
          lexeme(.eof, ""),
        ]
      )
    }
  }

  func testNotARegex() {
    do {
      var data =
        """
        min(reduced.count / 2, chunkSize / 2)
        """
      let lexemes = data.withUTF8 { buf in
        Lexer.lex(buf)
      }
      AssertEqualTokens(
        lexemes,
        [
          lexeme(.identifier, "min"),
          lexeme(.leftParen, "("),
          lexeme(.identifier, "reduced"),
          lexeme(.period, "."),
          lexeme(.identifier, "count ", trailingLength: 1),
          lexeme(.spacedBinaryOperator, "/ ", trailingLength: 1),
          lexeme(.integerLiteral, "2"),
          lexeme(.comma, ", ", trailingLength: 1),
          lexeme(.identifier, "chunkSize ", trailingLength: 1),
          lexeme(.spacedBinaryOperator, "/ ", trailingLength: 1),
          lexeme(.integerLiteral, "2"),
          lexeme(.rightParen, ")"),
          lexeme(.eof, ""),
        ]
      )
    }

    do {
      var data =
        """
        var x: Int {
          return 0 /
                 x
        }

        ///
        """
      let lexemes = data.withUTF8 { buf in
        Lexer.lex(buf)
      }
      AssertEqualTokens(
        lexemes,
        [
          lexeme(.varKeyword, "var ", trailingLength: 1),
          lexeme(.identifier, "x"),
          lexeme(.colon, ": ", trailingLength: 1),
          lexeme(.identifier, "Int ", trailingLength: 1),
          lexeme(.leftBrace, "{"),
          lexeme(.returnKeyword, "\n  return ", leadingLength: 3, trailingLength: 1),
          lexeme(.integerLiteral, "0 ", trailingLength: 1),
          lexeme(.spacedBinaryOperator, "/", trailingLength: 0),
          lexeme(.identifier, "\n         x", leadingLength: 10),
          lexeme(.rightBrace, "\n}", leadingLength: 1),
          lexeme(.eof, "\n\n///", leadingLength: 5),
        ]
      )
    }

    do {
      var data =
        """
        n /= 2 // foo
        """
      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(
          lexemes,
          [
            lexeme(.identifier, "n ", trailingLength: 1),
            lexeme(.spacedBinaryOperator, "/= ", trailingLength: 1),
            lexeme(.integerLiteral, "2 // foo", trailingLength: 7),
            lexeme(.eof, ""),
          ]
        )
      }
    }

    do {
      var data =
        """
        UIColor(white: 216.0/255.0, alpha: 44.0/255.0)
        """
      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(
          lexemes,
          [
            lexeme(.identifier, "UIColor"),
            lexeme(.leftParen, "("),
            lexeme(.identifier, "white"),
            lexeme(.colon, ": ", trailingLength: 1),
            lexeme(.floatingLiteral, "216.0"),
            lexeme(.unspacedBinaryOperator, "/"),
            lexeme(.floatingLiteral, "255.0"),
            lexeme(.comma, ", ", trailingLength: 1),
            lexeme(.identifier, "alpha"),
            lexeme(.colon, ": ", trailingLength: 1),
            lexeme(.floatingLiteral, "44.0"),
            lexeme(.unspacedBinaryOperator, "/"),
            lexeme(.floatingLiteral, "255.0"),
            lexeme(.rightParen, ")"),
            lexeme(.eof, ""),
          ]
        )
      }
    }

    do {
      var data =
        """
        #/abc|#def/
        """
      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(
          lexemes,
          [
            lexeme(.pound, "#"),
            lexeme(.unspacedBinaryOperator, "/"),
            lexeme(.identifier, "abc"),
            lexeme(.unspacedBinaryOperator, "|"),
            lexeme(.pound, "#"),
            lexeme(.identifier, "def"),
            lexeme(.postfixOperator, "/"),
            lexeme(.eof, ""),
          ]
        )
      }
    }
  }

  func testUnicodeReplcementsInStream() {
    do {
      var data =
        """
        () -> (\u{feff})
        """
      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(
          lexemes,
          [
            lexeme(.leftParen, "("),
            lexeme(.rightParen, ") ", trailingLength: 1),
            lexeme(.arrow, "-> ", trailingLength: 1),
            lexeme(.leftParen, "(\u{feff}", trailingLength: 3),
            lexeme(.rightParen, ")"),
            lexeme(.eof, ""),
          ]
        )
      }
    }

    do {
      var data =
        """
        y\u{fffe} + z
        """
      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(
          lexemes,
          [
            lexeme(.identifier, "y\u{fffe} ", trailingLength: 4),
            lexeme(.spacedBinaryOperator, "+ ", trailingLength: 1),
            lexeme(.identifier, "z"),
            lexeme(.eof, ""),
          ]
        )
      }
    }
  }

  func testOperators() {
    var data =
      """
      myString==""
      """
    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(
        lexemes,
        [
          lexeme(.identifier, "myString"),
          lexeme(.unspacedBinaryOperator, "=="),
          lexeme(.stringLiteral, #""""#),
          lexeme(.eof, ""),
        ]
      )
    }
  }

  func testEditorPlaceholders() {
    var data =
      """
      !<#b1#> && !<#b2#>
      """
    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(
        lexemes,
        [
          lexeme(.prefixOperator, "!"),
          lexeme(.identifier, "<#b1#> ", trailingLength: 1),
          lexeme(.spacedBinaryOperator, "&& ", trailingLength: 1),
          lexeme(.prefixOperator, "!"),
          lexeme(.identifier, "<#b2#>"),
          lexeme(.eof, ""),
        ]
      )
    }
  }

  func testCommentAttribution() {
    var data =
      """
      func foo() { // comment
          // new comment
          bar()
      }
      """
    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(
        lexemes,
        [
          lexeme(.funcKeyword, "func ", trailingLength: 1),
          lexeme(.identifier, "foo"),
          lexeme(.leftParen, "("),
          lexeme(.rightParen, ") ", trailingLength: 1),
          lexeme(.leftBrace, "{ // comment", trailingLength: 11),
          lexeme(
            .identifier,
            """

                // new comment
                bar
            """,
            leadingLength: 24
          ),
          lexeme(.leftParen, "("),
          lexeme(.rightParen, ")"),
          lexeme(.rightBrace, "\n}", leadingLength: 1),
          lexeme(.eof, ""),
        ]
      )
    }
  }

  func testCommentAttribution2() {
    // Example from https://forums.swift.org/t/changing-comment-trivia-attribution-from-trailing-trivia-to-leading-trivia/50773
    var data = "/*X_START*/x/*X_END*/ + /*Y_START*/y/*Y_END*/"
    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(
        lexemes,
        [
          lexeme(.identifier, "/*X_START*/x/*X_END*/ ", leadingLength: 11, trailingLength: 10),
          lexeme(.spacedBinaryOperator, "+ /*Y_START*/", trailingLength: 12),
          lexeme(.identifier, "y/*Y_END*/", trailingLength: 9),
          lexeme(.eof, ""),
        ]
      )
    }
  }

  func testNumericLiteralDiagnostics() {
    AssertParse(
      """
      var fl_l: Float = 0x1.01️⃣

      var fl_bad_separator2: Double = 0x1p2️⃣_

      var invalid_num_literal: Int64 = 03️⃣QWERTY
      var invalid_bin_literal: Int64 = 0b4️⃣QWERTY
      var invalid_hex_literal: Int64 = 0x5️⃣QWERTY
      var invalid_oct_literal: Int64 = 0o6️⃣QWERTY

      var invalid_exp_literal: Double = 1.0e+7️⃣QWERTY
      var invalid_fp_exp_literal: Double = 0x1p+8️⃣QWERTY
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "hexadecimal floating point literal must end with an exponent"),

        DiagnosticSpec(locationMarker: "2️⃣", message: "'_' is not a valid first character in floating point exponent"),

        DiagnosticSpec(locationMarker: "3️⃣", message: "'Q' is not a valid digit in integer literal"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "'Q' is not a valid binary digit (0 or 1) in integer literal"),
        DiagnosticSpec(locationMarker: "5️⃣", message: "'Q' is not a valid hexadecimal digit (0-9, A-F) in integer literal"),
        DiagnosticSpec(locationMarker: "6️⃣", message: "'Q' is not a valid octal digit (0-7) in integer literal"),

        DiagnosticSpec(locationMarker: "7️⃣", message: "'Q' is not a valid digit in floating point exponent"),
        DiagnosticSpec(locationMarker: "8️⃣", message: "'Q' is not a valid digit in floating point exponent"),
      ]
    )
  }

  func testBadNumericLiteralDigits() {
    AssertParse(
      """
      var invalid_num_literal_prefix: Int64 = 01️⃣a1234567
      var invalid_num_literal_middle: Int64 = 01232️⃣A5678
      var invalid_bin_literal_middle: Int64 = 0b103️⃣20101
      var invalid_oct_literal_middle: Int64 = 0o13574️⃣864
      var invalid_hex_literal_middle: Int64 = 0x147AD5️⃣G0
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "'a' is not a valid digit in integer literal"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "'A' is not a valid digit in integer literal"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "'2' is not a valid binary digit (0 or 1) in integer literal"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "'8' is not a valid octal digit (0-7) in integer literal"),
        DiagnosticSpec(locationMarker: "5️⃣", message: "'G' is not a valid hexadecimal digit (0-9, A-F) in integer literal"),
      ]
    )
  }

  func testMultiDigitTupleAccess() {
    var data = "x.13.1"
    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(
        lexemes,
        [
          lexeme(.identifier, "x"),
          lexeme(.period, "."),
          lexeme(.integerLiteral, "13"),
          lexeme(.period, "."),
          lexeme(.integerLiteral, "1"),
          lexeme(.eof, ""),
        ]
      )
    }
  }

  func testFloatingPointNumberAfterRangeOperator() {
    var data = "0.1...0.2"
    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(
        lexemes,
        [
          lexeme(.floatingLiteral, "0.1"),
          lexeme(.unspacedBinaryOperator, "..."),
          lexeme(.floatingLiteral, "0.2"),
          lexeme(.eof, ""),
        ]
      )
    }
  }

  func testUnterminatedFloatLiteral() {
    var data = "0."
    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(
        lexemes,
        [
          lexeme(.integerLiteral, "0"),
          lexeme(.unknown, "."),
          lexeme(.eof, ""),
        ]
      )
    }
  }
}

extension Lexer {
  fileprivate static func lex(
    _ input: UnsafeBufferPointer<UInt8>,
    from startIndex: Int = 0
  ) -> [Self.Lexeme] {
    var lexemes = [Lexeme]()
    for token in Lexer.tokenize(input, from: startIndex) {
      lexemes.append(token)

      guard token.tokenKind != .eof else {
        break
      }
    }
    return lexemes
  }
}
