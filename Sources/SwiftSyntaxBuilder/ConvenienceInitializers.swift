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
@_spi(RawSyntax) import SwiftParser
@_spi(RawSyntax) public import SwiftSyntax
#else
@_spi(RawSyntax) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax
#endif

// MARK: - ArrayElementListSyntax

extension ArrayElementListSyntax {
  public init(expressions: [ExprSyntax]) {
    let lastIndex = expressions.count - 1
    let elements = expressions.enumerated().map { index, expression in
      let element = ArrayElementSyntax(expression: expression)
      if index < lastIndex {
        return element.ensuringTrailingComma()
      } else {
        return element
      }
    }
    self.init(elements)
  }
}

// MARK: - ArrayExprSyntax

extension ArrayExprSyntax {
  public init(expressions: [ExprSyntax]) {
    self.init(elements: ArrayElementListSyntax(expressions: expressions))
  }
}

// MARK: - AttributeSyntax

extension AttributeSyntax {
  /// A convenience initializer that allows passing in arguments using a result builder
  /// and automatically adds parentheses as needed, similar to the convenience
  /// initializer for ``FunctionCallExprSyntax``.
  public init(
    _ attributeName: TypeSyntax,
    @LabeledExprListBuilder argumentList: () -> LabeledExprListSyntax? = { nil }
  ) {
    let argumentList = argumentList()
    self.init(
      attributeName: attributeName,
      leftParen: argumentList != nil ? .leftParenToken() : nil,
      arguments: argumentList.map(AttributeSyntax.Arguments.argumentList),
      rightParen: argumentList != nil ? .rightParenToken() : nil
    )
  }
}

// MARK: - BinaryOperatorExprSyntax

extension BinaryOperatorExprSyntax {
  public init(text: String) {
    self.init(operator: .binaryOperator(text))
  }
}

// MARK: - BooleanLiteralExprSyntax

extension BooleanLiteralExprSyntax {
  public init(_ value: Bool) {
    self.init(literal: value ? .keyword(.true) : .keyword(.false))
  }

  public init(booleanLiteral value: Bool) {
    self.init(value)
  }
}
#if compiler(>=6)
extension BooleanLiteralExprSyntax: @retroactive ExpressibleByBooleanLiteral {}
#else
extension BooleanLiteralExprSyntax: ExpressibleByBooleanLiteral {}
#endif

// MARK: - CatchClauseSyntax

extension CatchClauseSyntax {
  /// A convenience initializer that calculates spacing around the `catch` keyword.
  public init(
    leadingTrivia: Trivia = [],
    _ catchItems: CatchItemListSyntax,
    @CodeBlockItemListBuilder bodyBuilder: () -> CodeBlockItemListSyntax
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      catchKeyword: .keyword(.catch, trailingTrivia: catchItems.isEmpty ? [] : .space),
      catchItems: catchItems,
      body: CodeBlockSyntax(statements: bodyBuilder())
    )
  }
}

// MARK: - DictionaryExprSyntax

extension DictionaryExprSyntax {
  /// A convenience initializer that allows passing in members using a result builder
  /// instead of having to wrap them in a `DictionaryElementList`.
  public init(
    leftSquare: TokenSyntax = .leftSquareToken(),
    rightSquare: TokenSyntax = .rightSquareToken(),
    @DictionaryElementListBuilder contentBuilder: () -> DictionaryElementListSyntax = { DictionaryElementListSyntax([]) }
  ) {
    let elementList = contentBuilder()
    self.init(
      leftSquare: leftSquare,
      content: elementList.isEmpty ? .colon(.colonToken()) : .elements(elementList),
      rightSquare: rightSquare
    )
  }
}

// MARK: - ExprListSyntax

extension ExprListSyntax {
  public init(_ elements: [ExprSyntaxProtocol]) {
    self.init(elements.map { ExprSyntax(fromProtocol: $0) } as [ExprSyntax])
  }
}

// MARK: - ExprSyntax

extension ExprSyntax {
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
  /// `nil` in `.some`, `Double` will represent special values like infinities
  /// as code sequences like `.infinity`, etc. `Set` and `Dictionary` sort
  /// their elements to improve stability.
  ///
  /// Because of that intelligent behavior, this initializer is not guaranteed
  /// to produce a literal as the outermost syntax node, or even to have a
  /// literal anywhere in its syntax tree. Use a convenience initializer on a
  /// specific type if you need that exact type in the syntax tree.
  public init(literal: some ExpressibleByLiteralSyntax) {
    self.init(literal.makeLiteralSyntax())
  }
}

// MARK: - FloatLiteralExprSyntax

extension FloatLiteralExprSyntax {
  public init(_ value: Float) {
    self.init(literal: .floatLiteral(String(value)))
  }

  public init(floatLiteral value: Float) {
    self.init(value)
  }
}

#if compiler(>=6)
extension FloatLiteralExprSyntax: @retroactive ExpressibleByFloatLiteral {}
#else
extension FloatLiteralExprSyntax: ExpressibleByFloatLiteral {}
#endif

// MARK: - FunctionCallExprSyntax

extension FunctionCallExprSyntax {
  /// A convenience initializer that allows passing in arguments using a result builder
  /// instead of having to wrap them in a `TupleExprElementList`.
  /// The presence of the parenthesis will be inferred based on the presence of arguments and the trailing closure.
  public init(
    callee: some ExprSyntaxProtocol,
    trailingClosure: ClosureExprSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementListSyntax = [],
    @LabeledExprListBuilder argumentList: () -> LabeledExprListSyntax = { [] }
  ) {
    let argumentList = argumentList()
    let shouldOmitParens = argumentList.isEmpty && trailingClosure != nil
    self.init(
      calledExpression: callee,
      leftParen: shouldOmitParens ? nil : .leftParenToken(),
      arguments: argumentList,
      rightParen: shouldOmitParens ? nil : .rightParenToken(),
      trailingClosure: trailingClosure,
      additionalTrailingClosures: additionalTrailingClosures
    )
  }
}

// MARK: - IntegerLiteralExprSyntax

extension IntegerLiteralExprSyntax {
  public init(_ value: Int) {
    self.init(literal: .integerLiteral(String(value)))
  }

  public init(integerLiteral value: Int) {
    self.init(value)
  }
}

#if compiler(>=6)
extension IntegerLiteralExprSyntax: @retroactive ExpressibleByIntegerLiteral {}
#else
extension IntegerLiteralExprSyntax: ExpressibleByIntegerLiteral {}
#endif

// MARK: - LabeledExprSyntax

extension LabeledExprSyntax {
  /// A convenience initializer that allows passing in label as an optional string.
  /// The presence of the colon will be inferred based on the presence of the label.
  public init(label: String? = nil, expression: some ExprSyntaxProtocol) {
    self.init(
      label: label.map { .identifier($0) },
      colon: label == nil ? nil : .colonToken(trailingTrivia: .space),
      expression: expression
    )
  }
}

// MARK: - StringLiteralExprSyntax

extension String {
  /// Replace literal newlines with "\r", "\n", "\u{2028}", and ASCII control characters with "\0", "\u{7}"
  fileprivate func escapingForStringLiteral(usingDelimiter delimiter: String, isMultiline: Bool) -> String {
    // String literals cannot contain "unprintable" ASCII characters (control
    // characters, etc.) besides tab. As a matter of style, we also choose to
    // escape Unicode newlines like "\u{2028}" even though swiftc will allow
    // them in string literals.
    func needsEscaping(_ scalar: UnicodeScalar) -> Bool {
      if Character(scalar).isNewline {
        return true
      }

      if !scalar.isASCII || scalar.isPrintableASCII {
        return false
      }

      if scalar == "\t" {
        // Tabs need to be escaped in single-line string literals but not
        // multi-line string literals.
        return !isMultiline
      }
      return true
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
      case "\t":
        result += "t".unicodeScalars
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

fileprivate extension Unicode.Scalar {
  /// Whether this character represents a printable ASCII character,
  /// for the purposes of pattern parsing.
  var isPrintableASCII: Bool {
    // Exclude non-printables before the space character U+20, and anything
    // including and above the DEL character U+7F.
    return self.value >= 0x20 && self.value < 0x7F
  }
}

extension StringLiteralExprSyntax {
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
      case (true, _) where c.unicodeScalars.contains("#"):
        consecutivePounds += 1
        maxPounds = max(maxPounds, consecutivePounds)
      case (true, "\""), (true, "\\"):
        continue
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
    openDelimiter: TokenSyntax? = nil,
    openingQuote: TokenSyntax = .stringQuoteToken(),
    content: String,
    closingQuote: TokenSyntax = .stringQuoteToken(),
    closeDelimiter: TokenSyntax? = nil
  ) {
    var openingPounds = openDelimiter
    var closingPounds = closeDelimiter
    if openingPounds == nil, closingPounds == nil {
      // Match potential escapes in the string
      let (requiresEscaping, poundCount) = Self.requiresEscaping(content)
      if requiresEscaping {
        // Use a delimiter that is exactly one longer
        openingPounds = TokenSyntax.rawStringPoundDelimiter(String(repeating: "#", count: poundCount + 1))
        closingPounds = openingPounds
      }
    }

    let escapedContent = content.escapingForStringLiteral(
      usingDelimiter: closingPounds?.text ?? "",
      isMultiline: openingQuote.tokenView.rawKind == .multilineStringQuote
    )
    let contentToken = TokenSyntax.stringSegment(escapedContent)
    let segment = StringSegmentSyntax(content: contentToken)
    let segments = StringLiteralSegmentListSyntax([.stringSegment(segment)])

    self.init(
      openingPounds: openingPounds,
      openingQuote: openingQuote,
      segments: segments,
      closingQuote: closingQuote,
      closingPounds: closingPounds
    )
  }
}

// MARK: - UnexpectedNodesSyntax

extension UnexpectedNodesSyntax {
  public init(_ elements: [SyntaxProtocol]) {
    self.init(elements.map { Syntax(fromProtocol: $0) } as [Syntax])
  }
}

// MARK: - VariableDeclSyntax

extension VariableDeclSyntax {
  /// Creates an optionally initialized property.
  public init(
    leadingTrivia: Trivia = [],
    attributes: AttributeListSyntax = [],
    modifiers: DeclModifierListSyntax = [],
    _ bindingSpecifier: Keyword,
    name: PatternSyntax,
    type: TypeAnnotationSyntax? = nil,
    initializer: InitializerClauseSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes.with(\.trailingTrivia, .space),
      modifiers: modifiers,
      bindingSpecifier: .keyword(bindingSpecifier)
    ) {
      PatternBindingSyntax(
        pattern: name,
        typeAnnotation: type,
        initializer: initializer
      )
    }
  }
}

//==========================================================================//
// IMPORTANT: If you are tempted to add an extension here, please insert    //
// it in alphabetical order above                                           //
//==========================================================================//
