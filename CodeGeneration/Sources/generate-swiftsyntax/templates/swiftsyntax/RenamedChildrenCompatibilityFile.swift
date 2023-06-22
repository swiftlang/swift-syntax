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

let renamedChildrenCompatibilityFile = try! SourceFileSyntax(leadingTrivia: copyrightHeader) {
  for layoutNode in SYNTAX_NODES.compactMap(\.layoutNode).filter({ $0.children.hasDeprecatedChild }) {
    try ExtensionDeclSyntax("extension \(raw: layoutNode.type.syntaxBaseName)") {
      for child in layoutNode.children {
        if let deprecatedVarName = child.deprecatedVarName {
          let childType: TypeSyntax = child.kind.isNodeChoicesEmpty ? child.syntaxNodeKind.syntaxType : "\(raw: child.name)"
          let type = child.isOptional ? TypeSyntax("\(raw: childType)?") : TypeSyntax("\(raw: childType)")

          DeclSyntax(
            """
            @available(*, deprecated, renamed: "\(raw: child.varName)")
            public var \(raw: deprecatedVarName): \(raw: type) {
              get {
                return \(raw: child.varName)
              }
              set {
                \(raw: child.varName) = newValue
              }
            }
            """
          )
          if let childNode = SYNTAX_NODE_MAP[child.syntaxNodeKind]?.collectionNode,
            !child.isUnexpectedNodes,
            case .collection(_, let collectionElementName, let deprecatedCollectionElementName) = child.kind,
            let deprecatedCollectionElementName
          {
            let childEltType = childNode.collectionElementType.syntaxBaseName

            DeclSyntax(
              """
              @available(*, deprecated, renamed: "add\(raw: collectionElementName)")
              public func add\(raw: deprecatedCollectionElementName)(_ element: \(raw: childEltType)) -> \(raw: layoutNode.kind.syntaxType) {
                return add\(raw: collectionElementName)(element)
              }
              """
            )
          }
        }
      }

      let deprecatedNames = layoutNode.children
        .filter { !$0.isUnexpectedNodes }
        .compactMap { $0.deprecatedName?.withFirstCharacterLowercased }
        .joined(separator: ", ")

      try! InitializerDeclSyntax(
        """
        @available(*, deprecated, message: "Use an initializer with \(raw: deprecatedNames) argument(s).")
        @_disfavoredOverload
        \(layoutNode.generateInitializerDeclHeader(useDeprecatedChildName: true))
        """
      ) {
        FunctionCallExprSyntax(callee: ExprSyntax("self.init")) {
          TupleExprElementSyntax(label: "leadingTrivia", expression: ExprSyntax("leadingTrivia"))
          for child in layoutNode.children {
            if child.isUnexpectedNodes {
              TupleExprElementSyntax(expression: ExprSyntax("\(raw: child.deprecatedVarName ?? child.varName)"))
            } else {
              TupleExprElementSyntax(label: "\(child.varName)", expression: ExprSyntax("\(raw: child.deprecatedVarName ?? child.varName)"))
            }
          }
          TupleExprElementSyntax(label: "trailingTrivia", expression: ExprSyntax("trailingTrivia"))
        }
      }
    }
  }
}
