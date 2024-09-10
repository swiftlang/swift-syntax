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
    try ExtensionDeclSyntax("extension \(layoutNode.syntaxType)") {
      for child in layoutNode.children {
        if let deprecatedVarName = child.deprecatedVarName {
          DeclSyntax(
            """
            @available(*, deprecated, renamed: "\(child.identifier)")
            public var \(deprecatedVarName): \(child.actualType) {
              get {
                return \(child.baseCallName)
              }
              set {
                \(child.baseCallName) = newValue
              }
            }
            """
          )
          if let childNode = child.node?.collectionNode,
            !child.isUnexpectedNodes,
            case .collection(
              kind: _,
              collectionElementName: let collectionElementName,
              defaultsToEmpty: _,
              deprecatedCollectionElementName: let deprecatedCollectionElementName
            ) = child.kind,
            let deprecatedCollectionElementName
          {
            let childEltType = childNode.collectionElementType.syntaxType

            DeclSyntax(
              """
              @available(*, deprecated, renamed: "add\(raw: collectionElementName)")
              public func add\(raw: deprecatedCollectionElementName)(_ element: \(childEltType)) -> \(layoutNode.actualType) {
                return add\(raw: collectionElementName)(element)
              }
              """
            )
          }
        }
      }

      let deprecatedNames = layoutNode.children
        .filter { !$0.isUnexpectedNodes && $0.hasDeprecatedName }
        .map { $0.identifier.description }
        .joined(separator: ", ")

      let renamedArguments =
        layoutNode.children.map { child in
          if child.isUnexpectedNodes {
            return "_:"
          } else {
            return "\(child.labelDeclName):"
          }
        }.joined(separator: "")

      let renamedName = "\(layoutNode.syntaxType)(leadingTrivia:\(renamedArguments)trailingTrivia:)"

      try! InitializerDeclSyntax(
        """
        @available(*, deprecated, renamed: \(literal: renamedName))
        @_disfavoredOverload
        \(layoutNode.generateInitializerDeclHeader(useDeprecatedChildName: true))
        """
      ) {
        FunctionCallExprSyntax(callee: ExprSyntax("self.init")) {
          LabeledExprSyntax(label: "leadingTrivia", expression: ExprSyntax("leadingTrivia"))
          for child in layoutNode.children {
            if child.isUnexpectedNodes {
              LabeledExprSyntax(expression: ExprSyntax("\(child.deprecatedVarName ?? child.baseCallName)"))
            } else {
              LabeledExprSyntax(
                label: child.labelDeclName,
                colon: .colonToken(),
                expression: DeclReferenceExprSyntax(baseName: child.deprecatedVarName ?? child.baseCallName)
              )
            }
          }
          LabeledExprSyntax(label: "trailingTrivia", expression: ExprSyntax("trailingTrivia"))
        }
      }
    }
  }
}
