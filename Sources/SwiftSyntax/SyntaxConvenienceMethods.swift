//===- SyntaxConvenienceMethods.swift - Convenience funcs for syntax nodes ===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2019 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

public extension FloatLiteralExprSyntax {
  var floatingValue: Double {
    // Parsing a floating literal as a Double should never fail
    return Double(self.floatingDigits.text)!
  }
}

public extension IntegerLiteralExprSyntax {
  var integerValue: Int {
    // Parsing an integer literal as an Int should never fail
    return Int(self.digits.text)!
  }
}
