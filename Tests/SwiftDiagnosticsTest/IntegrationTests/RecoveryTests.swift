////===----------------------------------------------------------------------===//
////
//// This source file is part of the Swift.org open source project
////
//// Copyright (c) 2023 Apple Inc. and the Swift project authors
//// Licensed under Apache License v2.0 with Runtime Library Exception
////
//// See https://swift.org/LICENSE.txt for license information
//// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
////
////===----------------------------------------------------------------------===//
//
//// This test file has been translated from swift/test/Parse/recovery.swift
//
//import SwiftSyntax
//import XCTest
//
//final class RecoveryTests: XCTestCase {
//  func testRecovery1() {
//    assertParse(
//      #"""
//      func garbage() -> () {
//        var a : Int
//        ) this line is invalid, but we will stop at the keyword below...
//        return a + "a"
//      }
//      """#,
//      diagnostics: [
//        DiagnosticSpec(message: "unexpected code ') this line is invalid, but we will stop at the keyword below...' before 'return' statement")
//      ]
//    )
//  }
//
//  func testRecovery2() {
//    assertParse(
//      #"""
//      func moreGarbage() -> () {
//        ) this line is invalid, but we will stop at the declaration...
//        func a() -> Int { return 4 }
//        return a() + "a"
//      }
//      """#,
//      diagnostics: [
//        DiagnosticSpec(message: "unexpected code ') this line is invalid, but we will stop at the declaration...' before function")
//      ]
//    )
//  }
//
//  func testRecovery3() {
//    assertParse(
//      """
//      class Container<T> {
//        func exists() -> Bool { return true }
//      }
//      """
//    )
//  }
//
//  func testRecovery4() {
//    assertParse(
//      """
//      func useContainer() -> () {
//        var a : Container<not a type [skip this greater: >] >, b : Int
//        b = 5 // no-warning
//        a.exists()
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected '>' to end generic argument clause",
//          notes: [NoteSpec(message: "to match this opening '<'")],
//          fixIts: ["insert '>'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected '=' in variable",
//          fixIts: ["insert '='"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "unexpected code 'this greater: >' in subscript"
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected expression after operator",
//          fixIts: ["insert expression"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "unexpected code in function"
//        ),
//      ],
//      applyFixIts: ["insert '>'", "insert expression"],
//      fixedSource: """
//        func useContainer() -> () {
//          var a : Container<not> a type [skip this greater: >] > <#expression#>, b : Int
//          b = 5 // no-warning
//          a.exists()
//        }
//        """
//    )
//  }
//
//  func testRecovery5() {
//    assertParse(
//      """
//      @xyz class BadAttributes {
//        func exists() -> Bool { return true }
//      }
//      """
//    )
//  }
//
//  func testRecovery6() {
//    assertParse(
//      """
//      func test(a: BadAttributes) -> () {
//        _ = a.exists() // no-warning
//      }
//      """
//    )
//  }
//
//  func testRecovery7() {
//    assertParse(
//      """
//      // Here is an extra random close-brace!
//      }
//      //===--- Recovery for braced blocks.
//      func braceStmt1() {
//        { braceStmt1(); }a
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "unexpected brace before function"
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "consecutive statements on a line must be separated by newline or ';'",
//          fixIts: ["insert newline", "insert ';'"]
//        ),
//      ],
//      applyFixIts: ["insert newline"],
//      fixedSource: """
//        // Here is an extra random close-brace!
//        }
//        //===--- Recovery for braced blocks.
//        func braceStmt1() {
//          { braceStmt1(); }
//          a
//        }
//        """
//    )
//  }
//
//  func testRecovery8() {
//    assertParse(
//      """
//      // Here is an extra random close-brace!
//      }
//      //===--- Recovery for braced blocks.
//      func braceStmt1() {
//        { braceStmt1(); }a
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "unexpected brace before function"
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "consecutive statements on a line must be separated by newline or ';'",
//          fixIts: ["insert newline", "insert ';'"]
//        ),
//      ],
//      applyFixIts: ["insert ';'"],
//      fixedSource: """
//        // Here is an extra random close-brace!
//        }
//        //===--- Recovery for braced blocks.
//        func braceStmt1() {
//          { braceStmt1(); }; a
//        }
//        """
//    )
//  }
//
//  func testRecovery9() {
//    assertParse(
//      """
//      func braceStmt2() {
//        { () in braceStmt2(); }
//      }
//      """
//    )
//  }
//
//  func testRecovery10() {
//    assertParse(
//      """
//      func braceStmt3() {
//        {
//          undefinedIdentifier {}
//        }
//      }
//      """
//    )
//  }
//
//  // MARK: - Recovery for misplaced 'static'
//
//  func testRecovery11() {
//    assertParse(
//      """
//      static func toplevelStaticFunc() {}
//      static struct StaticStruct {}
//      static class StaticClass {}
//      static protocol StaticProtocol {}
//      static typealias StaticTypealias = Int
//      class ClassWithStaticDecls {
//        class var a = 42
//      }
//      """
//    )
//  }
//
//  func testRecovery12() {
//    assertParse(
//      """
//      if
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected expression and body in 'if' statement", fixIts: ["insert expression and body"])
//      ],
//      fixedSource: """
//        if <#expression#> {
//        }
//        """
//    )
//  }
//
//  func testRecovery13() {
//    assertParse(
//      """
//      if {
//        }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "missing condition in 'if' statement")
//      ]
//    )
//  }
//
//  func testRecovery14() {
//    assertParse(
//      """
//      if
//        {
//        }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "missing condition in 'if' statement")
//      ]
//    )
//  }
//
//  func testRecovery15() {
//    assertParse(
//      """
//      if true {
//        } else if {
//        }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "missing condition in 'if' statement")
//      ]
//    )
//  }
//
//  func testRecovery16() {
//    // It is debatable if we should do recovery here and parse { true } as the
//    // body, but the error message should be sensible.
//    assertParse(
//      """
//      if { true } {
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "missing condition in 'if' statement")
//      ]
//    )
//  }
//
//  func testRecovery17() {
//    assertParse(
//      """
//      if { true }() {
//        }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "missing condition in 'if' statement")
//      ]
//    )
//  }
//
//  func testRecovery18() {
//    // <rdar://problem/18940198>
//    assertParse(
//      """
//      if { { } }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "missing condition in 'if' statement")
//      ]
//    )
//  }
//
//  func testRecovery19() {
//    assertParse(
//      """
//      while
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected expression and code block in 'while' statement", fixIts: ["insert expression and code block"])
//      ],
//      fixedSource: """
//        while <#expression#> {
//        }
//        """
//    )
//  }
//
//  func testRecovery20() {
//    assertParse(
//      """
//      while {
//        }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "missing condition in 'while' statement")
//      ]
//    )
//  }
//
//  func testRecovery21() {
//    assertParse(
//      """
//      while
//        {
//        }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "missing condition in 'while' statement")
//      ]
//    )
//  }
//
//  func testRecovery22() {
//    // It is debatable if we should do recovery here and parse { true } as the
//    // body, but the error message should be sensible.
//    assertParse(
//      """
//      while { true } {
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "missing condition in 'while' statement")
//      ]
//    )
//  }
//
//  func testRecovery23() {
//    assertParse(
//      """
//      while { true }() {
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "missing condition in 'while' statement")
//      ]
//    )
//  }
//
//  func testRecovery24() {
//    // <rdar://problem/18940198>
//    assertParse(
//      """
//      while { { } }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "missing condition in 'while' statement")
//      ]
//    )
//  }
//
//  func testRecovery25() {
//    assertParse(
//      """
//      repeat {
//      } while
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected condition in 'repeat' statement", fixIts: ["insert condition"])
//      ],
//      fixedSource: """
//        repeat {
//        } while <#expression#>
//        """
//    )
//  }
//
//  func testRecovery26() {
//    assertParse(
//      """
//      {
//        missingControllingExprInRepeatWhile();
//      }
//      """
//    )
//  }
//
//  func testRecovery27() {
//    assertParse(
//      """
//      repeat {
//      } while { true }()
//      """,
//      diagnostics: [
//        // TODO: Old parser expected error on line 2: missing condition in 'while' statement
//        // TODO: Old parser expected error on line 2: consecutive statements on a line must be separated by ';', Fix-It replacements: 10 - 10 = ';'
//        // TODO: Old parser expected warning on line 2: result of call to closure returning 'Bool' is unused
//      ]
//    )
//  }
//
//  func testRecovery28() {
//    // https://github.com/apple/swift/issues/42787
//    assertParse(
//      """
//      repeat {
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected 'while' and condition in 'repeat' statement", fixIts: ["insert 'while' and condition"])
//      ],
//      fixedSource: """
//        repeat {
//        } while <#expression#>
//        """
//    )
//  }
//
//  func testRecovery29() {
//    assertParse(
//      """
//      for ; {
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected pattern, 'in', and expression in 'for' statement", fixIts: ["insert pattern, 'in', and expression"]),
//        DiagnosticSpec(message: "unexpected ';' separator", fixIts: ["remove ';'"]),
//      ],
//      fixedSource: """
//        for <#pattern#> in <#expression#> {
//        }
//        """
//    )
//  }
//
//  func testRecovery30() {
//    assertParse(
//      """
//      for ;
//        {
//        }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected pattern, 'in', and expression in 'for' statement", fixIts: ["insert pattern, 'in', and expression"]),
//        DiagnosticSpec(message: "unexpected ';' separator", fixIts: ["remove ';'"]),
//      ],
//      fixedSource: """
//        for <#pattern#> in <#expression#>
//          {
//          }
//        """
//    )
//  }
//
//  func testRecovery31() {
//    assertParse(
//      """
//      for ; true {
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected pattern, 'in', and expression in 'for' statement", fixIts: ["insert pattern, 'in', and expression"]),
//        DiagnosticSpec(message: "unexpected code '; true' in 'for' statement"),
//      ],
//      fixedSource: """
//        for <#pattern#> in <#expression#> ; true {
//        }
//        """
//    )
//  }
//
//  func testRecovery32() {
//    assertParse(
//      """
//      for var i = 0; true {
//        i += 1
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected 'in' and expression in 'for' statement", fixIts: ["insert 'in' and expression"]),
//        DiagnosticSpec(message: "unexpected code '= 0; true' in 'for' statement"),
//      ],
//      fixedSource: """
//        for var i in <#expression#> = 0; true {
//          i += 1
//        }
//        """
//    )
//  }
//
//  func testRecovery33() {
//    assertParse(
//      """
//      for
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected pattern, 'in', expression, and body in 'for' statement", fixIts: ["insert pattern, 'in', expression, and body"])
//      ],
//      fixedSource: """
//        for <#pattern#> in <#expression#> {
//        }
//        """
//    )
//  }
//
//  func testRecovery34() {
//    assertParse(
//      """
//      for {
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected pattern, 'in', and expression in 'for' statement",
//          fixIts: ["insert pattern, 'in', and expression"]
//        )
//      ],
//      fixedSource: """
//        for <#pattern#> in <#expression#> {
//        }
//        """
//    )
//  }
//
//  func testRecovery35() {
//    assertParse(
//      """
//      for
//      {
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected pattern, 'in', and expression in 'for' statement",
//          fixIts: ["insert pattern, 'in', and expression"]
//        )
//      ],
//      fixedSource: """
//        for <#pattern#> in <#expression#>
//        {
//        }
//        """
//    )
//  }
//
//  func testRecovery36() {
//    assertParse(
//      """
//      for i {
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(locationMarker: "", message: "expected 'in' and expression in 'for' statement", fixIts: ["insert 'in' and expression"])
//      ],
//      fixedSource: """
//        for i in <#expression#> {
//        }
//        """
//    )
//  }
//
//  func testRecovery37() {
//    assertParse(
//      """
//      for var i {
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(locationMarker: "", message: "expected 'in' and expression in 'for' statement", fixIts: ["insert 'in' and expression"])
//      ],
//      fixedSource: """
//        for var i in <#expression#> {
//        }
//        """
//    )
//  }
//
//  func testRecovery38() {
//    assertParse(
//      """
//      for in {
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "keyword 'in' cannot be used as an identifier here",
//          fixIts: ["if this name is unavoidable, use backticks to escape it"]
//        ),
//        DiagnosticSpec(locationMarker: "", message: "expected 'in' and expression in 'for' statement", fixIts: ["insert 'in' and expression"]),
//      ],
//      fixedSource: """
//        for `in` in <#expression#> {
//        }
//        """
//    )
//  }
//
//  func testRecovery39() {
//    assertParse(
//      """
//      for 0..<12 {
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected pattern and 'in' in 'for' statement", fixIts: ["insert pattern and 'in'"])
//      ],
//      fixedSource: """
//        for <#pattern#> in 0..<12 {
//        }
//        """
//    )
//  }
//
//  func testRecovery40() {
//    assertParse(
//      """
//      for for in {
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "keyword 'for' cannot be used as an identifier here",
//          fixIts: ["if this name is unavoidable, use backticks to escape it"]
//        ),
//        DiagnosticSpec(locationMarker: "", message: "expected Sequence expression for for-each loop", fixIts: ["insert expression"]),
//      ],
//      fixedSource: """
//        for `for` in <#expression#> {
//        }
//        """
//    )
//  }
//
//  func testRecovery41() {
//    assertParse(
//      """
//      for i in {
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected Sequence expression for for-each loop", fixIts: ["insert expression"])
//      ],
//      fixedSource: """
//        for i in <#expression#> {
//        }
//        """
//    )
//  }
//
//  func testRecovery42() {
//    // https://github.com/apple/swift/issues/48502
//    assertParse(
//      #"""
//      struct User { let name: String? }
//
//      let users = [User]()
//      for user in users whe {
//        if let name = user.name {
//          let key = "\(name)"
//        }
//      }
//      """#,
//      diagnostics: [
//        DiagnosticSpec(message: "unexpected code 'whe' in 'for' statement")
//      ]
//    )
//  }
//
//  func testRecovery43() {
//    assertParse(
//      """
//      for
//        ;
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected pattern, 'in', and expression in 'for' statement",
//          fixIts: ["insert pattern, 'in', and expression"]
//        ),
//        DiagnosticSpec(locationMarker: "", message: "expected '{' in 'for' statement", fixIts: ["insert '{'"]),
//        DiagnosticSpec(locationMarker: "", message: "standalone ';' statements are not allowed", fixIts: ["remove ';'"]),
//      ],
//      fixedSource: """
//        for   <#pattern#> in <#expression#> {
//        }
//        """
//    )
//  }
//
//  func testRecovery44() {
//    assertParse(
//      """
//      switch
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected expression and '{}' to end 'switch' statement", fixIts: ["insert expression and '{}'"])
//      ],
//      fixedSource: """
//        switch <#expression#> {
//        }
//        """
//    )
//  }
//
//  func testRecovery45() {
//    assertParse(
//      """
//      switch {
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(locationMarker: "", message: "expected expression in 'switch' statement", fixIts: ["insert expression"])
//      ],
//      fixedSource: """
//        switch <#expression#> {
//        }
//        """
//    )
//  }
//
//  func testRecovery46() {
//    assertParse(
//      """
//      switch
//      {
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(locationMarker: "", message: "expected expression in 'switch' statement", fixIts: ["insert expression"])
//      ],
//      fixedSource: """
//        switch <#expression#>
//        {
//        }
//        """
//    )
//  }
//
//  func testRecovery47() {
//    assertParse(
//      """
//      switch {
//        case _: return
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(locationMarker: "", message: "expected expression in 'switch' statement")
//      ]
//    )
//  }
//
//  func testRecovery48() {
//    assertParse(
//      """
//      switch {
//        case Int: return
//        case _: return
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(locationMarker: "", message: "expected expression in 'switch' statement")
//      ]
//    )
//  }
//
//  func testRecovery49() {
//    assertParse(
//      """
//      switch { 42 } {
//        case _: return
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(locationMarker: "", message: "expected expression in 'switch' statement"),
//        DiagnosticSpec(locationMarker: "", message: "all statements inside a switch must be covered by a 'case' or 'default' label", fixIts: ["insert label"]),
//        DiagnosticSpec(locationMarker: "", message: "'case' can only appear inside a 'switch' statement or 'enum' declaration"),
//      ],
//      fixedSource: """
//        switch {
//        case <#identifier#>: 42 } {
//          case _: return
//        }
//        """
//    )
//  }
//
//  func testRecovery50() {
//    assertParse(
//      """
//      switch { 42 }() {
//        case _: return
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected expression in 'switch' statement"
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "all statements inside a switch must be covered by a 'case' or 'default' label",
//          fixIts: ["insert label"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "consecutive statements on a line must be separated by newline or ';'",
//          fixIts: ["insert newline", "insert ';'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "'case' can only appear inside a 'switch' statement or 'enum' declaration"
//        ),
//      ],
//      applyFixIts: ["insert label", "insert newline"],
//      fixedSource: """
//        switch {
//        case <#identifier#>: 42 }()
//        {
//          case _: return
//        }
//        """
//    )
//  }
//
//  func testRecovery51() {
//    assertParse(
//      """
//      switch { 42 }() {
//        case _: return
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected expression in 'switch' statement"
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "all statements inside a switch must be covered by a 'case' or 'default' label",
//          fixIts: ["insert label"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "consecutive statements on a line must be separated by newline or ';'",
//          fixIts: ["insert newline", "insert ';'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "'case' can only appear inside a 'switch' statement or 'enum' declaration"
//        ),
//      ],
//      applyFixIts: ["insert label", "insert ';'"],
//      fixedSource: """
//        switch {
//        case <#identifier#>: 42 }(); {
//          case _: return
//        }
//        """
//    )
//  }
//
//  // MARK: - Recovery for missing braces in nominal type decls.
//
//  func testRecovery52() {
//    assertParse(
//      """
//      struct NoBracesStruct1()
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected member block in struct", fixIts: ["insert member block"])
//      ],
//      fixedSource: """
//        struct NoBracesStruct1 {
//        }()
//        """
//    )
//  }
//
//  func testRecovery53() {
//    assertParse(
//      """
//      enum NoBracesUnion1()
//      class NoBracesClass1()
//      protocol NoBracesProtocol1()
//      extension NoBracesStruct1()
//      """,
//      diagnostics: [
//        DiagnosticSpec(locationMarker: "", message: "expected '{' in enum", fixIts: ["insert '{'"]),
//        DiagnosticSpec(locationMarker: "", message: "unexpected code '()' before class"),
//        DiagnosticSpec(locationMarker: "", message: "expected '{' in class", fixIts: ["insert '{'"]),
//        DiagnosticSpec(locationMarker: "", message: "unexpected code '()' before protocol"),
//        DiagnosticSpec(locationMarker: "", message: "expected '{' in protocol", fixIts: ["insert '{'"]),
//        DiagnosticSpec(locationMarker: "", message: "unexpected code '()' before extension"),
//        DiagnosticSpec(locationMarker: "", message: "expected member block in extension", fixIts: ["insert member block"]),
//        DiagnosticSpec(locationMarker: "", message: "expected '}' to end protocol", fixIts: ["insert '}'"]),
//        DiagnosticSpec(locationMarker: "", message: "expected '}' to end class", fixIts: ["insert '}'"]),
//        DiagnosticSpec(locationMarker: "", message: "expected '}' to end enum", fixIts: ["insert '}'"]),
//      ],
//      fixedSource: """
//        enum NoBracesUnion1 {()
//        class NoBracesClass1 {()
//        protocol NoBracesProtocol1 {()
//        extension NoBracesStruct1 {
//        }
//        }
//        }
//        }()
//        """
//    )
//  }
//
//  func testRecovery54() {
//    assertParse(
//      """
//      struct NoBracesStruct2
//      enum NoBracesUnion2
//      class NoBracesClass2
//      protocol NoBracesProtocol2
//      extension NoBracesStruct2
//      """,
//      diagnostics: [
//        DiagnosticSpec(locationMarker: "", message: "expected '{' in struct", fixIts: ["insert '{'"]),
//        DiagnosticSpec(locationMarker: "", message: "expected '{' in enum", fixIts: ["insert '{'"]),
//        DiagnosticSpec(locationMarker: "", message: "expected '{' in class", fixIts: ["insert '{'"]),
//        DiagnosticSpec(locationMarker: "", message: "expected '{' in protocol", fixIts: ["insert '{'"]),
//        DiagnosticSpec(locationMarker: "", message: "expected member block in extension", fixIts: ["insert member block"]),
//        DiagnosticSpec(locationMarker: "", message: "expected '}' to end protocol", fixIts: ["insert '}'"]),
//        DiagnosticSpec(locationMarker: "", message: "expected '}' to end class", fixIts: ["insert '}'"]),
//        DiagnosticSpec(locationMarker: "", message: "expected '}' to end enum", fixIts: ["insert '}'"]),
//        DiagnosticSpec(locationMarker: "", message: "expected '}' to end struct", fixIts: ["insert '}'"]),
//      ],
//      fixedSource: """
//        struct NoBracesStruct2 {
//        enum NoBracesUnion2 {
//        class NoBracesClass2 {
//        protocol NoBracesProtocol2 {
//        extension NoBracesStruct2 {
//        }
//        }
//        }
//        }
//        }
//        """
//    )
//  }
//
//  // MARK: - Recovery for multiple identifiers in decls
//
//  func testRecovery55() {
//    let testCases: [UInt: (fixIt: String, fixedSource: String)] = [
//      #line: ("join the identifiers together", "protocol Multiident {}"),
//      #line: ("join the identifiers together with camel-case", "protocol MultiIdent {}"),
//    ]
//
//    for (line, testCase) in testCases {
//      assertParse(
//        """
//        protocol Multi ident {}
//        """,
//        diagnostics: [
//          DiagnosticSpec(
//            message: "found an unexpected second identifier in protocol; is there an accidental break?",
//            highlight: "ident",
//            fixIts: ["join the identifiers together", "join the identifiers together with camel-case"],
//            line: line
//          )
//        ],
//        applyFixIts: [testCase.fixIt],
//        fixedSource: testCase.fixedSource,
//        line: line
//      )
//    }
//  }
//
//  func testRecovery56() {
//    assertParse(
//      """
//      class CCC CCC<T> {}
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "found an unexpected second identifier in class; is there an accidental break?",
//          highlight: "CCC<T>",
//          fixIts: ["join the identifiers together"]
//        )
//      ],
//      fixedSource: """
//        class CCCCCC<T> {}
//        """
//    )
//  }
//
//  func testRecovery57() {
//    assertParse(
//      """
//      enum EE EE<T> where T : Multi {
//        case a a
//        case b
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "found an unexpected second identifier in enum; is there an accidental break?",
//          fixIts: ["join the identifiers together"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "consecutive declarations on a line must be separated by newline or ';'",
//          fixIts: ["insert newline", "insert ';'"]
//        ),
//        DiagnosticSpec(locationMarker: "", message: "unexpected code 'a' before enum case"),
//      ],
//      applyFixIts: ["join the identifiers together", "insert newline"],
//      fixedSource: """
//        enum EEEE<T> where T : Multi {
//          case a
//          a
//          case b
//        }
//        """
//    )
//  }
//
//  func testRecovery58() {
//    assertParse(
//      """
//      enum EE EE<T> where T : Multi {
//        case a a
//        case b
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "found an unexpected second identifier in enum; is there an accidental break?",
//          fixIts: ["join the identifiers together"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "consecutive declarations on a line must be separated by newline or ';'",
//          fixIts: ["insert newline", "insert ';'"]
//        ),
//        DiagnosticSpec(locationMarker: "", message: "unexpected code 'a' before enum case"),
//      ],
//      applyFixIts: ["join the identifiers together", "insert ';'"],
//      fixedSource: """
//        enum EEEE<T> where T : Multi {
//          case a;a
//          case b
//        }
//        """
//    )
//  }
//
//  func testRecovery59() {
//    assertParse(
//      #"""
//      struct SS SS : Multi {
//        private var a b : Int = ""
//        func f() {
//          var c d = 5
//          let _ = 0
//        }
//      }
//      """#,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "found an unexpected second identifier in struct; is there an accidental break?",
//          fixIts: ["join the identifiers together"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "found an unexpected second identifier in pattern; is there an accidental break?",
//          fixIts: ["join the identifiers together", "join the identifiers together with camel-case"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected ':' in type annotation",
//          fixIts: ["insert ':'"]
//        ),
//      ],
//      fixedSource: #"""
//        struct SSSS : Multi {
//          private var ab : Int = ""
//          func f() {
//            var c: d = 5
//            let _ = 0
//          }
//        }
//        """#
//    )
//  }
//
//  func testRecovery60() {
//    assertParse(
//      """
//      let (efg hij, foobar) = (5, 6)
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected ',' in tuple pattern", fixIts: ["insert ','"])
//      ],
//      fixedSource: """
//        let (efg, hij, foobar) = (5, 6)
//        """
//    )
//  }
//
//  func testRecovery61() {
//    assertParse(
//      """
//      let (efg Hij, foobar) = (5, 6)
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected ':' in tuple pattern", fixIts: ["insert ':'"])
//      ],
//      fixedSource: """
//        let (efg: Hij, foobar) = (5, 6)
//        """
//    )
//  }
//
//  func testRecovery62() {
//    assertParse(
//      """
//      private var a b : Int = ""
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "found an unexpected second identifier in pattern; is there an accidental break?",
//          fixIts: ["join the identifiers together", "join the identifiers together with camel-case"]
//        )
//      ],
//      fixedSource: """
//        private var ab : Int = ""
//        """
//    )
//  }
//
//  func testRecovery63() {
//    assertParse(
//      """
//      _ = foobar // OK.
//      """
//    )
//  }
//
//  // MARK: - Recovery for parse errors in types.
//
//  func testRecovery64() {
//    assertParse(
//      """
//      struct ErrorTypeInVarDecl1 {
//        var v1 :
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected type in type annotation", fixIts: ["insert type"])
//      ],
//      fixedSource: """
//        struct ErrorTypeInVarDecl1 {
//          var v1 : <#type#>
//        }
//        """
//    )
//  }
//
//  func testRecovery65() {
//    assertParse(
//      """
//      struct ErrorTypeInVarDecl2 {
//        var v1 : Int.
//        var v2 : Int
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected name in member type", fixIts: ["insert name"])
//      ],
//      fixedSource: """
//        struct ErrorTypeInVarDecl2 {
//          var v1 : Int.<#identifier#>
//          var v2 : Int
//        }
//        """
//    )
//  }
//
//  func testRecovery66() {
//    assertParse(
//      """
//      struct ErrorTypeInVarDecl3 {
//        var v1 : Int<
//        var v2 : Int
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected '>' to end generic argument clause",
//          notes: [NoteSpec(message: "to match this opening '<'")],
//          fixIts: ["insert '>'"]
//        )
//      ],
//      fixedSource: """
//        struct ErrorTypeInVarDecl3 {
//          var v1 : Int< >
//          var v2 : Int
//        }
//        """
//    )
//  }
//
//  func testRecovery67() {
//    assertParse(
//      """
//      struct ErrorTypeInVarDecl4 {
//        var v1 : Int<,
//        var v2 : Int
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected '>' to end generic argument clause",
//          notes: [NoteSpec(message: "to match this opening '<'")],
//          fixIts: ["insert '>'"]
//        )
//      ],
//      fixedSource: """
//        struct ErrorTypeInVarDecl4 {
//          var v1 : Int< >,
//          var v2 : Int
//        }
//        """
//    )
//  }
//
//  func testRecovery68() {
//    assertParse(
//      """
//      struct ErrorTypeInVarDecl5 {
//        var v1 : Int<Int
//        var v2 : Int
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected '>' to end generic argument clause",
//          notes: [NoteSpec(message: "to match this opening '<'")],
//          fixIts: ["insert '>'"]
//        )
//      ],
//      fixedSource: """
//        struct ErrorTypeInVarDecl5 {
//          var v1 : Int<Int>
//          var v2 : Int
//        }
//        """
//    )
//  }
//
//  func testRecovery69() {
//    assertParse(
//      """
//      struct ErrorTypeInVarDecl6 {
//        var v1 : Int<Int,
//                     Int
//        var v2 : Int
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected '>' to end generic argument clause",
//          notes: [
//            NoteSpec(message: "to match this opening '<'")
//          ],
//          fixIts: ["insert '>'"]
//        )
//      ],
//      fixedSource: """
//        struct ErrorTypeInVarDecl6 {
//          var v1 : Int<Int,
//                       Int>
//          var v2 : Int
//        }
//        """
//    )
//  }
//
//  func testRecovery70() {
//    assertParse(
//      """
//      struct ErrorTypeInVarDecl7 {
//        var v1 : Int<Int,
//        var v2 : Int
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected type in generic argument",
//          fixIts: ["insert type"]
//        ),
//        DiagnosticSpec(
//          message: "expected '>' to end generic argument clause",
//          notes: [NoteSpec(message: "to match this opening '<'")],
//          fixIts: ["insert '>'"]
//        ),
//      ],
//      fixedSource: """
//        struct ErrorTypeInVarDecl7 {
//          var v1 : Int<Int, <#type#>>
//          var v2 : Int
//        }
//        """
//    )
//  }
//
//  func testRecovery71() {
//    assertParse(
//      """
//      struct ErrorTypeInVarDecl12 {
//        var v1 : FooProtocol &
//        var v2 : Int
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected type in type composition", fixIts: ["insert type"])
//      ],
//      fixedSource: """
//        struct ErrorTypeInVarDecl12 {
//          var v1 : FooProtocol & <#type#>
//          var v2 : Int
//        }
//        """
//    )
//  }
//
//  func testRecovery72() {
//    assertParse(
//      """
//      struct ErrorTypeInVarDecl13 {
//        var v1 : & FooProtocol
//        var v2 : Int
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected type in type composition", fixIts: ["insert type"])
//      ],
//      fixedSource: """
//        struct ErrorTypeInVarDecl13 {
//          var v1 : <#type#> & FooProtocol
//          var v2 : Int
//        }
//        """
//    )
//  }
//
//  func testRecovery73() {
//    assertParse(
//      """
//      struct ErrorTypeInVarDecl16 {
//        var v1 : FooProtocol &
//        var v2 : Int
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected type in type composition", fixIts: ["insert type"])
//      ],
//      fixedSource: """
//        struct ErrorTypeInVarDecl16 {
//          var v1 : FooProtocol & <#type#>
//          var v2 : Int
//        }
//        """
//    )
//  }
//
//  func testRecovery74() {
//    assertParse(
//      """
//      func ErrorTypeInPattern4(_: FooProtocol & ) { }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected type in type composition", fixIts: ["insert type"])
//      ],
//      fixedSource: """
//        func ErrorTypeInPattern4(_: FooProtocol & <#type#>) { }
//        """
//    )
//  }
//
//  func testRecovery75() {
//    assertParse(
//      """
//      struct ErrorGenericParameterList1<
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected '>' to end generic parameter clause",
//          notes: [NoteSpec(message: "to match this opening '<'")],
//          fixIts: ["insert '>'"]
//        ),
//        DiagnosticSpec(
//          message: "expected member block in struct",
//          fixIts: ["insert member block"]
//        ),
//      ],
//      fixedSource: """
//        struct ErrorGenericParameterList1< > {
//        }
//        """
//    )
//  }
//
//  func testRecovery76() {
//    assertParse(
//      """
//      struct ErrorGenericParameterList1<each
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected name in generic parameter",
//          fixIts: ["insert name"]
//        ),
//        DiagnosticSpec(
//          message: "expected '>' to end generic parameter clause",
//          notes: [NoteSpec(message: "to match this opening '<'")],
//          fixIts: ["insert '>'"]
//        ),
//        DiagnosticSpec(
//          message: "expected member block in struct",
//          fixIts: ["insert member block"]
//        ),
//      ],
//      fixedSource: """
//        struct ErrorGenericParameterList1<each <#identifier#>> {
//        }
//        """
//    )
//  }
//
//  func testRecovery77() {
//    assertParse(
//      """
//      struct ErrorGenericParameterList2<T
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected '>' to end generic parameter clause",
//          notes: [NoteSpec(message: "to match this opening '<'")],
//          fixIts: ["insert '>'"]
//        ),
//        DiagnosticSpec(
//          message: "expected member block in struct",
//          fixIts: ["insert member block"]
//        ),
//      ],
//      fixedSource: """
//        struct ErrorGenericParameterList2<T> {
//        }
//        """
//    )
//  }
//
//  func testRecovery78() {
//    assertParse(
//      """
//      struct ErrorGenericParameterList3<T,
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected generic parameter in generic parameter clause",
//          fixIts: ["insert generic parameter"]
//        ),
//        DiagnosticSpec(
//          message: "expected '>' to end generic parameter clause",
//          notes: [NoteSpec(message: "to match this opening '<'")],
//          fixIts: ["insert '>'"]
//        ),
//        DiagnosticSpec(
//          message: "expected member block in struct",
//          fixIts: ["insert member block"]
//        ),
//      ],
//      fixedSource: """
//        struct ErrorGenericParameterList3<T, <#identifier#>> {
//        }
//        """
//    )
//  }
//
//  func testRecovery79() {
//    // Note: Don't move braces to a different line here.
//    assertParse(
//      """
//      struct ErrorGenericParameterList4<
//      {
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected '>' to end generic parameter clause",
//          notes: [NoteSpec(message: "to match this opening '<'")],
//          fixIts: ["insert '>'"]
//        )
//      ],
//      fixedSource: """
//        struct ErrorGenericParameterList4< >
//        {
//        }
//        """
//    )
//  }
//
//  func testRecovery80() {
//    // Note: Don't move braces to a different line here.
//    assertParse(
//      """
//      struct ErrorGenericParameterList5<T
//      {
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected '>' to end generic parameter clause",
//          notes: [NoteSpec(message: "to match this opening '<'")],
//          fixIts: ["insert '>'"]
//        )
//      ],
//      fixedSource: """
//        struct ErrorGenericParameterList5<T>
//        {
//        }
//        """
//    )
//  }
//
//  func testRecovery81() {
//    // Note: Don't move braces to a different line here.
//    assertParse(
//      """
//      struct ErrorGenericParameterList6<T,
//      {
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected generic parameter in generic parameter clause",
//          fixIts: ["insert generic parameter"]
//        ),
//        DiagnosticSpec(
//          message: "expected '>' to end generic parameter clause",
//          notes: [NoteSpec(message: "to match this opening '<'")],
//          fixIts: ["insert '>'"]
//        ),
//      ],
//      fixedSource: """
//        struct ErrorGenericParameterList6<T, <#identifier#>>
//        {
//        }
//        """
//    )
//  }
//
//  func testRecovery82() {
//    assertParse(
//      """
//      struct ErrorTypeInVarDeclFunctionType1 {
//        var v1 : () ->
//        var v2 : Int
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected return type in function type", fixIts: ["insert return type"])
//      ],
//      fixedSource: """
//        struct ErrorTypeInVarDeclFunctionType1 {
//          var v1 : () -> <#type#>
//          var v2 : Int
//        }
//        """
//    )
//  }
//
//  func testRecovery83() {
//    let testCases: [UInt: (testCase: String, fixedSource: String)] = [
//      #line: ("let a1: Swift.Int]", "let a1: [Swift.Int]"),
//      #line: ("let a3: Set<Int>]", "let a3: [Set<Int>]"),
//      #line: ("let a4: Int]?", "let a4: [Int]?"),
//      #line: ("let a5: Int?]", "let a5: [Int?]"),
//      #line: ("let a6: [Int]]", "let a6: [[Int]]"),
//      #line: ("let a7: [String: Int]]", "let a7: [[String: Int]]"),
//      #line: ("func foo() -> Int]??", "func foo() -> [Int]??"),
//    ]
//
//    for (line, testCase) in testCases {
//      assertParse(
//        testCase.testCase,
//        diagnostics: [
//          DiagnosticSpec(message: "unexpected ']' in type; did you mean to write an array type?", fixIts: ["insert '['"], line: line)
//        ],
//        fixedSource: testCase.fixedSource,
//        line: line
//      )
//    }
//
//    assertParse(
//      """
//      let a8: Int
//      ]
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "extraneous code ']' at top level"
//        )
//      ]
//    )
//  }
//
//  func testRecovery84() {
//    assertParse(
//      """
//      let a2: Set<Int]>
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected '>' to end generic argument clause",
//          notes: [NoteSpec(message: "to match this opening '<'")],
//          fixIts: ["insert '>'"]
//        ),
//        DiagnosticSpec(message: "extraneous code ']>' at top level"),
//      ],
//      fixedSource: """
//        let a2: Set<Int>]>
//        """
//    )
//  }
//
//  func testRecovery85() {
//    assertParse(
//      """
//      struct ErrorTypeInVarDeclDictionaryType {
//        let a1: String:
//        let a2: String: Int]
//        let a3: String: [Int]
//        let a4: String: Int
//        let a5: String: Int]??
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "consecutive declarations on a line must be separated by newline or ';'",
//          fixIts: ["insert newline", "insert ';'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "unexpected code ':' before variable"
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected '[' to start dictionary type",
//          fixIts: ["insert '['"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected '[' to start dictionary type",
//          fixIts: ["insert '['"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected ']' to end dictionary type",
//          fixIts: ["insert ']'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected '[' to start dictionary type",
//          fixIts: ["insert '['"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected ']' to end dictionary type",
//          fixIts: ["insert ']'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected '[' to start dictionary type",
//          fixIts: ["insert '['"]
//        ),
//      ],
//      fixedSource: """
//        struct ErrorTypeInVarDeclDictionaryType {
//          let a1: String
//          :
//          let a2: [String: Int]
//          let a3: [String: [Int]]
//          let a4: [String: Int]
//          let a5: [String: Int]??
//        }
//        """
//    )
//
//    assertParse(
//      """
//      let a6: [Int: String]
//      ]
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "extraneous code ']' at top level"
//        )
//      ]
//    )
//  }
//
//  func testRecovery86() {
//    assertParse(
//      """
//      struct ErrorInFunctionSignatureResultArrayType1 {
//        func foo() -> Int[ {
//          return [0]
//        }
//        func bar() -> Int] {
//          return [0]
//        }
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected '}' to end struct",
//          notes: [NoteSpec(locationMarker: "", message: "to match this opening '{'")],
//          fixIts: ["insert '}'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected ']' to end array",
//          notes: [NoteSpec(locationMarker: "", message: "to match this opening '['")],
//          fixIts: ["insert ']'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "unexpected ']' in type; did you mean to write an array type?",
//          fixIts: ["insert '['"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "extraneous brace at top level"
//        ),
//      ],
//      fixedSource: """
//        struct ErrorInFunctionSignatureResultArrayType1 {
//          func foo() -> Int
//        }[ {
//            return [0]
//          }]
//          func bar() -> [Int] {
//            return [0]
//          }
//        }
//        """
//    )
//  }
//
//  func testRecovery87() {
//    assertParse(
//      """
//      struct ErrorInFunctionSignatureResultArrayType2 {
//        func foo() -> Int[0 {
//          return [0]
//        }
//      }
//      """,
//      diagnostics: [
//        // TODO: Old parser expected error to add `]` on line 2, but we should just recover to
//        //       `{` with `[0` becoming unexpected.
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected '}' to end struct",
//          notes: [NoteSpec(locationMarker: "", message: "to match this opening '{'")],
//          fixIts: ["insert '}'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected ',' in array element",
//          fixIts: ["insert ','"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected ']' to end array",
//          notes: [NoteSpec(locationMarker: "", message: "to match this opening '['")],
//          fixIts: ["insert ']'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "extraneous brace at top level"
//        ),
//      ],
//      fixedSource: """
//        struct ErrorInFunctionSignatureResultArrayType2 {
//          func foo() -> Int
//        }[0, {
//            return [0]
//          }]
//        }
//        """
//    )
//  }
//
//  func testRecovery88() {
//    assertParse(
//      """
//      struct ErrorInFunctionSignatureResultArrayType3 {
//        func foo() -> Int[0] {
//          return [0]
//        }
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "unexpected code '[0]' in function")
//      ]
//    )
//  }
//
//  func testRecovery89() {
//    assertParse(
//      """
//      struct ErrorInFunctionSignatureResultArrayType4 {
//        func foo() -> Int[0_1] {
//          return [0]
//        }
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "unexpected code '[0_1]' in function")
//      ]
//    )
//  }
//
//  func testRecovery90() {
//    assertParse(
//      """
//      struct ErrorInFunctionSignatureResultArrayType5 {
//        func foo() -> Int[0b1] {
//          return [0]
//        }
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "unexpected code '[0b1]' in function")
//      ]
//    )
//  }
//
//  func testRecovery91() {
//    assertParse(
//      """
//      struct ErrorInFunctionSignatureResultArrayType11 {
//        func foo() -> Int[(a){a++}] {
//        }
//      }
//      """,
//      diagnostics: [
//        // TODO: We should just recover to `{` with `[(a){a++}]` becoming unexpected.
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected '}' to end struct",
//          notes: [NoteSpec(message: "to match this opening '{'")],
//          fixIts: ["insert '}'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "consecutive statements on a line must be separated by newline or ';'",
//          fixIts: ["insert newline", "insert ';'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "extraneous brace at top level"
//        ),
//      ],
//      fixedSource: """
//        struct ErrorInFunctionSignatureResultArrayType11 {
//          func foo() -> Int
//        }[(a){a++}]
//          {
//          }
//        }
//        """
//    )
//  }
//
//  // Recovery for missing initial value in var decls.
//
//  func testRecovery92() {
//    assertParse(
//      """
//      struct MissingInitializer1 {
//        var v1 : Int =
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected expression in variable", fixIts: ["insert expression"])
//      ],
//      fixedSource: """
//        struct MissingInitializer1 {
//          var v1 : Int = <#expression#>
//        }
//        """
//    )
//  }
//
//  // MARK: - Recovery for expr-postfix.
//
//  func testRecovery93() {
//    assertParse(
//      """
//      func exprPostfix1(x : Int) {
//        x.
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected name in member access", fixIts: ["insert name"])
//      ],
//      fixedSource: """
//        func exprPostfix1(x : Int) {
//          x.<#identifier#>
//        }
//        """
//    )
//  }
//
//  func testRecovery94() {
//    assertParse(
//      """
//      func exprPostfix2() {
//        _ = .42
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "'.42' is not a valid floating point literal; it must be written '0.42'",
//          fixIts: ["insert '0'"]
//        )
//      ],
//      fixedSource: """
//        func exprPostfix2() {
//          _ = 0.42
//        }
//        """
//    )
//  }
//
//  func testRecovery95() {
//    assertParse(
//      """
//      //===---
//      """
//    )
//  }
//  // MARK: - Recovery for expr-super.
//
//  func testRecovery96() {
//    assertParse(
//      """
//      class Base {}
//      """
//    )
//  }
//
//  func testRecovery97() {
//    assertParse(
//      """
//      class ExprSuper1 {
//        init() {
//          super
//        }
//      }
//      """
//    )
//  }
//
//  func testRecovery98() {
//    assertParse(
//      """
//      class ExprSuper2 {
//        init() {
//          super.
//        }
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected name in member access", fixIts: ["insert name"])
//      ],
//      fixedSource: """
//        class ExprSuper2 {
//          init() {
//            super.<#identifier#>
//          }
//        }
//        """
//    )
//  }
//
//  func testRecovery99() {
//    assertParse(
//      """
//      //===--- Recovery for braces inside a nominal decl.
//      """
//    )
//  }
//
//  func testRecovery100() {
//    assertParse(
//      """
//      struct BracesInsideNominalDecl1 {
//        {
//          aaa
//        }
//        typealias A = Int
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "unexpected code before typealias declaration")
//      ]
//    )
//  }
//
//  func testRecovery101() {
//    assertParse(
//      """
//      func use_BracesInsideNominalDecl1() {
//        // Ensure that the typealias decl is not skipped.
//        var _ : BracesInsideNominalDecl1.A // no-error
//      }
//      """
//    )
//  }
//
//  func testRecovery102() {
//    // https://github.com/apple/swift/issues/43383
//    assertParse(
//      #"""
//      class С_43383 {
//          print("No one else was in the room where it happened")
//      }
//      """#,
//      diagnostics: [
//        DiagnosticSpec(locationMarker: "", message: "expected 'func' in function", fixIts: ["insert 'func'"]),
//        DiagnosticSpec(locationMarker: "", message: #"unexpected code '"No one else was in the room where it happened"' in parameter clause"#),
//      ],
//      fixedSource: #"""
//        class С_43383 {
//            func print("No one else was in the room where it happened")
//        }
//        """#
//    )
//  }
//
//  func testRecovery103() {
//    assertParse(
//      #"""
//      extension С_43383 {
//          print("The room where it happened, the room where it happened")
//      }
//      """#,
//      diagnostics: [
//        DiagnosticSpec(locationMarker: "", message: "expected 'func' in function", fixIts: ["insert 'func'"]),
//        DiagnosticSpec(locationMarker: "", message: #"unexpected code '"The room where it happened, the room where it happened"' in parameter clause"#),
//      ],
//      fixedSource: #"""
//        extension С_43383 {
//            func print("The room where it happened, the room where it happened")
//        }
//        """#
//    )
//  }
//
//  // MARK: - Recovery for wrong decl introducer keyword.
//
//  func testRecovery104() {
//    assertParse(
//      """
//      class WrongDeclIntroducerKeyword1 {
//        notAKeyword() {}
//        func foo() {}
//        class func bar() {}
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected 'func' in function", fixIts: ["insert 'func'"])
//      ],
//      fixedSource: """
//        class WrongDeclIntroducerKeyword1 {
//          func notAKeyword() {}
//          func foo() {}
//          class func bar() {}
//        }
//        """
//    )
//
//    assertParse(
//      """
//      class WrongDeclIntroducerKeyword1 {
//        notAKeyword() {}
//        var x: Int
//      }
//      """,
//      diagnostics: [DiagnosticSpec(message: "expected 'func' in function", fixIts: ["insert 'func'"])],
//      fixedSource: """
//        class WrongDeclIntroducerKeyword1 {
//          func notAKeyword() {}
//          var x: Int
//        }
//        """
//    )
//  }
//
//  // MARK: - Recovery for wrong inheritance clause.
//
//  func testRecovery105() {
//    assertParse(
//      """
//      class Base2<T> {
//      }
//      """
//    )
//  }
//
//  func testRecovery106() {
//    assertParse(
//      """
//      class SubModule {
//          class Base1 {}
//          class Base2<T> {}
//      }
//      """
//    )
//  }
//
//  func testRecovery107() {
//    assertParse(
//      """
//      class WrongInheritanceClause1(Int) {}
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected ':' to begin inheritance clause",
//          fixIts: ["replace '(' and ')' with ':'"]
//        )
//      ],
//      fixedSource: """
//        class WrongInheritanceClause1: Int {}
//        """
//    )
//  }
//
//  func testRecovery108() {
//    assertParse(
//      """
//      class WrongInheritanceClause2(Base2<Int>) {}
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected ':' to begin inheritance clause",
//          fixIts: ["replace '(' and ')' with ':'"]
//        )
//      ],
//      fixedSource: """
//        class WrongInheritanceClause2: Base2<Int>{}
//        """
//    )
//  }
//
//  func testRecovery109() {
//    assertParse(
//      """
//      class WrongInheritanceClause3<T>(SubModule.Base1) where T:AnyObject {}
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected ':' to begin inheritance clause",
//          fixIts: ["replace '(' and ')' with ':'"]
//        )
//      ],
//      fixedSource: """
//        class WrongInheritanceClause3<T>: SubModule.Base1 where T:AnyObject {}
//        """
//    )
//  }
//
//  func testRecovery110() {
//    assertParse(
//      """
//      class WrongInheritanceClause4(SubModule.Base2<Int>) {}
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected ':' to begin inheritance clause",
//          fixIts: ["replace '(' and ')' with ':'"]
//        )
//      ],
//      fixedSource: """
//        class WrongInheritanceClause4: SubModule.Base2<Int>{}
//        """
//    )
//  }
//
//  func testRecovery111() {
//    assertParse(
//      """
//      class WrongInheritanceClause5<T>(SubModule.Base2<Int>) where T:AnyObject {}
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected ':' to begin inheritance clause",
//          fixIts: ["replace '(' and ')' with ':'"]
//        )
//      ],
//      fixedSource: """
//        class WrongInheritanceClause5<T>: SubModule.Base2<Int>where T:AnyObject {}
//        """
//    )
//  }
//
//  func testRecovery112() {
//    assertParse(
//      """
//      class WrongInheritanceClause6(Int {}
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected ':' to begin inheritance clause",
//          fixIts: ["replace '(' with ':'"]
//        )
//      ],
//      fixedSource: """
//        class WrongInheritanceClause6: Int {}
//        """
//    )
//  }
//
//  func testRecovery113() {
//    assertParse(
//      """
//      class WrongInheritanceClause7<T>(Int where T:AnyObject {}
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected ':' to begin inheritance clause",
//          fixIts: ["replace '(' with ':'"]
//        )
//      ],
//      fixedSource: """
//        class WrongInheritanceClause7<T>: Int where T:AnyObject {}
//        """
//    )
//  }
//
//  func testRecovery114() {
//    // <rdar://problem/18502220> [swift-crashes 078] parser crash on invalid cast in sequence expr
//    assertParse(
//      """
//      Base=1 as Base=1
//      """
//    )
//  }
//
//  func testRecovery115() {
//    // <rdar://problem/18634543> Parser hangs at swift::Parser::parseType
//    assertParse(
//      #"""
//      public enum TestA {
//        public static func convertFromExtenndition(
//          s._core.count != 0, "Can't form a Character from an empty String")
//      }
//      """#,
//      diagnostics: [
//        DiagnosticSpec(message: "expected ':' and type in parameter", fixIts: ["insert ':' and type"]),
//        DiagnosticSpec(message: #"unexpected code '._core.count != 0, "Can't form a Character from an empty String"' in parameter clause"#),
//      ],
//      fixedSource: #"""
//        public enum TestA {
//          public static func convertFromExtenndition(
//            s: <#type#>._core.count != 0, "Can't form a Character from an empty String")
//        }
//        """#
//    )
//  }
//
//  func testRecovery116() {
//    assertParse(
//      #"""
//      public enum TestB {
//        public static func convertFromExtenndition(
//          s._core.count ?= 0, "Can't form a Character from an empty String")
//      }
//      """#,
//      diagnostics: [
//        DiagnosticSpec(message: "expected ':' and type in parameter", fixIts: ["insert ':' and type"]),
//        DiagnosticSpec(message: #"unexpected code '._core.count ?= 0, "Can't form a Character from an empty String"' in parameter clause"#),
//      ],
//      fixedSource: #"""
//        public enum TestB {
//          public static func convertFromExtenndition(
//            s: <#type#>._core.count ?= 0, "Can't form a Character from an empty String")
//        }
//        """#
//    )
//  }
//
//  func testRecovery117() {
//    // <rdar://problem/18634543> Infinite loop and unbounded memory consumption in parser
//    assertParse(
//      """
//      func foo1(bar!=baz) {}
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected ':' and type in parameter", fixIts: ["insert ':' and type"]),
//        DiagnosticSpec(message: "unexpected code '!=baz' in parameter clause"),
//      ],
//      fixedSource: """
//         func foo1(bar: <#type#>!=baz) {}
//        """
//    )
//  }
//
//  func testRecovery118() {
//    assertParse(
//      """
//      func foo2(bar! = baz) {}
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected ':' and type in parameter", fixIts: ["insert ':' and type"]),
//        DiagnosticSpec(message: "unexpected code '! = baz' in parameter clause"),
//      ],
//      fixedSource: """
//        func foo2(bar: <#type#>! = baz) {}
//        """
//    )
//  }
//
//  func testRecovery119() {
//    // rdar://19605567
//    assertParse(
//      """
//      switch esp {
//      case let (jeb):
//        class Ceac<}> {}
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected '>' to end generic parameter clause",
//          notes: [NoteSpec(message: "to match this opening '<'")],
//          fixIts: ["insert '>'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected '{' in class",
//          fixIts: ["insert '{'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "unexpected code '> {}' in 'switch' statement"
//        ),
//      ],
//      fixedSource: """
//        switch esp {
//        case let (jeb):
//          class Ceac< > {}> {}
//        }
//        """
//    )
//  }
//
//  func testRecovery120() {
//    // rdar://19605164
//    assertParse(
//      """
//      #if true
//      struct Foo19605164 {
//      func a(s: S[{{g) -> Int {}
//      }}}
//      #endif
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected ')' to end parameter clause",
//          notes: [NoteSpec(locationMarker: "", message: "to match this opening '('")],
//          fixIts: ["insert ')'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected '}' to end struct",
//          notes: [NoteSpec(locationMarker: "", message: "to match this opening '{'")],
//          fixIts: ["insert '}'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "unexpected code ') -> Int {}' in closure"
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected ',' in array element",
//          fixIts: ["insert ','"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected ']' to end array",
//          notes: [NoteSpec(locationMarker: "", message: "to match this opening '['")],
//          fixIts: ["insert ']'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "unexpected brace in conditional compilation block"
//        ),
//      ],
//      fixedSource: """
//        #if true
//        struct Foo19605164 {
//        func a(s: S)
//        }[{{g) -> Int {}
//        }},]}
//        #endif
//        """
//    )
//  }
//
//  func testRecovery121() {
//    // rdar://19605567
//    assertParse(
//      """
//      func F() { init<( } )}
//      struct InitializerWithName {
//        init x() {}
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected '>' to end generic parameter clause",
//          notes: [NoteSpec(locationMarker: "", message: "to match this opening '<'")],
//          fixIts: ["insert '>'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected ')' to end parameter clause",
//          notes: [NoteSpec(locationMarker: "", message: "to match this opening '('")],
//          fixIts: ["insert ')'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "unexpected code ')}' before struct"
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "initializers cannot have a name",
//          fixIts: ["remove 'x'"]
//        ),
//      ],
//      fixedSource: """
//        func F() { init< >() } )}
//        struct InitializerWithName {
//          init() {}
//        }
//        """
//    )
//  }
//
//  func testRecovery122() {
//    assertParse(
//      """
//      init a(b: Int) {}
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "initializers cannot have a name", fixIts: ["remove 'a'"])
//      ],
//      fixedSource: """
//        init(b: Int) {}
//        """
//    )
//  }
//
//  func testRecovery123() {
//    assertParse(
//      """
//      init? c(_ d: Int) {}
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "initializers cannot have a name", fixIts: ["remove 'c'"])
//      ],
//      fixedSource: """
//        init?(_ d: Int) {}
//        """
//    )
//  }
//
//  func testRecovery124() {
//    assertParse(
//      """
//      init e<T>(f: T) {}
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "initializers cannot have a name", fixIts: ["remove 'e<T>'"])
//      ],
//      fixedSource: """
//        init(f: T) {}
//        """
//    )
//  }
//
//  func testRecovery125() {
//    assertParse(
//      """
//      init? g<T>(_: T) {}
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "initializers cannot have a name", fixIts: ["remove 'g<T>'"])
//      ],
//      fixedSource: """
//        init?(_: T) {}
//        """
//    )
//  }
//
//  func testRecovery126() {
//    assertParse(
//      """
//      init c d: Int {}
//      """,
//      diagnostics: [
//        DiagnosticSpec(locationMarker: "", message: "expected '(' to start parameter clause", fixIts: ["insert '('"]),
//        DiagnosticSpec(locationMarker: "", message: "expected ')' to end parameter clause", fixIts: ["insert ')'"]),
//      ],
//      fixedSource: """
//        init(c d: Int) {}
//        """
//    )
//  }
//
//  func testRecovery127() {
//    assertParse(
//      """
//      let n == C { get {}
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "extraneous code at top level")
//      ]
//    )
//  }
//
//  func testRecovery128() {
//    // <rdar://problem/20489838> QoI: Nonsensical error and fixit if "let" is missing between 'if let ... where' clauses
//    assertParse(
//      """
//      if let y = x where y == 0, let z = x {
//        _ = y
//        _ = z
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected ',' joining parts of a multi-clause condition",
//          fixIts: ["replace 'where' with ','"]
//        )
//      ],
//      fixedSource: """
//        if let y = x, y == 0, let z = x {
//          _ = y
//          _ = z
//        }
//        """
//
//    )
//  }
//
//  func testRecovery129() {
//    assertParse(
//      """
//      if var y = x, y == 0, var z = x {
//        z = y; y = z
//      }
//      """
//    )
//  }
//
//  func testRecovery130() {
//    assertParse(
//      """
//      if var y = x, z = x {
//        z = y; y = z
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected 'var' in optional binding", fixIts: ["insert 'var'"])
//      ],
//      fixedSource: """
//        if var y = x, var z = x {
//          z = y; y = z
//        }
//        """
//    )
//  }
//
//  func testRecovery131() {
//    assertParse(
//      #"""
//      // <rdar://problem/20883210> QoI: Following a "let" condition with boolean condition spouts nonsensical errors
//      guard let x: Int? = 1, x == 1 else {  }
//      """#
//    )
//  }
//
//  func testRecovery132() {
//    assertParse(
//      """
//      // rdar://20866942
//      func testRefutableLet() {
//        var e : Int?
//        let x? = e
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "unexpected code '? = e' in function")
//      ]
//    )
//  }
//
//  func testRecovery133() {
//    // <rdar://problem/19833424> QoI: Bad error message when using Objective-C literals (@"Hello")
//    assertParse(
//      #"""
//      let myString = @"foo"
//      """#,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "string literals in Swift are not preceded by an '@' sign",
//          fixIts: ["remove '@'"]
//        )
//      ],
//      fixedSource: """
//        let myString = "foo"
//        """
//    )
//  }
//
//  func testRecovery134() {
//    // <rdar://problem/16990885> support curly quotes for string literals
//    assertParse(
//      """
//      let curlyQuotes1 = “hello world!”
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: #"unicode curly quote found; use '"' instead"#, fixIts: [#"replace curly quotes with '"'"#])
//      ],
//      fixedSource: """
//        let curlyQuotes1 = "hello world!"
//        """
//    )
//  }
//
//  func testRecovery135() {
//    assertParse(
//      #"""
//      let curlyQuotes2 = “hello world!"
//      """#,
//      diagnostics: [
//        DiagnosticSpec(message: #"unicode curly quote found; use '"' instead"#, fixIts: [#"replace curly quotes with '"'"#])
//      ],
//      fixedSource: #"""
//        let curlyQuotes2 = "hello world!"
//        """#
//    )
//  }
//
//  func testRecovery136() {
//    // <rdar://problem/21196171> compiler should recover better from "unicode Specials" characters
//    assertParse(
//      #"""
//      let ￼tryx  = 123
//      """#,
//      diagnostics: [
//        DiagnosticSpec(message: "invalid character in source file")
//      ]
//    )
//  }
//
//  func testRecovery137() {
//    assertParse(
//      """
//      // <rdar://problem/21369926> Malformed Swift Enums crash playground service
//      enum Rank: Int {
//        case Ace = 1
//        case Two = 2.1
//      }
//      """
//    )
//  }
//
//  func testRecovery138() {
//    assertParse(
//      """
//      // rdar://22240342 - Crash in diagRecursivePropertyAccess
//      class r22240342 {
//        lazy var xx: Int = {
//          foo {
//            let issueView = 42
//            issueView.delegate = 12
//          }
//          return 42
//          }()
//      }
//      """
//    )
//  }
//
//  func testRecovery139() {
//    // <rdar://problem/22387625> QoI: Common errors: 'let x= 5' and 'let x =5' could use Fix-its
//    assertParse(
//      """
//      func r22387625() {
//        let _= 5
//        let _ =5
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(locationMarker: "", message: "'=' must have consistent whitespace on both sides", fixIts: ["insert whitespace"]),
//        DiagnosticSpec(locationMarker: "", message: "'=' must have consistent whitespace on both sides", fixIts: ["insert whitespace"]),
//      ],
//      fixedSource: """
//        func r22387625() {
//          let _ = 5
//          let _ = 5
//        }
//        """
//    )
//  }
//
//  func testRecovery140() {
//    // https://github.com/apple/swift/issues/45723
//    assertParse(
//      """
//      do {
//        let _: Int= 5
//        let _: Array<Int>= []
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(locationMarker: "", message: "'=' must have consistent whitespace on both sides", fixIts: ["insert whitespace"]),
//        DiagnosticSpec(locationMarker: "", message: "'=' must have consistent whitespace on both sides", fixIts: ["insert whitespace"]),
//      ],
//      fixedSource: """
//        do {
//          let _: Int = 5
//          let _: Array<Int> = []
//        }
//        """
//    )
//  }
//
//  func testRecovery141() {
//    assertParse(
//      """
//      // <rdar://problem/23086402> Swift compiler crash in CSDiag
//      protocol A23086402 {
//        var b: B23086402 { get }
//      }
//      """
//    )
//  }
//
//  func testRecovery142() {
//    assertParse(
//      """
//      protocol B23086402 {
//        var c: [String] { get }
//      }
//      """
//    )
//  }
//
//  func testRecovery143() {
//    assertParse(
//      #"""
//      func test23086402(a: A23086402) {
//        print(a.b.c + "") // should not crash but: expected-error {{}}
//      }
//      """#
//    )
//  }
//
//  func testRecovery144() {
//    assertParse(
//      #"""
//      // <rdar://problem/23550816> QoI: Poor diagnostic in argument list of "print" (varargs related)
//      // The situation has changed. String now conforms to the RangeReplaceableCollection protocol
//      // and `ss + s` becomes ambiguous. Disambiguation is provided with the unavailable overload
//      // in order to produce a meaningful diagnostics. (Related: <rdar://problem/31763930>)
//      func test23550816(ss: [String], s: String) {
//        print(ss + s)
//      }
//      """#
//    )
//  }
//
//  func testRecovery145() {
//    assertParse(
//      """
//      // <rdar://problem/23719432> [practicalswift] Compiler crashes on &(Int:_)
//      func test11() {
//        var x = 42
//          &(Int:x)
//      }
//      """,
//      substructure: InOutExprSyntax(
//        ampersand: .prefixAmpersandToken(),
//        expression: ExprSyntax(
//          TupleExprSyntax(
//            leftParen: .leftParenToken(),
//            elements: LabeledExprListSyntax([
//              LabeledExprSyntax(
//                label: .identifier("Int"),
//                colon: .colonToken(),
//                expression: ExprSyntax(DeclReferenceExprSyntax(baseName: .identifier("x")))
//              )
//            ]),
//            rightParen: .rightParenToken()
//          )
//        )
//      )
//
//    )
//  }
//
//  func testRecovery146() {
//    // <rdar://problem/19911096> QoI: terrible recovery when using '·' for an operator
//    assertParse(
//      """
//      infix operator · {
//        associativity none precedence 150
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "'·' is considered an identifier and must not appear within an operator name"
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "operator should not be declared with body",
//          fixIts: ["remove operator body"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "consecutive statements on a line must be separated by newline or ';'",
//          fixIts: ["insert newline", "insert ';'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "extraneous brace at top level"
//        ),
//      ],
//      applyFixIts: ["remove operator body", "insert newline"],
//      fixedSource: """
//        infix operator · precedence
//          150
//        }
//        """
//    )
//  }
//
//  func testRecovery147() {
//    // <rdar://problem/19911096> QoI: terrible recovery when using '·' for an operator
//    assertParse(
//      """
//      infix operator · {
//        associativity none precedence 150
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "'·' is considered an identifier and must not appear within an operator name"
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "operator should not be declared with body",
//          fixIts: ["remove operator body"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "consecutive statements on a line must be separated by newline or ';'",
//          fixIts: ["insert newline", "insert ';'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "extraneous brace at top level"
//        ),
//      ],
//      applyFixIts: ["remove operator body", "insert ';'"],
//      fixedSource: """
//        infix operator · precedence; 150
//        }
//        """
//    )
//  }
//
//  func testRecovery148() {
//    assertParse(
//      """
//      infix operator -@-class Recover1 {}
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "'@-class' is not allowed in operator names", fixIts: ["remove '@-class'"])
//      ],
//      fixedSource: """
//        infix operator - Recover1 {}
//        """
//    )
//  }
//
//  func testRecovery149() {
//    assertParse(
//      """
//      prefix operator -фф--class Recover2 {}
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "'фф--class' is not allowed in operator names", fixIts: ["remove 'фф--class'"])
//      ],
//      fixedSource: """
//        prefix operator - Recover2 {}
//        """
//    )
//  }
//
//  func testRecovery150() {
//    // <rdar://problem/21712891> Swift Compiler bug: String subscripts with range should require closing bracket.
//    assertParse(
//      #"""
//      func r21712891(s : String) -> String {
//        let a = s.startIndex..<s.startIndex
//        _ = a
//        // The specific errors produced don't actually matter, but we need to reject this.
//        return "\(s[a)"
//      }
//      """#,
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected ']' to end subscript",
//          notes: [NoteSpec(message: "to match this opening '['")],
//          fixIts: ["insert ']'"]
//        )
//      ],
//      fixedSource: #"""
//        func r21712891(s : String) -> String {
//          let a = s.startIndex..<s.startIndex
//          _ = a
//          // The specific errors produced don't actually matter, but we need to reject this.
//          return "\(s[a])"
//        }
//        """#
//    )
//  }
//
//  func testRecovery151() {
//    // <rdar://problem/24029542> "Postfix '.' is reserved" error message" isn't helpful
//    assertParse(
//      #"""
//      func postfixDot(a : String) {
//        _ = a.utf8
//        _ = a.   utf8
//        _ = a.
//          a.
//      }
//      """#,
//      diagnostics: [
//        DiagnosticSpec(locationMarker: "", message: "extraneous whitespace after '.' is not permitted", fixIts: ["remove whitespace"]),
//        DiagnosticSpec(locationMarker: "", message: "expected name in member access", fixIts: ["insert name"]),
//        DiagnosticSpec(locationMarker: "", message: "expected name in member access", fixIts: ["insert name"]),
//      ],
//      fixedSource: #"""
//        func postfixDot(a : String) {
//          _ = a.utf8
//          _ = a.utf8
//          _ = a.<#identifier#>
//            a.<#identifier#>
//        }
//        """#
//    )
//  }
//
//  func testRecovery152() {
//    // <rdar://problem/22290244> QoI: "UIColor." gives two issues, should only give one
//    assertParse(
//      #"""
//      func f() { // expected-note 2{{did you mean 'f'?}}
//        _ = ClassWithStaticDecls.
//      }
//      """#,
//      diagnostics: [
//        DiagnosticSpec(message: "expected name in member access", fixIts: ["insert name"])
//      ],
//      fixedSource: #"""
//        func f() { // expected-note 2{{did you mean 'f'?}}
//          _ = ClassWithStaticDecls.<#identifier#>
//        }
//        """#
//    )
//  }
//
//  func testRecovery153() {
//    // rdar://problem/22478168
//    // https://github.com/apple/swift/issues/53396
//    assertParse(
//      """
//      func f_53396(a: Int == 0) {}
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected '=' instead of '==' to assign default value for parameter", fixIts: ["replace '==' with '='"])
//      ],
//      fixedSource: """
//        func f_53396(a: Int = 0) {}
//        """
//    )
//  }
//
//  func testRecovery154() {
//    // rdar://38225184
//    assertParse(
//      """
//      extension Collection where Element == Int && Index == Int {}
//      """,
//      diagnostics: [
//        DiagnosticSpec(message: "expected ',' to separate the requirements of this 'where' clause", fixIts: ["replace '&&' with ','"])
//      ],
//      fixedSource: """
//        extension Collection where Element == Int, Index == Int {}
//        """
//    )
//  }
//
//  func testRecovery155() {
//    assertParse(
//      """
//      func testSkipUnbalancedParen() {
//        ?(
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected '}' to end function",
//          notes: [NoteSpec(message: "to match this opening '{'")],
//          fixIts: ["insert '}'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "extraneous code at top level"
//        ),
//      ],
//      fixedSource: """
//        func testSkipUnbalancedParen() {
//        }
//          ?(
//        }
//        """
//    )
//  }
//
//  func testRecovery156() {
//    assertParse(
//      """
//      func testSkipToFindOpenBrace1() {
//        do { if case }
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected expression, '=', and expression in pattern matching",
//          fixIts: ["insert expression, '=', and expression"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected '{' in 'if' statement",
//          fixIts: ["insert '{'"]
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected '}' to end function",
//          notes: [NoteSpec(message: "to match this opening '{'")],
//          fixIts: ["insert '}'"]
//        ),
//      ],
//      fixedSource: """
//        func testSkipToFindOpenBrace2() {
//          do { if case <#expression#> = <#expression#> {}
//        }
//        }
//        """
//    )
//  }
//
//  func testRecovery157() {
//    assertParse(
//      """
//      func testSkipToFindOpenBrace3() {
//        do { if true {} else false }
//      }
//      """,
//      diagnostics: [
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected '{' or 'if' after 'else'"
//        ),
//        DiagnosticSpec(
//          locationMarker: "",
//          message: "expected '}' to end function",
//          notes: [NoteSpec(message: "to match this opening '{'")],
//          fixIts: ["insert '}'"]
//        ),
//      ],
//      fixedSource: """
//        func testSkipToFindOpenBrace4() {
//          do { if true {} else false }
//        }
//        }
//        """
//    )
//  }
//
//  func testRecovery158() {
//    assertParse(
//      "func foo() bogus {}",
//      diagnostics: [
//        DiagnosticSpec(message: "unexpected code 'bogus' in function")
//      ]
//    )
//
//    assertParse(
//      "func foo() bogus -> Int {}",
//      diagnostics: [
//        DiagnosticSpec(message: "unexpected code 'bogus' in function signature")
//      ]
//    )
//  }
//
//  // https://github.com/apple/swift-syntax/issues/1483
//  func testRecovery159() {
//    // Can be parsed and produces no diagnostics.
//    assertParse(
//      "func f< >() {}",
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected generic parameter in generic parameter clause",
//          fixIts: ["insert generic parameter"]
//        )
//      ],
//      fixedSource: """
//        func f<<#identifier#>>() {}
//        """
//    )
//
//    // Can be parsed. Printing the node or asking for the diagnostics leads to a crash.
//    assertParse(
//      "func f<>() {}",
//      diagnostics: [
//        DiagnosticSpec(
//          message: "expected generic parameter in generic parameter clause",
//          fixIts: ["insert generic parameter"]
//        )
//      ],
//      fixedSource: """
//        func f<<#identifier#>>() {}
//        """
//    )
//  }
//
//  // https://github.com/apple/swift-syntax/pull/1484/files#r1176740738
//  func testRecovery160() {
//    assertParse(
//      "func foo() -> Int:",
//      diagnostics: [
//        DiagnosticSpec(message: "extraneous code ':' at top level")
//      ]
//    )
//  }
//}
