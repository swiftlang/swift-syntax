// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 6)
//// Automatically Generated From TokenKind.swift.gyb.
//// Do Not Edit Directly!
//===----------------- TokenKind.swift - Token Kind Enum ------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// Enumerates the kinds of tokens in the Swift language.
public enum TokenKind: Codable {
  case eof
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case associatedtypeKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case classKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case deinitKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case enumKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case extensionKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case funcKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case importKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case initKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case inoutKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case letKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case operatorKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case precedencegroupKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case protocolKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case structKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case subscriptKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case typealiasKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case varKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case fileprivateKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case internalKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case privateKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case publicKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case staticKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case deferKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case ifKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case guardKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case doKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case repeatKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case elseKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case forKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case inKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case whileKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case returnKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case breakKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case continueKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case fallthroughKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case switchKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case caseKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case defaultKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case whereKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case catchKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case throwKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case asKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case anyKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case falseKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case isKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case nilKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case rethrowsKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case superKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case selfKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case capitalSelfKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case trueKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case tryKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case throwsKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case __file__Keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case __line__Keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case __column__Keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case __function__Keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case __dso_handle__Keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case wildcardKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case leftParen
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case rightParen
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case leftBrace
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case rightBrace
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case leftSquareBracket
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case rightSquareBracket
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case leftAngle
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case rightAngle
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case period
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case prefixPeriod
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case comma
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case colon
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case semicolon
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case equal
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case atSign
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case pound
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case prefixAmpersand
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case arrow
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case backtick
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case backslash
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case exclamationMark
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case postfixQuestionMark
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case infixQuestionMark
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case stringQuote
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case multilineStringQuote
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundKeyPathKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundLineKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundSelectorKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundFileKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundColumnKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundFunctionKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundDsohandleKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundSourceLocationKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundWarningKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundErrorKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundIfKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundElseKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundElseifKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundEndifKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundAvailableKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundFileLiteralKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundImageLiteralKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundColorLiteralKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case integerLiteral(String)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case floatingLiteral(String)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case stringLiteral(String)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case unknown(String)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case identifier(String)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case unspacedBinaryOperator(String)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case spacedBinaryOperator(String)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case postfixOperator(String)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case prefixOperator(String)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case dollarIdentifier(String)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case contextualKeyword(String)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case stringSegment(String)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case stringInterpolationAnchor
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case yield
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 33)

  /// The textual representation of this token kind.
  var text: String {
    switch self {
    case .eof: return ""
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .associatedtypeKeyword: return "associatedtype"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .classKeyword: return "class"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .deinitKeyword: return "deinit"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .enumKeyword: return "enum"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .extensionKeyword: return "extension"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .funcKeyword: return "func"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .importKeyword: return "import"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .initKeyword: return "init"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .inoutKeyword: return "inout"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .letKeyword: return "let"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .operatorKeyword: return "operator"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .precedencegroupKeyword: return "precedencegroup"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .protocolKeyword: return "protocol"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .structKeyword: return "struct"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .subscriptKeyword: return "subscript"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .typealiasKeyword: return "typealias"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .varKeyword: return "var"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .fileprivateKeyword: return "fileprivate"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .internalKeyword: return "internal"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .privateKeyword: return "private"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .publicKeyword: return "public"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .staticKeyword: return "static"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .deferKeyword: return "defer"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .ifKeyword: return "if"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .guardKeyword: return "guard"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .doKeyword: return "do"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .repeatKeyword: return "repeat"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .elseKeyword: return "else"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .forKeyword: return "for"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .inKeyword: return "in"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .whileKeyword: return "while"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .returnKeyword: return "return"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .breakKeyword: return "break"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .continueKeyword: return "continue"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .fallthroughKeyword: return "fallthrough"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .switchKeyword: return "switch"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .caseKeyword: return "case"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .defaultKeyword: return "default"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .whereKeyword: return "where"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .catchKeyword: return "catch"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .throwKeyword: return "throw"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .asKeyword: return "as"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .anyKeyword: return "Any"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .falseKeyword: return "false"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .isKeyword: return "is"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .nilKeyword: return "nil"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .rethrowsKeyword: return "rethrows"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .superKeyword: return "super"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .selfKeyword: return "self"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .capitalSelfKeyword: return "Self"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .trueKeyword: return "true"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .tryKeyword: return "try"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .throwsKeyword: return "throws"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .__file__Keyword: return "__FILE__"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .__line__Keyword: return "__LINE__"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .__column__Keyword: return "__COLUMN__"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .__function__Keyword: return "__FUNCTION__"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .__dso_handle__Keyword: return "__DSO_HANDLE__"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .wildcardKeyword: return "_"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .leftParen: return "("
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .rightParen: return ")"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .leftBrace: return "{"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .rightBrace: return "}"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .leftSquareBracket: return "["
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .rightSquareBracket: return "]"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .leftAngle: return "<"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .rightAngle: return ">"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .period: return "."
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .prefixPeriod: return "."
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .comma: return ","
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .colon: return ":"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .semicolon: return ";"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .equal: return "="
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .atSign: return "@"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .pound: return "#"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .prefixAmpersand: return "&"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .arrow: return "->"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .backtick: return "`"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .backslash: return "\\"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .exclamationMark: return "!"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .postfixQuestionMark: return "?"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .infixQuestionMark: return "?"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .stringQuote: return "\""
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .multilineStringQuote: return "\"\"\""
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundKeyPathKeyword: return "#keyPath"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundLineKeyword: return "#line"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundSelectorKeyword: return "#selector"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundFileKeyword: return "#file"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundColumnKeyword: return "#column"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundFunctionKeyword: return "#function"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundDsohandleKeyword: return "#dsohandle"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundSourceLocationKeyword: return "#sourceLocation"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundWarningKeyword: return "#warning"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundErrorKeyword: return "#error"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundIfKeyword: return "#if"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundElseKeyword: return "#else"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundElseifKeyword: return "#elseif"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundEndifKeyword: return "#endif"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundAvailableKeyword: return "#available"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundFileLiteralKeyword: return "#fileLiteral"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundImageLiteralKeyword: return "#imageLiteral"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundColorLiteralKeyword: return "#colorLiteral"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .integerLiteral(let text): return text
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .floatingLiteral(let text): return text
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .stringLiteral(let text): return text
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .unknown(let text): return text
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .identifier(let text): return text
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .unspacedBinaryOperator(let text): return text
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .spacedBinaryOperator(let text): return text
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .postfixOperator(let text): return text
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .prefixOperator(let text): return text
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .dollarIdentifier(let text): return text
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .contextualKeyword(let text): return text
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .stringSegment(let text): return text
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .stringInterpolationAnchor: return ")"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .yield: return "yield"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 45)
    }
  }

  /// Keys for serializing and deserializing token kinds.
  enum CodingKeys: String, CodingKey {
    case kind, text
  }

  enum DecodeError: Error {
    case unknownTokenKind(String)
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let kind = try container.decode(String.self, forKey: .kind)
    switch kind {
    case "eof": self = .eof
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_associatedtype":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .associatedtypeKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_class":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .classKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_deinit":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .deinitKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_enum":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .enumKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_extension":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .extensionKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_func":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .funcKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_import":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .importKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_init":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .initKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_inout":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .inoutKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_let":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .letKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_operator":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .operatorKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_precedencegroup":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .precedencegroupKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_protocol":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .protocolKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_struct":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .structKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_subscript":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .subscriptKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_typealias":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .typealiasKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_var":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .varKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_fileprivate":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .fileprivateKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_internal":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .internalKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_private":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .privateKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_public":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .publicKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_static":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .staticKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_defer":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .deferKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_if":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .ifKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_guard":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .guardKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_do":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .doKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_repeat":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .repeatKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_else":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .elseKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_for":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .forKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_in":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .inKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_while":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .whileKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_return":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .returnKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_break":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .breakKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_continue":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .continueKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_fallthrough":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .fallthroughKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_switch":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .switchKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_case":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .caseKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_default":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .defaultKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_where":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .whereKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_catch":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .catchKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_throw":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .throwKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_as":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .asKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_Any":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .anyKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_false":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .falseKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_is":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .isKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_nil":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .nilKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_rethrows":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .rethrowsKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_super":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .superKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_self":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .selfKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_Self":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .capitalSelfKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_true":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .trueKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_try":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .tryKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_throws":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .throwsKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw___FILE__":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .__file__Keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw___LINE__":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .__line__Keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw___COLUMN__":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .__column__Keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw___FUNCTION__":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .__function__Keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw___DSO_HANDLE__":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .__dso_handle__Keyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw__":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .wildcardKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "l_paren":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .leftParen
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "r_paren":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .rightParen
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "l_brace":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .leftBrace
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "r_brace":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .rightBrace
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "l_square":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .leftSquareBracket
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "r_square":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .rightSquareBracket
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "l_angle":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .leftAngle
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "r_angle":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .rightAngle
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "period":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .period
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "period_prefix":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .prefixPeriod
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "comma":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .comma
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "colon":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .colon
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "semi":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .semicolon
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "equal":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .equal
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "at_sign":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .atSign
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "pound":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .pound
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "amp_prefix":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .prefixAmpersand
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "arrow":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .arrow
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "backtick":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .backtick
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "backslash":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .backslash
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "exclaim_postfix":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .exclamationMark
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "question_postfix":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .postfixQuestionMark
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "question_infix":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .infixQuestionMark
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "string_quote":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .stringQuote
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "multiline_string_quote":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .multilineStringQuote
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "pound_keyPath":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .poundKeyPathKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "pound_line":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .poundLineKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "pound_selector":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .poundSelectorKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "pound_file":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .poundFileKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "pound_column":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .poundColumnKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "pound_function":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .poundFunctionKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "pound_dsohandle":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .poundDsohandleKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "pound_sourceLocation":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .poundSourceLocationKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "pound_warning":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .poundWarningKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "pound_error":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .poundErrorKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "pound_if":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .poundIfKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "pound_else":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .poundElseKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "pound_elseif":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .poundElseifKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "pound_endif":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .poundEndifKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "pound_available":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .poundAvailableKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "pound_fileLiteral":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .poundFileLiteralKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "pound_imageLiteral":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .poundImageLiteralKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "pound_colorLiteral":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .poundColorLiteralKeyword
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "integer_literal":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 67)
      let text = try container.decode(String.self, forKey: .text)
      self = .integerLiteral(text)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "floating_literal":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 67)
      let text = try container.decode(String.self, forKey: .text)
      self = .floatingLiteral(text)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "string_literal":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 67)
      let text = try container.decode(String.self, forKey: .text)
      self = .stringLiteral(text)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "unknown":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 67)
      let text = try container.decode(String.self, forKey: .text)
      self = .unknown(text)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "identifier":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 67)
      let text = try container.decode(String.self, forKey: .text)
      self = .identifier(text)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "oper_binary_unspaced":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 67)
      let text = try container.decode(String.self, forKey: .text)
      self = .unspacedBinaryOperator(text)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "oper_binary_spaced":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 67)
      let text = try container.decode(String.self, forKey: .text)
      self = .spacedBinaryOperator(text)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "oper_postfix":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 67)
      let text = try container.decode(String.self, forKey: .text)
      self = .postfixOperator(text)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "oper_prefix":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 67)
      let text = try container.decode(String.self, forKey: .text)
      self = .prefixOperator(text)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "dollarident":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 67)
      let text = try container.decode(String.self, forKey: .text)
      self = .dollarIdentifier(text)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "contextual_keyword":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 67)
      let text = try container.decode(String.self, forKey: .text)
      self = .contextualKeyword(text)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "string_segment":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 67)
      let text = try container.decode(String.self, forKey: .text)
      self = .stringSegment(text)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "string_interpolation_anchor":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .stringInterpolationAnchor
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 63)
    case "kw_yield":
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 65)
      self = .yield
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 71)
    default: throw DecodeError.unknownTokenKind(kind)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(kind, forKey: .kind)
    try container.encode(text, forKey: .text)
  }
  
  var kind: String {
    switch self {
    case .eof: return "eof"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .associatedtypeKeyword: return "kw_associatedtype"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .classKeyword: return "kw_class"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .deinitKeyword: return "kw_deinit"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .enumKeyword: return "kw_enum"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .extensionKeyword: return "kw_extension"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .funcKeyword: return "kw_func"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .importKeyword: return "kw_import"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .initKeyword: return "kw_init"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .inoutKeyword: return "kw_inout"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .letKeyword: return "kw_let"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .operatorKeyword: return "kw_operator"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .precedencegroupKeyword: return "kw_precedencegroup"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .protocolKeyword: return "kw_protocol"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .structKeyword: return "kw_struct"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .subscriptKeyword: return "kw_subscript"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .typealiasKeyword: return "kw_typealias"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .varKeyword: return "kw_var"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .fileprivateKeyword: return "kw_fileprivate"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .internalKeyword: return "kw_internal"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .privateKeyword: return "kw_private"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .publicKeyword: return "kw_public"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .staticKeyword: return "kw_static"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .deferKeyword: return "kw_defer"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .ifKeyword: return "kw_if"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .guardKeyword: return "kw_guard"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .doKeyword: return "kw_do"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .repeatKeyword: return "kw_repeat"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .elseKeyword: return "kw_else"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .forKeyword: return "kw_for"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .inKeyword: return "kw_in"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .whileKeyword: return "kw_while"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .returnKeyword: return "kw_return"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .breakKeyword: return "kw_break"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .continueKeyword: return "kw_continue"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .fallthroughKeyword: return "kw_fallthrough"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .switchKeyword: return "kw_switch"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .caseKeyword: return "kw_case"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .defaultKeyword: return "kw_default"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .whereKeyword: return "kw_where"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .catchKeyword: return "kw_catch"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .throwKeyword: return "kw_throw"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .asKeyword: return "kw_as"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .anyKeyword: return "kw_Any"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .falseKeyword: return "kw_false"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .isKeyword: return "kw_is"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .nilKeyword: return "kw_nil"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .rethrowsKeyword: return "kw_rethrows"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .superKeyword: return "kw_super"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .selfKeyword: return "kw_self"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .capitalSelfKeyword: return "kw_Self"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .trueKeyword: return "kw_true"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .tryKeyword: return "kw_try"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .throwsKeyword: return "kw_throws"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .__file__Keyword: return "kw___FILE__"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .__line__Keyword: return "kw___LINE__"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .__column__Keyword: return "kw___COLUMN__"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .__function__Keyword: return "kw___FUNCTION__"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .__dso_handle__Keyword: return "kw___DSO_HANDLE__"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .wildcardKeyword: return "kw__"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .leftParen: return "l_paren"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .rightParen: return "r_paren"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .leftBrace: return "l_brace"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .rightBrace: return "r_brace"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .leftSquareBracket: return "l_square"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .rightSquareBracket: return "r_square"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .leftAngle: return "l_angle"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .rightAngle: return "r_angle"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .period: return "period"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .prefixPeriod: return "period_prefix"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .comma: return "comma"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .colon: return "colon"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .semicolon: return "semi"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .equal: return "equal"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .atSign: return "at_sign"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .pound: return "pound"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .prefixAmpersand: return "amp_prefix"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .arrow: return "arrow"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .backtick: return "backtick"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .backslash: return "backslash"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .exclamationMark: return "exclaim_postfix"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .postfixQuestionMark: return "question_postfix"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .infixQuestionMark: return "question_infix"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .stringQuote: return "string_quote"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .multilineStringQuote: return "multiline_string_quote"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .poundKeyPathKeyword: return "pound_keyPath"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .poundLineKeyword: return "pound_line"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .poundSelectorKeyword: return "pound_selector"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .poundFileKeyword: return "pound_file"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .poundColumnKeyword: return "pound_column"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .poundFunctionKeyword: return "pound_function"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .poundDsohandleKeyword: return "pound_dsohandle"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .poundSourceLocationKeyword: return "pound_sourceLocation"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .poundWarningKeyword: return "pound_warning"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .poundErrorKeyword: return "pound_error"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .poundIfKeyword: return "pound_if"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .poundElseKeyword: return "pound_else"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .poundElseifKeyword: return "pound_elseif"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .poundEndifKeyword: return "pound_endif"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .poundAvailableKeyword: return "pound_available"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .poundFileLiteralKeyword: return "pound_fileLiteral"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .poundImageLiteralKeyword: return "pound_imageLiteral"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .poundColorLiteralKeyword: return "pound_colorLiteral"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .integerLiteral(_): return "integer_literal"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .floatingLiteral(_): return "floating_literal"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .stringLiteral(_): return "string_literal"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .unknown(_): return "unknown"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .identifier(_): return "identifier"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .unspacedBinaryOperator(_): return "oper_binary_unspaced"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .spacedBinaryOperator(_): return "oper_binary_spaced"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .postfixOperator(_): return "oper_postfix"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .prefixOperator(_): return "oper_prefix"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .dollarIdentifier(_): return "dollarident"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .contextualKeyword(_): return "contextual_keyword"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .stringSegment(_): return "string_segment"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .stringInterpolationAnchor: return "string_interpolation_anchor"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 89)
    case .yield: return "kw_yield"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 91)
    }
  }
}

extension TokenKind: Equatable {
  public static func ==(lhs: TokenKind, rhs: TokenKind) -> Bool {
    switch (lhs, rhs) {
    case (.eof, .eof): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.associatedtypeKeyword, .associatedtypeKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.classKeyword, .classKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.deinitKeyword, .deinitKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.enumKeyword, .enumKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.extensionKeyword, .extensionKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.funcKeyword, .funcKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.importKeyword, .importKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.initKeyword, .initKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.inoutKeyword, .inoutKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.letKeyword, .letKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.operatorKeyword, .operatorKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.precedencegroupKeyword, .precedencegroupKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.protocolKeyword, .protocolKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.structKeyword, .structKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.subscriptKeyword, .subscriptKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.typealiasKeyword, .typealiasKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.varKeyword, .varKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.fileprivateKeyword, .fileprivateKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.internalKeyword, .internalKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.privateKeyword, .privateKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.publicKeyword, .publicKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.staticKeyword, .staticKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.deferKeyword, .deferKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.ifKeyword, .ifKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.guardKeyword, .guardKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.doKeyword, .doKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.repeatKeyword, .repeatKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.elseKeyword, .elseKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.forKeyword, .forKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.inKeyword, .inKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.whileKeyword, .whileKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.returnKeyword, .returnKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.breakKeyword, .breakKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.continueKeyword, .continueKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.fallthroughKeyword, .fallthroughKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.switchKeyword, .switchKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.caseKeyword, .caseKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.defaultKeyword, .defaultKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.whereKeyword, .whereKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.catchKeyword, .catchKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.throwKeyword, .throwKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.asKeyword, .asKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.anyKeyword, .anyKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.falseKeyword, .falseKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.isKeyword, .isKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.nilKeyword, .nilKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.rethrowsKeyword, .rethrowsKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.superKeyword, .superKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.selfKeyword, .selfKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.capitalSelfKeyword, .capitalSelfKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.trueKeyword, .trueKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.tryKeyword, .tryKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.throwsKeyword, .throwsKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.__file__Keyword, .__file__Keyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.__line__Keyword, .__line__Keyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.__column__Keyword, .__column__Keyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.__function__Keyword, .__function__Keyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.__dso_handle__Keyword, .__dso_handle__Keyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.wildcardKeyword, .wildcardKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.leftParen, .leftParen): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.rightParen, .rightParen): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.leftBrace, .leftBrace): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.rightBrace, .rightBrace): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.leftSquareBracket, .leftSquareBracket): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.rightSquareBracket, .rightSquareBracket): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.leftAngle, .leftAngle): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.rightAngle, .rightAngle): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.period, .period): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.prefixPeriod, .prefixPeriod): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.comma, .comma): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.colon, .colon): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.semicolon, .semicolon): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.equal, .equal): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.atSign, .atSign): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.pound, .pound): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.prefixAmpersand, .prefixAmpersand): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.arrow, .arrow): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.backtick, .backtick): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.backslash, .backslash): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.exclamationMark, .exclamationMark): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.postfixQuestionMark, .postfixQuestionMark): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.infixQuestionMark, .infixQuestionMark): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.stringQuote, .stringQuote): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.multilineStringQuote, .multilineStringQuote): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.poundKeyPathKeyword, .poundKeyPathKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.poundLineKeyword, .poundLineKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.poundSelectorKeyword, .poundSelectorKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.poundFileKeyword, .poundFileKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.poundColumnKeyword, .poundColumnKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.poundFunctionKeyword, .poundFunctionKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.poundDsohandleKeyword, .poundDsohandleKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.poundSourceLocationKeyword, .poundSourceLocationKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.poundWarningKeyword, .poundWarningKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.poundErrorKeyword, .poundErrorKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.poundIfKeyword, .poundIfKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.poundElseKeyword, .poundElseKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.poundElseifKeyword, .poundElseifKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.poundEndifKeyword, .poundEndifKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.poundAvailableKeyword, .poundAvailableKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.poundFileLiteralKeyword, .poundFileLiteralKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.poundImageLiteralKeyword, .poundImageLiteralKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.poundColorLiteralKeyword, .poundColorLiteralKeyword): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 104)
    case (.integerLiteral(let lhsText), .integerLiteral(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 104)
    case (.floatingLiteral(let lhsText), .floatingLiteral(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 104)
    case (.stringLiteral(let lhsText), .stringLiteral(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 104)
    case (.unknown(let lhsText), .unknown(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 104)
    case (.identifier(let lhsText), .identifier(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 104)
    case (.unspacedBinaryOperator(let lhsText), .unspacedBinaryOperator(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 104)
    case (.spacedBinaryOperator(let lhsText), .spacedBinaryOperator(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 104)
    case (.postfixOperator(let lhsText), .postfixOperator(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 104)
    case (.prefixOperator(let lhsText), .prefixOperator(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 104)
    case (.dollarIdentifier(let lhsText), .dollarIdentifier(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 104)
    case (.contextualKeyword(let lhsText), .contextualKeyword(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 104)
    case (.stringSegment(let lhsText), .stringSegment(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.stringInterpolationAnchor, .stringInterpolationAnchor): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case (.yield, .yield): return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 108)
    default: return false
    }
  }
}
