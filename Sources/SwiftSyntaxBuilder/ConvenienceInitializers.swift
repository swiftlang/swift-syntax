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
      catchKeyword: .catchKeyword(trailingTrivia: catchItems.isEmpty ? [] : .space),
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
      content: elementList.isEmpty ? .colon(.colonToken()) : .elements(elementList),
      rightSquare: rightSquare
    )
  }
}

// MARK: - Expr

extension Expr {
  /// Returns a syntax tree for an expression that represents the value of the
  /// provided instance. For example, passing an `Array<String>` will result in
  /// an array literal containing string literals:
  ///
  ///     let arrayExpr = Expr(literal: ["a", "b", "c"])
  ///     // `arrayExpr` is a syntax tree like `["a", "b", "c"]`
  ///
  /// This initializer is compatible with types that conform to
  /// ``ExpressibleByLiteralSyntax``. These include:
  ///
  /// * `String` and `Substring`
  /// * `Int` and other integer types
  /// * `Double` and other floating-point types
  /// * `Bool`
  /// * `Array` and `Set` of conforming elements
  /// * `Dictionary` and `KeyValuePairs` of conforming keys and values
  /// * `Optional` of conforming wrapped value
  ///
  /// Conformances will generally handle edge cases sensibly: `String` will
  /// use raw literals and escapes as needed, `Optional` will wrap a nested
  /// `nil` in `.some`, `Double` wil represent special values like infinities
  /// as code sequences like `.infinity`, etc. `Set` and `Dictionary` sort
  /// thier elements to improve stability.
  ///
  /// Because of that intelligent behavior, this initializer is not guaranteed
  /// to produce a literal as the outermost syntax node, or even to have a
  /// literal anywhere in its syntax tree. Use a convenience initializer on a
  /// specific type if you need that exact type in the syntax tree.
  public init<Literal: ExpressibleByLiteralSyntax>(literal: Literal) {
    self.init(literal.makeLiteralSyntax())
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
  public init<C: ExprSyntaxProtocol>(
    callee: C,
    trailingClosure: ClosureExprSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementList? = nil,
    @TupleExprElementListBuilder argumentList: () -> TupleExprElementList = { [] }
  ) {
    let argumentList = argumentList()
    let shouldOmitParens = argumentList.isEmpty && trailingClosure != nil
    self.init(
      calledExpression: callee,
      leftParen: shouldOmitParens ? nil : .leftParen,
      argumentList: argumentList,
      rightParen: shouldOmitParens ? nil : .rightParen,
      trailingClosure: trailingClosure,
      additionalTrailingClosures: additionalTrailingClosures
    )
  }
}

// MARK: - FunctionParameter

// TODO: We should split FunctionParameter into separate nodes
//
// This would allow them to be both `SyntaxParseable` and
// `SyntaxExpressibleByStringInterpolation`, allowing this initializer to be
// removed. In general we shouldn't allow the builder to take arbitrary
// strings, only literals.
extension FunctionParameter {
  public init(
    _ source: String,
    for subject: Parser.ParameterSubject
  ) {
    self = try! performParse(
      source: Array(source.utf8),
      parse: {
        let raw = RawSyntax($0.parseFunctionParameter(for: subject))
        return Syntax(raw: raw).cast(FunctionParameter.self)
      }
    )
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
      elseKeyword: generatedElseBody == nil ? nil : .elseKeyword(leadingTrivia: .space),
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
    self.init(base: base, dot: dot, name: .identifier(name), declNameArguments: declNameArguments)
  }
}

// MARK: - StringLiteralExpr

extension String {
  /// Replace literal newlines with "\r", "\n", "\u{2028}", and ASCII control characters with "\0", "\u{7}"
  fileprivate func escapingForStringLiteral(usingDelimiter delimiter: String) -> String {
    // String literals cannot contain "unprintable" ASCII characters (control
    // characters, etc.) besides tab. As a matter of style, we also choose to
    // escape Unicode newlines like "\u{2028}" even though swiftc will allow
    // them in string literals.
    func needsEscaping(_ scalar: UnicodeScalar) -> Bool {
      return (scalar.isASCII && scalar != "\t" && !scalar.isPrintableASCII)
        || Character(scalar).isNewline
    }

    // Work at the Unicode scalar level so that "\r\n" isn't combined.
    var result = String.UnicodeScalarView()
    var input = self.unicodeScalars[...]
    while let firstNewline = input.firstIndex(where: needsEscaping(_:)) {
      result += input[..<firstNewline]

      result += "\\\(delimiter)".unicodeScalars
      switch input[firstNewline] {
      case "\r":
        result += "r".unicodeScalars
      case "\n":
        result += "n".unicodeScalars
      case "\0":
        result += "0".unicodeScalars
      case let other:
        result += "u{\(String(other.value, radix: 16))}".unicodeScalars
      }
      input = input[input.index(after: firstNewline)...]
    }
    result += input

    return String(result)
  }
}

extension StringLiteralExpr {
  private enum PoundState {
    case afterQuote, afterBackslash, none
  }

  private static func requiresEscaping(_ content: String) -> (Bool, poundCount: Int) {
    var countingPounds = false
    var consecutivePounds = 0
    var maxPounds = 0
    var requiresEscaping = false

    for c in content {
      switch (countingPounds, c) {
      // Normal mode: scanning for characters that can be followed by pounds.
      case (false, "\""), (false, "\\"):
        countingPounds = true
        requiresEscaping = true
      case (false, _):
        continue

      // Special mode: counting a sequence of pounds until we reach its end.
      case (true, "#"):
        consecutivePounds += 1
        maxPounds = max(maxPounds, consecutivePounds)
      case (true, _):
        countingPounds = false
        consecutivePounds = 0
      }
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

    let escapedContent = content.escapingForStringLiteral(usingDelimiter: closeDelimiter?.text ?? "")
    let contentToken = Token.stringSegment(escapedContent)
    let segment = StringSegment(content: contentToken)
    let segments = StringLiteralSegments([.stringSegment(segment)])

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
  public init(_ label: SwitchCase, @CodeBlockItemListBuilder statementsBuilder: () -> CodeBlockItemListSyntax) {
    self = label
    self.statements = statementsBuilder()
  }
}

// MARK: - TernaryExpr

extension TernaryExpr {
  public init<C: ExprSyntaxProtocol, F: ExprSyntaxProtocol, S: ExprSyntaxProtocol>(
    if condition: C,
    then firstChoice: F,
    else secondChoice: S
  ) {
    self.init(
      conditionExpression: condition,
      questionMark: .infixQuestionMarkToken(leadingTrivia: .space, trailingTrivia: .space),
      firstChoice: firstChoice,
      colonMark: .colonToken(leadingTrivia: .space),
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
      label: label.map { .identifier($0) },
      colon: label == nil ? nil : .colonToken(),
      expression: expression
    )
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
