//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// This test file has been translated from swift/test/Parse/enum_element_pattern_swift4.swift

import XCTest

final class EnumElementPatternSwift4Tests: ParserTestCase {
  func testEnumElementPatternSwift42() {
    assertParse(
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
      """
    )
  }

  func testEnumElementPatternSwift43() {
    assertParse(
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
      """
    )
  }

  func testEnumElementPatternSwift44() {
    assertParse(
      """
      extension E : Error {}
      func canThrow() throws {
        throw E.A
      }
      """
    )
  }

  func testEnumElementPatternSwift45() {
    assertParse(
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
