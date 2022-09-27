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

  func testObjectLiterals2() {
    AssertParse(
      """
      let _ = #^DIAG_1^##Color(colorLiteralRed: red, green: green, blue: blue, alpha: alpha) 
      let _ = #^DIAG_2^##Image(imageLiteral: localResourceNameAsString) 
      let _ = #^DIAG_3^##FileReference(fileReferenceLiteral: localResourceNameAsString)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '#Color(...)' has been renamed to '#colorLiteral(...), Fix-It replacements: 10 - 15 = 'colorLiteral', 16 - 31 = 'red'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected expression in variable"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text '#Color(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)' before variable"),
        // TODO: Old parser expected error on line 2: '#Image(...)' has been renamed to '#imageLiteral(...)', Fix-It replacements: 10 - 15 = 'imageLiteral', 16 - 28 = 'resourceName'
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected expression in variable"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text '#Image(imageLiteral: localResourceNameAsString)' before variable"),
        // TODO: Old parser expected error on line 3: '#FileReference(...)' has been renamed to '#fileLiteral(...)', Fix-It replacements: 10 - 23 = 'fileLiteral', 24 - 44 = 'resourceName'
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected expression in variable"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "extraneous '#FileReference(fileReferenceLiteral: localResourceNameAsString)' at top level"),
      ]
    )
  }

  func testObjectLiterals3() {
    AssertParse(
      """
      let _ = #^DIAG_1^##notAPound 
      let _ = #^DIAG_2^##notAPound(1, 2) 
      let _ = #^DIAG_3^##Color //  {{none}}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: use of unknown directive '#notAPound'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected expression in variable"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text '#notAPound' before variable"),
        // TODO: Old parser expected error on line 2: use of unknown directive '#notAPound'
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected expression in variable"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text '#notAPound(1, 2)' before variable"),
        // TODO: Old parser expected error on line 3: expected argument list in object literal
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected expression in variable"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "extraneous '#Color' at top level"),
      ]
    )
  }

  func testObjectLiterals4() {
    AssertParse(
      """
      let _ = [#^DIAG_1^###] //  {{none}}
      let _ = [#^DIAG_2^##Color(_: 1, green: 1, 2) 
      let _ = [#^DIAG_3^##Color(red: 1, green: 1, blue: 1)# 
      let _ = [#^DIAG_4^##Color(withRed: 1, green: 1, whatever: 2)#] 
      let _ = #^DIAG_5^##Color(_: 1, green: 1)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected expression in container literal
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text '##' in array"),
        // TODO: Old parser expected error on line 2: '[#Color(...)#]' has been renamed to '#colorLiteral(...)', Fix-It replacements: 9 - 10 = '', 11 - 16 = 'colorLiteral', 17 - 18 = 'red'
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected ']' to end array"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text '#Color(_: 1, green: 1, 2)' before variable"),
        // TODO: Old parser expected error on line 3: '[#Color(...)#]' has been renamed to '#colorLiteral(...)', Fix-It replacements: 9 - 10 = '', 11 - 16 = 'colorLiteral', 17 - 20 = 'red', 43 - 44 = ''
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected ']' to end array"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "unexpected text '#Color(red: 1, green: 1, blue: 1)#' before variable"),
        // TODO: Old parser expected error on line 4: '[#Color(...)#]' has been renamed to '#colorLiteral(...)', Fix-It replacements: 9 - 10 = '', 11 - 16 = 'colorLiteral', 17 - 24 = 'red', 51 - 53 = ''
        DiagnosticSpec(locationMarker: "DIAG_4", message: "unexpected text '#Color(withRed: 1, green: 1, whatever: 2)#' in array"),
        // TODO: Old parser expected error on line 5: '#Color(...)' has been renamed to '#colorLiteral(...)', Fix-It replacements: 10 - 15 = 'colorLiteral', 16 - 17 = 'red'
        DiagnosticSpec(locationMarker: "DIAG_5", message: "expected expression in variable"),
        DiagnosticSpec(locationMarker: "DIAG_5", message: "extraneous '#Color(_: 1, green: 1)' at top level"),
      ]
    )
  }

}
