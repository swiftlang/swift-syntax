//===- SyntaxConvenienceMethods.swift - Convenience funcs for syntax nodes ===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2020 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

public extension FloatLiteralExprSyntax {
  var floatingValue: Double {
    return potentialFloatingValue!
  }

  fileprivate var potentialFloatingValue: Double? {
    let floatingDigitsWithoutUnderscores = floatingDigits.text.filter {
      $0 != "_"
    }
    return Double(floatingDigitsWithoutUnderscores)
  }
}

public extension IntegerLiteralExprSyntax {
  var integerValue: Int {
    return potentialIntegerValue!
  }

  fileprivate var potentialIntegerValue: Int? {
    let text = digits.text
    let (prefixLength, radix) = IntegerLiteralExprSyntax.prefixLengthAndRadix(text: text)
    let digitsStartIndex = text.index(text.startIndex, offsetBy: prefixLength)
    let textWithoutPrefix = text.suffix(from: digitsStartIndex)

    let textWithoutPrefixOrUnderscores = textWithoutPrefix.filter {
      $0 != "_"
    }

    return Int(textWithoutPrefixOrUnderscores, radix: radix)
  }

  private static func prefixLengthAndRadix(text: String) -> (Int, Int) {
    let nonDecimalPrefixLength = 2

    let binaryPrefix = "0b"
    let octalPrefix = "0o"
    let decimalPrefix = ""
    let hexadecimalPrefix = "0x"

    let binaryRadix = 2
    let octalRadix = 8
    let decimalRadix = 10
    let hexadecimalRadix = 16

    switch String(text.prefix(nonDecimalPrefixLength)) {
    case binaryPrefix:
      return (binaryPrefix.count, binaryRadix)
    case octalPrefix:
      return (octalPrefix.count, octalRadix)
    case hexadecimalPrefix:
      return (hexadecimalPrefix.count, hexadecimalRadix)
    default:
      return (decimalPrefix.count, decimalRadix)
    }
  }
}

public extension IntegerLiteralExprSyntax {
  var isValid: Bool {
    potentialIntegerValue != nil
  }
}

public extension FloatLiteralExprSyntax {
  var isValid: Bool {
    potentialFloatingValue != nil
  }
}
