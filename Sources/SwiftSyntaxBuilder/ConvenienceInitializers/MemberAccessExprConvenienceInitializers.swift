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

extension MemberAccessExpr {
  /// Creates a `MemberAccessExpr` using the provided parameters.
  public init(
    base: ExprSyntax? = nil,
    dot: Token = .period,
    name: String,
    declNameArguments: DeclNameArgumentsSyntax? = nil
  ) {
    self.init(base: base, dot: dot, name: TokenSyntax.identifier(name), declNameArguments: declNameArguments)
  }
}
