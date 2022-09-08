//===----------------------- CharacterInfo.swift --------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
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

    static let SPACE    = Character.Info(rawValue: 0x01)  // ' '
    static let DIGIT    = Character.Info(rawValue: 0x02)  // 0-9
    static let XLETTER  = Character.Info(rawValue: 0x04)  // a-f,A-F
    static let UPPER    = Character.Info(rawValue: 0x08)  // A-Z
    static let LOWER    = Character.Info(rawValue: 0x10)  // a-z
    static let UNDER    = Character.Info(rawValue: 0x20)  // _
    static let PERIOD   = Character.Info(rawValue: 0x40)  // .
    static let PUNCT    = Character.Info(rawValue: 0x80)  // `$@()

    static let XUPPER: Character.Info = [ .XLETTER, .UPPER ]

    static let XLOWER: Character.Info = [ .XLETTER, .LOWER ]
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
    return self.testRawInfoTable { entry in
      !entry.intersection([ .UPPER, .LOWER, .UNDER, ]).isEmpty
    }
  }

  /// A Boolean value indicating whether this scalar is one which is recommended
  /// to be allowed to appear in a non-starting position in a programming
  /// language identifier.
  var isAsciiIdentifierContinue: Bool {
    return self.testRawInfoTable { entry in
      !entry.intersection([ .UPPER, .LOWER, .DIGIT, .UNDER ]).isEmpty
    }
  }

  /// A Boolean value indicating whether this scalar is an ASCII character used
  /// for the representation of base-10 numbers.
  var isDigit: Bool {
    return self.testRawInfoTable { entry in
      entry.contains(.DIGIT)
    }
  }

  /// A Boolean value indicating whether this scalar is considered to be either
  /// an uppercase or lowercase ASCII character.
  var isLetter: Bool {
    return self.testRawInfoTable { entry in
      !entry.intersection([ .UPPER, .LOWER ]).isEmpty
    }
  }

  /// A Boolean value indicating whether this scalar is an ASCII character
  /// commonly used for the representation of hexadecimal numbers.
  var isHexDigit: Bool {
    return self.testRawInfoTable { entry in
      !entry.intersection([ .DIGIT, .XLETTER ]).isEmpty
    }
  }
}

extension Unicode.Scalar {
  private func testRawInfoTable(
    _ performTest: (Character.Info) -> Bool
  ) -> Bool {
    return self.isASCII && withUnsafePointer(to: &InfoTable) { InfoTable in
      let infoPtr = UnsafeRawBufferPointer(start: InfoTable, count: 0x80)
        .assumingMemoryBound(to: Character.Info.self)
      return performTest(infoPtr[Int(self.value)])
    }
  }
}

extension UnsafeRawBufferPointer {
  /// Returns a typed buffer to the memory referenced by this buffer,
  /// assuming that the memory is already bound to the specified type.
  ///
  /// Use this method when you have a raw buffer to memory that has *already*
  /// been bound to the specified type. The memory starting at this pointer
  /// must be bound to the type `T`. Accessing memory through the returned
  /// pointer is undefined if the memory has not been bound to `T`. To bind
  /// memory to `T`, use `bindMemory(to:capacity:)` instead of this method.
  ///
  /// - Note: The buffer's base address must match the
  ///   alignment of `T` (as reported by `MemoryLayout<T>.alignment`).
  ///   That is, `Int(bitPattern: self.baseAddress) % MemoryLayout<T>.alignment`
  ///   must equal zero.
  ///
  /// - Parameter to: The type `T` that the memory has already been bound to.
  /// - Returns: A typed pointer to the same memory as this raw pointer.
  fileprivate func assumingMemoryBound<T>(
    to: T.Type
  ) -> UnsafeBufferPointer<T> {
    guard let s = self.baseAddress else {
      return .init(start: nil, count: 0)
    }
    let c = self.count
    let n = c / MemoryLayout<T>.stride
    return .init(start: s.assumingMemoryBound(to: T.self), count: n)
  }
}

private var InfoTable: CharacterInfoTable = (
  // 0 NUL        1 SOH         2 STX         3 ETX
  // 4 EOT        5 ENQ         6 ACK         7 BEL
  [],             [],           [],           [],
  [],             [],           [],           [],
  // 8 BS          9 HT         10 NL         11 VT
  //12 NP         13 CR         14 SO         15 SI
  [],             [],           [],           [],
  [],             [],           [],           [],
  //16 DLE        17 DC1        18 DC2        19 DC3
  //20 DC4        21 NAK        22 SYN        23 ETB
  [],             [],           [],           [],
  [],             [],           [],           [],
  //24 CAN        25 EM         26 SUB        27 ESC
  //28 FS         29 GS         30 RS         31 US
  [],             [],           [],           [],
  [],             [],           [],           [],
  //32 SP         33  !         34  "         35  #
  //36  $         37  %         38  &         39  '
  .SPACE,         [],           [],           [],
  .PUNCT,         [],           [],           [],
  //40  (         41  )         42  *         43  +
  //44  ,         45  -         46  .         47  /
  .PUNCT,         .PUNCT,       [] ,          [],
  [],             [],           .PERIOD,      [],
  //48  0         49  1         50  2         51  3
  //52  4         53  5         54  6         55  7
  .DIGIT,         .DIGIT,       .DIGIT,       .DIGIT,
  .DIGIT,         .DIGIT,       .DIGIT,       .DIGIT,
  //56  8         57  9         58  :         59  ;
  //60  <         61  =         62  >         63  ?
  .DIGIT,         .DIGIT,       [],           [],
  [],             [],           [],           [],
  //64  @         65  A         66  B         67  C
  //68  D         69  E         70  F         71  G
  .PUNCT,         .XUPPER,      .XUPPER,      .XUPPER,
  .XUPPER,        .XUPPER,      .XUPPER,      .UPPER,
  //72  H         73  I         74  J         75  K
  //76  L         77  M         78  N         79  O
  .UPPER,         .UPPER,       .UPPER,       .UPPER,
  .UPPER,         .UPPER,       .UPPER,       .UPPER,
  //80  P         81  Q         82  R         83  S
  //84  T         85  U         86  V         87  W
  .UPPER,         .UPPER,       .UPPER,       .UPPER,
  .UPPER,         .UPPER,       .UPPER,       .UPPER,
  //88  X         89  Y         90  Z         91  [
  //92  \         93  ]         94  ^         95  _
  .UPPER,         .UPPER,       .UPPER,       [],
  .PUNCT,         [],           [],           .UNDER,
  //96  `         97  a         98  b         99  c
  //100  d       101  e        102  f        103  g
  .PUNCT,        .XLOWER,      .XLOWER,      .XLOWER,
  .XLOWER,       .XLOWER,      .XLOWER,      .LOWER,
  //104  h       105  i        106  j        107  k
  //108  l       109  m        110  n        111  o
  .LOWER,        .LOWER,       .LOWER,       .LOWER,
  .LOWER,        .LOWER,       .LOWER,       .LOWER,
  //112  p       113  q        114  r        115  s
  //116  t       117  u        118  v        119  w
  .LOWER,        .LOWER,       .LOWER,       .LOWER,
  .LOWER,        .LOWER,       .LOWER,       .LOWER,
  //120  x       121  y        122  z        123  {
  //124  |       125  }        126  ~        127 DEL
  .LOWER,        .LOWER,       .LOWER,       [],
  [],            [] ,          [] ,          [])

private typealias CharacterInfoTable = (
  Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info,
  Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info,
  Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info,
  Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info,
  Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info,
  Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info,
  Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info,
  Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info,
  Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info,
  Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info,
  Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info,
  Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info,
  Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info,
  Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info,
  Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info,
  Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info, Character.Info
)
