@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import XCTest

final class StatementTests: XCTestCase {
  func testIf() throws {
    try AssertParse({ $0.parseIfStatement() }) {
      """
      if let x { }
      """
    }

    try AssertParse({ $0.parseIfStatement() }) {
      """
      if case* ! = x {
        bar()
      }
      """
    }
  }

  func testNestedIfs() throws {
    try AssertParse({ $0.parseDeclaration() }) {
      let nest = 22
      var example = "func nestThoseIfs() {\n"
      for index in (0...nest) {
          let indent = String(repeating: "    ", count: index + 1)
          example += indent + "if false != true {\n"
          example += indent + "   print \"\\(i)\"\n"
      }

      for index in (0...nest).reversed() {
          let indent = String(repeating: "    ", count: index + 1)
          example += indent + "}\n"
      }
      example += "}"
      return example
    }
  }

  func testDo() throws {
    try AssertParse({ $0.parseDoStatement() }) {
       """
       do {

       }
       """
    }
  }

  func testDoCatch() throws {
    try AssertParse({ $0.parseDoStatement() }) {
       """
       do {

       } catch {

       }
       """
    }
  }

  func testReturn() throws {
    try AssertParse({ $0.parseReturnStatement() }) {
      "return"
    }

    try AssertParse({ $0.parseReturnStatement() }) {
       #"""
       return "assert(\(assertChoices.joined(separator: " || ")))"
       """#
    }

    try AssertParse({ $0.parseReturnStatement() }) {
      "return true ? nil : nil"
    }
  }

  func testSwitch() throws {
    try AssertParse({ $0.parseStatement() }) {
      """
      switch x {
      case .A, .B:
        break
      }
      """
    }

    try AssertParse({ $0.parseStatement() }) {
      """
      switch 0 {
      @$dollar case _:
        break
      }
      """
    }

    try AssertParse({ $0.parseStatement() }) {
      """
      switch x {
      case .A:
        break
      case .B:
        break
      #if NEVER
      #elseif ENABLE_C
      case .C:
        break
      #endif
      }
      """
    }
  }
}
