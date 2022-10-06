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

import SwiftDiagnostics
@_spi(RawSyntax) import SwiftSyntax

fileprivate let diagnosticDomain: String = "SwiftParser"

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

/// A parser error with a static message.
public struct StaticParserError: DiagnosticMessage {
  public let message: String
  private let messageID: String

  /// This should only be called within a static var on DiagnosticMessage, such
  /// as the examples below. This allows us to pick up the messageID from the
  /// var name.
  fileprivate init(_ message: String, messageID: String = #function) {
    self.message = message
    self.messageID = messageID
  }

  public var diagnosticID: MessageID {
    MessageID(domain: diagnosticDomain, id: "\(type(of: self)).\(messageID)")
  }

  public var severity: DiagnosticSeverity { .error }
}

extension DiagnosticMessage where Self == StaticParserError {
  /// Please order the diagnostics alphabetically by property name.
  public static var allStatmentsInSwitchMustBeCoveredByCase: Self {
    .init("all statements inside a switch must be covered by a 'case' or 'default' label")
  }
  public static var associatedTypeCannotUsePack: Self {
    .init("associated types cannot be variadic")
  }
  public static var caseOutsideOfSwitchOrEnum: Self {
    .init("'case' can only appear inside a 'switch' statement or 'enum' declaration")
  }
  public static var classConstraintCanOnlyBeUsedInProtocol: Self {
    .init("'class' constraint can only appear on protocol declarations")
  }
  public static var consecutiveDeclarationsOnSameLine: Self {
    .init("consecutive declarations on a line must be separated by ';'")
  }
  public static var consecutiveStatementsOnSameLine: Self {
    .init("consecutive statements on a line must be separated by ';'")
  }
  public static var cStyleForLoop: Self {
    .init("C-style for statement has been removed in Swift 3")
  }
  public static var defaultCannotBeUsedWithWhere: Self {
    .init("'default' cannot be used with a 'where' guard expression")
  }
  public static var defaultOutsideOfSwitch: Self {
    .init("'default' label can only appear inside a 'switch' statement")
  }
  public static var deinitCannotHaveName: Self {
    .init("deinitializers cannot have a name")
  }
  public static var deinitCannotHaveParameters: Self {
    .init("deinitializers cannot have parameters")
  }
  public static var editorPlaceholderInSourceFile: Self {
    .init("editor placeholder in source file")
  }
  public static var expectedExpressionAfterTry: Self {
    .init("expected expression after 'try'")
  }
  public static var initializerInPattern: Self {
    .init("unexpected initializer in pattern; did you mean to use '='?")
  }
  public static var invalidFlagAfterPrecedenceGroupAssignment: Self {
    .init("expected 'true' or 'false' after 'assignment'")
  }
  public static var missingColonAndExprInTernaryExpr: Self {
    .init("expected ':' and expression after '? ...' in ternary expression")
  }
  public static var missingColonInTernaryExpr: Self {
    .init("expected ':' after '? ...' in ternary expression")
  }
  public static var operatorShouldBeDeclaredWithoutBody: Self {
    .init("operator should not be declared with body")
  }
  public static var standaloneSemicolonStatement: Self {
    .init("standalone ';' statements are not allowed")
  }
  public static var maximumNestingLevelOverflow: Self {
    .init("parsing has exceeded the maximum nesting level")
  }
  public static var subscriptsCannotHaveNames: Self {
    .init("subscripts cannot have a name")
  }
  public static var throwsInReturnPosition: Self {
    .init("'throws' may only occur before '->'")
  }
  public static var tryMustBePlacedOnReturnedExpr: Self {
    .init("'try' must be placed on the returned expression")
  }
  public static var tryMustBePlacedOnThrownExpr: Self {
    .init("'try' must be placed on the thrown expression")
  }
  public static var tryOnInitialValueExpression: Self {
    .init("'try' must be placed on the initial value expression")
  }
  public static var unexpectedSemicolon: Self {
    .init("unexpected ';' separator")
  }
}

// MARK: - Diagnostics (please sort alphabetically)

public struct EffectsSpecifierAfterArrow: ParserError {
  public let effectsSpecifiersAfterArrow: [TokenSyntax]

  public var message: String {
    "\(nodesDescription(effectsSpecifiersAfterArrow, format: false)) may only occur before '->'"
  }
}

public struct ExtaneousCodeAtTopLevel: ParserError {
  public let extraneousCode: UnexpectedNodesSyntax

  public var message: String {
    return "extraneous \(extraneousCode.shortSingleLineContentDescription) at top level"
  }
}

public struct IdentifierNotAllowedInOperatorName: ParserError {
  public let identifier: TokenSyntax

  public var message: String {
    return "\(nodesDescription([identifier], format: false)) is considered an identifier and must not appear within an operator name"
  }
}

public struct InvalidIdentifierError: ParserError {
  public let invalidIdentifier: TokenSyntax
  public let missingIdentifier: TokenSyntax

  public var message: String {
    switch invalidIdentifier.tokenKind {
    case .floatingLiteral(let text), .integerLiteral(let text):
      fallthrough
    case .unknown(let text) where text.first?.isNumber == true:
      let name = missingIdentifier.childNameInParent ?? "identifier"
      return "\(name) can only start with a letter or underscore, not a number"
    case .wildcardKeyword:
      return "'\(invalidIdentifier.text)' cannot be used as an identifier here"
    case let tokenKind where tokenKind.isKeyword:
      return "keyword '\(invalidIdentifier.text)' cannot be used as an identifier here"
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

public struct SpaceSeparatedIdentifiersError: ParserError {
  public let firstToken: TokenSyntax
  public let additionalTokens: [TokenSyntax]

  public var message: String {
    if let name = firstToken.parent?.ancestorOrSelf(mapping: {
      $0.nodeTypeNameForDiagnostics(allowBlockNames: false)
    }) {
      return "found an unexpected second identifier in \(name)"
    } else {
      return "found an unexpected second identifier"
    }
  }
}

public struct SpecifierOnParameterName: ParserError {
  public let misplacedSpecifiers: [TokenSyntax]

  public var message: String {
    return "\(nodesDescription(misplacedSpecifiers, format: false)) before a parameter name is not allowed"
  }
}

public struct TokensNotAllowedInOperatorName: ParserError {
  public let tokens: [TokenSyntax]

  public var message: String {
    return "\(nodesDescription(tokens, format: false)) is not allowed in operator names"
  }
}

public struct TryCannotBeUsed: ParserError {
  public let nextToken: TokenSyntax

  public var message: String {
    return "'try' cannot be used with '\(nextToken.text)'"
  }
}

public struct UnexpectedNodesError: ParserError {
  public let unexpectedNodes: UnexpectedNodesSyntax

  public var message: String {
    var message = "unexpected \(unexpectedNodes.shortSingleLineContentDescription)"
    if let parent = unexpectedNodes.parent {
      if let parentTypeName = parent.nodeTypeNameForDiagnostics(allowBlockNames: false), parent.children(viewMode: .sourceAccurate).first?.id == unexpectedNodes.id {
        message += " before \(parentTypeName)"
      } else if let parentTypeName = parent.ancestorOrSelf(mapping: { $0.nodeTypeNameForDiagnostics(allowBlockNames: false) }) {
        message += " in \(parentTypeName)"
      }
    }
    return message
  }
}

public struct UnknownDirectiveError: ParserError {
  public let unexpected: UnexpectedNodesSyntax

  public var message: String {
    return "use of unknown directive \(nodesDescription([unexpected], format: false))"
  }
}

// MARK: - Fix-Its (please sort alphabetically)

/// A parser fix-it with a static message.
public struct StaticParserFixIt: FixItMessage {
  public let message: String
  private let messageID: String

  /// This should only be called within a static var on FixItMessage, such
  /// as the examples below. This allows us to pick up the messageID from the
  /// var name.
  fileprivate init(_ message: String, messageID: String = #function) {
    self.message = message
    self.messageID = messageID
  }

  public var fixItID: MessageID {
    MessageID(domain: diagnosticDomain, id: "\(type(of: self)).\(messageID)")
  }
}

extension FixItMessage where Self == StaticParserFixIt {
  /// Please order alphabetically by property name.
  public static var insertSemicolon: Self {
    .init("insert ';'")
  }
  public static var insertAttributeArguments: Self {
    .init("insert attribute argument")
  }
  public static var joinIdentifiers: Self {
    .init("join the identifiers together")
  }
  public static var joinIdentifiersWithCamelCase: Self {
    .init("join the identifiers together with camel-case")
  }
  public static var removeOperatorBody: Self {
    .init("remove operator body")
  }
  public static var wrapInBackticks: Self {
    .init("if this name is unavoidable, use backticks to escape it")
  }
}

public struct MoveTokensAfterFixIt: ParserFixIt {
  /// The token that should be moved
  public let movedTokens: [TokenSyntax]

  /// The token after which `movedTokens` should be moved
  public let after: RawTokenKind

  public var message: String {
    "move \(nodesDescription(movedTokens, format: false)) after '\(after.nameForDiagnostics)'"
  }
}

public struct MoveTokensInFrontOfFixIt: ParserFixIt {
  /// The token that should be moved
  public let movedTokens: [TokenSyntax]

  /// The token after which 'try' should be moved
  public let inFrontOf: RawTokenKind

  public var message: String {
    "move \(nodesDescription(movedTokens, format: false)) in front of '\(inFrontOf.nameForDiagnostics)'"
  }
}

public struct MoveTokensInFrontOfTypeFixIt: ParserFixIt {
  /// The token that should be moved
  public let movedTokens: [TokenSyntax]

  public var message: String {
    "move \(nodesDescription(movedTokens, format: false)) in front of type"
  }
}

public struct RemoveRedundantFixIt: ParserFixIt {
  public let removeTokens: [TokenSyntax]

  public var message: String {
    "remove redundant \(nodesDescription(removeTokens, format: false))"
  }
}

public struct RemoveNodesFixIt: ParserFixIt {
  public let nodesToRemove: [Syntax]

  init<SyntaxType: SyntaxProtocol>(_ nodesToRemove: [SyntaxType]) {
    self.nodesToRemove = nodesToRemove.map(Syntax.init)
  }

  init<SyntaxType: SyntaxProtocol>(_ nodeToRemove: SyntaxType) {
    self.nodesToRemove = [Syntax(nodeToRemove)]
  }

  public var message: String {
    "remove \(nodesDescription(nodesToRemove, format: false))"
  }
}

public struct ReplaceTokensFixIt: ParserFixIt {
  public let replaceTokens: [TokenSyntax]

  public let replacement: TokenSyntax

  public var message: String {
    "replace \(nodesDescription(replaceTokens, format: false)) by '\(replacement.text)'"
  }
}
