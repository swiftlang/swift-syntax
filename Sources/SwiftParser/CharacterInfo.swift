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

extension UInt8 {
  /// A Boolean value indicating whether this byte is an ASCII character which is
  /// recommended to be allowed to appear in a non-starting position in a
  /// programming language identifier.
  var isAsciiIdentifierContinue: Bool {
    self.testCharacterInfo(.IDENT_CONT)
  }

  /// The classification of a byte, which is what a scalar's classification
  /// reduces to: a scalar outside ASCII belongs to none of these sets, and one
  /// inside it is this byte.
  fileprivate func testCharacterInfo(
    _ match: Character.Info
  ) -> Bool {
    let info: Character.Info
    switch self {
    case UInt8(ascii: "0")...UInt8(ascii: "9"):
      info = [.IDENT_CONT, .DECIMAL, .HEX]

    case UInt8(ascii: "A")...UInt8(ascii: "F"),
      UInt8(ascii: "a")...UInt8(ascii: "f"):
      info = [.IDENT_START, .IDENT_CONT, .HEX, .LETTER]

    case UInt8(ascii: "G")...UInt8(ascii: "Z"),
      UInt8(ascii: "g")...UInt8(ascii: "z"):
      info = [.IDENT_START, .IDENT_CONT, .LETTER]

    case UInt8(ascii: "_"):
      info = [.IDENT_START, .IDENT_CONT]

    case UInt8(ascii: "$"):
      info = [.IDENT_CONT]

    default:
      info = []
    }
    return info.contains(match)
  }
}

extension Unicode.Scalar {
  private func testCharacterInfo(
    _ match: Character.Info
  ) -> Bool {
    guard self.isASCII else {
      return false
    }
    // `isASCII` has established the range, so the conversion need not check it
    // again.
    return UInt8(truncatingIfNeeded: self.value).testCharacterInfo(match)
  }
}
