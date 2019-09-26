//// Automatically Generated From SyntaxClassifier.swift.gyb.
//// Do Not Edit Directly!
//===------------ SyntaxClassifier.swift.gyb - Syntax Collection ----------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2019 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

public enum SyntaxClassification {
  /// The token should not receive syntax coloring. 
  case none
  /// A Swift keyword, including contextual keywords. 
  case keyword
  /// A generic identifier. 
  case identifier
  /// An identifier referring to a type. 
  case typeIdentifier
  /// An identifier starting with `$` like `$0`. 
  case dollarIdentifier
  /// An integer literal. 
  case integerLiteral
  /// A floating point literal. 
  case floatingLiteral
  /// A string literal including multiline string literals. 
  case stringLiteral
  /// The opening and closing paranthesis of string interpolation. 
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
      case (.expressionSegment, 2):
        return (.stringInterpolationAnchor, true)
      case (.ifConfigClause, 0):
        return (.buildConfigId, false)
      case (.ifConfigDecl, 1):
        return (.buildConfigId, false)
      case (.declModifier, 0):
        return (.attribute, false)
      case (.precedenceGroupRelation, 0):
        return (.keyword, false)
      case (.precedenceGroupAssociativity, 0):
        return (.keyword, false)
      case (.attribute, 1):
        return (.attribute, false)
      case (.simpleTypeIdentifier, 0):
        return (.typeIdentifier, false)
      case (.memberTypeIdentifier, 2):
        return (.typeIdentifier, false)
      case (.someType, 0):
        return (.keyword, false)
      case (.availabilityVersionRestriction, 0):
        return (.keyword, false)
      default: return nil
      }
    } else {
      switch (parentKind, indexInParent) {
      case (.ifConfigClause, 1):
        return (.buildConfigId, false)
      case (.operatorDecl, 1):
        return (.attribute, false)
      case (.customAttribute, 1):
        return (.attribute, false)
      default: return nil
      }
    }
  }
}

extension RawTokenKind {
  internal var classification: SyntaxClassification {
    switch (self) {
    case .associatedtypeKeyword:
      return .keyword
    case .classKeyword:
      return .keyword
    case .deinitKeyword:
      return .keyword
    case .enumKeyword:
      return .keyword
    case .extensionKeyword:
      return .keyword
    case .funcKeyword:
      return .keyword
    case .importKeyword:
      return .keyword
    case .initKeyword:
      return .keyword
    case .inoutKeyword:
      return .keyword
    case .letKeyword:
      return .keyword
    case .operatorKeyword:
      return .keyword
    case .precedencegroupKeyword:
      return .keyword
    case .protocolKeyword:
      return .keyword
    case .structKeyword:
      return .keyword
    case .subscriptKeyword:
      return .keyword
    case .typealiasKeyword:
      return .keyword
    case .varKeyword:
      return .keyword
    case .fileprivateKeyword:
      return .keyword
    case .internalKeyword:
      return .keyword
    case .privateKeyword:
      return .keyword
    case .publicKeyword:
      return .keyword
    case .staticKeyword:
      return .keyword
    case .deferKeyword:
      return .keyword
    case .ifKeyword:
      return .keyword
    case .guardKeyword:
      return .keyword
    case .doKeyword:
      return .keyword
    case .repeatKeyword:
      return .keyword
    case .elseKeyword:
      return .keyword
    case .forKeyword:
      return .keyword
    case .inKeyword:
      return .keyword
    case .whileKeyword:
      return .keyword
    case .returnKeyword:
      return .keyword
    case .breakKeyword:
      return .keyword
    case .continueKeyword:
      return .keyword
    case .fallthroughKeyword:
      return .keyword
    case .switchKeyword:
      return .keyword
    case .caseKeyword:
      return .keyword
    case .defaultKeyword:
      return .keyword
    case .whereKeyword:
      return .keyword
    case .catchKeyword:
      return .keyword
    case .throwKeyword:
      return .keyword
    case .asKeyword:
      return .keyword
    case .anyKeyword:
      return .keyword
    case .falseKeyword:
      return .keyword
    case .isKeyword:
      return .keyword
    case .nilKeyword:
      return .keyword
    case .rethrowsKeyword:
      return .keyword
    case .superKeyword:
      return .keyword
    case .selfKeyword:
      return .keyword
    case .capitalSelfKeyword:
      return .keyword
    case .trueKeyword:
      return .keyword
    case .tryKeyword:
      return .keyword
    case .throwsKeyword:
      return .keyword
    case .__file__Keyword:
      return .keyword
    case .__line__Keyword:
      return .keyword
    case .__column__Keyword:
      return .keyword
    case .__function__Keyword:
      return .keyword
    case .__dso_handle__Keyword:
      return .keyword
    case .wildcardKeyword:
      return .keyword
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
    case .prefixPeriod:
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
    case .poundKeyPathKeyword:
      return .keyword
    case .poundLineKeyword:
      return .keyword
    case .poundSelectorKeyword:
      return .keyword
    case .poundFileKeyword:
      return .keyword
    case .poundColumnKeyword:
      return .keyword
    case .poundFunctionKeyword:
      return .keyword
    case .poundDsohandleKeyword:
      return .keyword
    case .poundAssertKeyword:
      return .keyword
    case .poundSourceLocationKeyword:
      return .poundDirectiveKeyword
    case .poundWarningKeyword:
      return .poundDirectiveKeyword
    case .poundErrorKeyword:
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
    case .poundFileLiteralKeyword:
      return .objectLiteral
    case .poundImageLiteralKeyword:
      return .objectLiteral
    case .poundColorLiteralKeyword:
      return .objectLiteral
    case .integerLiteral:
      return .integerLiteral
    case .floatingLiteral:
      return .floatingLiteral
    case .stringLiteral:
      return .stringLiteral
    case .unknown:
      return .none
    case .identifier:
      return .identifier
    case .unspacedBinaryOperator:
      return .none
    case .spacedBinaryOperator:
      return .none
    case .postfixOperator:
      return .none
    case .prefixOperator:
      return .none
    case .dollarIdentifier:
      return .dollarIdentifier
    case .contextualKeyword:
      return .keyword
    case .rawStringDelimiter:
      return .none
    case .stringSegment:
      return .stringLiteral
    case .stringInterpolationAnchor:
      return .stringInterpolationAnchor
    case .yield:
      return .none
    case .eof:
      return .none
    }
  }
}
