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
public import SwiftDiagnostics
@_spi(Diagnostics) import SwiftParser
@_spi(RawSyntax) public import SwiftSyntax
#else
import SwiftDiagnostics
@_spi(Diagnostics) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax
#endif

fileprivate let diagnosticDomain: String = "SwiftParser"

/// An error diagnostic whose ID is determined by the diagnostic's type.
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
  var noteID: MessageID { get }
}

public extension ParserNote {
  @available(*, deprecated, message: "Use noteID instead.", renamed: "noteID")
  static var fixItID: MessageID {
    return Self.noteID
  }

  static var noteID: MessageID {
    return MessageID(domain: diagnosticDomain, id: "\(self)")
  }

  var noteID: MessageID {
    return Self.noteID
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
  public static var allStatementsInSwitchMustBeCoveredByCase: Self {
    .init("all statements inside a switch must be covered by a 'case' or 'default' label")
  }
  public static var associatedTypeCannotUsePack: Self {
    .init("associated types cannot be variadic")
  }
  public static var canImportWrongSecondParameterLabel: Self {
    .init("2nd parameter of canImport should be labeled as _version or _underlyingVersion")
  }
  public static var canImportWrongNumberOfParameter: Self {
    .init("canImport can take only two parameters")
  }
  public static var caseOutsideOfSwitchOrEnum: Self {
    .init("'case' can only appear inside a 'switch' statement or 'enum' declaration")
  }
  public static var classConstraintCanOnlyBeUsedInProtocol: Self {
    .init("'class' constraint can only appear on protocol declarations")
  }
  public static var consecutiveDeclarationsOnSameLine: Self {
    .init("consecutive declarations on a line must be separated by newline or ';'")
  }
  public static var consecutiveStatementsOnSameLine: Self {
    .init("consecutive statements on a line must be separated by newline or ';'")
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
  public static var deinitCannotThrow: Self {
    .init("deinitializers cannot throw")
  }
  public static var editorPlaceholderInSourceFile: Self {
    .init("editor placeholder in source file")
  }
  public static var escapedNewlineAtLastLineOfMultiLineStringLiteralNotAllowed: Self {
    .init("escaped newline at the last line of a multi-line string literal is not allowed")
  }
  public static var expectedColonClass: Self {
    .init("expected ':' to begin inheritance clause")
  }
  public static var expectedExpressionAfterTry: Self {
    .init("expected expression after 'try'")
  }
  public static var expectedAssignmentInsteadOfComparisonOperator: Self {
    .init("expected '=' instead of '==' to assign default value for parameter")
  }
  public static var expectedCommaInWhereClause: Self {
    .init("expected ',' to separate the requirements of this 'where' clause")
  }
  public static var expectedLeftBraceOrIfAfterElse: Self {
    .init("expected '{' or 'if' after 'else'")
  }
  public static var expectedSequenceExpressionInForEachLoop: Self {
    .init("expected Sequence expression for for-each loop")
  }
  public static var extraTokensAtTheEndOfSourceLocationDirective: Self {
    .init("extra tokens following the #sourceLocation directive")
  }
  public static var extraTokensFollowingConditionalCompilationDirective: Self {
    .init("extra tokens following conditional compilation directive")
  }
  public static var extraRightBracket: Self {
    .init("unexpected ']' in type; did you mean to write an array type?")
  }
  public static var forbiddenExtendedEscapingString: Self {
    .init("argument cannot be an extended escaping string literal")
  }
  public static var forbiddenInterpolatedString: Self {
    return .init("argument cannot be an interpolated string literal")
  }
  public static var genericParamCantBeUsedInEnumCaseDecl: Self {
    return .init("generic signature cannot be declared in enum 'case'")
  }
  public static var initializerInPattern: Self {
    .init("unexpected initializer in pattern; did you mean to use '='?")
  }
  public static var initializerCannotHaveName: Self {
    .init("initializers cannot have a name")
  }
  public static var initializerCannotHaveResultType: Self {
    .init("initializers cannot have a result type")
  }
  public static var invalidFlagAfterPrecedenceGroupAssignment: Self {
    .init("expected 'true' or 'false' after 'assignment'")
  }
  public static var invalidPrecedenceGroupAssociativity: Self {
    .init("Expected 'none', 'left', or 'right' after 'associativity'")
  }
  public static var joinConditionsUsingComma: Self {
    .init("expected ',' joining parts of a multi-clause condition")
  }
  public static var joinPlatformsUsingComma: Self {
    .init("expected ',' joining platforms in availability condition")
  }
  public static var maximumNestingLevelOverflow: Self {
    .init("parsing has exceeded the maximum nesting level")
  }
  public static var missingColonAndExprInTernaryExpr: Self {
    .init("expected ':' and expression after '? ...' in ternary expression")
  }
  public static var missingColonInTernaryExpr: Self {
    .init("expected ':' after '? ...' in ternary expression")
  }
  public static var missingConformanceRequirement: Self {
    .init("expected ':' or '==' to indicate a conformance or same-type requirement")
  }
  public static var misspelledAsync: Self {
    .init("expected async specifier; did you mean 'async'?")
  }
  public static var misspelledThrows: Self {
    .init("expected throwing specifier; did you mean 'throws'?")
  }
  public static var missingFixityInOperatorDeclaration: Self {
    .init("operator must be declared as 'prefix', 'postfix', or 'infix'")
  }
  public static var multiLineStringLiteralMustBeginOnNewLine: Self {
    .init("multi-line string literal content must begin on a new line")
  }
  public static var multiLineStringLiteralMustHaveClosingDelimiterOnNewLine: Self {
    .init("multi-line string literal closing delimiter must begin on a new line")
  }
  public static var operatorShouldBeDeclaredWithoutBody: Self {
    .init("operator should not be declared with body")
  }
  public static var singleQuoteStringLiteral: Self {
    .init(#"Single-quoted string literal found, use '"'"#)
  }
  public static var standaloneSemicolonStatement: Self {
    .init("standalone ';' statements are not allowed")
  }
  public static var stringLiteralAtSign: Self {
    .init("string literals in Swift are not preceded by an '@' sign")
  }
  public static var subscriptsCannotHaveNames: Self {
    .init("subscripts cannot have a name")
  }
  public static var tooManyClosingPoundDelimiters: Self {
    .init("too many '#' characters in closing delimiter")
  }
  public static var tooFewClosingPoundDelimiters: Self {
    .init("expected additional '#' characters in closing delimiter")
  }
  public static var tooManyRawStringDelimitersToStartInterpolation: Self {
    .init("too many '#' characters to start string interpolation")
  }
  public static var tryMustBePlacedOnReturnedExpr: Self {
    .init("'try' must be placed on the returned expression")
  }
  public static var tryMustBePlacedOnThrownExpr: Self {
    .init("'try' must be placed on the thrown expression")
  }
  public static var tryMustBePlacedOnThenExpr: Self {
    .init("'try' must be placed on the produced expression")
  }
  public static var tryOnInitialValueExpression: Self {
    .init("'try' must be placed on the initial value expression")
  }
  public static var typeParameterPackEllipsis: Self {
    .init("ellipsis operator cannot be used with a type parameter pack")
  }
  public static var unexpectedPoundElseSpaceIf: Self {
    .init("unexpected 'if' keyword following '#else' conditional compilation directive; did you mean '#elseif'?")
  }
  public static var unexpectedSemicolon: Self {
    .init("unexpected ';' separator")
  }
  public static var versionComparisonNotNeeded: Self {
    .init("version comparison not needed")
  }
}

// MARK: - Diagnostics (please sort alphabetically)

public struct AsyncMustPrecedeThrows: ParserError {
  public let asyncKeywords: [TokenSyntax]
  public let throwsKeyword: TokenSyntax

  public var message: String {
    return "\(nodesDescription(asyncKeywords, format: false)) must precede \(nodesDescription([throwsKeyword], format: false))"
  }
}

public struct AvailabilityConditionAsExpression: ParserError {
  public let availabilityToken: TokenSyntax
  public let negatedAvailabilityToken: TokenSyntax

  public var message: String {
    return "\(availabilityToken) cannot be used as an expression, did you mean to use '\(negatedAvailabilityToken)'?"
  }
}

public struct AvailabilityConditionInExpression: ParserError {
  public let availabilityCondition: AvailabilityConditionSyntax

  public var message: String {
    return "\(nodesDescription([availabilityCondition], format: false)) cannot be used in an expression, only as a condition of 'if' or 'guard'"
  }
}

public struct CannotParseVersionTuple: ParserError {
  public let versionTuple: UnexpectedNodesSyntax

  public var message: String {
    return "cannot parse version component \(versionTuple.shortSingleLineContentDescription)"
  }
}

public struct DeinitializerSignatureError: ParserError {
  public let name: TokenSyntax?
  public let params: FunctionParameterClauseSyntax?
  public let returnClause: ReturnClauseSyntax?

  public var message: String {
    var descriptions: [String] = []

    if name != nil {
      descriptions.append("a name")
    }

    if params != nil {
      descriptions.append("parameters")
    }

    if returnClause != nil {
      var message = "return clause"

      if descriptions.isEmpty {
        message = "a " + message
      }

      descriptions.append(message)
    }

    return "deinitializers cannot have \(formatDescriptions(descriptions))"
  }
}

public struct DuplicateEffectSpecifiers: ParserError {
  public let correctSpecifier: TokenSyntax
  public let unexpectedSpecifier: TokenSyntax

  public var message: String {
    if correctSpecifier.tokenKind == unexpectedSpecifier.tokenKind {
      return "\(nodesDescription([unexpectedSpecifier], format: false)) has already been specified"
    } else {
      return "\(nodesDescription([unexpectedSpecifier], format: false)) conflicts with \(nodesDescription([correctSpecifier], format: false))"
    }
  }
}

public struct EffectsSpecifierAfterArrow: ParserError {
  public let effectsSpecifiersAfterArrow: [TokenSyntax]

  public var message: String {
    "\(nodesDescription(effectsSpecifiersAfterArrow, format: false)) must precede '->'"
  }
}

public struct ExtraneousCodeAtTopLevel: ParserError {
  public let extraneousCode: UnexpectedNodesSyntax

  public var message: String {
    return "extraneous \(extraneousCode.shortSingleLineContentDescription) at top level"
  }
}

public struct ExtraneousWhitespace: ParserError {
  public let tokenWithWhitespace: TokenSyntax

  public var message: String {
    return "extraneous whitespace after '\(tokenWithWhitespace.text)' is not permitted"
  }
}

public struct IdentifierNotAllowedInOperatorName: ParserError {
  public let identifier: TokenSyntax

  public var message: String {
    return "\(nodesDescription([identifier], format: false)) is considered an identifier and must not appear within an operator name"
  }
}

public struct InvalidFloatLiteralMissingLeadingZero: ParserError {
  public let decimalDigits: TokenSyntax

  public var message: String {
    return "'.\(decimalDigits.text)' is not a valid floating point literal; it must be written '0.\(decimalDigits.text)'"
  }
}

public struct InvalidIdentifierError: ParserError {
  public let invalidIdentifier: TokenSyntax
  public let missingIdentifier: TokenSyntax

  public var message: String {
    switch invalidIdentifier.tokenKind {
    case .floatLiteral(let text), .integerLiteral(let text):
      fallthrough
    case .unknown(let text) where text.first?.isNumber == true:
      let name = missingIdentifier.childNameInParent ?? "identifier"
      return "\(name) can only start with a letter or underscore, not a number"
    case .wildcard:
      return "'\(invalidIdentifier.text)' cannot be used as an identifier here"
    case let tokenKind where tokenKind.isLexerClassifiedKeyword:
      return "keyword '\(invalidIdentifier.text)' cannot be used as an identifier here"
    default:
      return "'\(invalidIdentifier.text)' is not a valid identifier"
    }
  }
}

public struct InvalidIndentationInMultiLineStringLiteralError: ParserError {
  public enum Kind: Sendable {
    case insufficientIndentation
    case unexpectedSpace
    case unexpectedTab

    var message: String {
      switch self {
      case .insufficientIndentation: return "insufficient indentation"
      case .unexpectedSpace: return "unexpected space in indentation"
      case .unexpectedTab: return "unexpected tab in indentation"
      }
    }
  }

  public let kind: Kind
  public let lines: Int

  public var message: String {
    if lines == 1 {
      return "\(kind.message) of line in multi-line string literal"
    } else {
      return "\(kind.message) of the next \(lines) lines in multi-line string literal"
    }
  }
}

public struct MissingAttributeArgument: ParserError {
  /// The name of the attribute that's missing the argument, without `@`.
  public let attributeName: TypeSyntax

  public var message: String {
    return "expected argument for '@\(attributeName)' attribute"
  }
}

public struct MissingBothStringQuotesOfStringSegments: ParserError {
  public let stringSegments: StringLiteralSegmentListSyntax

  public var message: String {
    return #"expected \#(stringSegments.shortSingleLineContentDescription) to be surrounded by '"'"#
  }
}

public struct MissingConditionInStatement: ParserError {
  let node: SyntaxProtocol

  public var message: String {
    if let name = node.nodeTypeNameForDiagnostics(allowBlockNames: false) {
      return "missing condition in \(name)"
    } else {
      return "missing condition in statement"
    }
  }
}

public struct MissingExpressionInStatement: ParserError {
  let node: SyntaxProtocol

  public var message: String {
    if let name = node.nodeTypeNameForDiagnostics(allowBlockNames: false) {
      return "expected expression in \(name)"
    } else {
      return "expected expression in statement"
    }
  }
}

public struct NegatedAvailabilityCondition: ParserError {
  public let availabilityCondition: AvailabilityConditionSyntax
  public let negatedAvailabilityKeyword: TokenSyntax

  public var message: String {
    return
      "\(nodesDescription([availabilityCondition], format: false)) cannot be used in an expression; did you mean \(nodesDescription([negatedAvailabilityKeyword], format: false))?"
  }
}

public struct SpaceSeparatedIdentifiersError: ParserError {
  public let firstToken: TokenSyntax
  public let additionalTokens: [TokenSyntax]

  public var message: String {
    if let name = firstToken.parent?.ancestorOrSelf(mapping: {
      $0.nodeTypeNameForDiagnostics(allowBlockNames: false)
    }) {
      return "found an unexpected second identifier in \(name); is there an accidental break?"
    } else {
      return "found an unexpected second identifier; is there an accidental break?"
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

public struct TrailingVersionAreIgnored: ParserError {
  public let major: TokenSyntax
  public let components: VersionComponentListSyntax

  public var message: String {
    return "trailing components of version \(major)\(components) are ignored"
  }

  public var severity: DiagnosticSeverity = .warning
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
      if let parentTypeName = parent.nodeTypeNameForDiagnostics(allowBlockNames: false),
        parent.children(viewMode: .sourceAccurate).first(where: { $0.totalLength.utf8Length > 0 })?.id == unexpectedNodes.id
      {
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

public struct UnknownParameterError: ParserError {
  public let parameter: TokenSyntax
  public let validParameters: [TokenSyntax]

  public var message: String {
    var message = "unknown parameter '\(parameter.text)'"

    if let parentTypeName = parameter.parent?.ancestorOrSelf(mapping: { $0.nodeTypeNameForDiagnostics(allowBlockNames: false) }) {
      message += " in \(parentTypeName)"
    }

    message += "; valid parameters are \(nodesDescription(validParameters, format: true))"

    return message
  }
}

// MARK: - Notes (please sort alphabetically)

public struct EffectSpecifierDeclaredHere: ParserNote {
  let specifier: TokenSyntax

  public var message: String {
    return "\(nodesDescription([specifier], format: false)) declared here"
  }
}

/// A parser fix-it with a static message.
public struct StaticParserNote: NoteMessage {
  public let message: String
  private let messageID: String

  /// This should only be called within a static var on FixItMessage, such
  /// as the examples below. This allows us to pick up the messageID from the
  /// var name.
  fileprivate init(_ message: String, messageID: String = #function) {
    self.message = message
    self.messageID = messageID
  }

  public var noteID: MessageID {
    MessageID(domain: diagnosticDomain, id: "\(type(of: self)).\(messageID)")
  }
}

extension NoteMessage where Self == StaticParserNote {
  /// Please order alphabetically by property name.
  public static var shouldMatchIndentationOfClosingQuote: Self {
    .init("should match indentation here")
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
  public static var changeIndentationToMatchClosingDelimiter: Self {
    .init("change indentation of this line to match closing delimiter")
  }
  public static var insertSemicolon: Self {
    .init("insert ';'")
  }
  public static var insertAttributeArguments: Self {
    .init("insert attribute argument")
  }
  public static var insertNewline: Self {
    .init("insert newline")
  }
  public static var insertWhitespace: Self {
    .init("insert whitespace")
  }
  public static var joinIdentifiers: Self {
    .init("join the identifiers together")
  }
  public static var joinIdentifiersWithCamelCase: Self {
    .init("join the identifiers together with camel-case")
  }
  public static var removeBackslash: Self {
    .init("remove '\'")
  }
  public static var removeExtraneousDelimiters: Self {
    .init("remove extraneous delimiters")
  }
  public static var insertExtraClosingPounds: Self {
    .init("insert additional closing '#' delimiters")
  }
  public static var removeExtraneousWhitespace: Self {
    .init("remove whitespace")
  }
  public static var removeOperatorBody: Self {
    .init("remove operator body")
  }
  public static var replaceCurlyQuoteByNormalQuote: Self {
    .init(#"replace curly quotes with '"'"#)
  }
  public static var replaceNonBreakingSpaceBySpace: Self {
    .init("replace non-breaking space with ' '")
  }
  public static var wrapInBackticks: Self {
    .init("if this name is unavoidable, use backticks to escape it")
  }
}

public struct InsertFixIt: ParserFixIt {
  public let tokenToBeInserted: TokenSyntax

  public var message: String {
    "insert '\(tokenToBeInserted.text)'"
  }
}

public struct MoveTokensAfterFixIt: ParserFixIt {
  /// The token that should be moved
  public let movedTokens: [TokenSyntax]

  /// The token after which `movedTokens` should be moved
  public let after: TokenKind

  public var message: String {
    "move \(nodesDescription(movedTokens, format: false)) after '\(after.nameForDiagnostics)'"
  }
}

public struct MoveTokensInFrontOfFixIt: ParserFixIt {
  /// The token that should be moved
  public let movedTokens: [TokenSyntax]

  /// The token before which 'movedTokens' should be moved
  public let inFrontOf: TokenKind

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

  init(_ nodesToRemove: [some SyntaxProtocol]) {
    self.nodesToRemove = nodesToRemove.map(Syntax.init)
  }

  init(_ nodeToRemove: some SyntaxProtocol) {
    self.nodesToRemove = [Syntax(nodeToRemove)]
  }

  public var message: String {
    "remove \(nodesDescription(nodesToRemove, format: false))"
  }
}

public struct ReplaceTokensFixIt: ParserFixIt {
  public let replaceTokens: [TokenSyntax]

  public let replacements: [TokenSyntax]

  public var message: String {
    "replace \(nodesDescription(replaceTokens, format: false)) with \(nodesDescription(replacements, format: false))"
  }
}
