// This test file has been translated from swift/test/Parse/object_literals.swift

import XCTest

final class ObjectLiteralsTests: XCTestCase {
  func testObjectLiterals1() {
    AssertParse(
      """
      let _ = [1️⃣#Color(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)#] 
      let _ = [2️⃣#Image(imageLiteral: localResourceNameAsString)#] 
      let _ = [3️⃣#FileReference(fileReferenceLiteral: localResourceNameAsString)#]
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '[#Color(...)#]' has been renamed to '#colorLiteral(...), Fix-It replacements: 9 - 10 = '', 11 - 16 = 'colorLiteral', 17 - 32 = 'red', 78 - 80 = ''
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '#Color(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)#' in array"),
        // TODO: Old parser expected error on line 2: '[#Image(...)#]' has been renamed to '#imageLiteral(...)', Fix-It replacements: 9 - 10 = '', 11 - 16 = 'imageLiteral', 17 - 29 = 'resourceName', 57 - 59 = ''
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '#Image(imageLiteral: localResourceNameAsString)#' in array"),
        // TODO: Old parser expected error on line 3: '[#FileReference(...)#]' has been renamed to '#fileLiteral(...)', Fix-It replacements: 9 - 10 = '', 11 - 24 = 'fileLiteral', 25 - 45 = 'resourceName', 73 - 75 = ''
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected code '#FileReference(fileReferenceLiteral: localResourceNameAsString)#' in array"),
      ]
    )
  }

  func testObjectLiterals2a() {
    AssertParse(
      """
      let _ = 1️⃣#Color(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '#Color(...)' has been renamed to '#colorLiteral(...), Fix-It replacements: 10 - 15 = 'colorLiteral', 16 - 31 = 'red'
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: "extraneous code '#Color(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)' at top level"),
      ]
    )
  }

  func testObjectLiterals2b() {
    AssertParse(
      """
      let _ = 1️⃣#Image(imageLiteral: localResourceNameAsString)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '#Image(...)' has been renamed to '#imageLiteral(...)', Fix-It replacements: 10 - 15 = 'imageLiteral', 16 - 28 = 'resourceName'
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: "extraneous code '#Image(imageLiteral: localResourceNameAsString)' at top level"),
      ]
    )
  }


  func testObjectLiterals2c() {
    AssertParse(
      """
      let _ = 1️⃣#FileReference(fileReferenceLiteral: localResourceNameAsString)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '#FileReference(...)' has been renamed to '#fileLiteral(...)', Fix-It replacements: 10 - 23 = 'fileLiteral', 24 - 44 = 'resourceName'
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: "extraneous code '#FileReference(fileReferenceLiteral: localResourceNameAsString)' at top level"),
      ]
    )
  }


  func testObjectLiterals3a() {
    AssertParse(
      """
      let _ = 1️⃣#notAPound
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: use of unknown directive '#notAPound'
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: "extraneous code '#notAPound' at top level"),
      ]
    )
  }

  func testObjectLiterals3b() {
    AssertParse(
      """
      let _ = 1️⃣#notAPound(1, 2)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: use of unknown directive '#notAPound'
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: "extraneous code '#notAPound(1, 2)' at top level"),
      ]
    )
  }

  func testObjectLiterals3c() {
    AssertParse(
      """
      let _ = 1️⃣#Color //  {{none}}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected argument list in object literal
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: "extraneous code '#Color' at top level"),
      ]
    )
  }

  func testObjectLiterals4() {
    AssertParse(
      """
      let _ = [1️⃣##] //  {{none}}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected expression in container literal
        DiagnosticSpec(message: "unexpected code '##' in array"),
      ]
    )
  }

  func testObjectLiterals5() {
    AssertParse(
      """
      let _ = [1️⃣#Color(_: 1, green: 1, 2)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '[#Color(...)#]' has been renamed to '#colorLiteral(...)', Fix-It replacements: 9 - 10 = '', 11 - 16 = 'colorLiteral', 17 - 18 = 'red'
        DiagnosticSpec(message: "expected ']' to end array"),
        DiagnosticSpec(message: "extraneous code '#Color(_: 1, green: 1, 2)' at top level"),
      ]
    )
  }

  func testObjectLiterals6() {
    AssertParse(
      """
      let _ = [1️⃣#Color(red: 1, green: 1, blue: 1)#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '[#Color(...)#]' has been renamed to '#colorLiteral(...)', Fix-It replacements: 9 - 10 = '', 11 - 16 = 'colorLiteral', 17 - 20 = 'red', 43 - 44 = ''
        DiagnosticSpec(message: "expected ']' to end array"),
        DiagnosticSpec(message: "extraneous code '#Color(red: 1, green: 1, blue: 1)#' at top level"),
      ]
    )
  }

  func testObjectLiterals7() {
    AssertParse(
      """
      let _ = [1️⃣#Color(withRed: 1, green: 1, whatever: 2)#]
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '[#Color(...)#]' has been renamed to '#colorLiteral(...)', Fix-It replacements: 9 - 10 = '', 11 - 16 = 'colorLiteral', 17 - 24 = 'red', 51 - 53 = ''
        DiagnosticSpec(message: "unexpected code '#Color(withRed: 1, green: 1, whatever: 2)#' in array"),
      ]
    )
  }

  func testObjectLiterals8() {
    AssertParse(
      """
      let _ = 1️⃣#Color(_: 1, green: 1)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '#Color(...)' has been renamed to '#colorLiteral(...)', Fix-It replacements: 10 - 15 = 'colorLiteral', 16 - 17 = 'red'
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: "extraneous code '#Color(_: 1, green: 1)' at top level"),
      ]
    )
  }
}
