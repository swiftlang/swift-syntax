//===--- ParserDiagnosticKinds.swift --------------------------------------===//
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

import SwiftDiagnostics
@_spi(RawSyntax) import SwiftSyntax

let diagnosticDomain: String = "SwiftParser"

extension SyntaxProtocol {
  /// Return the name of this syntax node to be used to describe it in
  /// diagnostics. If the node itself has no diagnostic name (eg. it exists for
  /// the syntax tree's structure), use the name of the enclosing parent node by
  /// default.
  /// Pass inherit: false to prevent this behavior, in which case `nil` will be
  /// returned instead.
  func nodeTypeNameForDiagnostics(inherit: Bool = true) -> String? {
    if let name = Syntax(self).as(SyntaxEnum.self).nameForDiagnostics {
      return name
    }
    if inherit {
      if let parent = self.parent {
        return parent.nodeTypeNameForDiagnostics(inherit: inherit)
      }
    }
    return nil
  }

  /// If the syntax node (excluding leading and trailing trivia) only spans a
  /// single line and has less than 100 characters (and thus fits into a
  /// diagnostic message), return that. Otherwise, return `nil`.
  var contentForDiagnosticsIfShortSingleLine: String? {
    let contentWithoutTrivia = self.withoutLeadingTrivia().withoutTrailingTrivia().description
    if contentWithoutTrivia.contains("\n") || contentWithoutTrivia.count > 100 {
      return nil
    } else {
      return contentWithoutTrivia
    }
  }
}

/// A error diagnostic whose ID is determined by the diagnostic's type.
public protocol ParserError: DiagnosticMessage {
  var diagnosticID: MessageID { get }
}

public extension ParserError {
  static var diagnosticID: MessageID {
    return MessageID(domain: diagnosticDomain, id: "\(self)")
  }

  var diagnosticID: MessageID {
    return Self.diagnosticID
  }

  var severity: DiagnosticSeverity {
    return .error
  }
}

public protocol ParserFixIt: FixItMessage {
  var fixItID: MessageID { get }
}

public extension ParserFixIt {
  static var fixItID: MessageID {
    return MessageID(domain: diagnosticDomain, id: "\(self)")
  }

  var fixItID: MessageID {
    return Self.fixItID
  }
}

// MARK: - Static diagnostics

/// Please order the cases in this enum alphabetically by case name.
public enum StaticParserError: String, DiagnosticMessage {
  case cStyleForLoop = "C-style for statement has been removed in Swift 3"
  case missingColonInTernaryExprDiagnostic = "Expected ':' after '? ...' in ternary expression"
  case missingFunctionParameterClause = "Expected argument list in function declaration"
  case throwsInReturnPosition = "'throws' may only occur before '->'"

  public var message: String { self.rawValue }

  public var diagnosticID: MessageID {
    MessageID(domain: diagnosticDomain, id: "\(type(of: self)).\(self)")
  }

  public var severity: DiagnosticSeverity { .error }
}

public enum StaticParserFixIt: String, FixItMessage {
  case moveThrowBeforeArrow = "Move 'throws' before '->'"

  public var message: String { self.rawValue }

  public var fixItID: MessageID {
    MessageID(domain: diagnosticDomain, id: "\(type(of: self)).\(self)")
  }
}

// MARK: - Diagnostics (please sort alphabetically)

public struct ExtaneousCodeAtTopLevel: ParserError {
  public let extraneousCode: UnexpectedNodesSyntax

  public var message: String {
    if let shortContent = extraneousCode.contentForDiagnosticsIfShortSingleLine {
      return "Extraneous '\(shortContent)' at top level"
    } else {
      return "Extraneous code at top level"
    }
  }
}

public struct InvalidIdentifierError: ParserError {
  public let invalidIdentifier: TokenSyntax

  public var message: String {
    switch invalidIdentifier.tokenKind {
    case .unknown(let text) where text.first?.isNumber == true:
      return "identifier can only start with a letter or underscore, not a number"
    default:
      return "'\(invalidIdentifier.text)' is not a valid identifier"
    }
  }
}

public struct MissingTokenError: ParserError {
  public let missingToken: TokenSyntax

  public var message: String {
    var message = "Expected"
    if missingToken.text.isEmpty {
      message += " \(missingToken.tokenKind.decomposeToRaw().rawKind.nameForDiagnostics)"
    } else {
      message += " '\(missingToken.text)'"
    }
    if let parent = missingToken.parent, let parentTypeName = parent.nodeTypeNameForDiagnostics() {
      switch missingToken.tokenKind {
      case .leftAngle, .leftBrace, .leftParen, .leftSquareBracket:
        if parent.children(viewMode: .fixedUp).first?.as(TokenSyntax.self) == missingToken {
          message += " to start \(parentTypeName)"
        }
      case .rightAngle, .rightBrace, .rightParen, .rightSquareBracket:
        if parent.children(viewMode: .fixedUp).last?.as(TokenSyntax.self) == missingToken {
          message += " to end \(parentTypeName)"
        }
      default:
        message += " in \(parentTypeName)"
      }
    }
    return message
  }

  public var handledNodes: [Syntax] {
    if let previous = missingToken.previousToken(viewMode: .all), previous.parent!.is(UnexpectedNodesSyntax.self) {
      return [Syntax(previous.parent!)]
    }
    return []
  }
}

public struct UnexpectedNodesError: ParserError {
  public let unexpectedNodes: UnexpectedNodesSyntax

  public var message: String {
    var message = "Unexpected text"
    if let shortContent = unexpectedNodes.contentForDiagnosticsIfShortSingleLine {
      message += " '\(shortContent)'"
    }
    if let parent = unexpectedNodes.parent {
      if let parentTypeName = parent.nodeTypeNameForDiagnostics(inherit: false), parent.children(viewMode: .sourceAccurate).first?.id == unexpectedNodes.id {
        message += " before \(parentTypeName)"
      } else if let parentTypeName = parent.nodeTypeNameForDiagnostics() {
        message += " in \(parentTypeName)"
      }
    }
    return message
  }
}
