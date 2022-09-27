// This test file has been translated from swift/test/Parse/ifconfig_expr.swift

import XCTest

final class IfconfigExprTests: XCTestCase {
  func testIfconfigExpr1() {
    AssertParse(
      """
      postfix operator ++
      postfix func ++ (_: Int) -> Int { 0 }
      """
    )
  }

  func testIfconfigExpr2() {
    AssertParse(
      """
      struct OneResult {}
      struct TwoResult {}
      """
    )
  }

  func testIfconfigExpr3() {
    AssertParse(
      """
      protocol MyProto {
          func optionalMethod() -> [Int]?
      }
      struct MyStruct {
          var optionalMember: MyProto? { nil }
          func methodOne() -> OneResult { OneResult() }
          func methodTwo() -> TwoResult { TwoResult() }
      }
      """
    )
  }

  func testIfconfigExpr4() {
    AssertParse(
      """
      func globalFunc<T>(_ arg: T) -> T { arg }
      """
    )
  }

  func testIfconfigExpr5() {
    AssertParse(
      """
      func testBasic(baseExpr: MyStruct) {
          baseExpr
      #if CONDITION_1
            .methodOne() 
      #else
            .methodTwo()
      #endif
      }
      """
    )
  }

  func testIfconfigExpr6() {
    AssertParse(
      """
      MyStruct()
      #if CONDITION_1
        .methodOne() 
      #else
        .methodTwo()
      #endif
      """
    )
  }

  func testIfconfigExpr7() {
    AssertParse(
      #"""
      func testInvalidContent(baseExpr: MyStruct, otherExpr: Int) {
        baseExpr      
      #if CONDITION_1
          { $0 + 1  } 
      #endif
        baseExpr      
      #if CONDITION_1
          #^DIAG_1^#+ otherExpr 
      #endif
        baseExpr
      #if CONDITION_1
          .methodOne() 
        #^DIAG_2^#print("debug") 
      #endif
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 8: unary operator cannot be separated from its operand
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text '+ otherExpr' in conditional compilation block"),
        // TODO: Old parser expected error on line 13: unexpected tokens in '#if' expression body
        DiagnosticSpec(locationMarker: "DIAG_2", message: #"unexpected text 'print("debug")' in conditional compilation block"#),
      ]
    )
  }

  func testIfconfigExpr8() {
    AssertParse(
      """
      func testExprKind(baseExpr: MyStruct, idx: Int) {
        baseExpr
      #if CONDITION_1
        .optionalMember?.optionalMethod()![idx]++ 
      #else
        .otherMethod(arg) {
          //...
        }
      #endif
        baseExpr
      #if CONDITION_1
        .methodOne() #^DIAG^#+ 12 
      #endif
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 12: unexpected tokens in '#if' expression body
        DiagnosticSpec(message: "unexpected text '+ 12' in conditional compilation block"),
      ]
    )
  }

  func testIfconfigExpr9() {
    AssertParse(
      """
      func emptyElse(baseExpr: MyStruct) {
        baseExpr
      #if CONDITION_1
          .methodOne() 
      #elseif CONDITION_2#^DIAG_1^#
          // OK. Do nothing.
      #endif
        baseExpr
      #if CONDITION_1
          .methodOne() 
      #elseif CONDITION_2#^DIAG_2^#
        #^DIAG_3^#return         
      #endif
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected expression in conditional compilation clause"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected expression in conditional compilation clause"),
        // TODO: Old parser expected error on line 12: unexpected tokens in '#if' expression body
        DiagnosticSpec(locationMarker: "DIAG_3", message: "unexpected text 'return' in conditional compilation block"),
      ]
    )
  }

  func testIfconfigExpr10() {
    AssertParse(
      """
      func consecutiveIfConfig(baseExpr: MyStruct) {
          baseExpr
      #if CONDITION_1
        .methodOne()
      #endif
      #if CONDITION_2
        .methodTwo()
      #endif
        .unknownMethod() 
      }
      """
    )
  }

  func testIfconfigExpr11() {
    AssertParse(
      """
      func nestedIfConfig(baseExpr: MyStruct) {
        baseExpr
      #if CONDITION_1
        #if CONDITION_2
          .methodOne()
        #endif
        #if CONDITION_1
          .methodTwo() 
        #endif
      #else
        .unknownMethod1()
        #if CONDITION_2
          .unknownMethod2()
        #endif
      #endif
      }
      """
    )
  }

  func testIfconfigExpr12() {
    AssertParse(
      """
      func ifconfigExprInExpr(baseExpr: MyStruct) {
        globalFunc( 
          baseExpr
      #if CONDITION_1
            .methodOne()
      #else
            .methodTwo()
      #endif
        )
      }
      """
    )
  }

  func testIfconfigExpr13() {
    AssertParse(
      #"""
      func canImportVersioned() {
      #if canImport(A, _version: 2)
        let a = 1
      #endif
      #if canImport(A, _version: 2.2)
        let a = 1
      #endif
      #if canImport(A, _version: 2.2.2)
        let a = 1
      #endif
      #if canImport(A, _version: 2.2.2.2)
        let a = 1
      #endif
      #if canImport(A, _version: 2.2.2.2.2) 
        let a = 1
      #endif
      #if canImport(A, _underlyingVersion: 4)
        let a = 1
      #endif
      #if canImport(A, _underlyingVersion: 2.200)
        let a = 1
      #endif
      #if canImport(A, _underlyingVersion: 2.200.1)
        let a = 1
      #endif
      #if canImport(A, _underlyingVersion: 2.200.1.3)
        let a = 1
      #endif
      #if canImport(A, unknown: 2.2) 
        let a = 1
      #endif
      #if canImport(A,#^DIAG_1^#) 
        let a = 1
      #endif
      #if canImport(A, 2.2) 
        let a = 1
      #endif
      #if canImport(A, 2.2, 1.1) 
        let a = 1
      #endif
      #if canImport(A, _version:#^DIAG_2^#) 
        let a = 1
      #endif
      #if canImport(A, _version: "") 
        let a = 1
      #endif
      #if canImport(A, _version: >=2.2) 
        let a = 1
      #endif
      #if canImport(A, _version: #^DIAG_3^#20A301) 
        let a = 1
      #endif
      #if canImport(A, _version: "20A301") 
        let a = 1
      #endif
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected warning on line 14: trailing components of version '2.2.2.2' are ignored
        // TODO: Old parser expected error on line 29: 2nd parameter of canImport should be labeled as _version or _underlyingVersion
        // TODO: Old parser expected error on line 32: unexpected ',' separator
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected value in function call"),
        // TODO: Old parser expected error on line 35: 2nd parameter of canImport should be labeled as _version or _underlyingVersion
        // TODO: Old parser expected error on line 38: canImport can take only two parameters
        // TODO: Old parser expected error on line 41: expected expression in list of expressions
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected value in function call"),
        // TODO: Old parser expected error on line 44: _version argument cannot be empty
        // TODO: Old parser expected error on line 47: cannot parse module version '>=2.2'
        // TODO: Old parser expected error on line 50: 'A' is not a valid digit in integer literal
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected value in function call"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "unexpected text '20A301' in function call"),
        // TODO: Old parser expected error on line 53: cannot parse module version '20A301'
      ]
    )
  }

}
