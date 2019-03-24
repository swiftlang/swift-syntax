// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 6)
//// Automatically Generated From SyntaxClassifier.swift.gyb.
//// Do Not Edit Directly!
//===------------ SyntaxClassifier.swift.gyb - Syntax Collection ----------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2018 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

public enum SyntaxClassification {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// The token should not receive syntax coloring. 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// A Swift keyword, including contextual keywords. 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// A generic identifier. 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case identifier
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// An identifier referring to a type. 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case typeIdentifier
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// An identifier starting with `$` like `$0`. 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case dollarIdentifier
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// An integer literal. 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case integerLiteral
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// A floating point literal. 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case floatingLiteral
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// A string literal including multiline string literals. 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case stringLiteral
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// The opening and closing paranthesis of string interpolation. 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case stringInterpolationAnchor
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// A `#` keyword like `#warning`. 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case poundDirectiveKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// A build configuration directive like `#if`, `#elseif`, `#else`. 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case buildConfigId
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// An attribute starting with an `@`. 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case attribute
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// An image, color, etc. literal. 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case objectLiteral
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// An editor placeholder of the form `<#content#>` 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case editorPlaceholder
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// A line comment starting with `//`. 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case lineComment
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// A doc line comment starting with `///`. 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case docLineComment
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// A block comment starting with `/**` and ending with `*/. 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case blockComment
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// A doc block comment starting with `/**` and ending with `*/. 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case docBlockComment
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 29)
}

fileprivate class _SyntaxClassifier: SyntaxVisitor {

  /// Don't classify nodes with these IDs or any of their children
  var skipNodeIds: Set<SyntaxNodeId> = []

  /// The top of the `contextStack` determines the classification for all tokens
  /// encountered that do not have a native classification. If `force` is `true`
  /// the top of the stack also determines the classification of tokens with a
  /// native classification
  private var contextStack: [(classification: SyntaxClassification, force: Bool)] = 
      [(classification: .none, force: false)]

  /// The classifications that have determined so far are collected in this
  /// dictionary
  var classifications: [TokenSyntax: SyntaxClassification] = [:]

  private func visit(
    _ node: Syntax, 
    classification: SyntaxClassification, 
    force: Bool = false
  ) {
    contextStack.append((classification: classification, force: force))
    node.walk(self)
    contextStack.removeLast()
  }

  private func getContextFreeClassificationForTokenKind(_ tokenKind: TokenKind) 
      -> SyntaxClassification? {
    switch (tokenKind) {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .associatedtypeKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .classKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .deinitKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .enumKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .extensionKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .funcKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .importKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .initKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .inoutKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .letKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .operatorKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .precedencegroupKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .protocolKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .structKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .subscriptKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .typealiasKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .varKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .fileprivateKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .internalKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .privateKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .publicKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .staticKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .deferKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .ifKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .guardKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .doKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .repeatKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .elseKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .forKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .inKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .whileKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .returnKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .breakKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .continueKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .fallthroughKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .switchKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .caseKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .defaultKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .whereKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .catchKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .throwKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .asKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .anyKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .falseKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .isKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .nilKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .rethrowsKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .superKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .selfKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .capitalSelfKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .trueKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .tryKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .throwsKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .__file__Keyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .__line__Keyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .__column__Keyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .__function__Keyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .__dso_handle__Keyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .wildcardKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .leftParen:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .rightParen:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .leftBrace:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .rightBrace:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .leftSquareBracket:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .rightSquareBracket:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .leftAngle:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .rightAngle:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .period:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .prefixPeriod:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .comma:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .colon:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .semicolon:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .equal:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .atSign:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.attribute
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .pound:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .prefixAmpersand:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .arrow:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .backtick:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .backslash:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .exclamationMark:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .postfixQuestionMark:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .infixQuestionMark:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .stringQuote:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.stringLiteral
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .multilineStringQuote:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.stringLiteral
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundKeyPathKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundLineKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundSelectorKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundFileKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundColumnKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundFunctionKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundDsohandleKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundAssertKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundSourceLocationKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.poundDirectiveKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundWarningKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.poundDirectiveKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundErrorKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.poundDirectiveKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundIfKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.poundDirectiveKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundElseKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.poundDirectiveKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundElseifKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.poundDirectiveKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundEndifKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.poundDirectiveKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundAvailableKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundFileLiteralKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.objectLiteral
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundImageLiteralKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.objectLiteral
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundColorLiteralKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.objectLiteral
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .integerLiteral:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.integerLiteral
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .floatingLiteral:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.floatingLiteral
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .stringLiteral:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.stringLiteral
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .unknown:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .identifier:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 65)
      return nil
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .unspacedBinaryOperator:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .spacedBinaryOperator:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .postfixOperator:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .prefixOperator:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .dollarIdentifier:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.dollarIdentifier
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .contextualKeyword:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .stringSegment:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.stringLiteral
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .stringInterpolationAnchor:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.stringInterpolationAnchor
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .yield:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 68)
    case .eof:
      return SyntaxClassification.none
    }
  }

  override func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
    assert(token.isPresent)
    // FIXME: We need to come up with some way in which the SyntaxClassifier can
    // classify trivia (i.e. comments). In particular we need to be able to
    // look into the comments to find things like URLs or keywords like MARK.
    var classification = contextStack.last!.classification
    if !contextStack.last!.force {
      if let contextFreeClassification = 
          getContextFreeClassificationForTokenKind(token.tokenKind) {
        classification = contextFreeClassification
      }
      if case .unknown = token.tokenKind, token.text.starts(with: "\"") {
        classification = .stringLiteral
      } else if case .identifier = token.tokenKind, 
          token.text.starts(with: "<#") && token.text.hasSuffix("#>") {
        classification = .editorPlaceholder
      }
    }
    assert(classifications[token] == nil,
           "\(token) has already been classified")
    classifications[token] = classification
    return .skipChildren
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: UnknownDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: UnknownExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: UnknownStmtSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: UnknownTypeSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: UnknownPatternSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: CodeBlockItemSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.item.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let semicolon = node.semicolon { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      semicolon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let errorTokens = node.errorTokens { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      errorTokens.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: CodeBlockItemListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: CodeBlockSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftBrace.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.statements.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightBrace.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: InOutExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.ampersand.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.expression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PoundColumnExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.poundColumn.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: FunctionCallArgumentListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: TupleElementListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ArrayElementListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: DictionaryElementListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: StringInterpolationSegmentsSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: TryExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.tryKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let questionOrExclamationMark = node.questionOrExclamationMark { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      questionOrExclamationMark.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.expression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: DeclNameArgumentSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.name.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: DeclNameArgumentListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: DeclNameArgumentsSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.arguments.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: IdentifierExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.identifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let declNameArguments = node.declNameArguments { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      declNameArguments.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: SuperRefExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.superKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: NilLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.nilKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: DiscardAssignmentExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.wildcard.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: AssignmentExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.assignToken.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: SequenceExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.elements.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ExprListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PoundLineExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.poundLine.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PoundFileExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.poundFile.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PoundFunctionExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.poundFunction.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PoundDsohandleExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.poundDsohandle.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: SymbolicReferenceExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.identifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let genericArgumentClause = node.genericArgumentClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      genericArgumentClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PrefixOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let operatorToken = node.operatorToken { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      operatorToken.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.postfixExpression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: BinaryOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.operatorToken.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ArrowExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let throwsToken = node.throwsToken { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      throwsToken.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.arrowToken.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: FloatLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.floatingDigits.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: TupleExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.elementList.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ArrayExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftSquare.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.elements.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightSquare.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: DictionaryExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftSquare.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.content.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightSquare.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ImplicitMemberExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.dot.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.name.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let declNameArguments = node.declNameArguments { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      declNameArguments.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: FunctionCallArgumentSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let label = node.label { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      label.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let colon = node.colon { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.expression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: TupleElementSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let label = node.label { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      label.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let colon = node.colon { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.expression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ArrayElementSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.expression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: DictionaryElementSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.keyExpression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.valueExpression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: IntegerLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.digits.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.stringLiteral.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: BooleanLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.booleanLiteral.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: TernaryExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.conditionExpression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.questionMark.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.firstChoice.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.colonMark.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.secondChoice.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: MemberAccessExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let base = node.base { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      base.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.dot.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.name.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let declNameArguments = node.declNameArguments { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      declNameArguments.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: DotSelfExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let expression = node.expression { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      expression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.dot.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.selfKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: IsExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.isTok.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.typeName.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: AsExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.asTok.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let questionOrExclamationMark = node.questionOrExclamationMark { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      questionOrExclamationMark.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.typeName.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: TypeExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.type.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ClosureCaptureItemSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let specifier = node.specifier { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      specifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let name = node.name { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      name.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let assignToken = node.assignToken { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      assignToken.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.expression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ClosureCaptureItemListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ClosureCaptureSignatureSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftSquare.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let items = node.items { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      items.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightSquare.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ClosureParamSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.name.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ClosureParamListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ClosureSignatureSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let capture = node.capture { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      capture.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let input = node.input { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      input.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let throwsTok = node.throwsTok { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      throwsTok.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let output = node.output { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      output.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.inTok.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ClosureExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftBrace.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let signature = node.signature { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      signature.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.statements.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightBrace.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: UnresolvedPatternExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.pattern.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: FunctionCallExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.calledExpression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let leftParen = node.leftParen { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      leftParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.argumentList.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let rightParen = node.rightParen { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      rightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingClosure = node.trailingClosure { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingClosure.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: SubscriptExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.calledExpression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftBracket.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.argumentList.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightBracket.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingClosure = node.trailingClosure { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingClosure.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: OptionalChainingExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.expression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.questionMark.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ForcedValueExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.expression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.exclamationMark.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PostfixUnaryExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.expression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.operatorToken.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: SpecializeExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.expression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.genericArgumentClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: StringSegmentSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.content.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ExpressionSegmentSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.backslash.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 119)
    visit(node.leftParen, 
          classification: .stringInterpolationAnchor, 
          force: true)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.expression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: StringInterpolationExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.openQuote.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.segments.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.closeQuote.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: KeyPathExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.backslash.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let rootExpr = node.rootExpr { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      rootExpr.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.expression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: KeyPathBaseExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.period.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ObjcNamePieceSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.name.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let dot = node.dot { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      dot.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ObjcNameSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ObjcKeyPathExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.keyPath.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.name.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ObjcSelectorExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.poundSelector.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let kind = node.kind { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      kind.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let colon = node.colon { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.name.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: EditorPlaceholderExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.identifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ObjectLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.identifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.arguments.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: TypeInitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.equal.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.value.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: TypealiasDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      attributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      modifiers.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.typealiasKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.identifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let genericParameterClause = node.genericParameterClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      genericParameterClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let initializer = node.initializer { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      initializer.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let genericWhereClause = node.genericWhereClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      genericWhereClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: AssociatedtypeDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      attributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      modifiers.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.associatedtypeKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.identifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let inheritanceClause = node.inheritanceClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      inheritanceClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let initializer = node.initializer { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      initializer.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let genericWhereClause = node.genericWhereClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      genericWhereClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: FunctionParameterListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ParameterClauseSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.parameterList.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ReturnClauseSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.arrow.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.returnType.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: FunctionSignatureSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.input.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let throwsOrRethrowsKeyword = node.throwsOrRethrowsKeyword { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      throwsOrRethrowsKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let output = node.output { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      output.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: IfConfigClauseSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 119)
    visit(node.poundKeyword, 
          classification: .buildConfigId, 
          force: false)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let condition = node.condition { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 110)
      visit(condition, 
            classification: .buildConfigId, 
            force: false)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.elements.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: IfConfigClauseListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.clauses.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 119)
    visit(node.poundEndif, 
          classification: .buildConfigId, 
          force: false)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PoundErrorDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.poundError.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.message.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PoundWarningDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.poundWarning.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.message.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PoundSourceLocationSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.poundSourceLocation.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let args = node.args { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      args.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PoundSourceLocationArgsSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.fileArgLabel.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.fileArgColon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.fileName.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.comma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.lineArgLabel.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.lineArgColon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.lineNumber.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: DeclModifierSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 119)
    visit(node.name, 
          classification: .attribute, 
          force: false)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let detailLeftParen = node.detailLeftParen { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      detailLeftParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let detail = node.detail { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      detail.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let detailRightParen = node.detailRightParen { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      detailRightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: InheritedTypeSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.typeName.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: InheritedTypeListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: TypeInheritanceClauseSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.inheritedTypeCollection.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      attributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      modifiers.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.classKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.identifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let genericParameterClause = node.genericParameterClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      genericParameterClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let inheritanceClause = node.inheritanceClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      inheritanceClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let genericWhereClause = node.genericWhereClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      genericWhereClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.members.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      attributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      modifiers.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.structKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.identifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let genericParameterClause = node.genericParameterClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      genericParameterClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let inheritanceClause = node.inheritanceClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      inheritanceClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let genericWhereClause = node.genericWhereClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      genericWhereClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.members.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      attributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      modifiers.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.protocolKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.identifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let inheritanceClause = node.inheritanceClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      inheritanceClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let genericWhereClause = node.genericWhereClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      genericWhereClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.members.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ExtensionDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      attributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      modifiers.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.extensionKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.extendedType.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let inheritanceClause = node.inheritanceClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      inheritanceClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let genericWhereClause = node.genericWhereClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      genericWhereClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.members.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: MemberDeclBlockSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftBrace.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.members.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightBrace.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: MemberDeclListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: MemberDeclListItemSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.decl.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let semicolon = node.semicolon { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      semicolon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: SourceFileSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.statements.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.eofToken.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: InitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.equal.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.value.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: FunctionParameterSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      attributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let firstName = node.firstName { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      firstName.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let secondName = node.secondName { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      secondName.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let colon = node.colon { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let type = node.type { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      type.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let ellipsis = node.ellipsis { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      ellipsis.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let defaultArgument = node.defaultArgument { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      defaultArgument.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ModifierListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      attributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      modifiers.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.funcKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.identifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let genericParameterClause = node.genericParameterClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      genericParameterClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.signature.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let genericWhereClause = node.genericWhereClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      genericWhereClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let body = node.body { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      body.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      attributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      modifiers.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.initKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let optionalMark = node.optionalMark { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      optionalMark.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let genericParameterClause = node.genericParameterClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      genericParameterClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.parameters.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let throwsOrRethrowsKeyword = node.throwsOrRethrowsKeyword { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      throwsOrRethrowsKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let genericWhereClause = node.genericWhereClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      genericWhereClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let body = node.body { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      body.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: DeinitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      attributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      modifiers.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.deinitKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.body.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: SubscriptDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      attributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      modifiers.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.subscriptKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let genericParameterClause = node.genericParameterClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      genericParameterClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.indices.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.result.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let genericWhereClause = node.genericWhereClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      genericWhereClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let accessor = node.accessor { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      accessor.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: AccessLevelModifierSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.name.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let leftParen = node.leftParen { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      leftParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let modifier = node.modifier { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      modifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let rightParen = node.rightParen { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      rightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: AccessPathComponentSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.name.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingDot = node.trailingDot { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingDot.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: AccessPathSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      attributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      modifiers.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.importTok.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let importKind = node.importKind { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      importKind.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.path.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: AccessorParameterSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.name.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: AccessorDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      attributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let modifier = node.modifier { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      modifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.accessorKind.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let parameter = node.parameter { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      parameter.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let body = node.body { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      body.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: AccessorListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: AccessorBlockSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftBrace.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.accessors.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightBrace.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PatternBindingSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.pattern.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let typeAnnotation = node.typeAnnotation { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      typeAnnotation.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let initializer = node.initializer { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      initializer.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let accessor = node.accessor { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      accessor.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PatternBindingListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      attributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      modifiers.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.letOrVarKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.bindings.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: EnumCaseElementSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.identifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let associatedValue = node.associatedValue { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      associatedValue.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let rawValue = node.rawValue { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      rawValue.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: EnumCaseElementListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: EnumCaseDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      attributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      modifiers.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.caseKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.elements.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      attributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      modifiers.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.enumKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.identifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let genericParameters = node.genericParameters { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      genericParameters.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let inheritanceClause = node.inheritanceClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      inheritanceClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let genericWhereClause = node.genericWhereClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      genericWhereClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.members.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: OperatorDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      attributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 110)
      visit(modifiers, 
            classification: .attribute, 
            force: false)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.operatorKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.identifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let operatorPrecedenceAndTypes = node.operatorPrecedenceAndTypes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      operatorPrecedenceAndTypes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: IdentifierListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: OperatorPrecedenceAndTypesSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.precedenceGroupAndDesignatedTypes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PrecedenceGroupDeclSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      attributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      modifiers.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.precedencegroupKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.identifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftBrace.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.groupAttributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightBrace.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PrecedenceGroupAttributeListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PrecedenceGroupRelationSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 119)
    visit(node.higherThanOrLowerThan, 
          classification: .keyword, 
          force: false)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.otherNames.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PrecedenceGroupNameListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PrecedenceGroupNameElementSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.name.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PrecedenceGroupAssignmentSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.assignmentKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.flag.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PrecedenceGroupAssociativitySyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 119)
    visit(node.associativityKeyword, 
          classification: .keyword, 
          force: false)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.value.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: TokenListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: NonEmptyTokenListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: AttributeSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.atSignToken.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 119)
    visit(node.attributeName, 
          classification: .attribute, 
          force: false)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let leftParen = node.leftParen { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      leftParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let argument = node.argument { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      argument.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let rightParen = node.rightParen { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      rightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let tokenList = node.tokenList { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      tokenList.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: AttributeListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: SpecializeAttributeSpecListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: LabeledSpecializeEntrySyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.label.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.value.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: NamedAttributeStringArgumentSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.nameTok.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.stringOrDeclname.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: DeclNameSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.declBaseName.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let declNameArguments = node.declNameArguments { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      declNameArguments.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ImplementsAttributeArgumentsSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.type.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.comma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.declBaseName.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let declNameArguments = node.declNameArguments { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      declNameArguments.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ObjCSelectorPieceSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let name = node.name { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      name.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let colon = node.colon { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ObjCSelectorSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ContinueStmtSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.continueKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let label = node.label { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      label.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: WhileStmtSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let labelName = node.labelName { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      labelName.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let labelColon = node.labelColon { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      labelColon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.whileKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.conditions.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.body.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: DeferStmtSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.deferKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.body.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ExpressionStmtSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.expression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: SwitchCaseListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: RepeatWhileStmtSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let labelName = node.labelName { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      labelName.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let labelColon = node.labelColon { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      labelColon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.repeatKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.body.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.whileKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.condition.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: GuardStmtSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.guardKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.conditions.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.elseKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.body.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: WhereClauseSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.whereKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.guardResult.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ForInStmtSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let labelName = node.labelName { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      labelName.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let labelColon = node.labelColon { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      labelColon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.forKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let caseKeyword = node.caseKeyword { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      caseKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.pattern.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let typeAnnotation = node.typeAnnotation { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      typeAnnotation.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.inKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.sequenceExpr.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let whereClause = node.whereClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      whereClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.body.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: SwitchStmtSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let labelName = node.labelName { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      labelName.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let labelColon = node.labelColon { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      labelColon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.switchKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.expression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftBrace.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.cases.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightBrace.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: CatchClauseListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: DoStmtSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let labelName = node.labelName { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      labelName.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let labelColon = node.labelColon { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      labelColon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.doKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.body.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let catchClauses = node.catchClauses { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      catchClauses.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ReturnStmtSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.returnKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let expression = node.expression { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      expression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: YieldStmtSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.yieldKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.yields.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: YieldListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.elementList.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: FallthroughStmtSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.fallthroughKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: BreakStmtSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.breakKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let label = node.label { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      label.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: CaseItemListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ConditionElementSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.condition.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: AvailabilityConditionSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.poundAvailableKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.availabilitySpec.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: MatchingPatternConditionSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.caseKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.pattern.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let typeAnnotation = node.typeAnnotation { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      typeAnnotation.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.initializer.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: OptionalBindingConditionSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.letOrVarKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.pattern.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let typeAnnotation = node.typeAnnotation { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      typeAnnotation.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.initializer.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ConditionElementListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: DeclarationStmtSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.declaration.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ThrowStmtSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.throwKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.expression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: IfStmtSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let labelName = node.labelName { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      labelName.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let labelColon = node.labelColon { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      labelColon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.ifKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.conditions.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.body.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let elseKeyword = node.elseKeyword { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      elseKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let elseBody = node.elseBody { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      elseBody.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ElseIfContinuationSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.ifStatement.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ElseBlockSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.elseKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.body.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: SwitchCaseSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let unknownAttr = node.unknownAttr { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      unknownAttr.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.label.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.statements.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: SwitchDefaultLabelSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.defaultKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: CaseItemSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.pattern.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let whereClause = node.whereClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      whereClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: SwitchCaseLabelSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.caseKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.caseItems.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: CatchClauseSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.catchKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let pattern = node.pattern { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      pattern.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let whereClause = node.whereClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      whereClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.body.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: PoundAssertStmtSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.poundAssert.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.condition.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let comma = node.comma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      comma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let message = node.message { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      message.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: GenericWhereClauseSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.whereKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.requirementList.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: GenericRequirementListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: SameTypeRequirementSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftTypeIdentifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.equalityToken.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightTypeIdentifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: GenericParameterListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: GenericParameterSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      attributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.name.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let colon = node.colon { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let inheritedType = node.inheritedType { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      inheritedType.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: GenericParameterClauseSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftAngleBracket.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.genericParameterList.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightAngleBracket.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ConformanceRequirementSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftTypeIdentifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightTypeIdentifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: SimpleTypeIdentifierSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 119)
    visit(node.name, 
          classification: .typeIdentifier, 
          force: false)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let genericArgumentClause = node.genericArgumentClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      genericArgumentClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: MemberTypeIdentifierSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.baseType.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.period.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 119)
    visit(node.name, 
          classification: .typeIdentifier, 
          force: false)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let genericArgumentClause = node.genericArgumentClause { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      genericArgumentClause.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ClassRestrictionTypeSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.classKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ArrayTypeSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftSquareBracket.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.elementType.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightSquareBracket.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: DictionaryTypeSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftSquareBracket.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.keyType.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.valueType.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightSquareBracket.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: MetatypeTypeSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.baseType.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.period.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.typeOrProtocol.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: OptionalTypeSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.wrappedType.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.questionMark.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.wrappedType.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.exclamationMark.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: CompositionTypeElementSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.type.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let ampersand = node.ampersand { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      ampersand.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: CompositionTypeElementListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: CompositionTypeSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.elements.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: TupleTypeElementSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let inOut = node.inOut { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      inOut.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let name = node.name { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      name.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let secondName = node.secondName { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      secondName.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let colon = node.colon { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.type.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let ellipsis = node.ellipsis { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      ellipsis.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let initializer = node.initializer { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      initializer.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: TupleTypeElementListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: TupleTypeSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.elements.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: FunctionTypeSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.arguments.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let throwsOrRethrowsKeyword = node.throwsOrRethrowsKeyword { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      throwsOrRethrowsKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.arrow.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.returnType.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: AttributedTypeSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let specifier = node.specifier { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      specifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      attributes.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.baseType.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: GenericArgumentListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: GenericArgumentSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.argumentType.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: GenericArgumentClauseSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftAngleBracket.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.arguments.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightAngleBracket.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: TypeAnnotationSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.type.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: EnumCasePatternSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let type = node.type { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      type.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.period.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.caseName.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let associatedTuple = node.associatedTuple { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      associatedTuple.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: IsTypePatternSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.isKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.type.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: OptionalPatternSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.subPattern.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.questionMark.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: IdentifierPatternSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.identifier.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: AsTypePatternSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.pattern.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.asKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.type.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: TuplePatternSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.leftParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.elements.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.rightParen.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: WildcardPatternSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.wildcard.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let typeAnnotation = node.typeAnnotation { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      typeAnnotation.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: TuplePatternElementSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let labelName = node.labelName { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      labelName.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let labelColon = node.labelColon { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      labelColon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.pattern.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ExpressionPatternSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.expression.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: TuplePatternElementListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: ValueBindingPatternSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.letOrVarKeyword.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.valuePattern.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: AvailabilitySpecListSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 104)
    return .visitChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: AvailabilityArgumentSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.entry.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      trailingComma.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: AvailabilityLabeledArgumentSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.label.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.colon.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.value.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: AvailabilityVersionRestrictionSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 119)
    visit(node.platform, 
          classification: .keyword, 
          force: false)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.version.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 99)
  override func visit(_ node: VersionTupleSyntax) -> SyntaxVisitorContinueKind {
    if skipNodeIds.contains(node.raw.id) {
      return .skipChildren
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 123)
    node.majorMinor.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let patchPeriod = node.patchPeriod { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      patchPeriod.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
    if let patchVersion = node.patchVersion { 
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
      patchVersion.walk(self)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 116)
    }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 127)
    return .skipChildren
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 129)
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 132)
}

public enum SyntaxClassifier {
  /// Classify all tokens in the given syntax tree for syntax highlighting.
  /// If a `IncrementalTreeTransferSession` is passed, only nodes that have 
  /// changed since the last transfer will be classified.
  public static func classifyTokensInTree(
    _ syntaxTree: SourceFileSyntax,
    skipNodes: Set<SyntaxNodeId> = []
  ) -> [TokenSyntax: SyntaxClassification] {
    let classifier = _SyntaxClassifier()
    classifier.skipNodeIds = skipNodes
    syntaxTree.walk(classifier)
    return classifier.classifications
  }
}
