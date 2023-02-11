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

extension Character {
  fileprivate struct Info: OptionSet {
    var rawValue: UInt8

    init(rawValue: UInt8) {
      self.rawValue = rawValue
    }

    static let IDENT_START: Self = .init(rawValue: 0x01)
    static let IDENT_CONT: Self = .init(rawValue: 0x02)
    static let DECIMAL: Self = .init(rawValue: 0x04)
    static let HEX: Self = .init(rawValue: 0x08)
    static let LETTER: Self = .init(rawValue: 0x10)
  }
}

extension Unicode.Scalar {
  var isASCII: Bool {
    return self.value <= 127
  }

  /// A Boolean value indicating whether this scalar is one which is recommended
  /// to be allowed to appear in a starting position in a programming language
  /// identifier.
  var isAsciiIdentifierStart: Bool {
    self.testCharacterInfo(.IDENT_START)
  }

  /// A Boolean value indicating whether this scalar is one which is recommended
  /// to be allowed to appear in a non-starting position in a programming
  /// language identifier.
  var isAsciiIdentifierContinue: Bool {
    self.testCharacterInfo(.IDENT_CONT)
  }

  /// A Boolean value indicating whether this scalar is an ASCII character used
  /// for the representation of base-10 numbers.
  var isDigit: Bool {
    self.testCharacterInfo(.DECIMAL)
  }

  /// A Boolean value indicating whether this scalar is considered to be either
  /// an uppercase or lowercase ASCII character.
  var isLetter: Bool {
    self.testCharacterInfo(.LETTER)
  }

  /// A Boolean value indicating whether this scalar is an ASCII character
  /// commonly used for the representation of hexadecimal numbers.
  var isHexDigit: Bool {
    self.testCharacterInfo(.HEX)
  }
}

extension Unicode.Scalar {
  private func testCharacterInfo(
    _ match: Character.Info
  ) -> Bool {
    let info: Character.Info
    switch self.value {
    case  // '0'-'9'
    48, 49, 50, 51, 52, 53, 54, 55, 56, 57:
      info = [.IDENT_CONT, .DECIMAL, .HEX]

    case  // 'A'-'F'
    65, 66, 67, 68, 69, 70,
      // 'a'-'f'
      97, 98, 99, 100, 101, 102:
      info = [.IDENT_START, .IDENT_CONT, .HEX, .LETTER]

    case  // 'G'-'Z'
    71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88,
      89, 90,
      // 'g'-'z'
      103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117,
      118, 119, 120, 121, 122:
      info = [.IDENT_START, .IDENT_CONT, .LETTER]

    case  // '_'
    95:
      info = [.IDENT_START, .IDENT_CONT]

    case  // '$'
    36:
      info = [.IDENT_CONT]

    default:
      info = []
    }
    return info.contains(match)
  }
}
