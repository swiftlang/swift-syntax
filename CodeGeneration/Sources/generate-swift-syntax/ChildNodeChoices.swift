//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax
import SwiftSyntaxBuilder
import SyntaxSupport

struct ChildNodeChoices {
  @dynamicMemberLookup
  struct Choice {
    var node: any NodeChoiceConvertible

    subscript<T>(dynamicMember keyPath: KeyPath<any NodeChoiceConvertible, T>) -> T {
      self.node[keyPath: keyPath]
    }
  }

  let name: TypeSyntax
  let choices: [Choice]

  func isKindOfFuncDecl(parameterName: TokenSyntax, parameterType: TypeSyntax) -> FunctionDeclSyntax {
    try! FunctionDeclSyntax("public static func isKindOf(_ \(parameterName): \(parameterType)) -> Bool") {
      ExprSyntax(
        "\(raw: self.choices.map { "\($0.syntaxType).isKindOf(\(parameterName))" }.joined(separator: " || "))"
      )
    }
  }

  func syntaxGetter(propertyName: TokenSyntax, propertyType: TypeSyntax) -> VariableDeclSyntax {
    try! VariableDeclSyntax("public var \(propertyName.declNameOrVarCallName): \(propertyType)") {
      try! SwitchExprSyntax("switch self") {
        for choice in self.choices {
          SwitchCaseSyntax("case .\(choice.enumCaseCallName)(let node):") {
            StmtSyntax("return node.\(propertyName.nonVarCallNameOrLabelDeclName)")
          }
        }
      }
    }
  }

  func syntaxInitDecl(inputType: TypeSyntax) -> InitializerDeclSyntax {
    try! InitializerDeclSyntax("public init?(_ node: \(inputType))") {
      self.choices.ifExpr
    }
  }
}

extension Node {
  func childrenNodeChoices(forRaw: Bool = false) -> [ChildNodeChoices] {
    if let node = self.layoutNode {
      return node.children.compactMap { child in
        switch child.kind {
        case .nodeChoices(let choices):
          return ChildNodeChoices(
            name: child.syntaxChoicesType,
            choices: choices.map { ChildNodeChoices.Choice(node: forRaw ? $0.raw : $0) }
          )
        default:
          return nil
        }
      }
    } else if let node = self.collectionNode, node.elementChoices.count > 1 {
      return [
        ChildNodeChoices(
          name: "Element",
          choices: node.elementChoices.map {
            ChildNodeChoices.Choice(node: forRaw ? $0.node!.raw : $0.node!)
          }
        )
      ]
    } else {
      return []
    }
  }
}

extension ChildNodeChoices.Choice {
  var enumCaseDecl: EnumCaseDeclSyntax {
    try! EnumCaseDeclSyntax(
      """
      \(self.documentation)\
      \(self.experimentalDocNote)\
      \(self.apiAttributes)\
      case \(self.enumCaseDeclName)(\(self.syntaxType))
      """
    )
  }

  func baseTypeInitDecl(hasArgumentName: Bool) -> InitializerDeclSyntax? {
    guard self.isBaseType else {
      return nil
    }
    let firstName: SyntaxNodeString
    let secondName: TokenSyntax
    if hasArgumentName {
      firstName = ""
      secondName = self.labelDeclName
    } else {
      firstName = "_ "
      secondName = "node"
    }
    return try! InitializerDeclSyntax(
      """
      \(self.experimentalDocNote)\
      \(self.apiAttributes)\
      public init(\(firstName)\(secondName): some \(self.protocolType))
      """
    ) {
      ExprSyntax(
        "self = .\(self.memberCallName)(\(self.syntaxType)(\(secondName)))"
      )
    }
  }

  var concreteTypeInitDecl: InitializerDeclSyntax {
    try! InitializerDeclSyntax(
      """
      \(self.experimentalDocNote)\
      \(self.apiAttributes)\
      public init(_ node: \(self.syntaxType))
      """
    ) {
      ExprSyntax("self = .\(self.memberCallName)(node)")
    }
  }
}

private extension Array where Element == ChildNodeChoices.Choice {
  var ifExpr: IfExprSyntax {
    precondition(!self.isEmpty)
    var result = try! IfExprSyntax(
      "if let node = node.as(\(self.last!.syntaxType).self)",
      bodyBuilder: {
        ExprSyntax("self = .\(self.last!.memberCallName)(node)")
      },
      else: {
        ["return nil"]
      }
    )
    for choice in self.reversed().dropFirst() {
      result = try! IfExprSyntax(
        "if let node = node.as(\(choice.syntaxType).self)",
        bodyBuilder: {
          ExprSyntax("self = .\(choice.memberCallName)(node)")
        },
        elseIf: result
      )
    }
    return result
  }
}
