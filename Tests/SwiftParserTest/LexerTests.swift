import XCTest
@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser


private func lexeme(
  _ kind: RawTokenKind,
  _ wholeText: SyntaxText,
  leading: Int = 0,
  trailing: Int = 0
) -> Lexer.Lexeme {
  return Lexer.Lexeme(
    tokenKind: kind,
    flags: [.isAtStartOfLine],
    start: wholeText.baseAddress!,
    leadingTriviaLength: leading,
    textLength: wholeText.count - leading - trailing,
    trailingTriviaLength: trailing)
}

public class LexerTests: XCTestCase {
  func testIdentifiers() throws {
    var data =
    """
    Hello World
    """
    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(lexemes, [
        lexeme(.identifier, "Hello ", trailing: 1),
        lexeme(.identifier, "World"),
        lexeme(.eof, ""),
      ])
    }
  }

  func testEscapedIdentifiers() throws {
    var data =
    """
    `Hello` `World` `$`
    """
    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(lexemes, [
        lexeme(.identifier, "`Hello` ", trailing: 1),
        lexeme(.identifier, "`World` ", trailing: 1),
        lexeme(.identifier, "`$`"),
        lexeme(.eof, ""),
     ])
    }
  }

  func testBlockComments() throws {
    do {
      var data =
      """
      /*/ */
      func not_doc5() {}
      """

      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(lexemes, [
          lexeme(.funcKeyword, "/*/ */\nfunc ", leading: 7, trailing: 1),
          lexeme(.identifier, "not_doc5"),
          lexeme(.leftParen, "("),
          lexeme(.rightParen, ") ", trailing: 1),
          lexeme(.leftBrace, "{"),
          lexeme(.rightBrace, "}"),
          lexeme(.eof, ""),
        ])
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
        AssertEqualTokens(lexemes, [
          lexeme(.eof, "/* */\n/**/\n/* /* */ */", leading: 22),
        ])
      }
    }
  }

  func testDeepTupleAccess() throws {
    var data =
    #"""
    x.1.0
    """#

    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(lexemes, [
        lexeme(.identifier, "x"),
        lexeme(.period, "."),
        lexeme(.integerLiteral, "1"),
        lexeme(.period, "."),
        lexeme(.integerLiteral, "0"),
        lexeme(.eof, ""),
      ])
    }
  }

  func testUnicodeLiteral() throws {
    do {
      var data =
      #"""
      "\u{1234}"
      """#

      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(lexemes, [
          lexeme(.stringLiteral, #""\u{1234}""#),
          lexeme(.eof, ""),
        ])
      }
    }

    do {
      var data =
      #"""
      "\u{12341234}"
      """#

      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(lexemes, [
          lexeme(.unknown, #""\u{12341234}""#),
          lexeme(.eof, ""),
        ])
      }
    }
  }


  func testNumberLiterals() throws {
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
      AssertEqualTokens(lexemes, [
        lexeme(.integerLiteral, "1234567890"),
        lexeme(.integerLiteral, "\n0b1010101", leading: 1),
        lexeme(.integerLiteral, "\n0xABC", leading: 1),
        lexeme(.floatingLiteral, "\n1.0", leading: 1),
        lexeme(.floatingLiteral, "\n1.0e10", leading: 1),
        lexeme(.floatingLiteral, "\n1.0E10", leading: 1),
        lexeme(.integerLiteral, "\n0xfeed_beef", leading: 1),
        lexeme(.floatingLiteral, "\n0xff.0p2", leading: 1),
        lexeme(.prefixOperator, "\n-", leading: 1),
        lexeme(.floatingLiteral, "0xff.0p2"),
        lexeme(.prefixOperator, "\n+", leading: 1),
        lexeme(.floatingLiteral, "0xff.0p2"),
        lexeme(.floatingLiteral, "\n0x1.921fb4p1", leading: 1),
        lexeme(.eof, ""),
      ])
    }
  }

  func testRawStringLiterals() throws {
    do {
      var data =
      """
      ###"this is a ##"raw"## string"###
      """
      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(lexemes, [
          lexeme(.stringLiteral, ####"###"this is a ##"raw"## string"###"####),
          lexeme(.eof, ""),
        ])
      }
    }

    do {
      var data =
      """
      #"#"abc"#
      """
      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(lexemes, [
          lexeme(.stringLiteral, ####"#"#"abc"#"####),
          lexeme(.eof, ""),
        ])
      }
    }

    do {
      var data =
      """
      ###"##"abc"###
      """
      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(lexemes, [
          lexeme(.stringLiteral, ####"###"##"abc"###"####),
          lexeme(.eof, ""),
        ])
      }
    }

    do {
      var data =
      #####"""
      ##"""abc"####
      """#####
      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(lexemes, [
          lexeme(.stringLiteral, ###"##"""abc"##"###),
          lexeme(.pound, "#"),
          lexeme(.pound, "#"),
          lexeme(.eof, ""),
        ])
      }
    }
  }

  func testShebang() throws {
    var data =
    """
    #!/usr/bin/swiftc
    let x = 42
    """
    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(lexemes, [
        lexeme(.letKeyword, "#!/usr/bin/swiftc\nlet ", leading: 18, trailing: 1),
        lexeme(.identifier, "x ", trailing: 1),
        lexeme(.equal, "= ", trailing: 1),
        lexeme(.integerLiteral, "42"),
        lexeme(.eof, ""),
      ])
    }
  }

  func testDocComment() throws {
    var data =
    """
    /** hello */
    var x: Int
    /* regular comment */
    """
    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(lexemes, [
        lexeme(.varKeyword, "/** hello */\nvar ", leading: 13, trailing: 1),
        lexeme(.identifier, "x"),
        lexeme(.colon, ": ", trailing: 1),
        lexeme(.identifier, "Int"),
        lexeme(.eof, "\n/* regular comment */", leading: 22),
      ])
    }
  }

  func testMain() throws {
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
      AssertEqualTokens(lexemes, [
        lexeme(.atSign, "/* TestApp */\n@", leading: 14),
        lexeme(.identifier, "main ", trailing: 1),
        lexeme(.structKeyword, "struct ", trailing: 1),
        lexeme(.identifier, "TestApp ", trailing: 1),
        lexeme(.leftBrace, "{"),
        lexeme(.staticKeyword, "\n  static ", leading: 3, trailing: 1),
        lexeme(.funcKeyword, "func ", trailing: 1),
        lexeme(.identifier, "main"),
        lexeme(.leftParen, "("),
        lexeme(.rightParen, ") ", trailing: 1),
        lexeme(.leftBrace, "{"),
        lexeme(.identifier, "\n    print", leading: 5),
        lexeme(.leftParen, "("),
        lexeme(.stringLiteral, "\"Hello World\""),
        lexeme(.rightParen, ")"),
        lexeme(.rightBrace, "\n  }", leading: 3),
        lexeme(.rightBrace, "\n}", leading: 1),
        lexeme(.eof, ""),
      ])
    }
  }

  func testRegexLexing() throws {
    let fixtures: [(String, [Lexer.Lexeme])] = [
      ("/abc/", [
        lexeme(.regexLiteral, "/abc/"),
        lexeme(.eof, ""),
      ]),
      ("#/abc/#", [
        lexeme(.regexLiteral, "#/abc/#"),
        lexeme(.eof, ""),
      ]),
      ("###/abc/###", [
        lexeme(.regexLiteral, "###/abc/###"),
        lexeme(.eof, ""),
      ]),
      ("""
       #/
       a
       b
       /#
       """, [
        lexeme(.regexLiteral, "#/\na\nb\n/#"),
        lexeme(.eof, ""),
      ]),
      ("#/ \na\nb\n  /#", [
        lexeme(.regexLiteral, "#/ \na\nb\n  /#"),
        lexeme(.eof, ""),
      ]),
      ("##/ \na\nb\n  /##", [
        lexeme(.regexLiteral, "##/ \na\nb\n  /##"),
        lexeme(.eof, ""),
      ]),
      ("#/abc/def/#", [
        lexeme(.regexLiteral, "#/abc/def/#"),
        lexeme(.eof, ""),
      ]),
      ("#/abc\\/#def/#", [
        lexeme(.regexLiteral, "#/abc\\/#def/#"),
        lexeme(.eof, ""),
      ]),
      ("#/abc|#def/#", [
        lexeme(.regexLiteral, "#/abc|#def/#"),
        lexeme(.eof, ""),
      ]),
      ("#/abc\n/#", [
        lexeme(.pound, "#"),
        lexeme(.unspacedBinaryOperator, "/"),
        lexeme(.identifier, "abc"),
        lexeme(.prefixOperator, "\n/", leading: 1),
        lexeme(.pound, "#"),
        lexeme(.eof, ""),
      ]),
      ("#/abc\r/#", [
        lexeme(.pound, "#"),
        lexeme(.unspacedBinaryOperator, "/"),
        lexeme(.identifier, "abc"),
        lexeme(.prefixOperator, "\r/", leading: 1),
        lexeme(.pound, "#"),
        lexeme(.eof, ""),
      ]),
      ("/a)/", [
        lexeme(.prefixOperator, "/"),
        lexeme(.identifier, "a"),
        lexeme(.rightParen, ")"),
        lexeme(.postfixOperator, "/"),
        lexeme(.eof, ""),
      ]),
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
      AssertEqualTokens(lexemes, [
        lexeme(.staticKeyword, "static ", trailing: 1),
        lexeme(.funcKeyword, "func �", trailing: 4),
        lexeme(.leftParen, "("),
        lexeme(.rightParen, ") ", trailing: 1),
        lexeme(.leftBrace, "{"),
        lexeme(.rightBrace, "}"),
        lexeme(.eof, ""),
      ])
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
      AssertEqualTokens(lexemes, [
        lexeme(.identifier, "\u{feff}Hello", leading: 3),
        lexeme(.eof, "")
      ])
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
        AssertEqualTokens(lexemes, [
          lexeme(.eof, """
                 // diff3-style conflict markers

                 <<<<<<< HEAD:conflict_markers.swift // expected-error {{source control conflict marker in source file}}
                 var a : String = "A"
                 var b : String = "b"
                 =======
                 var a : String = "a"
                 var b : String = "B"
                 >>>>>>> 18844bc65229786b96b89a9fc7739c0fc897905e:conflict_markers.swift
                 """, leading: 300)
        ])
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
        AssertEqualTokens(lexemes, [
          lexeme(.eof, """
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

                 """, leading: 204),
        ])
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
      AssertEqualTokens(lexemes, [
        lexeme(.stringLiteral, #""\\)|[^\\s`!()\\[\\]{};:'\".,<>?«»“”‘’]))""#),
        lexeme(.eof, ""),
      ])
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
      AssertEqualTokens(lexemes, [
        lexeme(.identifier, "min"),
        lexeme(.leftParen, "("),
        lexeme(.identifier, "reduced"),
        lexeme(.period, "."),
        lexeme(.identifier, "count ", trailing: 1),
        lexeme(.spacedBinaryOperator, "/ ", trailing: 1),
        lexeme(.integerLiteral, "2"),
        lexeme(.comma, ", ", trailing: 1),
        lexeme(.identifier, "chunkSize ", trailing: 1),
        lexeme(.spacedBinaryOperator, "/ ", trailing: 1),
        lexeme(.integerLiteral, "2"),
        lexeme(.rightParen, ")"),
        lexeme(.eof, ""),
      ])
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
      AssertEqualTokens(lexemes, [
        lexeme(.varKeyword, "var ", trailing: 1),
        lexeme(.identifier, "x"),
        lexeme(.colon, ": ", trailing: 1),
        lexeme(.identifier, "Int ", trailing: 1),
        lexeme(.leftBrace, "{"),
        lexeme(.returnKeyword, "\n  return ", leading: 3, trailing: 1),
        lexeme(.integerLiteral, "0 ", trailing: 1),
        lexeme(.spacedBinaryOperator, "/", trailing: 0),
        lexeme(.identifier, "\n         x", leading: 10),
        lexeme(.rightBrace, "\n}", leading: 1),
        lexeme(.eof, "\n\n///", leading: 5),
      ])
    }

    do {
      var data =
      """
      n /= 2 // foo
      """
      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(lexemes, [
          lexeme(.identifier, "n ", trailing: 1),
          lexeme(.spacedBinaryOperator, "/= ", trailing: 1),
          lexeme(.integerLiteral, "2 ", trailing: 1),
          lexeme(.eof, "// foo", leading: 6),
        ])
      }
    }

    do {
      var data =
      """
      UIColor(white: 216.0/255.0, alpha: 44.0/255.0)
      """
      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(lexemes, [
          lexeme(.identifier, "UIColor"),
          lexeme(.leftParen, "("),
          lexeme(.identifier, "white"),
          lexeme(.colon, ": ", trailing: 1),
          lexeme(.floatingLiteral, "216.0"),
          lexeme(.unspacedBinaryOperator, "/"),
          lexeme(.floatingLiteral, "255.0"),
          lexeme(.comma, ", ", trailing: 1),
          lexeme(.identifier, "alpha"),
          lexeme(.colon, ": ", trailing: 1),
          lexeme(.floatingLiteral, "44.0"),
          lexeme(.unspacedBinaryOperator, "/"),
          lexeme(.floatingLiteral, "255.0"),
          lexeme(.rightParen, ")"),
          lexeme(.eof, ""),
        ])
      }
    }

    do {
      var data =
      """
      #/abc|#def/
      """
      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(lexemes, [
          lexeme(.pound, "#"),
          lexeme(.unspacedBinaryOperator, "/"),
          lexeme(.identifier, "abc"),
          lexeme(.unspacedBinaryOperator, "|"),
          lexeme(.pound, "#"),
          lexeme(.identifier, "def"),
          lexeme(.postfixOperator, "/"),
          lexeme(.eof, ""),
        ])
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
        AssertEqualTokens(lexemes, [
          lexeme(.leftParen, "("),
          lexeme(.rightParen, ") ", trailing: 1),
          lexeme(.arrow, "-> ", trailing: 1),
          lexeme(.leftParen, "(\u{feff}", trailing: 3),
          lexeme(.rightParen, ")"),
          lexeme(.eof, ""),
        ])
      }
    }

    do {
      var data =
      """
      y\u{fffe} + z
      """
      data.withUTF8 { buf in
        let lexemes = Lexer.lex(buf)
        AssertEqualTokens(lexemes, [
          lexeme(.identifier, "y\u{fffe} ", trailing: 4),
          lexeme(.spacedBinaryOperator, "+ ", trailing: 1),
          lexeme(.identifier, "z"),
          lexeme(.eof, ""),
        ])
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
      AssertEqualTokens(lexemes, [
        lexeme(.identifier, "myString"),
        lexeme(.unspacedBinaryOperator, "=="),
        lexeme(.stringLiteral, #""""#),
        lexeme(.eof, ""),
      ])
    }
  }

  func testEditorPlaceholders() {
    var data =
    """
    !<#b1#> && !<#b2#>
    """
    data.withUTF8 { buf in
      let lexemes = Lexer.lex(buf)
      AssertEqualTokens(lexemes, [
        lexeme(.prefixOperator, "!"),
        lexeme(.identifier, "<#b1#> ", trailing: 1),
        lexeme(.spacedBinaryOperator, "&& ", trailing: 1),
        lexeme(.prefixOperator, "!"),
        lexeme(.identifier, "<#b2#>"),
        lexeme(.eof, ""),
      ])
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
