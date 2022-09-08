@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import XCTest

final class DirectiveTests: XCTestCase {
  func testSwitchIfConfig() {
    AssertParse(
      """
      switch x {
      case 1: fallthrough
      #if FOO
      case 2: fallthrough
      case 3: print(3)
      case 4: print(4)
      #endif
      case 5: fallthrough
      case 6: print(6)
      #if BAR
      #if BAZ
      case 7: print(7)
      case 8: fallthrough
      #endif
      case 9: fallthrough
      #endif
      case 10: print(10)
      }
      """
    )
  }

  func testPostfixIfConfigExpression() {
    AssertParse(
       """
       foo
         .bar()
         .baz()
         #if CONFIG1
         .quux
         .garp
         #if CONFIG2
         .quux
         #if CONFIG3
           #if INNER1
            .quux
            .garp
           #endif
         #elseif CONFIG3
         .quux
         .garp
         #else
         .gorp
         #endif
         .garp
         #endif
         #endif
       """
    )
  }

  func testSourceLocation() {
    AssertParse(
       """
       #sourceLocation()
       """
    )

    AssertParse(
       """
       #sourceLocation(file: "foo", line: 42)
       """
    )
  }

  public func testUnterminatedPoundIf() {
    AssertParse(
      "#if test#^DIAG^#",
      diagnostics: [
        DiagnosticSpec(message: "Expected '#endif' in conditional compilation block")
      ]
    )
  }

  func testExtraSyntaxInDirective() {
    AssertParse(
      """
      #if os(iOS)
        func foo() {}
      #^DIAG_1^#}
      #else
        func baz() {}
      #^DIAG_2^#}
      #endif
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "DIAG_1", message: "Unexpected text '}' found in conditional compilation clause"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "Unexpected text '}' found in conditional compilation block"),
      ]
    )
  }

}
