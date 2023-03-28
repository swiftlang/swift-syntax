// This test file has been translated from swift/test/StringProcessing/Parse/forward-slash-regex.swift

import XCTest

final class ForwardSlashRegexTests: XCTestCase {
  func testForwardSlashRegex1() {
    AssertParse(
      """
      prefix operator /
      prefix operator ^/
      prefix operator /^/
      """
    )
  }

  func testForwardSlashRegex2() {
    AssertParse(
      """
      prefix func ^/ <T> (_ x: T) -> T { x }
      """
    )
  }

  func testForwardSlashRegex3() {
    AssertParse(
      """
      prefix operator !!
      """
    )
  }

  func testForwardSlashRegex4() {
    AssertParse(
      """
      prefix func !! <T>(_ x: T) -> T { x }
      """
    )
  }

  func testForwardSlashRegex5() {
    AssertParse(
      """
      prefix operator ^^
      """
    )
  }

  func testForwardSlashRegex6() {
    AssertParse(
      """
      prefix func ^^ <T>(_ x: T) -> T { x }
      """
    )
  }

  func testForwardSlashRegex7() {
    AssertParse(
      """
      precedencegroup P {
        associativity: left
      }
      """
    )
  }

  func testForwardSlashRegex8() {
    AssertParse(
      """
      // The divisions in the body of the below operators make sure we don't try and
      // consider them to be ending delimiters of a regex.
      infix operator /^/ : P
      func /^/ (lhs: Int, rhs: Int) -> Int { 1 / 2 }
      """
    )
  }

  func testForwardSlashRegex9() {
    AssertParse(
      """
      infix operator /^ : P
      func /^ (lhs: Int, rhs: Int) -> Int { 1 / 2 }
      """
    )
  }

  func testForwardSlashRegex10() {
    AssertParse(
      """
      infix operator ^^/ : P
      func ^^/ (lhs: Int, rhs: Int) -> Int { 1 / 2 }
      """
    )
  }

  func testForwardSlashRegex11() {
    AssertParse(
      """
      let i = 01️⃣ /^/2️⃣ 1/^/3
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }

  func testForwardSlashRegex12() {
    AssertParse(
      """
      let x = /abc/
      """
    )
  }

  func testForwardSlashRegex13() {
    AssertParse(
      """
      _ = /abc/
      """
    )
  }

  func testForwardSlashRegex14() {
    AssertParse(
      """
      _ = /x/.self
      """
    )
  }

  func testForwardSlashRegex15() {
    AssertParse(
      #"""
      _ = /\//
      """#
    )
  }

  func testForwardSlashRegex16() {
    AssertParse(
      #"""
      _ = /\\/
      """#
    )
  }

  func testForwardSlashRegex17() {
    AssertParse(
      """
      // This is just here to appease typo correction.
      let y = 0
      """
    )
  }

  func testForwardSlashRegex18() {
    AssertParse(
      """
      // These unfortunately become prefix `=` and infix `=/` respectively. We could
      // likely improve the diagnostic though.
      do {
        let z1️⃣=/0/
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: type annotation missing in pattern
        // TODO: Old parser expected error on line 4: consecutive statements on a line must be separated by ';'
        // TODO: Old parser expected error on line 4: expected expression
        DiagnosticSpec(message: "unexpected code '=/0/' in 'do' statement"),
      ]
    )
  }

  func testForwardSlashRegex19() {
    AssertParse(
      """
      do {
        _=/0/
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: '_' can only appear in a pattern or on the left side of an assignment
        // TODO: Old parser expected error on line 2: cannot find operator '=/' in scope
        // TODO: Old parser expected error on line 2: '/' is not a postfix unary operator
      ]
    )
  }

  func testForwardSlashRegex20() {
    AssertParse(
      """
      // No closing '/' so a prefix operator.
      """
    )
  }

  func testForwardSlashRegex21() {
    AssertParse(
      """
      _ = /x
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '/' is not a prefix unary operator
      ]
    )
  }

  func testForwardSlashRegex22() {
    AssertParse(
      """
      _ = !/x/
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot convert value of type 'Regex<Substring>' to expected argument type 'Bool'
      ]
    )
  }

  func testForwardSlashRegex23() {
    AssertParse(
      """
      _ = (!/x/)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot convert value of type 'Regex<Substring>' to expected argument type 'Bool'
      ]
    )
  }

  func testForwardSlashRegex24() {
    AssertParse(
      """
      _ = 1️⃣!/ /
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: regex literal may not start with space; add backslash to escape
        // TODO: Old parser expected error on line 1: cannot convert value of type 'Regex<Substring>' to expected argument type 'Bool'
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code '!/ /' at top level"),
      ]
    )
  }

  func testForwardSlashRegex25() {
    AssertParse(
      """
      _ = 1️⃣!!/ /
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: regex literal may not start with space; add backslash to escape
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code '!!/ /' at top level"),
      ]
    )
  }

  func testForwardSlashRegex26() {
    AssertParse(
      """
      _ = !!/x/
      """
    )
  }

  func testForwardSlashRegex27() {
    AssertParse(
      """
      _ = (!!/x/)
      """
    )
  }

  func testForwardSlashRegex28() {
    AssertParse(
      """
      _ = 1️⃣/^)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unterminated regex literal
        // TODO: Old parser expected error on line 1: closing ')' does not balance any groups openings
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code '/^)' at top level"),
      ]
    )
  }

  func testForwardSlashRegex29() {
    AssertParse(
      """
      _ = /x/!
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot force unwrap value of non-optional type 'Regex<Substring>'
      ]
    )
  }

  func testForwardSlashRegex30() {
    AssertParse(
      """
      _ = /x/ + /y/
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: binary operator '+' cannot be applied to two 'Regex<Substring>' operands
      ]
    )
  }

  func testForwardSlashRegex31() {
    AssertParse(
      """
      _ = /x/+/y/
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot find operator '+/' in scope
        // TODO: Old parser expected error on line 1: '/' is not a postfix unary operator
      ]
    )
  }

  func testForwardSlashRegex32() {
    AssertParse(
      """
      _ = /x/?.blah
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot use optional chaining on non-optional value of type 'Regex<Substring>'
        // TODO: Old parser expected error on line 1: value of type 'Regex<Substring>' has no member 'blah'
      ]
    )
  }

  func testForwardSlashRegex33() {
    AssertParse(
      """
      _ = /x/!.blah
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot force unwrap value of non-optional type 'Regex<Substring>'
        // TODO: Old parser expected error on line 1: value of type 'Regex<Substring>' has no member 'blah'
      ]
    )
  }

  func testForwardSlashRegex34() {
    AssertParse(
      """
      do {
        _ = /x /?
          .blah
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot find operator '/?' in scope
        // TODO: Old parser expected error on line 1: '/' is not a prefix unary operator
        // TODO: Old parser expected error on line 3: cannot infer contextual base in reference to member 'blah'
      ]
    )
  }

  func testForwardSlashRegex35() {
    AssertParse(
      """
      _ = /x/? 
        .blah
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot use optional chaining on non-optional value of type 'Regex<Substring>'
        // TODO: Old parser expected error on line 2: value of type 'Regex<Substring>' has no member 'blah'
      ]
    )
  }

  func testForwardSlashRegex36() {
    AssertParse(
      """
      _ = 0; /x/
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: regular expression literal is unused
      ]
    )
  }

  func testForwardSlashRegex37() {
    AssertParse(
      """
      do {
        _ = 0; /x /1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in 'do' statement"),
        // TODO: Old parser expected error on line 3: expected expression after operator
      ]
    )
  }

  func testForwardSlashRegex38() {
    AssertParse(
      """
      _ = /x/ ? 0 : 1 
      do {
        _ = /x / 1️⃣? 0 : 1 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot convert value of type 'Regex<Substring>' to expected condition type 'Bool'
        DiagnosticSpec(message: "expected expression in 'do' statement"),
        DiagnosticSpec(message: "unexpected code '? 0 : 1' in 'do' statement"),
        // TODO: Old parser expected error on line 3: expected expression after operator
      ]
    )
  }

  func testForwardSlashRegex39() {
    AssertParse(
      """
      _ = .random() ? /x/ : .blah
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: type 'Regex<Substring>' has no member 'blah'
      ]
    )
  }

  func testForwardSlashRegex40() {
    AssertParse(
      """
      _ = /x/ ?? /x/ 
      do {
        _ = /x / 1️⃣?? /x / 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: left side of nil coalescing operator '??' has non-optional type 'Regex<Substring>', so the right side is never used
        // TODO: Old parser expected error on line 3: unary operator cannot be separated from its operand
        DiagnosticSpec(message: "expected expression in 'do' statement"),
        DiagnosticSpec(message: "unexpected code '?? /x /' in 'do' statement"),
        // TODO: Old parser expected error on line 4: expected expression after operator
      ]
    )
  }

  func testForwardSlashRegex41() {
    AssertParse(
      """
      _ = /x/??/x/
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '/' is not a postfix unary operator
      ]
    )
  }

  func testForwardSlashRegex42() {
    AssertParse(
      """
      _ = /x/ ... /y/
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: referencing operator function '...' on 'Comparable' requires that 'Regex<Substring>' conform to 'Comparable'
      ]
    )
  }

  func testForwardSlashRegex43() {
    AssertParse(
      """
      _ = /x/.../y/
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: missing whitespace between '...' and '/' operators
        // TODO: Old parser expected error on line 1: '/' is not a postfix unary operator
      ]
    )
  }

  func testForwardSlashRegex44() {
    AssertParse(
      """
      _ = /x/...
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unary operator '...' cannot be applied to an operand of type 'Regex<Substring>'
        // TODO: Old parser expected note on line 1: overloads for '...' exist with these partially matching parameter lists
      ]
    )
  }

  func testForwardSlashRegex45() {
    AssertParse(
      """
      do {
        _ = /x1️⃣ /2️⃣...
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: '/' is not a prefix unary operator
        // TODO: Old parser expected error on line 2: consecutive statements on a line must be separated by ';'
        // TODO: Old parser expected error on line 2: operator with postfix spacing cannot start a subexpression
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in prefix operator expression"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '...' in 'do' statement"),
        // TODO: Old parser expected error on line 3: expected expression
      ]
    )
  }

  func testForwardSlashRegex46() {
    AssertParse(
      """
      do {
        _ = true / false /1️⃣; 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected expression after operator
        DiagnosticSpec(message: "expected expression in 'do' statement"),
      ]
    )
  }

  func testForwardSlashRegex47() {
    AssertParse(
      #"""
      _ = "\(/x/)"
      """#
    )
  }

  func testForwardSlashRegex48() {
    AssertParse(
      """
      func defaulted(x: Regex<Substring> = /x/) {}
      """
    )
  }

  func testForwardSlashRegex49() {
    AssertParse(
      """
      func foo<T>(_ x: T, y: T) {}
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 1: 'foo(_:y:)' declared here
      ]
    )
  }

  func testForwardSlashRegex50() {
    AssertParse(
      """
      foo(/abc/, y: /abc/)
      """
    )
  }

  func testForwardSlashRegex51() {
    AssertParse(
      """
      // TODO: The parser ought to have better recovery in cases where a binary
      // operator chain is missing an operand, currently we throw everything away.
      foo(/abc/, y: /abc /1️⃣)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: missing argument for parameter 'y' in call
        DiagnosticSpec(message: "expected expression in function call"),
        // TODO: Old parser expected error on line 3: expected expression after operator
      ]
    )
  }

  func testForwardSlashRegex52() {
    AssertParse(
      """
      func bar<T>(_ x: inout T) {}
      """
    )
  }

  func testForwardSlashRegex53() {
    AssertParse(
      """
      bar(&/x/)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot pass immutable value as inout argument: literals are not mutable
      ]
    )
  }

  func testForwardSlashRegex54() {
    AssertParse(
      """
      struct S {
        subscript(x: Regex<Substring>) -> Void { () } 
        subscript(fn: (Int, Int) -> Int) -> Int { 0 }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 2: 'subscript(_:)' declared here
      ]
    )
  }

  func testForwardSlashRegex55() {
    AssertParse(
      """
      func testSubscript(_ x: S) {
        x[/x/]
        x[/x /1️⃣]
        _ = x[/] / 2
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: missing argument for parameter #1 in call
        DiagnosticSpec(message: "expected expression in subscript"),
        // TODO: Old parser expected error on line 3: expected expression after operator
      ]
    )
  }

  func testForwardSlashRegex56() {
    AssertParse(
      """
      func testReturn() -> Regex<Substring> {
        if .random() {
          return /x/
        }
        return /x /1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in 'return' statement"),
        // TODO: Old parser expected error on line 6: expected expression after operator
      ]
    )
  }

  func testForwardSlashRegex57() {
    AssertParse(
      """
      func testThrow() throws {
        throw /x/ 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: thrown expression type 'Regex<Substring>' does not conform to 'Error'
      ]
    )
  }

  func testForwardSlashRegex58() {
    AssertParse(
      """
      do {
        _ = [/abc/, /abc /1️⃣] 
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in array element"),
        // TODO: Old parser expected error on line 2: expected expression after operator
      ]
    )
  }

  func testForwardSlashRegex59() {
    AssertParse(
      """
      do {
        _ = [/abc /1️⃣: /abc /2️⃣]
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected expression in dictionary element"),
        // TODO: Old parser expected error on line 2: expected expression after operator
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in dictionary element"),
      ]
    )
  }

  func testForwardSlashRegex60() {
    AssertParse(
      """
      _ = [/abc/:/abc/]
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: generic struct 'Dictionary' requires that 'Regex<Substring>' conform to 'Hashable'
      ]
    )
  }

  func testForwardSlashRegex61() {
    AssertParse(
      """
      _ = [/abc/ : /abc/]
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: generic struct 'Dictionary' requires that 'Regex<Substring>' conform to 'Hashable'
      ]
    )
  }

  func testForwardSlashRegex62() {
    AssertParse(
      """
      _ = [/abc/:/abc/]
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: generic struct 'Dictionary' requires that 'Regex<Substring>' conform to 'Hashable'
      ]
    )
  }

  func testForwardSlashRegex63() {
    AssertParse(
      """
      _ = [/abc/: /abc/]
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: generic struct 'Dictionary' requires that 'Regex<Substring>' conform to 'Hashable'
      ]
    )
  }

  func testForwardSlashRegex64() {
    AssertParse(
      """
      _ = (/abc/, /abc/)
      """
    )
  }

  func testForwardSlashRegex65() {
    AssertParse(
      """
      _ = ((/abc/))
      """
    )
  }

  func testForwardSlashRegex66() {
    AssertParse(
      """
      do {
        _ = ((/abc /1️⃣))
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in tuple"),
        // TODO: Old parser expected error on line 2: expected expression after operator
      ]
    )
  }

  func testForwardSlashRegex67() {
    AssertParse(
      """
      _ = { /abc/ }
      """
    )
  }

  func testForwardSlashRegex68() {
    AssertParse(
      """
      _ = {
        /abc/
      }
      """
    )
  }

  func testForwardSlashRegex69() {
    AssertParse(
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
    AssertParse(
      """
      let _: () -> Int = {
        0
        /1 / 
        2
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: '/' is not a prefix unary operator
      ]
    )
  }

  func testForwardSlashRegex71() {
    AssertParse(
      """
      _ = {
        0 
        /1/ 
        2 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 2: integer literal is unused
        // TODO: Old parser expected warning on line 3: regular expression literal is unused
        // TODO: Old parser expected warning on line 4: integer literal is unused
      ]
    )
  }

  func testForwardSlashRegex72() {
    AssertParse(
      """
      // Operator chain, as a regex literal may not start with space.
      """
    )
  }

  func testForwardSlashRegex73() {
    AssertParse(
      """
      _ = 2
      / 1 / .bitWidth
      """
    )
  }

  func testForwardSlashRegex74() {
    AssertParse(
      """
      _ = 2
      /1/ .bitWidth
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: value of type 'Regex<Substring>' has no member 'bitWidth'
      ]
    )
  }

  func testForwardSlashRegex75() {
    AssertParse(
      """
      _ = 2
      / 1 /
        .bitWidth
      """
    )
  }

  func testForwardSlashRegex76() {
    AssertParse(
      """
      _ = 2
      /1 /
        .bitWidth
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: '/' is not a prefix unary operator
      ]
    )
  }

  func testForwardSlashRegex77() {
    AssertParse(
      """
      _ = !!/1/ .bitWidth
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: value of type 'Regex<Substring>' has no member 'bitWidth'
      ]
    )
  }

  func testForwardSlashRegex78() {
    AssertParse(
      """
      _ = !!/1 / .bitWidth
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot find operator '!!/' in scope
      ]
    )
  }

  func testForwardSlashRegex79() {
    AssertParse(
      """
      let z =
      /y/
      """
    )
  }

  func testForwardSlashRegex80() {
    AssertParse(
      """
      // While '.' is technically an operator character, it seems more likely that
      // the user hasn't written the member name yet.
      """
    )
  }

  func testForwardSlashRegex81() {
    AssertParse(
      """
      _ = 01️⃣. / 1 / 2
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected member name following '.'
        DiagnosticSpec(message: "extraneous code '. / 1 / 2' at top level"),
      ]
    )
  }

  func testForwardSlashRegex82() {
    AssertParse(
      """
      _ = 0 . 1️⃣/ 1 / 2
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected member name following '.'
        DiagnosticSpec(message: "expected name in member access"),
      ]
    )
  }

  func testForwardSlashRegex83() {
    AssertParse(
      #"""
      switch "" {
      case _ where /x/:
        break
      default:
        break
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: cannot convert value of type 'Regex<Substring>' to expected condition type 'Bool'
      ]
    )
  }

  func testForwardSlashRegex84() {
    AssertParse(
      """
      do {} catch /x/ {}
      """
    )
  }

  func testForwardSlashRegex85() {
    AssertParse(
      """
      
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 0: expression pattern of type 'Regex<Substring>' cannot match values of type 'any Error'
        // TODO: Old parser expected error on line 0: binary operator '~=' cannot be applied to two 'any Error' operands
        // TODO: Old parser expected warning on line 0: 'catch' block is unreachable because no errors are thrown in 'do' block
      ]
    )
  }

  func testForwardSlashRegex86() {
    AssertParse(
      """
      switch /x/ {
      default:
        break
      }
      """
    )
  }

  func testForwardSlashRegex87() {
    AssertParse(
      """
      if /x/ {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot convert value of type 'Regex<Substring>' to expected condition type 'Bool'
      ]
    )
  }

  func testForwardSlashRegex88() {
    AssertParse(
      """
      if /x/.smth {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: value of type 'Regex<Substring>' has no member 'smth'
      ]
    )
  }

  func testForwardSlashRegex89() {
    AssertParse(
      """
      func testGuard() {
        guard /x/ else { return } 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: cannot convert value of type 'Regex<Substring>' to expected condition type 'Bool'
      ]
    )
  }

  func testForwardSlashRegex90() {
    AssertParse(
      """
      for x in [0] where /x/ {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot convert value of type 'Regex<Substring>' to expected condition type 'Bool'
      ]
    )
  }

  func testForwardSlashRegex91() {
    AssertParse(
      """
      typealias Magic<T> = T
      """
    )
  }

  func testForwardSlashRegex92() {
    AssertParse(
      """
      _ = /x/ as Magic
      """
    )
  }

  func testForwardSlashRegex93() {
    AssertParse(
      """
      _ = /x/ as! String
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: cast from 'Regex<Substring>' to unrelated type 'String' always fails
      ]
    )
  }

  func testForwardSlashRegex94() {
    AssertParse(
      """
      _ = type(of: /x/)
      """
    )
  }

  func testForwardSlashRegex95() {
    AssertParse(
      """
      do {
        let 1️⃣/x/ 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected pattern
        DiagnosticSpec(message: "expected pattern in variable"),
      ]
    )
  }

  func testForwardSlashRegex96() {
    AssertParse(
      """
      do {
        _ = try /x/; _ = try /x /1️⃣
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 2: no calls to throwing functions occur within 'try' expression
        DiagnosticSpec(message: "expected expression in 'do' statement"),
        // TODO: Old parser expected error on line 3: expected expression after operator
      ]
    )
  }

  func testForwardSlashRegex97() {
    AssertParse(
      """
      do {
        _ = try? /x/; _ = try? /x /1️⃣
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 2: no calls to throwing functions occur within 'try' expression
        DiagnosticSpec(message: "expected expression in 'do' statement"),
        // TODO: Old parser expected error on line 3: expected expression after operator
      ]
    )
  }

  func testForwardSlashRegex98() {
    AssertParse(
      """
      do {
        _ = try! /x/; _ = try! /x /1️⃣
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 2: no calls to throwing functions occur within 'try' expression
        DiagnosticSpec(message: "expected expression in 'do' statement"),
        // TODO: Old parser expected error on line 3: expected expression after operator
      ]
    )
  }

  func testForwardSlashRegex99() {
    AssertParse(
      """
      _ = await /x/
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: no 'async' operations occur within 'await' expression
      ]
    )
  }

  func testForwardSlashRegex100() {
    AssertParse(
      """
      /x/ = 0 
      /x/()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot assign to value: literals are not mutable
        // TODO: Old parser expected error on line 2: cannot call value of non-function type 'Regex<Substring>'
      ]
    )
  }

  func testForwardSlashRegex101() {
    AssertParse(
      """
      // We treat the following as comments, as it seems more likely the user has
      // written a comment and is still in the middle of writing the characters before
      // it.
      """
    )
  }

  func testForwardSlashRegex102() {
    AssertParse(
      """
      _ = /x// comment
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '/' is not a prefix unary operator
      ]
    )
  }

  func testForwardSlashRegex103() {
    AssertParse(
      """
      _ = /x // comment
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '/' is not a prefix unary operator
      ]
    )
  }

  func testForwardSlashRegex104() {
    AssertParse(
      """
      _ = /x/*comment*/
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '/' is not a prefix unary operator
      ]
    )
  }

  func testForwardSlashRegex105() {
    AssertParse(
      """
      // MARK: Unapplied operators
      """
    )
  }

  func testForwardSlashRegex106() {
    AssertParse(
      """
      // These become regex literals, unless last character is space, or are surrounded in parens.
      """
    )
  }

  func testForwardSlashRegex107() {
    AssertParse(
      """
      func baz(_ x: (Int, Int) -> Int, _ y: (Int, Int) -> Int) {} // expected-note 3{{'baz' declared here}}
      """
    )
  }

  func testForwardSlashRegex108() {
    AssertParse(
      """
      baz(/, /)
      baz(/,/)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: cannot convert value of type 'Regex<Substring>' to expected argument type '(Int, Int) -> Int'
        // TODO: Old parser expected error on line 2: missing argument for parameter #2 in call
      ]
    )
  }

  func testForwardSlashRegex109() {
    AssertParse(
      """
      baz((/), /)
      """
    )
  }

  func testForwardSlashRegex110() {
    AssertParse(
      """
      baz(/^, /)
      baz(/^,/)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: cannot convert value of type 'Regex<Substring>' to expected argument type '(Int, Int) -> Int'
        // TODO: Old parser expected error on line 2: missing argument for parameter #2 in call
      ]
    )
  }

  func testForwardSlashRegex111() {
    AssertParse(
      """
      baz((/^), /)
      """
    )
  }

  func testForwardSlashRegex112() {
    AssertParse(
      """
      baz(^^/, /)
      baz(^^/,/) 
      baz((^^/), /)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: missing argument for parameter #2 in call
      ]
    )
  }

  func testForwardSlashRegex113() {
    AssertParse(
      """
      func bazbaz(_ x: (Int, Int) -> Int, _ y: Int) {}
      """
    )
  }

  func testForwardSlashRegex114() {
    AssertParse(
      """
      bazbaz(/, 0)
      bazbaz(^^/, 0)
      """
    )
  }

  func testForwardSlashRegex115() {
    AssertParse(
      """
      func qux<T>(_ x: (Int, Int) -> Int, _ y: T) -> Int { 0 }
      """
    )
  }

  func testForwardSlashRegex116() {
    AssertParse(
      #"""
      _ = qux(/, 1) / 2
      do {
        _ = qux(/, "(") / 2
        _ = qux(/, "(")/1️⃣2
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 4: cannot convert value of type 'Regex<(Substring, Substring)>' to expected argument type '(Int, Int) -> Int'
        DiagnosticSpec(message: "expected ')' to end function call"),
        // TODO: Old parser expected error on line 4: expected ',' separator
      ]
    )
  }

  func testForwardSlashRegex117() {
    AssertParse(
      #"""
      _ = qux((/), "(") / 2
      """#
    )
  }

  func testForwardSlashRegex118() {
    AssertParse(
      """
      _ = qux(/, 1) // this comment tests to make sure we don't try and end the regex on the starting '/' of '//'.
      """
    )
  }

  func testForwardSlashRegex119() {
    AssertParse(
      """
      _ = qux(/, 1) /* same thing with a block comment */
      """
    )
  }

  func testForwardSlashRegex120() {
    AssertParse(
      """
      @discardableResult1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected declaration after attribute"),
      ]
    )
  }

  func testForwardSlashRegex121() {
    AssertParse(
      """
      func quxqux(_ x: (Int, Int) -> Int) -> Int { 0 }
      """
    )
  }

  func testForwardSlashRegex122() {
    AssertParse(
      """
      quxqux(/^/) 
      quxqux((/^/)) 
      quxqux({ $0 /^/ $1 })
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot convert value of type 'Regex<Substring>' to expected argument type '(Int, Int) -> Int'
        // TODO: Old parser expected error on line 2: cannot convert value of type 'Regex<Substring>' to expected argument type '(Int, Int) -> Int'
      ]
    )
  }

  func testForwardSlashRegex123() {
    AssertParse(
      """
      quxqux(!/^/)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot convert value of type 'Bool' to expected argument type '(Int, Int) -> Int'
        // TODO: Old parser expected error on line 1: cannot convert value of type 'Regex<Substring>' to expected argument type 'Bool'
      ]
    )
  }

  func testForwardSlashRegex124() {
    AssertParse(
      """
      quxqux(/^)
      """
    )
  }

  func testForwardSlashRegex125() {
    AssertParse(
      """
      _ = quxqux(/^) / 1
      """
    )
  }

  func testForwardSlashRegex126() {
    AssertParse(
      """
      let arr: [Double] = [2, 3, 4]
      """
    )
  }

  func testForwardSlashRegex127() {
    AssertParse(
      """
      _ = arr.reduce(1, /) / 3
      """
    )
  }

  func testForwardSlashRegex128() {
    AssertParse(
      """
      _ = arr.reduce(1, /) + arr.reduce(1, /)
      """
    )
  }

  func testForwardSlashRegex129() {
    AssertParse(
      """
      // MARK: ')' disambiguation behavior
      """
    )
  }

  func testForwardSlashRegex130() {
    AssertParse(
      """
      _ = (/x)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '/' is not a prefix unary operator
      ]
    )
  }

  func testForwardSlashRegex131() {
    AssertParse(
      """
      _ = (/x)/
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '/' is not a prefix unary operator
        // TODO: Old parser expected error on line 1: '/' is not a postfix unary operator
      ]
    )
  }

  func testForwardSlashRegex132() {
    AssertParse(
      """
      _ = (/[(0)])/
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '/' is not a prefix unary operator
        // TODO: Old parser expected error on line 1: '/' is not a postfix unary operator
      ]
    )
  }

  func testForwardSlashRegex133() {
    AssertParse(
      """
      _ = /[(0)]/
      """
    )
  }

  func testForwardSlashRegex134() {
    AssertParse(
      """
      _ = /(x)/
      """
    )
  }

  func testForwardSlashRegex135() {
    AssertParse(
      """
      _ = /[1️⃣)]/
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ']' to end array"),
        DiagnosticSpec(message: "extraneous code ')]/' at top level"),
      ]
    )
  }

  func testForwardSlashRegex136() {
    AssertParse(
      #"""
      _ = /[a\1️⃣]2️⃣)]/
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected root in key path"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code ')]/' at top level"),
      ]
    )
  }

  func testForwardSlashRegex137() {
    AssertParse(
      """
      _ = /([1️⃣)2️⃣])/
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ']' to end array"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code '])/' at top level"),
      ]
    )
  }

  func testForwardSlashRegex138() {
    AssertParse(
      """
      _ = 1️⃣/]]][)]/
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code '/]]][)]/' at top level"),
      ]
    )
  }

  func testForwardSlashRegex139() {
    AssertParse(
      """
      _ = 1️⃣/
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unterminated regex literal
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code '/' at top level"),
      ]
    )
  }

  func testForwardSlashRegex140() {
    AssertParse(
      """
      _ = 1️⃣/)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unterminated regex literal
        // TODO: Old parser expected error on line 1: closing ')' does not balance any groups openings
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code '/)' at top level"),
      ]
    )
  }

  func testForwardSlashRegex141() {
    AssertParse(
      """
      let fn: (Int, Int) -> Int = (/)
      """
    )
  }

  func testForwardSlashRegex142() {
    AssertParse(
      #"""
      _ = /\()1️⃣/
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '/' is not a prefix unary operator
        // TODO: Old parser expected error on line 1: '/' is not a postfix unary operator
        // TODO: Old parser expected error on line 1: invalid component of Swift key path
        DiagnosticSpec(message: "extraneous code '/' at top level"),
      ]
    )
  }

  func testForwardSlashRegex143() {
    AssertParse(
      #"""
      do {
        let _: Regex = (/whatever\)/1️⃣
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected note on line 2: to match this opening '('
        DiagnosticSpec(message: "expected ')' to end tuple"),
        // TODO: Old parser expected error on line 3: expected ')' in expression list
      ]
    )
  }

  func testForwardSlashRegex144() {
    AssertParse(
      """
      do {
        _ = /(()())1️⃣)/
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: '/' is not a prefix unary operator
        // TODO: Old parser expected error on line 2: consecutive statements on a line must be separated by ';'
        // TODO: Old parser expected error on line 2: expected expression
        // TODO: Old parser expected error on line 2: cannot call value of non-function type '()'
        DiagnosticSpec(message: "unexpected code ')/' in 'do' statement"),
      ]
    )
  }

  func testForwardSlashRegex145() {
    AssertParse(
      """
      do {
        _ = /[x]1️⃣)/
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: '/' is not a prefix unary operator
        // TODO: Old parser expected error on line 2: consecutive statements on a line must be separated by ';'
        // TODO: Old parser expected error on line 2: expected expression
        DiagnosticSpec(message: "unexpected code ')/' in 'do' statement"),
      ]
    )
  }

  func testForwardSlashRegex146() {
    AssertParse(
      #"""
      do {
        _ = /[\1️⃣]2️⃣])/
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected expression path in Swift key path
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected root in key path"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '])/' in 'do' statement"),
      ]
    )
  }

  func testForwardSlashRegex147() {
    AssertParse(
      """
      _ = ^/x/
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '^' is not a prefix unary operator
      ]
    )
  }

  func testForwardSlashRegex148() {
    AssertParse(
      """
      _ = (^/x)/
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '/' is not a postfix unary operator
      ]
    )
  }

  func testForwardSlashRegex149() {
    AssertParse(
      """
      _ = (!!/x/)
      """
    )
  }

  func testForwardSlashRegex150() {
    AssertParse(
      #"""
      _ = ^/"/"
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '^' is not a prefix unary operator
        // TODO: Old parser expected error on line 1: unterminated string literal
      ]
    )
  }

  func testForwardSlashRegex151() {
    AssertParse(
      #"""
      _ = ^/"[/"
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '^' is not a prefix unary operator
        // TODO: Old parser expected error on line 1: unterminated string literal
        // TODO: Old parser expected error on line 1: expected custom character class members
      ]
    )
  }

  func testForwardSlashRegex152() {
    AssertParse(
      #"""
      _ = (^/)("/")
      """#
    )
  }

  func testForwardSlashRegex153() {
    AssertParse(
      """
      // MARK: Starting characters
      """
    )
  }

  func testForwardSlashRegex154() {
    AssertParse(
      """
      // Fine.
      """
    )
  }

  func testForwardSlashRegex155() {
    AssertParse(
      """
      _ = /./
      """
    )
  }

  func testForwardSlashRegex156() {
    AssertParse(
      """
      // You need to escape if you want a regex literal to start with these characters.
      """
    )
  }

  func testForwardSlashRegex157() {
    AssertParse(
      #"""
      _ = /\ 1️⃣/2️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected root in key path"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression"),
      ]
    )
  }

  func testForwardSlashRegex158() {
    AssertParse(
      """
      _ = 1️⃣/ /
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: regex literal may not start with space; add backslash to escape, Fix-It replacements: 6 - 6 = '\'
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code '/ /' at top level"),
      ]
    )
  }

  func testForwardSlashRegex159() {
    AssertParse(
      """
      _ = 1️⃣/  /
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: regex literal may not start with space; add backslash to escape, Fix-It replacements: 6 - 6 = '\'
        // TODO: Old parser expected error on line 1: regex literal may not end with space; use extended literal instead, Fix-It replacements: 5 - 5 = '#', 9 - 9 = '#'
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code '/  /' at top level"),
      ]
    )
  }

  func testForwardSlashRegex160() {
    AssertParse(
      """
      _ = #/  /#
      """
    )
  }

  func testForwardSlashRegex161() {
    AssertParse(
      #"""
      _ = /x1️⃣\ 2️⃣/3️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected root in key path"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected expression"),
      ]
    )
  }

  func testForwardSlashRegex162() {
    AssertParse(
      #"""
      _ = /\ 1️⃣\ 2️⃣/3️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected root in key path"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected root in key path"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected expression"),
      ]
    )
  }

  func testForwardSlashRegex163() {
    AssertParse(
      """
      // There are intentionally trailing spaces here
      """
    )
  }

  func testForwardSlashRegex164() {
    AssertParse(
      """
      _ = 1️⃣/
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unterminated regex literal
        // TODO: Old parser expected error on line 1: regex literal may not start with space; add backslash to escape, Fix-It replacements: 6 - 6 = '\'
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code '/' at top level"),
      ]
    )
  }

  func testForwardSlashRegex165() {
    AssertParse(
      """
      // There are intentionally trailing spaces here
      """
    )
  }

  func testForwardSlashRegex166() {
    AssertParse(
      """
      _ = 1️⃣/^
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unterminated regex literal
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code '/^' at top level"),
      ]
    )
  }

  func testForwardSlashRegex167() {
    AssertParse(
      #"""
      _ = /\)/
      """#
    )
  }

  func testForwardSlashRegex168() {
    AssertParse(
      """
      _ = 1️⃣/)/
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: closing ')' does not balance any groups openings
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code '/)/' at top level"),
      ]
    )
  }

  func testForwardSlashRegex169() {
    AssertParse(
      """
      _ = /,/
      """
    )
  }

  func testForwardSlashRegex170() {
    AssertParse(
      """
      _ = /}/
      """
    )
  }

  func testForwardSlashRegex171() {
    AssertParse(
      """
      _ = /]/
      """
    )
  }

  func testForwardSlashRegex172() {
    AssertParse(
      """
      _ = /:/
      """
    )
  }

  func testForwardSlashRegex173() {
    AssertParse(
      """
      _ = /;/
      """
    )
  }

  func testForwardSlashRegex174() {
    AssertParse(
      """
      // Don't emit diagnostics here, as we re-lex.
      """
    )
  }

  func testForwardSlashRegex175() {
    AssertParse(
      """
      _ = /0xG/
      """
    )
  }

  func testForwardSlashRegex176() {
    AssertParse(
      """
      _ = /0oG/
      """
    )
  }

  func testForwardSlashRegex177() {
    AssertParse(
      #"""
      _ = /"/
      """#
    )
  }

  func testForwardSlashRegex178() {
    AssertParse(
      """
      _ = /'/
      """
    )
  }

  func testForwardSlashRegex179() {
    AssertParse(
      """
      _ = /<#placeholder#>/
      """
    )
  }

  func testForwardSlashRegex180() {
    AssertParse(
      """
      _ = ^^/1️⃣0xG/
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in prefix operator expression"),
        DiagnosticSpec(message: "extraneous code '0xG/' at top level"),
      ]
    )
  }

  func testForwardSlashRegex181() {
    AssertParse(
      """
      _ = ^^/1️⃣0oG/
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in prefix operator expression"),
        DiagnosticSpec(message: "extraneous code '0oG/' at top level"),
      ]
    )
  }

  func testForwardSlashRegex182() {
    AssertParse(
      #"""
      _ = ^^/"/1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"expected '"' to end string literal"#),
      ]
    )
  }

  func testForwardSlashRegex183() {
    AssertParse(
      """
      _ = ^^/'/1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ''' in string literal"),
      ]
    )
  }

  func testForwardSlashRegex184() {
    AssertParse(
      """
      _ = ^^/<#placeholder#>/
      """
    )
  }

  func testForwardSlashRegex185() {
    AssertParse(
      """
      _ = (^^/1️⃣0xG/)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in prefix operator expression"),
        DiagnosticSpec(message: "unexpected code '0xG/' in tuple"),
      ]
    )
  }

  func testForwardSlashRegex186() {
    AssertParse(
      """
      _ = (^^/1️⃣0oG/)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in prefix operator expression"),
        DiagnosticSpec(message: "unexpected code '0oG/' in tuple"),
      ]
    )
  }

  func testForwardSlashRegex187() {
    AssertParse(
      #"""
      _ = (^^/"/)1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"expected '"' to end string literal"#),
        DiagnosticSpec(message: "expected ')' to end tuple"),
      ]
    )
  }

  func testForwardSlashRegex188() {
    AssertParse(
      """
      _ = (^^/'/)1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ''' in string literal"),
        DiagnosticSpec(message: "expected ')' to end tuple"),
      ]
    )
  }

  func testForwardSlashRegex189() {
    AssertParse(
      """
      _ = (^^/<#placeholder#>/)
      """
    )
  }

}
