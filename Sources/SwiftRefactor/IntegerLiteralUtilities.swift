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

#if swift(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

extension IntegerLiteralExprSyntax {
  public enum Radix {
    case binary
    case octal
    case decimal
    case hex

    public var size: Int {
      switch self {
      case .binary: return 2
      case .octal: return 8
      case .decimal: return 10
      case .hex: return 16
      }
    }
  }

  public var radix: Radix {
    let text = self.literal.text
    if text.starts(with: "0b") {
      return .binary
    } else if text.starts(with: "0o") {
      return .octal
    } else if text.starts(with: "0x") {
      return .hex
    } else {
      return .decimal
    }
  }

  /// Returns an (arbitrarily) "ideal" number of digits that should constitute
  /// a separator-delimited "group" in an integer literal.
  var idealGroupSize: Int {
    switch self.radix {
    case .binary: return 4
    case .octal: return 3
    case .decimal: return 3
    case .hex: return 4
    }
  }

  /// Split the leading radix prefix from the value part of this integer literal.
  ///
  /// ```
  /// 10 -> ("", "10")
  /// 0xFFFF -> ("0x", "FFFF")
  /// 0o77 -> ("0o", "77")
  /// 0b1010101 -> ("0b", "1010101")
  /// ```
  public func split() -> (prefix: String, value: Substring) {
    let text = self.literal.text
    switch self.radix {
    case .binary:
      return ("0b", text.dropFirst(2))
    case .octal:
      return ("0o", text.dropFirst(2))
    case .decimal:
      return ("", Substring(text))
    case .hex:
      return ("0x", text.dropFirst(2))
    }
  }
}
