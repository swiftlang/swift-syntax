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

    AssertParse(
      """
      public class C<R> {

      #sourceLocation(file: "f.swift", line: 1)
        public func f<S>(_ s: S) {

      #sourceLocation(file: "f.swift", line: 2)
          g(s)
        }
      }
      """)
  }

  public func testUnterminatedPoundIf() {
    AssertParse(
      "#if test#^DIAG^#",
      diagnostics: [
        DiagnosticSpec(message: "expected '#endif' in conditional compilation block")
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
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text '}' before conditional compilation clause"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text '}' in conditional compilation block"),
      ]
    )
  }

  func testHasAttribute() {
    AssertParse(
      """
      @frozen
      #if hasAttribute(foo)
      @foo
      #endif
      public struct S2 { }
      """)

    AssertParse(
      """
      struct Inner {
        @frozen
      #if hasAttribute(foo)
        #if hasAttribute(bar)
        @foo @bar
        #endif
      #endif
        public struct S2 { }

      #if hasAttribute(foo)
        @foo#^DIAG_1^#
      #endif
        @inlinable
        func f1() { }

      #if hasAttribute(foo)
        @foo#^DIAG_2^#
      #else
        @available(*, deprecated, message: "nope")
        @frozen#^DIAG_3^#
      #endif
        public struct S3 { }
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected declaration after attribute in conditional compilation clause"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected declaration after attribute in conditional compilation clause"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected declaration after attribute in conditional compilation clause"),
      ]
    )
  }

}
