// This test file has been translated from swift/test/Parse/enum_element_pattern_swift4.swift

import XCTest

final class EnumElementPatternSwift4Tests: XCTestCase {
  func testEnumElementPatternSwift41() {
    AssertParse(
      """
      // https://github.com/apple/swift/issues/46040
      // See test/Compatibility/enum_element_pattern.swift for Swift3 behavior.
      // As for FIXME cases: see https://github.com/apple/swift/issues/46054
      """
    )
  }

  func testEnumElementPatternSwift42() {
    AssertParse(
      """
      enum E {
        case A, B, C, D
        static func testE(e: E) {
          switch e {
          case A<UndefinedTy>(): 
            break
          case B<Int>(): 
            break
          default:
            break;
          }
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 5: cannot specialize a non-generic definition
        // TODO: Old parser expected note on line 5: while parsing this '<' as a type parameter bracket
        // TODO: Old parser expected error on line 7: cannot specialize a non-generic definition
        // TODO: Old parser expected note on line 7: while parsing this '<' as a type parameter bracket
      ]
    )
  }

  func testEnumElementPatternSwift43() {
    AssertParse(
      """
      func testE(e: E) {
        switch e {
        case E.A<UndefinedTy>(): 
          break
        case E.B<Int>(): 
          break
        case .C(): 
          break
        case .D(let payload): 
          let _: () = payload
          break
        default:
          break
        }
        guard
          case .C() = e, 
          case .D(let payload) = e 
        else { return }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: cannot specialize a non-generic definition
        // TODO: Old parser expected note on line 3: while parsing this '<' as a type parameter bracket
        // TODO: Old parser expected error on line 5: cannot specialize a non-generic definition
        // TODO: Old parser expected note on line 5: while parsing this '<' as a type parameter bracket
      ]
    )
  }

  func testEnumElementPatternSwift44() {
    AssertParse(
      """
      extension E : Error {}
      func canThrow() throws {
        throw E.A
      }
      """
    )
  }

  func testEnumElementPatternSwift45() {
    AssertParse(
      """
      do {
        try canThrow()
      } catch E.A() { 
        // ..
      } catch E.B(let payload) { 
        let _: () = payload
      }
      """
    )
  }

}
