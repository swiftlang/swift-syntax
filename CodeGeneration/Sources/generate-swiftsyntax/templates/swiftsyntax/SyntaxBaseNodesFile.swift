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
    DeclSyntax(
      """
      // MARK: - \(node.kind.syntaxType)

      /// Protocol to which all `\(node.kind.syntaxType)` nodes conform. Extension point to add
      /// common methods to all `\(node.kind.syntaxType)` nodes.
      /// DO NOT CONFORM TO THIS PROTOCOL YOURSELF!
      public protocol \(node.kind.protocolType): \(raw: node.base.protocolType) {}
      """
    )

    try! ExtensionDeclSyntax("public extension Syntax") {
      DeclSyntax(
        """
        /// Check whether the non-type erased version of this syntax node conforms to
        /// \(node.kind.protocolType).
        /// Note that this will incur an existential conversion.
        func isProtocol(_: \(node.kind.protocolType).Protocol) -> Bool {
          return self.asProtocol(\(node.kind.protocolType).self) != nil
        }
        """
      )

      DeclSyntax(
        """
        /// Return the non-type erased version of this syntax node if it conforms to
        /// \(node.kind.protocolType). Otherwise return nil.
        /// Note that this will incur an existential conversion.
        func asProtocol(_: \(node.kind.protocolType).Protocol) -> \(node.kind.protocolType)? {
          return self.asProtocol(SyntaxProtocol.self) as? \(node.kind.protocolType)
        }
        """
      )
    }

    try! StructDeclSyntax(
      """
      \(raw: node.documentation)
      public struct \(node.kind.syntaxType): \(node.kind.protocolType), SyntaxHashable
      """
    ) {
      DeclSyntax("public let _syntaxNode: Syntax")

      DeclSyntax(
        """
        /// Create a `\(node.kind.syntaxType)` node from a specialized syntax node.
        public init(_ syntax: some \(node.kind.protocolType)) {
          // We know this cast is going to succeed. Go through init(_: SyntaxData)
          // to do a sanity check and verify the kind matches in debug builds and get
          // maximum performance in release builds.
          self.init(syntax._syntaxNode.data)
        }
        """
      )

      DeclSyntax(
        """
        /// Create a `\(node.kind.syntaxType)` node from a specialized optional syntax node.
        public init?(_ syntax: (some \(node.kind.protocolType))?) {
          guard let syntax = syntax else { return nil }
          self.init(syntax)
        }
        """
      )

      DeclSyntax(
        """
        public init(fromProtocol syntax: \(node.kind.protocolType)) {
          // We know this cast is going to succeed. Go through init(_: SyntaxData)
          // to do a sanity check and verify the kind matches in debug builds and get
          // maximum performance in release builds.
          self.init(syntax._syntaxNode.data)
        }
        """
      )

      DeclSyntax(
        """
        /// Create a `\(node.kind.syntaxType)` node from a specialized optional syntax node.
        public init?(fromProtocol syntax: \(node.kind.protocolType)?) {
          guard let syntax = syntax else { return nil }
          self.init(fromProtocol: syntax)
        }
        """
      )

      try InitializerDeclSyntax("public init?(_ node: some SyntaxProtocol)") {
        try SwitchExprSyntax("switch node.raw.kind") {
          SwitchCaseListSyntax {
            SwitchCaseSyntax(
              label: .case(
                SwitchCaseLabelSyntax {
                  for childNode in SYNTAX_NODES where childNode.base == node.kind {
                    CaseItemSyntax(
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

      try InitializerDeclSyntax(
        """
        /// Creates a `\(node.kind.syntaxType)` node from the given `SyntaxData`. This assumes
        /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
        /// is undefined.
        internal init(_ data: SyntaxData)
        """
      ) {
        CodeBlockItemListSyntax {
          try! SwitchExprSyntax("switch data.raw.kind") {
            SwitchCaseSyntax(
              label: .case(
                SwitchCaseLabelSyntax {
                  for childNode in SYNTAX_NODES where childNode.base == node.kind {
                    CaseItemSyntax(
                      pattern: ExpressionPatternSyntax(
                        expression: ExprSyntax(".\(childNode.varOrCaseName)")
                      )
                    )
                  }
                }
              )
            ) {
              BreakStmtSyntax()
            }

            SwitchCaseSyntax("default:") {
              ExprSyntax("preconditionFailure(\"Unable to create \(node.kind.syntaxType) from \\(data.raw.kind)\")")
            }
          }
        }

        ExprSyntax("self._syntaxNode = Syntax(data)")
      }

      DeclSyntax(
        """
        public func `is`<S: \(node.kind.protocolType)>(_ syntaxType: S.Type) -> Bool {
          return self.as(syntaxType) != nil
        }
        """
      )

      DeclSyntax(
        """
        public func `as`<S: \(node.kind.protocolType)>(_ syntaxType: S.Type) -> S? {
          return S.init(self)
        }
        """
      )

      DeclSyntax(
        """
        public func cast<S: \(node.kind.protocolType)>(_ syntaxType: S.Type) -> S {
          return self.as(S.self)!
        }
        """
      )

      DeclSyntax(
        """
        /// Syntax nodes always conform to `\(node.kind.protocolType)`. This API is just
        /// added for consistency.
        /// Note that this will incur an existential conversion.
        @available(*, deprecated, message: "Expression always evaluates to true")
        public func isProtocol(_: \(raw: node.kind.protocolType).Protocol) -> Bool {
          return true
        }
        """
      )

      DeclSyntax(
        """
        /// Return the non-type erased version of this syntax node.
        /// Note that this will incur an existential conversion.
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
  }

  try! ExtensionDeclSyntax("extension Syntax") {
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

}
