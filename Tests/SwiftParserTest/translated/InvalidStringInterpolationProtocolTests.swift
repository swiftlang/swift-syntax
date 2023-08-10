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

// This test file has been translated from swift/test/Parse/invalid_string_interpolation_protocol.swift

import XCTest

final class InvalidStringInterpolationProtocolTests: ParserTestCase {
  func testInvalidStringInterpolationProtocol1() {
    assertParse(
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
      """
    )
  }

  func testInvalidStringInterpolationProtocol2() {
    assertParse(
      """
      // Has no 'appendInterpolation' methods at all
      public struct IncompleteStringInterpolation: StringInterpolationProtocol {
        public init(literalCapacity: Int, interpolationCount: Int) {}
        public mutating func appendLiteral(_: String) {}
      }
      """
    )
  }

  func testInvalidStringInterpolationProtocol3() {
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
