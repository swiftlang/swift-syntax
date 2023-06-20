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

@_spi(RawSyntax) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax

// MARK: - CustomAttribute

extension AttributeSyntax {
  /// A convenience initializer that allows passing in arguments using a result builder
  /// and automatically adds parentheses as needed, similar to the convenience
  /// initializer for ``FunctionCallExpr``.
  public init(
    _ attributeName: TypeSyntax,
    @TupleExprElementListBuilder argumentList: () -> TupleExprElementListSyntax? = { nil }
  ) {
    let argumentList = argumentList()
    self.init(
      attributeName: attributeName,
      leftParen: argumentList != nil ? .leftParenToken() : nil,
      argument: argumentList.map(AttributeSyntax.Argument.argumentList),
      rightParen: argumentList != nil ? .rightParenToken() : nil
    )
  }
}

// MARK: - BinaryOperatorExpr

extension BinaryOperatorExprSyntax {
  public init(text: String) {
    self.init(operatorToken: .binaryOperator(text))
  }
}

// MARK: - BooleanLiteralExpr

extension BooleanLiteralExprSyntax: ExpressibleByBooleanLiteral {
  public init(_ value: Bool) {
    self.init(booleanLiteral: value ? .keyword(.true) : .keyword(.false))
  }

  public init(booleanLiteral value: Bool) {
    self.init(value)
  }
}

// MARK: - CatchClause

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

// MARK: - DictionaryExpr

extension DictionaryExprSyntax {
  /// A convenience initializer that allows passing in members using a result builder
  /// instead of having to wrap them in a `DictionaryElementList`.
  public init(
    leftSquare: TokenSyntax = .leftSquareBracketToken(),
    rightSquare: TokenSyntax = .rightSquareBracketToken(),
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

// MARK: - Expr

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
    self.init(floatingDigits: .floatingLiteral(String(value)))
  }

  public init(floatLiteral value: Float) {
    self.init(value)
  }
}

// MARK: - FunctionCallExpr

extension FunctionCallExprSyntax {
  /// A convenience initializer that allows passing in arguments using a result builder
  /// instead of having to wrap them in a `TupleExprElementList`.
  /// The presence of the parenthesis will be inferred based on the presence of arguments and the trailing closure.
  public init<C: ExprSyntaxProtocol>(
    callee: C,
    trailingClosure: ClosureExprSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementListSyntax? = nil,
    @TupleExprElementListBuilder argumentList: () -> TupleExprElementListSyntax = { [] }
  ) {
    let argumentList = argumentList()
    let shouldOmitParens = argumentList.isEmpty && trailingClosure != nil
    self.init(
      calledExpression: callee,
      leftParen: shouldOmitParens ? nil : .leftParenToken(),
      argumentList: argumentList,
      rightParen: shouldOmitParens ? nil : .rightParenToken(),
      trailingClosure: trailingClosure,
      additionalTrailingClosures: additionalTrailingClosures
    )
  }
}

// MARK: - IntegerLiteralExpr

extension IntegerLiteralExprSyntax: ExpressibleByIntegerLiteral {
  public init(_ value: Int) {
    self.init(digits: .integerLiteral(String(value)))
  }

  public init(integerLiteral value: Int) {
    self.init(value)
  }
}

// MARK: - StringLiteralExpr

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
    openQuote: TokenSyntax = .stringQuoteToken(),
    content: String,
    closeQuote: TokenSyntax = .stringQuoteToken(),
    closeDelimiter: TokenSyntax? = nil
  ) {
    var openDelimiter = openDelimiter
    var closeDelimiter = closeDelimiter
    if openDelimiter == nil, closeDelimiter == nil {
      // Match potential escapes in the string
      let (requiresEscaping, poundCount) = Self.requiresEscaping(content)
      if requiresEscaping {
        // Use a delimiter that is exactly one longer
        openDelimiter = TokenSyntax.rawStringDelimiter(String(repeating: "#", count: poundCount + 1))
        closeDelimiter = openDelimiter
      }
    }

    let escapedContent = content.escapingForStringLiteral(usingDelimiter: closeDelimiter?.text ?? "", isMultiline: openQuote.tokenView.rawKind == .multilineStringQuote)
    let contentToken = TokenSyntax.stringSegment(escapedContent)
    let segment = StringSegmentSyntax(content: contentToken)
    let segments = StringLiteralSegmentsSyntax([.stringSegment(segment)])

    self.init(
      openDelimiter: openDelimiter,
      openQuote: openQuote,
      segments: segments,
      closeQuote: closeQuote,
      closeDelimiter: closeDelimiter
    )
  }
}

// MARK: - TupleExprElement

extension TupleExprElementSyntax {
  /// A convenience initializer that allows passing in label as an optional string.
  /// The presence of the colon will be inferred based on the presence of the label.
  public init<E: ExprSyntaxProtocol>(label: String? = nil, expression: E) {
    self.init(
      label: label.map { .identifier($0) },
      colon: label == nil ? nil : .colonToken(),
      expression: expression
    )
  }
}

// MARK: - VariableDecl

extension VariableDeclSyntax {
  /// Creates an optionally initialized property.
  public init(
    leadingTrivia: Trivia = [],
    attributes: AttributeListSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ bindingKeyword: Keyword,
    name: PatternSyntax,
    type: TypeAnnotationSyntax? = nil,
    initializer: InitializerClauseSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      attributes: attributes?.with(\.trailingTrivia, .space),
      modifiers: modifiers,
      bindingKeyword: .keyword(bindingKeyword)
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
