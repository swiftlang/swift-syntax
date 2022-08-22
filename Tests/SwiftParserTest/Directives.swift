@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import XCTest

final class DirectiveTests: XCTestCase {
  func testSwitchIfConfig() throws {
    try AssertParse({ $0.parseStatement() }) {
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
    }
  }

  func testPostfixIfConfigExpression() throws {
    try AssertParse({ $0.parseExpression() }) {
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
    }
  }

  func testSourceLocation() throws {
    try AssertParse({ $0.parsePoundSourceLocationDirective() }) {
       """
       #sourceLocation()
       """
    }

    try AssertParse({ $0.parsePoundSourceLocationDirective() }) {
       """
       #sourceLocation(file: "foo", line: 42)
       """
    }
  }
}
