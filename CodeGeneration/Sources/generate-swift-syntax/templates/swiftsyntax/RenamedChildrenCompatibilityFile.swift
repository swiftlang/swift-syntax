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
    var deprecatedMembers = SYNTAX_COMPATIBILITY_LAYER.deprecatedMembers(for: layoutNode)

    try ExtensionDeclSyntax("extension \(layoutNode.type.syntaxBaseName)") {
      for child in deprecatedMembers.vars {
        makeCompatibilityVar(for: child)
        if let addMethod = makeCompatibilityAddMethod(for: child) {
          addMethod
        }
      }

      let renamedName = InitSignature(layoutNode).compoundName
      for signature in deprecatedMembers.inits {
        makeCompatibilityInit(for: signature, renamedName: renamedName)
      }
    }
  }
}

func makeCompatibilityVar(for child: Child) -> DeclSyntax {
  let childType: TypeSyntax =
    child.kind.isNodeChoicesEmpty ? child.syntaxNodeKind.syntaxType : child.syntaxChoicesType
  let type = child.isOptional ? TypeSyntax("\(childType)?") : childType

  // Form the access chain for the current name.
  let childPath = child.newestChild ?? child
  let childPathString = childPath.name
  let childAccess = ExprSyntax(DeclReferenceExprSyntax(baseName: childPath.baseCallName))

  return DeclSyntax(
    """
    @available(*, deprecated, renamed: \(literal: childPathString))
    public var \(child.identifier): \(type) {
      get {
        return \(childAccess)
      }
      set {
        \(childAccess) = newValue
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
    \(signature.generateInitializerDeclHeader())
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
