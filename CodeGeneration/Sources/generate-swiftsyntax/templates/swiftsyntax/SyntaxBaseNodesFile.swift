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
  for node in SYNTAX_NODES where node.isBase {
    DeclSyntax(
      """
      // MARK: - \(raw: node.name)

      /// Protocol to which all `\(raw: node.name)` nodes conform. Extension point to add
      /// common methods to all `\(raw: node.name)` nodes.
      /// DO NOT CONFORM TO THIS PROTOCOL YOURSELF!
      public protocol \(raw: node.name)Protocol: \(raw: node.baseType.baseName)Protocol {}
      """
    )

    try! ExtensionDeclSyntax("public extension Syntax") {
      DeclSyntax(
        """
        /// Check whether the non-type erased version of this syntax node conforms to
        /// \(raw: node.name)Protocol.
        /// Note that this will incur an existential conversion.
        func isProtocol(_: \(raw: node.name)Protocol.Protocol) -> Bool {
          return self.asProtocol(\(raw: node.name)Protocol.self) != nil
        }
        """
      )

      DeclSyntax(
        """
        /// Return the non-type erased version of this syntax node if it conforms to
        /// \(raw: node.name)Protocol. Otherwise return nil.
        /// Note that this will incur an existential conversion.
        func asProtocol(_: \(raw: node.name)Protocol.Protocol) -> \(raw: node.name)Protocol? {
          return self.asProtocol(SyntaxProtocol.self) as? \(raw: node.name)Protocol
        }
        """
      )
    }

    try! StructDeclSyntax(
      """
      \(raw: node.description ?? "")
      public struct \(raw: node.name): \(raw: node.name)Protocol, SyntaxHashable
      """
    ) {
      DeclSyntax("public let _syntaxNode: Syntax")

      DeclSyntax(
        """
        /// Create a `\(raw: node.name)` node from a specialized syntax node.
        public init<S: \(raw: node.name)Protocol>(_ syntax: S) {
          // We know this cast is going to succeed. Go through init(_: SyntaxData)
          // to do a sanity check and verify the kind matches in debug builds and get
          // maximum performance in release builds.
          self.init(syntax._syntaxNode.data)
        }
        """
      )

      DeclSyntax(
        """
        /// Create a `\(raw: node.name)` node from a specialized optional syntax node.
        public init?<S: \(raw: node.name)Protocol>(_ syntax: S?) {
          guard let syntax = syntax else { return nil }
          self.init(syntax)
        }
        """
      )

      DeclSyntax(
        """
        public init(fromProtocol syntax: \(raw: node.name)Protocol) {
          // We know this cast is going to succeed. Go through init(_: SyntaxData)
          // to do a sanity check and verify the kind matches in debug builds and get
          // maximum performance in release builds.
          self.init(syntax._syntaxNode.data)
        }
        """
      )

      DeclSyntax(
        """
        /// Create a `\(raw: node.name)` node from a specialized optional syntax node.
        public init?(fromProtocol syntax: \(raw: node.name)Protocol?) {
          guard let syntax = syntax else { return nil }
          self.init(fromProtocol: syntax)
        }
        """
      )

      try InitializerDeclSyntax("public init?<S: SyntaxProtocol>(_ node: S)") {
        try SwitchExprSyntax("switch node.raw.kind") {
          SwitchCaseListSyntax {
            SwitchCaseSyntax(
              label: .case(
                SwitchCaseLabelSyntax {
                  for childNode in SYNTAX_NODES where childNode.baseKind == node.syntaxKind {
                    CaseItemSyntax(
                      pattern: ExpressionPatternSyntax(
                        expression: ExprSyntax(".\(raw: childNode.swiftSyntaxKind)")
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
        /// Creates a `\(raw: node.name)` node from the given `SyntaxData`. This assumes
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
                  for childNode in SYNTAX_NODES where childNode.baseKind == node.syntaxKind {
                    CaseItemSyntax(
                      pattern: ExpressionPatternSyntax(
                        expression: ExprSyntax(".\(raw: childNode.swiftSyntaxKind)")
                      )
                    )
                  }
                }
              )
            ) {
              BreakStmtSyntax()
            }

            SwitchCaseSyntax("default:") {
              ExprSyntax("preconditionFailure(\"Unable to create \(raw: node.name) from \\(data.raw.kind)\")")
            }
          }
        }

        ExprSyntax("self._syntaxNode = Syntax(data)")
      }

      DeclSyntax(
        """
        public func `is`<S: \(raw: node.name)Protocol>(_ syntaxType: S.Type) -> Bool {
          return self.as(syntaxType) != nil
        }
        """
      )

      DeclSyntax(
        """
        public func `as`<S: \(raw: node.name)Protocol>(_ syntaxType: S.Type) -> S? {
          return S.init(self)
        }
        """
      )

      DeclSyntax(
        """
        public func cast<S: \(raw: node.name)Protocol>(_ syntaxType: S.Type) -> S {
          return self.as(S.self)!
        }
        """
      )

      DeclSyntax(
        """
        /// Syntax nodes always conform to `\(raw: node.name)Protocol`. This API is just
        /// added for consistency.
        /// Note that this will incur an existential conversion.
        @available(*, deprecated, message: "Expression always evaluates to true")
        public func isProtocol(_: \(raw: node.name)Protocol.Protocol) -> Bool {
          return true
        }
        """
      )

      DeclSyntax(
        """
        /// Return the non-type erased version of this syntax node.
        /// Note that this will incur an existential conversion.
        public func asProtocol(_: \(raw: node.name)Protocol.Protocol) -> \(raw: node.name)Protocol {
          return Syntax(self).asProtocol(\(raw: node.name)Protocol.self)!
        }
        """
      )

      try VariableDeclSyntax("public static var structure: SyntaxNodeStructure") {
        let choices = ArrayExprSyntax {
          for childNode in SYNTAX_NODES where childNode.baseKind == node.syntaxKind {
            ArrayElementSyntax(
              leadingTrivia: .newline,
              expression: ExprSyntax(".node(\(raw: childNode.name).self)")
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
            expression: ExprSyntax(".node(\(raw: node.name).self)")
          )
        }
      }

      StmtSyntax("return .choices(\(choices))")
    }
  }

}
