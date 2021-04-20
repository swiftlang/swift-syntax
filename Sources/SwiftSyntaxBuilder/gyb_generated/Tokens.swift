//// Automatically Generated From Tokens.swift.gyb.
//// Do Not Edit Directly!
//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2021 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

/// Namespace for commonly used tokens with default trivia.
public enum Tokens {
  /// The `associatedtype` keyword
  public static let `associatedtype` = SyntaxFactory.makeAssociatedtypeKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `class` keyword
  public static let `class` = SyntaxFactory.makeClassKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `deinit` keyword
  public static let `deinit` = SyntaxFactory.makeDeinitKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `enum` keyword
  public static let `enum` = SyntaxFactory.makeEnumKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `extension` keyword
  public static let `extension` = SyntaxFactory.makeExtensionKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `func` keyword
  public static let `func` = SyntaxFactory.makeFuncKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `import` keyword
  public static let `import` = SyntaxFactory.makeImportKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `init` keyword
  public static let `init` = SyntaxFactory.makeInitKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `inout` keyword
  public static let `inout` = SyntaxFactory.makeInoutKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `let` keyword
  public static let `let` = SyntaxFactory.makeLetKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `operator` keyword
  public static let `operator` = SyntaxFactory.makeOperatorKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `precedencegroup` keyword
  public static let `precedencegroup` = SyntaxFactory.makePrecedencegroupKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `protocol` keyword
  public static let `protocol` = SyntaxFactory.makeProtocolKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `struct` keyword
  public static let `struct` = SyntaxFactory.makeStructKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `subscript` keyword
  public static let `subscript` = SyntaxFactory.makeSubscriptKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `typealias` keyword
  public static let `typealias` = SyntaxFactory.makeTypealiasKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `var` keyword
  public static let `var` = SyntaxFactory.makeVarKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `fileprivate` keyword
  public static let `fileprivate` = SyntaxFactory.makeFileprivateKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `internal` keyword
  public static let `internal` = SyntaxFactory.makeInternalKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `private` keyword
  public static let `private` = SyntaxFactory.makePrivateKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `public` keyword
  public static let `public` = SyntaxFactory.makePublicKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `static` keyword
  public static let `static` = SyntaxFactory.makeStaticKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `defer` keyword
  public static let `defer` = SyntaxFactory.makeDeferKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `if` keyword
  public static let `if` = SyntaxFactory.makeIfKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `guard` keyword
  public static let `guard` = SyntaxFactory.makeGuardKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `do` keyword
  public static let `do` = SyntaxFactory.makeDoKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `repeat` keyword
  public static let `repeat` = SyntaxFactory.makeRepeatKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `else` keyword
  public static let `else` = SyntaxFactory.makeElseKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `for` keyword
  public static let `for` = SyntaxFactory.makeForKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `in` keyword
  public static let `in` = SyntaxFactory.makeInKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `while` keyword
  public static let `while` = SyntaxFactory.makeWhileKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `return` keyword
  public static let `return` = SyntaxFactory.makeReturnKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `break` keyword
  public static let `break` = SyntaxFactory.makeBreakKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `continue` keyword
  public static let `continue` = SyntaxFactory.makeContinueKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `fallthrough` keyword
  public static let `fallthrough` = SyntaxFactory.makeFallthroughKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `switch` keyword
  public static let `switch` = SyntaxFactory.makeSwitchKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `case` keyword
  public static let `case` = SyntaxFactory.makeCaseKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `default` keyword
  public static let `default` = SyntaxFactory.makeDefaultKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `where` keyword
  public static let `where` = SyntaxFactory.makeWhereKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `catch` keyword
  public static let `catch` = SyntaxFactory.makeCatchKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `throw` keyword
  public static let `throw` = SyntaxFactory.makeThrowKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `as` keyword
  public static let `as` = SyntaxFactory.makeAsKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `Any` keyword
  public static let `any` = SyntaxFactory.makeAnyKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `false` keyword
  public static let `false` = SyntaxFactory.makeFalseKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `is` keyword
  public static let `is` = SyntaxFactory.makeIsKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `nil` keyword
  public static let `nil` = SyntaxFactory.makeNilKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `rethrows` keyword
  public static let `rethrows` = SyntaxFactory.makeRethrowsKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `super` keyword
  public static let `super` = SyntaxFactory.makeSuperKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `self` keyword
  public static let `self` = SyntaxFactory.makeSelfKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `Self` keyword
  public static let `capitalSelf` = SyntaxFactory.makeCapitalSelfKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `true` keyword
  public static let `true` = SyntaxFactory.makeTrueKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `try` keyword
  public static let `try` = SyntaxFactory.makeTryKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `throws` keyword
  public static let `throws` = SyntaxFactory.makeThrowsKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `__FILE__` keyword
  public static let `__file__` = SyntaxFactory.make__FILE__Keyword()
    .withTrailingTrivia(.spaces(1))

  /// The `__LINE__` keyword
  public static let `__line__` = SyntaxFactory.make__LINE__Keyword()
    .withTrailingTrivia(.spaces(1))

  /// The `__COLUMN__` keyword
  public static let `__column__` = SyntaxFactory.make__COLUMN__Keyword()
    .withTrailingTrivia(.spaces(1))

  /// The `__FUNCTION__` keyword
  public static let `__function__` = SyntaxFactory.make__FUNCTION__Keyword()
    .withTrailingTrivia(.spaces(1))

  /// The `__DSO_HANDLE__` keyword
  public static let `__dso_handle__` = SyntaxFactory.make__DSO_HANDLE__Keyword()
    .withTrailingTrivia(.spaces(1))

  /// The `_` keyword
  public static let `wildcard` = SyntaxFactory.makeWildcardKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `(` token
  public static let `leftParen` = SyntaxFactory.makeLeftParenToken()

  /// The `)` token
  public static let `rightParen` = SyntaxFactory.makeRightParenToken()

  /// The `{` token
  public static let `leftBrace` = SyntaxFactory.makeLeftBraceToken()

  /// The `}` token
  public static let `rightBrace` = SyntaxFactory.makeRightBraceToken()

  /// The `[` token
  public static let `leftSquareBracket` = SyntaxFactory.makeLeftSquareBracketToken()

  /// The `]` token
  public static let `rightSquareBracket` = SyntaxFactory.makeRightSquareBracketToken()

  /// The `<` token
  public static let `leftAngle` = SyntaxFactory.makeLeftAngleToken()
    .withLeadingTrivia(.spaces(1))
    .withTrailingTrivia(.spaces(1))

  /// The `>` token
  public static let `rightAngle` = SyntaxFactory.makeRightAngleToken()
    .withLeadingTrivia(.spaces(1))
    .withTrailingTrivia(.spaces(1))

  /// The `.` token
  public static let `period` = SyntaxFactory.makePeriodToken()

  /// The `.` token
  public static let `prefixPeriod` = SyntaxFactory.makePrefixPeriodToken()

  /// The `,` token
  public static let `comma` = SyntaxFactory.makeCommaToken()
    .withTrailingTrivia(.spaces(1))

  /// The `...` token
  public static let `ellipsis` = SyntaxFactory.makeEllipsisToken()

  /// The `:` token
  public static let `colon` = SyntaxFactory.makeColonToken()
    .withTrailingTrivia(.spaces(1))

  /// The `;` token
  public static let `semicolon` = SyntaxFactory.makeSemicolonToken()

  /// The `=` token
  public static let `equal` = SyntaxFactory.makeEqualToken()
    .withLeadingTrivia(.spaces(1))
    .withTrailingTrivia(.spaces(1))

  /// The `@` token
  public static let `atSign` = SyntaxFactory.makeAtSignToken()

  /// The `#` token
  public static let `pound` = SyntaxFactory.makePoundToken()

  /// The `&` token
  public static let `prefixAmpersand` = SyntaxFactory.makePrefixAmpersandToken()
    .withLeadingTrivia(.spaces(1))
    .withTrailingTrivia(.spaces(1))

  /// The `->` token
  public static let `arrow` = SyntaxFactory.makeArrowToken()
    .withTrailingTrivia(.spaces(1))

  /// The ``` token
  public static let `backtick` = SyntaxFactory.makeBacktickToken()

  /// The `\` token
  public static let `backslash` = SyntaxFactory.makeBackslashToken()

  /// The `!` token
  public static let `exclamationMark` = SyntaxFactory.makeExclamationMarkToken()

  /// The `?` token
  public static let `postfixQuestionMark` = SyntaxFactory.makePostfixQuestionMarkToken()

  /// The `?` token
  public static let `infixQuestionMark` = SyntaxFactory.makeInfixQuestionMarkToken()

  /// The `"` token
  public static let `stringQuote` = SyntaxFactory.makeStringQuoteToken()

  /// The `'` token
  public static let `singleQuote` = SyntaxFactory.makeSingleQuoteToken()

  /// The `"""` token
  public static let `multilineStringQuote` = SyntaxFactory.makeMultilineStringQuoteToken()

  /// The `#keyPath` keyword
  public static let `poundKeyPath` = SyntaxFactory.makePoundKeyPathKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#line` keyword
  public static let `poundLine` = SyntaxFactory.makePoundLineKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#selector` keyword
  public static let `poundSelector` = SyntaxFactory.makePoundSelectorKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#file` keyword
  public static let `poundFile` = SyntaxFactory.makePoundFileKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#fileID` keyword
  public static let `poundFileID` = SyntaxFactory.makePoundFileIDKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#filePath` keyword
  public static let `poundFilePath` = SyntaxFactory.makePoundFilePathKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#column` keyword
  public static let `poundColumn` = SyntaxFactory.makePoundColumnKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#function` keyword
  public static let `poundFunction` = SyntaxFactory.makePoundFunctionKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#dsohandle` keyword
  public static let `poundDsohandle` = SyntaxFactory.makePoundDsohandleKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#assert` keyword
  public static let `poundAssert` = SyntaxFactory.makePoundAssertKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#sourceLocation` keyword
  public static let `poundSourceLocation` = SyntaxFactory.makePoundSourceLocationKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#warning` keyword
  public static let `poundWarning` = SyntaxFactory.makePoundWarningKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#error` keyword
  public static let `poundError` = SyntaxFactory.makePoundErrorKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#if` keyword
  public static let `poundIf` = SyntaxFactory.makePoundIfKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#else` keyword
  public static let `poundElse` = SyntaxFactory.makePoundElseKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#elseif` keyword
  public static let `poundElseif` = SyntaxFactory.makePoundElseifKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#endif` keyword
  public static let `poundEndif` = SyntaxFactory.makePoundEndifKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#available` keyword
  public static let `poundAvailable` = SyntaxFactory.makePoundAvailableKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#fileLiteral` keyword
  public static let `poundFileLiteral` = SyntaxFactory.makePoundFileLiteralKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#imageLiteral` keyword
  public static let `poundImageLiteral` = SyntaxFactory.makePoundImageLiteralKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#colorLiteral` keyword
  public static let `poundColorLiteral` = SyntaxFactory.makePoundColorLiteralKeyword()
    .withTrailingTrivia(.spaces(1))

  public static func `integerLiteral`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeIntegerLiteral(text)
  }

  public static func `floatingLiteral`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeFloatingLiteral(text)
  }

  public static func `stringLiteral`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeStringLiteral(text)
  }

  public static func `unknown`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeUnknown(text)
  }

  public static func `identifier`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeIdentifier(text)
  }

  public static func `unspacedBinaryOperator`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeUnspacedBinaryOperator(text)
  }

  public static func `spacedBinaryOperator`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeSpacedBinaryOperator(text)
  }

  public static func `postfixOperator`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makePostfixOperator(text)
  }

  public static func `prefixOperator`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makePrefixOperator(text)
  }

  public static func `dollarIdentifier`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeDollarIdentifier(text)
  }

  public static func `contextualKeyword`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeContextualKeyword(text)
  }

  public static func `rawStringDelimiter`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeRawStringDelimiter(text)
  }

  public static func `stringSegment`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeStringSegment(text)
  }

  /// The `)` token
  public static let `stringInterpolationAnchor` = SyntaxFactory.makeStringInterpolationAnchorToken()

  /// The `yield` token
  public static let `yield` = SyntaxFactory.makeYieldToken()

}
