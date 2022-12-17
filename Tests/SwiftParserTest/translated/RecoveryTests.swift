// This test file has been translated from swift/test/Parse/recovery.swift

import XCTest

final class RecoveryTests: XCTestCase {
  func testRecovery1() {
    AssertParse(
      """
      //===--- Helper types used in this file.
      """
    )
  }

  func testRecovery2() {
    AssertParse(
      """
      protocol FooProtocol {}
      """
    )
  }

  func testRecovery3() {
    AssertParse(
      """
      //===--- Tests.
      """
    )
  }

  func testRecovery4() {
    AssertParse(
      #"""
      func garbage() -> () {
        var a : Int
        1️⃣) this line is invalid, but we will stop at the keyword below... 
        return a + "a" 
      }
      """#,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code ') this line is invalid, but we will stop at the keyword below...' before 'return' statement")
      ]
    )
  }

  func testRecovery5() {
    AssertParse(
      #"""
      func moreGarbage() -> () {
        1️⃣) this line is invalid, but we will stop at the declaration... 
        func a() -> Int { return 4 }
        return a() + "a" 
      }
      """#,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code ') this line is invalid, but we will stop at the declaration...' before function")
      ]
    )
  }

  func testRecovery6() {
    AssertParse(
      """
      class Container<T> {
        func exists() -> Bool { return true }
      }
      """
    )
  }

  func testRecovery7() {
    AssertParse(
      """
      func useContainer() -> () {
        var a : Container<not 1️⃣a2️⃣ type [skip 3️⃣this greater: >] >4️⃣, b : Int 
        b = 5 // no-warning
        a.exists()
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '>' to end generic argument clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected code 'this greater: >' in subscript"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected expression in function"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "unexpected code in function"),
      ]
    )
  }

  func testRecovery8() {
    AssertParse(
      """
      @xyz class BadAttributes { 
        func exists() -> Bool { return true }
      }
      """
    )
  }

  func testRecovery9() {
    AssertParse(
      """
      func test(a: BadAttributes) -> () {
        _ = a.exists() // no-warning
      }
      """
    )
  }

  func testRecovery10() {
    AssertParse(
      """
      // Here is an extra random close-brace!
      1️⃣}
      //===--- Recovery for braced blocks.
      func braceStmt1() {
        { braceStmt1(); }2️⃣a
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before function"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }

  func testRecovery11() {
    AssertParse(
      """
      func braceStmt2() {
        { () in braceStmt2(); }
      }
      """
    )
  }

  func testRecovery12() {
    AssertParse(
      """
      func braceStmt3() {
        {  
          undefinedIdentifier {} 
        }
      }
      """
    )
  }

  func testRecovery13() {
    AssertParse(
      """
      //===--- Recovery for misplaced 'static'.
      static func toplevelStaticFunc() {} 
      static struct StaticStruct {} 
      static class StaticClass {} 
      static protocol StaticProtocol {} 
      static typealias StaticTypealias = Int 
      class ClassWithStaticDecls {
        class var a = 42 
      }
      """
    )
  }

  func testRecovery13b() {
    AssertParse(
      """
        if1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression and body in 'if' statement")
      ]
    )
  }

  func testRecovery14() {
    AssertParse(
      """
      if { 
        }1️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: missing condition in 'if' statement
        DiagnosticSpec(message: "expected code block in 'if' statement")
      ]
    )
  }

  func testRecovery15() {
    AssertParse(
      """
      if 
        {
        }1️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: missing condition in 'if' statement
        DiagnosticSpec(message: "expected code block in 'if' statement")
      ]
    )
  }

  func testRecovery16() {
    AssertParse(
      """
      if true {
        } else if { 
        }1️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: missing condition in 'if' statement
        DiagnosticSpec(message: "expected code block in 'if' statement")
      ]
    )
  }

  func testRecovery17() {
    AssertParse(
      """
      // It is debatable if we should do recovery here and parse { true } as the
        // body, but the error message should be sensible.
        if { true } { 
        }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: missing condition in 'if' statement
        // TODO: Old parser expected error on line 3: consecutive statements on a line must be separated by ';', Fix-It replacements: 14 - 14 = ';'
        // TODO: Old parser expected error on line 3: closure expression is unused
        // TODO: Old parser expected note on line 3: did you mean to use a 'do' statement?, Fix-It replacements: 15 - 15 = 'do '
        // TODO: Old parser expected warning on line 3: boolean literal is unused
      ]
    )
  }

  func testRecovery18() {
    AssertParse(
      """
      if { true }() {
        }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: missing condition in 'if' statement
      ]
    )
  }

  func testRecovery19() {
    AssertParse(
      """
      // <rdar://problem/18940198>
        if { { } }1️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: missing condition in 'if' statement
        // TODO: Old parser expected error on line 2: closure expression is unused
        // TODO: Old parser expected note on line 2: did you mean to use a 'do' statement?, Fix-It replacements: 8 - 8 = 'do '
        DiagnosticSpec(message: "expected code block in 'if' statement")
      ]
    )
  }

  func testRecovery20() {
    AssertParse(
      """
      while1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression and code block in 'while' statement")
      ]
    )
  }

  func testRecovery21() {
    AssertParse(
      """
      while { 
        }1️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: missing condition in 'while' statement
        DiagnosticSpec(message: "expected code block in 'while' statement")
      ]
    )
  }

  func testRecovery22() {
    AssertParse(
      """
      while 
        {
        }1️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: missing condition in 'while' statement
        DiagnosticSpec(message: "expected code block in 'while' statement")
      ]
    )
  }

  func testRecovery23() {
    AssertParse(
      """
      // It is debatable if we should do recovery here and parse { true } as the
      // body, but the error message should be sensible.
      while { true } {
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: missing condition in 'while' statement
        // TODO: Old parser expected error on line 3: consecutive statements on a line must be separated by ';', Fix-It replacements: 17 - 17 = ';'
        // TODO: Old parser expected error on line 3: closure expression is unused
        // TODO: Old parser expected note on line 3: did you mean to use a 'do' statement?, Fix-It replacements: 18 - 18 = 'do '
        // TODO: Old parser expected warning on line 3: boolean literal is unused
      ]
    )
  }

  func testRecovery24() {
    AssertParse(
      """
      while { true }() { //  expected-error 2 {{consecutive statements on a line must be separated by ';'}} expected-error {{closure expression is unused}} expected-note {{did you mean to use a 'do' statement?}} {{20-20=do }} expected-warning {{boolean literal is unused}}
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: missing condition in 'while' statement
      ]
    )
  }

  func testRecovery25() {
    AssertParse(
      """
      // <rdar://problem/18940198>
      while { { } }1️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: missing condition in 'while' statement
        // TODO: Old parser expected error on line 2: closure expression is unused
        // TODO: Old parser expected note on line 2: did you mean to use a 'do' statement?, Fix-It replacements: 11 - 11 = 'do '
        DiagnosticSpec(message: "expected code block in 'while' statement")
      ]
    )
  }

  func testRecovery26() {
    AssertParse(
      """
      repeat {
      } while1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected condition in 'repeat' statement")
      ]
    )
  }

  func testRecovery27() {
    AssertParse(
      """
      { 
        missingControllingExprInRepeatWhile();
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: closure expression is unused
        // TODO: Old parser expected note on line 1: did you mean to use a 'do' statement?, Fix-It replacements: 3 - 3 = 'do '
      ]
    )
  }

  func testRecovery28() {
    AssertParse(
      """
      repeat {
      } while { true }()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: missing condition in 'while' statement
        // TODO: Old parser expected error on line 2: consecutive statements on a line must be separated by ';', Fix-It replacements: 10 - 10 = ';'
        // TODO: Old parser expected warning on line 2: result of call to closure returning 'Bool' is unused
      ]
    )
  }

  func testRecovery29() {
    // https://github.com/apple/swift/issues/42787
    AssertParse(
      """
      repeat {
      }1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'while' and condition in 'repeat' statement")
      ]
    )
  }

  func testRecovery30() {
    AssertParse(
      """
      for 1️⃣; {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected pattern, 'in', and expression in 'for' statement"),
        DiagnosticSpec(message: "unexpected ';' separator"),
      ]
    )
  }

  func testRecovery31() {
    AssertParse(
      """
      for 1️⃣; 
        { 
        }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected pattern, 'in', and expression in 'for' statement"),
        DiagnosticSpec(message: "unexpected ';' separator"),
      ]
    )
  }

  func testRecovery32() {
    AssertParse(
      """
      for 1️⃣; true { 
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected pattern, 'in', and expression in 'for' statement"),
        DiagnosticSpec(message: "unexpected code '; true' in 'for' statement"),
      ]
    )
  }

  func testRecovery33() {
    AssertParse(
      """
      for var i 1️⃣= 0; true { 
        i += 1
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'in' and expression in 'for' statement"),
        DiagnosticSpec(message: "unexpected code '= 0; true' in 'for' statement"),
      ]
    )
  }

  func testRecovery34() {
    AssertParse(
      """
      for1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected pattern, 'in', expression, and body in 'for' statement")
      ]
    )
  }

  func testRecovery35() {
    AssertParse(
      """
      for 1️⃣{
      }2️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected pattern
        // TODO: Old parser expected error on line 1: expected Sequence expression for for-each loop
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected pattern and 'in' in 'for' statement"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected code block in 'for' statement"),
      ]
    )
  }

  func testRecovery36() {
    AssertParse(
      """
      for1️⃣
      {
      }2️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected Sequence expression for for-each loop
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected pattern and 'in' in 'for' statement"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected code block in 'for' statement"),
      ]
    )
  }

  func testRecovery37() {
    AssertParse(
      """
      for i 1️⃣{
      }2️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected Sequence expression for for-each loop
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected 'in' in 'for' statement"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected code block in 'for' statement"),
      ]
    )
  }

  func testRecovery38() {
    AssertParse(
      """
      for var i 1️⃣{
      }2️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected Sequence expression for for-each loop
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected 'in' in 'for' statement"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected code block in 'for' statement"),
      ]
    )
  }

  func testRecovery39() {
    AssertParse(
      """
      for 1️⃣in 2️⃣{
      }3️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected pattern
        // TODO: Old parser expected error on line 1: expected Sequence expression for for-each loop
        DiagnosticSpec(locationMarker: "1️⃣", message: "keyword 'in' cannot be used as an identifier here"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected 'in' in 'for' statement"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected code block in 'for' statement"),
      ]
    )
  }

  func testRecovery40() {
    AssertParse(
      """
      for 1️⃣0..<12 {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected pattern and 'in' in 'for' statement")
      ]
    )
  }

  func testRecovery41() {
    AssertParse(
      """
      for 1️⃣for in {
      }2️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected '{' to start the body of for-each loop
        DiagnosticSpec(locationMarker: "1️⃣", message: "keyword 'for' cannot be used as an identifier here"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected code block in 'for' statement"),
      ]
    )
  }

  func testRecovery42() {
    AssertParse(
      """
      for i in { 
      }1️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected Sequence expression for for-each loop
        DiagnosticSpec(message: "expected code block in 'for' statement")
      ]
    )
  }

  func testRecovery43() {
    AssertParse(
      """
      // https://github.com/apple/swift/issues/48502
      struct User { let name: String? }
      """
    )
  }

  func testRecovery44() {
    AssertParse(
      #"""
      let users = [User]()
      for user in users 1️⃣whe {
        if let name = user.name {
          let key = "\(name)"
        }
      }
      """#,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'whe' in 'for' statement")
      ]
    )
  }

  func testRecovery45a() {
    AssertParse(
      """
      for 1️⃣
        2️⃣; 
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected pattern, 'in', and expression in 'for' statement"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '{' in 'for' statement"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "standalone ';' statements are not allowed"),
      ]
    )
  }

  func testRecovery45b() {
    AssertParse(
      """
      switch1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression and '{}' to end 'switch' statement")
      ]
    )
  }

  func testRecovery46() {
    AssertParse(
      """
      switch { 
      }1️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected expression in 'switch' statement
        // TODO: Old parser expected error on line 1: 'switch' statement body must have at least one 'case' or 'default' block
        DiagnosticSpec(message: "expected '{}' in 'switch' statement")
      ]
    )
  }

  func testRecovery47() {
    AssertParse(
      """
      switch 
      {
      }1️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected expression in 'switch' statement
        // TODO: Old parser expected error on line 1: 'switch' statement body must have at least one 'case' or 'default' block
        DiagnosticSpec(message: "expected '{}' in 'switch' statement")
      ]
    )
  }

  func testRecovery48() {
    AssertParse(
      """
      switch { 
        1️⃣case _: return
      }2️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected expression in 'switch' statement
        DiagnosticSpec(locationMarker: "1️⃣", message: "'case' can only appear inside a 'switch' statement or 'enum' declaration"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '{}' in 'switch' statement"),
      ]
    )
  }

  func testRecovery49() {
    AssertParse(
      """
      switch { 
        1️⃣case Int: return
        2️⃣case _: return
      }3️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected expression in 'switch' statement
        // TODO: Old parser expected error on line 2: 'is' keyword required to pattern match against type name, Fix-It replacements: 10 - 10 = 'is '
        DiagnosticSpec(locationMarker: "1️⃣", message: "'case' can only appear inside a 'switch' statement or 'enum' declaration"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "'case' can only appear inside a 'switch' statement or 'enum' declaration"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected '{}' in 'switch' statement"),
      ]
    )
  }

  func testRecovery50() {
    AssertParse(
      """
      switch { 42 } { 
        case _: return
      }
      """
    )
  }

  func testRecovery51() {
    AssertParse(
      """
      switch { 42 }() {
        case _: return
      }
      """
    )
  }

  //===--- Recovery for missing braces in nominal type decls.
  func testRecovery54() {
    AssertParse(
      """
      struct NoBracesStruct11️⃣()
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected member block in struct")
      ]
    )
  }

  func testRecovery55() {
    AssertParse(
      """
      enum NoBracesUnion11️⃣() 
      class NoBracesClass12️⃣() 
      protocol NoBracesProtocol13️⃣() 
      extension NoBracesStruct14️⃣()
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '{' in enum"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '()' before class"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '{' in class"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '()' before protocol"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected '{' in protocol"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected code '()' before extension"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected member block in extension"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected '}' to end protocol"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected '}' to end class"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected '}' to end enum"),
      ]
    )
  }

  func testRecovery56() {
    AssertParse(
      """
      struct NoBracesStruct2 1️⃣
      enum NoBracesUnion2 2️⃣
      class NoBracesClass2 3️⃣
      protocol NoBracesProtocol2 4️⃣
      extension NoBracesStruct25️⃣
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '{' in struct"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '{' in enum"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected '{' in class"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected '{' in protocol"),
        DiagnosticSpec(locationMarker: "5️⃣", message: "expected member block in extension"),
        DiagnosticSpec(locationMarker: "5️⃣", message: "expected '}' to end protocol"),
        DiagnosticSpec(locationMarker: "5️⃣", message: "expected '}' to end class"),
        DiagnosticSpec(locationMarker: "5️⃣", message: "expected '}' to end enum"),
        DiagnosticSpec(locationMarker: "5️⃣", message: "expected '}' to end struct"),
      ]
    )
  }

  //===--- Recovery for multiple identifiers in decls
  func testRecovery58() {
    AssertParse(
      """
      protocol Multi 1️⃣ident {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "found an unexpected second identifier in protocol")
      ]
    )
  }

  func testRecovery60() {
    AssertParse(
      """
      class CCC 1️⃣CCC<T> {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "found an unexpected second identifier in class")
      ],
      fixedSource: """
        class CCCCCC<T> {}
        """
    )
  }

  func testRecovery62() {
    AssertParse(
      """
      enum EE 1️⃣EE<T> where T : Multi {
        case a2️⃣ 3️⃣a
        case b
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "found an unexpected second identifier in enum"),
        // TODO: Old parser expected error on line 2: found an unexpected second identifier in enum 'case' declaration; is there an accidental break?
        // TODO: Old parser expected note on line 2: join the identifiers together, Fix-It replacements: 8 - 11 = 'aa'
        // TODO: Old parser expected note on line 2: join the identifiers together with camel-case, Fix-It replacements: 8 - 11 = 'aA'
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive declarations on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected code 'a' before enum case"),
      ]
    )
  }

  func testRecovery63() {
    AssertParse(
      #"""
      struct SS 1️⃣SS : Multi {
        private var a 2️⃣b 3️⃣: Int = ""
        func f() {
          var c 4️⃣d = 5
          let _ = 0
        }
      }
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "found an unexpected second identifier in struct"),
        // TODO: Old parser expected error on line 2: found an unexpected second identifier in variable declaration; is there an accidental break?
        // TODO: Old parser expected error on line 2: cannot convert value of type 'String' to specified type 'Int'
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ':' in type annotation"),
        DiagnosticSpec(locationMarker: "3️⃣", message: #"unexpected code ': Int = ""' before function"#),
        // TODO: Old parser expected error on line 4: found an unexpected second identifier in variable declaration; is there an accidental break?
        // TODO: Old parser expected warning on line 4: initialization of variable 'c' was never used; consider replacing with assignment to '_' or removing it
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected ':' in type annotation"),
      ]
    )
  }

  func testRecovery64() {
    AssertParse(
      """
      let (efg 1️⃣hij, foobar) = (5, 6)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: found an unexpected second identifier in constant declaration; is there an accidental break?
        DiagnosticSpec(message: "unexpected code 'hij, foobar' in tuple pattern")
      ]
    )
  }

  func testRecovery65() {
    AssertParse(
      """
      _ = foobar // OK.
      """
    )
  }

  //===--- Recovery for parse errors in types.

  func testRecovery67() {
    AssertParse(
      """
      struct ErrorTypeInVarDecl1 {
        var v1 : 1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected type in type annotation")
      ]
    )
  }

  func testRecovery68() {
    AssertParse(
      """
      struct ErrorTypeInVarDecl2 {
        var v1 : Int1️⃣. 
        var v2 : Int
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected member name following '.'
        DiagnosticSpec(message: "consecutive declarations on a line must be separated by ';'"),
        DiagnosticSpec(message: "unexpected code '.' before variable"),
      ]
    )
  }

  func testRecovery69() {
    AssertParse(
      """
      struct ErrorTypeInVarDecl3 {
        var v1 : Int< 1️⃣
        var v2 : Int
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '>' to end generic argument clause")
      ]
    )
  }

  func testRecovery70() {
    AssertParse(
      """
      struct ErrorTypeInVarDecl4 {
        var v1 : Int<1️⃣, 
        var v2 : Int
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '>' to end generic argument clause")
      ]
    )
  }

  func testRecovery71() {
    AssertParse(
      """
      struct ErrorTypeInVarDecl5 {
        var v1 : Int<Int 1️⃣
        var v2 : Int
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '>' to end generic argument clause")
      ]
    )
  }

  func testRecovery72() {
    AssertParse(
      """
      struct ErrorTypeInVarDecl6 {
        var v1 : Intℹ️<Int,
                     Int 1️⃣
        var v2 : Int
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '>' to end generic argument clause", notes: [NoteSpec(message: "to match this opening '<'")])
      ]
    )
  }

  func testRecovery73() {
    AssertParse(
      """
      struct ErrorTypeInVarDecl7 {
        var v1 : Int<Int, 1️⃣
        var v2 : Int
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected type in generic argument"),
        DiagnosticSpec(message: "expected '>' to end generic argument clause"),
      ]
    )
  }

  func testRecovery83() {
    AssertParse(
      """
      struct ErrorTypeInVarDecl12 {
        var v1 : FooProtocol & 1️⃣
        var v2 : Int
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected type in type composition")
      ]
    )
  }

  func testRecovery84() {
    AssertParse(
      """
      struct ErrorTypeInVarDecl13 { 
        var v1 : 1️⃣& FooProtocol 
        var v2 : Int
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected type in type composition")
      ]
    )
  }

  func testRecovery85() {
    AssertParse(
      """
      struct ErrorTypeInVarDecl16 {
        var v1 : FooProtocol & 1️⃣
        var v2 : Int
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected type in type composition")
      ]
    )
  }

  func testRecovery86() {
    AssertParse(
      """
      func ErrorTypeInPattern4(_: FooProtocol & 1️⃣) { }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected type in type composition")
      ]
    )
  }

  func testRecovery87() {
    AssertParse(
      """
      struct ErrorGenericParameterList1<1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '>' to end generic parameter clause"),
        DiagnosticSpec(message: "expected member block in struct"),
      ]
    )
  }

  func testRecovery88() {
    AssertParse(
      """
      struct ErrorGenericParameterList2<T1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '>' to end generic parameter clause"),
        DiagnosticSpec(message: "expected member block in struct"),
      ]
    )
  }

  func testRecovery89() {
    AssertParse(
      """
      struct ErrorGenericParameterList3<T,1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected generic parameter in generic parameter clause"),
        DiagnosticSpec(message: "expected '>' to end generic parameter clause"),
        DiagnosticSpec(message: "expected member block in struct"),
      ]
    )
  }

  func testRecovery90() {
    AssertParse(
      """
      // Note: Don't move braces to a different line here.
      struct ErrorGenericParameterList4< 1️⃣
      {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '>' to end generic parameter clause")
      ]
    )
  }

  func testRecovery91() {
    AssertParse(
      """
      // Note: Don't move braces to a different line here.
      struct ErrorGenericParameterList5<T 1️⃣
      {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '>' to end generic parameter clause")
      ]
    )
  }

  func testRecovery92() {
    AssertParse(
      """
      // Note: Don't move braces to a different line here.
      struct ErrorGenericParameterList6<T, 1️⃣
      {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected generic parameter in generic parameter clause"),
        DiagnosticSpec(message: "expected '>' to end generic parameter clause"),
      ]
    )
  }

  func testRecovery93() {
    AssertParse(
      """
      struct ErrorTypeInVarDeclFunctionType1 {
        var v1 : () -> 1️⃣
        var v2 : Int
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected type in function type")
      ]
    )
  }

  func testRecovery98a() {
    AssertParse(
      """
      let a1: Swift.Int1️⃣]
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous code ']' at top level")
      ]
    )
  }

  func testRecovery98b() {
    AssertParse(
      """
      let a2: Set<Int1️⃣]>
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 3: to match this opening '<'
        // TODO: Old parser expected error on line 3: expected '>' to complete generic argument list
        DiagnosticSpec(message: "expected '>' to end generic argument clause"),
        DiagnosticSpec(message: "extraneous code ']>' at top level"),
      ]
    )
  }

  func testRecovery98c() {
    AssertParse(
      """
      let a3: Set<Int>1️⃣]
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: unexpected ']' in type; did you mean to write an array type?, Fix-It replacements: 11 - 11 = '['
        DiagnosticSpec(message: "extraneous code ']' at top level")
      ]
    )
  }

  func testRecovery98d() {
    AssertParse(
      """
      let a4: Int1️⃣]?
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 5: unexpected ']' in type; did you mean to write an array type?, Fix-It replacements: 11 - 11 = '['
        // TODO: Old parser expected error on line 5: expected declaration
        // TODO: Old parser expected error on line 5: consecutive declarations on a line must be separated by ';'
        DiagnosticSpec(message: "extraneous code ']?' at top level")
      ]
    )
  }

  func testRecovery98e() {
    AssertParse(
      """
      let a5: Int?1️⃣]
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 6: unexpected ']' in type; did you mean to write an array type?, Fix-It replacements: 11 - 11 = '['
        DiagnosticSpec(message: "extraneous code ']' at top level")
      ]
    )
  }

  func testRecovery98f() {
    AssertParse(
      """
      let a6: [Int]1️⃣]
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 7: unexpected ']' in type; did you mean to write an array type?, Fix-It replacements: 11 - 11 = '['
        DiagnosticSpec(message: "extraneous code ']' at top level")
      ]
    )
  }

  func testRecovery98g() {
    AssertParse(
      """
      let a7: [String: Int]1️⃣]
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 8: unexpected ']' in type; did you mean to write an array type?, Fix-It replacements: 11 - 11 = '['
        DiagnosticSpec(message: "extraneous code ']' at top level")
      ]
    )
  }

  func testRecovery99() {
    AssertParse(
      """
      struct ErrorTypeInVarDeclDictionaryType {
        let a1: String1️⃣: 
        let a2: String2️⃣: Int] 
        let a3: String3️⃣: [Int] 
        let a4: String4️⃣: Int 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unexpected ':' in type; did you mean to write a dictionary type?, Fix-It replacements: 11 - 11 = '['
        // TODO: Old parser expected error on line 2: expected dictionary value type
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive declarations on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code ':' before variable"),
        // TODO: Old parser expected error on line 3: unexpected ':' in type; did you mean to write a dictionary type?, Fix-It replacements: 11 - 11 = '['
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code ': Int]' before variable"),
        // TODO: Old parser expected error on line 4: unexpected ':' in type; did you mean to write a dictionary type?, Fix-It replacements: 11 - 11 = '[', 24 - 24 = ']'
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected code ': [Int]' before variable"),
        // TODO: Old parser expected error on line 5: unexpected ':' in type; did you mean to write a dictionary type?, Fix-It replacements: 11 - 11 = '[', 22 - 22 = ']'
        DiagnosticSpec(locationMarker: "4️⃣", message: "unexpected code ': Int' in struct"),
      ]
    )
  }

  func testRecovery100() {
    AssertParse(
      """
      struct ErrorInFunctionSignatureResultArrayType1 {
        func foo() -> Int1️⃣[ { 
          return [0]
        }  2️⃣
        func bar() -> Int3️⃣] { 
          return [0]
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '{' in body of function declaration
        // TODO: Old parser expected note on line 2: to match this opening '['
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '}' to end struct"),
        // TODO: Old parser expected error on line 4: expected ']' in array type
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ']' to end array"),
        // TODO: Old parser expected error on line 5: unexpected ']' in type; did you mean to write an array type?, Fix-It replacements: 17 - 17 = '['
        DiagnosticSpec(locationMarker: "3️⃣", message: "extraneous code at top level"),
      ]
    )
  }

  func testRecovery101() {
    AssertParse(
      """
      struct ErrorInFunctionSignatureResultArrayType2 {
        func foo() -> Int1️⃣[0 { 
          return [0]  
        }2️⃣
      3️⃣}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected ']' in array type
        // TODO: Old parser expected note on line 2: to match this opening '['
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '}' to end struct"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ']' to end array"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "extraneous brace at top level"),
      ]
    )
  }

  func testRecovery102() {
    AssertParse(
      """
      struct ErrorInFunctionSignatureResultArrayType3 {
        func foo() -> Int1️⃣[0] { 
          return [0]
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: array types are now written with the brackets around the element type, Fix-It replacements: 17 - 17 = '[', 20 - 21 = ''
        DiagnosticSpec(message: "unexpected code in struct")
      ]
    )
  }

  func testRecovery103() {
    AssertParse(
      """
      struct ErrorInFunctionSignatureResultArrayType4 {
        func foo() -> Int1️⃣[0_1] { 
          return [0]
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: array types are now written with the brackets around the element type, Fix-It replacements: 17 - 17 = '[', 20 - 21 = ''
        DiagnosticSpec(message: "unexpected code in struct")
      ]
    )
  }

  func testRecovery104() {
    AssertParse(
      """
      struct ErrorInFunctionSignatureResultArrayType5 {
        func foo() -> Int1️⃣[0b1] { 
          return [0]
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: array types are now written with the brackets around the element type, Fix-It replacements: 17 - 17 = '[', 20 - 21 = ''
        DiagnosticSpec(message: "unexpected code in struct")
      ]
    )
  }

  func testRecovery105() {
    AssertParse(
      """
      struct ErrorInFunctionSignatureResultArrayType11 { 
        func foo() -> Int1️⃣[(a){a++}] { 
        }
      2️⃣}
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 1: in declaration of 'ErrorInFunctionSignatureResultArrayType11'
        // TODO: Old parser expected error on line 2: consecutive declarations on a line must be separated by ';', Fix-It replacements: 29 - 29 = ';'
        // TODO: Old parser expected error on line 2: expected ']' in array type
        // TODO: Old parser expected note on line 2: to match this opening '['
        // TODO: Old parser expected error on line 2: cannot find operator '++' in scope; did you mean '+= 1'?
        // TODO: Old parser expected error on line 2: cannot find 'a' in scope
        // TODO: Old parser expected error on line 2: expected declaration
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '}' to end struct"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous brace at top level"),
      ]
    )
  }

  func testRecovery106() {
    AssertParse(
      """
      //===--- Recovery for missing initial value in var decls.
      """
    )
  }

  func testRecovery107() {
    AssertParse(
      """
      struct MissingInitializer1 {
        var v1 : Int = 1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in variable")
      ]
    )
  }

  func testRecovery108() {
    AssertParse(
      """
      //===--- Recovery for expr-postfix.
      """
    )
  }

  func testRecovery109() {
    AssertParse(
      """
      func exprPostfix1(x : Int) {
        x1️⃣. 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected member name following '.'
        DiagnosticSpec(message: "unexpected code '.' in function")
      ]
    )
  }

  func testRecovery110() {
    AssertParse(
      """
      func exprPostfix2() {
        _ = .1️⃣42 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: '.42' is not a valid floating point literal; it must be written '0.42', Fix-It replacements: 7 - 7 = '0'
        DiagnosticSpec(message: "expected name in member access")
      ]
    )
  }

  func testRecovery111() {
    AssertParse(
      """
      //===--- Recovery for expr-super.
      """
    )
  }

  func testRecovery112() {
    AssertParse(
      """
      class Base {}
      """
    )
  }

  func testRecovery113() {
    AssertParse(
      """
      class ExprSuper1 {
        init() {
          super 
        }
      }
      """
    )
  }

  func testRecovery114() {
    AssertParse(
      """
      class ExprSuper2 {
        init() {
          super1️⃣. 
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: expected member name following '.'
        DiagnosticSpec(message: "unexpected code '.' in initializer")
      ]
    )
  }

  func testRecovery115() {
    AssertParse(
      """
      //===--- Recovery for braces inside a nominal decl.
      """
    )
  }

  func testRecovery116() {
    AssertParse(
      """
      struct BracesInsideNominalDecl1 { 
        1️⃣{ 
          aaa
        }
        typealias A = Int
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code before typealias declaration")
      ]
    )
  }

  func testRecovery117() {
    AssertParse(
      """
      func use_BracesInsideNominalDecl1() {
        // Ensure that the typealias decl is not skipped.
        var _ : BracesInsideNominalDecl1.A // no-error
      }
      """
    )
  }

  func testRecovery118() {
    AssertParse(
      #"""
      // https://github.com/apple/swift/issues/43383
      class С_43383 {
          1️⃣print(2️⃣"No one else was in the room where it happened") 
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 3: expected parameter name followed by ':'
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected 'func' in function"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected type in parameter"),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"unexpected code '"No one else was in the room where it happened"' in parameter clause"#),
      ]
    )
  }

  func testRecovery119() {
    AssertParse(
      #"""
      extension С_43383 {
          1️⃣print(2️⃣"The room where it happened, the room where it happened")
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected parameter name followed by ':'
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected 'func' in function"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected type in parameter"),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"unexpected code '"The room where it happened, the room where it happened"' in parameter clause"#),
      ]
    )
  }

  func testRecovery120() {
    AssertParse(
      """
      //===--- Recovery for wrong decl introducer keyword.
      """
    )
  }

  func testRecovery121() {
    AssertParse(
      """
      class WrongDeclIntroducerKeyword1 {
        1️⃣notAKeyword() {} 
        func foo() {}
        class func bar() {}
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected 'func' keyword in instance method declaration
        DiagnosticSpec(message: "unexpected code 'notAKeyword() {}' before function")
      ]
    )
  }

  func testRecovery122() {
    AssertParse(
      """
      //===--- Recovery for wrong inheritance clause.
      """
    )
  }

  func testRecovery123() {
    AssertParse(
      """
      class Base2<T> {
      }
      """
    )
  }

  func testRecovery124() {
    AssertParse(
      """
      class SubModule {
          class Base1 {}
          class Base2<T> {}
      }
      """
    )
  }

  func testRecovery125() {
    AssertParse(
      """
      class WrongInheritanceClause11️⃣(Int) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected ':' to begin inheritance clause, Fix-It replacements: 30 - 31 = ': ', 34 - 35 = ''
        DiagnosticSpec(message: "unexpected code '(Int)' in class")
      ]
    )
  }

  func testRecovery126() {
    AssertParse(
      """
      class WrongInheritanceClause21️⃣(Base2<Int>) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected ':' to begin inheritance clause, Fix-It replacements: 30 - 31 = ': ', 41 - 42 = ''
        DiagnosticSpec(message: "unexpected code '(Base2<Int>)' in class")
      ]
    )
  }

  func testRecovery127() {
    AssertParse(
      """
      class WrongInheritanceClause3<T>1️⃣(SubModule.Base1) where T:AnyObject {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected ':' to begin inheritance clause, Fix-It replacements: 33 - 34 = ': ', 49 - 50 = ''
        DiagnosticSpec(message: "unexpected code '(SubModule.Base1) where T:AnyObject' in class")
      ]
    )
  }

  func testRecovery128() {
    AssertParse(
      """
      class WrongInheritanceClause41️⃣(SubModule.Base2<Int>) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected ':' to begin inheritance clause, Fix-It replacements: 30 - 31 = ': ', 51 - 52 = ''
        DiagnosticSpec(message: "unexpected code '(SubModule.Base2<Int>)' in class")
      ]
    )
  }

  func testRecovery129() {
    AssertParse(
      """
      class WrongInheritanceClause5<T>1️⃣(SubModule.Base2<Int>) where T:AnyObject {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected ':' to begin inheritance clause, Fix-It replacements: 33 - 34 = ': ', 54 - 55 = ''
        DiagnosticSpec(message: "unexpected code '(SubModule.Base2<Int>) where T:AnyObject' in class")
      ]
    )
  }

  func testRecovery130() {
    AssertParse(
      """
      class WrongInheritanceClause61️⃣(Int 2️⃣{}3️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected ':' to begin inheritance clause, Fix-It replacements: 30 - 31 = ': '
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '{' in class"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected 'var' in variable"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' to end tuple pattern"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected '}' to end class"),
      ]
    )
  }

  func testRecovery131() {
    AssertParse(
      """
      class WrongInheritanceClause7<T>1️⃣(Int 2️⃣where T:AnyObject {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected ':' to begin inheritance clause, Fix-It replacements: 33 - 34 = ': '
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '{' in class"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected 'var' in variable"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' to end tuple pattern"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '}' to end class"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code 'where T:AnyObject {}' at top level"),
      ]
    )
  }

  func testRecovery132() {
    AssertParse(
      """
      // <rdar://problem/18502220> [swift-crashes 078] parser crash on invalid cast in sequence expr
      Base=1 as Base=1
      """
    )
  }

  func testRecovery133() {
    AssertParse(
      #"""
      // <rdar://problem/18634543> Parser hangs at swift::Parser::parseType
      public enum TestA {
        public static func convertFromExtenndition( 
          s._core.count 1️⃣!= 0, "Can't form a Character from an empty String")
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 3: expected '{' in body of function declaration
        // TODO: Old parser expected error on line 3: expected parameter name followed by ':'
        // TODO: Old parser expected error on line 4: expected parameter name followed by ':'
        DiagnosticSpec(message: #"unexpected code '!= 0, "Can't form a Character from an empty String"' in parameter clause"#)
      ]
    )
  }

  func testRecovery134() {
    AssertParse(
      #"""
      public enum TestB {
        public static func convertFromExtenndition( 
          s._core.count 1️⃣?= 0, "Can't form a Character from an empty String")
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '{' in body of function declaration
        // TODO: Old parser expected error on line 2: expected parameter name followed by ':'
        // TODO: Old parser expected error on line 3: expected parameter name followed by ':'
        DiagnosticSpec(message: #"unexpected code '?= 0, "Can't form a Character from an empty String"' in parameter clause"#)
      ]
    )
  }

  func testRecovery135() {
    AssertParse(
      """
      // <rdar://problem/18634543> Infinite loop and unbounded memory consumption in parser
      class bar {}
      """
    )
  }

  func testRecovery136() {
    AssertParse(
      """
      var baz: bar
      func foo1(bar!=baz) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unnamed parameters must be written with the empty name '_'
        // TODO: Old parser expected note on line 2: did you mean 'foo1'?
      ]
    )
  }

  func testRecovery137() {
    AssertParse(
      """
      func foo2(bar! = baz) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unnamed parameters must be written with the empty name '_'
        // TODO: Old parser expected note on line 1: did you mean 'foo2'?
      ]
    )
  }

  func testRecovery138() {
    AssertParse(
      """
      // rdar://19605567
      switch esp {
      case let (jeb):
        class Ceac<1️⃣}2️⃣> {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '>' to end generic parameter clause"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '{' in class"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '> {}' in 'switch' statement"),
      ]
    )
  }

  func testRecovery141() {
    AssertParse(
      """
      #if true
      // rdar://19605164
      struct Foo19605164 {
      func a(s: S1️⃣[{{g2️⃣) -> Int {} 
      }}3️⃣}
      #endif
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '}' to end struct"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code ') -> Int {}' in closure"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected ']' to end array"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected brace in conditional compilation block"),
      ]
    )
  }

  func testRecovery143() {
    AssertParse(
      """
      // rdar://19605567
      func F() { init<1️⃣( 2️⃣} 3️⃣)}
      struct InitializerWithName {
        init 4️⃣x() {}5️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '>' to end generic parameter clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected type and ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected code ')}' before struct"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "unexpected code 'x' before parameter clause"),
      ]
    )
  }

  func testRecovery144() {
    AssertParse(
      """
      init 1️⃣a(b: Int) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: initializers cannot have a name, Fix-It replacements: 8 - 9 = ''
        DiagnosticSpec(message: "unexpected code 'a' before parameter clause")
      ]
    )
  }

  func testRecovery145() {
    AssertParse(
      """
      init? 1️⃣c(_ d: Int) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: initializers cannot have a name, Fix-It replacements: 9 - 10 = ''
        DiagnosticSpec(message: "unexpected code 'c' before parameter clause")
      ]
    )
  }

  func testRecovery146() {
    AssertParse(
      """
      init 1️⃣e<T>(f: T) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: initializers cannot have a name, Fix-It replacements: 8 - 9 = ''
        DiagnosticSpec(message: "unexpected code 'e<T>' before parameter clause")
      ]
    )
  }

  func testRecovery147() {
    AssertParse(
      """
      init? 1️⃣g<T>(_: T) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: initializers cannot have a name, Fix-It replacements: 9 - 10 = ''
        DiagnosticSpec(message: "unexpected code 'g<T>' before parameter clause")
      ]
    )
  }

  func testRecovery148() {
    AssertParse(
      """
      init 1️⃣c d: Int 2️⃣{}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '(' to start parameter clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' to end parameter clause"),
      ]
    )
  }

  func testRecovery150() {
    AssertParse(
      """
      let n 1️⃣== C { get {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous code at top level")
      ]
    )
  }

  func testRecovery151() {
    AssertParse(
      #"""
      // <rdar://problem/20489838> QoI: Nonsensical error and fixit if "let" is missing between 'if let ... where' clauses
      if let y = x 1️⃣where y == 0, let z = x {
        _ = y
        _ = z
      }2️⃣
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 4: expected ',' joining parts of a multi-clause condition, Fix-It replacements: 15 - 21 = ','
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '{' in 'if' statement"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code 'where y == 0,' before variable"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '}' to end 'if' statement"),
      ]
    )
  }

  func testRecovery152() {
    AssertParse(
      """
      if var y = x, y == 0, var z = x {
        z = y; y = z
      }
      """
    )
  }

  func testRecovery153() {
    AssertParse(
      """
      if var y = x, z = x { 
        z = y; y = z
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected 'var' in conditional, Fix-It replacements: 17 - 17 = 'var '
      ]
    )
  }

  func testRecovery154() {
    AssertParse(
      #"""
      // <rdar://problem/20883210> QoI: Following a "let" condition with boolean condition spouts nonsensical errors
      guard let x: Int? = 1, x == 1 else {  }
      """#
    )
  }

  func testRecovery156() {
    AssertParse(
      """
      // rdar://20866942
      func testRefutableLet() {
        var e : Int?
        let x1️⃣? = e  
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '? = e' in function")
      ]
    )
  }

  func testRecovery157() {
    AssertParse(
      #"""
      // <rdar://problem/19833424> QoI: Bad error message when using Objective-C literals (@"Hello") in Swift files
      let myString = 1️⃣@"foo"
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: string literals in Swift are not preceded by an '@' sign, Fix-It replacements: 16 - 17 = ''
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: #"extraneous code '@"foo"' at top level"#),
      ]
    )
  }

  func testRecovery158() {
    AssertParse(
      """
      // <rdar://problem/16990885> support curly quotes for string literals
      let curlyQuotes1 = 1️⃣“hello world!”
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unicode curly quote found, replace with '"', Fix-It replacements: 35 - 38 = '"'
        // TODO: Old parser expected error on line 2: unicode curly quote found, replace with '"', Fix-It replacements: 20 - 23 = '"'
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: "extraneous code '“hello world!”' at top level"),
      ]
    )
  }

  func testRecovery159() {
    AssertParse(
      #"""
      let curlyQuotes2 = 1️⃣“hello world!"
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unicode curly quote found, replace with '"', Fix-It replacements: 20 - 23 = '"'
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: #"extraneous code '“hello world!"' at top level"#),
      ]
    )
  }

  func testRecovery160() {
    AssertParse(
      #"""
      // <rdar://problem/21196171> compiler should recover better from "unicode Specials" characters
      let ￼tryx  = 123
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: invalid character in source file, Fix-It replacements: 5 - 8 = ' '
      ]
    )
  }

  func testRecovery161() {
    AssertParse(
      """
      // <rdar://problem/21369926> Malformed Swift Enums crash playground service
      enum Rank: Int {  
        case Ace = 1
        case Two = 2.1  
      }
      """
    )
  }

  func testRecovery162() {
    AssertParse(
      """
      // rdar://22240342 - Crash in diagRecursivePropertyAccess
      class r22240342 {
        lazy var xx: Int = {
          foo {  
            let issueView = 42
            issueView.delegate = 12
          }
          return 42
          }()
      }
      """
    )
  }

  func testRecovery163() {
    AssertParse(
      """
      // <rdar://problem/22387625> QoI: Common errors: 'let x= 5' and 'let x =5' could use Fix-its
      func r22387625() {
        let _= 5 
        let _ =5 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: '=' must have consistent whitespace on both sides, Fix-It replacements: 8 - 8 = ' '
        // TODO: Old parser expected error on line 4: '=' must have consistent whitespace on both sides, Fix-It replacements: 10 - 10 = ' '
      ]
    )
  }

  func testRecovery164() {
    AssertParse(
      """
      // https://github.com/apple/swift/issues/45723
      do {
        let _: Int= 5 
        let _: Array<Int>= [] 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: '=' must have consistent whitespace on both sides, Fix-It replacements: 13 - 13 = ' '
        // TODO: Old parser expected error on line 4: '=' must have consistent whitespace on both sides, Fix-It replacements: 20 - 20 = ' '
      ]
    )
  }

  func testRecovery165() {
    AssertParse(
      """
      // <rdar://problem/23086402> Swift compiler crash in CSDiag
      protocol A23086402 {
        var b: B23086402 { get }
      }
      """
    )
  }

  func testRecovery166() {
    AssertParse(
      """
      protocol B23086402 {
        var c: [String] { get }
      }
      """
    )
  }

  func testRecovery167() {
    AssertParse(
      #"""
      func test23086402(a: A23086402) {
        print(a.b.c + "") // should not crash but: expected-error {{}}
      }
      """#
    )
  }

  func testRecovery168() {
    AssertParse(
      #"""
      // <rdar://problem/23550816> QoI: Poor diagnostic in argument list of "print" (varargs related)
      // The situation has changed. String now conforms to the RangeReplaceableCollection protocol
      // and `ss + s` becomes ambiguous. Disambiguation is provided with the unavailable overload
      // in order to produce a meaningful diagnostics. (Related: <rdar://problem/31763930>)
      func test23550816(ss: [String], s: String) {
        print(ss + s)  
      }
      """#
    )
  }

  func testRecovery169() {
    AssertParse(
      """
      // <rdar://problem/23719432> [practicalswift] Compiler crashes on &(Int:_)
      func test23719432() {
        var x = 42
          &(Int:x) 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: '&' may only be used to pass an argument to inout parameter
      ]
    )
  }

  func testRecovery170() {
    AssertParse(
      """
      // <rdar://problem/19911096> QoI: terrible recovery when using '·' for an operator
      infix operator 1️⃣· 2️⃣{
        associativity none precedence3️⃣ 150
      4️⃣}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "'·' is considered an identifier and must not appear within an operator name"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "operator should not be declared with body"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "extraneous brace at top level"),
      ]
    )
  }

  func testRecovery171() {
    AssertParse(
      """
      infix operator -1️⃣@-class Recover1 {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '@' is not allowed in operator names
        DiagnosticSpec(message: "'@-class' is not allowed in operator names")
      ]
    )
  }

  func testRecovery172() {
    AssertParse(
      """
      prefix operator -1️⃣фф--class Recover2 {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'фф' is considered an identifier and must not appear within an operator name
        DiagnosticSpec(message: "'фф--class' is not allowed in operator names")
      ]
    )
  }

  func testRecovery173() {
    AssertParse(
      #"""
      // <rdar://problem/21712891> Swift Compiler bug: String subscripts with range should require closing bracket.
      func r21712891(s : String) -> String {
        let a = s.startIndex..<s.startIndex
        _ = a
        // The specific errors produced don't actually matter, but we need to reject this.
        return "\(s[a1️⃣)"  
      }
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected ']' to end subscript")
      ]
    )
  }

  func testRecovery174() {
    AssertParse(
      #"""
      // <rdar://problem/24029542> "Postfix '.' is reserved" error message" isn't helpful
      func postfixDot(a : String) {
        _ = a.utf8
        _ = a1️⃣.   utf8  
        _ = a.       
          a.         
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 4: extraneous whitespace after '.' is not permitted, Fix-It replacements: 9 - 12 = ''
        DiagnosticSpec(message: "unexpected code in function")
        // TODO: Old parser expected error on line 5: expected member name following '.'
        // TODO: Old parser expected error on line 6: expected member name following '.'
      ]
    )
  }

  func testRecovery175() {
    AssertParse(
      #"""
      // <rdar://problem/22290244> QoI: "UIColor." gives two issues, should only give one
      func f() { // expected-note 2{{did you mean 'f'?}}
        _ = ClassWithStaticDecls1️⃣.  
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 3: expected member name following '.'
        DiagnosticSpec(message: "unexpected code '.' in function")
      ]
    )
  }

  func testRecovery176() {
    AssertParse(
      """
      // rdar://problem/22478168
      // https://github.com/apple/swift/issues/53396
      func f_53396(a: Int 1️⃣== 0) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: expected '=' instead of '==' to assign default value for parameter, Fix-It replacements: 21 - 23 = '='
        DiagnosticSpec(message: "unexpected code '== 0' in parameter clause")
      ]
    )
  }

  func testRecovery177() {
    AssertParse(
      """
      // rdar://38225184
      extension Collection where Element == Int 1️⃣&& Index == Int {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '&& Index == Int' in extension")
        // TODO: Old parser expected error on line 1: expected ',' to separate the requirements of this 'where' clause, Fix-It replacements: 43 - 45 = ','
      ]
    )
  }

  func testRecovery179() {
    AssertParse(
      """
      func testSkipUnbalancedParen() {1️⃣
        2️⃣?( 
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '}' to end function"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code at top level"),
      ]
    )
  }

  func testRecovery180() {
    AssertParse(
      """
      func testSkipToFindOpenBrace1() {
        do { if case 1️⃣}
      }2️⃣
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected expression, '=', and expression in pattern matching"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '{' in 'if' statement"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '}' to end function"),
      ]
    )
  }

  func testRecovery181() {
    AssertParse(
      """
      func testSkipToFindOpenBrace2() {
        do { if true {} else 1️⃣false } 
      }2️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '{' or 'if' after 'else'
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '{' in 'if' statement"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '}' to end function"),
      ]
    )
  }

}
