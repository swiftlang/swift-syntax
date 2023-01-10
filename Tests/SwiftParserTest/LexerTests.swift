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

public class LexerTests: XCTestCase {
  func testIdentifiers() {
    AssertLexemes(
      "Hello World",
      lexemes: [
        LexemeSpec(.identifier, text: "Hello", trailing: " "),
        LexemeSpec(.identifier, text: "World"),
      ]
    )
  }

  func testEscapedIdentifiers() {
    AssertLexemes(
      "`Hello` `World` `$`",
      lexemes: [
        LexemeSpec(.identifier, text: "`Hello`", trailing: " "),
        LexemeSpec(.identifier, text: "`World`", trailing: " "),
        LexemeSpec(.identifier, text: "`$`"),
      ]
    )
  }

  func testBlockComments() {
    AssertLexemes(
      """
      /*/ */
      func not_doc5() {}
      """,
      lexemes: [
        LexemeSpec(.funcKeyword, leading: "/*/ */\n", text: "func", trailing: " ", flags: [.isAtStartOfLine]),
        LexemeSpec(.identifier, text: "not_doc5"),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.rightParen, text: ")", trailing: " "),
        LexemeSpec(.leftBrace, text: "{"),
        LexemeSpec(.rightBrace, text: "}"),
      ]
    )

    AssertLexemes(
      """
      /* */
      /**/
      /* /* */ */
      """,
      lexemes: [
        LexemeSpec(.eof, leading: "/* */\n/**/\n/* /* */ */", text: "", flags: [.isAtStartOfLine])
      ]
    )
  }

  func testDeepTupleAccess() {
    AssertLexemes(
      "x.1.0",
      lexemes: [
        LexemeSpec(.identifier, text: "x"),
        LexemeSpec(.period, text: "."),
        LexemeSpec(.integerLiteral, text: "1"),
        LexemeSpec(.period, text: "."),
        LexemeSpec(.integerLiteral, text: "0"),
      ]
    )
  }

  func testUnicodeLiteral() {
    AssertLexemes(
      #"""
      "\u{1234}"
      """#,
      lexemes: [
        LexemeSpec(.stringLiteral, text: #""\u{1234}""#)
      ]
    )

    AssertLexemes(
      #"""
      "\u{12341234}"
      """#,
      lexemes: [
        LexemeSpec(.stringLiteral, text: #""\u{12341234}""#, flags: [.isErroneous])
      ]
    )
  }

  func testNumberLiterals() {
    AssertLexemes(
      "1234567890",
      lexemes: [
        LexemeSpec(.integerLiteral, text: "1234567890")
      ]
    )
    AssertLexemes(
      "0b1010101",
      lexemes: [
        LexemeSpec(.integerLiteral, text: "0b1010101")
      ]
    )
    AssertLexemes(
      "0xABC",
      lexemes: [
        LexemeSpec(.integerLiteral, text: "0xABC")
      ]
    )
    AssertLexemes(
      "1.0",
      lexemes: [
        LexemeSpec(.floatingLiteral, text: "1.0")
      ]
    )
    AssertLexemes(
      "1.0e10",
      lexemes: [
        LexemeSpec(.floatingLiteral, text: "1.0e10")
      ]
    )
    AssertLexemes(
      "1.0E10",
      lexemes: [
        LexemeSpec(.floatingLiteral, text: "1.0E10")
      ]
    )
    AssertLexemes(
      "0xfeed_beef",
      lexemes: [
        LexemeSpec(.integerLiteral, text: "0xfeed_beef")
      ]
    )
    AssertLexemes(
      "0xff.0p2",
      lexemes: [
        LexemeSpec(.floatingLiteral, text: "0xff.0p2")
      ]
    )
    AssertLexemes(
      "-0xff.0p2",
      lexemes: [
        LexemeSpec(.prefixOperator, text: "-"),
        LexemeSpec(.floatingLiteral, text: "0xff.0p2"),
      ]
    )
    AssertLexemes(
      "+0xff.0p2",
      lexemes: [
        LexemeSpec(.prefixOperator, text: "+"),
        LexemeSpec(.floatingLiteral, text: "0xff.0p2"),
      ]
    )
    AssertLexemes(
      "0x1.921fb4p1",
      lexemes: [
        LexemeSpec(.floatingLiteral, text: "0x1.921fb4p1")
      ]
    )
  }

  func testRawStringLiterals() {
    AssertLexemes(
      """
      ###"this is a ##"raw"## string"###
      """,
      lexemes: [
        LexemeSpec(.stringLiteral, text: ####"###"this is a ##"raw"## string"###"####)
      ]
    )

    AssertLexemes(
      """
      #"#"abc"#
      """,
      lexemes: [
        LexemeSpec(.stringLiteral, text: ####"#"#"abc"#"####)
      ]
    )

    AssertLexemes(
      """
      ###"##"abc"###
      """,
      lexemes: [
        LexemeSpec(.stringLiteral, text: ####"###"##"abc"###"####)
      ]
    )

    AssertLexemes(
      #####"""
      ##"""abc"####
      """#####,
      lexemes: [
        LexemeSpec(.stringLiteral, text: ###"##"""abc"##"###),
        LexemeSpec(.pound, text: "#"),
        LexemeSpec(.pound, text: "#"),
      ]
    )
  }

  func testShebang() {
    AssertLexemes(
      """
      #!/usr/bin/swiftc
      let x = 42
      """,
      lexemes: [
        LexemeSpec(.letKeyword, leading: "#!/usr/bin/swiftc\n", text: "let", trailing: " ", flags: [.isAtStartOfLine]),
        LexemeSpec(.identifier, text: "x", trailing: " "),
        LexemeSpec(.equal, text: "=", trailing: " "),
        LexemeSpec(.integerLiteral, text: "42"),
      ]
    )
  }

  func testDocComment() {
    AssertLexemes(
      """
      /** hello */
      var x: Int
      /* regular comment */
      """,
      lexemes: [
        LexemeSpec(.varKeyword, leading: "/** hello */\n", text: "var", trailing: " ", flags: [.isAtStartOfLine]),
        LexemeSpec(.identifier, text: "x"),
        LexemeSpec(.colon, text: ":", trailing: " "),
        LexemeSpec(.identifier, text: "Int"),
        LexemeSpec(.eof, leading: "\n/* regular comment */", text: "", flags: [.isAtStartOfLine]),
      ]
    )
  }

  func testMain() {
    AssertLexemes(
      """
      /* TestApp */
      @main struct TestApp {
        static func main() {
          print("Hello World")
        }
      }
      """,
      lexemes: [
        LexemeSpec(.atSign, leading: "/* TestApp */\n", text: "@", flags: [.isAtStartOfLine]),
        LexemeSpec(.identifier, text: "main", trailing: " "),
        LexemeSpec(.structKeyword, text: "struct", trailing: " "),
        LexemeSpec(.identifier, text: "TestApp", trailing: " "),
        LexemeSpec(.leftBrace, text: "{"),
        LexemeSpec(.staticKeyword, leading: "\n  ", text: "static", trailing: " ", flags: [.isAtStartOfLine]),
        LexemeSpec(.funcKeyword, text: "func", trailing: " "),
        LexemeSpec(.identifier, text: "main"),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.rightParen, text: ")", trailing: " "),
        LexemeSpec(.leftBrace, text: "{"),
        LexemeSpec(.identifier, leading: "\n    ", text: "print", flags: [.isAtStartOfLine]),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.stringLiteral, text: "\"Hello World\""),
        LexemeSpec(.rightParen, text: ")"),
        LexemeSpec(.rightBrace, leading: "\n  ", text: "}", flags: [.isAtStartOfLine]),
        LexemeSpec(.rightBrace, leading: "\n", text: "}", flags: [.isAtStartOfLine]),
      ]
    )
  }

  func testRegexLexing() {
    AssertLexemes(
      "/abc/",
      lexemes: [
        LexemeSpec(.regexLiteral, text: "/abc/")
      ]
    )
    AssertLexemes(
      "#/abc/#",
      lexemes: [
        LexemeSpec(.regexLiteral, text: "#/abc/#")
      ]
    )
    AssertLexemes(
      "###/abc/###",
      lexemes: [
        LexemeSpec(.regexLiteral, text: "###/abc/###")
      ]
    )
    AssertLexemes(
      """
      #/
      a
      b
      /#
      """,
      lexemes: [
        LexemeSpec(.regexLiteral, text: "#/\na\nb\n/#")
      ]
    )
    AssertLexemes(
      "#/ \na\nb\n  /#",
      lexemes: [
        LexemeSpec(.regexLiteral, text: "#/ \na\nb\n  /#")
      ]
    )
    AssertLexemes(
      "##/ \na\nb\n  /##",
      lexemes: [
        LexemeSpec(.regexLiteral, text: "##/ \na\nb\n  /##")
      ]
    )
    AssertLexemes(
      "#/abc/def/#",
      lexemes: [
        LexemeSpec(.regexLiteral, text: "#/abc/def/#")
      ]
    )
    AssertLexemes(
      "#/abc\\/#def/#",
      lexemes: [
        LexemeSpec(.regexLiteral, text: "#/abc\\/#def/#")
      ]
    )
    AssertLexemes(
      "#/abc|#def/#",
      lexemes: [
        LexemeSpec(.regexLiteral, text: "#/abc|#def/#")
      ]
    )
    AssertLexemes(
      "#/abc\n/#",
      lexemes: [
        LexemeSpec(.pound, text: "#"),
        LexemeSpec(.unspacedBinaryOperator, text: "/"),
        LexemeSpec(.identifier, text: "abc"),
        LexemeSpec(.prefixOperator, leading: "\n", text: "/", flags: [.isAtStartOfLine]),
        LexemeSpec(.pound, text: "#"),
      ]
    )
    AssertLexemes(
      "#/abc\r/#",
      lexemes: [
        LexemeSpec(.pound, text: "#"),
        LexemeSpec(.unspacedBinaryOperator, text: "/"),
        LexemeSpec(.identifier, text: "abc"),
        LexemeSpec(.prefixOperator, leading: "\r", text: "/", flags: [.isAtStartOfLine]),
        LexemeSpec(.pound, text: "#"),
      ]
    )
    AssertLexemes(
      "/a)/",
      lexemes: [
        LexemeSpec(.prefixOperator, text: "/"),
        LexemeSpec(.identifier, text: "a"),
        LexemeSpec(.rightParen, text: ")"),
        LexemeSpec(.postfixOperator, text: "/"),
      ]
    )
  }

  func testUnexpectedLexing() {
    AssertLexemes(
      "static func �() {}",
      lexemes: [
        LexemeSpec(.staticKeyword, text: "static", trailing: " "),
        LexemeSpec(.funcKeyword, text: "func", trailing: " �"),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.rightParen, text: ")", trailing: " "),
        LexemeSpec(.leftBrace, text: "{"),
        LexemeSpec(.rightBrace, text: "}"),
      ]
    )
  }

  func testBOMLexing() {
    let bom: Unicode.Scalar = "\u{feff}"
    AssertLexemes(
      "\(bom)Hello",
      lexemes: [
        LexemeSpec(.identifier, leading: "\u{feff}", text: "Hello")
      ]
    )
  }

  func testConflictLexing() {
    AssertLexemes(
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
      lexemes: [
        LexemeSpec(
          .eof,
          leading:
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
          text: "",
          flags: [.isAtStartOfLine]
        )
      ]
    )

    AssertLexemes(
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
      lexemes: [
        LexemeSpec(
          .eof,
          leading:
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
          text: "",
          flags: [.isAtStartOfLine]
        )
      ]
    )
  }

  func testUnicodeStringLiteralLexing() {
    AssertLexemes(
      #"""
      "\\)|[^\\s`!()\\[\\]{};:'\".,<>?«»“”‘’]))"
      """#,
      lexemes: [
        LexemeSpec(.stringLiteral, text: #""\\)|[^\\s`!()\\[\\]{};:'\".,<>?«»“”‘’]))""#)
      ]
    )
  }

  func testNotARegex() {
    AssertLexemes(
      "min(reduced.count / 2, chunkSize / 2)",
      lexemes: [
        LexemeSpec(.identifier, text: "min"),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.identifier, text: "reduced"),
        LexemeSpec(.period, text: "."),
        LexemeSpec(.identifier, text: "count", trailing: " "),
        LexemeSpec(.spacedBinaryOperator, text: "/", trailing: " "),
        LexemeSpec(.integerLiteral, text: "2"),
        LexemeSpec(.comma, text: ",", trailing: " "),
        LexemeSpec(.identifier, text: "chunkSize", trailing: " "),
        LexemeSpec(.spacedBinaryOperator, text: "/", trailing: " "),
        LexemeSpec(.integerLiteral, text: "2"),
        LexemeSpec(.rightParen, text: ")"),
      ]
    )
    AssertLexemes(
      """
      var x: Int {
        return 0 /
               x
      }

      ///
      """,
      lexemes: [
        LexemeSpec(.varKeyword, text: "var", trailing: " "),
        LexemeSpec(.identifier, text: "x"),
        LexemeSpec(.colon, text: ":", trailing: " "),
        LexemeSpec(.identifier, text: "Int", trailing: " "),
        LexemeSpec(.leftBrace, text: "{"),
        LexemeSpec(.returnKeyword, leading: "\n  ", text: "return", trailing: " ", flags: [.isAtStartOfLine]),
        LexemeSpec(.integerLiteral, text: "0", trailing: " "),
        LexemeSpec(.spacedBinaryOperator, text: "/"),
        LexemeSpec(.identifier, leading: "\n         ", text: "x", flags: [.isAtStartOfLine]),
        LexemeSpec(.rightBrace, leading: "\n", text: "}", flags: [.isAtStartOfLine]),
        LexemeSpec(.eof, leading: "\n\n///", text: "", flags: [.isAtStartOfLine]),
      ]
    )

    AssertLexemes(
      "n /= 2 // foo",
      lexemes: [
        LexemeSpec(.identifier, text: "n", trailing: " "),
        LexemeSpec(.spacedBinaryOperator, text: "/=", trailing: " "),
        LexemeSpec(.integerLiteral, text: "2", trailing: " // foo"),
      ]
    )

    AssertLexemes(
      "UIColor(white: 216.0/255.0, alpha: 44.0/255.0)",
      lexemes: [
        LexemeSpec(.identifier, text: "UIColor"),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.identifier, text: "white"),
        LexemeSpec(.colon, text: ":", trailing: " "),
        LexemeSpec(.floatingLiteral, text: "216.0"),
        LexemeSpec(.unspacedBinaryOperator, text: "/"),
        LexemeSpec(.floatingLiteral, text: "255.0"),
        LexemeSpec(.comma, text: ",", trailing: " "),
        LexemeSpec(.identifier, text: "alpha"),
        LexemeSpec(.colon, text: ":", trailing: " "),
        LexemeSpec(.floatingLiteral, text: "44.0"),
        LexemeSpec(.unspacedBinaryOperator, text: "/"),
        LexemeSpec(.floatingLiteral, text: "255.0"),
        LexemeSpec(.rightParen, text: ")"),
      ]
    )

    AssertLexemes(
      "#/abc|#def/",
      lexemes: [
        LexemeSpec(.pound, text: "#"),
        LexemeSpec(.unspacedBinaryOperator, text: "/"),
        LexemeSpec(.identifier, text: "abc"),
        LexemeSpec(.unspacedBinaryOperator, text: "|"),
        LexemeSpec(.pound, text: "#"),
        LexemeSpec(.identifier, text: "def"),
        LexemeSpec(.postfixOperator, text: "/"),
      ]
    )
  }

  func testUnicodeReplcementsInStream() {
    AssertLexemes(
      "() -> (\u{feff})",
      lexemes: [
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.rightParen, text: ")", trailing: " "),
        LexemeSpec(.arrow, text: "->", trailing: " "),
        LexemeSpec(.leftParen, text: "(", trailing: "\u{feff}"),
        LexemeSpec(.rightParen, text: ")"),
      ]
    )

    AssertLexemes(
      "y\u{fffe} + z",
      lexemes: [
        LexemeSpec(.identifier, text: "y", trailing: "\u{fffe} "),
        LexemeSpec(.spacedBinaryOperator, text: "+", trailing: " "),
        LexemeSpec(.identifier, text: "z"),
      ]
    )
  }

  func testOperators() {
    AssertLexemes(
      """
      myString==""
      """,
      lexemes: [
        LexemeSpec(.identifier, text: "myString"),
        LexemeSpec(.unspacedBinaryOperator, text: "=="),
        LexemeSpec(.stringLiteral, text: #""""#),
      ]
    )
  }

  func testEditorPlaceholders() {
    AssertLexemes(
      "!<#b1#> && !<#b2#>",
      lexemes: [
        LexemeSpec(.prefixOperator, text: "!"),
        LexemeSpec(.identifier, text: "<#b1#>", trailing: " "),
        LexemeSpec(.spacedBinaryOperator, text: "&&", trailing: " "),
        LexemeSpec(.prefixOperator, text: "!"),
        LexemeSpec(.identifier, text: "<#b2#>"),
      ]
    )
  }

  func testCommentAttribution() {
    AssertLexemes(
      """
      func foo() { // comment
          // new comment
          bar()
      }
      """,
      lexemes: [
        LexemeSpec(.funcKeyword, text: "func", trailing: " "),
        LexemeSpec(.identifier, text: "foo"),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.rightParen, text: ")", trailing: " "),
        LexemeSpec(.leftBrace, text: "{", trailing: " // comment"),
        LexemeSpec(
          .identifier,
          leading: """

                // new comment
                \

            """,
          text: "bar",
          flags: [.isAtStartOfLine]
        ),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.rightParen, text: ")"),
        LexemeSpec(.rightBrace, leading: "\n", text: "}", flags: [.isAtStartOfLine]),
      ]
    )
  }

  func testCommentAttribution2() {
    // Example from https://forums.swift.org/t/changing-comment-trivia-attribution-from-trailing-trivia-to-leading-trivia/50773
    AssertLexemes(
      "/*X_START*/x/*X_END*/ + /*Y_START*/y/*Y_END*/",
      lexemes: [
        LexemeSpec(.identifier, leading: "/*X_START*/", text: "x", trailing: "/*X_END*/ "),
        LexemeSpec(.spacedBinaryOperator, text: "+", trailing: " /*Y_START*/"),
        LexemeSpec(.identifier, text: "y", trailing: "/*Y_END*/"),
      ]
    )
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
}
