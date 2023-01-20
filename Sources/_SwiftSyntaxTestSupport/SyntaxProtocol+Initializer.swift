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

import SwiftBasicFormat
@_spi(RawSyntax) import SwiftSyntax
import SwiftSyntaxBuilder

private class InitializerExprFormat: BasicFormat {
  override var indentation: TriviaPiece { return .spaces(indentationLevel * 2) }

  private func formatChildrenSeparatedByNewline<SyntaxType: SyntaxProtocol>(children: SyntaxChildren, elementType: SyntaxType.Type) -> [SyntaxType] {
    indentationLevel += 1
    var formattedChildren = children.map {
      self.visit($0).as(SyntaxType.self)!
    }
    formattedChildren = formattedChildren.map {
      if $0.leadingTrivia?.first?.isNewline == true {
        return $0
      } else {
        return $0.with(\.leadingTrivia, indentedNewline + ($0.leadingTrivia ?? []))
      }
    }
    indentationLevel -= 1
    if !formattedChildren.isEmpty {
      formattedChildren[formattedChildren.count - 1] = formattedChildren[formattedChildren.count - 1].with(\.trailingTrivia, indentedNewline)
    }
    return formattedChildren
  }

  override func visit(_ node: TupleExprElementListSyntax) -> TupleExprElementListSyntax {
    let children = node.children(viewMode: .all)
    // If the function only takes a single argument, display it on the same line
    if let callee = node.parent?.as(FunctionCallExprSyntax.self)?.calledExpression.as(MemberAccessExprSyntax.self), callee.base == nil {
      // This is a constructor for tokens. Write them on a single line
      return super.visit(node)
    }
    if children.count > 1 {
      return TupleExprElementListSyntax(formatChildrenSeparatedByNewline(children: children, elementType: TupleExprElementSyntax.self))
    } else {
      return super.visit(node)
    }
  }

  override func visit(_ node: ArrayElementListSyntax) -> ArrayElementListSyntax {
    let children = node.children(viewMode: .all)
    // Short array literals are presented on one line, list each element on a different line.
    if node.description.count > 30 {
      return ArrayElementListSyntax(formatChildrenSeparatedByNewline(children: children, elementType: ArrayElementSyntax.self))
    } else {
      return super.visit(node)
    }
  }
}

private extension TriviaPiece {
  var initializerExpr: ExprSyntax {
    let (label, value) = Mirror(reflecting: self).children.first!
    let arg: ExprSyntax
    switch value {
    case let value as String:
      arg = ExprSyntax(literal: value)
    case let value as Int:
      arg = ExprSyntax(literal: value)
    default:
      fatalError("Unknown associated value type")
    }
    return ExprSyntax(
      FunctionCallExprSyntax(callee: MemberAccessExprSyntax(name: label!)) {
        TupleExprElementSyntax(expression: arg)
      }
    )
  }
}

private extension Trivia {
  var initializerExpr: ExprSyntax {
    if pieces.count == 1 {
      switch pieces.first {
      case .spaces(1):
        return ExprSyntax(MemberAccessExprSyntax(name: "space"))
      case .newlines(1):
        return ExprSyntax(MemberAccessExprSyntax(name: "newline"))
      default:
        break
      }
    }
    return ExprSyntax(
      ArrayExprSyntax {
        for piece in pieces {
          ArrayElementSyntax(expression: piece.initializerExpr)
        }
      }
    )
  }
}

extension SyntaxProtocol {
  /// Returns a Swift expression that, when parsed, constructs this syntax node
  /// (or at least an expression that's very close to constructing this node, the addition of a few manual upcast by hand is still needed).
  /// The intended use case for this is to print a syntax tree and create a substructure assertion from the generated expression.
  /// When `includeTrivia` is set to `false`, the token's leading and trailing trivia will not be included in the generated expression.
  public func debugInitCall(includeTrivia: Bool = true) -> String {
    return self.debugInitCallExpr(includeTrivia: includeTrivia).formatted(using: InitializerExprFormat()).description
  }

  private func debugInitCallExpr(includeTrivia: Bool) -> ExprSyntax {
    let mirror = Mirror(reflecting: self)
    if self.isCollection {
      let typeName = String(describing: type(of: self))
      return ExprSyntax(
        FunctionCallExprSyntax(callee: IdentifierExprSyntax(identifier: .identifier(typeName))) {
          TupleExprElementSyntax(
            expression: ArrayExprSyntax {
              for child in mirror.children {
                let value = child.value as! SyntaxProtocol?
                ArrayElementSyntax(expression: value?.debugInitCallExpr(includeTrivia: includeTrivia) ?? ExprSyntax(NilLiteralExprSyntax()))
              }
            }
          )
        }
      )
    } else if let token = Syntax(self).as(TokenSyntax.self) {
      let tokenKind = token.tokenKind
      let tokenInitializerName: String
      let tokenKindArgument: ExprSyntax?
      if tokenKind.isLexerClassifiedKeyword || tokenKind == .eof {
        tokenInitializerName = String(describing: tokenKind)
        tokenKindArgument = nil
      } else if case .keyword(let keyword) = tokenKind {
        tokenInitializerName = "keyword"
        tokenKindArgument = ExprSyntax(MemberAccessExprSyntax(name: String(describing: keyword)))
      } else if tokenKind.decomposeToRaw().rawKind.defaultText != nil {
        tokenInitializerName = "\(String(describing: tokenKind))Token"
        tokenKindArgument = nil
      } else {
        let tokenKindStr = String(describing: tokenKind)
        tokenInitializerName = String(tokenKindStr[..<tokenKindStr.firstIndex(of: "(")!])
        tokenKindArgument = ExprSyntax(StringLiteralExprSyntax(content: token.text))
      }
      return ExprSyntax(
        FunctionCallExprSyntax(callee: MemberAccessExprSyntax(name: tokenInitializerName)) {
          if let tokenKindArgument = tokenKindArgument {
            TupleExprElementSyntax(expression: tokenKindArgument)
          }
          if includeTrivia && !token.leadingTrivia.isEmpty {
            TupleExprElementSyntax(
              label: .identifier("leadingTrivia"),
              colon: .colonToken(),
              expression: token.leadingTrivia.initializerExpr
            )
          }
          if includeTrivia && !token.trailingTrivia.isEmpty {
            TupleExprElementSyntax(
              label: .identifier("trailingTrivia"),
              colon: .colonToken(),
              expression: token.trailingTrivia.initializerExpr
            )
          }
          if token.presence != .present {
            TupleExprElementSyntax(
              label: .identifier("presence"),
              colon: .colonToken(),
              expression: MemberAccessExprSyntax(name: "missing")
            )
          }
        }
      )
    } else {
      let typeName = String(describing: type(of: self))
      return ExprSyntax(
        FunctionCallExprSyntax(callee: IdentifierExprSyntax(identifier: .identifier(typeName))) {
          for child in mirror.children {
            let label = child.label!
            let value = child.value as! SyntaxProtocol?
            let isUnexpected = label.hasPrefix("unexpected")
            if !isUnexpected || value != nil {
              TupleExprElementSyntax(
                label: isUnexpected ? nil : .identifier(label),
                colon: isUnexpected ? nil : .colonToken(),
                expression: value?.debugInitCallExpr(includeTrivia: includeTrivia) ?? ExprSyntax(NilLiteralExprSyntax())
              )
            }
          }
        }
      )
    }
  }
}
