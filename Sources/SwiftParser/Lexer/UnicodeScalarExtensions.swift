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

extension Unicode.Scalar {
  var isValidIdentifierContinuationCodePoint: Bool {
    if self.isASCII {
      return self.isAsciiIdentifierContinue
    }

    // N1518: Recommendations for extended identifier characters for C and C++
    // Proposed Annex X.1: Ranges of characters allowed
    let c = self.value
    return (c == 0x00A8) as Bool
      || (c == 0x00AA) as Bool
      || (c == 0x00AD) as Bool
      || (c == 0x00AF) as Bool
      || (c >= 0x00B2 && c <= 0x00B5) as Bool
      || (c >= 0x00B7 && c <= 0x00BA) as Bool
      || (c >= 0x00BC && c <= 0x00BE) as Bool
      || (c >= 0x00C0 && c <= 0x00D6) as Bool
      || (c >= 0x00D8 && c <= 0x00F6) as Bool
      || (c >= 0x00F8 && c <= 0x00FF) as Bool

      || (c >= 0x0100 && c <= 0x167F) as Bool
      || (c >= 0x1681 && c <= 0x180D) as Bool
      || (c >= 0x180F && c <= 0x1FFF) as Bool

      || (c >= 0x200B && c <= 0x200D) as Bool
      || (c >= 0x202A && c <= 0x202E) as Bool
      || (c >= 0x203F && c <= 0x2040) as Bool
      || (c == 0x2054) as Bool
      || (c >= 0x2060 && c <= 0x206F) as Bool

      || (c >= 0x2070 && c <= 0x218F) as Bool
      || (c >= 0x2460 && c <= 0x24FF) as Bool
      || (c >= 0x2776 && c <= 0x2793) as Bool
      || (c >= 0x2C00 && c <= 0x2DFF) as Bool
      || (c >= 0x2E80 && c <= 0x2FFF) as Bool

      || (c >= 0x3004 && c <= 0x3007) as Bool
      || (c >= 0x3021 && c <= 0x302F) as Bool
      || (c >= 0x3031 && c <= 0x303F) as Bool

      || (c >= 0x3040 && c <= 0xD7FF) as Bool

      || (c >= 0xF900 && c <= 0xFD3D) as Bool
      || (c >= 0xFD40 && c <= 0xFDCF) as Bool
      || (c >= 0xFDF0 && c <= 0xFE44) as Bool
      || (c >= 0xFE47 && c <= 0xFFF8) as Bool

      || (c >= 0x10000 && c <= 0x1FFFD) as Bool
      || (c >= 0x20000 && c <= 0x2FFFD) as Bool
      || (c >= 0x30000 && c <= 0x3FFFD) as Bool
      || (c >= 0x40000 && c <= 0x4FFFD) as Bool
      || (c >= 0x50000 && c <= 0x5FFFD) as Bool
      || (c >= 0x60000 && c <= 0x6FFFD) as Bool
      || (c >= 0x70000 && c <= 0x7FFFD) as Bool
      || (c >= 0x80000 && c <= 0x8FFFD) as Bool
      || (c >= 0x90000 && c <= 0x9FFFD) as Bool
      || (c >= 0xA0000 && c <= 0xAFFFD) as Bool
      || (c >= 0xB0000 && c <= 0xBFFFD) as Bool
      || (c >= 0xC0000 && c <= 0xCFFFD) as Bool
      || (c >= 0xD0000 && c <= 0xDFFFD) as Bool
      || (c >= 0xE0000 && c <= 0xEFFFD) as Bool
  }

  var isValidIdentifierStartCodePoint: Bool {
    if (self.isASCII) {
      return self.isAsciiIdentifierStart
    }
    guard self.isValidIdentifierContinuationCodePoint else {
      return false
    }

    // N1518: Recommendations for extended identifier characters for C and C++
    // Proposed Annex X.2: Ranges of characters disallowed initially
    let c = self.value
    if ((c >= 0x0300 && c <= 0x036F) || (c >= 0x1DC0 && c <= 0x1DFF) || (c >= 0x20D0 && c <= 0x20FF) || (c >= 0xFE20 && c <= 0xFE2F)) {
      return false
    }

    return true
  }

  /// isOperatorStartCodePoint - Return true if the specified code point is a
  /// valid start of an operator.
  var isOperatorStartCodePoint: Bool {
    // ASCII operator chars.
    if self.value < 0x80 {
      switch UInt8(self.value) {
      case "/", "=", "-", "+", "*", "%", "<",
        ">", "!", "&", "|", "^", "~", ".", "?":
        return true
      default:
        return false
      }
    }

    // Unicode math, symbol, arrow, dingbat, and line/box drawing chars.
    let c = self.value
    return (c >= 0x00A1 && c <= 0x00A7)
      || c == 0x00A9 || c == 0x00AB || c == 0x00AC || c == 0x00AE
      || c == 0x00B0 || c == 0x00B1 || c == 0x00B6 || c == 0x00BB
      || c == 0x00BF || c == 0x00D7 || c == 0x00F7
      || c == 0x2016 || c == 0x2017 || (c >= 0x2020 && c <= 0x2027)
      || (c >= 0x2030 && c <= 0x203E) || (c >= 0x2041 && c <= 0x2053)
      || (c >= 0x2055 && c <= 0x205E) || (c >= 0x2190 && c <= 0x23FF)
      || (c >= 0x2500 && c <= 0x2775) || (c >= 0x2794 && c <= 0x2BFF)
      || (c >= 0x2E00 && c <= 0x2E7F) || (c >= 0x3001 && c <= 0x3003)
      || (c >= 0x3008 && c <= 0x3030)
  }

  /// isOperatorContinuationCodePoint - Return true if the specified code point
  /// is a valid operator code point.
  var isOperatorContinuationCodePoint: Bool {
    if self.isOperatorStartCodePoint {
      return true
    }

    // Unicode combining characters and variation selectors.
    let c = self.value
    return (c >= 0x0300 && c <= 0x036F)
      || (c >= 0x1DC0 && c <= 0x1DFF)
      || (c >= 0x20D0 && c <= 0x20FF)
      || (c >= 0xFE00 && c <= 0xFE0F)
      || (c >= 0xFE20 && c <= 0xFE2F)
      || (c >= 0xE0100 && c <= 0xE01EF)
  }

  /// Whether this character represents a printable ASCII character,
  /// for the purposes of pattern parsing.
  var isPrintableASCII: Bool {
    // Exclude non-printables before the space character U+20, and anything
    // including and above the DEL character U+7F.
    return self.value >= 0x20 && self.value < 0x7F
  }
}

extension Unicode.Scalar {
  /// Lex a single unicode scalar, which might consists of multiple bytes.
  /// `advance` returns the current byte in the lexer and advances the lexer by
  /// one byte.
  /// `peek` returns the current byte in the lexer without advancing it.
  @inline(__always)
  static func lexing(advance: () -> UInt8?, peek: () -> UInt8?) -> Self? {
    guard let curByte = advance() else {
      return nil
    }

    if (curByte < 0x80) {
      return Unicode.Scalar(curByte)
    }

    // If this is not the start of a UTF8 character,
    // then it is either a continuation byte or an invalid UTF8 code point.
    if !curByte.isStartOfUTF8Character {
      // Skip until we get the start of another character.  This is guaranteed to
      // at least stop at the nul at the end of the buffer.
      while let peeked = peek(), !peeked.isStartOfUTF8Character {
        _ = advance()
      }
      return nil
    }

    // Read the number of high bits set, which indicates the number of bytes in
    // the character.
    let encodedBytes = (~curByte).leadingZeroBitCount
    // We have a multi-byte UTF-8 scalar.
    // Single-byte UTF-8 scalars are handled at the start of the function by checking `curByte < 0x80`.
    // `isStartOfUTF8Character` guaranteed that the `curByte` has 2 to 4 leading ones.
    precondition(encodedBytes >= 2 && encodedBytes <= 4)

    // Drop the high bits indicating the # bytes of the result.
    var charValue = UInt32(curByte << encodedBytes) >> encodedBytes

    // Read and validate the continuation bytes.
    for _ in 1..<encodedBytes {
      guard let curByte = peek() else {
        return nil
      }
      // If the high bit isn't set or the second bit isn't clear, then this is not
      // a continuation byte!
      if (curByte < 0x80 || curByte >= 0xC0) {
        return nil
      }

      // Accumulate our result.
      charValue <<= 6
      charValue |= UInt32(curByte & 0x3F)
      _ = advance()
    }

    // If we got here, we read the appropriate number of accumulated bytes.
    // Verify that the encoding was actually minimal.
    // Number of bits in the value, ignoring leading zeros.
    let numBits = 32 - charValue.leadingZeroBitCount
    if numBits <= 5 + 6 {
      return encodedBytes == 2 ? Unicode.Scalar(charValue) : nil
    }
    if numBits <= 4 + 6 + 6 {
      return encodedBytes == 3 ? Unicode.Scalar(charValue) : nil
    }
    return encodedBytes == 4 ? Unicode.Scalar(charValue) : nil
  }

  /// Returns the first unicode scalar in `byteSequence`, which may span multiple bytes.
  @_spi(Diagnostics)
  public static func lexing(from byteSequence: some Collection<UInt8>) -> Self? {
    var index = byteSequence.startIndex
    let peek = { () -> UInt8? in
      if index < byteSequence.endIndex {
        return byteSequence[index]
      } else {
        return nil
      }
    }
    let advance = { () -> UInt8? in
      defer {
        index = byteSequence.index(after: index)
      }
      return peek()
    }

    return self.lexing(advance: advance, peek: peek)
  }
}

extension UInt8 {
  var isStartOfUTF8Character: Bool {
    // RFC 2279: The octet values FE and FF never appear.
    // RFC 3629: The octet values C0, C1, F5 to FF never appear.
    return self < 0x80 || (self >= 0xC2 && self < 0xF5)
  }
}

/// Allows direct comparisons between UInt8 and double quoted literals.
extension UInt8 {
  /// Equality operator
  @_transparent
  static func == (i: Self, s: Unicode.Scalar) -> Bool {
    return i == UInt8(ascii: s)
  }
  /// Inequality operator
  @_transparent
  static func != (i: Self, s: Unicode.Scalar) -> Bool {
    return i != UInt8(ascii: s)
  }
  /// Used in switch statements
  @_transparent
  static func ~= (s: Unicode.Scalar, i: Self) -> Bool {
    return i == UInt8(ascii: s)
  }
}

extension UInt8? {
  /// Equality operator
  @_transparent
  static func == (i: Self, s: Unicode.Scalar) -> Bool {
    return i == UInt8(ascii: s)
  }
  /// Inequality operator
  @_transparent
  static func != (i: Self, s: Unicode.Scalar) -> Bool {
    return i != UInt8(ascii: s)
  }
  /// Used in switch statements
  @_transparent
  static func ~= (s: Unicode.Scalar, i: Self) -> Bool {
    return i == UInt8(ascii: s)
  }
}
