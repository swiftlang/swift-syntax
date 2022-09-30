// This test file has been translated from swift/test/Parse/switch.swift

import XCTest

final class SwitchTests: XCTestCase {
  func testSwitch1() {
    AssertParse(
      """
      // TODO: Implement tuple equality in the library.
      // BLOCKED: <rdar://problem/13822406>
      func ~= (x: (Int,Int), y: (Int,Int)) -> Bool {
        return true
      }
      """
    )
  }

  func testSwitch2() {
    AssertParse(
      """
      func parseError1(x: Int) {
        switch #^DIAG_1^#func #^DIAG_2^#{} 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected expression in 'switch' statement
        // TODO: Old parser expected error on line 2: expected identifier in function declaration
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected expression and '{}' to end 'switch' statement"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected identifier in function"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected argument list in function declaration"),
      ]
    )
  }

  func testSwitch3() {
    AssertParse(
      """
      func parseError2(x: Int) {
        switch x #^DIAG_1^#
      }#^DIAG_2^#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '{' after 'switch' subject expression
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected '{' in 'switch' statement"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected '}' to end function"),
      ]
    )
  }

  func testSwitch4() {
    AssertParse(
      """
      func parseError3(x: Int) {
        switch x {
          case #^DIAG^#
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: expected pattern
        // TODO: Old parser expected error on line 3: expected ':' after 'case'
        DiagnosticSpec(message: "expected expression in pattern"),
        DiagnosticSpec(message: "expected ':' in switch case"),
      ]
    )
  }

  func testSwitch5() {
    AssertParse(
      """
      func parseError4(x: Int) {
        switch x {
        case var z where #^DIAG^#
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: expected expression for 'where' guard of 'case'
        // TODO: Old parser expected error on line 3: expected ':' after 'case'
        DiagnosticSpec(message: "expected expression in 'where' clause"),
        DiagnosticSpec(message: "expected ':' in switch case"),
      ]
    )
  }

  func testSwitch6() {
    AssertParse(
      """
      func parseError5(x: Int) {
        switch x {
        case let z #^DIAG^#
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: expected ':' after 'case'
        DiagnosticSpec(message: "expected ':' in switch case"),
      ]
    )
  }

  func testSwitch7() {
    AssertParse(
      """
      func parseError6(x: Int) {
        switch x {
        default #^DIAG^#
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: expected ':' after 'default'
        DiagnosticSpec(message: "expected ':' in switch case"),
      ]
    )
  }

  func testSwitch8() {
    AssertParse(
      """
      var x: Int
      """
    )
  }

  func testSwitch9() {
    AssertParse(
      """
      switch x {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'switch' statement body must have at least one 'case' or 'default' block
      ]
    )
  }

  func testSwitch10() {
    AssertParse(
      """
      switch x {
      case 0:
        x = 0
      // Multiple patterns per case
      case 1, 2, 3:
        x = 0
      // 'where' guard
      case _ where x % 2 == 0:
        x = 1
        x = 2
        x = 3
      case _ where x % 2 == 0,
           _ where x % 3 == 0:
        x = 1
      case 10,
           _ where x % 3 == 0:
        x = 1
      case _ where x % 2 == 0,
           20:
        x = 1
      case var y where y % 2 == 0:
        x = y + 1
      case _ where 0: 
        x = 0
      default:
        x = 1
      }
      """
    )
  }

  func testSwitch11() {
    AssertParse(
      """
      // Multiple cases per case block
      switch x { 
      case 0: 
      case 1:
        x = 0
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: 'case' label in a 'switch' must have at least one executable statement, Fix-It replacements: 8 - 8 = ' break'
      ]
    )
  }

  func testSwitch12() {
    AssertParse(
      """
      switch x {
      case 0: 
      default:
        x = 0
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'case' label in a 'switch' must have at least one executable statement, Fix-It replacements: 8 - 8 = ' break'
      ]
    )
  }

  func testSwitch13() {
    AssertParse(
      """
      switch x { 
      case 0:
        x = 0
      case 1: 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: 'case' label in a 'switch' must have at least one executable statement, Fix-It replacements: 8 - 8 = ' break'
      ]
    )
  }

  func testSwitch14() {
    AssertParse(
      """
      switch x {
      case 0:
        x = 0
      default: 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: 'default' label in a 'switch' must have at least one executable statement, Fix-It replacements: 9 - 9 = ' break'
      ]
    )
  }

  func testSwitch15() {
    AssertParse(
      """
      switch x { 
      case 0:#^DIAG^#
        ; 
      case 1:
        x = 0
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in switch case"),
        // TODO: Old parser expected error on line 3: ';' statements are not allowed, Fix-It replacements: 3 - 5 = ''
      ]
    )
  }

  func testSwitch16() {
    AssertParse(
      """
      switch x {
        #^DIAG^#x = 1 
      default:
        x = 0
      case 0: 
        x = 0
      case 1:
        x = 0
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: all statements inside a switch must be covered by a 'case' or 'default'
        DiagnosticSpec(message: "unexpected text 'x = 1' in switch case"),
        // TODO: Old parser expected error on line 5: additional 'case' blocks cannot appear after the 'default' block of a 'switch'
      ]
    )
  }

  func testSwitch17() {
    AssertParse(
      """
      switch x {
      default:
        x = 0
      default: 
        x = 0
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: additional 'case' blocks cannot appear after the 'default' block of a 'switch'
      ]
    )
  }

  func testSwitch18() {
    AssertParse(
      """
      switch x { 
        #^DIAG^#x = 1 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'switch' statement body must have at least one 'case' or 'default' block
        // TODO: Old parser expected error on line 2: all statements inside a switch must be covered by a 'case' or 'default'
        DiagnosticSpec(message: "unexpected text 'x = 1' in 'switch' statement"),
      ]
    )
  }

  func testSwitch19() {
    AssertParse(
      """
      switch x { 
        #^DIAG^#x = 1 
        x = 2
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'switch' statement body must have at least one 'case' or 'default' block
        // TODO: Old parser expected error on line 2: all statements inside a switch must be covered by a 'case' or 'default'
        DiagnosticSpec(message: "unexpected text in 'switch' statement"),
      ]
    )
  }

  func testSwitch20() {
    AssertParse(
      """
      switch x {
      default: 
      case 0: 
        x = 0
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'default' label in a 'switch' must have at least one executable statement, Fix-It replacements: 9 - 9 = ' break'
        // TODO: Old parser expected error on line 3: additional 'case' blocks cannot appear after the 'default' block of a 'switch'
      ]
    )
  }

  func testSwitch21() {
    AssertParse(
      """
      switch x {
      default: 
      default: 
        x = 0
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'default' label in a 'switch' must have at least one executable statement, Fix-It replacements: 9 - 9 = ' break'
        // TODO: Old parser expected error on line 3: additional 'case' blocks cannot appear after the 'default' block of a 'switch'
      ]
    )
  }

  func testSwitch22() {
    AssertParse(
      """
      switch x { 
      default #^DIAG^#where x == 0: 
        x = 0
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'default' cannot be used with a 'where' guard expression
        DiagnosticSpec(message: "unexpected text 'where x == 0' in switch case"),
      ]
    )
  }

  func testSwitch23() {
    AssertParse(
      """
      switch x { 
      case 0: 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'case' label in a 'switch' must have at least one executable statement, Fix-It replacements: 8 - 8 = ' break'
      ]
    )
  }

  func testSwitch24() {
    AssertParse(
      """
      switch x { 
      case 0: 
      case 1:
        x = 0
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'case' label in a 'switch' must have at least one executable statement, Fix-It replacements: 8 - 8 = ' break'
      ]
    )
  }

  func testSwitch25() {
    AssertParse(
      """
      switch x { 
      case 0:
        x = 0
      case 1: 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: 'case' label in a 'switch' must have at least one executable statement, Fix-It replacements: 8 - 8 = ' break'
      ]
    )
  }

  func testSwitch26() {
    AssertParse(
      """
      #^DIAG^#case 0: 
      var y = 0
      default: 
      var z = 1
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'case' label can only appear inside a 'switch' statement
        DiagnosticSpec(message: "extraneous code at top level"),
        // TODO: Old parser expected error on line 3: 'default' label can only appear inside a 'switch' statement
      ]
    )
  }

  func testSwitch27() {
    AssertParse(
      """
      fallthrough
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'fallthrough' is only allowed inside a switch
      ]
    )
  }

  func testSwitch28() {
    AssertParse(
      """
      switch x {
      case 0:
        fallthrough
      case 1:
        fallthrough
      default:
        fallthrough 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 7: 'fallthrough' without a following 'case' or 'default' block
      ]
    )
  }

  func testSwitch29() {
    AssertParse(
      """
      // Fallthrough can transfer control anywhere within a case and can appear
      // multiple times in the same case.
      switch x {
      case 0:
        if true { fallthrough }
        if false { fallthrough }
        x += 1
      default:
        x += 1
      }
      """
    )
  }

  func testSwitch30() {
    AssertParse(
      """
      // Cases cannot contain 'var' bindings if there are multiple matching patterns
      // attached to a block. They may however contain other non-binding patterns.
      """
    )
  }

  func testSwitch31() {
    AssertParse(
      """
      var t = (1, 2)
      """
    )
  }

  func testSwitch32() {
    AssertParse(
      """
      switch t {
      case (var a, 2), (1, _): 
        ()
      case (_, 2), (var a, _): 
        ()
      case (var a, 2), (1, var b): 
        ()
      case (var a, 2): 
      case (1, _):
        ()
      case (_, 2): 
      case (1, var a): 
        ()
      case (var a, 2): 
      case (1, var b): 
        ()
      case (1, let b): // let bindings expected-warning {{immutable value 'b' was never used; consider replacing with '_' or removing it}}
        ()
      case (_, 2), (let a, _): 
        ()
      // OK
      case (_, 2), (1, _):
        ()
      case (_, var a), (_, var a): 
        ()
      case (var a, var b), (var b, var a): 
        ()
      case (_, 2): 
      case (1, _):
        ()
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 8: 'case' label in a 'switch' must have at least one executable statement, Fix-It replacements: 17 - 17 = ' break'
        // TODO: Old parser expected error on line 11: 'case' label in a 'switch' must have at least one executable statement, Fix-It replacements: 13 - 13 = ' break'
        // TODO: Old parser expected error on line 14: 'case' label in a 'switch' must have at least one executable statement, Fix-It replacements: 17 - 17 = ' break'
        // TODO: Old parser expected error on line 28: 'case' label in a 'switch' must have at least one executable statement, Fix-It replacements: 13 - 13 = ' break'
      ]
    )
  }

  func testSwitch33() {
    AssertParse(
      """
      func patternVarUsedInAnotherPattern(x: Int) {
        switch x {
        case let a, 
             value: 
          break
        }
      }
      """
    )
  }

  func testSwitch34() {
    AssertParse(
      """
      // Fallthroughs can only transfer control into a case label with bindings if the previous case binds a superset of those vars.
      switch t {
      case (1, 2):
        fallthrough 
      case (var a, var b): 
        t = (b, a)
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: 'fallthrough' from a case which doesn't bind variable 'a'
        // TODO: Old parser expected error on line 4: 'fallthrough' from a case which doesn't bind variable 'b'
        // TODO: Old parser expected warning on line 5: variable 'a' was never mutated; consider changing to 'let' constant
        // TODO: Old parser expected warning on line 5: variable 'b' was never mutated; consider changing to 'let' constant
      ]
    )
  }

  func testSwitch35() {
    AssertParse(
      """
      switch t { // specifically notice on next line that we shouldn't complain that a is unused - just never mutated
      case (var a, let b): 
        t = (b, b)
        fallthrough // ok - notice that subset of bound variables falling through is fine
      case (2, let a):
        t = (a, a)
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 2: variable 'a' was never mutated; consider changing to 'let' constant
      ]
    )
  }

  func testSwitch36() {
    AssertParse(
      """
      func patternVarDiffType(x: Int, y: Double) {
        switch (x, y) {
        case (1, let a): 
          fallthrough
        case (let a, _):
          break
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: pattern variable bound to type 'Double', fallthrough case bound to type 'Int'
      ]
    )
  }

  func testSwitch37() {
    AssertParse(
      """
      func patternVarDiffMutability(x: Int, y: Double) {
        switch x {
        case let a where a < 5, var a where a > 10: 
          break
        default:
          break
        }
        switch (x, y) {
        // Would be nice to have a fixit in the following line if we detect that all bindings in the same pattern have the same problem.
        case let (a, b) where a < 5, var (a, b) where a > 10: // expected-error 2{{'var' pattern binding must match previous 'let' pattern binding}}{{none}}
          break
        case (let a, var b) where a < 5, (let a, let b) where a > 10: 
          break
        case (let a, let b) where a < 5, (var a, let b) where a > 10, (let a, var b) where a == 8:
          break
        default:
          break
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: 'var' pattern binding must match previous 'let' pattern binding, Fix-It replacements: 27 - 30 = 'let'
        // TODO: Old parser expected error on line 12: 'let' pattern binding must match previous 'var' pattern binding, Fix-It replacements: 44 - 47 = 'var'
        // TODO: Old parser expected error on line 14: 'var' pattern binding must match previous 'let' pattern binding, Fix-It replacements: 37 - 40 = 'let'
        // TODO: Old parser expected error on line 14: 'var' pattern binding must match previous 'let' pattern binding, Fix-It replacements: 73 - 76 = 'let'
      ]
    )
  }

  func testSwitch38() {
    AssertParse(
      """
      func test_label(x : Int) {
      Gronk: 
        switch x {
        case 42: return
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: switch must be exhaustive
        // TODO: Old parser expected note on line 2: do you want to add a default clause?
      ]
    )
  }

  func testSwitch39() {
    AssertParse(
      """
      func enumElementSyntaxOnTuple() {
        switch (1, 1) {
        case .Bar: 
          break
        default:
          break
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: value of tuple type '(Int, Int)' has no member 'Bar'
      ]
    )
  }

  func testSwitch40() {
    AssertParse(
      """
      // https://github.com/apple/swift/issues/42798
      enum Whatever { case Thing }
      func f0(values: [Whatever]) { 
          switch value { 
          case .Thing: // Ok. Don't emit diagnostics about enum case not found in type <<error type>>.
              break
          }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 3: 'values' declared here
        // TODO: Old parser expected error on line 4: cannot find 'value' in scope; did you mean 'values'?
      ]
    )
  }

  func testSwitch41() {
    AssertParse(
      #"""
      // https://github.com/apple/swift/issues/43334
      // https://github.com/apple/swift/issues/43335
      enum Whichever {
        case Thing
        static let title = "title"
        static let alias: Whichever = .Thing
      }
      func f1(x: String, y: Whichever) {
        switch x {
          case Whichever.title: // Ok. Don't emit diagnostics for static member of enum.
              break
          case Whichever.buzz: 
              break
          case Whichever.alias: 
          default:
            break
        }
        switch y {
          case Whichever.Thing: // Ok.
              break
          case Whichever.alias: // Ok. Don't emit diagnostics for static member of enum.
              break
          case Whichever.title: 
              break
        }
        switch y {
          case .alias:
            break
          default:
            break
        }
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 12: type 'Whichever' has no member 'buzz'
        // TODO: Old parser expected error on line 14: expression pattern of type 'Whichever' cannot match values of type 'String'
        // TODO: Old parser expected note on line 14: overloads for '~=' exist
        // TODO: Old parser expected error on line 14: 'case' label in a 'switch' must have at least one executable statement
        // TODO: Old parser expected error on line 23: expression pattern of type 'String' cannot match values of type 'Whichever'
      ]
    )
  }

  func testSwitch42() {
    AssertParse(
      """
      switch Whatever.Thing {
      case .Thing: 
      @unknown case _:
        x = 0
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'case' label in a 'switch' must have at least one executable statement, Fix-It replacements: 13 - 13 = ' break'
      ]
    )
  }

  func testSwitch43() {
    AssertParse(
      """
      switch Whatever.Thing {
      case .Thing: 
      @unknown default:
        x = 0
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'case' label in a 'switch' must have at least one executable statement, Fix-It replacements: 13 - 13 = ' break'
      ]
    )
  }

  func testSwitch44() {
    AssertParse(
      """
      switch Whatever.Thing {
      case .Thing:
        x = 0
      @unknown case _: 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: 'case' label in a 'switch' must have at least one executable statement, Fix-It replacements: 17 - 17 = ' break'
      ]
    )
  }

  func testSwitch45() {
    AssertParse(
      """
      switch Whatever.Thing {
      case .Thing:
        x = 0
      @unknown default: 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: 'default' label in a 'switch' must have at least one executable statement, Fix-It replacements: 18 - 18 = ' break'
      ]
    )
  }

  func testSwitch46() {
    AssertParse(
      """
      switch Whatever.Thing {
      @unknown default:
        x = 0
      default: 
        x = 0
      case .Thing:
        x = 0
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: additional 'case' blocks cannot appear after the 'default' block of a 'switch'
      ]
    )
  }

  func testSwitch47() {
    AssertParse(
      """
      switch Whatever.Thing {
      default:
        x = 0
      @unknown case _: 
        x = 0
      case .Thing:
        x = 0
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: additional 'case' blocks cannot appear after the 'default' block of a 'switch'
        // TODO: Old parser expected error on line 4: '@unknown' can only be applied to the last case in a switch
      ]
    )
  }

  func testSwitch48() {
    AssertParse(
      """
      switch Whatever.Thing {
      default:
        x = 0
      @unknown default: 
        x = 0
      case .Thing:
        x = 0
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: additional 'case' blocks cannot appear after the 'default' block of a 'switch'
      ]
    )
  }

  func testSwitch49() {
    AssertParse(
      """
      switch Whatever.Thing { 
      @unknown default #^DIAG^#where x == 0: 
        x = 0
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: switch must be exhaustive
        // TODO: Old parser expected note on line 1: add missing case: '.Thing'
        // TODO: Old parser expected error on line 2: 'default' cannot be used with a 'where' guard expression
        DiagnosticSpec(message: "unexpected text 'where x == 0' in switch case"),
      ]
    )
  }

  func testSwitch50() {
    AssertParse(
      """
      switch Whatever.Thing { 
      @unknown case _:
        fallthrough 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: switch must be exhaustive
        // TODO: Old parser expected note on line 1: add missing case: '.Thing'
        // TODO: Old parser expected error on line 3: 'fallthrough' without a following 'case' or 'default' block
      ]
    )
  }

  func testSwitch51() {
    AssertParse(
      """
      switch Whatever.Thing {
      @unknown case _: 
        fallthrough
      case .Thing:
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: '@unknown' can only be applied to the last case in a switch
      ]
    )
  }

  func testSwitch52() {
    AssertParse(
      """
      switch Whatever.Thing {
      @unknown default:
        fallthrough
      case .Thing: 
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: additional 'case' blocks cannot appear after the 'default' block of a 'switch'
      ]
    )
  }

  func testSwitch53() {
    AssertParse(
      """
      switch Whatever.Thing {
      @unknown case _, _: 
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: '@unknown' cannot be applied to multiple patterns
      ]
    )
  }

  func testSwitch54() {
    AssertParse(
      """
      switch Whatever.Thing {
      @unknown case _, _, _: 
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: '@unknown' cannot be applied to multiple patterns
      ]
    )
  }

  func testSwitch55() {
    AssertParse(
      """
      switch Whatever.Thing { 
      @unknown case let value: 
        _ = value
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: switch must be exhaustive
        // TODO: Old parser expected note on line 1: add missing case: '.Thing'
        // TODO: Old parser expected error on line 2: '@unknown' is only supported for catch-all cases ("case _")
      ]
    )
  }

  func testSwitch56() {
    AssertParse(
      """
      switch (Whatever.Thing, Whatever.Thing) { 
      @unknown case (_, _): 
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: switch must be exhaustive
        // TODO: Old parser expected note on line 1: add missing case: '(_, _)'
        // TODO: Old parser expected error on line 2: '@unknown' is only supported for catch-all cases ("case _")
      ]
    )
  }

  func testSwitch57() {
    AssertParse(
      """
      switch Whatever.Thing { 
      @unknown case is Whatever: 
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: switch must be exhaustive
        // TODO: Old parser expected note on line 1: add missing case: '.Thing'
        // TODO: Old parser expected error on line 2: '@unknown' is only supported for catch-all cases ("case _")
        // TODO: Old parser expected warning on line 2: 'is' test is always true
      ]
    )
  }

  func testSwitch58() {
    AssertParse(
      """
      switch Whatever.Thing { 
      @unknown case .Thing: 
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: switch must be exhaustive
        // TODO: Old parser expected note on line 1: add missing case: '.Thing'
        // TODO: Old parser expected error on line 2: '@unknown' is only supported for catch-all cases ("case _")
      ]
    )
  }

  func testSwitch59() {
    AssertParse(
      """
      switch Whatever.Thing { 
      @unknown case (_): // okay
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: switch must be exhaustive
        // TODO: Old parser expected note on line 1: add missing case: '.Thing'
      ]
    )
  }

  func testSwitch60() {
    AssertParse(
      """
      switch Whatever.Thing { 
      @unknown case _ where x == 0: 
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: switch must be exhaustive
        // TODO: Old parser expected note on line 1: add missing case: '.Thing'
        // TODO: Old parser expected error on line 2: 'where' cannot be used with '@unknown'
      ]
    )
  }

  func testSwitch61() {
    AssertParse(
      """
      switch Whatever.Thing { 
      @unknown default #^DIAG^#where x == 0: 
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: switch must be exhaustive
        // TODO: Old parser expected note on line 1: add missing case: '.Thing'
        // TODO: Old parser expected error on line 2: 'default' cannot be used with a 'where' guard expression
        DiagnosticSpec(message: "unexpected text 'where x == 0' in switch case"),
      ]
    )
  }

  func testSwitch62() {
    AssertParse(
      """
      switch Whatever.Thing {
      case .Thing:
        x = 0
      #if true
      @unknown case _:
        x = 0
      #endif
      }
      """
    )
  }

  func testSwitch63() {
    AssertParse(
      """
      switch x {
      case 0:
        break
      @garbage case _: 
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: unknown attribute 'garbage'
      ]
    )
  }

  func testSwitch64() {
    AssertParse(
      """
      switch x {
      case 0:
        break
      @garbage @moreGarbage default: 
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: unknown attribute 'garbage'
        // TODO: Old parser expected error on line 4: unknown attribute 'moreGarbage'
      ]
    )
  }

  func testSwitch65() {
    AssertParse(
      """
      @unknown let _ = 1
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unknown attribute 'unknown'
      ]
    )
  }

  func testSwitch66() {
    AssertParse(
      """
      switch x {
      case _:
        @unknown let _ = 1 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: unknown attribute 'unknown'
      ]
    )
  }

  func testSwitch67() {
    AssertParse(
      """
      switch Whatever.Thing {
      case .Thing:
        break
      @unknown#^DIAG_1^#(garbage) case _: 
        break
      }
      switch Whatever.Thing {
      case .Thing:
        break
      @unknown 
      @unknown 
      case _:
        break
      }
      switch Whatever.Thing { 
      @unknown @garbage#^DIAG_2^#(foobar) 
      case _:
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: unexpected '(' in attribute 'unknown'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text '(garbage)' in switch case"),
        // TODO: Old parser expected note on line 10: attribute already specified here
        // TODO: Old parser expected error on line 11: duplicate attribute
        // TODO: Old parser expected warning on line 15: switch must be exhaustive
        // TODO: Old parser expected note on line 15: add missing case: '.Thing'
        // TODO: Old parser expected error on line 16: unknown attribute 'garbage'
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text '(foobar)' in switch case"),
      ]
    )
  }

  func testSwitch68() {
    AssertParse(
      """
      switch x { 
      case 1:
        break
      @unknown case _: 
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: switch must be exhaustive
        // TODO: Old parser expected note on line 4: remove '@unknown' to handle remaining values, Fix-It replacements: 1 - 10 = ''
      ]
    )
  }

  func testSwitch69() {
    AssertParse(
      """
      switch x { 
      @unknown case _: 
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: switch must be exhaustive
        // TODO: Old parser expected note on line 2: remove '@unknown' to handle remaining values, Fix-It replacements: 1 - 10 = ''
      ]
    )
  }

  func testSwitch70() {
    AssertParse(
      """
      switch x { 
      @unknown default: 
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: switch must be exhaustive
        // TODO: Old parser expected note on line 2: remove '@unknown' to handle remaining values, Fix-It replacements: 1 - 10 = ''
      ]
    )
  }

  func testSwitch71() {
    AssertParse(
      """
      switch Whatever.Thing {
      case .Thing:
        break
      @unknown case _: 
        break
      @unknown case _:
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: '@unknown' can only be applied to the last case in a switch
      ]
    )
  }

  func testSwitch72() {
    AssertParse(
      """
      switch Whatever.Thing {
      case .Thing:
        break
      @unknown case _: 
        break
      @unknown default:
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: '@unknown' can only be applied to the last case in a switch
      ]
    )
  }

  func testSwitch73() {
    AssertParse(
      """
      switch Whatever.Thing {
      case .Thing:
        break
      @unknown default:
        break
      @unknown default: 
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 6: additional 'case' blocks cannot appear after the 'default' block of a 'switch'
      ]
    )
  }

  func testSwitch74() {
    AssertParse(
      """
      switch Whatever.Thing {
      @unknown case _: 
        break
      @unknown case _:
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: '@unknown' can only be applied to the last case in a switch
      ]
    )
  }

  func testSwitch75() {
    AssertParse(
      """
      switch Whatever.Thing {
      @unknown case _: 
        break
      @unknown default:
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: '@unknown' can only be applied to the last case in a switch
      ]
    )
  }

  func testSwitch76() {
    AssertParse(
      """
      switch Whatever.Thing {
      @unknown default:
        break
      @unknown default: 
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: additional 'case' blocks cannot appear after the 'default' block of a 'switch'
      ]
    )
  }

  func testSwitch77() {
    AssertParse(
      """
      switch x {
      @unknown case _: 
        break
      @unknown case _:
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: '@unknown' can only be applied to the last case in a switch
      ]
    )
  }

  func testSwitch78() {
    AssertParse(
      """
      switch x {
      @unknown case _: 
        break
      @unknown default:
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: '@unknown' can only be applied to the last case in a switch
      ]
    )
  }

  func testSwitch79() {
    AssertParse(
      """
      switch x {
      @unknown default:
        break
      @unknown default: 
        break
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: additional 'case' blocks cannot appear after the 'default' block of a 'switch'
      ]
    )
  }

  func testSwitch80() {
    AssertParse(
      """
      func testReturnBeforeUnknownDefault() {
        switch x { 
        case 1:
          return#^DIAG^#
        @unknown default: 
          break
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: switch must be exhaustive
        // TODO: Old parser expected note on line 5: remove '@unknown' to handle remaining values
      ]
    )
  }

  func testSwitch81() {
    AssertParse(
      """
      func testReturnBeforeIncompleteUnknownDefault() {
        switch x { 
        case 1:
          return#^DIAG_1^#
        @unknown default #^DIAG_2^#
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: switch must be exhaustive
        // TODO: Old parser expected error on line 5: expected ':' after 'default'
        // TODO: Old parser expected note on line 5: remove '@unknown' to handle remaining values
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected ':' in switch case"),
      ]
    )
  }

  func testSwitch82() {
    AssertParse(
      """
      func testReturnBeforeIncompleteUnknownDefault2() {
        switch x { 
        case 1:
          return
        @unknown #^DIAG^#
        } 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: switch must be exhaustive
        // TODO: Old parser expected note on line 2: do you want to add a default clause?
        // TODO: Old parser expected error on line 5: unknown attribute 'unknown'
        DiagnosticSpec(message: "expected declaration after attribute in switch case"),
        // TODO: Old parser expected error on line 6: expected declaration
      ]
    )
  }

  func testSwitch83() {
    AssertParse(
      """
      func testIncompleteArrayLiteral() {
        switch x { 
        case 1:
          _ = #^NOTE^#[1 #^DIAG^#
        @unknown default: 
          ()
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: switch must be exhaustive
        // TODO: Old parser expected error on line 4: expected ']' in container literal expression
        DiagnosticSpec(message: "expected ']' to end array", notes: [
          NoteSpec(message: "to match this opening '['")
        ]),
        // TODO: Old parser expected note on line 5: remove '@unknown' to handle remaining values
      ]
    )
  }

}
