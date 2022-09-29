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

public protocol ParserNote: NoteMessage {
  var fixItID: MessageID { get }
}

public extension ParserNote {
  static var fixItID: MessageID {
    return MessageID(domain: diagnosticDomain, id: "\(self)")
  }

  var fixItID: MessageID {
    return Self.fixItID
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

// MARK: - Errors (please sort alphabetically)

/// Please order the cases in this enum alphabetically by case name.
public enum StaticParserError: String, DiagnosticMessage {
  case cStyleForLoop = "C-style for statement has been removed in Swift 3"
  case missingColonInTernaryExprDiagnostic = "expected ':' after '? ...' in ternary expression"
  case missingFunctionParameterClause = "expected argument list in function declaration"
  case throwsInReturnPosition = "'throws' may only occur before '->'"

  public var message: String { self.rawValue }

  public var diagnosticID: MessageID {
    MessageID(domain: diagnosticDomain, id: "\(type(of: self)).\(self)")
  }

  public var severity: DiagnosticSeverity { .error }
}

// MARK: - Diagnostics (please sort alphabetically)

public struct ExtaneousCodeAtTopLevel: ParserError {
  public let extraneousCode: UnexpectedNodesSyntax

  public var message: String {
    if let shortContent = extraneousCode.contentForDiagnosticsIfShortSingleLine {
      return "extraneous '\(shortContent)' at top level"
    } else {
      return "extraneous code at top level"
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

public struct MissingAttributeArgument: ParserError {
  /// The name of the attribute that's missing the argument, without `@`.
  public let attributeName: TokenSyntax

  public var message: String {
    return "expected argument for '@\(attributeName)' attribute"
  }
}

public struct UnexpectedNodesError: ParserError {
  public let unexpectedNodes: UnexpectedNodesSyntax

  public var message: String {
    var message = "unexpected text"
    if let shortContent = unexpectedNodes.contentForDiagnosticsIfShortSingleLine {
      message += " '\(shortContent)'"
    }
    if let parent = unexpectedNodes.parent {
      if let parentTypeName = parent.nodeTypeNameForDiagnostics, parent.children(viewMode: .sourceAccurate).first?.id == unexpectedNodes.id {
        message += " before \(parentTypeName)"
      } else if let parentTypeName = parent.ancestorOrSelf(where: { $0.nodeTypeNameForDiagnostics != nil })?.nodeTypeNameForDiagnostics {
        message += " in \(parentTypeName)"
      }
    }
    return message
  }
}

// MARK: - Fix-Its (please sort alphabetically)

public enum StaticParserFixIt: String, FixItMessage {
  case insertAttributeArguments = "insert attribute argument"
  case moveThrowBeforeArrow = "move 'throws' before '->'"

  public var message: String { self.rawValue }

  public var fixItID: MessageID {
    MessageID(domain: diagnosticDomain, id: "\(type(of: self)).\(self)")
  }
}
