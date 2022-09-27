// This test file has been translated from swift/test/Parse/invalid_string_interpolation_protocol.swift

import XCTest

final class InvalidStringInterpolationProtocolTests: XCTestCase {
  func testInvalidStringInterpolationProtocol1() {
    AssertParse(
      """
      // Has a lot of invalid 'appendInterpolation' methods
      public struct BadStringInterpolation: StringInterpolationProtocol {
        //  {{educational-notes=string-interpolation-conformance}}
        public init(literalCapacity: Int, interpolationCount: Int) {}
        public mutating func appendLiteral(_: String) {}
        public static func appendInterpolation(static: ()) {
          //  {{educational-notes=string-interpolation-conformance}}
        }
        private func appendInterpolation(private: ()) {
        }
        func appendInterpolation(default: ()) {
        }
        public func appendInterpolation(intResult: ()) -> Int {
          //  {{educational-notes=string-interpolation-conformance}}
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: type conforming to 'StringInterpolationProtocol' does not implement a valid 'appendInterpolation' method
        // TODO: Old parser expected warning on line 6: 'appendInterpolation' method will never be used because it is static, Fix-It replacements: 10 - 17 = ''
        // TODO: Old parser expected warning on line 9: 'appendInterpolation' method is private, but 'BadStringInterpolation' is public
        // TODO: Old parser expected warning on line 11: 'appendInterpolation' method is internal, but 'BadStringInterpolation' is public
        // TODO: Old parser expected warning on line 13: 'appendInterpolation' method does not return 'Void' or have a discardable result, Fix-It replacements: 10 - 10 = '@discardableResult '
      ]
    )
  }

  func testInvalidStringInterpolationProtocol2() {
    AssertParse(
      """
      // Has no 'appendInterpolation' methods at all
      public struct IncompleteStringInterpolation: StringInterpolationProtocol {
        public init(literalCapacity: Int, interpolationCount: Int) {}
        public mutating func appendLiteral(_: String) {}
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: type conforming to 'StringInterpolationProtocol' does not implement a valid 'appendInterpolation' method
      ]
    )
  }

  func testInvalidStringInterpolationProtocol3() {
    AssertParse(
      """
      // Has only good 'appendInterpolation' methods.
      public struct GoodStringInterpolation: StringInterpolationProtocol {
        public init(literalCapacity: Int, interpolationCount: Int) {}
        public mutating func appendLiteral(_: String) {}
        public func appendInterpolation(noResult: ()) {}
        public func appendInterpolation(voidResult: ()) -> Void {}
        @discardableResult
        public func appendInterpolation(discardableResult: ()) -> Int {}
      }
      """
    )
  }

  func testInvalidStringInterpolationProtocol4() {
    AssertParse(
      """
      // Has only good 'appendInterpolation' methods, but they're in an extension.
      public struct GoodSplitStringInterpolation: StringInterpolationProtocol {
        public init(literalCapacity: Int, interpolationCount: Int) {}
        public mutating func appendLiteral(_: String) {}
      }
      """
    )
  }

  func testInvalidStringInterpolationProtocol5() {
    AssertParse(
      """
      extension GoodSplitStringInterpolation {
        public func appendInterpolation(noResult: ()) {}
        public func appendInterpolation(voidResult: ()) -> Void {}
        @discardableResult
        public func appendInterpolation(discardableResult: ()) -> Int {}
      }
      """
    )
  }

  func testInvalidStringInterpolationProtocol6() {
    AssertParse(
      """
      // Has only good 'appendInterpolation' methods, and is not public.
      struct GoodNonPublicStringInterpolation: StringInterpolationProtocol {
        init(literalCapacity: Int, interpolationCount: Int) {}
        mutating func appendLiteral(_: String) {}
        func appendInterpolation(noResult: ()) {}
        public func appendInterpolation(voidResult: ()) -> Void {}
        @discardableResult
        func appendInterpolation(discardableResult: ()) -> Int {}
      }
      """
    )
  }

  func testInvalidStringInterpolationProtocol7() {
    AssertParse(
      """
      // Has a mixture of good and bad 'appendInterpolation' methods.
      // We don't emit any errors in this case--we assume the others
      // are implementation details or something.
      public struct GoodStringInterpolationWithBadOnesToo: StringInterpolationProtocol {
        public init(literalCapacity: Int, interpolationCount: Int) {}
        public mutating func appendLiteral(_: String) {}
        public func appendInterpolation(noResult: ()) {}
        public static func appendInterpolation(static: ()) {}
        private func appendInterpolation(private: ()) {}
        func appendInterpolation(default: ()) {}
        public func appendInterpolation(intResult: ()) -> Int {}
      }
      """
    )
  }

}
