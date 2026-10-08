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

  func testUnescapedControlCharacters() {
    for codePoint in 0x00...0x1F {
      let control = String(UnicodeScalar(codePoint)!)
      assertParseError(
        "\"\(control)\"",
        message: "unexpected character '\(control)'; unescaped control character in string"
      )
    }
    // Use LF to cover escapes, object keys, and field values.
    for json in ["\"\\n\n\"", "\"\\\n\"", "{\"\n\":true}", "{\"ignored\":\"\n\"}", "{\"ignored\":\"\\\n\"}"] {
      assertParseError(json, message: "unexpected character '\n'; unescaped control character in string")
    }
  }

  func testEscapedControlCharacters() throws {
    for codePoint in 0x00...0x1F {
      let hex = String(codePoint, radix: 16, uppercase: true)
      var json = "\"\\u\(String(repeating: "0", count: 4 - hex.count))\(hex)\""
      let decoded = try json.withUTF8 { try JSON.decode(String.self, from: $0) }
      XCTAssertEqual(decoded, String(UnicodeScalar(codePoint)!))
    }
  }

  func testEscapedUnicodeScalars() throws {
    for codePoint in [0x7F, 0x80, 0x7FF, 0x800, 0xD7FF, 0xE000, 0xFFFF] {
      let hex = String(codePoint, radix: 16, uppercase: true)
      var json = "\"prefix\\u\(String(repeating: "0", count: 4 - hex.count))\(hex)suffix\""
      let decoded = try json.withUTF8 { try JSON.decode(String.self, from: $0) }
      XCTAssertEqual(decoded, "prefix\(UnicodeScalar(codePoint)!)suffix")
    }
  }

  func testInvalidUTF8() {
    let invalidSequences: [[UInt8]] = [
      // Isolated continuation bytes and overlong encodings.
      [0x80], [0xBF], [0xC0, 0xAF], [0xC1, 0xBF],
      // Truncated sequences and invalid continuation bytes.
      [0xC2], [0xC2, 0x7F], [0xDF, 0xC0],
      [0xE0], [0xE0, 0xA0], [0xE1, 0x80, 0x7F], [0xEF, 0xBF],
      [0xF0], [0xF0, 0x90], [0xF0, 0x90, 0x80], [0xF1, 0x80, 0x80, 0x7F],
      // Overlong three- and four-byte encodings.
      [0xE0, 0x9F, 0xBF], [0xF0, 0x8F, 0xBF, 0xBF],
      // UTF-8 encodings of surrogate code points.
      [0xED, 0xA0, 0x80], [0xED, 0xBF, 0xBF],
      // Values above U+10FFFF and invalid leading bytes.
      [0xF4, 0x90, 0x80, 0x80], [0xF5, 0x80, 0x80, 0x80], [0xFF],
    ]
    for sequence in invalidSequences {
      assertParseError([0x22] + sequence + [0x22], message: "invalid UTF-8 sequence in string")
    }

    // Use 0xFF to cover escapes and object keys.
    for json in [
      Array(#""\n"#.utf8) + [0xFF, 0x22],
      [0x22, 0xFF] + Array(#"\t""#.utf8),
      [0x22, 0x5C, 0xFF, 0x22],
      Array("{\"".utf8) + [0xFF] + Array("\":true}".utf8),
    ] {
      assertParseError(json, message: "invalid UTF-8 sequence in string")
    }

    // Invalid UTF-8 must also be rejected in fields the decoded type ignores.
    let json = Array("{\"ignored\":\"\\".utf8) + [0xFF] + Array("\"}".utf8)
    XCTAssertThrowsError(try json.withUnsafeBufferPointer { try JSON.decode(EmptyStruct.self, from: $0) }) { error in
      guard case DecodingError.dataCorrupted = error else {
        XCTFail("expected corrupted JSON, got \(error)")
        return
      }
    }
  }

  func testUTF8Boundaries() throws {
    for codePoint in [0x20, 0x7F, 0x80, 0x7FF, 0x800, 0xD7FF, 0xE000, 0xFFFD, 0xFFFF, 0x10000, 0x10FFFF] {
      let value = String(UnicodeScalar(codePoint)!)
      var json = "\n\t \"\(value)\" \r\n"
      let decoded = try json.withUTF8 { try JSON.decode(String.self, from: $0) }
      XCTAssertEqual(decoded, value)
    }
    assertRoundTrip(of: ["\u{10FFFF}": "\u{10FFFF}"], expectedJSON: "{\"\u{10FFFF}\":\"\u{10FFFF}\"}")
  }

  func testTruncatedUTF8Buffer() {
    let sequences: [[UInt8]] = [[0xC2, 0x80], [0xE0, 0xA0, 0x80], [0xF0, 0x90, 0x80, 0x80]]
    for sequence in sequences {
      let json = [UInt8(0x22)] + sequence + [0x22]
      json.withUnsafeBufferPointer { buffer in
        // The complete scalar exists in storage, but is outside the supplied buffer.
        for end in 2...sequence.count {
          assertParseError(
            UnsafeBufferPointer(rebasing: buffer[..<end]),
            message: "invalid UTF-8 sequence in string"
          )
        }
      }
    }
  }

  func testStringScanWordBoundaries() throws {
    for offset in 0..<8 {
      let prefix = String(repeating: "a", count: 8 + offset)
      for suffix in ["end", "é", "中文", "😀", "\"\\\n"] {
        let value = prefix + suffix
        let json = try JSON.encode(value)
        let decoded = try json.withUnsafeBufferPointer { try JSON.decode(String.self, from: $0) }
        XCTAssertEqual(decoded, value)
      }
      assertParseError(
        "\"\(prefix)\nremaining\"",
        message: "unexpected character '\n'; unescaped control character in string"
      )
      assertParseError(
        [0x22] + Array(prefix.utf8) + [0xFF] + Array("remaining\"".utf8),
        message: "invalid UTF-8 sequence in string"
      )
    }
  }

  func testUTF8ScalarPairs() throws {
    // Cover the fast path and the E0/ED/four-byte fallbacks, with room for an eight-byte load.
    for value in ["中文", "\u{800}中", "中\u{D7FF}", "中\u{E000}", "中😀"] {
      var json = "\"\(value)\"   "
      let decoded = try json.withUTF8 { try JSON.decode(String.self, from: $0) }
      XCTAssertEqual(decoded, value)
    }
    let invalidSequences: [[UInt8]] = [[0xE1, 0x80, 0x7F], [0xE0, 0x9F, 0xBF], [0xED, 0xA0, 0x80]]
    for sequence in invalidSequences {
      assertParseError(
        [0x22, 0xE1, 0x80, 0x80] + sequence + [0x22, 0x20, 0x20, 0x20],
        message: "invalid UTF-8 sequence in string"
      )
    }
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
    assertParseError(Array(json.utf8), message: message, file: file, line: line)
  }

  private func assertParseError(_ json: [UInt8], message: String, file: StaticString = #filePath, line: UInt = #line) {
    json.withUnsafeBufferPointer {
      assertParseError($0, message: message, file: file, line: line)
    }
  }

  private func assertParseError(
    _ json: UnsafeBufferPointer<UInt8>,
    message: String,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    do {
      _ = try JSON.decode(Bool.self, from: json)
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

private struct EmptyStruct: Codable, Equatable {
  static func == (_ lhs: EmptyStruct, _ rhs: EmptyStruct) -> Bool {
    return true
  }
}

private class EmptyClass: Codable, Equatable {
  static func == (_ lhs: EmptyClass, _ rhs: EmptyClass) -> Bool {
    return true
  }
}

private enum Direction: Codable {
  case right
  case left
}

private enum Animal: String, Codable {
  case dog
  case cat
}

private enum Switch: Codable {
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

private indirect enum Tree: Codable, Equatable {
  case int(Int)
  case string(String)
  case array([Self])
  case dictionary([String: Self])
}

private struct ComplexStruct: Codable, Equatable {
  struct Diagnostic: Codable, Equatable {
    var message: String
    var animal: Animal
    var data: [Int?]
  }

  var result: String?
  var diagnostics: [Diagnostic]
  var elapsed: Double
}
