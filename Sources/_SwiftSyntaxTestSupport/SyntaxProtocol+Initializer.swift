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

#if swift(>=6)
import SwiftBasicFormat
@_spi(Testing) import SwiftParser
@_spi(RawSyntax) public import SwiftSyntax
import SwiftSyntaxBuilder
#else
import SwiftBasicFormat
@_spi(Testing) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax
import SwiftSyntaxBuilder
#endif

private class InitializerExprFormat: BasicFormat {
  public init() {
    super.init(indentationWidth: .spaces(2))
  }

  private func formatChildrenSeparatedByNewline<SyntaxType: SyntaxProtocol>(children: SyntaxChildren, elementType: SyntaxType.Type) -> [SyntaxType] {
    increaseIndentationLevel()
    var formattedChildren = children.map {
      self.rewrite($0.cast(SyntaxType.self)).cast(SyntaxType.self)
    }
    formattedChildren = formattedChildren.map {
      if $0.leadingTrivia.first?.isNewline == true {
        return $0
      } else {
        return $0.with(\.leadingTrivia, .newline + currentIndentationLevel + $0.leadingTrivia)
      }
    }
    decreaseIndentationLevel()
    if !formattedChildren.isEmpty {
      formattedChildren[formattedChildren.count - 1] = formattedChildren[formattedChildren.count - 1].with(\.trailingTrivia, .newline + currentIndentationLevel)
    }
    return formattedChildren
  }

  override func visit(_ node: LabeledExprListSyntax) -> LabeledExprListSyntax {
    let children = node.children(viewMode: .all)
    // If the function only takes a single argument, display it on the same line
    if let callee = node.parent?.as(FunctionCallExprSyntax.self)?.calledExpression.as(MemberAccessExprSyntax.self), callee.base == nil {
      // This is a constructor for tokens. Write them on a single line
      return super.visit(node)
    }
    if children.count > 1 {
      return LabeledExprListSyntax(formatChildrenSeparatedByNewline(children: children, elementType: LabeledExprSyntax.self))
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
      FunctionCallExprSyntax(callee: ExprSyntax(".\(raw: label!)")) {
        LabeledExprSyntax(expression: arg)
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
  ///
  /// - Warning: This is only designed for use in the debugger. Do not call it outside of the debugger.
  @available(*, deprecated, message: "For use in debugger only")
  public func debugInitCall(includeTrivia: Bool = true) -> String {
    return self.debugInitCallExpr(includeTrivia: includeTrivia).formatted(using: InitializerExprFormat()).description
  }

  private func debugInitCallExpr(includeTrivia: Bool) -> ExprSyntax {
    if type(of: self) != self.syntaxNodeType {
      let nestedInitCall = Syntax(self).asProtocol(SyntaxProtocol.self).debugInitCallExpr(includeTrivia: includeTrivia)
      var typeName = "\(type(of: self))"
      // If the type is `SyntaxChildChoices`, it is a nested type that needs to be qualified.
      if self is SyntaxChildChoices, let parent = parent {
        typeName = "\(parent.syntaxNodeType).\(typeName)"
      }
      return ExprSyntax(
        FunctionCallExprSyntax(callee: ExprSyntax("\(raw: typeName)")) {
          LabeledExprSyntax(expression: nestedInitCall)
        }
      )
    }

    if case .collection(let collectionElementType) = self.syntaxNodeType.structure {
      let typeName = String(describing: type(of: self))
      return ExprSyntax(
        FunctionCallExprSyntax(callee: DeclReferenceExprSyntax(baseName: .identifier(typeName))) {
          LabeledExprSyntax(
            expression: ArrayExprSyntax {
              for child in self.children(viewMode: .all) {
                ArrayElementSyntax(expression: child.as(collectionElementType)!.debugInitCallExpr(includeTrivia: includeTrivia))
              }
            }
          )
        }
      )
    } else if let token = Syntax(self).as(TokenSyntax.self) {
      let tokenKind = token.tokenKind
      let tokenInitializerName: String
      let tokenKindArgument: ExprSyntax?
      if case .keyword(let keyword) = tokenKind {
        tokenInitializerName = "keyword"
        tokenKindArgument = ExprSyntax(".\(raw: keyword)")
      } else if tokenKind.isLexerClassifiedKeyword {
        tokenInitializerName = String(describing: tokenKind)
        tokenKindArgument = nil
      } else if tokenKind.decomposeToRaw().rawKind.defaultText != nil {
        tokenInitializerName = "\(String(describing: tokenKind))Token"
        tokenKindArgument = nil
      } else {
        let tokenKindStr = String(describing: tokenKind)
        tokenInitializerName = String(tokenKindStr[..<tokenKindStr.firstIndex(of: "(")!])
        tokenKindArgument = ExprSyntax(StringLiteralExprSyntax(content: token.text))
      }
      return ExprSyntax(
        FunctionCallExprSyntax(callee: ExprSyntax(".\(raw: tokenInitializerName)")) {
          if let tokenKindArgument = tokenKindArgument {
            LabeledExprSyntax(expression: tokenKindArgument)
          }
          if includeTrivia && !token.leadingTrivia.isEmpty {
            LabeledExprSyntax(
              label: .identifier("leadingTrivia"),
              colon: .colonToken(),
              expression: token.leadingTrivia.initializerExpr
            )
          }
          if includeTrivia && !token.trailingTrivia.isEmpty {
            LabeledExprSyntax(
              label: .identifier("trailingTrivia"),
              colon: .colonToken(),
              expression: token.trailingTrivia.initializerExpr
            )
          }
          if token.presence != .present {
            LabeledExprSyntax(
              label: .identifier("presence"),
              colon: .colonToken(),
              expression: MemberAccessExprSyntax(name: "missing")
            )
          }
        }
      )
    } else if case .layout(let layout) = self.syntaxNodeType.structure {
      let typeName = String(describing: type(of: self))
      return ExprSyntax(
        FunctionCallExprSyntax(callee: DeclReferenceExprSyntax(baseName: .identifier(typeName))) {
          for keyPath in layout {
            let label = childName(keyPath) ?? ""
            let value = self[keyPath: keyPath as! PartialKeyPath<Self>] as! SyntaxProtocol?
            let isUnexpected = label.hasPrefix("unexpected")
            if value != nil {
              LabeledExprSyntax(
                label: isUnexpected ? nil : .identifier(label),
                colon: isUnexpected ? nil : .colonToken(),
                expression: value?.debugInitCallExpr(includeTrivia: includeTrivia) ?? ExprSyntax(NilLiteralExprSyntax())
              )
            }
          }
        }
      )
    } else {
      fatalError()
    }
  }
}
