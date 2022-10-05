// This test file has been translated from swift/test/Parse/object_literals.swift

import XCTest

final class ObjectLiteralsTests: XCTestCase {
  func testObjectLiterals1() {
    AssertParse(
      """
      let _ = [#^DIAG_1^##Color(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)#] 
      let _ = [#^DIAG_2^##Image(imageLiteral: localResourceNameAsString)#] 
      let _ = [#^DIAG_3^##FileReference(fileReferenceLiteral: localResourceNameAsString)#]
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '[#Color(...)#]' has been renamed to '#colorLiteral(...), Fix-It replacements: 9 - 10 = '', 11 - 16 = 'colorLiteral', 17 - 32 = 'red', 78 - 80 = ''
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text '#Color(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)#' in array"),
        // TODO: Old parser expected error on line 2: '[#Image(...)#]' has been renamed to '#imageLiteral(...)', Fix-It replacements: 9 - 10 = '', 11 - 16 = 'imageLiteral', 17 - 29 = 'resourceName', 57 - 59 = ''
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text '#Image(imageLiteral: localResourceNameAsString)#' in array"),
        // TODO: Old parser expected error on line 3: '[#FileReference(...)#]' has been renamed to '#fileLiteral(...)', Fix-It replacements: 9 - 10 = '', 11 - 24 = 'fileLiteral', 25 - 45 = 'resourceName', 73 - 75 = ''
        DiagnosticSpec(locationMarker: "DIAG_3", message: "unexpected text '#FileReference(fileReferenceLiteral: localResourceNameAsString)#' in array"),
      ]
    )
  }

  func testObjectLiterals2a() {
    AssertParse(
      """
      let _ = #^DIAG^##Color(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '#Color(...)' has been renamed to '#colorLiteral(...), Fix-It replacements: 10 - 15 = 'colorLiteral', 16 - 31 = 'red'
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: "extraneous '#Color(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)' at top level"),
      ]
    )
  }

  func testObjectLiterals2b() {
    AssertParse(
      """
      let _ = #^DIAG^##Image(imageLiteral: localResourceNameAsString)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '#Image(...)' has been renamed to '#imageLiteral(...)', Fix-It replacements: 10 - 15 = 'imageLiteral', 16 - 28 = 'resourceName'
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: "extraneous '#Image(imageLiteral: localResourceNameAsString)' at top level"),
      ]
    )
  }


  func testObjectLiterals2c() {
    AssertParse(
      """
      let _ = #^DIAG^##FileReference(fileReferenceLiteral: localResourceNameAsString)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '#FileReference(...)' has been renamed to '#fileLiteral(...)', Fix-It replacements: 10 - 23 = 'fileLiteral', 24 - 44 = 'resourceName'
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: "extraneous '#FileReference(fileReferenceLiteral: localResourceNameAsString)' at top level"),
      ]
    )
  }


  func testObjectLiterals3a() {
    AssertParse(
      """
      let _ = #^DIAG^##notAPound
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: use of unknown directive '#notAPound'
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: "extraneous '#notAPound' at top level"),
      ]
    )
  }

  func testObjectLiterals3b() {
    AssertParse(
      """
      let _ = #^DIAG^##notAPound(1, 2)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: use of unknown directive '#notAPound'
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: "extraneous '#notAPound(1, 2)' at top level"),
      ]
    )
  }

  func testObjectLiterals3c() {
    AssertParse(
      """
      let _ = #^DIAG^##Color //  {{none}}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected argument list in object literal
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: "extraneous '#Color' at top level"),
      ]
    )
  }

  func testObjectLiterals4() {
    AssertParse(
      """
      let _ = [#^DIAG^###] //  {{none}}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected expression in container literal
        DiagnosticSpec(message: "unexpected text '##' in array"),
      ]
    )
  }

  func testObjectLiterals5() {
    AssertParse(
      """
      let _ = [#^DIAG^##Color(_: 1, green: 1, 2)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '[#Color(...)#]' has been renamed to '#colorLiteral(...)', Fix-It replacements: 9 - 10 = '', 11 - 16 = 'colorLiteral', 17 - 18 = 'red'
        DiagnosticSpec(message: "expected ']' to end array"),
        DiagnosticSpec(message: "extraneous '#Color(_: 1, green: 1, 2)' at top level"),
      ]
    )
  }

  func testObjectLiterals6() {
    AssertParse(
      """
      let _ = [#^DIAG^##Color(red: 1, green: 1, blue: 1)#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '[#Color(...)#]' has been renamed to '#colorLiteral(...)', Fix-It replacements: 9 - 10 = '', 11 - 16 = 'colorLiteral', 17 - 20 = 'red', 43 - 44 = ''
        DiagnosticSpec(message: "expected ']' to end array"),
        DiagnosticSpec(message: "extraneous '#Color(red: 1, green: 1, blue: 1)#' at top level"),
      ]
    )
  }

  func testObjectLiterals7() {
    AssertParse(
      """
      let _ = [#^DIAG^##Color(withRed: 1, green: 1, whatever: 2)#]
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '[#Color(...)#]' has been renamed to '#colorLiteral(...)', Fix-It replacements: 9 - 10 = '', 11 - 16 = 'colorLiteral', 17 - 24 = 'red', 51 - 53 = ''
        DiagnosticSpec(message: "unexpected text '#Color(withRed: 1, green: 1, whatever: 2)#' in array"),
      ]
    )
  }

  func testObjectLiterals8() {
    AssertParse(
      """
      let _ = #^DIAG^##Color(_: 1, green: 1)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '#Color(...)' has been renamed to '#colorLiteral(...)', Fix-It replacements: 10 - 15 = 'colorLiteral', 16 - 17 = 'red'
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: "extraneous '#Color(_: 1, green: 1)' at top level"),
      ]
    )
  }
}
