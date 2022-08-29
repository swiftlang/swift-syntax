//===----------------------------------------------------------------------===//
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

extension FloatLiteralExpr {
  public init(_ value: Float) {
    self.init(floatingDigits: String(value))
  }
}

extension FloatLiteralExpr: ExpressibleByFloatLiteral {
  public init(floatLiteral value: Float) {
    self.init(value)
  }
}
