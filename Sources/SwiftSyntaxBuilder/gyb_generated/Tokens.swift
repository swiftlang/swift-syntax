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
public extension TokenSyntax {
  /// The `associatedtype` keyword
  static let `associatedtype` = SyntaxFactory.makeAssociatedtypeKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `class` keyword
  static let `class` = SyntaxFactory.makeClassKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `deinit` keyword
  static let `deinit` = SyntaxFactory.makeDeinitKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `enum` keyword
  static let `enum` = SyntaxFactory.makeEnumKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `extension` keyword
  static let `extension` = SyntaxFactory.makeExtensionKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `func` keyword
  static let `func` = SyntaxFactory.makeFuncKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `import` keyword
  static let `import` = SyntaxFactory.makeImportKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `init` keyword
  static let `init` = SyntaxFactory.makeInitKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `inout` keyword
  static let `inout` = SyntaxFactory.makeInoutKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `let` keyword
  static let `let` = SyntaxFactory.makeLetKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `operator` keyword
  static let `operator` = SyntaxFactory.makeOperatorKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `precedencegroup` keyword
  static let `precedencegroup` = SyntaxFactory.makePrecedencegroupKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `protocol` keyword
  static let `protocol` = SyntaxFactory.makeProtocolKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `struct` keyword
  static let `struct` = SyntaxFactory.makeStructKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `subscript` keyword
  static let `subscript` = SyntaxFactory.makeSubscriptKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `typealias` keyword
  static let `typealias` = SyntaxFactory.makeTypealiasKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `var` keyword
  static let `var` = SyntaxFactory.makeVarKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `fileprivate` keyword
  static let `fileprivate` = SyntaxFactory.makeFileprivateKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `internal` keyword
  static let `internal` = SyntaxFactory.makeInternalKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `private` keyword
  static let `private` = SyntaxFactory.makePrivateKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `public` keyword
  static let `public` = SyntaxFactory.makePublicKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `static` keyword
  static let `static` = SyntaxFactory.makeStaticKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `defer` keyword
  static let `defer` = SyntaxFactory.makeDeferKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `if` keyword
  static let `if` = SyntaxFactory.makeIfKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `guard` keyword
  static let `guard` = SyntaxFactory.makeGuardKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `do` keyword
  static let `do` = SyntaxFactory.makeDoKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `repeat` keyword
  static let `repeat` = SyntaxFactory.makeRepeatKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `else` keyword
  static let `else` = SyntaxFactory.makeElseKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `for` keyword
  static let `for` = SyntaxFactory.makeForKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `in` keyword
  static let `in` = SyntaxFactory.makeInKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `while` keyword
  static let `while` = SyntaxFactory.makeWhileKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `return` keyword
  static let `return` = SyntaxFactory.makeReturnKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `break` keyword
  static let `break` = SyntaxFactory.makeBreakKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `continue` keyword
  static let `continue` = SyntaxFactory.makeContinueKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `fallthrough` keyword
  static let `fallthrough` = SyntaxFactory.makeFallthroughKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `switch` keyword
  static let `switch` = SyntaxFactory.makeSwitchKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `case` keyword
  static let `case` = SyntaxFactory.makeCaseKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `default` keyword
  static let `default` = SyntaxFactory.makeDefaultKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `where` keyword
  static let `where` = SyntaxFactory.makeWhereKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `catch` keyword
  static let `catch` = SyntaxFactory.makeCatchKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `throw` keyword
  static let `throw` = SyntaxFactory.makeThrowKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `as` keyword
  static let `as` = SyntaxFactory.makeAsKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `Any` keyword
  static let `any` = SyntaxFactory.makeAnyKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `false` keyword
  static let `false` = SyntaxFactory.makeFalseKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `is` keyword
  static let `is` = SyntaxFactory.makeIsKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `nil` keyword
  static let `nil` = SyntaxFactory.makeNilKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `rethrows` keyword
  static let `rethrows` = SyntaxFactory.makeRethrowsKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `super` keyword
  static let `super` = SyntaxFactory.makeSuperKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `self` keyword
  static let `self` = SyntaxFactory.makeSelfKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `Self` keyword
  static let `capitalSelf` = SyntaxFactory.makeCapitalSelfKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `true` keyword
  static let `true` = SyntaxFactory.makeTrueKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `try` keyword
  static let `try` = SyntaxFactory.makeTryKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `throws` keyword
  static let `throws` = SyntaxFactory.makeThrowsKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `__FILE__` keyword
  static let `__file__` = SyntaxFactory.make__FILE__Keyword()
    .withTrailingTrivia(.spaces(1))

  /// The `__LINE__` keyword
  static let `__line__` = SyntaxFactory.make__LINE__Keyword()
    .withTrailingTrivia(.spaces(1))

  /// The `__COLUMN__` keyword
  static let `__column__` = SyntaxFactory.make__COLUMN__Keyword()
    .withTrailingTrivia(.spaces(1))

  /// The `__FUNCTION__` keyword
  static let `__function__` = SyntaxFactory.make__FUNCTION__Keyword()
    .withTrailingTrivia(.spaces(1))

  /// The `__DSO_HANDLE__` keyword
  static let `__dso_handle__` = SyntaxFactory.make__DSO_HANDLE__Keyword()
    .withTrailingTrivia(.spaces(1))

  /// The `_` keyword
  static let `wildcard` = SyntaxFactory.makeWildcardKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `(` token
  static let `leftParen` = SyntaxFactory.makeLeftParenToken()

  /// The `)` token
  static let `rightParen` = SyntaxFactory.makeRightParenToken()

  /// The `{` token
  static let `leftBrace` = SyntaxFactory.makeLeftBraceToken()

  /// The `}` token
  static let `rightBrace` = SyntaxFactory.makeRightBraceToken()

  /// The `[` token
  static let `leftSquareBracket` = SyntaxFactory.makeLeftSquareBracketToken()

  /// The `]` token
  static let `rightSquareBracket` = SyntaxFactory.makeRightSquareBracketToken()

  /// The `<` token
  static let `leftAngle` = SyntaxFactory.makeLeftAngleToken()
    .withLeadingTrivia(.spaces(1))
    .withTrailingTrivia(.spaces(1))

  /// The `>` token
  static let `rightAngle` = SyntaxFactory.makeRightAngleToken()
    .withLeadingTrivia(.spaces(1))
    .withTrailingTrivia(.spaces(1))

  /// The `.` token
  static let `period` = SyntaxFactory.makePeriodToken()

  /// The `.` token
  static let `prefixPeriod` = SyntaxFactory.makePrefixPeriodToken()

  /// The `,` token
  static let `comma` = SyntaxFactory.makeCommaToken()
    .withTrailingTrivia(.spaces(1))

  /// The `...` token
  static let `ellipsis` = SyntaxFactory.makeEllipsisToken()

  /// The `:` token
  static let `colon` = SyntaxFactory.makeColonToken()
    .withTrailingTrivia(.spaces(1))

  /// The `;` token
  static let `semicolon` = SyntaxFactory.makeSemicolonToken()

  /// The `=` token
  static let `equal` = SyntaxFactory.makeEqualToken()
    .withLeadingTrivia(.spaces(1))
    .withTrailingTrivia(.spaces(1))

  /// The `@` token
  static let `atSign` = SyntaxFactory.makeAtSignToken()

  /// The `#` token
  static let `pound` = SyntaxFactory.makePoundToken()

  /// The `&` token
  static let `prefixAmpersand` = SyntaxFactory.makePrefixAmpersandToken()
    .withLeadingTrivia(.spaces(1))
    .withTrailingTrivia(.spaces(1))

  /// The `->` token
  static let `arrow` = SyntaxFactory.makeArrowToken()
    .withTrailingTrivia(.spaces(1))

  /// The ``` token
  static let `backtick` = SyntaxFactory.makeBacktickToken()

  /// The `\` token
  static let `backslash` = SyntaxFactory.makeBackslashToken()

  /// The `!` token
  static let `exclamationMark` = SyntaxFactory.makeExclamationMarkToken()

  /// The `?` token
  static let `postfixQuestionMark` = SyntaxFactory.makePostfixQuestionMarkToken()

  /// The `?` token
  static let `infixQuestionMark` = SyntaxFactory.makeInfixQuestionMarkToken()

  /// The `"` token
  static let `stringQuote` = SyntaxFactory.makeStringQuoteToken()

  /// The `'` token
  static let `singleQuote` = SyntaxFactory.makeSingleQuoteToken()

  /// The `"""` token
  static let `multilineStringQuote` = SyntaxFactory.makeMultilineStringQuoteToken()

  /// The `#keyPath` keyword
  static let `poundKeyPath` = SyntaxFactory.makePoundKeyPathKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#line` keyword
  static let `poundLine` = SyntaxFactory.makePoundLineKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#selector` keyword
  static let `poundSelector` = SyntaxFactory.makePoundSelectorKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#file` keyword
  static let `poundFile` = SyntaxFactory.makePoundFileKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#fileID` keyword
  static let `poundFileID` = SyntaxFactory.makePoundFileIDKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#filePath` keyword
  static let `poundFilePath` = SyntaxFactory.makePoundFilePathKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#column` keyword
  static let `poundColumn` = SyntaxFactory.makePoundColumnKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#function` keyword
  static let `poundFunction` = SyntaxFactory.makePoundFunctionKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#dsohandle` keyword
  static let `poundDsohandle` = SyntaxFactory.makePoundDsohandleKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#assert` keyword
  static let `poundAssert` = SyntaxFactory.makePoundAssertKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#sourceLocation` keyword
  static let `poundSourceLocation` = SyntaxFactory.makePoundSourceLocationKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#warning` keyword
  static let `poundWarning` = SyntaxFactory.makePoundWarningKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#error` keyword
  static let `poundError` = SyntaxFactory.makePoundErrorKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#if` keyword
  static let `poundIf` = SyntaxFactory.makePoundIfKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#else` keyword
  static let `poundElse` = SyntaxFactory.makePoundElseKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#elseif` keyword
  static let `poundElseif` = SyntaxFactory.makePoundElseifKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#endif` keyword
  static let `poundEndif` = SyntaxFactory.makePoundEndifKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#available` keyword
  static let `poundAvailable` = SyntaxFactory.makePoundAvailableKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#unavailable` keyword
  static let `poundUnavailable` = SyntaxFactory.makePoundUnavailableKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#fileLiteral` keyword
  static let `poundFileLiteral` = SyntaxFactory.makePoundFileLiteralKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#imageLiteral` keyword
  static let `poundImageLiteral` = SyntaxFactory.makePoundImageLiteralKeyword()
    .withTrailingTrivia(.spaces(1))

  /// The `#colorLiteral` keyword
  static let `poundColorLiteral` = SyntaxFactory.makePoundColorLiteralKeyword()
    .withTrailingTrivia(.spaces(1))

  static func `integerLiteral`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeIntegerLiteral(text)
  }

  static func `floatingLiteral`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeFloatingLiteral(text)
  }

  static func `stringLiteral`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeStringLiteral(text)
  }

  static func `unknown`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeUnknown(text)
  }

  static func `identifier`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeIdentifier(text)
  }

  static func `unspacedBinaryOperator`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeUnspacedBinaryOperator(text)
  }

  static func `spacedBinaryOperator`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeSpacedBinaryOperator(text)
  }

  static func `postfixOperator`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makePostfixOperator(text)
  }

  static func `prefixOperator`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makePrefixOperator(text)
  }

  static func `dollarIdentifier`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeDollarIdentifier(text)
  }

  static func `contextualKeyword`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeContextualKeyword(text)
  }

  static func `rawStringDelimiter`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeRawStringDelimiter(text)
  }

  static func `stringSegment`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeStringSegment(text)
  }

  /// The `)` token
  static let `stringInterpolationAnchor` = SyntaxFactory.makeStringInterpolationAnchorToken()

  /// The `yield` token
  static let `yield` = SyntaxFactory.makeYieldToken()

  /// The `eof` token
  static let eof = SyntaxFactory.makeToken(.eof, presence: .present)
}
