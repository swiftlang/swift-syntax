//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if compiler(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

// TODO: We ought to consider exposing this as a public syntax protocol.
@_spi(Testing) public protocol CallLikeSyntax: SyntaxProtocol {
  var arguments: LabeledExprListSyntax { get set }
  var leftParen: TokenSyntax? { get set }
  var rightParen: TokenSyntax? { get set }
  var trailingClosure: ClosureExprSyntax? { get set }
  var additionalTrailingClosures: MultipleTrailingClosureElementListSyntax { get set }
}
@_spi(Testing) extension FunctionCallExprSyntax: CallLikeSyntax {}
@_spi(Testing) extension MacroExpansionExprSyntax: CallLikeSyntax {}
@_spi(Testing) extension MacroExpansionDeclSyntax: CallLikeSyntax {}

extension SyntaxProtocol {
  @_spi(Testing) public func asProtocol(_: CallLikeSyntax.Protocol) -> (any CallLikeSyntax)? {
    Syntax(self).asProtocol(SyntaxProtocol.self) as? CallLikeSyntax
  }
}
