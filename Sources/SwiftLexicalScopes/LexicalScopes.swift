//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation
import SwiftSyntax

extension SyntaxProtocol {
  /// Given syntax node position, returns all available labeled statements.
  @_spi(Compiler) @_spi(Testing) public func lookupLabeledStmts() -> [LabeledStmtSyntax] {
    guard let scope else { return [] }
    return scope.lookupLabeledStmts(at: self)
  }

  /// Given syntax node position, returns the current switch case and it's fallthrough destination.
  @_spi(Compiler) @_spi(Testing) public func lookupFallthroughSourceAndDest()
  -> (source: SwitchCaseSyntax?, destination: SwitchCaseSyntax?) {
    guard let scope else { return (nil, nil) }
    return scope.lookupFallthroughSourceAndDestination(at: self)
  }

  /// Given syntax node position, returns the closest ancestor catch node.
  @_spi(Compiler) @_spi(Testing) public func lookupCatchNode() -> Syntax? {
    guard let scope else { return nil }
    return scope.lookupCatchNode(at: Syntax(self))
  }

  /// Given name and syntax node position, return referenced declaration.
  @_spi(Compiler) @_spi(Testing) public func lookupDeclarationsFor(name: String) -> [Syntax] {
    guard let scope else { return [] }
    return scope.getDeclarationsFor(name: name, at: self)
  }
}
