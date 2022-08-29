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

import SwiftSyntax

extension CustomAttribute {
  /// A convenience initializer that allows passing in arguments using a result builder
  /// and automatically adds parentheses as needed, similar to the convenience
  /// initializer for ``FunctionCallExpr``.
  public init(
    _ attributeName: ExpressibleAsTypeBuildable,
    @TupleExprElementListBuilder argumentList: () -> ExpressibleAsTupleExprElementList? = { nil }
  ) {
    let argumentList = argumentList()
    self.init(
      attributeName: attributeName,
      leftParen: argumentList != nil ? .leftParen : nil,
      argumentList: argumentList,
      rightParen: argumentList != nil ? .rightParen : nil
    )
  }
}

