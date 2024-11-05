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
    try ExtensionDeclSyntax("extension \(layoutNode.type.syntaxBaseName)") {
      for child in layoutNode.children {
        if let deprecatedVarName = child.deprecatedVarName {
          makeCompatibilityVar(for: child, deprecatedVarName: deprecatedVarName)
          if let addMethod = makeCompatibilityAddMethod(for: child) {
            addMethod
          }
        }
      }

      let renamedName = InitSignature(layoutNode).compoundName
      makeCompatibilityInit(for: InitSignature(layoutNode), renamedName: renamedName)
    }
  }
}

func makeCompatibilityVar(for child: Child, deprecatedVarName: TokenSyntax) -> DeclSyntax {
  let childType: TypeSyntax =
    child.kind.isNodeChoicesEmpty ? child.syntaxNodeKind.syntaxType : child.syntaxChoicesType
  let type = child.isOptional ? TypeSyntax("\(childType)?") : childType

  return DeclSyntax(
    """
    @available(*, deprecated, renamed: "\(child.identifier)")
    public var \(deprecatedVarName): \(type) {
      get {
        return \(child.baseCallName)
      }
      set {
        \(child.baseCallName) = newValue
      }
    }
    """
  )
}

func makeCompatibilityAddMethod(for child: Child) -> DeclSyntax? {
  if let childNode = SYNTAX_NODE_MAP[child.syntaxNodeKind]?.collectionNode,
    !child.isUnexpectedNodes,
    case .collection(
      kind: _,
      collectionElementName: let collectionElementName,
      defaultsToEmpty: _,
      deprecatedCollectionElementName: let deprecatedCollectionElementName
    ) = child.kind,
    let deprecatedCollectionElementName
  {
    let childEltType = childNode.collectionElementType.syntaxBaseName

    return DeclSyntax(
      """
      @available(*, deprecated, renamed: "add\(raw: collectionElementName)")
      public func add\(raw: deprecatedCollectionElementName)(_ element: \(childEltType)) -> Self {
        return add\(raw: collectionElementName)(element)
      }
      """
    )
  }

  return nil
}

func makeCompatibilityInit(for signature: InitSignature, renamedName: String) -> InitializerDeclSyntax {
  try! InitializerDeclSyntax(
    """
    @available(*, deprecated, renamed: \(literal: renamedName))
    @_disfavoredOverload
    \(signature.generateInitializerDeclHeader(useDeprecatedChildName: true))
    """
  ) {
    FunctionCallExprSyntax(callee: ExprSyntax("self.init")) {
      LabeledExprSyntax(label: "leadingTrivia", expression: ExprSyntax("leadingTrivia"))

      for argExpr in signature.makeArgumentsToInitializeNewestChildren() {
        argExpr
      }

      LabeledExprSyntax(label: "trailingTrivia", expression: ExprSyntax("trailingTrivia"))
    }
  }
}
