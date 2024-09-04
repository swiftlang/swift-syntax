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

extension ChildNodeChoices.Choice {
  @MemberBlockItemListBuilder
  var castingMethods: MemberBlockItemListSyntax {
    if self.isBase {
      DeclSyntax(
        """
        /// Checks if the current syntax node can be cast to the type conforming to the ``\(self.protocolType)`` protocol.
        ///
        /// - Returns: `true` if the node can be cast, `false` otherwise.
        \(self.experimentalDocNote)\
        \(self.apiAttributes)\
        public func `is`(_ syntaxType: (some \(self.protocolType)).Type) -> Bool {
          return self.as(syntaxType) != nil
        }
        """
      )

      DeclSyntax(
        """
        /// Attempts to cast the current syntax node to the type conforming to the ``\(self.protocolType)`` protocol.
        ///
        /// - Returns: An instance of the specialized type, or `nil` if the cast fails.
        \(self.experimentalDocNote)\
        \(self.apiAttributes)\
        public func `as`<S: \(self.protocolType)>(_ syntaxType: S.Type) -> S? {
          return S.init(self)
        }
        """
      )

      DeclSyntax(
        """
        /// Force-casts the current syntax node to the type conforming to the ``\(self.protocolType)`` protocol.
        ///
        /// - Returns: An instance of the specialized type.
        /// - Warning: This function will crash if the cast is not possible. Use `as` to safely attempt a cast.
        \(self.experimentalDocNote)\
        \(self.apiAttributes)\
        public func cast<S: \(self.protocolType)>(_ syntaxType: S.Type) -> S {
          return self.as(S.self)!
        }
        """
      )
    } else {
      DeclSyntax(
        """
        /// Checks if the current syntax node can be cast to \(raw: self.doccLink).
        ///
        /// - Returns: `true` if the node can be cast, `false` otherwise.
        \(self.experimentalDocNote)\
        \(self.apiAttributes)\
        public func `is`(_ syntaxType: \(self.syntaxType).Type) -> Bool {
          return self.as(syntaxType) != nil
        }
        """
      )

      DeclSyntax(
        """
        /// Attempts to cast the current syntax node to \(raw: self.doccLink).
        ///
        /// - Returns: An instance of \(raw: self.doccLink), or `nil` if the cast fails.
        \(self.experimentalDocNote)\
        \(self.apiAttributes)\
        public func `as`(_ syntaxType: \(self.syntaxType).Type) -> \(self.syntaxType)? {
          return \(self.syntaxType).init(self)
        }
        """
      )

      DeclSyntax(
        """
        /// Force-casts the current syntax node to \(raw: self.doccLink).
        ///
        /// - Returns: An instance of \(raw: self.doccLink).
        /// - Warning: This function will crash if the cast is not possible. Use `as` to safely attempt a cast.
        \(self.experimentalDocNote)\
        \(self.apiAttributes)\
        public func cast(_ syntaxType: \(self.syntaxType).Type) -> \(self.syntaxType) {
          return self.as(\(self.syntaxType).self)!
        }
        """
      )
    }
  }
}
