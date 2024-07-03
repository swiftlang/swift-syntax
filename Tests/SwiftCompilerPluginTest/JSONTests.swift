//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(PluginMessage) import SwiftCompilerPluginMessageHandling
import XCTest

final class JSONTests: XCTestCase {

  func testPrimitive() {
    assertRoundTrip(of: true, expectedJSON: "true")
    assertRoundTrip(of: false, expectedJSON: "false")
    assertRoundTrip(of: Bool?.none, expectedJSON: "null")
    assertRoundTrip(of: "", expectedJSON: "\"\"")
    assertRoundTrip(of: 0, expectedJSON: "0")
    assertRoundTrip(of: 0 as Int8, expectedJSON: "0")
    assertRoundTrip(of: 0.0 as Float, expectedJSON: "0.0")
    assertRoundTrip(of: 0.0 as Double, expectedJSON: "0.0")
  }

  func testEmptyStruct() {
    let value = EmptyStruct()
    assertRoundTrip(of: value, expectedJSON: "{}")
  }

  func testEmptyClass() {
    let value = EmptyClass()
    assertRoundTrip(of: value, expectedJSON: "{}")
  }

  func testTrivialEnumDefault() {
    assertRoundTrip(of: Direction.left, expectedJSON: #"{"left":{}}"#)
    assertRoundTrip(of: Direction.right, expectedJSON: #"{"right":{}}"#)
  }

  func testTrivialEnumRawValue() {
    assertRoundTrip(of: Animal.dog, expectedJSON: #""dog""#)
    assertRoundTrip(of: Animal.cat, expectedJSON: #""cat""#)
  }

  func testTrivialEnumCustom() {
    assertRoundTrip(of: Switch.off, expectedJSON: "false")
    assertRoundTrip(of: Switch.on, expectedJSON: "true")
  }

  func testEnumWithAssociated() {
    let tree: Tree = .dictionary([
      "name": .string("John Doe"),
      "data": .array([.int(12), .string("foo")]),
    ])
    assertRoundTrip(
      of: tree,
      expectedJSON: #"""
        {"dictionary":{"_0":{"data":{"array":{"_0":[{"int":{"_0":12}},{"string":{"_0":"foo"}}]}},"name":{"string":{"_0":"John Doe"}}}}}
        """#
    )
  }

  func testArrayOfInt() {
    let arr: [Int] = [12, 42]
    assertRoundTrip(of: arr, expectedJSON: "[12,42]")
    let empty: [Int] = []
    assertRoundTrip(of: empty, expectedJSON: "[]")
  }

  func testComplexStruct() {
    let empty = ComplexStruct(result: nil, diagnostics: [], elapsed: 0.0)
    assertRoundTrip(of: empty, expectedJSON: #"{"diagnostics":[],"elapsed":0.0}"#)

    let value = ComplexStruct(
      result: "\tresult\nfoo",
      diagnostics: [
        .init(
          message: "error 🛑",
          animal: .cat,
          data: [nil, 42]
        )
      ],
      elapsed: 42.3e32
    )
    assertRoundTrip(
      of: value,
      expectedJSON: #"""
        {"diagnostics":[{"animal":"cat","data":[null,42],"message":"error 🛑"}],"elapsed":4.23e+33,"result":"\tresult\nfoo"}
        """#
    )
  }

  func testEscapedString() {
    assertRoundTrip(
      of: "\n\"\\\u{A9}\u{0}\u{07}\u{1B}",
      expectedJSON: #"""
        "\n\"\\©\u0000\u0007\u001B"
        """#
    )
  }

  func testParseError() {
    assertParseError(
      #"{"foo": 1"#,
      message: "unexpected end of file"
    )
    assertParseError(
      #""foo"#,
      message: "unexpected end of file"
    )
    assertParseError(
      "\n",
      message: "unexpected end of file"
    )
    assertParseError(
      "trua",
      message: "unexpected character 'a'; expected 'e'"
    )
    assertParseError(
      "[true, #foo]",
      message: "unexpected character '#'; value start"
    )
    assertParseError(
      "{}true",
      message: "unexpected character 't'; after top-level value"
    )
  }

  func testInvalidStringDecoding() {
    assertInvalidStrng(#""foo\"#)  // EOF after '\'
    assertInvalidStrng(#""\x""#)  // Unknown character after '\'
    assertInvalidStrng(#""\u1""#)  // Missing 4 digits after '\u'
    assertInvalidStrng(#""\u12""#)
    assertInvalidStrng(#""\u123""#)
    assertInvalidStrng(#""\uEFGH""#)  // Invalid HEX characters.
  }

  func testStringSurrogatePairDecoding() {
    // FIXME: Escaped surrogate pairs are not supported.
    // Currently parsed as "invalid", but this should be valid '𐐷' (U+10437) character
    assertInvalidStrng(#"\uD801\uDC37"#)
  }

  func testTypeCoercion() {
    assertRoundTripTypeCoercionFailure(of: [false, true], as: [Int].self)
    assertRoundTripTypeCoercionFailure(of: [false, true], as: [Int8].self)
    assertRoundTripTypeCoercionFailure(of: [false, true], as: [Int16].self)
    assertRoundTripTypeCoercionFailure(of: [false, true], as: [Int32].self)
    assertRoundTripTypeCoercionFailure(of: [false, true], as: [Int64].self)
    assertRoundTripTypeCoercionFailure(of: [false, true], as: [UInt].self)
    assertRoundTripTypeCoercionFailure(of: [false, true], as: [UInt8].self)
    assertRoundTripTypeCoercionFailure(of: [false, true], as: [UInt16].self)
    assertRoundTripTypeCoercionFailure(of: [false, true], as: [UInt32].self)
    assertRoundTripTypeCoercionFailure(of: [false, true], as: [UInt64].self)
    assertRoundTripTypeCoercionFailure(of: [false, true], as: [Float].self)
    assertRoundTripTypeCoercionFailure(of: [false, true], as: [Double].self)
    assertRoundTripTypeCoercionFailure(of: [0, 1] as [Int], as: [Bool].self)
    assertRoundTripTypeCoercionFailure(of: [0, 1] as [Int8], as: [Bool].self)
    assertRoundTripTypeCoercionFailure(of: [0, 1] as [Int16], as: [Bool].self)
    assertRoundTripTypeCoercionFailure(of: [0, 1] as [Int32], as: [Bool].self)
    assertRoundTripTypeCoercionFailure(of: [0, 1] as [Int64], as: [Bool].self)
    assertRoundTripTypeCoercionFailure(of: [0, 1] as [UInt], as: [Bool].self)
    assertRoundTripTypeCoercionFailure(of: [0, 1] as [UInt8], as: [Bool].self)
    assertRoundTripTypeCoercionFailure(of: [0, 1] as [UInt16], as: [Bool].self)
    assertRoundTripTypeCoercionFailure(of: [0, 1] as [UInt32], as: [Bool].self)
    assertRoundTripTypeCoercionFailure(of: [0, 1] as [UInt64], as: [Bool].self)
    assertRoundTripTypeCoercionFailure(of: [0.0, 1.0] as [Float], as: [Bool].self)
    assertRoundTripTypeCoercionFailure(of: [0.0, 1.0] as [Double], as: [Bool].self)
  }

  func testFloatingPointBufferBoundary() throws {
    // Make sure floating point parsing does not read past the decoding JSON buffer.
    var str = "0.199"
    try str.withUTF8 { buf in
      let truncated = UnsafeBufferPointer(rebasing: buf[0..<3])
      XCTAssertEqual(try JSON.decode(Double.self, from: truncated), 0.1)
      XCTAssertEqual(try JSON.decode(Float.self, from: truncated), 0.1)
    }
  }

  private func assertRoundTrip<T: Codable & Equatable>(
    of value: T,
    expectedJSON: String,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    let payload: [UInt8]
    do {
      payload = try JSON.encode(value)
    } catch let error {
      XCTFail("Failed to encode \(T.self) to JSON: \(error)", file: file, line: line)
      return
    }

    let jsonStr = String(decoding: payload, as: UTF8.self)
    XCTAssertEqual(jsonStr, expectedJSON, file: file, line: line)

    let decoded: T
    do {
      decoded = try payload.withUnsafeBufferPointer {
        try JSON.decode(T.self, from: $0)
      }
    } catch let error {
      XCTFail("Failed to decode \(T.self) from JSON: \(error)", file: file, line: line)
      return
    }
    XCTAssertEqual(value, decoded, file: file, line: line)
  }

  private func assertRoundTripTypeCoercionFailure<T: Codable, U: Codable>(
    of value: T,
    as type: U.Type,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    do {
      let data = try JSONEncoder().encode(value)
      let _ = try JSONDecoder().decode(U.self, from: data)
      XCTFail("Coercion from \(T.self) to \(U.self) was expected to fail.", file: file, line: line)
    } catch DecodingError.typeMismatch(_, _) {
      // Success
    } catch {
      XCTFail("unexpected error", file: file, line: line)
    }
  }

  private func assertInvalidStrng(_ json: String, file: StaticString = #filePath, line: UInt = #line) {
    do {
      var json = json
      _ = try json.withUTF8 { try JSON.decode(String.self, from: $0) }
      XCTFail("decoding should fail", file: file, line: line)
    } catch {}
  }

  private func assertParseError(_ json: String, message: String, file: StaticString = #filePath, line: UInt = #line) {
    do {
      var json = json
      _ = try json.withUTF8 { try JSON.decode(Bool.self, from: $0) }
      XCTFail("decoding should fail", file: file, line: line)
    } catch DecodingError.dataCorrupted(let context) {
      XCTAssertEqual(
        String(describing: try XCTUnwrap(context.underlyingError, file: file, line: line)),
        message
      )
    } catch {
      XCTFail("unexpected error", file: file, line: line)
    }
  }
}

// MARK: - Test Types

fileprivate struct EmptyStruct: Codable, Equatable {
  static func == (_ lhs: EmptyStruct, _ rhs: EmptyStruct) -> Bool {
    return true
  }
}

fileprivate class EmptyClass: Codable, Equatable {
  static func == (_ lhs: EmptyClass, _ rhs: EmptyClass) -> Bool {
    return true
  }
}

fileprivate enum Direction: Codable {
  case right
  case left
}

fileprivate enum Animal: String, Codable {
  case dog
  case cat
}

fileprivate enum Switch: Codable {
  case off
  case on

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    switch try container.decode(Bool.self) {
    case false: self = .off
    case true: self = .on
    }
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case .off: try container.encode(false)
    case .on: try container.encode(true)
    }
  }
}

fileprivate enum Tree: Codable, Equatable {
  indirect case int(Int)
  indirect case string(String)
  indirect case array([Self])
  indirect case dictionary([String: Self])
}

fileprivate struct ComplexStruct: Codable, Equatable {
  struct Diagnostic: Codable, Equatable {
    var message: String
    var animal: Animal
    var data: [Int?]
  }

  var result: String?
  var diagnostics: [Diagnostic]
  var elapsed: Double
}
