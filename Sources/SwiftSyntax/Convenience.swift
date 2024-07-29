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

extension EnumCaseParameterSyntax {

  /// Creates an ``EnumCaseParameterSyntax`` with a `firstName`, and automatically adds a `colon` to it.
  ///
  ///  - SeeAlso: For more information on the arguments, see ``EnumCaseParameterSyntax/init(leadingTrivia:_:modifiers:_:firstName:_:secondName:_:colon:_:type:_:defaultArgument:_:trailingComma:_:trailingTrivia:)``
  ///
  public init(
    leadingTrivia: Trivia? = nil,
    modifiers: DeclModifierListSyntax = [],
    firstName: TokenSyntax,
    secondName: TokenSyntax? = nil,
    colon: TokenSyntax = TokenSyntax.colonToken(),
    type: some TypeSyntaxProtocol,
    defaultValue: InitializerClauseSyntax? = nil,
    trailingComma: TokenSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      modifiers: modifiers,
      firstName: firstName as TokenSyntax?,
      secondName: secondName,
      colon: colon,
      type: type,
      defaultValue: defaultValue,
      trailingComma: trailingComma,
      trailingTrivia: trailingTrivia
    )
  }
}

extension FloatLiteralExprSyntax {
  ///  A computed property representing the floating-point value parsed from the associated `literal.text` property.
  ///
  /// - Returns: A double value parsed from the associated`literal.text`, or `nil` if the text cannot be parsed as a double.
  public var representedLiteralValue: Double? {
    guard !hasError else { return nil }

    let floatingDigitsWithoutUnderscores = literal.text.filter {
      $0 != "_"
    }

    return Double(floatingDigitsWithoutUnderscores)
  }
}

extension IntegerLiteralExprSyntax {
  public enum Radix: Sendable {
    case binary
    case octal
    case decimal
    case hex

    public var size: Int {
      switch self {
      case .binary: return 2
      case .octal: return 8
      case .decimal: return 10
      case .hex: return 16
      }
    }

    /// The prefix that is used to express an integer literal with this
    /// radix in Swift source code, e.g., "0x" for hexadecimal.
    public var literalPrefix: String {
      switch self {
      case .binary: return "0b"
      case .octal: return "0o"
      case .hex: return "0x"
      case .decimal: return ""
      }
    }

    fileprivate var offset: Int {
      switch self {
      case .binary, .hex, .octal:
        return 2
      case .decimal:
        return 0
      }
    }
  }

  public var radix: Radix {
    let text = self.literal.text
    if text.starts(with: "0b") {
      return .binary
    } else if text.starts(with: "0o") {
      return .octal
    } else if text.starts(with: "0x") {
      return .hex
    } else {
      return .decimal
    }
  }

  /// A computed property representing the integer value parsed from the associated `literal.text` property, considering the specified radix.
  ///
  /// - Returns: An integer value parsed from the associated `literal.text`, or `nil` if the text cannot be parsed as an integer.
  public var representedLiteralValue: Int? {
    guard !hasError else { return nil }

    let text = literal.text
    let radix = self.radix
    let digitsStartIndex = text.index(text.startIndex, offsetBy: radix.offset)
    let textWithoutPrefix = text.suffix(from: digitsStartIndex)

    let textWithoutPrefixOrUnderscores = textWithoutPrefix.filter {
      $0 != "_"
    }

    return Int(textWithoutPrefixOrUnderscores, radix: radix.size)
  }
}

extension MemberAccessExprSyntax {
  /// Creates a new ``MemberAccessExprSyntax`` where the accessed member is represented by
  /// an identifier without specifying argument labels.
  ///
  /// A member access can specify function argument labels, which is required
  /// when the name would be ambiguous otherwise. For example, given multiple overloads
  /// ```swift
  /// struct Person {
  ///   func consume(drink: Drink) {}
  ///   func consume(food: Food) {}
  /// }
  /// ```
  ///
  /// `consume(drink:)` is required to explicitly reference the consume function
  /// that takes a drink.
  ///
  /// Given how common it is to not need the argument names, this initializer is
  /// provided as a convenience to avoid having to create a ``DeclReferenceExprSyntax``
  /// for the member name.
  public init(
    leadingTrivia: Trivia? = nil,
    base: (some ExprSyntaxProtocol)? = ExprSyntax?.none,
    period: TokenSyntax = .periodToken(),
    name: TokenSyntax,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      base: base,
      period: period,
      declName: DeclReferenceExprSyntax(baseName: name),
      trailingTrivia: trailingTrivia
    )
  }
}

//==========================================================================//
// IMPORTANT: If you are tempted to add an extension here, please insert    //
// it in alphabetical order above                                           //
//==========================================================================//
