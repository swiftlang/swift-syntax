// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 6)
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
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// The token should not receive syntax coloring. 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// A Swift keyword, including contextual keywords. 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// A generic identifier. 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case identifier
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// An identifier referring to a type. 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case typeIdentifier
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// An identifier starting with `$` like `$0`. 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case dollarIdentifier
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// An integer literal. 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case integerLiteral
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// A floating point literal. 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case floatingLiteral
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// A string literal including multiline string literals. 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case stringLiteral
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// The opening and closing paranthesis of string interpolation. 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case stringInterpolationAnchor
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// A `#` keyword like `#warning`. 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case poundDirectiveKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// A build configuration directive like `#if`, `#elseif`, `#else`. 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case buildConfigId
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// An attribute starting with an `@`. 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case attribute
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// An image, color, etc. literal. 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case objectLiteral
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// An editor placeholder of the form `<#content#>` 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case editorPlaceholder
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// A line comment starting with `//`. 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case lineComment
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// A doc line comment starting with `///`. 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case docLineComment
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// A block comment starting with `/**` and ending with `*/. 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case blockComment
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 24)
  /// A doc block comment starting with `/**` and ending with `*/. 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 27)
  case docBlockComment
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 29)
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
    visit(node)
    contextStack.removeLast()
  }

  private func getContextFreeClassificationForTokenKind(_ tokenKind: TokenKind) 
      -> SyntaxClassification? {
    switch (tokenKind) {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .associatedtypeKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .classKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .deinitKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .enumKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .extensionKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .funcKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .importKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .initKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .inoutKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .letKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .operatorKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .precedencegroupKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .protocolKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .structKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .subscriptKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .typealiasKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .varKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .fileprivateKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .internalKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .privateKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .publicKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .staticKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .deferKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .ifKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .guardKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .doKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .repeatKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .elseKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .forKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .inKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .whileKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .returnKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .breakKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .continueKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .fallthroughKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .switchKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .caseKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .defaultKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .whereKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .catchKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .throwKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .asKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .anyKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .falseKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .isKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .nilKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .rethrowsKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .superKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .selfKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .capitalSelfKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .trueKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .tryKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .throwsKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .__file__Keyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .__line__Keyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .__column__Keyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .__function__Keyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .__dso_handle__Keyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .wildcardKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .leftParen:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .rightParen:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .leftBrace:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .rightBrace:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .leftSquareBracket:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .rightSquareBracket:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .leftAngle:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .rightAngle:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .period:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .prefixPeriod:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .comma:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .colon:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .semicolon:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .equal:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .atSign:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.attribute
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .pound:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .prefixAmpersand:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .arrow:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .backtick:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .backslash:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .exclamationMark:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .postfixQuestionMark:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .infixQuestionMark:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .stringQuote:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.stringLiteral
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .multilineStringQuote:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.stringLiteral
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundKeyPathKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundLineKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundSelectorKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundFileKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundColumnKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundFunctionKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundDsohandleKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundSourceLocationKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.poundDirectiveKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundWarningKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.poundDirectiveKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundErrorKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.poundDirectiveKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundIfKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.poundDirectiveKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundElseKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.poundDirectiveKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundElseifKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.poundDirectiveKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundEndifKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.poundDirectiveKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundAvailableKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundFileLiteralKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.objectLiteral
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundImageLiteralKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.objectLiteral
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .poundColorLiteralKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.objectLiteral
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .integerLiteral:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.integerLiteral
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .floatingLiteral:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.floatingLiteral
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .stringLiteral:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.stringLiteral
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .unknown:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .identifier:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 65)
      return nil
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .unspacedBinaryOperator:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .spacedBinaryOperator:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .postfixOperator:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .prefixOperator:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .dollarIdentifier:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.dollarIdentifier
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .contextualKeyword:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .stringSegment:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.stringLiteral
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .stringInterpolationAnchor:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.stringInterpolationAnchor
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 61)
    case .yield:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 63)
      return SyntaxClassification.none
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 68)
    case .eof:
      return SyntaxClassification.none
    }
  }

  override func visit(_ token: TokenSyntax) {
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
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: UnknownDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: UnknownExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: UnknownStmtSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: UnknownTypeSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: UnknownPatternSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: CodeBlockItemSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.item)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let semicolon = node.semicolon { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(semicolon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let errorTokens = node.errorTokens { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(errorTokens)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: CodeBlockItemListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: CodeBlockSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftBrace)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.statements)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightBrace)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: InOutExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.ampersand)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.expression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: PoundColumnExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.poundColumn)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: FunctionCallArgumentListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: TupleElementListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ArrayElementListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: DictionaryElementListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: StringInterpolationSegmentsSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: TryExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.tryKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let questionOrExclamationMark = node.questionOrExclamationMark { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(questionOrExclamationMark)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.expression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: DeclNameArgumentSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.name)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: DeclNameArgumentListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: DeclNameArgumentsSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.arguments)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: IdentifierExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.identifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let declNameArguments = node.declNameArguments { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(declNameArguments)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: SuperRefExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.superKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: NilLiteralExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.nilKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: DiscardAssignmentExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.wildcard)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: AssignmentExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.assignToken)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: SequenceExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.elements)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ExprListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: PoundLineExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.poundLine)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: PoundFileExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.poundFile)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: PoundFunctionExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.poundFunction)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: PoundDsohandleExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.poundDsohandle)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: SymbolicReferenceExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.identifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let genericArgumentClause = node.genericArgumentClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(genericArgumentClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: PrefixOperatorExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let operatorToken = node.operatorToken { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(operatorToken)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.postfixExpression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: BinaryOperatorExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.operatorToken)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ArrowExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let throwsToken = node.throwsToken { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(throwsToken)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.arrowToken)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: FloatLiteralExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.floatingDigits)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: TupleExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.elementList)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ArrayExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftSquare)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.elements)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightSquare)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: DictionaryExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftSquare)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.content)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightSquare)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ImplicitMemberExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.dot)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.name)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let declNameArguments = node.declNameArguments { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(declNameArguments)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: FunctionCallArgumentSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let label = node.label { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(label)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let colon = node.colon { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.expression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: TupleElementSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let label = node.label { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(label)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let colon = node.colon { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.expression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ArrayElementSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.expression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: DictionaryElementSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.keyExpression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.valueExpression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: IntegerLiteralExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.digits)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: StringLiteralExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.stringLiteral)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: BooleanLiteralExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.booleanLiteral)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: TernaryExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.conditionExpression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.questionMark)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.firstChoice)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.colonMark)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.secondChoice)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: MemberAccessExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let base = node.base { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(base)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.dot)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.name)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let declNameArguments = node.declNameArguments { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(declNameArguments)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: DotSelfExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.expression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.dot)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.selfKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: IsExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.isTok)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.typeName)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: AsExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.asTok)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let questionOrExclamationMark = node.questionOrExclamationMark { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(questionOrExclamationMark)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.typeName)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: TypeExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.type)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ClosureCaptureItemSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let specifier = node.specifier { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(specifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let name = node.name { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(name)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let assignToken = node.assignToken { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(assignToken)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.expression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ClosureCaptureItemListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ClosureCaptureSignatureSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftSquare)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let items = node.items { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(items)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightSquare)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ClosureParamSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.name)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ClosureParamListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ClosureSignatureSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let capture = node.capture { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(capture)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let input = node.input { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(input)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let throwsTok = node.throwsTok { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(throwsTok)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let output = node.output { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(output)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.inTok)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ClosureExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftBrace)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let signature = node.signature { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(signature)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.statements)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightBrace)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: UnresolvedPatternExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.pattern)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: FunctionCallExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.calledExpression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let leftParen = node.leftParen { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(leftParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.argumentList)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let rightParen = node.rightParen { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(rightParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingClosure = node.trailingClosure { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingClosure)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: SubscriptExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.calledExpression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftBracket)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.argumentList)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightBracket)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingClosure = node.trailingClosure { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingClosure)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: OptionalChainingExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.expression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.questionMark)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ForcedValueExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.expression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.exclamationMark)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: PostfixUnaryExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.expression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.operatorToken)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: SpecializeExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.expression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.genericArgumentClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: StringSegmentSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.content)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ExpressionSegmentSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.backslash)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 117)
    visit(node.leftParen, 
          classification: .stringInterpolationAnchor, 
          force: true)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.expression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: StringInterpolationExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.openQuote)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.segments)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.closeQuote)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: KeyPathExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.backslash)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let rootExpr = node.rootExpr { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(rootExpr)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.expression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: KeyPathBaseExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.period)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ObjcNamePieceSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.name)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let dot = node.dot { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(dot)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ObjcNameSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ObjcKeyPathExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.keyPath)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.name)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ObjcSelectorExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.poundSelector)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let kind = node.kind { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(kind)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let colon = node.colon { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.name)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: EditorPlaceholderExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.identifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ObjectLiteralExprSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.identifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.arguments)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: TypeInitializerClauseSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.equal)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.value)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: TypealiasDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(attributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(modifiers)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.typealiasKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.identifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let genericParameterClause = node.genericParameterClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(genericParameterClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let initializer = node.initializer { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(initializer)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let genericWhereClause = node.genericWhereClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(genericWhereClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: AssociatedtypeDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(attributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(modifiers)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.associatedtypeKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.identifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let inheritanceClause = node.inheritanceClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(inheritanceClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let initializer = node.initializer { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(initializer)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let genericWhereClause = node.genericWhereClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(genericWhereClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: FunctionParameterListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ParameterClauseSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.parameterList)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ReturnClauseSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.arrow)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.returnType)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: FunctionSignatureSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.input)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let throwsOrRethrowsKeyword = node.throwsOrRethrowsKeyword { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(throwsOrRethrowsKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let output = node.output { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(output)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: IfConfigClauseSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 117)
    visit(node.poundKeyword, 
          classification: .buildConfigId, 
          force: false)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let condition = node.condition { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
      visit(condition, 
            classification: .buildConfigId, 
            force: false)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.elements)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: IfConfigClauseListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: IfConfigDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.clauses)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 117)
    visit(node.poundEndif, 
          classification: .buildConfigId, 
          force: false)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: PoundErrorDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.poundError)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.message)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: PoundWarningDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.poundWarning)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.message)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: PoundSourceLocationSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.poundSourceLocation)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let args = node.args { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(args)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: PoundSourceLocationArgsSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.fileArgLabel)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.fileArgColon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.fileName)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.comma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.lineArgLabel)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.lineArgColon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.lineNumber)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: DeclModifierSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 117)
    visit(node.name, 
          classification: .attribute, 
          force: false)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let detailLeftParen = node.detailLeftParen { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(detailLeftParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let detail = node.detail { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(detail)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let detailRightParen = node.detailRightParen { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(detailRightParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: InheritedTypeSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.typeName)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: InheritedTypeListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: TypeInheritanceClauseSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.inheritedTypeCollection)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ClassDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(attributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(modifiers)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.classKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.identifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let genericParameterClause = node.genericParameterClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(genericParameterClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let inheritanceClause = node.inheritanceClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(inheritanceClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let genericWhereClause = node.genericWhereClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(genericWhereClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.members)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: StructDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(attributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(modifiers)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.structKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.identifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let genericParameterClause = node.genericParameterClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(genericParameterClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let inheritanceClause = node.inheritanceClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(inheritanceClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let genericWhereClause = node.genericWhereClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(genericWhereClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.members)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ProtocolDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(attributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(modifiers)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.protocolKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.identifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let inheritanceClause = node.inheritanceClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(inheritanceClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let genericWhereClause = node.genericWhereClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(genericWhereClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.members)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ExtensionDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(attributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(modifiers)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.extensionKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.extendedType)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let inheritanceClause = node.inheritanceClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(inheritanceClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let genericWhereClause = node.genericWhereClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(genericWhereClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.members)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: MemberDeclBlockSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftBrace)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.members)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightBrace)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: MemberDeclListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: MemberDeclListItemSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.decl)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let semicolon = node.semicolon { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(semicolon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: SourceFileSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.statements)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.eofToken)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: InitializerClauseSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.equal)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.value)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: FunctionParameterSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(attributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let firstName = node.firstName { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(firstName)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let secondName = node.secondName { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(secondName)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let colon = node.colon { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let type = node.type { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(type)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let ellipsis = node.ellipsis { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(ellipsis)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let defaultArgument = node.defaultArgument { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(defaultArgument)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ModifierListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: FunctionDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(attributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(modifiers)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.funcKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.identifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let genericParameterClause = node.genericParameterClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(genericParameterClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.signature)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let genericWhereClause = node.genericWhereClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(genericWhereClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let body = node.body { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(body)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: InitializerDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(attributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(modifiers)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.initKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let optionalMark = node.optionalMark { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(optionalMark)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let genericParameterClause = node.genericParameterClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(genericParameterClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.parameters)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let throwsOrRethrowsKeyword = node.throwsOrRethrowsKeyword { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(throwsOrRethrowsKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let genericWhereClause = node.genericWhereClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(genericWhereClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let body = node.body { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(body)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: DeinitializerDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(attributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(modifiers)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.deinitKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.body)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: SubscriptDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(attributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(modifiers)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.subscriptKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let genericParameterClause = node.genericParameterClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(genericParameterClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.indices)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.result)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let genericWhereClause = node.genericWhereClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(genericWhereClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let accessor = node.accessor { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(accessor)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: AccessLevelModifierSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.name)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let leftParen = node.leftParen { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(leftParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let modifier = node.modifier { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(modifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let rightParen = node.rightParen { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(rightParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: AccessPathComponentSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.name)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingDot = node.trailingDot { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingDot)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: AccessPathSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ImportDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(attributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(modifiers)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.importTok)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let importKind = node.importKind { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(importKind)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.path)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: AccessorParameterSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.name)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: AccessorDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(attributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let modifier = node.modifier { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(modifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.accessorKind)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let parameter = node.parameter { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(parameter)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let body = node.body { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(body)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: AccessorListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: AccessorBlockSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftBrace)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.accessorListOrStmtList)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightBrace)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: PatternBindingSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.pattern)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let typeAnnotation = node.typeAnnotation { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(typeAnnotation)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let initializer = node.initializer { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(initializer)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let accessor = node.accessor { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(accessor)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: PatternBindingListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: VariableDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(attributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(modifiers)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.letOrVarKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.bindings)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: EnumCaseElementSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.identifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let associatedValue = node.associatedValue { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(associatedValue)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let rawValue = node.rawValue { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(rawValue)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: EnumCaseElementListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: EnumCaseDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(attributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(modifiers)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.caseKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.elements)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: EnumDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(attributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(modifiers)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.enumKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.identifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let genericParameters = node.genericParameters { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(genericParameters)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let inheritanceClause = node.inheritanceClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(inheritanceClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let genericWhereClause = node.genericWhereClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(genericWhereClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.members)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: OperatorDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(attributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 108)
      visit(modifiers, 
            classification: .attribute, 
            force: false)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.operatorKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.identifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let infixOperatorGroup = node.infixOperatorGroup { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(infixOperatorGroup)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: InfixOperatorGroupSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.precedenceGroupName)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: PrecedenceGroupDeclSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(attributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let modifiers = node.modifiers { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(modifiers)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.precedencegroupKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.identifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftBrace)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.groupAttributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightBrace)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: PrecedenceGroupAttributeListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: PrecedenceGroupRelationSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 117)
    visit(node.higherThanOrLowerThan, 
          classification: .keyword, 
          force: false)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.otherNames)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: PrecedenceGroupNameListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: PrecedenceGroupNameElementSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.name)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: PrecedenceGroupAssignmentSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.assignmentKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.flag)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: PrecedenceGroupAssociativitySyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 117)
    visit(node.associativityKeyword, 
          classification: .keyword, 
          force: false)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.value)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: TokenListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: NonEmptyTokenListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: AttributeSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.atSignToken)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 117)
    visit(node.attributeName, 
          classification: .attribute, 
          force: false)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let leftParen = node.leftParen { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(leftParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let argument = node.argument { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(argument)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let rightParen = node.rightParen { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(rightParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let tokenList = node.tokenList { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(tokenList)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: AttributeListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: SpecializeAttributeSpecListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: LabeledSpecializeEntrySyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.label)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.value)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ImplementsAttributeArgumentsSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.type)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.comma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.declBaseName)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let declNameArguments = node.declNameArguments { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(declNameArguments)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ObjCSelectorPieceSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let name = node.name { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(name)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let colon = node.colon { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ObjCSelectorSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ContinueStmtSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.continueKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let label = node.label { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(label)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: WhileStmtSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let labelName = node.labelName { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(labelName)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let labelColon = node.labelColon { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(labelColon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.whileKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.conditions)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.body)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: DeferStmtSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.deferKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.body)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ExpressionStmtSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.expression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: SwitchCaseListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: RepeatWhileStmtSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let labelName = node.labelName { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(labelName)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let labelColon = node.labelColon { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(labelColon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.repeatKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.body)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.whileKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.condition)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: GuardStmtSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.guardKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.conditions)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.elseKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.body)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: WhereClauseSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.whereKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.guardResult)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ForInStmtSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let labelName = node.labelName { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(labelName)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let labelColon = node.labelColon { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(labelColon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.forKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let caseKeyword = node.caseKeyword { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(caseKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.pattern)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let typeAnnotation = node.typeAnnotation { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(typeAnnotation)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.inKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.sequenceExpr)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let whereClause = node.whereClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(whereClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.body)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: SwitchStmtSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let labelName = node.labelName { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(labelName)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let labelColon = node.labelColon { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(labelColon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.switchKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.expression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftBrace)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.cases)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightBrace)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: CatchClauseListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: DoStmtSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let labelName = node.labelName { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(labelName)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let labelColon = node.labelColon { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(labelColon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.doKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.body)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let catchClauses = node.catchClauses { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(catchClauses)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ReturnStmtSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.returnKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let expression = node.expression { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(expression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: YieldStmtSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.yieldKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let leftParen = node.leftParen { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(leftParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.expression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let rightParen = node.rightParen { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(rightParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let semicolon = node.semicolon { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(semicolon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: FallthroughStmtSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.fallthroughKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: BreakStmtSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.breakKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let label = node.label { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(label)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: CaseItemListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ConditionElementSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.condition)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: AvailabilityConditionSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.poundAvailableKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.availabilitySpec)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: MatchingPatternConditionSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.caseKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.pattern)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let typeAnnotation = node.typeAnnotation { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(typeAnnotation)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.initializer)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: OptionalBindingConditionSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.letOrVarKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.pattern)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let typeAnnotation = node.typeAnnotation { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(typeAnnotation)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.initializer)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ConditionElementListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: DeclarationStmtSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.declaration)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ThrowStmtSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.throwKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.expression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: IfStmtSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let labelName = node.labelName { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(labelName)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let labelColon = node.labelColon { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(labelColon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.ifKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.conditions)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.body)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let elseKeyword = node.elseKeyword { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(elseKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let elseBody = node.elseBody { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(elseBody)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ElseIfContinuationSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.ifStatement)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ElseBlockSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.elseKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.body)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: SwitchCaseSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let unknownAttr = node.unknownAttr { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(unknownAttr)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.label)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.statements)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: SwitchDefaultLabelSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.defaultKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: CaseItemSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.pattern)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let whereClause = node.whereClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(whereClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: SwitchCaseLabelSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.caseKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.caseItems)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: CatchClauseSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.catchKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let pattern = node.pattern { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(pattern)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let whereClause = node.whereClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(whereClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.body)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: GenericWhereClauseSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.whereKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.requirementList)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: GenericRequirementListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: SameTypeRequirementSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftTypeIdentifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.equalityToken)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightTypeIdentifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: GenericParameterListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: GenericParameterSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(attributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.name)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let colon = node.colon { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let inheritedType = node.inheritedType { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(inheritedType)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: GenericParameterClauseSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftAngleBracket)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.genericParameterList)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightAngleBracket)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ConformanceRequirementSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftTypeIdentifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightTypeIdentifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: SimpleTypeIdentifierSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 117)
    visit(node.name, 
          classification: .typeIdentifier, 
          force: false)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let genericArgumentClause = node.genericArgumentClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(genericArgumentClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: MemberTypeIdentifierSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.baseType)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.period)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 117)
    visit(node.name, 
          classification: .typeIdentifier, 
          force: false)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let genericArgumentClause = node.genericArgumentClause { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(genericArgumentClause)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ClassRestrictionTypeSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.classKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ArrayTypeSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftSquareBracket)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.elementType)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightSquareBracket)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: DictionaryTypeSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftSquareBracket)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.keyType)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.valueType)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightSquareBracket)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: MetatypeTypeSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.baseType)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.period)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.typeOrProtocol)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: OptionalTypeSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.wrappedType)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.questionMark)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.wrappedType)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.exclamationMark)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: CompositionTypeElementSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.type)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let ampersand = node.ampersand { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(ampersand)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: CompositionTypeElementListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: CompositionTypeSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.elements)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: TupleTypeElementSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let inOut = node.inOut { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(inOut)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let name = node.name { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(name)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let secondName = node.secondName { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(secondName)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let colon = node.colon { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.type)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let ellipsis = node.ellipsis { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(ellipsis)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let initializer = node.initializer { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(initializer)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: TupleTypeElementListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: TupleTypeSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.elements)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: FunctionTypeSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.arguments)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let throwsOrRethrowsKeyword = node.throwsOrRethrowsKeyword { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(throwsOrRethrowsKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.arrow)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.returnType)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: AttributedTypeSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let specifier = node.specifier { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(specifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let attributes = node.attributes { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(attributes)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.baseType)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: GenericArgumentListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: GenericArgumentSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.argumentType)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: GenericArgumentClauseSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftAngleBracket)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.arguments)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightAngleBracket)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: TypeAnnotationSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.type)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: EnumCasePatternSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let type = node.type { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(type)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.period)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.caseName)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let associatedTuple = node.associatedTuple { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(associatedTuple)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: IsTypePatternSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.isKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.type)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: OptionalPatternSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.subPattern)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.questionMark)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: IdentifierPatternSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.identifier)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: AsTypePatternSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.pattern)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.asKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.type)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: TuplePatternSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.leftParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.elements)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.rightParen)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: WildcardPatternSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.wildcard)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let typeAnnotation = node.typeAnnotation { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(typeAnnotation)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: TuplePatternElementSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let labelName = node.labelName { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(labelName)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let labelColon = node.labelColon { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(labelColon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.pattern)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ExpressionPatternSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.expression)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: TuplePatternElementListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: ValueBindingPatternSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.letOrVarKeyword)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.valuePattern)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: AvailabilitySpecListSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 102)
    super.visit(node)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: AvailabilityArgumentSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.entry)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let trailingComma = node.trailingComma { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(trailingComma)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: AvailabilityLabeledArgumentSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.label)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.colon)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.value)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: AvailabilityVersionRestrictionSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 117)
    visit(node.platform, 
          classification: .keyword, 
          force: false)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.version)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 97)
  override func visit(_ node: VersionTupleSyntax) {
    if skipNodeIds.contains(node.raw.id) {
      return
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 121)
    visit(node.majorMinor)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let patchPeriod = node.patchPeriod { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(patchPeriod)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 106)
    if let patchVersion = node.patchVersion { 
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 112)
      visit(patchVersion)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 114)
    }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 126)

  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxClassifier.swift.gyb", line: 130)
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
    classifier.visit(syntaxTree)
    return classifier.classifications
  }
}
