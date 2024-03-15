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

@_spi(RawSyntax) @_spi(Testing) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax
import XCTest

fileprivate func lex(_ sourceBytes: [UInt8], body: ([Lexer.Lexeme]) throws -> Void) rethrows {
  let lookaheadTracker = UnsafeMutablePointer<LookaheadTracker>.allocate(capacity: 1)
  defer {
    lookaheadTracker.deallocate()
  }
  lookaheadTracker.initialize(to: LookaheadTracker())
  try sourceBytes.withUnsafeBufferPointer { (buf) in
    var lexemes = [Lexer.Lexeme]()
    for token in Lexer.tokenize(buf, from: 0, lookaheadTracker: lookaheadTracker) {
      lexemes.append(token)

      if token.rawTokenKind == .endOfFile {
        break
      }
    }
    try body(lexemes)
  }
}

/// `LexemeSpec` heavily relies on string literals to represent the expected
/// values for trivia and text. While this is good for most cases, string
/// literals can't contain invalid UTF-8. Thus, we need a different assert
/// function working on byte arrays to test source code containing invalid UTF-8.
fileprivate func assertRawBytesLexeme(
  _ lexeme: Lexer.Lexeme,
  kind: RawTokenKind,
  leadingTrivia: [UInt8] = [],
  text: [UInt8],
  trailingTrivia: [UInt8] = [],
  error: SwiftSyntax.TokenDiagnostic? = nil,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  XCTAssertEqual(lexeme.rawTokenKind, kind, file: file, line: line)
  leadingTrivia.withUnsafeBufferPointer { leadingTrivia in
    let leadingTriviaText = SyntaxText(buffer: SyntaxArenaAllocatedBufferPointer(leadingTrivia))
    XCTAssertEqual(lexeme.leadingTriviaText, leadingTriviaText, file: file, line: line)
  }
  text.withUnsafeBufferPointer { textBuffer in
    let text = SyntaxText(buffer: SyntaxArenaAllocatedBufferPointer(textBuffer))
    XCTAssertEqual(lexeme.tokenText, text, file: file, line: line)
  }
  trailingTrivia.withUnsafeBufferPointer { trailingTrivia in
    let trailingTriviaText = SyntaxText(buffer: SyntaxArenaAllocatedBufferPointer(trailingTrivia))
    XCTAssertEqual(lexeme.trailingTriviaText, trailingTriviaText, file: file, line: line)
  }
  XCTAssertEqual(lexeme.diagnostic, error, file: file, line: line)
}

class LexerTests: ParserTestCase {
  func testIdentifiers() {
    assertLexemes(
      "Hello World",
      lexemes: [
        LexemeSpec(.identifier, text: "Hello", trailing: " "),
        LexemeSpec(.identifier, text: "World"),
      ]
    )
  }

  func testEscapedIdentifiers() {
    assertLexemes(
      "`Hello` `World` `$`",
      lexemes: [
        LexemeSpec(.identifier, text: "`Hello`", trailing: " "),
        LexemeSpec(.identifier, text: "`World`", trailing: " "),
        LexemeSpec(.identifier, text: "`$`"),
      ]
    )
  }

  func testBlockComments() {
    assertLexemes(
      """
      /*/ */
      func not_doc5() {}
      """,
      lexemes: [
        LexemeSpec(.keyword, leading: "/*/ */\n", text: "func", trailing: " ", flags: [.isAtStartOfLine]),
        LexemeSpec(.identifier, text: "not_doc5"),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.rightParen, text: ")", trailing: " "),
        LexemeSpec(.leftBrace, text: "{"),
        LexemeSpec(.rightBrace, text: "}"),
      ]
    )

    assertLexemes(
      """
      /* */
      /**/
      /* /* */ */
      """,
      lexemes: [
        LexemeSpec(.endOfFile, leading: "/* */\n/**/\n/* /* */ */", text: "", flags: [.isAtStartOfLine])
      ]
    )
  }

  func testDeepTupleAccess() {
    assertLexemes(
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
    assertLexemes(
      #"""
      "\u{1234}"
      """#,
      lexemes: [
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: #"\u{1234}"#),
        LexemeSpec(.stringQuote, text: #"""#),
      ]
    )

    assertLexemes(
      #"""
      "1️⃣\u{12341234}"
      """#,
      lexemes: [
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: #"\u{12341234}"#, diagnostic: "invalid escape sequence in literal"),
        LexemeSpec(.stringQuote, text: #"""#),
      ]
    )
  }

  func testNumberLiterals() {
    assertLexemes(
      "1234567890",
      lexemes: [
        LexemeSpec(.integerLiteral, text: "1234567890")
      ]
    )
    assertLexemes(
      "0b1010101",
      lexemes: [
        LexemeSpec(.integerLiteral, text: "0b1010101")
      ]
    )
    assertLexemes(
      "0xABC",
      lexemes: [
        LexemeSpec(.integerLiteral, text: "0xABC")
      ]
    )
    assertLexemes(
      "1.0",
      lexemes: [
        LexemeSpec(.floatLiteral, text: "1.0")
      ]
    )
    assertLexemes(
      "1.0e10",
      lexemes: [
        LexemeSpec(.floatLiteral, text: "1.0e10")
      ]
    )
    assertLexemes(
      "1.0E10",
      lexemes: [
        LexemeSpec(.floatLiteral, text: "1.0E10")
      ]
    )
    assertLexemes(
      "0xfeed_beef",
      lexemes: [
        LexemeSpec(.integerLiteral, text: "0xfeed_beef")
      ]
    )
    assertLexemes(
      "0xff.0p2",
      lexemes: [
        LexemeSpec(.floatLiteral, text: "0xff.0p2")
      ]
    )
    assertLexemes(
      "-0xff.0p2",
      lexemes: [
        LexemeSpec(.prefixOperator, text: "-"),
        LexemeSpec(.floatLiteral, text: "0xff.0p2"),
      ]
    )
    assertLexemes(
      "+0xff.0p2",
      lexemes: [
        LexemeSpec(.prefixOperator, text: "+"),
        LexemeSpec(.floatLiteral, text: "0xff.0p2"),
      ]
    )
    assertLexemes(
      "0x1.921fb4p1",
      lexemes: [
        LexemeSpec(.floatLiteral, text: "0x1.921fb4p1")
      ]
    )
  }

  func testRawStringLiterals() {
    assertLexemes(
      """
      ###"this is a ##"raw"## string"###
      """,
      lexemes: [
        LexemeSpec(.rawStringPoundDelimiter, text: "###"),
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: ###"this is a ##"raw"## string"###),
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.rawStringPoundDelimiter, text: "###"),
      ]
    )

    assertLexemes(
      """
      #"#"abc"#
      """,
      lexemes: [
        LexemeSpec(.rawStringPoundDelimiter, text: "#"),
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: #"#"abc"#),
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.rawStringPoundDelimiter, text: "#"),
      ]
    )

    assertLexemes(
      """
      ###"##"abc"###
      """,
      lexemes: [
        LexemeSpec(.rawStringPoundDelimiter, text: "###"),
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: #"##"abc"#),
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.rawStringPoundDelimiter, text: "###"),
      ]
    )

    assertLexemes(
      #####"""
      ##"""abc"####
      """#####,
      lexemes: [
        LexemeSpec(.rawStringPoundDelimiter, text: "##"),
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: ###"""abc"###),
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.rawStringPoundDelimiter, text: "####"),
      ]
    )
  }

  func testShebang() {
    assertLexemes(
      """
      #!/usr/bin/swiftc
      let x = 42
      """,
      lexemes: [
        LexemeSpec(.shebang, text: "#!/usr/bin/swiftc"),
        LexemeSpec(.keyword, leading: "\n", text: "let", trailing: " ", flags: [.isAtStartOfLine]),
        LexemeSpec(.identifier, text: "x", trailing: " "),
        LexemeSpec(.equal, text: "=", trailing: " "),
        LexemeSpec(.integerLiteral, text: "42"),
      ]
    )
  }

  func testDocComment() {
    assertLexemes(
      """
      /** hello */
      var x: Int
      /* regular comment */
      """,
      lexemes: [
        LexemeSpec(.keyword, leading: "/** hello */\n", text: "var", trailing: " ", flags: [.isAtStartOfLine]),
        LexemeSpec(.identifier, text: "x"),
        LexemeSpec(.colon, text: ":", trailing: " "),
        LexemeSpec(.identifier, text: "Int"),
        LexemeSpec(.endOfFile, leading: "\n/* regular comment */", text: "", flags: [.isAtStartOfLine]),
      ]
    )
  }

  func testMain() {
    assertLexemes(
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
        LexemeSpec(.keyword, text: "struct", trailing: " "),
        LexemeSpec(.identifier, text: "TestApp", trailing: " "),
        LexemeSpec(.leftBrace, text: "{"),
        LexemeSpec(.keyword, leading: "\n  ", text: "static", trailing: " ", flags: [.isAtStartOfLine]),
        LexemeSpec(.keyword, text: "func", trailing: " "),
        LexemeSpec(.identifier, text: "main"),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.rightParen, text: ")", trailing: " "),
        LexemeSpec(.leftBrace, text: "{"),
        LexemeSpec(.identifier, leading: "\n    ", text: "print", flags: [.isAtStartOfLine]),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: "Hello World"),
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.rightParen, text: ")"),
        LexemeSpec(.rightBrace, leading: "\n  ", text: "}", flags: [.isAtStartOfLine]),
        LexemeSpec(.rightBrace, leading: "\n", text: "}", flags: [.isAtStartOfLine]),
      ]
    )
  }

  func testRegexLexing() {
    assertLexemes(
      "/abc/",
      lexemes: [
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: "abc"),
        LexemeSpec(.regexSlash, text: "/"),
      ]
    )
    assertLexemes(
      "#/abc/#",
      lexemes: [
        LexemeSpec(.regexPoundDelimiter, text: "#"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: "abc"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexPoundDelimiter, text: "#"),
      ]
    )
    assertLexemes(
      "###/abc/###",
      lexemes: [
        LexemeSpec(.regexPoundDelimiter, text: "###"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: "abc"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexPoundDelimiter, text: "###"),
      ]
    )
    assertLexemes(
      """
      #/
      a
      b
      /#
      """,
      lexemes: [
        LexemeSpec(.regexPoundDelimiter, text: "#"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: "\na\nb\n"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexPoundDelimiter, text: "#"),
      ]
    )
    assertLexemes(
      "#/ \na\nb\n  /#",
      lexemes: [
        LexemeSpec(.regexPoundDelimiter, text: "#"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: " \na\nb\n  "),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexPoundDelimiter, text: "#"),
      ]
    )
    assertLexemes(
      "##/ \na\nb\n  /##",
      lexemes: [
        LexemeSpec(.regexPoundDelimiter, text: "##"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: " \na\nb\n  "),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexPoundDelimiter, text: "##"),
      ]
    )
    assertLexemes(
      "#/abc/def/#",
      lexemes: [
        LexemeSpec(.regexPoundDelimiter, text: "#"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: "abc/def"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexPoundDelimiter, text: "#"),
      ]
    )
    assertLexemes(
      "#/abc\\/#def/#",
      lexemes: [
        LexemeSpec(.regexPoundDelimiter, text: "#"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: "abc\\/#def"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexPoundDelimiter, text: "#"),
      ]
    )
    assertLexemes(
      "#/abc|#def/#",
      lexemes: [
        LexemeSpec(.regexPoundDelimiter, text: "#"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: "abc|#def"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexPoundDelimiter, text: "#"),
      ]
    )
    assertLexemes(
      "#/abc\n/#",
      lexemes: [
        LexemeSpec(.regexPoundDelimiter, text: "#"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: "abc"),
        LexemeSpec(.prefixOperator, leading: "\n", text: "/", flags: [.isAtStartOfLine]),
        LexemeSpec(.pound, text: "#"),
      ]
    )
    assertLexemes(
      "#/abc\r/#",
      lexemes: [
        LexemeSpec(.regexPoundDelimiter, text: "#"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: "abc"),
        LexemeSpec(.prefixOperator, leading: "\r", text: "/", flags: [.isAtStartOfLine]),
        LexemeSpec(.pound, text: "#"),
      ]
    )
    assertLexemes(
      "/a)/",
      lexemes: [
        LexemeSpec(.prefixOperator, text: "/"),
        LexemeSpec(.identifier, text: "a"),
        LexemeSpec(.rightParen, text: ")"),
        LexemeSpec(.postfixOperator, text: "/"),
      ]
    )
    // Make sure if we have an unterminated extended literal, we stop at the
    // first newline
    assertLexemes(
      """
      #/
      abc
      """,
      lexemes: [
        LexemeSpec(.regexPoundDelimiter, text: "#"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: ""),
        LexemeSpec(.identifier, leading: "\n", text: "abc", flags: .isAtStartOfLine),
      ]
    )
    // Check that we can split operators okay.
    assertLexemes(
      "!/abc/",
      lexemes: [
        LexemeSpec(.prefixOperator, text: "!"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: "abc"),
        LexemeSpec(.regexSlash, text: "/"),
      ]
    )
    assertLexemes(
      "!^/abc/",
      lexemes: [
        LexemeSpec(.prefixOperator, text: "!^"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: "abc"),
        LexemeSpec(.regexSlash, text: "/"),
      ]
    )
    assertLexemes(
      "!#/abc/#",
      lexemes: [
        LexemeSpec(.prefixOperator, text: "!"),
        LexemeSpec(.regexPoundDelimiter, text: "#"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: "abc"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexPoundDelimiter, text: "#"),
      ]
    )
    // Make sure we don't lex this as a regex.
    assertLexemes(
      """
      func /^ () { y/ }
      """,
      lexemes: [
        LexemeSpec(.keyword, text: "func", trailing: " "),
        LexemeSpec(.binaryOperator, text: "/^", trailing: " "),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.rightParen, text: ")", trailing: " "),
        LexemeSpec(.leftBrace, text: "{", trailing: " "),
        LexemeSpec(.identifier, text: "y"),
        LexemeSpec(.postfixOperator, text: "/", trailing: " "),
        LexemeSpec(.rightBrace, text: "}"),
      ]
    )
    assertLexemes(
      "^^/!*/",
      lexemes: [
        LexemeSpec(.prefixOperator, text: "^^"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: "!*"),
        LexemeSpec(.regexSlash, text: "/"),
      ]
    )
    assertLexemes(
      "/!*/",
      lexemes: [
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: "!*"),
        LexemeSpec(.regexSlash, text: "/"),
      ]
    )

    // Regex literal, even though it's in operator position.
    assertLexemes(
      "x /y/",
      lexemes: [
        LexemeSpec(.identifier, text: "x", trailing: " "),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: "y"),
        LexemeSpec(.regexSlash, text: "/"),
      ]
    )
    assertLexemes(
      "x /.^ y/",
      lexemes: [
        LexemeSpec(.identifier, text: "x", trailing: " "),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: ".^ y"),
        LexemeSpec(.regexSlash, text: "/"),
      ]
    )

    // Comments, not regex literals
    assertLexemes(
      "^//",
      lexemes: [
        LexemeSpec(.binaryOperator, text: "^", trailing: "//")
      ]
    )
    assertLexemes(
      "^1️⃣/*/",
      lexemes: [
        LexemeSpec(.binaryOperator, text: "^", trailing: "/*/", diagnostic: "unterminated '/*' comment")
      ]
    )
  }

  func testUnexpectedLexing() {
    assertLexemes(
      "static func 1️⃣�() {}",
      lexemes: [
        LexemeSpec(.keyword, text: "static", trailing: " "),
        LexemeSpec(.keyword, text: "func", trailing: " �", diagnostic: "invalid character in source file"),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.rightParen, text: ")", trailing: " "),
        LexemeSpec(.leftBrace, text: "{"),
        LexemeSpec(.rightBrace, text: "}"),
      ]
    )
  }

  func testBOMLexing() {
    let bom: Unicode.Scalar = "\u{feff}"
    assertLexemes(
      "\(bom)Hello",
      lexemes: [
        LexemeSpec(.identifier, leading: "\u{feff}", text: "Hello")
      ]
    )
  }

  func testConflictLexing() {
    assertLexemes(
      """
      // diff3-style conflict markers

      1️⃣<<<<<<< HEAD:conflict_markers.swift // expected-error {{source control conflict marker in source file}}
      var a : String = "A"
      var b : String = "b"
      =======
      var a : String = "a"
      var b : String = "B"
      >>>>>>> 18844bc65229786b96b89a9fc7739c0fc897905e:conflict_markers.swift
      """,
      lexemes: [
        LexemeSpec(
          .endOfFile,
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
          diagnostic: "source control conflict marker in source file",
          flags: [.isAtStartOfLine]
        )
      ]
    )

    assertLexemes(
      """
      // Perforce-style conflict markers

      1️⃣>>>> ORIGINAL
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
          .endOfFile,
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
          diagnostic: "source control conflict marker in source file",
          flags: [.isAtStartOfLine]
        )
      ]
    )
  }

  func testUnicodeStringLiteralLexing() {
    assertLexemes(
      #"""
      "\\)|[^\\s`!()\\[\\]{};:'\".,<>?«»“”‘’]))"
      """#,
      lexemes: [
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: #"\\)|[^\\s`!()\\[\\]{};:'\".,<>?«»“”‘’]))"#),
        LexemeSpec(.stringQuote, text: #"""#),
      ]
    )
  }

  func testNotARegex() {
    assertLexemes(
      "min(reduced.count / 2, chunkSize / 2)",
      lexemes: [
        LexemeSpec(.identifier, text: "min"),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.identifier, text: "reduced"),
        LexemeSpec(.period, text: "."),
        LexemeSpec(.identifier, text: "count", trailing: " "),
        LexemeSpec(.binaryOperator, text: "/", trailing: " "),
        LexemeSpec(.integerLiteral, text: "2"),
        LexemeSpec(.comma, text: ",", trailing: " "),
        LexemeSpec(.identifier, text: "chunkSize", trailing: " "),
        LexemeSpec(.binaryOperator, text: "/", trailing: " "),
        LexemeSpec(.integerLiteral, text: "2"),
        LexemeSpec(.rightParen, text: ")"),
      ]
    )
    assertLexemes(
      """
      var x: Int {
        return 0 /
               x
      }

      ///
      """,
      lexemes: [
        LexemeSpec(.keyword, text: "var", trailing: " "),
        LexemeSpec(.identifier, text: "x"),
        LexemeSpec(.colon, text: ":", trailing: " "),
        LexemeSpec(.identifier, text: "Int", trailing: " "),
        LexemeSpec(.leftBrace, text: "{"),
        LexemeSpec(.keyword, leading: "\n  ", text: "return", trailing: " ", flags: [.isAtStartOfLine]),
        LexemeSpec(.integerLiteral, text: "0", trailing: " "),
        LexemeSpec(.binaryOperator, text: "/"),
        LexemeSpec(.identifier, leading: "\n         ", text: "x", flags: [.isAtStartOfLine]),
        LexemeSpec(.rightBrace, leading: "\n", text: "}", flags: [.isAtStartOfLine]),
        LexemeSpec(.endOfFile, leading: "\n\n///", text: "", flags: [.isAtStartOfLine]),
      ]
    )

    assertLexemes(
      "n /= 2 // foo",
      lexemes: [
        LexemeSpec(.identifier, text: "n", trailing: " "),
        LexemeSpec(.binaryOperator, text: "/=", trailing: " "),
        LexemeSpec(.integerLiteral, text: "2", trailing: " // foo"),
      ]
    )

    assertLexemes(
      "UIColor(white: 216.0/255.0, alpha: 44.0/255.0)",
      lexemes: [
        LexemeSpec(.identifier, text: "UIColor"),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.identifier, text: "white"),
        LexemeSpec(.colon, text: ":", trailing: " "),
        LexemeSpec(.floatLiteral, text: "216.0"),
        LexemeSpec(.binaryOperator, text: "/"),
        LexemeSpec(.floatLiteral, text: "255.0"),
        LexemeSpec(.comma, text: ",", trailing: " "),
        LexemeSpec(.identifier, text: "alpha"),
        LexemeSpec(.colon, text: ":", trailing: " "),
        LexemeSpec(.floatLiteral, text: "44.0"),
        LexemeSpec(.binaryOperator, text: "/"),
        LexemeSpec(.floatLiteral, text: "255.0"),
        LexemeSpec(.rightParen, text: ")"),
      ]
    )

    assertLexemes(
      "#/abc|#def/",
      lexemes: [
        LexemeSpec(.regexPoundDelimiter, text: "#"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: "abc|#def"),
        LexemeSpec(.regexSlash, text: "/"),
      ]
    )

    assertLexemes(
      "#/abc|#def//",
      lexemes: [
        LexemeSpec(.regexPoundDelimiter, text: "#"),
        LexemeSpec(.regexSlash, text: "/"),
        LexemeSpec(.regexLiteralPattern, text: "abc|#def/"),
        LexemeSpec(.regexSlash, text: "/"),
      ]
    )
    // This is an operator, not a regex.
    assertLexemes(
      "lhs /==/ rhs",
      lexemes: [
        LexemeSpec(.identifier, text: "lhs", trailing: " "),
        LexemeSpec(.binaryOperator, text: "/==/", trailing: " "),
        LexemeSpec(.identifier, text: "rhs"),
      ]
    )
  }

  func testUnicodeReplcementsInStream() {
    assertLexemes(
      "() -> (\u{feff})",
      lexemes: [
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.rightParen, text: ")", trailing: " "),
        LexemeSpec(.arrow, text: "->", trailing: " "),
        LexemeSpec(.leftParen, text: "(", trailing: "\u{feff}"),
        LexemeSpec(.rightParen, text: ")"),
      ]
    )

    assertLexemes(
      "y1️⃣\u{fffe} + z",
      lexemes: [
        LexemeSpec(.identifier, text: "y", trailing: "\u{fffe} ", diagnostic: "invalid character in source file"),
        LexemeSpec(.binaryOperator, text: "+", trailing: " "),
        LexemeSpec(.identifier, text: "z"),
      ]
    )
  }

  func testOperators() {
    assertLexemes(
      """
      myString==""
      """,
      lexemes: [
        LexemeSpec(.identifier, text: "myString"),
        LexemeSpec(.binaryOperator, text: "=="),
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: ""),
        LexemeSpec(.stringQuote, text: #"""#),
      ]
    )
  }

  func testEditorPlaceholders() {
    assertLexemes(
      "!1️⃣<#b1#> && !2️⃣<#b2#>",
      lexemes: [
        LexemeSpec(.prefixOperator, text: "!"),
        LexemeSpec(.identifier, text: "<#b1#>", trailing: " ", errorLocationMarker: "1️⃣", diagnostic: "editor placeholder in source file"),
        LexemeSpec(.binaryOperator, text: "&&", trailing: " "),
        LexemeSpec(.prefixOperator, text: "!"),
        LexemeSpec(.identifier, text: "<#b2#>", errorLocationMarker: "2️⃣", diagnostic: "editor placeholder in source file"),
      ]
    )

    assertLexemes(
      "1️⃣<##>",
      lexemes: [
        LexemeSpec(.identifier, text: "<##>", trailing: "", diagnostic: "editor placeholder in source file")
      ]
    )

    assertLexemes(
      "let 1️⃣<#name#> = 2️⃣<#value#>",
      lexemes: [
        LexemeSpec(.keyword, text: "let", trailing: " "),
        LexemeSpec(.identifier, text: "<#name#>", trailing: " ", errorLocationMarker: "1️⃣", diagnostic: "editor placeholder in source file"),
        LexemeSpec(.equal, text: "=", trailing: " "),
        LexemeSpec(.identifier, text: "<#value#>", errorLocationMarker: "2️⃣", diagnostic: "editor placeholder in source file"),
      ]
    )
  }

  func testCommentAttribution() {
    assertLexemes(
      """
      func foo() { // comment
          // new comment
          bar()
      }
      """,
      lexemes: [
        LexemeSpec(.keyword, text: "func", trailing: " "),
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
    assertLexemes(
      "/*X_START*/x/*X_END*/ + /*Y_START*/y/*Y_END*/",
      lexemes: [
        LexemeSpec(.identifier, leading: "/*X_START*/", text: "x", trailing: "/*X_END*/ "),
        LexemeSpec(.binaryOperator, text: "+", trailing: " /*Y_START*/"),
        LexemeSpec(.identifier, text: "y", trailing: "/*Y_END*/"),
      ]
    )
  }

  func testNumericLiteralDiagnostics() {
    assertLexemes(
      " 0x1.01️⃣",
      lexemes: [LexemeSpec(.integerLiteral, leading: " ", text: "0x1.0", diagnostic: "hexadecimal floating point literal must end with an exponent")]
    )
    assertLexemes(
      " 0x1p1️⃣_",
      lexemes: [LexemeSpec(.floatLiteral, leading: " ", text: "0x1p_", diagnostic: "'_' is not a valid first character in floating point exponent")]
    )
    assertLexemes(
      "01️⃣QWERTY",
      lexemes: [LexemeSpec(.integerLiteral, text: "0QWERTY", diagnostic: "'Q' is not a valid digit in integer literal")]
    )
    assertLexemes(
      "0b1️⃣QWERTY",
      lexemes: [LexemeSpec(.integerLiteral, text: "0bQWERTY", diagnostic: "'Q' is not a valid binary digit (0 or 1) in integer literal")]
    )
    assertLexemes(
      "0x1️⃣QWERTY",
      lexemes: [LexemeSpec(.integerLiteral, text: "0xQWERTY", diagnostic: "'Q' is not a valid hexadecimal digit (0-9, A-F) in integer literal")]
    )
    assertLexemes(
      "0o1️⃣QWERTY",
      lexemes: [LexemeSpec(.integerLiteral, text: "0oQWERTY", diagnostic: "'Q' is not a valid octal digit (0-7) in integer literal")]
    )
    assertLexemes(
      "1.0e+1️⃣QWERTY",
      lexemes: [LexemeSpec(.floatLiteral, text: "1.0e+QWERTY", diagnostic: "'Q' is not a valid digit in floating point exponent")]
    )
    assertLexemes(
      "0x1p+1️⃣QWERTY",
      lexemes: [LexemeSpec(.floatLiteral, text: "0x1p+QWERTY", diagnostic: "'Q' is not a valid digit in floating point exponent")]
    )
  }

  func testInvalidCharacterSpanningMultipleBytes() {
    assertLexemes(
      "121️⃣😡",
      lexemes: [
        LexemeSpec(.integerLiteral, text: "12😡", diagnostic: "'😡' is not a valid digit in integer literal")
      ]
    )
  }

  func testBadNumericLiteralDigits() {
    assertLexemes(
      "01️⃣a1234567",
      lexemes: [LexemeSpec(.integerLiteral, text: "0a1234567", diagnostic: "'a' is not a valid digit in integer literal")]
    )
    assertLexemes(
      "01231️⃣A5678",
      lexemes: [LexemeSpec(.integerLiteral, text: "0123A5678", diagnostic: "'A' is not a valid digit in integer literal")]
    )
    assertLexemes(
      "0b101️⃣20101",
      lexemes: [LexemeSpec(.integerLiteral, text: "0b1020101", diagnostic: "'2' is not a valid binary digit (0 or 1) in integer literal")]
    )
    assertLexemes(
      "0o13571️⃣864",
      lexemes: [LexemeSpec(.integerLiteral, text: "0o1357864", diagnostic: "'8' is not a valid octal digit (0-7) in integer literal")]
    )
    assertLexemes(
      "0x147AD1️⃣G0",
      lexemes: [LexemeSpec(.integerLiteral, text: "0x147ADG0", diagnostic: "'G' is not a valid hexadecimal digit (0-9, A-F) in integer literal")]
    )
  }

  func testStringLiteralWithBlockCommentStart() {
    assertLexemes(
      """
      "/*"
      """,
      lexemes: [
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: "/*"),
        LexemeSpec(.stringQuote, text: #"""#),
      ]
    )
  }

  func testBOMAtStartOfFile() throws {
    let sourceBytes: [UInt8] = [0xef, 0xbb, 0xbf]
    lex(sourceBytes) { lexemes in
      guard lexemes.count == 1 else {
        return XCTFail("Expected 1 lexeme, got \(lexemes.count)")
      }

      assertRawBytesLexeme(
        lexemes[0],
        kind: .endOfFile,
        leadingTrivia: sourceBytes,
        text: []
      )
    }
  }

  func testBOMInTheMiddleOfIdentifier() throws {
    let sourceBytes: [UInt8] = [UInt8(ascii: "a"), 0xef, 0xbb, 0xbf, UInt8(ascii: "b")]
    lex(sourceBytes) { lexemes in
      guard lexemes.count == 2 else {
        return XCTFail("Expected 2 lexemes, got \(lexemes.count)")
      }

      assertRawBytesLexeme(
        lexemes[0],
        kind: .identifier,
        text: sourceBytes
      )
    }
  }

  func testBOMAsLeadingTriviaInSourceFile() throws {
    let sourceBytes: [UInt8] = [UInt8(ascii: "1"), UInt8(ascii: " "), UInt8(ascii: "+"), UInt8(ascii: " "), 0xef, 0xbb, 0xbf, UInt8(ascii: "2")]
    lex(sourceBytes) { lexemes in
      guard lexemes.count == 4 else {
        return XCTFail("Expected 4 lexemes, got \(lexemes.count)")
      }

      assertRawBytesLexeme(
        lexemes[1],
        kind: .binaryOperator,
        text: [UInt8(ascii: "+")],
        trailingTrivia: [UInt8(ascii: " "), 0xef, 0xbb, 0xbf]
      )
    }
  }

  func testInvalidUtf8() {
    let sourceBytes: [UInt8] = [0xef, 0xfb, 0xbd, 0x0a]

    lex(sourceBytes) { lexemes in
      guard lexemes.count == 1 else {
        return XCTFail("Expected 1 lexeme, got \(lexemes.count)")
      }
      assertRawBytesLexeme(
        lexemes[0],
        kind: .endOfFile,
        leadingTrivia: sourceBytes,
        text: [],
        error: TokenDiagnostic(.invalidUtf8, byteOffset: 0)
      )
    }
  }

  func testInvalidUtf8_2() {
    let sourceBytes: [UInt8] = [0xfd]

    lex(sourceBytes) { lexemes in
      guard lexemes.count == 1 else {
        return XCTFail("Expected 1 lexeme, got \(lexemes.count)")
      }
      assertRawBytesLexeme(
        lexemes[0],
        kind: .endOfFile,
        leadingTrivia: sourceBytes,
        text: [],
        error: TokenDiagnostic(.invalidUtf8, byteOffset: 0)
      )
    }
  }

  func testInvalidUtf8_3() {
    let sourceBytes: [UInt8] = [0xfd, 0x41]  // 0x41 == "A"

    lex(sourceBytes) { lexemes in
      guard lexemes.count == 2 else {
        return XCTFail("Expected 2 lexemes, got \(lexemes.count)")
      }
      assertRawBytesLexeme(
        lexemes[0],
        kind: .identifier,
        leadingTrivia: [0xfd],
        text: [0x41],
        error: TokenDiagnostic(.invalidUtf8, byteOffset: 0)
      )
    }
  }

  func testUTF16Surrogates1() {
    // U+D800 <= (UTF16 surrogates code point) <= U+DFFF
    let sourceBytes: [UInt8] = [0xED, 0xA0, 0x80]  // The bytes represent the code point U+D800

    lex(sourceBytes) { lexemes in
      guard lexemes.count == 1 else {
        return XCTFail("Expected 1 lexemes, got \(lexemes.count)")
      }
      assertRawBytesLexeme(
        lexemes[0],
        kind: .endOfFile,
        leadingTrivia: [0xED, 0xA0, 0x80],
        text: [],
        error: TokenDiagnostic(.invalidUtf8, byteOffset: 0)
      )
    }
  }

  func testUTF16Surrogates2() {
    let sourceBytes: [UInt8] = [0xED, 0xBF, 0xBF]  // The bytes represent the code point U+DFFF

    lex(sourceBytes) { lexemes in
      guard lexemes.count == 1 else {
        return XCTFail("Expected 1 lexemes, got \(lexemes.count)")
      }
      assertRawBytesLexeme(
        lexemes[0],
        kind: .endOfFile,
        leadingTrivia: [0xED, 0xBF, 0xBF],
        text: [],
        error: TokenDiagnostic(.invalidUtf8, byteOffset: 0)
      )
    }
  }

  func testInvalidUTF8RegexLiteral() {
    let slashByte = UInt8(UnicodeScalar("/").value)
    let sourceBytes: [UInt8] = [slashByte, 0xfd, slashByte]

    lex(sourceBytes) { lexemes in
      guard lexemes.count == 4 else {
        return XCTFail("Expected 4 lexemes, got \(lexemes.count)")
      }
      assertRawBytesLexeme(
        lexemes[1],
        kind: .regexLiteralPattern,
        leadingTrivia: [],
        text: [0xfd],
        error: TokenDiagnostic(.invalidUtf8, byteOffset: 1)
      )
    }
  }

  func testInterpolatedString() {
    assertLexemes(
      #"""
      "\("message")"
      """#,
      lexemes: [
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: ""),
        LexemeSpec(.backslash, text: "\\"),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: "message"),
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.rightParen, text: ")"),
        LexemeSpec(.stringSegment, text: ""),
        LexemeSpec(.stringQuote, text: #"""#),
      ]
    )
  }

  func testBackslashInFrontOfStringInterpolation() {
    assertLexemes(
      #"""
      "\"\(text)"
      """#,
      lexemes: [
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: #"\""#),
        LexemeSpec(.backslash, text: "\\"),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.identifier, text: "text"),
        LexemeSpec(.rightParen, text: ")"),
        LexemeSpec(.stringSegment, text: ""),
        LexemeSpec(.stringQuote, text: #"""#),
      ]
    )
  }

  func testUnterminatedSingleLineStringLiteral() {
    assertLexemes(
      ##"""
      "bar

      """##,
      lexemes: [
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: "bar"),
        LexemeSpec(.endOfFile, leading: "\n", text: "", flags: [.isAtStartOfLine]),
      ]
    )
  }

  func testUnclosedStringInterpolationWithNewline() {
    assertLexemes(
      #"""
      "\(

      """#,
      lexemes: [
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: ""),
        LexemeSpec(.backslash, text: "\\"),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.stringSegment, text: ""),
        LexemeSpec(.endOfFile, leading: "\n", text: "", flags: .isAtStartOfLine),
      ]
    )
  }

  func testNewlineInInterpolationOfSingleLineString() {
    assertLexemes(
      #"""
      "test \(label:
      foo)"
      """#,
      lexemes: [
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: "test "),
        LexemeSpec(.backslash, text: "\\"),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.identifier, text: "label"),
        LexemeSpec(.colon, text: ":"),
        LexemeSpec(.stringSegment, text: ""),
        LexemeSpec(.identifier, leading: "\n", text: "foo", flags: .isAtStartOfLine),
        LexemeSpec(.rightParen, text: ")"),
        LexemeSpec(.stringQuote, text: #"""#),
      ]
    )
  }

  func testMultilineStringLiteral() {
    assertLexemes(
      #"""
        """
        line 1
        line 2
        """
      """#,
      lexemes: [
        LexemeSpec(.multilineStringQuote, leading: "  ", text: #"""""#, trailing: "\n"),
        LexemeSpec(.stringSegment, text: "  line 1\n", flags: .isAtStartOfLine),
        LexemeSpec(.stringSegment, text: "  line 2\n", flags: .isAtStartOfLine),
        LexemeSpec(.stringSegment, text: "  ", flags: .isAtStartOfLine),
        LexemeSpec(.multilineStringQuote, text: #"""""#),
      ]
    )

    assertLexemes(
      #"""
        """
        line 1 \
        line 2
        """
      """#,
      lexemes: [
        LexemeSpec(.multilineStringQuote, leading: "  ", text: #"""""#, trailing: "\n"),
        LexemeSpec(.stringSegment, text: "  line 1 ", trailing: "\\\n", flags: .isAtStartOfLine),
        LexemeSpec(.stringSegment, text: "  line 2\n", flags: .isAtStartOfLine),
        LexemeSpec(.stringSegment, text: "  ", flags: .isAtStartOfLine),
        LexemeSpec(.multilineStringQuote, text: #"""""#),
      ]
    )
  }

  func testMultiDigitTupleAccess() {
    assertLexemes(
      "x.13.1",
      lexemes: [
        LexemeSpec(.identifier, text: "x"),
        LexemeSpec(.period, text: "."),
        LexemeSpec(.integerLiteral, text: "13"),
        LexemeSpec(.period, text: "."),
        LexemeSpec(.integerLiteral, text: "1"),
      ]
    )
  }

  func testFloatingPointNumberAfterRangeOperator() {
    assertLexemes(
      "0.1...0.2",
      lexemes: [
        LexemeSpec(.floatLiteral, text: "0.1"),
        LexemeSpec(.binaryOperator, text: "..."),
        LexemeSpec(.floatLiteral, text: "0.2"),
      ]
    )
  }

  func testUnterminatedFloatLiteral() {
    assertLexemes(
      "0.",
      lexemes: [
        LexemeSpec(.integerLiteral, text: "0"),
        LexemeSpec(.period, text: "."),
      ]
    )
  }

  func testNullCharacterInSourceFile() {
    assertLexemes(
      "var x = 11️⃣\0\nvar y = 2",
      lexemes: [
        LexemeSpec(.keyword, text: "var", trailing: " "),
        LexemeSpec(.identifier, text: "x", trailing: " "),
        LexemeSpec(.equal, text: "=", trailing: " "),
        LexemeSpec(.integerLiteral, text: "1", trailing: "\0", diagnostic: "nul character embedded in middle of file"),
        LexemeSpec(.keyword, leading: "\n", text: "var", trailing: " ", flags: .isAtStartOfLine),
        LexemeSpec(.identifier, text: "y", trailing: " "),
        LexemeSpec(.equal, text: "=", trailing: " "),
        LexemeSpec(.integerLiteral, text: "2", trailing: ""),
      ]
    )
  }

  func testNullCharacterInStringLiteral() {
    assertLexemes(
      """
      "1️⃣\0"
      """,
      lexemes: [
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: "\0", diagnostic: "nul character embedded in middle of file"),
        LexemeSpec(.stringQuote, text: #"""#),
      ]
    )
  }

  func testInvalidUtf8InStringLiteral() {
    lex([UInt8(ascii: #"""#), 0xef, UInt8(ascii: #"""#)]) { lexemes in
      guard lexemes.count == 4 else {
        return XCTFail("Expected 4 lexemes")
      }

      assertRawBytesLexeme(
        lexemes[1],
        kind: .stringSegment,
        text: [0xef],
        error: TokenDiagnostic(.invalidUtf8, byteOffset: 0)
      )
    }
  }

  func testInvalidUnicodeEscapeSequence() {
    assertLexemes(
      #"""
      "1️⃣\u"
      """#,
      lexemes: [
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: #"\u"#, diagnostic: #"expected hexadecimal code in \u{...} escape sequence"#),
        LexemeSpec(.stringQuote, text: #"""#),
      ]
    )

    assertLexemes(
      #"""
      "1️⃣\u{"
      """#,
      lexemes: [
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: #"\u{"#, diagnostic: #"expected '}' in \u{...} escape sequence"#),
        LexemeSpec(.stringQuote, text: #"""#),
      ]
    )

    assertLexemes(
      #"""
      "1️⃣\u{12"
      """#,
      lexemes: [
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: #"\u{12"#, diagnostic: #"expected '}' in \u{...} escape sequence"#),
        LexemeSpec(.stringQuote, text: #"""#),
      ]
    )

    assertLexemes(
      #"""
      "1️⃣\u{}"
      """#,
      lexemes: [
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: #"\u{}"#, diagnostic: #"\u{...} escape sequence expects between 1 and 8 hex digits"#),
        LexemeSpec(.stringQuote, text: #"""#),
      ]
    )

    assertLexemes(
      #"""
      "1️⃣\u{hello}"
      """#,
      lexemes: [
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: #"\u{hello}"#, diagnostic: #"expected '}' in \u{...} escape sequence"#),
        LexemeSpec(.stringQuote, text: #"""#),
      ]
    )

    assertLexemes(
      #"""
      "1️⃣\u{fffffffff}"
      """#,
      lexemes: [
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: #"\u{fffffffff}"#, diagnostic: #"\u{...} escape sequence expects between 1 and 8 hex digits"#),
        LexemeSpec(.stringQuote, text: #"""#),
      ]
    )
  }

  func testCloseBlockCommentWithoutOpen() {
    assertLexemes(
      """
      1️⃣*/
      """,
      lexemes: [
        LexemeSpec(.unknown, text: "*/", diagnostic: "unexpected end of block comment")
      ]
    )

    assertLexemes(
      """
      /**/1️⃣*/
      """,
      lexemes: [
        LexemeSpec(.unknown, leading: "/**/", text: "*/", diagnostic: "unexpected end of block comment")
      ]
    )

    assertLexemes(
      """
      /**/a1️⃣*/
      """,
      lexemes: [
        LexemeSpec(.identifier, leading: "/**/", text: "a"),
        LexemeSpec(.unknown, text: "*/", diagnostic: "unexpected end of block comment"),
      ]
    )
  }

  func testCurlyQuotes() {
    assertLexemes(
      """
      a 1️⃣“curly string” b
      """,
      lexemes: [
        LexemeSpec(.identifier, text: "a", trailing: " "),
        LexemeSpec(.identifier, text: "“curly string”", trailing: " ", diagnostic: #"unicode curly quote found; use '"' instead"#),
        LexemeSpec(.identifier, text: "b"),
      ]
    )
  }

  func testInvalidIdentifierStart() {
    // Verify that U+0330 (combining tilde below) is a valid identifier continuation
    assertLexemes(
      "a\u{0330}",
      lexemes: [
        LexemeSpec(.identifier, text: "a\u{0330}")
      ]
    )

    assertLexemes(
      "\u{0330}",
      lexemes: [
        LexemeSpec(.identifier, text: "\u{0330}", errorLocationMarker: "START", diagnostic: "an identifier cannot begin with this character")
      ]
    )
  }

  func testNonBreakingSpace() {
    assertLexemes(
      "a 1️⃣\u{a0} b",
      lexemes: [
        LexemeSpec(.identifier, text: "a", trailing: " \u{a0} ", diagnostic: "non-breaking space (U+00A0) used instead of regular space"),
        LexemeSpec(.identifier, text: "b"),
      ]
    )
  }

  func testHexLiteralWithoutNumbers() {
    assertLexemes(
      "0x1️⃣",
      lexemes: [
        LexemeSpec(.integerLiteral, text: "0x", diagnostic: "expected hexadecimal digit (0-9, A-F) in integer literal")
      ]
    )

    assertLexemes(
      "0x1️⃣ ",
      lexemes: [
        LexemeSpec(.integerLiteral, text: "0x", trailing: " ", diagnostic: "expected hexadecimal digit (0-9, A-F) in integer literal")
      ]
    )
  }

  func testUnprintableAsciiCharactersInStringLiteral() {
    assertLexemes(
      """
      "1️⃣\u{7}"
      """,
      lexemes: [
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: "\u{7}", diagnostic: "unprintable ASCII character found in source file"),
        LexemeSpec(.stringQuote, text: #"""#),
      ]
    )
  }

  func testLexerErrorOverridesLexerWarning() {
    // Make sure we output the error about the malformed hex literal instead of
    // the warning about the non-breaking whitespace.
    assertLexemes(
      "\u{a0}0x1️⃣r",
      lexemes: [
        LexemeSpec(.integerLiteral, leading: "\u{a0}", text: "0xr", diagnostic: "'r' is not a valid hexadecimal digit (0-9, A-F) in integer literal")
      ]
    )
  }

  func testUnterminatedBlockComment() {
    assertLexemes(
      "1️⃣/*",
      lexemes: [
        LexemeSpec(.endOfFile, leading: "/*", text: "", diagnostic: "unterminated '/*' comment")
      ]
    )
  }

  func testSlashStartSlash() {
    assertLexemes(
      "1️⃣/*/",
      lexemes: [
        LexemeSpec(.endOfFile, leading: "/*/", text: "", diagnostic: "unterminated '/*' comment")
      ]
    )
  }

  func testNulCharacterInSourceFile() {
    assertParse(
      "let a = 1️⃣\u{0}1",
      diagnostics: [
        DiagnosticSpec(message: "nul character embedded in middle of file", severity: .warning)
      ]
    )
  }

  func testUnicodeContainTheEdgeContinuationByte() {
    // A continuation byte must be in the range greater than or
    // equal to 0x80 and less than or equal to 0xBF

    // À(0xC3 0x80), 㗀(0xE3 0x97 0x80), 🀀(0xF0 0x9F 0x80 0x80),
    // ÿ(0xC3 0xBF), 俿(0xE4 0xBF 0xBF), 𐐿(0xF0 0x90 0x90 0xBF)
    assertLexemes(
      "À 㗀 🀀 ÿ 俿 𐐿",
      lexemes: [
        LexemeSpec(.identifier, text: "À", trailing: " "),
        LexemeSpec(.identifier, text: "㗀", trailing: " "),
        LexemeSpec(.identifier, text: "🀀", trailing: " "),
        LexemeSpec(.identifier, text: "ÿ", trailing: " "),
        LexemeSpec(.identifier, text: "俿", trailing: " "),
        LexemeSpec(.identifier, text: "𐐿"),
      ]
    )
  }

  func testNestedUnterminatedStringInterpolations() {
    assertLexemes(
      #"""
      "\("\(

      """#,
      lexemes: [
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: ""),
        LexemeSpec(.backslash, text: #"\"#),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.stringQuote, text: #"""#),
        LexemeSpec(.stringSegment, text: ""),
        LexemeSpec(.backslash, text: #"\"#),
        LexemeSpec(.leftParen, text: "("),
        LexemeSpec(.stringSegment, text: ""),
        LexemeSpec(.stringSegment, text: ""),
        LexemeSpec(.endOfFile, leading: "\n", text: "", flags: [.isAtStartOfLine]),
      ]
    )
  }
}
