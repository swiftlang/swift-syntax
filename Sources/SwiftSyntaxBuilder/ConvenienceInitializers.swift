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

@_spi(RawSyntax) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax

// MARK: - BinaryOperatorExpr

extension BinaryOperatorExpr {
  public init(text: String) {
    self.init(operatorToken: .spacedBinaryOperator(text))
  }
}

// MARK: - BooleanLiteralExpr

extension BooleanLiteralExpr: ExpressibleByBooleanLiteral {
  public init(_ value: Bool) {
    self.init(booleanLiteral: value ? .true : .false)
  }

  public init(booleanLiteral value: Bool) {
    self.init(value)
  }
}

// MARK: - CatchClause

extension CatchClause {
  /// A convenience initializer that calculates spacing around the `catch` keyword.
  public init(
    leadingTrivia: Trivia = [],
    _ catchItems: CatchItemList,
    @CodeBlockItemListBuilder bodyBuilder: () -> CodeBlockItemListSyntax
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      catchKeyword: .catch.withTrailingTrivia(catchItems.isEmpty ? [] : .space),
      catchItems: catchItems,
      body: CodeBlockSyntax(statements: bodyBuilder())
    )
  }
}

// MARK: - CustomAttribute

extension CustomAttribute {
  /// A convenience initializer that allows passing in arguments using a result builder
  /// and automatically adds parentheses as needed, similar to the convenience
  /// initializer for ``FunctionCallExpr``.
  public init(
    _ attributeName: TypeSyntax,
    @TupleExprElementListBuilder argumentList: () -> TupleExprElementList? = { nil }
  ) {
    let argumentList = argumentList()
    self.init(
      attributeName: attributeName,
      leftParen: argumentList != nil ? .leftParen : nil,
      argumentList: argumentList,
      rightParen: argumentList != nil ? .rightParen : nil
    )
  }
}

// MARK: - DictionaryExpr

extension DictionaryExpr {
  /// A convenience initializer that allows passing in members using a result builder
  /// instead of having to wrap them in a `DictionaryElementList`.
  public init(
    leftSquare: Token = .`leftSquareBracket`,
    rightSquare: Token = .`rightSquareBracket`,
    @DictionaryElementListBuilder contentBuilder: () -> DictionaryElementListSyntax = { DictionaryElementList([]) }
  ) {
    let elementList = contentBuilder()
    self.init(
      leftSquare: leftSquare,
      content: elementList.isEmpty ? .colon(Token.colon.withTrailingTrivia([])) : .elements(elementList),
      rightSquare: rightSquare
    )
  }
}

// MARK: - FloatLiteralExprSyntax

extension FloatLiteralExprSyntax: ExpressibleByFloatLiteral {
  public init(_ value: Float) {
    self.init(floatingDigits: String(value))
  }

  public init(floatLiteral value: Float) {
    self.init(value)
  }
}

// MARK: - FunctionCallExpr

extension FunctionCallExpr {
  /// A convenience initializer that allows passing in arguments using a result builder
  /// instead of having to wrap them in a `TupleExprElementList`.
  /// The presence of the parenthesis will be inferred based on the presence of arguments and the trailing closure.
  public init(
    callee: String,
    trailingClosure: ClosureExprSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementList? = nil,
    @TupleExprElementListBuilder argumentList: () -> TupleExprElementList = { [] }
  ) {
    let argumentList = argumentList()
    let shouldOmitParens = argumentList.isEmpty && trailingClosure != nil
    self.init(
      calledExpression: Expr(callee),
      leftParen: shouldOmitParens ? nil : .leftParen,
      argumentList: argumentList,
      rightParen: shouldOmitParens ? nil : .rightParen,
      trailingClosure: trailingClosure,
      additionalTrailingClosures: additionalTrailingClosures
    )
  }
}

// MARK: - FunctionParameter

extension FunctionParameter {
  public init(
    _ source: String,
    for subject: Parser.ParameterSubject
  ) {
    self = try! performParse(source: Array(source.utf8), parse: {
      $0.parseFunctionParameter(for: subject).syntax
    })
  }
}

// MARK: - IfStmt

extension IfStmt {
  /// A convenience initializer that uses builder closures to express an
  /// if body, potentially with a second trailing builder closure for an else
  /// body.
  public init(
    leadingTrivia: Trivia = [],
    conditions: ConditionElementList,
    @CodeBlockItemListBuilder body: () -> CodeBlockItemList,
    @CodeBlockItemListBuilder elseBody: () -> CodeBlockItemList? = { nil }
  ) {
    let generatedElseBody = elseBody()
    self.init(
      leadingTrivia: leadingTrivia,
      conditions: conditions,
      body: CodeBlockSyntax(statements: body()),
      elseKeyword: generatedElseBody == nil ? nil : Token.else.withLeadingTrivia(.space).withTrailingTrivia([]),
      elseBody: generatedElseBody.map { .codeBlock(CodeBlock(statements: $0)) }
    )
  }
}


// MARK: - IntegerLiteralExpr

extension IntegerLiteralExpr: ExpressibleByIntegerLiteral {
  public init(_ value: Int) {
    self.init(digits: String(value))
  }

  public init(integerLiteral value: Int) {
    self.init(value)
  }
}

// MARK: - MemberAccessExpr

extension MemberAccessExpr {
  /// Creates a `MemberAccessExpr` using the provided parameters.
  public init(
    base: ExprSyntax? = nil,
    dot: Token = .period,
    name: String,
    declNameArguments: DeclNameArgumentsSyntax? = nil
  ) {
    self.init(base: base, dot: dot, name: TokenSyntax.identifier(name), declNameArguments: declNameArguments)
  }
}

// MARK: - StringLiteralExpr

extension String {
  /// Replace literal newlines with "\r", "\n".
  fileprivate func replacingNewlines() -> String {
    var result = ""
    var input = self[...]
    while let firstNewline = input.firstIndex(where: { $0.isNewline }) {
      result += input[..<firstNewline]
      if input[firstNewline] == "\r" {
        result += "\\r"
      } else if input[firstNewline] == "\r\n" {
        result += "\\r\\n"
      } else {
        result += "\\n"
      }
      input = input[input.index(after: firstNewline)...]
      continue
    }

    return result + input
  }
}

extension StringLiteralExpr {
  private enum PoundState {
    case afterQuote, afterBackslash, none
  }

  private static func requiresEscaping(_ content: String) -> (Bool, poundCount: Int) {
    var state: PoundState = .none
    var consecutivePounds = 0
    var maxPounds = 0
    var requiresEscaping = false

    for c in content {
      switch c {
      case "#":
        consecutivePounds += 1
      case "\"":
        state = .afterQuote
        consecutivePounds = 0
      case "\\":
        state = .afterBackslash
        consecutivePounds = 0
      case "(" where state == .afterBackslash:
        maxPounds = max(maxPounds, consecutivePounds)
        fallthrough
      default:
        consecutivePounds = 0
        state = .none
      }

      if state == .afterQuote {
        maxPounds = max(maxPounds, consecutivePounds)
      }

      requiresEscaping = requiresEscaping || state != .none
    }

    return (requiresEscaping, poundCount: maxPounds)
  }

  /// Creates a string literal, optionally specifying quotes and delimiters.
  /// If `openDelimiter` and `closeDelimiter` are `nil`, automatically determines
  /// the number of `#`s needed to express the string as-is without any escapes.
  public init(
    openDelimiter: Token? = nil,
    openQuote: Token = .stringQuote,
    content: String,
    closeQuote: Token = .stringQuote,
    closeDelimiter: Token? = nil
  ) {
    let contentToken = Token.stringSegment(content.replacingNewlines())
    let segment = StringSegment(content: contentToken)
    let segments = StringLiteralSegments([.stringSegment(segment)])

    var openDelimiter = openDelimiter
    var closeDelimiter = closeDelimiter
    if openDelimiter == nil, closeDelimiter == nil {
      // Match potential escapes in the string
      let (requiresEscaping, poundCount) = Self.requiresEscaping(content)
      if requiresEscaping {
        // Use a delimiter that is exactly one longer
        openDelimiter = Token.rawStringDelimiter(String(repeating: "#", count: poundCount + 1))
        closeDelimiter = openDelimiter
      }
    }

    self.init(
      openDelimiter: openDelimiter,
      openQuote: openQuote,
      segments: segments,
      closeQuote: closeQuote,
      closeDelimiter: closeDelimiter
    )
  }
}

// MARK: - SwitchCase

extension SwitchCase {
  public init(_ label: String, @CodeBlockItemListBuilder statementsBuilder: () -> CodeBlockItemListSyntax) {
    self.init("\(label)")
    self.statements = statementsBuilder()
  }
}

// MARK: - TernaryExpr

extension TernaryExpr {
  public init(
    if condition: ExprSyntaxProtocol,
    then firstChoice: ExprSyntaxProtocol,
    else secondChoice: ExprSyntaxProtocol
  ) {
    self.init(
      conditionExpression: condition,
      questionMark: .infixQuestionMark.withLeadingTrivia(.space).withTrailingTrivia(.space),
      firstChoice: firstChoice,
      colonMark: .colon.withLeadingTrivia(.space),
      secondChoice: secondChoice
    )
  }
}

// MARK: - TupleExprElement

extension TupleExprElement {
  /// A convenience initializer that allows passing in label as an optional string.
  /// The presence of the colon will be inferred based on the presence of the label.
  public init(label: String? = nil, expression: ExprSyntax) {
    self.init(
      label: label.map { Token.identifier($0) }, colon: label == nil ? nil : Token.colon, expression: expression, trailingComma: nil)
  }
}

// MARK: - VariableDecl

extension VariableDecl {
  /// Creates an optionally initialized property.
  public init(
    leadingTrivia: Trivia = [],
    attributes: AttributeList? = nil,
    modifiers: ModifierList? = nil,
    _ letOrVarKeyword: Token,
    name: IdentifierPattern,
    type: TypeAnnotation? = nil,
    initializer: InitializerClause? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes?.withTrailingTrivia(.space),
      modifiers: modifiers,
      letOrVarKeyword: letOrVarKeyword
    ) {
      PatternBinding(
        pattern: name,
        typeAnnotation: type,
        initializer: initializer
      )
    }
  }

  /// Creates a computed property with the given accessor.
  public init(
    leadingTrivia: Trivia = [],
    attributes: AttributeList? = nil,
    modifiers: ModifierList? = nil,
    name: IdentifierPattern,
    type: TypeAnnotation,
    @CodeBlockItemListBuilder accessor: () -> CodeBlockItemList
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes?.withTrailingTrivia(.space),
      modifiers: modifiers,
      letOrVarKeyword: .var
    ) {
      PatternBinding(
        pattern: name,
        typeAnnotation: type,
        accessor: .getter(CodeBlock(statements: accessor()))
      )
    }
  }
}

//==========================================================================//
// IMPORTANT: If you are tempted to add an extension here, please insert    //
// it in alphabetical order above                                           //
//==========================================================================//
