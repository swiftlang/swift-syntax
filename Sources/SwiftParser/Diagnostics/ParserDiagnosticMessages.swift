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
import SwiftSyntax

extension Syntax {
  // FIXME: These should be defined in gyb_syntax_support.
  var nodeTypeNameForDiagnostics: String? {
    if self.is(DeclSyntax.self) {
      return "declaration"
    } else if self.is(ExprSyntax.self) {
      return "expression"
    } else if self.is(PatternSyntax.self) {
      return "pattern"
    } else if self.is(StmtSyntax.self) {
      return "statement"
    } else if self.is(TypeSyntax.self) {
      return "type"
    } else if self.is(FunctionParameterSyntax.self) {
      return "function parameter"
    } else if self.is(ParameterClauseSyntax.self) {
      return "parameter clause"
    } else {
      return nil
    }
  }
}

/// A diagnostic whose ID is determined by the diagnostic's type.
public protocol DiagnosticMessageType: DiagnosticMessage {
  var diagnosticID: MessageID { get }
}

public extension DiagnosticMessageType {
  static var diagnosticID: MessageID {
    return MessageID("\(self)")
  }

  var diagnosticID: MessageID {
    return Self.diagnosticID
  }
}

// MARK: - Diagnostics (please sort alphabetically)

public struct CStyleForLoopDiagnostic: DiagnosticMessageType {
  public var message = "C-style for statement has been removed in Swift 3"
}

public struct MissingTokenDiagnostic: DiagnosticMessageType {
  public let missingToken: TokenSyntax

  public var message: String {
    guard let parent = missingToken.parent, let parentTypeName = parent.nodeTypeNameForDiagnostics else {
      return "Expected '\(missingToken.text)'"
    }
    switch missingToken.tokenKind {
    case .leftAngle, .leftBrace, .leftParen, .leftSquareBracket:
      if parent.children(viewMode: .fixedUp).first?.as(TokenSyntax.self) == missingToken {
        return "Expected '\(missingToken.text)' to start \(parentTypeName)"
      }
    case .rightAngle, .rightBrace, .rightParen, .rightSquareBracket:
      if parent.children(viewMode: .fixedUp).last?.as(TokenSyntax.self) == missingToken {
        return "Expected '\(missingToken.text)' to end \(parentTypeName)"
      }
    default:
      break
    }
    return "Expected '\(missingToken.text)' in \(parentTypeName)"
  }
}

public struct ThrowsInReturnPositionDiagnostic: DiagnosticMessageType {
  public let message = "'throws' may only occur before '->'"
}

public struct UnexpectedNodesDiagnostic: DiagnosticMessageType {
  public let unexpectedNodes: UnexpectedNodesSyntax

  public var message: String {
    if let parentTypeName = unexpectedNodes.parent?.nodeTypeNameForDiagnostics {
      return "Unexpected text '\(unexpectedNodes.description)' found in \(parentTypeName)"
    } else {
      return "Unexpected text '\(unexpectedNodes.description)'"
    }
  }
}
