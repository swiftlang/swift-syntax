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

public enum LexicalScopes {
  /// Given syntax node position, returns all available labeled statements.
  public static func lookupLabeledStmts(at syntax: SyntaxProtocol) -> [LabeledStmtSyntax] {
    guard let scope = syntax.scope else { return [] }
    return scope.lookupLabeledStmts(at: syntax)
  }

  /// Given syntax node position, returns the current switch case and it's fallthrough destination.
  public static func lookupFallthroughSourceAndDest(
    at syntax: SyntaxProtocol
  ) -> (source: SwitchCaseSyntax?, destination: SwitchCaseSyntax?) {
    guard let scope = syntax.scope else { return (nil, nil) }
    return scope.lookupFallthroughSourceAndDestination(at: syntax)
  }

  /// Given syntax node position, returns the closest ancestor catch node.
  public static func lookupCatchNode(at syntax: SyntaxProtocol) -> Syntax? {
    guard let scope = syntax.scope else { return nil }
    return scope.lookupCatchNode(at: Syntax(syntax))
  }

  /// Given name and syntax node position, return referenced declaration.
  public static func lookupDeclarationFor(name: String, at syntax: SyntaxProtocol) -> Syntax? {
    guard let scope = syntax.scope else { return nil }
    return scope.getDeclarationFor(name: name, at: syntax)
  }
}
