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

extension Child {
  var requiresLeadingSpace: Bool? {
    switch self.kind {
    case .token(_, let requiresLeadingSpace, _):
      return requiresLeadingSpace
    case .nodeChoices(let choices):
      for choice in choices {
        if let requiresLeadingSpace = choice.requiresLeadingSpace {
          return requiresLeadingSpace
        }
      }
    default:
      break
    }
    return nil
  }

  var requiresTrailingSpace: Bool? {
    switch self.kind {
    case .token(choices: _, _, let requiresTrailingSpace):
      return requiresTrailingSpace
    case .nodeChoices(let choices):
      for choice in choices {
        if let requiresTrailingSpace = choice.requiresTrailingSpace {
          return requiresTrailingSpace
        }
      }
    default:
      break
    }
    return nil
  }
}

let basicFormatFile = SourceFileSyntax {
  DeclSyntax(
    """
    \(raw: generateCopyrightHeader(for: "generate-swiftbasicformat"))
    import SwiftSyntax
    """
  )

  try! ClassDeclSyntax("open class BasicFormat: SyntaxRewriter") {
    DeclSyntax("public var indentationLevel: Int = 0")
    DeclSyntax("open var indentation: TriviaPiece { .spaces(indentationLevel * 4) }")
    DeclSyntax("public var indentedNewline: Trivia { Trivia(pieces: [.newlines(1), indentation]) }")
    DeclSyntax("private var lastRewrittenToken: TokenSyntax?")
    DeclSyntax("private var putNextTokenOnNewLine: Bool = false")

    DeclSyntax(
      """
      open override func visitPre(_ node: Syntax) {
        if let keyPath = getKeyPath(node), shouldIndent(keyPath) {
          indentationLevel += 1
        }
        if let parent = node.parent, childrenSeparatedByNewline(parent) {
          putNextTokenOnNewLine = true
        }
      }
      """
    )
    DeclSyntax(
      """
      open override func visitPost(_ node: Syntax) {
        if let keyPath = getKeyPath(node), shouldIndent(keyPath) {
          indentationLevel -= 1
        }
      }
      """
    )

    DeclSyntax(
      """
      open override func visit(_ node: TokenSyntax) -> TokenSyntax {
        var leadingTrivia = node.leadingTrivia
        var trailingTrivia = node.trailingTrivia
        if requiresLeadingSpace(node) && leadingTrivia.isEmpty && lastRewrittenToken?.trailingTrivia.isEmpty != false {
          leadingTrivia += .space
        }
        if requiresTrailingSpace(node) && trailingTrivia.isEmpty {
          trailingTrivia += .space
        }
        if let keyPath = getKeyPath(Syntax(node)), requiresLeadingNewline(keyPath), !(leadingTrivia.first?.isNewline ?? false) {
          leadingTrivia = .newline + leadingTrivia
        }
        leadingTrivia = leadingTrivia.indented(indentation: indentation)
        trailingTrivia = trailingTrivia.indented(indentation: indentation)
        let rewritten = TokenSyntax(
          node.tokenKind,
          leadingTrivia: leadingTrivia,
          trailingTrivia: trailingTrivia,
          presence: node.presence
        )
        lastRewrittenToken = rewritten
        putNextTokenOnNewLine = false
        return rewritten
      }
      """
    )

    try FunctionDeclSyntax("open func shouldIndent(_ keyPath: AnyKeyPath) -> Bool") {
      try SwitchExprSyntax("switch keyPath") {
        for node in SYNTAX_NODES where !node.isBase {
          for child in node.children where child.isIndented {
            SwitchCaseSyntax("case \\\(raw: node.type.syntaxBaseName).\(raw: child.swiftName):") {
              StmtSyntax("return true")
            }
          }
        }
        SwitchCaseSyntax("default:") {
          StmtSyntax("return false")
        }
      }
    }

    try FunctionDeclSyntax("open func requiresLeadingNewline(_ keyPath: AnyKeyPath) -> Bool") {
      try SwitchExprSyntax("switch keyPath") {
        for node in SYNTAX_NODES where !node.isBase {
          for child in node.children where child.requiresLeadingNewline {
            SwitchCaseSyntax("case \\\(raw: node.type.syntaxBaseName).\(raw: child.swiftName):") {
              StmtSyntax("return true")
            }
          }
        }
        SwitchCaseSyntax("default:") {
          StmtSyntax("return putNextTokenOnNewLine")
        }
      }
    }

    try FunctionDeclSyntax("open func childrenSeparatedByNewline(_ node: Syntax) -> Bool") {
      try SwitchExprSyntax("switch node.as(SyntaxEnum.self)") {
        for node in SYNTAX_NODES where !node.isBase {
          if node.elementsSeparatedByNewline {
            SwitchCaseSyntax("case .\(raw: node.swiftSyntaxKind):") {
              StmtSyntax("return true")
            }
          }
        }
        SwitchCaseSyntax("default:") {
          StmtSyntax("return false")
        }
      }
    }

    try FunctionDeclSyntax(
      """
      /// If this returns a value that is not `nil`, it overrides the default
      /// leading space behavior of a token.
      open func requiresLeadingSpace(_ keyPath: AnyKeyPath) -> Bool?
      """
    ) {
      try SwitchExprSyntax("switch keyPath") {
        for node in SYNTAX_NODES where !node.isBase {
          for child in node.children {
            if let requiresLeadingSpace = child.requiresLeadingSpace {
              SwitchCaseSyntax("case \\\(raw: node.type.syntaxBaseName).\(raw: child.swiftName):") {
                StmtSyntax("return \(literal: requiresLeadingSpace)")
              }
            }
          }
        }
        SwitchCaseSyntax("default:") {
          StmtSyntax("return nil")
        }
      }
    }

    try FunctionDeclSyntax("open func requiresLeadingSpace(_ token: TokenSyntax) -> Bool") {
      StmtSyntax(
        """
        if let keyPath = getKeyPath(token), let requiresLeadingSpace = requiresLeadingSpace(keyPath) {
          return requiresLeadingSpace
        }
        """
      )

      try SwitchExprSyntax("switch token.tokenKind") {
        for token in SYNTAX_TOKENS {
          if token.requiresLeadingSpace {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              StmtSyntax("return true")
            }
          }
        }
        for keyword in KEYWORDS where keyword.requiresLeadingSpace {
          SwitchCaseSyntax("case .keyword(.\(raw: keyword.escapedName)):") {
            StmtSyntax("return true")
          }
        }
        SwitchCaseSyntax("default:") {
          StmtSyntax("return false")
        }
      }
    }

    try FunctionDeclSyntax(
      """
      /// If this returns a value that is not `nil`, it overrides the default
      /// trailing space behavior of a token.
      open func requiresTrailingSpace(_ keyPath: AnyKeyPath) -> Bool?
      """
    ) {
      try SwitchExprSyntax("switch keyPath") {
        for node in SYNTAX_NODES where !node.isBase {
          for child in node.children {
            if let requiresTrailingSpace = child.requiresTrailingSpace {
              SwitchCaseSyntax("case \\\(raw: node.type.syntaxBaseName).\(raw: child.swiftName):") {
                StmtSyntax("return \(literal: requiresTrailingSpace)")
              }
            }
          }
        }
        SwitchCaseSyntax("default:") {
          StmtSyntax("return nil")
        }
      }
    }

    try FunctionDeclSyntax("open func requiresTrailingSpace(_ token: TokenSyntax) -> Bool") {
      StmtSyntax(
        """
        if let keyPath = getKeyPath(token), let requiresTrailingSpace = requiresTrailingSpace(keyPath) {
          return requiresTrailingSpace
        }
        """
      )

      StmtSyntax(
        """
        switch (token.tokenKind, token.nextToken(viewMode: .sourceAccurate)?.tokenKind) {
        case (.exclamationMark, .leftParen), // Ensures there is not space in `myOptionalClosure!()`
             (.exclamationMark, .period), // Ensures there is not space in `myOptionalBar!.foo()`
             (.keyword(.as), .exclamationMark), // Ensures there is not space in `as!`
             (.keyword(.as), .postfixQuestionMark), // Ensures there is not space in `as?`
             (.keyword(.try), .exclamationMark), // Ensures there is not space in `try!`
             (.keyword(.try), .postfixQuestionMark), // Ensures there is not space in `try?`:
             (.postfixQuestionMark, .leftParen), // Ensures there is not space in `init?()` or `myOptionalClosure?()`s
             (.postfixQuestionMark, .rightAngle), // Ensures there is not space in `ContiguousArray<RawSyntax?>`
             (.postfixQuestionMark, .rightParen): // Ensures there is not space in `myOptionalClosure?()`
          return false
        default:
          break
        }
        """
      )

      try SwitchExprSyntax("switch token.tokenKind") {
        for token in SYNTAX_TOKENS {
          if token.requiresTrailingSpace {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              StmtSyntax("return true")
            }
          }
        }
        for keyword in KEYWORDS where keyword.requiresTrailingSpace {
          SwitchCaseSyntax("case .keyword(.\(raw: keyword.escapedName)):") {
            StmtSyntax("return true")
          }
        }
        SwitchCaseSyntax("default:") {
          StmtSyntax("return false")
        }
      }
    }

    DeclSyntax(
      """
      private func getKeyPath<T: SyntaxProtocol>(_ node: T) -> AnyKeyPath? {
        guard let parent = node.parent else {
          return nil
        }
        guard case .layout(let childrenKeyPaths) = parent.kind.syntaxNodeType.structure else {
          return nil
        }
        return childrenKeyPaths[node.indexInParent]
      }
      """
    )
  }
}
