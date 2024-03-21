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

// This test file has been translated from swift/test/Parse/switch.swift

import XCTest

final class SwitchTests: ParserTestCase {
  func testSwitch1() {
    assertParse(
      """
      func ~= (x: (Int,Int), y: (Int,Int)) -> Bool {
        return true
      }
      """
    )
  }

  func testSwitch2() {
    assertParse(
      """
      func parseError1(x: Int) {
        switch 1️⃣func 2️⃣{}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected expression and '{}' to end 'switch' statement",
          fixIts: ["insert expression and '{}'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected identifier and function signature in function",
          fixIts: ["insert identifier and function signature"]
        ),
      ],
      fixedSource: """
        func parseError1(x: Int) {
          switch <#expression#> {
        }func <#identifier#>() {}
        }
        """
    )
  }

  func testSwitch3() {
    assertParse(
      """
      func parseError2(x: Int) {
        switch x 1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '{}' in 'switch' statement", fixIts: ["insert '{}'"])
      ],
      fixedSource: """
        func parseError2(x: Int) {
          switch x {
        }
        }
        """
    )
  }

  func testSwitch4() {
    assertParse(
      """
      func parseError3(x: Int) {
        switch x {
          case 1️⃣
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression and ':' in switch case", fixIts: ["insert expression and ':'"])
      ],
      fixedSource: """
        func parseError3(x: Int) {
          switch x {
            case <#expression#>:
          }
        }
        """
    )
  }

  func testSwitch5() {
    assertParse(
      """
      func parseError4(x: Int) {
        switch x {
        case var z where 1️⃣
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in 'where' clause", fixIts: ["insert expression"]),
        DiagnosticSpec(message: "expected ':' in switch case", fixIts: ["insert ':'"]),
      ],
      fixedSource: """
        func parseError4(x: Int) {
          switch x {
          case var z where <#expression#>:
          }
        }
        """
    )
  }

  func testSwitch6() {
    assertParse(
      """
      func parseError5(x: Int) {
        switch x {
        case let z1️⃣ 
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ':' in switch case", fixIts: ["insert ':'"])
      ],
      fixedSource: """
        func parseError5(x: Int) {
          switch x {
          case let z:
          }
        }
        """
    )
  }

  func testSwitch7() {
    assertParse(
      """
      func parseError6(x: Int) {
        switch x {
        default1️⃣ 
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ':' in switch case", fixIts: ["insert ':'"])
      ],
      fixedSource: """
        func parseError6(x: Int) {
          switch x {
          default:
          }
        }
        """
    )
  }

  func testSwitch8() {
    assertParse(
      """
      var x: Int
      """
    )
  }

  func testSwitch9() {
    assertParse(
      """
      switch x {}
      """
    )
  }

  func testSwitch10() {
    assertParse(
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
    assertParse(
      """
      // Multiple cases per case block
      switch x {
      case 0:
      case 1:
        x = 0
      }
      """
    )
  }

  func testSwitch12() {
    assertParse(
      """
      switch x {
      case 0:
      default:
        x = 0
      }
      """
    )
  }

  func testSwitch13() {
    assertParse(
      """
      switch x {
      case 0:
        x = 0
      case 1:
      }
      """
    )
  }

  func testSwitch14() {
    assertParse(
      """
      switch x {
      case 0:
        x = 0
      default:
      }
      """
    )
  }

  func testSwitch15() {
    assertParse(
      """
      switch x {
      case 0:
        1️⃣;
      case 1:
        x = 0
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "standalone ';' statements are not allowed", fixIts: ["remove ';'"])
      ],
      fixedSource: """
        switch x {
        case 0:

        case 1:
          x = 0
        }
        """
    )
  }

  func testSwitch16a() {
    assertParse(
      """
      switch x {
        1️⃣x = 1
      default:
        x = 0
      case 0:
        x = 0
      case 1:
        x = 0
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "all statements inside a switch must be covered by a 'case' or 'default' label",
          fixIts: ["insert label"]
        )
      ],
      fixedSource: """
        switch x {
        case <#identifier#>:
          x = 1
        default:
          x = 0
        case 0:
          x = 0
        case 1:
          x = 0
        }
        """
    )
  }

  func testSwitch16b() {
    assertParse(
      """
      switch x {
        1️⃣let x = 1
      case 1:
        x = 0
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "all statements inside a switch must be covered by a 'case' or 'default' label",
          fixIts: ["insert label"]
        )
      ],
      fixedSource: """
        switch x {
        case <#identifier#>:
          let x = 1
        case 1:
          x = 0
        }
        """
    )
  }

  func testSwitch17() {
    assertParse(
      """
      switch x {
      default:
        x = 0
      default:
        x = 0
      }
      """
    )
  }

  func testSwitch18() {
    assertParse(
      """
      switch x {
        1️⃣x = 1
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "all statements inside a switch must be covered by a 'case' or 'default' label",
          fixIts: ["insert label"]
        )
      ],
      fixedSource: """
        switch x {
        case <#identifier#>:
          x = 1
        }
        """
    )
  }

  func testSwitch19() {
    assertParse(
      """
      switch x {
        1️⃣x = 1
        x = 2
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "all statements inside a switch must be covered by a 'case' or 'default' label",
          fixIts: ["insert label"]
        )
      ],
      fixedSource: """
        switch x {
        case <#identifier#>:
          x = 1
          x = 2
        }
        """
    )
  }

  func testSwitch20() {
    assertParse(
      """
      switch x {
      default:
      case 0:
        x = 0
      }
      """
    )
  }

  func testSwitch21() {
    assertParse(
      """
      switch x {
      default:
      default:
        x = 0
      }
      """
    )
  }

  func testSwitch22() {
    assertParse(
      """
      switch x {
      default 1️⃣where x == 0:
        x = 0
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'default' cannot be used with a 'where' guard expression")
      ]
    )
  }

  func testSwitch23() {
    assertParse(
      """
      switch x {
      case 0:
      }
      """
    )
  }

  func testSwitch24() {
    assertParse(
      """
      switch x {
      case 0:
      case 1:
        x = 0
      }
      """
    )
  }

  func testSwitch25() {
    assertParse(
      """
      switch x {
      case 0:
        x = 0
      case 1:
      }
      """
    )
  }

  func testSwitch26() {
    assertParse(
      """
      1️⃣case 0:
      var y = 0
      2️⃣default:
      var z = 1
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "'case' can only appear inside a 'switch' statement or 'enum' declaration"
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "'default' label can only appear inside a 'switch' statement"),
      ]
    )
  }

  func testSwitch27() {
    assertParse(
      """
      fallthrough
      """
    )
  }

  func testSwitch28() {
    assertParse(
      """
      switch x {
      case 0:
        fallthrough
      case 1:
        fallthrough
      default:
        fallthrough
      }
      """
    )
  }

  func testSwitch29() {
    assertParse(
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
    assertParse(
      """
      // Cases cannot contain 'var' bindings if there are multiple matching patterns
      // attached to a block. They may however contain other non-binding patterns.
      """
    )
  }

  func testSwitch31() {
    assertParse(
      """
      var t = (1, 2)
      """
    )
  }

  func testSwitch32() {
    assertParse(
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
      """
    )
  }

  func testSwitch33() {
    assertParse(
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
    assertParse(
      """
      // Fallthroughs can only transfer control into a case label with bindings if the previous case binds a superset of those vars.
      switch t {
      case (1, 2):
        fallthrough
      case (var a, var b):
        t = (b, a)
      }
      """
    )
  }

  func testSwitch35() {
    assertParse(
      """
      switch t { // specifically notice on next line that we shouldn't complain that a is unused - just never mutated
      case (var a, let b):
        t = (b, b)
        fallthrough // ok - notice that subset of bound variables falling through is fine
      case (2, let a):
        t = (a, a)
      }
      """
    )
  }

  func testSwitch36() {
    assertParse(
      """
      func patternVarDiffType(x: Int, y: Double) {
        switch (x, y) {
        case (1, let a):
          fallthrough
        case (let a, _):
          break
        }
      }
      """
    )
  }

  func testSwitch37() {
    assertParse(
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
      """
    )
  }

  func testSwitch38() {
    assertParse(
      """
      func test_label(x : Int) {
      Gronk:
        switch x {
        case 42: return
        }
      }
      """
    )
  }

  func testSwitch39() {
    assertParse(
      """
      func enumElementSyntaxOnTuple() {
        switch (1, 1) {
        case .Bar:
          break
        default:
          break
        }
      }
      """
    )
  }

  func testSwitch40() {
    assertParse(
      """
      // https://github.com/apple/swift/issues/42798
      enum Whatever { case Thing }
      func f0(values: [Whatever]) {
          switch value {
          case .Thing: // Ok. Don't emit diagnostics about enum case not found in type <<error type>>.
              break
          }
      }
      """
    )
  }

  func testSwitch41() {
    assertParse(
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
      """#
    )
  }

  func testSwitch42() {
    assertParse(
      """
      switch Whatever.Thing {
      case .Thing:
      @unknown case _:
        x = 0
      }
      """
    )
  }

  func testSwitch43() {
    assertParse(
      """
      switch Whatever.Thing {
      case .Thing:
      @unknown default:
        x = 0
      }
      """
    )
  }

  func testSwitch44() {
    assertParse(
      """
      switch Whatever.Thing {
      case .Thing:
        x = 0
      @unknown case _:
      }
      """
    )
  }

  func testSwitch45() {
    assertParse(
      """
      switch Whatever.Thing {
      case .Thing:
        x = 0
      @unknown default:
      }
      """
    )
  }

  func testSwitch46() {
    assertParse(
      """
      switch Whatever.Thing {
      @unknown default:
        x = 0
      default:
        x = 0
      case .Thing:
        x = 0
      }
      """
    )
  }

  func testSwitch47() {
    assertParse(
      """
      switch Whatever.Thing {
      default:
        x = 0
      @unknown case _:
        x = 0
      case .Thing:
        x = 0
      }
      """
    )
  }

  func testSwitch48() {
    assertParse(
      """
      switch Whatever.Thing {
      default:
        x = 0
      @unknown default:
        x = 0
      case .Thing:
        x = 0
      }
      """
    )
  }

  func testSwitch49() {
    assertParse(
      """
      switch Whatever.Thing {
      @unknown default 1️⃣where x == 0:
        x = 0
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'default' cannot be used with a 'where' guard expression")
      ]
    )
  }

  func testSwitch50() {
    assertParse(
      """
      switch Whatever.Thing {
      @unknown case _:
        fallthrough
      }
      """
    )
  }

  func testSwitch51() {
    assertParse(
      """
      switch Whatever.Thing {
      @unknown case _:
        fallthrough
      case .Thing:
        break
      }
      """
    )
  }

  func testSwitch52() {
    assertParse(
      """
      switch Whatever.Thing {
      @unknown default:
        fallthrough
      case .Thing:
        break
      }
      """
    )
  }

  func testSwitch53() {
    assertParse(
      """
      switch Whatever.Thing {
      @unknown case _, _:
        break
      }
      """
    )
  }

  func testSwitch54() {
    assertParse(
      """
      switch Whatever.Thing {
      @unknown case _, _, _:
        break
      }
      """
    )
  }

  func testSwitch55() {
    assertParse(
      """
      switch Whatever.Thing {
      @unknown case let value:
        _ = value
      }
      """
    )
  }

  func testSwitch56() {
    assertParse(
      """
      switch (Whatever.Thing, Whatever.Thing) {
      @unknown case (_, _):
        break
      }
      """
    )
  }

  func testSwitch57() {
    assertParse(
      """
      switch Whatever.Thing {
      @unknown case is Whatever:
        break
      }
      """
    )
  }

  func testSwitch58() {
    assertParse(
      """
      switch Whatever.Thing {
      @unknown case .Thing:
        break
      }
      """
    )
  }

  func testSwitch59() {
    assertParse(
      """
      switch Whatever.Thing {
      @unknown case (_): // okay
        break
      }
      """
    )
  }

  func testSwitch60() {
    assertParse(
      """
      switch Whatever.Thing {
      @unknown case _ where x == 0:
        break
      }
      """
    )
  }

  func testSwitch61() {
    assertParse(
      """
      switch Whatever.Thing {
      @unknown default 1️⃣where x == 0:
        break
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'default' cannot be used with a 'where' guard expression")
      ]
    )
  }

  func testSwitch62() {
    assertParse(
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
    assertParse(
      """
      switch x {
      case 0:
        break
      @garbage case _:
        break
      }
      """
    )
  }

  func testSwitch64() {
    assertParse(
      """
      switch x {
      case 0:
        break
      @garbage 1️⃣@moreGarbage default:
        break
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '@moreGarbage' in switch case")
      ]
    )
  }

  func testSwitch65() {
    assertParse(
      """
      @unknown let _ = 1
      """
    )
  }

  func testSwitch66() {
    assertParse(
      """
      switch x {
      case _:
        @unknown let _ = 1
      }
      """
    )
  }

  func testSwitch67() {
    assertParse(
      """
      switch Whatever.Thing {
      case .Thing:
        break
      @unknown1️⃣(garbage) case _:
        break
      }
      switch Whatever.Thing {
      case .Thing:
        break
      @unknown
      2️⃣@unknown
      case _:
        break
      }
      switch Whatever.Thing {
      @unknown 3️⃣@garbage(foobar)
      case _:
        break
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '(garbage)' in switch case"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '@unknown' in switch case"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected code '@garbage(foobar)' in switch case"),
      ]
    )
  }

  func testSwitch68() {
    assertParse(
      """
      switch x {
      case 1:
        break
      @unknown case _:
        break
      }
      """
    )
  }

  func testSwitch69() {
    assertParse(
      """
      switch x {
      @unknown case _:
        break
      }
      """
    )
  }

  func testSwitch70() {
    assertParse(
      """
      switch x {
      @unknown default:
        break
      }
      """
    )
  }

  func testSwitch71() {
    assertParse(
      """
      switch Whatever.Thing {
      case .Thing:
        break
      @unknown case _:
        break
      @unknown case _:
        break
      }
      """
    )
  }

  func testSwitch72() {
    assertParse(
      """
      switch Whatever.Thing {
      case .Thing:
        break
      @unknown case _:
        break
      @unknown default:
        break
      }
      """
    )
  }

  func testSwitch73() {
    assertParse(
      """
      switch Whatever.Thing {
      case .Thing:
        break
      @unknown default:
        break
      @unknown default:
        break
      }
      """
    )
  }

  func testSwitch74() {
    assertParse(
      """
      switch Whatever.Thing {
      @unknown case _:
        break
      @unknown case _:
        break
      }
      """
    )
  }

  func testSwitch75() {
    assertParse(
      """
      switch Whatever.Thing {
      @unknown case _:
        break
      @unknown default:
        break
      }
      """
    )
  }

  func testSwitch76() {
    assertParse(
      """
      switch Whatever.Thing {
      @unknown default:
        break
      @unknown default:
        break
      }
      """
    )
  }

  func testSwitch77() {
    assertParse(
      """
      switch x {
      @unknown case _:
        break
      @unknown case _:
        break
      }
      """
    )
  }

  func testSwitch78() {
    assertParse(
      """
      switch x {
      @unknown case _:
        break
      @unknown default:
        break
      }
      """
    )
  }

  func testSwitch79() {
    assertParse(
      """
      switch x {
      @unknown default:
        break
      @unknown default:
        break
      }
      """
    )
  }

  func testSwitch80() {
    assertParse(
      """
      func testReturnBeforeUnknownDefault() {
        switch x {
        case 1:
          return
        @unknown default:
          break
        }
      }
      """
    )
  }

  func testSwitch81() {
    assertParse(
      """
      func testReturnBeforeIncompleteUnknownDefault() {
        switch x {
        case 1:
          return
        @unknown default1️⃣ 
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ':' in switch case", fixIts: ["insert ':'"])
      ],
      fixedSource: """
        func testReturnBeforeIncompleteUnknownDefault() {
          switch x {
          case 1:
            return
          @unknown default:
          }
        }
        """
    )
  }

  func testSwitch82() {
    assertParse(
      """
      func testReturnBeforeIncompleteUnknownDefault2() {
        switch x {
        case 1:
          return
        @unknown 1️⃣
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected label in switch case", fixIts: ["insert label"])
      ],
      fixedSource: """
        func testReturnBeforeIncompleteUnknownDefault2() {
          switch x {
          case 1:
            return
          @unknown case <#identifier#>:
          }
        }
        """
    )
  }

  func testSwitch83() {
    assertParse(
      """
      func testIncompleteArrayLiteral() {
        switch x {
        case 1:
          _ = ℹ️[11️⃣ 
        @unknown default:
          ()
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected ']' to end array",
          notes: [
            NoteSpec(message: "to match this opening '['")
          ],
          fixIts: ["insert ']'"]
        )
      ],
      fixedSource: """
        func testIncompleteArrayLiteral() {
          switch x {
          case 1:
            _ = [1]
          @unknown default:
            ()
          }
        }
        """
    )
  }
}
