// This test file has been translated from swift/test/StringProcessing/Parse/forward-slash-regex.swift

import XCTest

final class ForwardSlashRegexTests: XCTestCase {
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
    assertParse(
      """
      // The divisions in the body of the below operators make sure we don't try and
      // consider them to be ending delimiters of a regex.
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
    assertParse(
      """
      // These unfortunately become prefix `=` and infix `=/` respectively. We could
      // likely improve the diagnostic though.
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
        DiagnosticSpec(message: "bare slash regex literal may not end with space")
      ]
    )
  }

  func testForwardSlashRegex25() {
    assertParse(
      """
      _ = !!/1️⃣ /
      """,
      diagnostics: [
        DiagnosticSpec(message: "bare slash regex literal may not end with space")
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
      _ = /^)1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '/' to end regex literal")
      ]
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
      """
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
        DiagnosticSpec(message: "expected expression after operator")
      ]
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
        DiagnosticSpec(message: "expected expression after operator"),
        DiagnosticSpec(message: "unexpected code '? 0 : 1' in 'do' statement"),
      ]
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
        // TODO: Old parser expected error on line 3: unary operator cannot be separated from its operand
        DiagnosticSpec(message: "expected expression after operator"),
        DiagnosticSpec(message: "unexpected code '?? /x /' in 'do' statement"),
      ]
    )
  }

  func testForwardSlashRegex41() {
    // This parses as /x/ ??/ x/
    assertParse(
      """
      _ = /x/??/x/
      """
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
      """
    )
  }

  func testForwardSlashRegex44() {
    assertParse(
      """
      _ = /x/...
      """
    )
  }

  func testForwardSlashRegex45() {
    // This is parsed as /x /...
    assertParse(
      """
      do {
        _ = /x1️⃣ /2️⃣...
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: operator with postfix spacing cannot start a subexpression
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in operator"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '...' in 'do' statement"),
      ]
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
        DiagnosticSpec(message: "expected expression after operator")
      ]
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

  func testForwardSlashRegex49() {
    assertParse(
      """
      func foo<T>(_ x: T, y: T) {}
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
        DiagnosticSpec(message: "expected expression after operator")
      ]
    )
  }

  func testForwardSlashRegex53() {
    assertParse(
      """
      bar(&/x/)
      """
    )
  }

  func testForwardSlashRegex54() {
    assertParse(
      """
      struct S {
        subscript(x: Regex<Substring>) -> Void { () } 
        subscript(fn: (Int, Int) -> Int) -> Int { 0 }
      }
      """
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
        DiagnosticSpec(message: "expected expression after operator")
      ]
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
        DiagnosticSpec(message: "expected expression after operator")
      ]
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
        DiagnosticSpec(message: "expected expression after operator")
      ]
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected expression after operator"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression after operator"),
      ]
    )
  }

  func testForwardSlashRegex60() {
    assertParse(
      """
      _ = [/abc/:/abc/]
      """
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
      _ = [/abc/:/abc/]
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
        DiagnosticSpec(message: "expected expression after operator")
      ]
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
      """
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
      """
    )
  }

  func testForwardSlashRegex74() {
    // Regex literal
    assertParse(
      """
      _ = 2
      /1/ .bitWidth
      """
    )
  }

  func testForwardSlashRegex75() {
    // Operator chain
    assertParse(
      """
      _ = 2
      / 1 /
        .bitWidth
      """
    )
  }

  func testForwardSlashRegex76() {
    // This is parsed as '/1 / .bitWidth'
    assertParse(
      """
      _ = 2
      /1 /
        .bitWidth
      """
    )
  }

  func testForwardSlashRegex77() {
    // This is parsed as /1/.bitWidth
    assertParse(
      """
      _ = !!/1/ .bitWidth
      """
    )
  }

  func testForwardSlashRegex78() {
    // This is parsed as '!!/1'
    assertParse(
      """
      _ = !!/1 / .bitWidth
      """
    )
  }

  func testForwardSlashRegex79() {
    assertParse(
      """
      let z =
      /y/
      """
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
        DiagnosticSpec(message: "expected name in member access")
      ]
    )
  }

  func testForwardSlashRegex82() {
    assertParse(
      """
      _ = 0 . 1️⃣/ 1 / 2
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected name in member access")
      ]
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
        DiagnosticSpec(message: "expected pattern in variable")
      ]
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
        DiagnosticSpec(message: "expected expression after operator")
      ]
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
        DiagnosticSpec(message: "expected expression after operator")
      ]
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
        DiagnosticSpec(message: "expected expression after operator")
      ]
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
      """
    )
  }

  func testForwardSlashRegex103() {
    assertParse(
      """
      _ = /x // comment
      """
    )
  }

  func testForwardSlashRegex104() {
    assertParse(
      """
      _ = /x/*comment*/
      """
    )
  }

  func testForwardSlashRegex108() {
    // These become regex literals, unless last character is space, or are surrounded in parens.
    assertParse(
      """
      baz(/, /)
      baz(/,/)
      """
    )
  }

  func testForwardSlashRegex109() {
    assertParse(
      """
      baz((/), /)
      """
    )
  }

  func testForwardSlashRegex110() {
    assertParse(
      """
      baz(/^, /)
      baz(/^,/)
      """
    )
  }

  func testForwardSlashRegex111() {
    assertParse(
      """
      baz((/^), /)
      """
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
        _ = qux(/, "(")/1️⃣2
      }
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected ')' to end function call")
      ]
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
      _ = /1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '/' to end regex literal")
      ]
    )
  }

  func testForwardSlashRegex140() {
    assertParse(
      """
      _ = /)1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '/' to end regex literal")
      ]
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
        let _: Regex = (/whatever\)/1️⃣
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected note on line 2: to match this opening '('
        DiagnosticSpec(message: "expected ')' to end tuple")
      ]
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected root in key path"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '])/' in 'do' statement"),
      ]
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

  func testForwardSlashRegex150() {
    assertParse(
      #"""
      _ = ^/"/1️⃣"2️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"expected '"' to end string literal"#),
      ]
    )
  }

  func testForwardSlashRegex151() {
    assertParse(
      #"""
      _ = ^/"[/1️⃣"2️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"expected '"' to end string literal"#),
      ]
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
        DiagnosticSpec(message: "bare slash regex literal may not end with space")
      ]
    )
  }

  func testForwardSlashRegex159() {
    assertParse(
      """
      _ = / 1️⃣ /
      """,
      diagnostics: [
        DiagnosticSpec(message: "bare slash regex literal may not end with space")
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
      _ = /1️⃣               2️⃣
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "bare slash regex literal may not start with space"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '/' to end regex literal"),
      ]
    )
  }

  func testForwardSlashRegex166() {
    // There are intentionally trailing spaces here
    assertParse(
      """
      _ = /^                  1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '/' to end regex literal")
      ]
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
