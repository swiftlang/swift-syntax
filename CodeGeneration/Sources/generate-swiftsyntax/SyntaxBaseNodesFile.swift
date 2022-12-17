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
import SwiftSyntaxBuilder
import SyntaxSupport
import Utils

let syntaxBaseNodesFile = SourceFile(leadingTrivia: [.blockComment(generateCopyrightHeader(for: "generate-swiftsyntax"))]) {
  for node in SYNTAX_NODES where node.isBase {
    ProtocolDecl("""
      // MARK: - \(raw: node.name)
      
      /// Protocol to which all `\(raw: node.name)` nodes conform. Extension point to add
      /// common methods to all `\(raw: node.name)` nodes.
      /// DO NOT CONFORM TO THIS PROTOCOL YOURSELF!
      public protocol \(raw: node.name)Protocol: \(raw: node.baseType.baseName)Protocol {}
      """)
    
    ExtensionDecl("public extension Syntax") {
      FunctionDecl("""
        /// Check whether the non-type erased version of this syntax node conforms to
        /// \(raw: node.name)Protocol.
        /// Note that this will incur an existential conversion.
        func isProtocol(_: \(raw: node.name)Protocol.Protocol) -> Bool {
          return self.asProtocol(\(raw: node.name)Protocol.self) != nil
        }
        """)
      
      FunctionDecl("""
        /// Return the non-type erased version of this syntax node if it conforms to
        /// \(raw: node.name)Protocol. Otherwise return nil.
        /// Note that this will incur an existential conversion.
        func asProtocol(_: \(raw: node.name)Protocol.Protocol) -> \(raw: node.name)Protocol? {
          return self.asProtocol(SyntaxProtocol.self) as? \(raw: node.name)Protocol
        }
        """)
    }
    
    StructDecl("""
      \(node.description ?? "")
      public struct \(node.name): \(node.name)Protocol, SyntaxHashable
      """) {
      VariableDecl("public let _syntaxNode: Syntax")
      
      InitializerDecl("""
        /// Create a `\(raw: node.name)` node from a specialized syntax node.
        public init<S: \(raw: node.name)Protocol>(_ syntax: S) {
          // We know this cast is going to succeed. Go through init(_: SyntaxData)
          // to do a sanity check and verify the kind matches in debug builds and get
          // maximum performance in release builds.
          self.init(syntax._syntaxNode.data)
        }
        """)
      
      InitializerDecl("""
        /// Create a `\(raw: node.name)` node from a specialized optional syntax node.
        public init?<S: \(raw: node.name)Protocol>(_ syntax: S?) {
          guard let syntax = syntax else { return nil }
          self.init(syntax)
        }
        """)
      
      InitializerDecl("""
        public init(fromProtocol syntax: \(raw: node.name)Protocol) {
          // We know this cast is going to succeed. Go through init(_: SyntaxData)
          // to do a sanity check and verify the kind matches in debug builds and get
          // maximum performance in release builds.
          self.init(syntax._syntaxNode.data)
        }
        """)
      
      InitializerDecl("""
        /// Create a `\(raw: node.name)` node from a specialized optional syntax node.
        public init?(fromProtocol syntax: \(raw: node.name)Protocol?) {
          guard let syntax = syntax else { return nil }
          self.init(fromProtocol: syntax)
        }
        """)
      
      InitializerDecl("public init?<S: SyntaxProtocol>(_ node: S)") {
        SwitchStmt(expression: MemberAccessExpr("node.raw.kind")) {
          SwitchCaseList {
            SwitchCase(
              label: .case(SwitchCaseLabel {
                for childNode in SYNTAX_NODES where childNode.baseKind == node.syntaxKind {
                  CaseItem(
                    pattern: EnumCasePattern(
                      period: .period,
                      caseName: .identifier(childNode.swiftSyntaxKind))
                  )
                }
              })) {
                Expr("self._syntaxNode = node._syntaxNode")
              }
            
            SwitchCase("default:") {
              ReturnStmt("return nil")
            }
          }
        }
      }
      
      InitializerDecl("""
        /// Creates a `\(node.name)` node from the given `SyntaxData`. This assumes
        /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
        /// is undefined.
        internal init(_ data: SyntaxData)
        """) {
        IfConfigDecl(
          clauses: IfConfigClauseList {
            IfConfigClause(
              poundKeyword: .poundIfKeyword(),
              condition: Expr("DEBUG"),
              elements: IfConfigClauseSyntax.Elements.statements(CodeBlockItemList {
                SwitchStmt(
                  expression: Expr("data.raw.kind")) {
                    SwitchCase(
                      label: .case(SwitchCaseLabel {
                        for childNode in SYNTAX_NODES where childNode.baseKind == node.syntaxKind {
                          CaseItem(
                            pattern: EnumCasePatternSyntax(
                              period: .period,
                              caseName: .identifier(childNode.swiftSyntaxKind))
                          )
                        }
                      })) {
                        BreakStmt()
                      }
                    
                    SwitchCase("default:") {
                      FunctionCallExpr("fatalError(\"Unable to create \(raw: node.name) from \\(data.raw.kind)\")")
                    }
                  }
              })
            )
          }
        )
        
        Expr("self._syntaxNode = Syntax(data)")
      }
      
      FunctionDecl("""
        public func `is`<S: \(raw: node.name)Protocol>(_ syntaxType: S.Type) -> Bool {
          return self.as(syntaxType) != nil
        }
        """)
      
      FunctionDecl("""
        public func `as`<S: \(raw: node.name)Protocol>(_ syntaxType: S.Type) -> S? {
          return S.init(self)
        }
        """)
      
      FunctionDecl("""
        public func cast<S: \(raw: node.name)Protocol>(_ syntaxType: S.Type) -> S {
          return self.as(S.self)!
        }
        """)
      
      FunctionDecl("""
        /// Syntax nodes always conform to `\(raw: node.name)Protocol`. This API is just
        /// added for consistency.
        /// Note that this will incur an existential conversion.
        @available(*, deprecated, message: "Expression always evaluates to true")
        public func isProtocol(_: \(raw: node.name)Protocol.Protocol) -> Bool {
          return true
        }
        """)
      
      FunctionDecl("""
        /// Return the non-type erased version of this syntax node.
        /// Note that this will incur an existential conversion.
        public func asProtocol(_: \(raw: node.name)Protocol.Protocol) -> \(raw: node.name)Protocol {
          return Syntax(self).asProtocol(\(raw: node.name)Protocol.self)!
        }
        """)
      
      
      VariableDecl(
        modifiers: [DeclModifier(name: .public), DeclModifier(name: .static)],
        name: IdentifierPattern("structure"),
        type: TypeAnnotation(
          type: TypeSyntax("SyntaxNodeStructure"))
      ) {
        ReturnStmt(
          expression: FunctionCallExpr(
            callee: MemberAccessExpr(".choices")) {
              TupleExprElement(
                expression: ArrayExprSyntax {
                  for childNode in SYNTAX_NODES where childNode.baseKind == node.syntaxKind {
                    ArrayElement(
                      expression: FunctionCallExpr("\n.node(\(raw: childNode.name).self)")
                    )
                  }
                })
            }
        )
      }
      
      FunctionDecl("""
        public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
          return Syntax(self).childNameForDiagnostics(index)
        }
        """)
    }
    
    ExtensionDecl("""
      extension \(raw: node.name): CustomReflectable {
        /// Reconstructs the real syntax type for this type from the node's kind and
        /// provides a mirror that reflects this type.
        public var customMirror: Mirror {
          return Mirror(reflecting: Syntax(self).asProtocol(SyntaxProtocol.self))
        }
      }
      """)
    
  }
}
