//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(RawSyntax) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax
import XCTest

final class RegexLiteralTests: ParserTestCase {
  func testForwardSlash1() {
    assertParse(
      #"""
      /(?<identifier>[[:alpha:]]\w*) = (?<hex>[0-9A-F]+)/
      """#
    )
  }

  func testForwardSlash2() {
    assertParse(
      """
      postfix func /(lhs: Int) -> Int {1/}
      """
    )
  }

  func testEmpty() {
    assertParse("#//#")
  }

  func testExtraneous1() {
    assertParse(
      #"""
      #//#1️⃣#
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "too many '#' characters in closing delimiter",
          fixIts: ["remove extraneous delimiters"]
        )
      ],
      fixedSource: "#//#"
    )
  }
  func testExtraneous2() {
    assertParse(
      """
      #/abc/#1️⃣#
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "too many '#' characters in closing delimiter",
          fixIts: ["remove extraneous delimiters"]
        )
      ],
      fixedSource: "#/abc/#"
    )
  }

  func testUnterminated1() {
    assertParse(
      #"""
      #1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in macro expansion", fixIts: ["insert identifier"])
      ],
      fixedSource: #"""
        #<#identifier#>
        """#
    )
  }

  func testUnterminated2() {
    assertParse(
      #"""
      ℹ️/1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '/' to end regex literal",
          notes: [NoteSpec(message: "to match this opening '/'")],
          fixIts: ["insert '/'"]
        )
      ],
      fixedSource: #"""
        //
        """#
    )
  }

  func testUnterminated3() {
    assertParse(
      #"""
      /#1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in macro expansion", fixIts: ["insert identifier"])
      ],
      fixedSource: #"""
        /#<#identifier#>
        """#
    )
  }

  func testUnterminated4() {
    assertParse(
      #"""
      #/1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected '/#' to end regex literal", fixIts: ["insert '/#'"])
      ],
      fixedSource: #"""
        #//#
        """#
    )
  }

  func testUnterminated5() {
    assertParse(
      #"""
      ℹ️#//1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '#' to end regex literal",
          notes: [NoteSpec(message: "to match this opening '#'")],
          fixIts: ["insert '#'"]
        )
      ],
      fixedSource: #"""
        #//#
        """#
    )
  }

  func testUnterminated6() {
    assertParse(
      #"""
      ℹ️#///1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '#' to end regex literal",
          notes: [NoteSpec(message: "to match this opening '#'")],
          fixIts: ["insert '#'"]
        )
      ],
      fixedSource: #"""
        #///#
        """#
    )
  }

  func testUnterminated7() {
    assertParse(
      #"""
      ℹ️#/#1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected '/#' to end regex literal", fixIts: ["insert '/#'"])
      ],
      fixedSource: #"""
        #/#/#
        """#
    )
  }

  func testUnterminated8() {
    assertParse(
      #"""
      #/##1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected '/#' to end regex literal", fixIts: ["insert '/#'"])
      ],
      fixedSource: #"""
        #/##/#
        """#
    )
  }

  func testUnterminated9() {
    assertParse(
      #"""
      ℹ️#/##/1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '#' to end regex literal",
          notes: [NoteSpec(message: "to match this opening '#'")],
          fixIts: ["insert '#'"]
        )
      ],
      fixedSource: #"""
        #/##/#
        """#
    )
  }

  func testUnterminated10() {
    assertParse(
      #"""
      ##/##/#1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "expected additional '#' characters in closing delimiter",
          fixIts: ["insert additional closing '#' delimiters"]
        )
      ],
      fixedSource: "##/##/##"
    )
  }

  func testUnterminated11() {
    assertParse(
      #"""
      ##/###1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected '/##' to end regex literal", fixIts: ["insert '/##'"])
      ],
      fixedSource: "##/###/##"
    )
  }

  func testUnterminated12() {
    assertParse(
      #"""
      #/\/#1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected '/#' to end regex literal", fixIts: ["insert '/#'"])
      ],
      fixedSource: #"#/\/#/#"#
    )
  }

  func testUnterminated13() {
    assertParse(
      #"""
      ##/abc/#def1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected '/##' to end regex literal", fixIts: ["insert '/##'"])
      ],
      fixedSource: "##/abc/#def/##"
    )
  }

  func testUnterminated14() {
    assertParse(
      #"""
      ##/abc/def#1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected '/##' to end regex literal", fixIts: ["insert '/##'"])
      ],
      fixedSource: "##/abc/def#/##"
    )
  }

  func testTerminated1() {
    assertParse(
      #"""
      #//#
      """#
    )
  }

  func testTerminated2() {
    assertParse(
      #"""
      #///#
      """#
    )
  }

  func testTerminated3() {
    assertParse(
      #"""
      #/#//#
      """#
    )
  }

  func testTerminated4() {
    assertParse(
      #"""
      ##/##/##
      """#
    )
  }

  func testTerminated5() {
    assertParse(
      #"""
      #/\/#/#
      """#
    )
  }

  func testTerminated6() {
    assertParse(
      #"""
      #/\//#
      """#
    )
  }

  func testTerminated7() {
    assertParse(
      #"""
      #/\\/#
      """#
    )
  }

  func testUnprintable1() {
    assertParse(
      """
      /1️⃣\u{7F}/
      """,
      diagnostics: [
        DiagnosticSpec(message: "unprintable ASCII character found in source file")
      ]
    )
  }

  func testUnprintable2() {
    assertParse(
      """
      #/1️⃣\u{7F}/#
      """,
      diagnostics: [
        DiagnosticSpec(message: "unprintable ASCII character found in source file")
      ]
    )
  }

  func testMultiline1() {
    assertParse(
      """
      #/
      abc1️⃣/#
      """,
      diagnostics: [
        DiagnosticSpec(message: "multi-line regex closing delimiter must appear on new line")
      ]
    )
  }

  func testMultiline2() {
    assertParse(
      """
      #/abc1️⃣
      /#2️⃣
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '/#' to end regex literal", fixIts: ["insert '/#'"]),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected identifier in macro expansion",
          fixIts: ["insert identifier"]
        ),
      ],
      fixedSource: """
        #/abc/#
        /#<#identifier#>
        """
    )
  }

  func testMultiline3() {
    assertParse(
      """
      #/abc1️⃣
          \t \t /#2️⃣
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '/#' to end regex literal", fixIts: ["insert '/#'"]),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected identifier in macro expansion",
          fixIts: ["insert identifier"]
        ),
      ],
      fixedSource: """
        #/abc/#
            \t \t /#<#identifier#>
        """
    )
  }

  func testMultiline4() {
    assertParse(
      """
      #/
       abc
          \t \t /#
      """
    )
  }

  func testMultiline5() {
    assertParse(
      """
      #/
      #1️⃣/#
      """,
      diagnostics: [
        DiagnosticSpec(message: "multi-line regex closing delimiter must appear on new line")
      ]
    )
  }

  func testOpeningSpace1() {
    assertParse(
      """
      /1️⃣ a/
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "bare slash regex literal may not start with space",
          fixIts: [
            "convert to extended regex literal with '#'",
            #"insert '\'"#,
          ]
        )
      ],
      fixItsApplications: [
        .optIn(
          applyFixIts: ["convert to extended regex literal with '#'"],
          fixedSource: """
            #/ a/#
            """
        ),
        .optIn(
          applyFixIts: [#"insert '\'"#],
          fixedSource: #"""
            /\ a/
            """#
        ),
      ]
    )
  }

  func testOpeningSpace2() {
    assertParse(
      """
      let x = /1️⃣ a/
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "bare slash regex literal may not start with space",
          fixIts: [
            "convert to extended regex literal with '#'",
            #"insert '\'"#,
          ]
        )
      ],
      fixItsApplications: [
        .optIn(
          applyFixIts: ["convert to extended regex literal with '#'"],
          fixedSource: """
            let x = #/ a/#
            """
        ),
        .optIn(
          applyFixIts: [#"insert '\'"#],
          fixedSource: #"""
            let x = /\ a/
            """#
        ),
      ]
    )
  }

  func testOpeningSpace3() {
    assertParse(
      """
      #/ a/#
      """
    )
  }

  func testClosingSpace1() {
    assertParse(
      """
      /a /1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression after operator", fixIts: ["insert expression"])
      ],
      fixedSource: """
        /a / <#expression#>
        """
    )
  }

  func testClosingSpace2() {
    assertParse(
      """
      let x = /a /1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression after operator", fixIts: ["insert expression"])
      ],
      fixedSource: """
        let x = /a / <#expression#>
        """
    )
  }

  func testClosingSpace3() {
    assertParse(
      """
      #/a /#
      """
    )
  }

  func testClosingSpace4() {
    assertParse(
      """
      /,1️⃣ /
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "bare slash regex literal may not end with space",
          fixIts: ["convert to extended regex literal with '#'"]
        )
      ],
      fixedSource: """
        #/, /#
        """
    )
  }

  func testClosingSpace5() {
    assertParse(
      """
      let x = /,1️⃣ /
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "bare slash regex literal may not end with space",
          fixIts: ["convert to extended regex literal with '#'"]
        )
      ],
      fixedSource: """
        let x = #/, /#
        """
    )
  }

  func testOpeningAndClosingSpace1() {
    assertParse(
      """
      /1️⃣   /
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "bare slash regex literal may not start with space",
          fixIts: ["convert to extended regex literal with '#'"]
        )
      ],
      fixedSource: """
        #/   /#
        """
    )
  }

  func testOpeningAndClosingSpace2() {
    assertParse(
      """
      x += /1️⃣   /
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "bare slash regex literal may not start with space",
          fixIts: ["convert to extended regex literal with '#'"]
        )
      ],
      fixedSource: """
        x += #/   /#
        """
    )
  }

  func testOpeningAndClosingSpace3() {
    assertParse(
      """
      #/  /#
      """
    )
  }

  func testOpeningAndClosingSpace4() {
    assertParse(
      """
      /1️⃣ /
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "bare slash regex literal may not start with space",
          fixIts: [
            "convert to extended regex literal with '#'",
            #"insert '\'"#,
          ]
        )
      ],
      fixItsApplications: [
        .optIn(
          applyFixIts: ["convert to extended regex literal with '#'"],
          fixedSource: """
            #/ /#
            """
        ),
        .optIn(
          applyFixIts: [#"insert '\'"#],
          fixedSource: #"""
            /\ /
            """#
        ),
      ]
    )
  }

  func testOpeningAndClosingSpace5() {
    assertParse(
      """
      let x = /1️⃣ /
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "bare slash regex literal may not start with space",
          fixIts: [
            "convert to extended regex literal with '#'",
            #"insert '\'"#,
          ]
        )
      ],
      fixItsApplications: [
        .optIn(
          applyFixIts: ["convert to extended regex literal with '#'"],
          fixedSource: """
            let x = #/ /#
            """
        ),
        .optIn(
          applyFixIts: [#"insert '\'"#],
          fixedSource: #"""
            let x = /\ /
            """#
        ),
      ]
    )
  }

  func testOpeningAndClosingSpace6() {
    assertParse(
      """
      #/ /#
      """
    )
  }

  func testSingleLineTabChar() {
    // We currently only keep track of one lexer error, so only diagnose the first.
    assertParse(
      """
      #/1️⃣\t\t/#
      """,
      diagnostics: [
        DiagnosticSpec(message: "unprintable ASCII character found in source file")
      ]
    )
  }

  func testBinOpDisambiguation1() {
    assertParse(
      """
      x /^ y ^/ z
      """
    )
  }

  func testBinOpDisambiguation2() {
    assertParse(
      """
      x /^ y/
      """
    )
  }

  func testBinOpDisambiguation3() {
    assertParse(
      """
      x !/^ y/
      """
    )
  }

  func testBinOpDisambiguation4() {
    assertParse(
      """
      x !/^ y !/ z
      """
    )
  }

  func testBinOpDisambiguation5() {
    assertParse(
      """
      try? /^ x/
      """
    )
  }

  func testBinOpDisambiguation6() {
    assertParse(
      """
      try? /^ x ^/
      """
    )
  }

  func testBinOpDisambiguation7() {
    assertParse(
      """
      try! /^ x/
      """
    )
  }

  func testBinOpDisambiguation8() {
    assertParse(
      """
      try? /^ x ^/
      """
    )
  }

  func testBinOpDisambiguation9() {
    assertParse(
      """
      x < /^ }}x/
      """
    )
  }

  func testBinOpDisambiguation10() {
    assertParse(
      """
      { /^ }}x/ }
      """
    )
  }

  func testBinOpDisambiguation11() {
    assertParse(
      """
      ( /^ }}x/ )
      """
    )
  }

  func testBinOpDisambiguation12() {
    assertParse(
      """
      [ /^ }}x/ ]
      """
    )
  }

  func testBinOpDisambiguation13() {
    assertParse(
      """
      foo(&/^ }}x/)
      """
    )
  }

  func testBinOpDisambiguation14() {
    assertParse(
      """
      x; /^ }}x/
      """
    )
  }

  func testBinOpDisambiguation15() {
    assertParse(
      """
      [0 : /^ }}x/]
      """
    )
  }

  func testBinOpDisambiguation16() {
    assertParse(
      """
      (0, /^ }}x/)
      """
    )
  }

  func testBinOpDisambiguation17() {
    assertParse(
      """
      x^ /^ x/
      """
    )
  }

  func testBinOpDisambiguation18() {
    assertParse(
      """
      x! /^ x/
      """
    )
  }

  func testBinOpDisambiguation19() {
    assertParse(
      """
      x? /^ x/
      """
    )
  }

  func testBinOpDisambiguation20() {
    assertParse(
      """
      x > /^ }}x/
      """
    )
  }

  func testBinOpDisambiguation21() {
    assertParse(
      """
      {} /^ x/
      """
    )
  }

  func testBinOpDisambiguation22() {
    assertParse(
      """
      () /^ x/
      """
    )
  }

  func testBinOpDisambiguation23() {
    assertParse(
      """
      [] /^ x/
      """
    )
  }

  func testBinOpDisambiguation24() {
    assertParse(
      """
      x... /^ x/
      """
    )
  }

  func testBinOpDisambiguation25() {
    assertParse(
      """
      x.1️⃣ /^ x/
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected name in member access", fixIts: ["insert name"])
      ],
      fixedSource: """
        x.<#identifier#> /^ x/
        """
    )
  }

  func testBinOpDisambiguation26() {
    assertParse(
      """
      #1️⃣ /^ x/
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in macro expansion", fixIts: ["insert identifier"])
      ],
      fixedSource: """
        #<#identifier#> /^ x/
        """
    )
  }

  func testBinOpDisambiguation27() {
    assertParse(
      """
      `x` /^ x/
      """
    )
  }

  func testBinOpDisambiguation28() {
    // FIXME: The diagnostic should be one character back
    assertParse(
      #"""
      \1️⃣ /^ x/
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected root in key path", fixIts: ["insert root"])
      ],
      fixedSource: #"""
        \<#type#> /^ x/
        """#
    )
  }

  func testBinOpDisambiguation29() {
    assertParse(
      """
      x /^ x/
      """
    )
  }

  func testBinOpDisambiguation30() {
    assertParse(
      """
      true /^ x/
      """
    )
  }

  func testBinOpDisambiguation31() {
    assertParse(
      """
      false /^ x/
      """
    )
  }

  func testBinOpDisambiguation32() {
    assertParse(
      """
      try /^ }}x/
      """
    )
  }

  func testBinOpDisambiguation33() {
    assertParse(
      """
      x as Any /^ x/
      """
    )
  }

  func testBinOpDisambiguation34() {
    assertParse(
      """
      nil /^ x/
      """
    )
  }

  func testBinOpDisambiguation35() {
    assertParse(
      """
      .none /^ x/
      """
    )
  }

  func testBinOpDisambiguation36() {
    assertParse(
      """
      .objc /^ x/
      """
    )
  }

  func testBinOpDisambiguation37() {
    assertParse(
      """
      P.Protocol /^ x/
      """
    )
  }

  func testBinOpDisambiguation38() {
    assertParse(
      """
      self /^ x/
      """
    )
  }

  func testBinOpDisambiguation39() {
    assertParse(
      """
      Self /^ x/
      """
    )
  }

  func testBinOpDisambiguation40() {
    assertParse(
      """
      super /^ x/
      """
    )
  }

  func testBinOpDisambiguation41() {
    // await is a contextual keyword, so we can't assume it must be a regex.
    assertParse(
      """
      await 1️⃣/^ x/
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in 'await' expression", fixIts: ["insert expression"])
      ],
      fixedSource: """
        await <#expression#> /^ x/
        """
    )
  }

  func testBinOpDisambiguation42() {
    // await is a contextual keyword, so we can't assume it must be a regex.
    assertParse(
      """
      ^await /^ x/
      """
    )
  }

  func testBinOpDisambiguation43() {
    assertParse(
      """
      x ? /^ }}x/ : /x/
      """
    )
  }

  func testBinOpDisambiguation44() {
    assertParse(
      """
      x ? /x/ : /^ }}x/
      """
    )
  }

  func testBinOpDisambiguation45() {
    assertParse(
      """
      0 /^ x/
      """
    )
  }

  func testBinOpDisambiguation46() {
    assertParse(
      """
      0.1 /^ x/
      """
    )
  }

  func testBinOpDisambiguation47() {
    assertParse(
      """
      #if /^ }}x/
      #endif
      """
    )
  }

  func testBinOpDisambiguation48() {
    assertParse(
      """
      #if true
      #else
      /^ }}x/
      #endif
      """
    )
  }

  func testBinOpDisambiguation49() {
    assertParse(
      """
      #if true
      #elseif /^ }}x/
      #endif
      """
    )
  }

  func testBinOpDisambiguation50() {
    assertParse(
      """
      #if true
      #endif
      /^ }}x/
      """
    )
  }

  func testBinOpDisambiguation51() {
    // Unapplied operators, not regex.
    assertParse(
      """
      foo(a: /, /)
      """,
      substructure: LabeledExprListSyntax([
        .init(
          label: "a",
          colon: .colonToken(),
          expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/")),
          trailingComma: .commaToken()
        ),
        .init(
          expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/"))
        ),
      ])
    )
  }

  func testBinOpDisambiguation52() {
    // Unapplied operators, not regex.
    assertParse(
      """
      foo(a, /, /)
      """,
      substructure: LabeledExprListSyntax([
        .init(
          expression: DeclReferenceExprSyntax(baseName: "a"),
          trailingComma: .commaToken()
        ),
        .init(
          expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/")),
          trailingComma: .commaToken()
        ),
        .init(
          expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/"))
        ),
      ])
    )
  }

  func testBinOpDisambiguation53() {
    // Unapplied operators, not regex.
    assertParse(
      """
      foo(a, ^/, /)
      """,
      substructure: LabeledExprListSyntax([
        .init(
          expression: DeclReferenceExprSyntax(baseName: "a"),
          trailingComma: .commaToken()
        ),
        .init(
          expression: DeclReferenceExprSyntax(baseName: .binaryOperator("^/")),
          trailingComma: .commaToken()
        ),
        .init(
          expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/"))
        ),
      ])
    )
  }

  func testBinOpDisambiguation54() {
    // Unapplied operators, not regex.
    assertParse(
      """
      foo(a: ^/, /)
      """,
      substructure: LabeledExprListSyntax([
        .init(
          label: "a",
          colon: .colonToken(),
          expression: DeclReferenceExprSyntax(baseName: .binaryOperator("^/")),
          trailingComma: .commaToken()
        ),
        .init(
          expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/"))
        ),
      ])
    )
  }

  func testBinOpDisambiguation55() {
    // Unapplied operators, not regex.
    assertParse(
      """
      foo(^/, /)
      """,
      substructure: LabeledExprListSyntax([
        .init(
          expression: DeclReferenceExprSyntax(baseName: .binaryOperator("^/")),
          trailingComma: .commaToken()
        ),
        .init(
          expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/"))
        ),
      ])
    )
  }

  func testBinOpDisambiguation56() {
    // Unapplied operators, not regex.
    assertParse(
      """
      (^/, /)
      """,
      substructure: LabeledExprListSyntax([
        .init(
          expression: DeclReferenceExprSyntax(baseName: .binaryOperator("^/")),
          trailingComma: .commaToken()
        ),
        .init(
          expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/"))
        ),
      ])
    )
  }

  func testBinOpDisambiguation57() {
    // Unapplied operators, not regex.
    assertParse(
      """
      (/, /)
      """,
      substructure: LabeledExprListSyntax([
        .init(
          expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/")),
          trailingComma: .commaToken()
        ),
        .init(
          expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/"))
        ),
      ])
    )
  }

  func testBinOpDisambiguation58() {
    // Unapplied operators, not regex.
    assertParse(
      """
      x[/, /]
      """,
      substructure: LabeledExprListSyntax([
        .init(
          expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/")),
          trailingComma: .commaToken()
        ),
        .init(
          expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/"))
        ),
      ])
    )
  }

  func testBinOpDisambiguation59() {
    // Unapplied operators, not regex.
    assertParse(
      """
      x[^/, /]
      """,
      substructure: LabeledExprListSyntax([
        .init(
          expression: DeclReferenceExprSyntax(baseName: .binaryOperator("^/")),
          trailingComma: .commaToken()
        ),
        .init(
          expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/"))
        ),
      ])
    )
  }

  func testBinOpDisambiguation60() {
    // Invalid. We can't confidently lex as a regex (as the lexer thinks it
    // could be a subscript), so we get a parser error.
    assertParse(
      """
      [1️⃣/, /]
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '/, /' in array")
      ]
    )
  }

  func testBinOpDisambiguation61() {
    // Fine if there's no trailing space though.
    assertParse(
      """
      [/,/]
      """,
      substructure: RegexLiteralExprSyntax(regex: .regexLiteralPattern(","))
    )
  }

  func testPrefixOpSplitting1() {
    assertParse(
      """
      let x =1️⃣/abc/
      """,
      diagnostics: [
        DiagnosticSpec(message: "'=' must have consistent whitespace on both sides", fixIts: ["insert whitespace"])
      ],
      fixedSource: """
        let x = /abc/
        """
    )
  }

  func testPrefixOpSplitting2a() {
    assertParse(
      """
      let x 1️⃣.2️⃣/abc/
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected '=' in variable",
          fixIts: ["insert '='"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected name in member access",
          fixIts: ["insert name"]
        ),
      ],
      applyFixIts: ["insert '='", "insert name"],
      fixedSource: """
        let x = .<#identifier#>/abc/
        """
    )
  }

  func testPrefixOpSplitting2b() {
    assertParse(
      """
      let x 1️⃣.2️⃣/abc/
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected '=' in variable",
          fixIts: ["insert '='"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected name in member access",
          fixIts: ["insert name"]
        ),
      ],
      applyFixIts: ["insert '='", "insert name"],
      fixedSource: """
        let x = .<#identifier#>/abc/
        """
    )
  }

  func testPrefixOpSplitting3() {
    assertParse(
      """
      let x = true?/abc/1️⃣:/def/
      """,
      substructure: BinaryOperatorExprSyntax(operator: .binaryOperator("/")),
      diagnostics: [
        DiagnosticSpec(message: "extraneous code ':/def/' at top level")
      ]
    )
  }

  func testPrefixOpSplitting4() {
    assertParse(
      """
      let x = true ?/abc/ : /def/
      """,
      substructure: SequenceExprSyntax {
        BooleanLiteralExprSyntax(booleanLiteral: true)
        UnresolvedTernaryExprSyntax(thenExpression: RegexLiteralExprSyntax(regex: .regexLiteralPattern("abc")))
        RegexLiteralExprSyntax(regex: .regexLiteralPattern("def"))
      }
    )
  }

  func testPrefixOpSplitting5() {
    assertParse(
      """
      let x = &/abc/
      """,
      substructure: InOutExprSyntax(
        expression: RegexLiteralExprSyntax(
          regex: .regexLiteralPattern("abc")
        )
      )
    )
  }

  func testNulCharacter() {
    assertParse(
      "/1️⃣\0/",
      diagnostics: [
        DiagnosticSpec(message: "nul character embedded in middle of file", severity: .warning)
      ]
    )
  }

  func testEmoji() {
    assertParse("/👍/")
  }
}
