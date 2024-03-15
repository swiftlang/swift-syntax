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

// This test file has been translated from swift/test/StringProcessing/Parse/forward-slash-regex.swift

@_spi(RawSyntax) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax
import XCTest

final class ForwardSlashRegexTests: ParserTestCase {
  func testForwardSlashRegex1() {
    assertParse(
      """
      prefix operator /
      prefix operator ^/
      prefix operator /^/
      """
    )
  }

  func testForwardSlashRegex2() {
    assertParse(
      """
      prefix func ^/ <T> (_ x: T) -> T { x }
      """
    )
  }

  func testForwardSlashRegex8() {
    // The divisions in the body of the below operators make sure we don't try and
    // consider them to be ending delimiters of a regex.
    assertParse(
      """
      infix operator /^/ : P
      func /^/ (lhs: Int, rhs: Int) -> Int { 1 / 2 }
      """
    )
  }

  func testForwardSlashRegex9() {
    assertParse(
      """
      infix operator /^ : P
      func /^ (lhs: Int, rhs: Int) -> Int { 1 / 2 }
      """
    )
  }

  func testForwardSlashRegex10() {
    assertParse(
      """
      infix operator ^^/ : P
      func ^^/ (lhs: Int, rhs: Int) -> Int { 1 / 2 }
      """
    )
  }

  func testForwardSlashRegex11() {
    assertParse(
      """
      let i = 0 /^/ 1/^/3
      """
    )
  }

  func testForwardSlashRegex12() {
    assertParse(
      """
      let x = /abc/
      """
    )
  }

  func testForwardSlashRegex13() {
    assertParse(
      """
      _ = /abc/
      """
    )
  }

  func testForwardSlashRegex14() {
    assertParse(
      """
      _ = /x/.self
      """
    )
  }

  func testForwardSlashRegex15() {
    assertParse(
      #"""
      _ = /\//
      """#
    )
  }

  func testForwardSlashRegex16() {
    assertParse(
      #"""
      _ = /\\/
      """#
    )
  }

  func testForwardSlashRegex18() {
    // These unfortunately become prefix `=` and infix `=/` respectively. We could
    // likely improve the diagnostic though.
    assertParse(
      """
      do {
        let z1️⃣=/0/
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '=/0/' in 'do' statement")
      ]
    )
  }

  func testForwardSlashRegex19() {
    assertParse(
      """
      do {
        _=/0/
      }
      """
    )
  }

  func testForwardSlashRegex21() {
    assertParse(
      """
      _ = /x
      """
    )
  }

  func testForwardSlashRegex22() {
    assertParse(
      """
      _ = !/x/
      """
    )
  }

  func testForwardSlashRegex23() {
    assertParse(
      """
      _ = (!/x/)
      """
    )
  }

  func testForwardSlashRegex24() {
    assertParse(
      """
      _ = !/1️⃣ /
      """,
      diagnostics: [
        DiagnosticSpec(message: "bare slash regex literal may not start with space")
      ]
    )
  }

  func testForwardSlashRegex25() {
    assertParse(
      """
      _ = !!/1️⃣ /
      """,
      diagnostics: [
        DiagnosticSpec(message: "bare slash regex literal may not start with space")
      ]
    )
  }

  func testForwardSlashRegex26() {
    assertParse(
      """
      _ = !!/x/
      """
    )
  }

  func testForwardSlashRegex27() {
    assertParse(
      """
      _ = (!!/x/)
      """
    )
  }

  func testForwardSlashRegex28() {
    assertParse(
      """
      _ = ℹ️/^)1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '/' to end regex literal",
          notes: [NoteSpec(message: "to match this opening '/'")],
          fixIts: ["insert '/'"]
        )
      ],
      fixedSource: """
        _ = /^)/
        """
    )
  }

  func testForwardSlashRegex29() {
    assertParse(
      """
      _ = /x/!
      """
    )
  }

  func testForwardSlashRegex30() {
    assertParse(
      """
      _ = /x/ + /y/
      """
    )
  }

  func testForwardSlashRegex31() {
    assertParse(
      """
      _ = /x/+/y/
      """
    )
  }

  func testForwardSlashRegex32() {
    assertParse(
      """
      _ = /x/?.blah
      """
    )
  }

  func testForwardSlashRegex33() {
    assertParse(
      """
      _ = /x/!.blah
      """
    )
  }

  func testForwardSlashRegex34() {
    // Regex literals cannot end with space, so this is infix '/?'
    assertParse(
      """
      do {
        _ = /x /?
          .blah
      }
      """,
      substructure: BinaryOperatorExprSyntax(operator: .binaryOperator("/?"))
    )
  }

  func testForwardSlashRegex35() {
    assertParse(
      """
      _ = /x/? 
        .blah
      """
    )
  }

  func testForwardSlashRegex36() {
    assertParse(
      """
      _ = 0; /x/
      """
    )
  }

  func testForwardSlashRegex37() {
    assertParse(
      """
      do {
        _ = 0; /x /1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression after operator", fixIts: ["insert expression"])
      ],
      fixedSource: """
        do {
          _ = 0; /x / <#expression#>
        }
        """
    )
  }

  func testForwardSlashRegex38() {
    assertParse(
      """
      _ = /x/ ? 0 : 1 
      do {
        _ = /x / 1️⃣? 0 : 1 
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression after operator", fixIts: ["insert expression"]),
        DiagnosticSpec(message: "unexpected code '? 0 : 1' in 'do' statement"),
      ],
      fixedSource: """
        _ = /x/ ? 0 : 1
        do {
          _ = /x / <#expression#>? 0 : 1
        }
        """
    )
  }

  func testForwardSlashRegex39() {
    assertParse(
      """
      _ = .random() ? /x/ : .blah
      """
    )
  }

  func testForwardSlashRegex40() {
    assertParse(
      """
      _ = /x/ ?? /x/ 
      do {
        _ = /x / 1️⃣?? /x / 
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression after operator", fixIts: ["insert expression"]),
        DiagnosticSpec(message: "unexpected code '?? /x /' in 'do' statement"),
      ],
      fixedSource: """
        _ = /x/ ?? /x/
        do {
          _ = /x / <#expression#>?? /x /
        }
        """
    )
  }

  func testForwardSlashRegex41() {
    // This parses as /x/?? / x/
    assertParse(
      """
      _ = /x/??/x/
      """,
      substructure: SequenceExprSyntax {
        DiscardAssignmentExprSyntax()
        AssignmentExprSyntax()
        OptionalChainingExprSyntax(
          expression: OptionalChainingExprSyntax(
            expression: RegexLiteralExprSyntax(regex: .regexLiteralPattern("x"))
          )
        )
        BinaryOperatorExprSyntax(operator: .binaryOperator("/"))
        PostfixOperatorExprSyntax(expression: DeclReferenceExprSyntax(baseName: "x"), operator: .postfixOperator("/"))
      }
    )
  }

  func testForwardSlashRegex42() {
    assertParse(
      """
      _ = /x/ ... /y/
      """
    )
  }

  func testForwardSlashRegex43() {
    // This parses as /x/ .../ x/
    assertParse(
      """
      _ = /x/.../y/
      """,
      substructure: BinaryOperatorExprSyntax(operator: .binaryOperator(".../"))
    )
  }

  func testForwardSlashRegex44() {
    assertParse(
      """
      _ = /x/...
      """
    )
  }

  func testForwardSlashRegex45a() {
    // This is parsed as /x /...
    assertParse(
      """
      do {
        _ = /x1️⃣ /2️⃣...
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in operator", fixIts: ["insert expression"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '...' in 'do' statement"),
      ],
      applyFixIts: ["insert newline", "insert expression"],
      fixedSource: """
        do {
          _ = /x
          /<#expression#>...
        }
        """
    )
  }

  func testForwardSlashRegex45b() {
    // This is parsed as /x /...
    assertParse(
      """
      do {
        _ = /x1️⃣ /2️⃣...
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in operator", fixIts: ["insert expression"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '...' in 'do' statement"),
      ],
      applyFixIts: ["insert ';'", "insert expression"],
      fixedSource: """
        do {
          _ = /x; /<#expression#>...
        }
        """
    )
  }

  func testForwardSlashRegex46() {
    assertParse(
      """
      do {
        _ = true / false /1️⃣; 
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression after operator", fixIts: ["insert expression"])
      ],
      fixedSource: """
        do {
          _ = true / false / <#expression#>;
        }
        """
    )
  }

  func testForwardSlashRegex47() {
    assertParse(
      #"""
      _ = "\(/x/)"
      """#
    )
  }

  func testForwardSlashRegex48() {
    assertParse(
      """
      func defaulted(x: Regex<Substring> = /x/) {}
      """
    )
  }

  func testForwardSlashRegex50() {
    assertParse(
      """
      foo(/abc/, y: /abc/)
      """
    )
  }

  func testForwardSlashRegex51() {
    assertParse(
      """
      foo(/abc/, y: /abc /1️⃣)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression after operator", fixIts: ["insert expression"])
      ],
      fixedSource: """
        foo(/abc/, y: /abc / <#expression#>)
        """
    )
  }

  func testForwardSlashRegex53() {
    assertParse(
      """
      bar(&/x/)
      """,
      substructure: InOutExprSyntax(
        expression: RegexLiteralExprSyntax(
          regex: .regexLiteralPattern("x")
        )
      )
    )
  }

  func testForwardSlashRegex55() {
    assertParse(
      """
      func testSubscript(_ x: S) {
        x[/x/]
        x[/x /1️⃣]
        _ = x[/] / 2
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression after operator", fixIts: ["insert expression"])
      ],
      fixedSource: """
        func testSubscript(_ x: S) {
          x[/x/]
          x[/x / <#expression#>]
          _ = x[/] / 2
        }
        """
    )
  }

  func testForwardSlashRegex56() {
    assertParse(
      """
      func testReturn() -> Regex<Substring> {
        if .random() {
          return /x/
        }
        return /x /1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression after operator", fixIts: ["insert expression"])
      ],
      fixedSource: """
        func testReturn() -> Regex<Substring> {
          if .random() {
            return /x/
          }
          return /x / <#expression#>
        }
        """
    )
  }

  func testForwardSlashRegex57() {
    assertParse(
      """
      func testThrow() throws {
        throw /x/ 
      }
      """
    )
  }

  func testForwardSlashRegex58() {
    assertParse(
      """
      do {
        _ = [/abc/, /abc /1️⃣] 
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression after operator", fixIts: ["insert expression"])
      ],
      fixedSource: """
        do {
          _ = [/abc/, /abc / <#expression#>]
        }
        """
    )
  }

  func testForwardSlashRegex59() {
    assertParse(
      """
      do {
        _ = [/abc /1️⃣: /abc /2️⃣]
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected expression after operator",
          fixIts: ["insert expression"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected expression after operator",
          fixIts: ["insert expression"]
        ),
      ],
      fixedSource: """
        do {
          _ = [/abc / <#expression#>: /abc / <#expression#>]
        }
        """
    )
  }

  func testForwardSlashRegex60() {
    assertParse(
      """
      _ = [/abc/:/abc/]
      """,
      substructure: DictionaryExprSyntax(
        content: .elements(
          .init([
            .init(
              key: RegexLiteralExprSyntax(regex: .regexLiteralPattern("abc")),
              value: RegexLiteralExprSyntax(regex: .regexLiteralPattern("abc"))
            )
          ])
        )
      )
    )
  }

  func testForwardSlashRegex61() {
    assertParse(
      """
      _ = [/abc/ : /abc/]
      """
    )
  }

  func testForwardSlashRegex62() {
    assertParse(
      """
      _ = [/abc/ :/abc/]
      """
    )
  }

  func testForwardSlashRegex63() {
    assertParse(
      """
      _ = [/abc/: /abc/]
      """
    )
  }

  func testForwardSlashRegex64() {
    assertParse(
      """
      _ = (/abc/, /abc/)
      """
    )
  }

  func testForwardSlashRegex65() {
    assertParse(
      """
      _ = ((/abc/))
      """
    )
  }

  func testForwardSlashRegex66() {
    assertParse(
      """
      do {
        _ = ((/abc /1️⃣))
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression after operator", fixIts: ["insert expression"])
      ],
      fixedSource: """
        do {
          _ = ((/abc / <#expression#>))
        }
        """
    )
  }

  func testForwardSlashRegex67() {
    assertParse(
      """
      _ = { /abc/ }
      """
    )
  }

  func testForwardSlashRegex68() {
    assertParse(
      """
      _ = {
        /abc/
      }
      """
    )
  }

  func testForwardSlashRegex69() {
    assertParse(
      """
      let _: () -> Int = {
        0
        / 1 /
        2
      }
      """
    )
  }

  func testForwardSlashRegex70() {
    // This is parsed as '/1 / 2'
    assertParse(
      """
      let _: () -> Int = {
        0
        /1 / 
        2
      }
      """,
      substructure: BinaryOperatorExprSyntax(operator: .binaryOperator("/"))
    )
  }

  func testForwardSlashRegex71() {
    assertParse(
      """
      _ = {
        0 
        /1/ 
        2 
      }
      """
    )
  }

  func testForwardSlashRegex73() {
    // Operator chain, as a regex literal may not start with space.
    assertParse(
      """
      _ = 2
      / 1 / .bitWidth
      """,
      substructure: BinaryOperatorExprSyntax(operator: .binaryOperator("/"))
    )
  }

  func testForwardSlashRegex74() {
    // Regex literal
    assertParse(
      """
      _ = 2
      /1/ .bitWidth
      """,
      substructure: RegexLiteralExprSyntax(regex: .regexLiteralPattern("1"))
    )
  }

  func testForwardSlashRegex75() {
    // Operator chain
    assertParse(
      """
      _ = 2
      / 1 /
        .bitWidth
      """,
      substructure: BinaryOperatorExprSyntax(operator: .binaryOperator("/"))
    )
  }

  func testForwardSlashRegex76() {
    // This is parsed as '/1 / .bitWidth'
    assertParse(
      """
      _ = 2
      /1 /
        .bitWidth
      """,
      substructure: BinaryOperatorExprSyntax(operator: .binaryOperator("/"))
    )
  }

  func testForwardSlashRegex77() {
    // This is parsed as /1/.bitWidth
    assertParse(
      """
      _ = !!/1/ .bitWidth
      """,
      substructure: PrefixOperatorExprSyntax(
        operator: .prefixOperator("!!"),
        expression: MemberAccessExprSyntax(
          base: RegexLiteralExprSyntax(regex: .regexLiteralPattern("1")),
          name: "bitWidth"
        )
      )
    )
  }

  func testForwardSlashRegex78() {
    // This is parsed as '!!/1'
    assertParse(
      """
      _ = !!/1 / .bitWidth
      """,
      substructure: BinaryOperatorExprSyntax(operator: .binaryOperator("/"))
    )
  }

  func testForwardSlashRegex79() {
    assertParse(
      """
      let z =
      /y/
      """,
      substructure: RegexLiteralExprSyntax(regex: .regexLiteralPattern("y"))
    )
  }

  func testForwardSlashRegex81() {
    // While '.' is technically an operator character, it seems more likely that
    // the user hasn't written the member name yet.
    assertParse(
      """
      _ = 0.1️⃣ / 1 / 2
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected name in member access", fixIts: ["insert name"])
      ],
      fixedSource: """
        _ = 0.<#identifier#> / 1 / 2
        """
    )
  }

  func testForwardSlashRegex82() {
    assertParse(
      """
      _ = 0 .1️⃣ / 1 / 2
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected name in member access", fixIts: ["insert name"])
      ],
      fixedSource: """
        _ = 0 .<#identifier#> / 1 / 2
        """
    )
  }

  func testForwardSlashRegex83() {
    assertParse(
      #"""
      switch "" {
      case _ where /x/:
        break
      default:
        break
      }
      """#
    )
  }

  func testForwardSlashRegex84() {
    assertParse(
      """
      do {} catch /x/ {}
      """
    )
  }

  func testForwardSlashRegex86() {
    assertParse(
      """
      switch /x/ {
      default:
        break
      }
      """
    )
  }

  func testForwardSlashRegex87() {
    assertParse(
      """
      if /x/ {}
      """
    )
  }

  func testForwardSlashRegex88() {
    assertParse(
      """
      if /x/.smth {}
      """
    )
  }

  func testForwardSlashRegex89() {
    assertParse(
      """
      func testGuard() {
        guard /x/ else { return } 
      }
      """
    )
  }

  func testForwardSlashRegex90() {
    assertParse(
      """
      for x in [0] where /x/ {}
      """
    )
  }

  func testForwardSlashRegex92() {
    assertParse(
      """
      _ = /x/ as Magic
      """
    )
  }

  func testForwardSlashRegex93() {
    assertParse(
      """
      _ = /x/ as! String
      """
    )
  }

  func testForwardSlashRegex94() {
    assertParse(
      """
      _ = type(of: /x/)
      """
    )
  }

  func testForwardSlashRegex95() {
    assertParse(
      """
      do {
        let 1️⃣/x/
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected pattern in variable", fixIts: ["insert pattern"]),
        DiagnosticSpec(message: "expected '=' in variable", fixIts: ["insert '='"]),
      ],
      fixedSource: """
        do {
          let <#pattern#> = /x/
        }
        """
    )
  }

  func testForwardSlashRegex96() {
    assertParse(
      """
      do {
        _ = try /x/; _ = try /x /1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression after operator", fixIts: ["insert expression"])
      ],
      fixedSource: """
        do {
          _ = try /x/; _ = try /x / <#expression#>
        }
        """
    )
  }

  func testForwardSlashRegex97() {
    assertParse(
      """
      do {
        _ = try? /x/; _ = try? /x /1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression after operator", fixIts: ["insert expression"])
      ],
      fixedSource: """
        do {
          _ = try? /x/; _ = try? /x / <#expression#>
        }
        """
    )
  }

  func testForwardSlashRegex98() {
    assertParse(
      """
      do {
        _ = try! /x/; _ = try! /x /1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression after operator", fixIts: ["insert expression"])
      ],
      fixedSource: """
        do {
          _ = try! /x/; _ = try! /x / <#expression#>
        }
        """
    )
  }

  func testForwardSlashRegex99() {
    assertParse(
      """
      _ = await /x/
      """
    )
  }

  func testForwardSlashRegex100() {
    assertParse(
      """
      /x/ = 0 
      /x/()
      """
    )
  }

  func testForwardSlashRegex102() {
    // We treat the following as comments, as it seems more likely the user has
    // written a comment and is still in the middle of writing the characters before
    // it.
    assertParse(
      """
      _ = /x// comment
      """,
      substructure: PrefixOperatorExprSyntax(
        operator: .prefixOperator("/"),
        expression: DeclReferenceExprSyntax(baseName: "x")
      )
    )
  }

  func testForwardSlashRegex103() {
    assertParse(
      """
      _ = /x // comment
      """,
      substructure: PrefixOperatorExprSyntax(
        operator: .prefixOperator("/"),
        expression: DeclReferenceExprSyntax(baseName: "x")
      )
    )
  }

  func testForwardSlashRegex104() {
    assertParse(
      """
      _ = /x/*comment*/
      """,
      substructure: PrefixOperatorExprSyntax(
        operator: .prefixOperator("/"),
        expression: DeclReferenceExprSyntax(baseName: "x")
      )
    )
  }

  func testForwardSlashRegex108() {
    // These become regex literals, unless last character is space, or are surrounded in parens.
    assertParse(
      """
      baz(/, /)
      """,
      substructure: LabeledExprListSyntax([
        .init(expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/")), trailingComma: .commaToken()),
        .init(expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/"))),
      ])
    )
    assertParse(
      """
      baz(/,/)
      """,
      substructure: RegexLiteralExprSyntax(regex: .regexLiteralPattern(","))
    )
  }

  func testForwardSlashRegex109() {
    assertParse(
      """
      baz((/), /)
      """,
      substructure: LabeledExprListSyntax([
        .init(
          expression: TupleExprSyntax(
            elements: .init([
              .init(expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/")))
            ])
          ),
          trailingComma: .commaToken()
        ),
        .init(expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/"))),
      ])
    )
  }

  func testForwardSlashRegex110() {
    assertParse(
      """
      baz(/^, /)
      """,
      substructure: LabeledExprListSyntax([
        .init(expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/^")), trailingComma: .commaToken()),
        .init(expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/"))),
      ])
    )
    assertParse(
      """
      baz(/^,/)
      """,
      substructure: RegexLiteralExprSyntax(regex: .regexLiteralPattern("^,"))
    )
  }

  func testForwardSlashRegex111() {
    assertParse(
      """
      baz((/^), /)
      """,
      substructure: LabeledExprListSyntax([
        .init(
          expression: TupleExprSyntax(
            elements: .init([
              .init(expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/^")))
            ])
          ),
          trailingComma: .commaToken()
        ),
        .init(expression: DeclReferenceExprSyntax(baseName: .binaryOperator("/"))),
      ])
    )
  }

  func testForwardSlashRegex112() {
    assertParse(
      """
      baz(^^/, /)
      baz(^^/,/) 
      baz((^^/), /)
      """
    )
  }

  func testForwardSlashRegex114() {
    assertParse(
      """
      bazbaz(/, 0)
      bazbaz(^^/, 0)
      """
    )
  }

  func testForwardSlashRegex116() {
    assertParse(
      #"""
      _ = qux(/, 1) / 2
      do {
        _ = qux(/, "(") / 2
        _ = quxℹ️(/, "(")/1️⃣2
      }
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "expected ')' to end function call",
          notes: [NoteSpec(message: "to match this opening '('")],
          fixIts: ["insert ')'"]
        )
      ],
      fixedSource: #"""
        _ = qux(/, 1) / 2
        do {
          _ = qux(/, "(") / 2
          _ = qux(/, "(")/)2
        }
        """#
    )
  }

  func testForwardSlashRegex117() {
    assertParse(
      #"""
      _ = qux((/), "(") / 2
      """#
    )
  }

  func testForwardSlashRegex118() {
    assertParse(
      """
      _ = qux(/, 1) // this comment tests to make sure we don't try and end the regex on the starting '/' of '//'.
      """
    )
  }

  func testForwardSlashRegex119() {
    assertParse(
      """
      _ = qux(/, 1) /* same thing with a block comment */
      """
    )
  }

  func testForwardSlashRegex122() {
    assertParse(
      """
      quxqux(/^/) 
      quxqux((/^/)) 
      quxqux({ $0 /^/ $1 })
      """
    )
  }

  func testForwardSlashRegex123() {
    assertParse(
      """
      quxqux(!/^/)
      """
    )
  }

  func testForwardSlashRegex124() {
    assertParse(
      """
      quxqux(/^)
      """
    )
  }

  func testForwardSlashRegex125() {
    assertParse(
      """
      _ = quxqux(/^) / 1
      """
    )
  }

  func testForwardSlashRegex127() {
    assertParse(
      """
      _ = arr.reduce(1, /) / 3
      """
    )
  }

  func testForwardSlashRegex128() {
    assertParse(
      """
      _ = arr.reduce(1, /) + arr.reduce(1, /)
      """
    )
  }

  func testForwardSlashRegex130() {
    assertParse(
      """
      _ = (/x)
      """
    )
  }

  func testForwardSlashRegex131() {
    assertParse(
      """
      _ = (/x)/
      """
    )
  }

  func testForwardSlashRegex132() {
    assertParse(
      """
      _ = (/[(0)])/
      """
    )
  }

  func testForwardSlashRegex133() {
    assertParse(
      """
      _ = /[(0)]/
      """
    )
  }

  func testForwardSlashRegex134() {
    assertParse(
      """
      _ = /(x)/
      """
    )
  }

  func testForwardSlashRegex135() {
    assertParse(
      """
      _ = /[)]/
      """
    )
  }

  func testForwardSlashRegex136() {
    assertParse(
      #"""
      _ = /[a\])]/
      """#
    )
  }

  func testForwardSlashRegex137() {
    assertParse(
      """
      _ = /([)])/
      """
    )
  }

  func testForwardSlashRegex138() {
    assertParse(
      """
      _ = /]]][)]/
      """
    )
  }

  func testForwardSlashRegex139() {
    assertParse(
      """
      _ = ℹ️/1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '/' to end regex literal",
          notes: [NoteSpec(message: "to match this opening '/'")],
          fixIts: ["insert '/'"]
        )
      ],
      fixedSource: """
        _ = //
        """
    )
  }

  func testForwardSlashRegex140() {
    assertParse(
      """
      _ = ℹ️/)1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '/' to end regex literal",
          notes: [NoteSpec(message: "to match this opening '/'")],
          fixIts: ["insert '/'"]
        )
      ],
      fixedSource: """
        _ = /)/
        """
    )
  }

  func testForwardSlashRegex141() {
    assertParse(
      """
      let fn: (Int, Int) -> Int = (/)
      """
    )
  }

  func testForwardSlashRegex142() {
    assertParse(
      #"""
      _ = /\()1️⃣/
      """#,
      diagnostics: [
        DiagnosticSpec(message: "extraneous code '/' at top level")
      ]
    )
  }

  func testForwardSlashRegex143() {
    assertParse(
      #"""
      do {
        let _: Regex = ℹ️(/whatever\)/1️⃣
      }
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "expected ')' to end tuple",
          notes: [
            NoteSpec(message: "to match this opening '('")
          ],
          fixIts: ["insert ')'"]
        )
      ],
      fixedSource: #"""
        do {
          let _: Regex = (/whatever\)/)
        }
        """#
    )
  }

  func testForwardSlashRegex144() {
    assertParse(
      """
      do {
        _ = /(()())1️⃣)/
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code ')/' in 'do' statement")
      ]
    )
  }

  func testForwardSlashRegex145() {
    assertParse(
      """
      do {
        _ = /[x]1️⃣)/
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code ')/' in 'do' statement")
      ]
    )
  }

  func testForwardSlashRegex146() {
    assertParse(
      #"""
      do {
        _ = /[\1️⃣]2️⃣])/
      }
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected root in key path", fixIts: ["insert root"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '])/' in 'do' statement"),
      ],
      fixedSource: #"""
        do {
          _ = /[\<#type#>]])/
        }
        """#
    )
  }

  func testForwardSlashRegex147() {
    assertParse(
      """
      _ = ^/x/
      """
    )
  }

  func testForwardSlashRegex148() {
    assertParse(
      """
      _ = (^/x)/
      """
    )
  }

  func testForwardSlashRegex149() {
    assertParse(
      """
      _ = (!!/x/)
      """
    )
  }

  func testForwardSlashRegex150a() {
    assertParse(
      #"""
      _ = ^/"/1️⃣"2️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: #"expected '"' to end string literal"#,
          notes: [NoteSpec(locationMarker: "1️⃣", message: #"to match this opening '"'"#)],
          fixIts: [#"insert '"'"#]
        ),
      ],
      applyFixIts: ["insert newline", #"insert '"'"#],
      fixedSource: #"""
        _ = ^/"/
        ""
        """#
    )
  }

  func testForwardSlashRegex150b() {
    assertParse(
      #"""
      _ = ^/"/1️⃣"2️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: #"expected '"' to end string literal"#,
          notes: [NoteSpec(locationMarker: "1️⃣", message: #"to match this opening '"'"#)],
          fixIts: [#"insert '"'"#]
        ),
      ],
      applyFixIts: ["insert ';'", #"insert '"'"#],
      fixedSource: #"""
        _ = ^/"/; ""
        """#
    )
  }

  func testForwardSlashRegex151a() {
    assertParse(
      #"""
      _ = ^/"[/1️⃣"2️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: #"expected '"' to end string literal"#,
          notes: [NoteSpec(locationMarker: "1️⃣", message: #"to match this opening '"'"#)],
          fixIts: [#"insert '"'"#]
        ),
      ],
      applyFixIts: ["insert newline", #"insert '"'"#],
      fixedSource: #"""
        _ = ^/"[/
        ""
        """#
    )
  }

  func testForwardSlashRegex151b() {
    assertParse(
      #"""
      _ = ^/"[/1️⃣"2️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: #"expected '"' to end string literal"#,
          notes: [NoteSpec(locationMarker: "1️⃣", message: #"to match this opening '"'"#)],
          fixIts: [#"insert '"'"#]
        ),
      ],
      applyFixIts: ["insert ';'", #"insert '"'"#],
      fixedSource: #"""
        _ = ^/"[/; ""
        """#
    )
  }

  func testForwardSlashRegex152() {
    assertParse(
      #"""
      _ = (^/)("/")
      """#
    )
  }

  func testForwardSlashRegex155() {
    assertParse(
      """
      _ = /./
      """
    )
  }

  func testForwardSlashRegex157() {
    // Okay, as the space is escaped.
    assertParse(
      #"""
      _ = /\ /
      """#
    )
  }

  func testForwardSlashRegex158() {
    assertParse(
      """
      _ = /1️⃣ /
      """,
      diagnostics: [
        DiagnosticSpec(message: "bare slash regex literal may not start with space")
      ]
    )
  }

  func testForwardSlashRegex159() {
    assertParse(
      """
      _ = /1️⃣  /
      """,
      diagnostics: [
        DiagnosticSpec(message: "bare slash regex literal may not start with space")
      ]
    )
  }

  func testForwardSlashRegex160() {
    assertParse(
      """
      _ = #/  /#
      """
    )
  }

  func testForwardSlashRegex161() {
    assertParse(
      #"""
      _ = /x\ /
      """#
    )
  }

  func testForwardSlashRegex162() {
    assertParse(
      #"""
      _ = /\ \ /
      """#
    )
  }

  func testForwardSlashRegex163() {
    assertParse(
      """

      """
    )
  }

  func testForwardSlashRegex164() {
    // There are intentionally trailing spaces here
    assertParse(
      """
      _ = ℹ️/1️⃣               2️⃣
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "bare slash regex literal may not start with space"),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected '/' to end regex literal",
          notes: [NoteSpec(message: "to match this opening '/'")],
          fixIts: ["insert '/'"]
        ),
      ],
      fixedSource: """
        _ = /               /
        """
    )
  }

  func testForwardSlashRegex166() {
    // There are intentionally trailing spaces here
    assertParse(
      """
      _ = ℹ️/^                  1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '/' to end regex literal",
          notes: [NoteSpec(message: "to match this opening '/'")],
          fixIts: ["insert '/'"]
        )
      ],
      fixedSource: """
        _ = /^                  /
        """
    )
  }

  func testForwardSlashRegex167() {
    assertParse(
      #"""
      _ = /\)/
      """#
    )
  }

  func testForwardSlashRegex168() {
    assertParse(
      """
      _ = /)/
      """
    )
  }

  func testForwardSlashRegex169() {
    assertParse(
      """
      _ = /,/
      """
    )
  }

  func testForwardSlashRegex170() {
    assertParse(
      """
      _ = /}/
      """
    )
  }

  func testForwardSlashRegex171() {
    assertParse(
      """
      _ = /]/
      """
    )
  }

  func testForwardSlashRegex172() {
    assertParse(
      """
      _ = /:/
      """
    )
  }

  func testForwardSlashRegex173() {
    assertParse(
      """
      _ = /;/
      """
    )
  }

  func testForwardSlashRegex175() {
    assertParse(
      """
      _ = /0xG/
      """
    )
  }

  func testForwardSlashRegex176() {
    assertParse(
      """
      _ = /0oG/
      """
    )
  }

  func testForwardSlashRegex177() {
    assertParse(
      #"""
      _ = /"/
      """#
    )
  }

  func testForwardSlashRegex178() {
    assertParse(
      """
      _ = /'/
      """
    )
  }

  func testForwardSlashRegex179() {
    assertParse(
      """
      _ = /<#placeholder#>/
      """
    )
  }

  func testForwardSlashRegex180() {
    assertParse(
      """
      _ = ^^/1️⃣0xG/
      """
    )
  }

  func testForwardSlashRegex181() {
    assertParse(
      """
      _ = ^^/1️⃣0oG/
      """
    )
  }

  func testForwardSlashRegex182() {
    assertParse(
      #"""
      _ = ^^/"/1️⃣
      """#
    )
  }

  func testForwardSlashRegex183() {
    assertParse(
      """
      _ = ^^/'/1️⃣
      """
    )
  }

  func testForwardSlashRegex184() {
    assertParse(
      """
      _ = ^^/<#placeholder#>/
      """
    )
  }

  func testForwardSlashRegex185() {
    assertParse(
      """
      _ = (^^/1️⃣0xG/)
      """
    )
  }

  func testForwardSlashRegex186() {
    assertParse(
      """
      _ = (^^/1️⃣0oG/)
      """
    )
  }

  func testForwardSlashRegex187() {
    assertParse(
      #"""
      _ = (^^/"/)1️⃣
      """#
    )
  }

  func testForwardSlashRegex188() {
    assertParse(
      """
      _ = (^^/'/)1️⃣
      """
    )
  }

  func testForwardSlashRegex189() {
    assertParse(
      """
      _ = (^^/<#placeholder#>/)
      """
    )
  }
}
