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
import Utils

let syntaxBaseNodesFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  for node in SYNTAX_NODES where node.kind.isBase {
    let documentation = SwiftSyntax.Trivia(joining: [
      node.documentation,
      node.subtypes,
    ])
    DeclSyntax(
      """
      // MARK: - \(node.kind.syntaxType)

      /// Protocol to which all \(raw: node.kind.doccLink) nodes conform.
      ///
      /// Extension point to add common methods to all \(raw: node.kind.doccLink) nodes.
      ///
      ///  - Warning: Do not conform to this protocol yourself.
      \(node.apiAttributes())\
      public protocol \(node.kind.protocolType): \(node.base.protocolType) {}
      """
    )

    DeclSyntax(
      #"""
      /// Extension of ``\#(node.kind.protocolType)`` to provide casting methods.
      ///
      /// These methods enable casting between syntax node types within the same
      /// base node protocol hierarchy (e.g., ``DeclSyntaxProtocol``).
      ///
      /// While ``SyntaxProtocol`` offers general casting methods (``SyntaxProtocol.as(_:)``, 
      /// ``SyntaxProtocol.is(_:)``, and ``SyntaxProtocol.cast(_:)``), these often aren't
      /// appropriate for use on types conforming to a specific base node protocol
      /// like ``\#(node.kind.protocolType)``. That's because at this level,
      /// we know that the cast to another base node type (e.g., ``DeclSyntaxProtocol``
      /// when working with ``ExprSyntaxProtocol``) is guaranteed to fail.
      ///
      /// To guide developers toward correct usage, this extension provides overloads
      /// of these casting methods that are restricted to the same base node type.
      /// Furthermore, it marks the inherited casting methods from ``SyntaxProtocol`` as 
      /// deprecated, indicating that they will always fail when used in this context.
      extension \#(node.kind.protocolType) {
        /// Checks if the current syntax node can be cast to a given specialized syntax type.
        ///
        /// - Returns: `true` if the node can be cast, `false` otherwise.
        public func `is`<S: \#(node.kind.protocolType)>(_ syntaxType: S.Type) -> Bool {
          return self.as(syntaxType) != nil
        }

        /// Attempts to cast the current syntax node to a given specialized syntax type.
        ///
        /// - Returns: An instance of the specialized type, or `nil` if the cast fails.
        public func `as`<S: \#(node.kind.protocolType)>(_ syntaxType: S.Type) -> S? {
          return S.init(self)
        }

        /// Force-casts the current syntax node to a given specialized syntax type.
        ///
        /// - Returns: An instance of the specialized type.
        ///
        /// - Warning: This function will crash if the cast is not possible. Use `as` to safely attempt a cast.
        public func cast<S: \#(node.kind.protocolType)>(_ syntaxType: S.Type) -> S {
          return self.as(S.self)!
        }

        /// Checks if the current syntax node can be upcast to its base node type (\#(raw: node.kind.doccLink)).
        ///
        /// - Returns: `true` since the node can always be upcast to its base node.
        @available(*, deprecated, message: "This cast will always succeed")
        public func `is`(_ syntaxType: \#(node.kind.syntaxType).Type) -> Bool {
          return true
        }

        /// Attempts to upcast the current syntax node to its base node type (\#(raw: node.kind.doccLink)).
        ///
        /// - Returns: The base node created from the current syntax node, as the node can always be upcast to its base type.
        @available(*, deprecated, message: "Use `\#(node.kind.syntaxType).init` for upcasting")
        public func `as`(_ syntaxType: \#(node.kind.syntaxType).Type) -> \#(node.kind.syntaxType)? {
          return \#(node.kind.syntaxType)(self)
        }

        /// Force-upcast the current syntax node to its base node type (\#(raw: node.kind.doccLink)).
        ///
        /// - Returns: The base node created from the current syntax node, as the node can always be upcast to its base type.
        @available(*, deprecated, message: "Use `\#(node.kind.syntaxType).init` for upcasting")
        public func cast(_ syntaxType: \#(node.kind.syntaxType).Type) -> \#(node.kind.syntaxType) {
          return \#(node.kind.syntaxType)(self)
        }

        /// Checks if the current syntax node can be cast to a given node type from a base node protocol hierarchy other
        /// than ``\#(node.kind.protocolType)``.
        ///
        /// - Returns: `true` if the node can be cast, `false` otherwise.
        ///
        /// - Note: In most cases, this is comparing a ``\#(node.kind.protocolType)`` to a node that is not a
        ///   ``\#(node.kind.protocolType)``, which will always fail. If the `syntaxType` argument is a generic type,
        ///   constrain it to ``\#(node.kind.protocolType)`` instead of ``SyntaxProtocol``.
        @available(*, deprecated, message: "Type argument should be part of the '\#(node.kind.protocolType)' hierarchy")
        public func `is`<S: SyntaxProtocol>(_ syntaxType: S.Type) -> Bool {
          return self.as(syntaxType) != nil
        }

        /// Attempts to cast the current syntax node to a given node type from the a base node protocol hierarchy other than
        /// ``\#(node.kind.protocolType)``.
        ///
        /// - Returns: An instance of the specialized type, or `nil` if the cast fails.
        ///
        /// - Note: In most cases, this is casting a ``\#(node.kind.protocolType)`` to a node that is not a
        ///   ``\#(node.kind.protocolType)``, which will always fail. If the `syntaxType` argument is a generic type,
        ///   constrain it to ``\#(node.kind.protocolType)`` instead of ``SyntaxProtocol``.
        @available(*, deprecated, message: "Type argument should be part of the '\#(node.kind.protocolType)' hierarchy")
        public func `as`<S: SyntaxProtocol>(_ syntaxType: S.Type) -> S? {
          return S.init(self)
        }

        /// Force-casts the current syntax node to a given node type from a base node protocol hierarchy other than
        /// ``\#(node.kind.protocolType)``.
        ///
        /// - Returns: An instance of the specialized type.
        ///
        /// - Warning: This function will crash if the cast is not possible. Use `as` to safely attempt a cast.
        ///
        /// - Note: In most cases, this is casting a ``\#(node.kind.protocolType)`` to a node that is not a
        ///   ``\#(node.kind.protocolType)``, which will always fail. If the `syntaxType` argument is a generic type,
        ///   constrain it to ``\#(node.kind.protocolType)`` instead of ``SyntaxProtocol``.
        @available(*, deprecated, message: "Type argument should be part of the '\#(node.kind.protocolType)' hierarchy")
        public func cast<S: SyntaxProtocol>(_ syntaxType: S.Type) -> S {
          return self.as(S.self)!
        }
      }
      """#
    )

    try! ExtensionDeclSyntax("extension Syntax") {
      DeclSyntax(
        """
        /// Check whether the non-type erased version of this syntax node conforms to
        /// \(node.kind.protocolType).
        ///
        ///  - Note:  This will incur an existential conversion.
        public func isProtocol(_: \(node.kind.protocolType).Protocol) -> Bool {
          return self.asProtocol(\(node.kind.protocolType).self) != nil
        }
        """
      )

      DeclSyntax(
        """
        /// Return the non-type erased version of this syntax node if it conforms to
        /// \(node.kind.protocolType). Otherwise return nil.
        ///
        ///  - Note:  This will incur an existential conversion.
        public func asProtocol(_: \(node.kind.protocolType).Protocol) -> \(node.kind.protocolType)? {
          return self.asProtocol(SyntaxProtocol.self) as? \(node.kind.protocolType)
        }
        """
      )
    }

    try! StructDeclSyntax(
      """
      \(documentation)\
      \(node.apiAttributes())\
      public struct \(node.kind.syntaxType): \(node.kind.protocolType), SyntaxHashable
      """
    ) {
      DeclSyntax("public let _syntaxNode: Syntax")

      DeclSyntax(
        """
        /// Create a \(raw: node.kind.doccLink) node from a specialized syntax node.
        public init(_ syntax: __shared some \(node.kind.protocolType)) {
          // We know this cast is going to succeed. Go through init(_: SyntaxData)
          // to do a sanity check and verify the kind matches in debug builds and get
          // maximum performance in release builds.
          self = Syntax(syntax).cast(Self.self)
        }
        """
      )

      DeclSyntax(
        """
        /// Create a \(raw: node.kind.doccLink) node from a specialized optional syntax node.
        public init?(_ syntax: __shared (some \(node.kind.protocolType))?) {
          guard let syntax = syntax else { return nil }
          self.init(syntax)
        }
        """
      )

      DeclSyntax(
        """
        public init(fromProtocol syntax: __shared \(node.kind.protocolType)) {
          // We know this cast is going to succeed. Go through init(_: SyntaxData)
          // to do a sanity check and verify the kind matches in debug builds and get
          // maximum performance in release builds.
          self = Syntax(syntax).cast(Self.self)
        }
        """
      )

      DeclSyntax(
        """
        /// Create a \(raw: node.kind.doccLink) node from a specialized optional syntax node.
        public init?(fromProtocol syntax: __shared \(node.kind.protocolType)?) {
          guard let syntax = syntax else { return nil }
          self.init(fromProtocol: syntax)
        }
        """
      )

      try InitializerDeclSyntax("public init?(_ node: __shared some SyntaxProtocol)") {
        try SwitchExprSyntax("switch node.raw.kind") {
          SwitchCaseListSyntax {
            SwitchCaseSyntax(
              label: .case(
                SwitchCaseLabelSyntax {
                  for childNode in SYNTAX_NODES where childNode.base == node.kind {
                    SwitchCaseItemSyntax(
                      pattern: ExpressionPatternSyntax(
                        expression: ExprSyntax(".\(childNode.varOrCaseName)")
                      )
                    )
                  }
                }
              )
            ) {
              ExprSyntax("self._syntaxNode = node._syntaxNode")
            }

            SwitchCaseSyntax("default:") {
              StmtSyntax("return nil")
            }
          }
        }
      }

      DeclSyntax(
        """
        /// Syntax nodes always conform to `\(node.kind.protocolType)`. This API is just
        /// added for consistency.
        ///
        ///  - Note:  This will incur an existential conversion.
        @available(*, deprecated, message: "Expression always evaluates to true")
        public func isProtocol(_: \(node.kind.protocolType).Protocol) -> Bool {
          return true
        }
        """
      )

      DeclSyntax(
        """
        /// Return the non-type erased version of this syntax node.
        ///
        ///  - Note:  This will incur an existential conversion.
        public func asProtocol(_: \(node.kind.protocolType).Protocol) -> \(node.kind.protocolType) {
          return Syntax(self).asProtocol(\(node.kind.protocolType).self)!
        }
        """
      )

      try VariableDeclSyntax("public static var structure: SyntaxNodeStructure") {
        let choices = ArrayExprSyntax {
          for childNode in SYNTAX_NODES where childNode.base == node.kind {
            ArrayElementSyntax(
              leadingTrivia: .newline,
              expression: ExprSyntax(".node(\(childNode.kind.syntaxType).self)")
            )
          }
        }

        StmtSyntax("return .choices(\(choices))")
      }
    }

    leafProtocolDecl(type: node.kind.leafProtocolType, inheritedType: node.kind.protocolType)
    leafProtocolExtension(type: node.kind.leafProtocolType, inheritedType: node.kind.protocolType)
  }

  try! ExtensionDeclSyntax(
    """
    // MARK: - Syntax

    extension Syntax
    """
  ) {
    try VariableDeclSyntax("public static var structure: SyntaxNodeStructure") {
      let choices = ArrayExprSyntax {
        ArrayElementSyntax(
          leadingTrivia: .newline,
          expression: ExprSyntax(".node(TokenSyntax.self)")
        )

        for node in NON_BASE_SYNTAX_NODES {
          ArrayElementSyntax(
            leadingTrivia: .newline,
            expression: ExprSyntax(".node(\(node.kind.syntaxType).self)")
          )
        }
      }

      StmtSyntax("return .choices(\(choices))")
    }
  }

  leafProtocolDecl(type: "_LeafSyntaxNodeProtocol", inheritedType: "SyntaxProtocol")
  leafProtocolExtension(type: "_LeafSyntaxNodeProtocol", inheritedType: "SyntaxProtocol")
}

private func leafProtocolDecl(type: TypeSyntax, inheritedType: TypeSyntax) -> DeclSyntax {
  DeclSyntax(
    """
    /// Protocol that syntax nodes conform to if they don't have any semantic subtypes.
    /// These are syntax nodes that are not considered base nodes for other syntax types.
    ///
    /// Syntax nodes conforming to this protocol have their inherited casting methods
    /// deprecated to prevent incorrect casting.
    public protocol \(type): \(inheritedType) {}
    """
  )
}

private func leafProtocolExtension(type: TypeSyntax, inheritedType: TypeSyntax) -> DeclSyntax {
  DeclSyntax(
    #"""
    extension \#(type) {
      /// Checks if the current leaf syntax node can be cast to a different specified type.
      ///
      /// - Returns: `false` since the leaf node cannot be cast to a different specified type.
      ///
      /// - Note: This method overloads the general `is` method and is marked as deprecated to produce a warning,
      ///         informing the user that the cast will always fail.
      @available(*, deprecated, message: "This cast will always fail")
      public func `is`<S: \#(inheritedType)>(_ syntaxType: S.Type) -> Bool {
        return false
      }

      /// Attempts to cast the current leaf syntax node to a different specified type.
      ///
      /// - Returns: `nil` since the leaf node cannot be cast to a different specified type.
      ///
      /// - Note: This method overloads the general `as` method and is marked as deprecated to produce a warning,
      ///         informing the user that the cast will always fail.
      @available(*, deprecated, message: "This cast will always fail")
      public func `as`<S: \#(inheritedType)>(_ syntaxType: S.Type) -> S? {
        return nil
      }

      /// Force-casts the current leaf syntax node to a different specified type.
      ///
      /// - Returns: This method will always trigger a runtime crash and never return.
      ///
      /// - Note: This method overloads the general `cast` method and is marked as deprecated to produce a warning,
      ///         informing the user that the cast will always fail.
      /// - Warning: Invoking this method will lead to a fatal error.
      @available(*, deprecated, message: "This cast will always fail")
      public func cast<S: \#(inheritedType)>(_ syntaxType: S.Type) -> S {
        fatalError("\(Self.self) cannot be cast to \(S.self)")
      }
    }
    """#
  )
}
