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
        return $0.withLeadingTrivia(indentedNewline + ($0.leadingTrivia ?? []))
      }
    }
    indentationLevel -= 1
    if !formattedChildren.isEmpty {
      formattedChildren[formattedChildren.count - 1] = formattedChildren[formattedChildren.count - 1].withTrailingTrivia(indentedNewline)
    }
    return formattedChildren
  }

  override func visit(_ node: TupleExprElementListSyntax) -> TupleExprElementListSyntax {
    let children = node.children(viewMode: .all)
    // If the function only takes a single argument, display it on the same line
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
    let arg: Expr
    switch value {
    case let value as String:
      arg = Expr(literal: value)
    case let value as Int:
      arg = Expr(literal: value)
    default:
      fatalError("Unknown associated value type")
    }
    return ExprSyntax(
      FunctionCallExpr(callee: MemberAccessExpr(name: label!)) {
        TupleExprElement(expression: arg)
      }
    )
  }
}

private extension Trivia {
  var initializerExpr: ExprSyntax {
    if pieces.count == 1 {
      switch pieces.first {
      case .spaces(1):
        return ExprSyntax(MemberAccessExpr(name: "space"))
      case .newlines(1):
        return ExprSyntax(MemberAccessExpr(name: "newline"))
      default:
        break
      }
    }
    return ExprSyntax(
      ArrayExpr {
        for piece in pieces {
          ArrayElement(expression: piece.initializerExpr)
        }
      }
    )
  }
}

extension SyntaxProtocol {
  /// Returns a Swift expression that, when parsed, constructs this syntax node
  /// (or at least an expression that's very close to constructing this node, the addition of a few manual upcast by hand is still needed).
  /// The intended use case for this is to print a syntax tree and create a substructure assertion from the generated expression.
  public var debugInitCall: String {
    return self.debugInitCallExpr.formatted(using: InitializerExprFormat()).description
  }

  private var debugInitCallExpr: ExprSyntax {
    let mirror = Mirror(reflecting: self)
    if self.isCollection {
      let typeName = String(describing: type(of: self))
      return ExprSyntax(
        FunctionCallExpr(callee: IdentifierExpr(identifier: .identifier(typeName))) {
          TupleExprElement(
            expression: ArrayExpr {
              for child in mirror.children {
                let value = child.value as! SyntaxProtocol?
                ArrayElement(expression: value?.debugInitCallExpr ?? ExprSyntax(NilLiteralExpr()))
              }
            }
          )
        }
      )
    } else if let token = Syntax(self).as(TokenSyntax.self) {
      let tokenKind = token.tokenKind
      let tokenInitializerName: String
      let requiresExplicitText: Bool
      if tokenKind.isKeyword || tokenKind == .eof {
        tokenInitializerName = String(describing: tokenKind)
        requiresExplicitText = false
      } else if tokenKind.decomposeToRaw().rawKind.defaultText != nil {
        tokenInitializerName = "\(String(describing: tokenKind))Token"
        requiresExplicitText = false
      } else {
        let tokenKindStr = String(describing: tokenKind)
        tokenInitializerName = String(tokenKindStr[..<tokenKindStr.firstIndex(of: "(")!])
        requiresExplicitText = true
      }
      return ExprSyntax(
        FunctionCallExpr(callee: MemberAccessExpr(name: tokenInitializerName)) {
          if requiresExplicitText {
            TupleExprElement(
              expression: StringLiteralExpr(content: token.text)
            )
          }
          if !token.leadingTrivia.isEmpty {
            TupleExprElement(
              label: .identifier("leadingTrivia"),
              colon: .colon,
              expression: token.leadingTrivia.initializerExpr
            )
          }
          if !token.trailingTrivia.isEmpty {
            TupleExprElement(
              label: .identifier("trailingTrivia"),
              colon: .colon,
              expression: token.trailingTrivia.initializerExpr
            )
          }
          if token.presence != .present {
            TupleExprElement(
              label: .identifier("presence"),
              colon: .colon,
              expression: MemberAccessExpr(name: "missing")
            )
          }
        }
      )
    } else {
      let typeName = String(describing: type(of: self))
      return ExprSyntax(
        FunctionCallExpr(callee: IdentifierExpr(identifier: .identifier(typeName))) {
          for child in mirror.children {
            let label = child.label!
            let value = child.value as! SyntaxProtocol?
            let isUnexpected = label.hasPrefix("unexpected")
            if !isUnexpected || value != nil {
              TupleExprElement(
                label: isUnexpected ? nil : .identifier(label),
                colon: isUnexpected ? nil : .colon,
                expression: value?.debugInitCallExpr ?? ExprSyntax(NilLiteralExpr())
              )
            }
          }
        }
      )
    }
  }
}
