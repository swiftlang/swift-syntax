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

import SwiftSyntax
import SwiftSyntaxBuilder
import SyntaxSupport

@MemberBlockItemListBuilder
func choiceNodeCastingMethods(for syntaxNodeKind: SyntaxNodeKind) -> MemberBlockItemListSyntax {
  let apiAttributes = SYNTAX_NODE_MAP[syntaxNodeKind]?.apiAttributes() ?? []
  if syntaxNodeKind.isBase {
    DeclSyntax(
      """
      /// Checks if the current syntax node can be cast to the type conforming to the ``\(syntaxNodeKind.protocolType)`` protocol.
      ///
      /// - Returns: `true` if the node can be cast, `false` otherwise.
      \(apiAttributes)\
      public func `is`<S: \(syntaxNodeKind.protocolType)>(_ syntaxType: S.Type) -> Bool {
        return self.as(syntaxType) != nil
      }
      """
    )

    DeclSyntax(
      """
      /// Attempts to cast the current syntax node to the type conforming to the ``\(syntaxNodeKind.protocolType)`` protocol.
      ///
      /// - Returns: An instance of the specialized type, or `nil` if the cast fails.
      \(apiAttributes)\
      public func `as`<S: \(syntaxNodeKind.protocolType)>(_ syntaxType: S.Type) -> S? {
        return S.init(self)
      }
      """
    )

    DeclSyntax(
      """
      /// Force-casts the current syntax node to the type conforming to the ``\(syntaxNodeKind.protocolType)`` protocol.
      ///
      /// - Returns: An instance of the specialized type.
      /// - Warning: This function will crash if the cast is not possible. Use `as` to safely attempt a cast.
      \(apiAttributes)\
      public func cast<S: \(syntaxNodeKind.protocolType)>(_ syntaxType: S.Type) -> S {
        return self.as(S.self)!
      }
      """
    )
  } else {
    DeclSyntax(
      """
      /// Checks if the current syntax node can be cast to \(raw: syntaxNodeKind.doccLink).
      ///
      /// - Returns: `true` if the node can be cast, `false` otherwise.
      \(apiAttributes)\
      public func `is`(_ syntaxType: \(syntaxNodeKind.syntaxType).Type) -> Bool {
        return self.as(syntaxType) != nil
      }
      """
    )

    DeclSyntax(
      """
      /// Attempts to cast the current syntax node to \(raw: syntaxNodeKind.doccLink).
      ///
      /// - Returns: An instance of \(raw: syntaxNodeKind.doccLink), or `nil` if the cast fails.
      \(apiAttributes)\
      public func `as`(_ syntaxType: \(syntaxNodeKind.syntaxType).Type) -> \(syntaxNodeKind.syntaxType)? {
        return \(syntaxNodeKind.syntaxType).init(self)
      }
      """
    )

    DeclSyntax(
      """
      /// Force-casts the current syntax node to \(raw: syntaxNodeKind.doccLink).
      ///
      /// - Returns: An instance of \(raw: syntaxNodeKind.doccLink).
      /// - Warning: This function will crash if the cast is not possible. Use `as` to safely attempt a cast.
      \(apiAttributes)\
      public func cast(_ syntaxType: \(syntaxNodeKind.syntaxType).Type) -> \(syntaxNodeKind.syntaxType) {
        return self.as(\(syntaxNodeKind.syntaxType).self)!
      }
      """
    )
  }
}
