
//// Automatically Generated by generate-ideutils
//// Do Not Edit Directly!
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


@_spi(RawSyntax) import SwiftSyntax

public enum SyntaxClassification {
  /// The token should not receive syntax coloring.
  case none
  
  /// A Swift keyword, including contextual keywords.
  case keyword
  
  /// A generic identifier.
  case identifier
  
  /// An identifier referring to a type.
  case typeIdentifier
  
  /// An identifier referring to an operator.
  case operatorIdentifier
  
  /// An identifier starting with `$` like `$0`.
  case dollarIdentifier
  
  /// An integer literal.
  case integerLiteral
  
  /// A floating point literal.
  case floatingLiteral
  
  /// A string literal including multiline string literals.
  case stringLiteral
  
  /// The opening and closing parenthesis of string interpolation.
  case stringInterpolationAnchor
  
  /// A `#` keyword like `#warning`.
  case poundDirectiveKeyword
  
  /// A build configuration directive like `#if`, `#elseif`, `#else`.
  case buildConfigId
  
  /// An attribute starting with an `@`.
  case attribute
  
  /// An image, color, etc. literal.
  case objectLiteral
  
  /// An editor placeholder of the form `<#content#>`
  case editorPlaceholder
  
  /// A line comment starting with `//`.
  case lineComment
  
  /// A doc line comment starting with `///`.
  case docLineComment
  
  /// A block comment starting with `/**` and ending with `*/.
  case blockComment
  
  /// A doc block comment starting with `/**` and ending with `*/.
  case docBlockComment
}

extension SyntaxClassification {
  /// Checks if a node has a classification attached via its syntax definition.
  /// - Parameters:
  ///   - parentKind: The parent node syntax kind.
  ///   - indexInParent: The index of the node in its parent.
  ///   - childKind: The node syntax kind.
  /// - Returns: A pair of classification and whether it is "forced", or nil if
  ///   no classification is attached.
  internal static func classify(
    parentKind: SyntaxKind, indexInParent: Int, childKind: SyntaxKind
  ) -> (SyntaxClassification, Bool)? {
    // Separate checks for token nodes (most common checks) versus checks for layout nodes.
    if childKind == .token {
      switch (parentKind, indexInParent) {
      case (.availabilityVersionRestriction, 1):
        return (.keyword, false)
      case (.declModifier, 1):
        return (.attribute, false)
      case (.expressionSegment, 5):
        return (.stringInterpolationAnchor, true)
      case (.expressionSegment, 9):
        return (.stringInterpolationAnchor, true)
      case (.forInStmt, 5):
        return (.keyword, false)
      case (.ifConfigClause, 1):
        return (.buildConfigId, false)
      case (.ifConfigDecl, 3):
        return (.buildConfigId, false)
      case (.memberTypeIdentifier, 5):
        return (.typeIdentifier, false)
      case (.operatorDecl, 7):
        return (.operatorIdentifier, false)
      case (.precedenceGroupAssociativity, 1):
        return (.keyword, false)
      case (.precedenceGroupRelation, 1):
        return (.keyword, false)
      case (.simpleTypeIdentifier, 1):
        return (.typeIdentifier, false)
      default: 
        return nil
      }
    }else {
      switch (parentKind, indexInParent) {
      case (.attribute, 3):
        return (.attribute, false)
      case (.availabilityVersionRestrictionListEntry, 1):
        return (.keyword, false)
      case (.ifConfigClause, 3):
        return (.buildConfigId, false)
      case (.operatorDecl, 3):
        return (.attribute, false)
      default: 
        return nil
      }
    }
  }
}

extension RawTokenKind {
  internal var classification: SyntaxClassification {
    switch self {
    case .wildcard:
      return .none
    case .leftParen:
      return .none
    case .rightParen:
      return .none
    case .leftBrace:
      return .none
    case .rightBrace:
      return .none
    case .leftSquareBracket:
      return .none
    case .rightSquareBracket:
      return .none
    case .leftAngle:
      return .none
    case .rightAngle:
      return .none
    case .period:
      return .none
    case .comma:
      return .none
    case .ellipsis:
      return .none
    case .colon:
      return .none
    case .semicolon:
      return .none
    case .equal:
      return .none
    case .atSign:
      return .attribute
    case .pound:
      return .none
    case .prefixAmpersand:
      return .none
    case .arrow:
      return .none
    case .backtick:
      return .none
    case .backslash:
      return .none
    case .exclamationMark:
      return .none
    case .postfixQuestionMark:
      return .none
    case .infixQuestionMark:
      return .none
    case .stringQuote:
      return .stringLiteral
    case .singleQuote:
      return .stringLiteral
    case .multilineStringQuote:
      return .stringLiteral
    case .poundSourceLocationKeyword:
      return .poundDirectiveKeyword
    case .poundIfKeyword:
      return .poundDirectiveKeyword
    case .poundElseKeyword:
      return .poundDirectiveKeyword
    case .poundElseifKeyword:
      return .poundDirectiveKeyword
    case .poundEndifKeyword:
      return .poundDirectiveKeyword
    case .poundAvailableKeyword:
      return .keyword
    case .poundUnavailableKeyword:
      return .keyword
    case .integerLiteral:
      return .integerLiteral
    case .floatingLiteral:
      return .floatingLiteral
    case .regexLiteral:
      return .none
    case .unknown:
      return .none
    case .identifier:
      return .identifier
    case .binaryOperator:
      return .operatorIdentifier
    case .postfixOperator:
      return .operatorIdentifier
    case .prefixOperator:
      return .operatorIdentifier
    case .dollarIdentifier:
      return .dollarIdentifier
    case .keyword:
      return .keyword
    case .rawStringDelimiter:
      return .none
    case .stringSegment:
      return .stringLiteral
    case .eof:
      return .none
    }
  }
}
