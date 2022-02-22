//// Automatically Generated From Tokens.swift.gyb.
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

import SwiftSyntax

/// Namespace for commonly used tokens with default trivia.
public extension TokenSyntax {
  /// The `associatedtype` keyword
  static var `associatedtype`: TokenSyntax {
    SyntaxFactory.makeAssociatedtypeKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `class` keyword
  static var `class`: TokenSyntax {
    SyntaxFactory.makeClassKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `deinit` keyword
  static var `deinit`: TokenSyntax {
    SyntaxFactory.makeDeinitKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `enum` keyword
  static var `enum`: TokenSyntax {
    SyntaxFactory.makeEnumKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `extension` keyword
  static var `extension`: TokenSyntax {
    SyntaxFactory.makeExtensionKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `func` keyword
  static var `func`: TokenSyntax {
    SyntaxFactory.makeFuncKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `import` keyword
  static var `import`: TokenSyntax {
    SyntaxFactory.makeImportKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `init` keyword
  static var `init`: TokenSyntax {
    SyntaxFactory.makeInitKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `inout` keyword
  static var `inout`: TokenSyntax {
    SyntaxFactory.makeInoutKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `let` keyword
  static var `let`: TokenSyntax {
    SyntaxFactory.makeLetKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `operator` keyword
  static var `operator`: TokenSyntax {
    SyntaxFactory.makeOperatorKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `precedencegroup` keyword
  static var `precedencegroup`: TokenSyntax {
    SyntaxFactory.makePrecedencegroupKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `protocol` keyword
  static var `protocol`: TokenSyntax {
    SyntaxFactory.makeProtocolKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `struct` keyword
  static var `struct`: TokenSyntax {
    SyntaxFactory.makeStructKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `subscript` keyword
  static var `subscript`: TokenSyntax {
    SyntaxFactory.makeSubscriptKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `typealias` keyword
  static var `typealias`: TokenSyntax {
    SyntaxFactory.makeTypealiasKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `var` keyword
  static var `var`: TokenSyntax {
    SyntaxFactory.makeVarKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `fileprivate` keyword
  static var `fileprivate`: TokenSyntax {
    SyntaxFactory.makeFileprivateKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `internal` keyword
  static var `internal`: TokenSyntax {
    SyntaxFactory.makeInternalKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `private` keyword
  static var `private`: TokenSyntax {
    SyntaxFactory.makePrivateKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `public` keyword
  static var `public`: TokenSyntax {
    SyntaxFactory.makePublicKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `static` keyword
  static var `static`: TokenSyntax {
    SyntaxFactory.makeStaticKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `defer` keyword
  static var `defer`: TokenSyntax {
    SyntaxFactory.makeDeferKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `if` keyword
  static var `if`: TokenSyntax {
    SyntaxFactory.makeIfKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `guard` keyword
  static var `guard`: TokenSyntax {
    SyntaxFactory.makeGuardKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `do` keyword
  static var `do`: TokenSyntax {
    SyntaxFactory.makeDoKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `repeat` keyword
  static var `repeat`: TokenSyntax {
    SyntaxFactory.makeRepeatKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `else` keyword
  static var `else`: TokenSyntax {
    SyntaxFactory.makeElseKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `for` keyword
  static var `for`: TokenSyntax {
    SyntaxFactory.makeForKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `in` keyword
  static var `in`: TokenSyntax {
    SyntaxFactory.makeInKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `while` keyword
  static var `while`: TokenSyntax {
    SyntaxFactory.makeWhileKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `return` keyword
  static var `return`: TokenSyntax {
    SyntaxFactory.makeReturnKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `break` keyword
  static var `break`: TokenSyntax {
    SyntaxFactory.makeBreakKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `continue` keyword
  static var `continue`: TokenSyntax {
    SyntaxFactory.makeContinueKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `fallthrough` keyword
  static var `fallthrough`: TokenSyntax {
    SyntaxFactory.makeFallthroughKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `switch` keyword
  static var `switch`: TokenSyntax {
    SyntaxFactory.makeSwitchKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `case` keyword
  static var `case`: TokenSyntax {
    SyntaxFactory.makeCaseKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `default` keyword
  static var `default`: TokenSyntax {
    SyntaxFactory.makeDefaultKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `where` keyword
  static var `where`: TokenSyntax {
    SyntaxFactory.makeWhereKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `catch` keyword
  static var `catch`: TokenSyntax {
    SyntaxFactory.makeCatchKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `throw` keyword
  static var `throw`: TokenSyntax {
    SyntaxFactory.makeThrowKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `as` keyword
  static var `as`: TokenSyntax {
    SyntaxFactory.makeAsKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `Any` keyword
  static var `any`: TokenSyntax {
    SyntaxFactory.makeAnyKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `false` keyword
  static var `false`: TokenSyntax {
    SyntaxFactory.makeFalseKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `is` keyword
  static var `is`: TokenSyntax {
    SyntaxFactory.makeIsKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `nil` keyword
  static var `nil`: TokenSyntax {
    SyntaxFactory.makeNilKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `rethrows` keyword
  static var `rethrows`: TokenSyntax {
    SyntaxFactory.makeRethrowsKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `super` keyword
  static var `super`: TokenSyntax {
    SyntaxFactory.makeSuperKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `self` keyword
  static var `self`: TokenSyntax {
    SyntaxFactory.makeSelfKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `Self` keyword
  static var `capitalSelf`: TokenSyntax {
    SyntaxFactory.makeCapitalSelfKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `true` keyword
  static var `true`: TokenSyntax {
    SyntaxFactory.makeTrueKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `try` keyword
  static var `try`: TokenSyntax {
    SyntaxFactory.makeTryKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `throws` keyword
  static var `throws`: TokenSyntax {
    SyntaxFactory.makeThrowsKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `__FILE__` keyword
  static var `__file__`: TokenSyntax {
    SyntaxFactory.make__FILE__Keyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `__LINE__` keyword
  static var `__line__`: TokenSyntax {
    SyntaxFactory.make__LINE__Keyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `__COLUMN__` keyword
  static var `__column__`: TokenSyntax {
    SyntaxFactory.make__COLUMN__Keyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `__FUNCTION__` keyword
  static var `__function__`: TokenSyntax {
    SyntaxFactory.make__FUNCTION__Keyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `__DSO_HANDLE__` keyword
  static var `__dso_handle__`: TokenSyntax {
    SyntaxFactory.make__DSO_HANDLE__Keyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `_` keyword
  static var `wildcard`: TokenSyntax {
    SyntaxFactory.makeWildcardKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `(` token
  static var `leftParen`: TokenSyntax {
    SyntaxFactory.makeLeftParenToken()
  }

  /// The `)` token
  static var `rightParen`: TokenSyntax {
    SyntaxFactory.makeRightParenToken()
  }

  /// The `{` token
  static var `leftBrace`: TokenSyntax {
    SyntaxFactory.makeLeftBraceToken()
  }

  /// The `}` token
  static var `rightBrace`: TokenSyntax {
    SyntaxFactory.makeRightBraceToken()
  }

  /// The `[` token
  static var `leftSquareBracket`: TokenSyntax {
    SyntaxFactory.makeLeftSquareBracketToken()
  }

  /// The `]` token
  static var `rightSquareBracket`: TokenSyntax {
    SyntaxFactory.makeRightSquareBracketToken()
  }

  /// The `<` token
  static var `leftAngle`: TokenSyntax {
    SyntaxFactory.makeLeftAngleToken()
    .withLeadingTrivia(.spaces(1))
    .withTrailingTrivia(.spaces(1))
  }

  /// The `>` token
  static var `rightAngle`: TokenSyntax {
    SyntaxFactory.makeRightAngleToken()
    .withLeadingTrivia(.spaces(1))
    .withTrailingTrivia(.spaces(1))
  }

  /// The `.` token
  static var `period`: TokenSyntax {
    SyntaxFactory.makePeriodToken()
  }

  /// The `.` token
  static var `prefixPeriod`: TokenSyntax {
    SyntaxFactory.makePrefixPeriodToken()
  }

  /// The `,` token
  static var `comma`: TokenSyntax {
    SyntaxFactory.makeCommaToken()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `...` token
  static var `ellipsis`: TokenSyntax {
    SyntaxFactory.makeEllipsisToken()
  }

  /// The `:` token
  static var `colon`: TokenSyntax {
    SyntaxFactory.makeColonToken()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `;` token
  static var `semicolon`: TokenSyntax {
    SyntaxFactory.makeSemicolonToken()
  }

  /// The `=` token
  static var `equal`: TokenSyntax {
    SyntaxFactory.makeEqualToken()
    .withLeadingTrivia(.spaces(1))
    .withTrailingTrivia(.spaces(1))
  }

  /// The `@` token
  static var `atSign`: TokenSyntax {
    SyntaxFactory.makeAtSignToken()
  }

  /// The `#` token
  static var `pound`: TokenSyntax {
    SyntaxFactory.makePoundToken()
  }

  /// The `&` token
  static var `prefixAmpersand`: TokenSyntax {
    SyntaxFactory.makePrefixAmpersandToken()
    .withLeadingTrivia(.spaces(1))
    .withTrailingTrivia(.spaces(1))
  }

  /// The `->` token
  static var `arrow`: TokenSyntax {
    SyntaxFactory.makeArrowToken()
    .withTrailingTrivia(.spaces(1))
  }

  /// The ``` token
  static var `backtick`: TokenSyntax {
    SyntaxFactory.makeBacktickToken()
  }

  /// The `\` token
  static var `backslash`: TokenSyntax {
    SyntaxFactory.makeBackslashToken()
  }

  /// The `!` token
  static var `exclamationMark`: TokenSyntax {
    SyntaxFactory.makeExclamationMarkToken()
  }

  /// The `?` token
  static var `postfixQuestionMark`: TokenSyntax {
    SyntaxFactory.makePostfixQuestionMarkToken()
  }

  /// The `?` token
  static var `infixQuestionMark`: TokenSyntax {
    SyntaxFactory.makeInfixQuestionMarkToken()
  }

  /// The `"` token
  static var `stringQuote`: TokenSyntax {
    SyntaxFactory.makeStringQuoteToken()
  }

  /// The `'` token
  static var `singleQuote`: TokenSyntax {
    SyntaxFactory.makeSingleQuoteToken()
  }

  /// The `"""` token
  static var `multilineStringQuote`: TokenSyntax {
    SyntaxFactory.makeMultilineStringQuoteToken()
  }

  /// The `#keyPath` keyword
  static var `poundKeyPath`: TokenSyntax {
    SyntaxFactory.makePoundKeyPathKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#line` keyword
  static var `poundLine`: TokenSyntax {
    SyntaxFactory.makePoundLineKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#selector` keyword
  static var `poundSelector`: TokenSyntax {
    SyntaxFactory.makePoundSelectorKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#file` keyword
  static var `poundFile`: TokenSyntax {
    SyntaxFactory.makePoundFileKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#fileID` keyword
  static var `poundFileID`: TokenSyntax {
    SyntaxFactory.makePoundFileIDKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#filePath` keyword
  static var `poundFilePath`: TokenSyntax {
    SyntaxFactory.makePoundFilePathKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#column` keyword
  static var `poundColumn`: TokenSyntax {
    SyntaxFactory.makePoundColumnKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#function` keyword
  static var `poundFunction`: TokenSyntax {
    SyntaxFactory.makePoundFunctionKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#dsohandle` keyword
  static var `poundDsohandle`: TokenSyntax {
    SyntaxFactory.makePoundDsohandleKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#assert` keyword
  static var `poundAssert`: TokenSyntax {
    SyntaxFactory.makePoundAssertKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#sourceLocation` keyword
  static var `poundSourceLocation`: TokenSyntax {
    SyntaxFactory.makePoundSourceLocationKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#warning` keyword
  static var `poundWarning`: TokenSyntax {
    SyntaxFactory.makePoundWarningKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#error` keyword
  static var `poundError`: TokenSyntax {
    SyntaxFactory.makePoundErrorKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#if` keyword
  static var `poundIf`: TokenSyntax {
    SyntaxFactory.makePoundIfKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#else` keyword
  static var `poundElse`: TokenSyntax {
    SyntaxFactory.makePoundElseKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#elseif` keyword
  static var `poundElseif`: TokenSyntax {
    SyntaxFactory.makePoundElseifKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#endif` keyword
  static var `poundEndif`: TokenSyntax {
    SyntaxFactory.makePoundEndifKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#available` keyword
  static var `poundAvailable`: TokenSyntax {
    SyntaxFactory.makePoundAvailableKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#unavailable` keyword
  static var `poundUnavailable`: TokenSyntax {
    SyntaxFactory.makePoundUnavailableKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#fileLiteral` keyword
  static var `poundFileLiteral`: TokenSyntax {
    SyntaxFactory.makePoundFileLiteralKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#imageLiteral` keyword
  static var `poundImageLiteral`: TokenSyntax {
    SyntaxFactory.makePoundImageLiteralKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  /// The `#colorLiteral` keyword
  static var `poundColorLiteral`: TokenSyntax {
    SyntaxFactory.makePoundColorLiteralKeyword()
    .withTrailingTrivia(.spaces(1))
  }

  static func `integerLiteral`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeIntegerLiteral(text)
  }

  static func `floatingLiteral`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeFloatingLiteral(text)
  }

  static func `stringLiteral`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeStringLiteral(text)
  }

  static func `regexLiteral`(_ text: String) -> TokenSyntax {
    SyntaxFactory.makeRegexLiteral(text)
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
    .withLeadingTrivia(.spaces(1))
    .withTrailingTrivia(.spaces(1))
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
  static var `stringInterpolationAnchor`: TokenSyntax {
    SyntaxFactory.makeStringInterpolationAnchorToken()
  }

  /// The `yield` token
  static var `yield`: TokenSyntax {
    SyntaxFactory.makeYieldToken()
  }

  /// The `eof` token
  static var eof: TokenSyntax {
    SyntaxFactory.makeToken(.eof, presence: .present)
  }
}
