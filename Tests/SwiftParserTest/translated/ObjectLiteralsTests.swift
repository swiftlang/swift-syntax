// This test file has been translated from swift/test/Parse/object_literals.swift

import XCTest

final class ObjectLiteralsTests: XCTestCase {
  func testObjectLiterals1a() {
    AssertParse(
      """
      let _ = [1️⃣#Color(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)2️⃣#]
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "use of unknown directive '#Color(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "use of unknown directive '#'"),
      ]
    )
  }

  func testObjectLiterals1b() {
    AssertParse(
      """
      let _ = [1️⃣#Image(imageLiteral: localResourceNameAsString)2️⃣#]
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "use of unknown directive '#Image(imageLiteral: localResourceNameAsString)'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "use of unknown directive '#'"),
      ]
    )
  }

  func testObjectLiterals1c() {
    AssertParse(
      """
      let _ = [1️⃣#FileReference(fileReferenceLiteral: localResourceNameAsString)2️⃣#]
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "use of unknown directive '#FileReference(fileReferenceLiteral: localResourceNameAsString)'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "use of unknown directive '#'"),
      ]
    )
  }


  func testObjectLiterals2a() {
    AssertParse(
      """
      let _ = 1️⃣#Color(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)
      """,
      diagnostics: [
        DiagnosticSpec(message: "use of unknown directive '#Color(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)'"),
      ]
    )
  }

  func testObjectLiterals2b() {
    AssertParse(
      """
      let _ = 1️⃣#Image(imageLiteral: localResourceNameAsString)
      """,
      diagnostics: [
        DiagnosticSpec(message: "use of unknown directive '#Image(imageLiteral: localResourceNameAsString)'"),
      ]
    )
  }


  func testObjectLiterals2c() {
    AssertParse(
      """
      let _ = 1️⃣#FileReference(fileReferenceLiteral: localResourceNameAsString)
      """,
      diagnostics: [
        DiagnosticSpec(message: "use of unknown directive '#FileReference(fileReferenceLiteral: localResourceNameAsString)'"),
      ]
    )
  }


  func testObjectLiterals3a() {
    AssertParse(
      """
      let _ = 1️⃣#notAPound
      """,
      diagnostics: [
        DiagnosticSpec(message: "use of unknown directive '#notAPound'"),
      ]
    )
  }

  func testObjectLiterals3b() {
    AssertParse(
      """
      let _ = 1️⃣#notAPound(1, 2)
      """,
      diagnostics: [
        DiagnosticSpec(message: "use of unknown directive '#notAPound(1, 2)'"),
      ]
    )
  }

  func testObjectLiterals3c() {
    AssertParse(
      """
      let _ = 1️⃣#Color
      """,
      diagnostics: [
        DiagnosticSpec(message: "use of unknown directive '#Color'"),
      ]
    )
  }

  func testObjectLiterals4() {
    AssertParse(
      """
      let _ = [1️⃣#2️⃣#]
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "use of unknown directive '#'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "use of unknown directive '#'"),
      ]
    )
  }

  func testObjectLiterals5() {
    AssertParse(
      """
      let _ = [1️⃣#Color(_: 1, green: 1, 2)2️⃣
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "use of unknown directive '#Color(_: 1, green: 1, 2)'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ']' to end array"),
      ]
    )
  }

  func testObjectLiterals6() {
    AssertParse(
      """
      let _ = [1️⃣#Color(red: 1, green: 1, blue: 1)2️⃣#3️⃣
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "use of unknown directive '#Color(red: 1, green: 1, blue: 1)'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "use of unknown directive '#'"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected ']' to end array"),
      ]
    )
  }

  func testObjectLiterals7() {
    AssertParse(
      """
      let _ = [1️⃣#Color(withRed: 1, green: 1, whatever: 2)2️⃣#]
      """,
      diagnostics: [
        DiagnosticSpec(message: "use of unknown directive '#Color(withRed: 1, green: 1, whatever: 2)'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "use of unknown directive '#'")
      ]
    )
  }

  func testObjectLiterals8() {
    AssertParse(
      """
      let _ = 1️⃣#Color(_: 1, green: 1)
      """,
      diagnostics: [
        DiagnosticSpec(message: "use of unknown directive '#Color(_: 1, green: 1)'"),
      ]
    )
  }
}
