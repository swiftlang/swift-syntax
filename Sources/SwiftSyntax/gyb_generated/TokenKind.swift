// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 6)
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
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case associatedtypeKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case classKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case deinitKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case enumKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case extensionKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case funcKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case importKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case initKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case inoutKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case letKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case operatorKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case precedencegroupKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case protocolKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case structKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case subscriptKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case typealiasKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case varKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case fileprivateKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case internalKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case privateKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case publicKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case staticKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case deferKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case ifKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case guardKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case doKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case repeatKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case elseKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case forKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case inKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case whileKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case returnKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case breakKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case continueKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case fallthroughKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case switchKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case caseKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case defaultKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case whereKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case catchKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case throwKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case asKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case anyKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case falseKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case isKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case nilKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case rethrowsKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case superKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case selfKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case capitalSelfKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case trueKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case tryKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case throwsKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case __file__Keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case __line__Keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case __column__Keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case __function__Keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case __dso_handle__Keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case wildcardKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case leftParen
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case rightParen
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case leftBrace
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case rightBrace
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case leftSquareBracket
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case rightSquareBracket
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case leftAngle
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case rightAngle
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case period
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case prefixPeriod
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case comma
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case colon
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case semicolon
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case equal
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case atSign
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case pound
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case prefixAmpersand
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case arrow
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case backtick
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case backslash
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case exclamationMark
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case postfixQuestionMark
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case infixQuestionMark
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case stringQuote
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case multilineStringQuote
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundKeyPathKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundLineKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundSelectorKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundFileKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundColumnKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundFunctionKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundDsohandleKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundAssertKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundSourceLocationKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundWarningKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundErrorKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundIfKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundElseKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundElseifKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundEndifKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundAvailableKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundFileLiteralKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundImageLiteralKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case poundColorLiteralKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case integerLiteral(String)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case floatingLiteral(String)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case stringLiteral(String)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case unknown(String)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case identifier(String)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case unspacedBinaryOperator(String)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case spacedBinaryOperator(String)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case postfixOperator(String)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case prefixOperator(String)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case dollarIdentifier(String)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case contextualKeyword(String)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case stringSegment(String)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case stringInterpolationAnchor
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 31)
  case yield
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 33)

  /// The textual representation of this token kind.
  var text: String {
    switch self {
    case .eof: return ""
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .associatedtypeKeyword: return "associatedtype"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .classKeyword: return "class"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .deinitKeyword: return "deinit"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .enumKeyword: return "enum"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .extensionKeyword: return "extension"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .funcKeyword: return "func"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .importKeyword: return "import"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .initKeyword: return "init"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .inoutKeyword: return "inout"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .letKeyword: return "let"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .operatorKeyword: return "operator"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .precedencegroupKeyword: return "precedencegroup"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .protocolKeyword: return "protocol"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .structKeyword: return "struct"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .subscriptKeyword: return "subscript"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .typealiasKeyword: return "typealias"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .varKeyword: return "var"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .fileprivateKeyword: return "fileprivate"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .internalKeyword: return "internal"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .privateKeyword: return "private"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .publicKeyword: return "public"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .staticKeyword: return "static"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .deferKeyword: return "defer"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .ifKeyword: return "if"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .guardKeyword: return "guard"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .doKeyword: return "do"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .repeatKeyword: return "repeat"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .elseKeyword: return "else"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .forKeyword: return "for"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .inKeyword: return "in"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .whileKeyword: return "while"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .returnKeyword: return "return"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .breakKeyword: return "break"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .continueKeyword: return "continue"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .fallthroughKeyword: return "fallthrough"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .switchKeyword: return "switch"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .caseKeyword: return "case"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .defaultKeyword: return "default"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .whereKeyword: return "where"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .catchKeyword: return "catch"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .throwKeyword: return "throw"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .asKeyword: return "as"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .anyKeyword: return "Any"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .falseKeyword: return "false"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .isKeyword: return "is"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .nilKeyword: return "nil"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .rethrowsKeyword: return "rethrows"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .superKeyword: return "super"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .selfKeyword: return "self"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .capitalSelfKeyword: return "Self"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .trueKeyword: return "true"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .tryKeyword: return "try"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .throwsKeyword: return "throws"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .__file__Keyword: return "__FILE__"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .__line__Keyword: return "__LINE__"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .__column__Keyword: return "__COLUMN__"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .__function__Keyword: return "__FUNCTION__"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .__dso_handle__Keyword: return "__DSO_HANDLE__"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .wildcardKeyword: return "_"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .leftParen: return "("
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .rightParen: return ")"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .leftBrace: return "{"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .rightBrace: return "}"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .leftSquareBracket: return "["
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .rightSquareBracket: return "]"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .leftAngle: return "<"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .rightAngle: return ">"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .period: return "."
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .prefixPeriod: return "."
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .comma: return ","
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .colon: return ":"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .semicolon: return ";"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .equal: return "="
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .atSign: return "@"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .pound: return "#"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .prefixAmpersand: return "&"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .arrow: return "->"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .backtick: return "`"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .backslash: return "\\"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .exclamationMark: return "!"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .postfixQuestionMark: return "?"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .infixQuestionMark: return "?"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .stringQuote: return "\""
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .multilineStringQuote: return "\"\"\""
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundKeyPathKeyword: return "#keyPath"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundLineKeyword: return "#line"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundSelectorKeyword: return "#selector"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundFileKeyword: return "#file"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundColumnKeyword: return "#column"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundFunctionKeyword: return "#function"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundDsohandleKeyword: return "#dsohandle"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundAssertKeyword: return "#assert"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundSourceLocationKeyword: return "#sourceLocation"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundWarningKeyword: return "#warning"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundErrorKeyword: return "#error"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundIfKeyword: return "#if"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundElseKeyword: return "#else"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundElseifKeyword: return "#elseif"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundEndifKeyword: return "#endif"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundAvailableKeyword: return "#available"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundFileLiteralKeyword: return "#fileLiteral"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundImageLiteralKeyword: return "#imageLiteral"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .poundColorLiteralKeyword: return "#colorLiteral"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .integerLiteral(let text): return text
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .floatingLiteral(let text): return text
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .stringLiteral(let text): return text
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .unknown(let text): return text
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .identifier(let text): return text
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .unspacedBinaryOperator(let text): return text
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .spacedBinaryOperator(let text): return text
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .postfixOperator(let text): return text
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .prefixOperator(let text): return text
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .dollarIdentifier(let text): return text
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .contextualKeyword(let text): return text
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 42)
    case .stringSegment(let text): return text
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .stringInterpolationAnchor: return ")"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 40)
    case .yield: return "yield"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 45)
    }
  }

  public var isKeyword: Bool {
    switch self {
    case .eof: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .associatedtypeKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .classKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .deinitKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .enumKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .extensionKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .funcKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .importKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .initKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .inoutKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .letKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .operatorKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .precedencegroupKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .protocolKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .structKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .subscriptKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .typealiasKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .varKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .fileprivateKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .internalKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .privateKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .publicKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .staticKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .deferKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .ifKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .guardKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .doKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .repeatKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .elseKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .forKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .inKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .whileKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .returnKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .breakKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .continueKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .fallthroughKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .switchKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .caseKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .defaultKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .whereKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .catchKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .throwKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .asKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .anyKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .falseKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .isKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .nilKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .rethrowsKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .superKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .selfKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .capitalSelfKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .trueKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .tryKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .throwsKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .__file__Keyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .__line__Keyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .__column__Keyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .__function__Keyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .__dso_handle__Keyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .wildcardKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .leftParen: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .rightParen: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .leftBrace: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .rightBrace: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .leftSquareBracket: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .rightSquareBracket: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .leftAngle: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .rightAngle: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .period: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .prefixPeriod: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .comma: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .colon: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .semicolon: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .equal: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .atSign: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .pound: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .prefixAmpersand: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .arrow: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .backtick: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .backslash: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .exclamationMark: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .postfixQuestionMark: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .infixQuestionMark: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .stringQuote: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .multilineStringQuote: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .poundKeyPathKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .poundLineKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .poundSelectorKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .poundFileKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .poundColumnKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .poundFunctionKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .poundDsohandleKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .poundAssertKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .poundSourceLocationKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .poundWarningKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .poundErrorKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .poundIfKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .poundElseKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .poundElseifKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .poundEndifKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .poundAvailableKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .poundFileLiteralKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .poundImageLiteralKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 53)
    case .poundColorLiteralKeyword: return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .integerLiteral: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .floatingLiteral: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .stringLiteral: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .unknown: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .identifier: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .unspacedBinaryOperator: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .spacedBinaryOperator: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .postfixOperator: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .prefixOperator: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .dollarIdentifier: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .contextualKeyword: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .stringSegment: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .stringInterpolationAnchor: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 55)
    case .yield: return false
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 58)
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
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_associatedtype":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .associatedtypeKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_class":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .classKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_deinit":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .deinitKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_enum":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .enumKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_extension":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .extensionKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_func":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .funcKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_import":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .importKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_init":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .initKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_inout":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .inoutKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_let":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .letKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_operator":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .operatorKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_precedencegroup":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .precedencegroupKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_protocol":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .protocolKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_struct":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .structKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_subscript":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .subscriptKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_typealias":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .typealiasKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_var":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .varKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_fileprivate":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .fileprivateKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_internal":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .internalKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_private":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .privateKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_public":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .publicKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_static":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .staticKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_defer":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .deferKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_if":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .ifKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_guard":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .guardKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_do":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .doKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_repeat":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .repeatKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_else":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .elseKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_for":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .forKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_in":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .inKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_while":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .whileKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_return":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .returnKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_break":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .breakKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_continue":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .continueKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_fallthrough":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .fallthroughKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_switch":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .switchKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_case":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .caseKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_default":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .defaultKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_where":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .whereKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_catch":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .catchKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_throw":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .throwKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_as":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .asKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_Any":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .anyKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_false":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .falseKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_is":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .isKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_nil":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .nilKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_rethrows":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .rethrowsKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_super":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .superKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_self":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .selfKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_Self":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .capitalSelfKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_true":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .trueKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_try":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .tryKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_throws":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .throwsKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw___FILE__":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .__file__Keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw___LINE__":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .__line__Keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw___COLUMN__":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .__column__Keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw___FUNCTION__":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .__function__Keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw___DSO_HANDLE__":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .__dso_handle__Keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw__":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .wildcardKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "l_paren":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .leftParen
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "r_paren":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .rightParen
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "l_brace":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .leftBrace
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "r_brace":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .rightBrace
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "l_square":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .leftSquareBracket
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "r_square":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .rightSquareBracket
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "l_angle":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .leftAngle
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "r_angle":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .rightAngle
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "period":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .period
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "period_prefix":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .prefixPeriod
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "comma":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .comma
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "colon":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .colon
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "semi":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .semicolon
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "equal":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .equal
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "at_sign":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .atSign
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "pound":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .pound
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "amp_prefix":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .prefixAmpersand
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "arrow":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .arrow
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "backtick":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .backtick
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "backslash":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .backslash
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "exclaim_postfix":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .exclamationMark
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "question_postfix":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .postfixQuestionMark
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "question_infix":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .infixQuestionMark
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "string_quote":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .stringQuote
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "multiline_string_quote":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .multilineStringQuote
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "pound_keyPath":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .poundKeyPathKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "pound_line":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .poundLineKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "pound_selector":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .poundSelectorKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "pound_file":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .poundFileKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "pound_column":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .poundColumnKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "pound_function":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .poundFunctionKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "pound_dsohandle":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .poundDsohandleKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "pound_assert":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .poundAssertKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "pound_sourceLocation":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .poundSourceLocationKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "pound_warning":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .poundWarningKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "pound_error":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .poundErrorKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "pound_if":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .poundIfKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "pound_else":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .poundElseKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "pound_elseif":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .poundElseifKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "pound_endif":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .poundEndifKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "pound_available":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .poundAvailableKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "pound_fileLiteral":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .poundFileLiteralKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "pound_imageLiteral":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .poundImageLiteralKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "pound_colorLiteral":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .poundColorLiteralKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "integer_literal":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 80)
      let text = try container.decode(String.self, forKey: .text)
      self = .integerLiteral(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "floating_literal":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 80)
      let text = try container.decode(String.self, forKey: .text)
      self = .floatingLiteral(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "string_literal":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 80)
      let text = try container.decode(String.self, forKey: .text)
      self = .stringLiteral(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "unknown":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 80)
      let text = try container.decode(String.self, forKey: .text)
      self = .unknown(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "identifier":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 80)
      let text = try container.decode(String.self, forKey: .text)
      self = .identifier(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "oper_binary_unspaced":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 80)
      let text = try container.decode(String.self, forKey: .text)
      self = .unspacedBinaryOperator(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "oper_binary_spaced":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 80)
      let text = try container.decode(String.self, forKey: .text)
      self = .spacedBinaryOperator(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "oper_postfix":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 80)
      let text = try container.decode(String.self, forKey: .text)
      self = .postfixOperator(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "oper_prefix":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 80)
      let text = try container.decode(String.self, forKey: .text)
      self = .prefixOperator(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "dollarident":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 80)
      let text = try container.decode(String.self, forKey: .text)
      self = .dollarIdentifier(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "contextual_keyword":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 80)
      let text = try container.decode(String.self, forKey: .text)
      self = .contextualKeyword(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "string_segment":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 80)
      let text = try container.decode(String.self, forKey: .text)
      self = .stringSegment(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "string_interpolation_anchor":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .stringInterpolationAnchor
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 76)
    case "kw_yield":
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 78)
      self = .yield
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 84)
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
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .associatedtypeKeyword: return "kw_associatedtype"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .classKeyword: return "kw_class"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .deinitKeyword: return "kw_deinit"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .enumKeyword: return "kw_enum"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .extensionKeyword: return "kw_extension"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .funcKeyword: return "kw_func"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .importKeyword: return "kw_import"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .initKeyword: return "kw_init"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .inoutKeyword: return "kw_inout"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .letKeyword: return "kw_let"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .operatorKeyword: return "kw_operator"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .precedencegroupKeyword: return "kw_precedencegroup"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .protocolKeyword: return "kw_protocol"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .structKeyword: return "kw_struct"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .subscriptKeyword: return "kw_subscript"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .typealiasKeyword: return "kw_typealias"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .varKeyword: return "kw_var"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .fileprivateKeyword: return "kw_fileprivate"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .internalKeyword: return "kw_internal"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .privateKeyword: return "kw_private"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .publicKeyword: return "kw_public"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .staticKeyword: return "kw_static"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .deferKeyword: return "kw_defer"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .ifKeyword: return "kw_if"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .guardKeyword: return "kw_guard"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .doKeyword: return "kw_do"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .repeatKeyword: return "kw_repeat"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .elseKeyword: return "kw_else"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .forKeyword: return "kw_for"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .inKeyword: return "kw_in"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .whileKeyword: return "kw_while"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .returnKeyword: return "kw_return"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .breakKeyword: return "kw_break"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .continueKeyword: return "kw_continue"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .fallthroughKeyword: return "kw_fallthrough"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .switchKeyword: return "kw_switch"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .caseKeyword: return "kw_case"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .defaultKeyword: return "kw_default"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .whereKeyword: return "kw_where"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .catchKeyword: return "kw_catch"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .throwKeyword: return "kw_throw"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .asKeyword: return "kw_as"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .anyKeyword: return "kw_Any"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .falseKeyword: return "kw_false"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .isKeyword: return "kw_is"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .nilKeyword: return "kw_nil"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .rethrowsKeyword: return "kw_rethrows"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .superKeyword: return "kw_super"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .selfKeyword: return "kw_self"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .capitalSelfKeyword: return "kw_Self"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .trueKeyword: return "kw_true"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .tryKeyword: return "kw_try"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .throwsKeyword: return "kw_throws"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .__file__Keyword: return "kw___FILE__"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .__line__Keyword: return "kw___LINE__"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .__column__Keyword: return "kw___COLUMN__"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .__function__Keyword: return "kw___FUNCTION__"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .__dso_handle__Keyword: return "kw___DSO_HANDLE__"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .wildcardKeyword: return "kw__"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .leftParen: return "l_paren"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .rightParen: return "r_paren"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .leftBrace: return "l_brace"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .rightBrace: return "r_brace"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .leftSquareBracket: return "l_square"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .rightSquareBracket: return "r_square"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .leftAngle: return "l_angle"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .rightAngle: return "r_angle"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .period: return "period"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .prefixPeriod: return "period_prefix"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .comma: return "comma"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .colon: return "colon"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .semicolon: return "semi"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .equal: return "equal"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .atSign: return "at_sign"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .pound: return "pound"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .prefixAmpersand: return "amp_prefix"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .arrow: return "arrow"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .backtick: return "backtick"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .backslash: return "backslash"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .exclamationMark: return "exclaim_postfix"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .postfixQuestionMark: return "question_postfix"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .infixQuestionMark: return "question_infix"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .stringQuote: return "string_quote"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .multilineStringQuote: return "multiline_string_quote"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .poundKeyPathKeyword: return "pound_keyPath"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .poundLineKeyword: return "pound_line"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .poundSelectorKeyword: return "pound_selector"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .poundFileKeyword: return "pound_file"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .poundColumnKeyword: return "pound_column"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .poundFunctionKeyword: return "pound_function"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .poundDsohandleKeyword: return "pound_dsohandle"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .poundAssertKeyword: return "pound_assert"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .poundSourceLocationKeyword: return "pound_sourceLocation"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .poundWarningKeyword: return "pound_warning"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .poundErrorKeyword: return "pound_error"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .poundIfKeyword: return "pound_if"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .poundElseKeyword: return "pound_else"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .poundElseifKeyword: return "pound_elseif"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .poundEndifKeyword: return "pound_endif"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .poundAvailableKeyword: return "pound_available"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .poundFileLiteralKeyword: return "pound_fileLiteral"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .poundImageLiteralKeyword: return "pound_imageLiteral"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .poundColorLiteralKeyword: return "pound_colorLiteral"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .integerLiteral(_): return "integer_literal"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .floatingLiteral(_): return "floating_literal"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .stringLiteral(_): return "string_literal"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .unknown(_): return "unknown"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .identifier(_): return "identifier"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .unspacedBinaryOperator(_): return "oper_binary_unspaced"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .spacedBinaryOperator(_): return "oper_binary_spaced"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .postfixOperator(_): return "oper_postfix"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .prefixOperator(_): return "oper_prefix"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .dollarIdentifier(_): return "dollarident"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .contextualKeyword(_): return "contextual_keyword"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .stringSegment(_): return "string_segment"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .stringInterpolationAnchor: return "string_interpolation_anchor"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 102)
    case .yield: return "kw_yield"
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 104)
    }
  }
}

extension TokenKind: Equatable {
  public static func ==(lhs: TokenKind, rhs: TokenKind) -> Bool {
    switch (lhs, rhs) {
    case (.eof, .eof): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.associatedtypeKeyword, .associatedtypeKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.classKeyword, .classKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.deinitKeyword, .deinitKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.enumKeyword, .enumKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.extensionKeyword, .extensionKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.funcKeyword, .funcKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.importKeyword, .importKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.initKeyword, .initKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.inoutKeyword, .inoutKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.letKeyword, .letKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.operatorKeyword, .operatorKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.precedencegroupKeyword, .precedencegroupKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.protocolKeyword, .protocolKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.structKeyword, .structKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.subscriptKeyword, .subscriptKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.typealiasKeyword, .typealiasKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.varKeyword, .varKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.fileprivateKeyword, .fileprivateKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.internalKeyword, .internalKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.privateKeyword, .privateKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.publicKeyword, .publicKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.staticKeyword, .staticKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.deferKeyword, .deferKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.ifKeyword, .ifKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.guardKeyword, .guardKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.doKeyword, .doKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.repeatKeyword, .repeatKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.elseKeyword, .elseKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.forKeyword, .forKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.inKeyword, .inKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.whileKeyword, .whileKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.returnKeyword, .returnKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.breakKeyword, .breakKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.continueKeyword, .continueKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.fallthroughKeyword, .fallthroughKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.switchKeyword, .switchKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.caseKeyword, .caseKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.defaultKeyword, .defaultKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.whereKeyword, .whereKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.catchKeyword, .catchKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.throwKeyword, .throwKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.asKeyword, .asKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.anyKeyword, .anyKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.falseKeyword, .falseKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.isKeyword, .isKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.nilKeyword, .nilKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.rethrowsKeyword, .rethrowsKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.superKeyword, .superKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.selfKeyword, .selfKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.capitalSelfKeyword, .capitalSelfKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.trueKeyword, .trueKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.tryKeyword, .tryKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.throwsKeyword, .throwsKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.__file__Keyword, .__file__Keyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.__line__Keyword, .__line__Keyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.__column__Keyword, .__column__Keyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.__function__Keyword, .__function__Keyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.__dso_handle__Keyword, .__dso_handle__Keyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.wildcardKeyword, .wildcardKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.leftParen, .leftParen): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.rightParen, .rightParen): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.leftBrace, .leftBrace): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.rightBrace, .rightBrace): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.leftSquareBracket, .leftSquareBracket): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.rightSquareBracket, .rightSquareBracket): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.leftAngle, .leftAngle): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.rightAngle, .rightAngle): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.period, .period): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.prefixPeriod, .prefixPeriod): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.comma, .comma): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.colon, .colon): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.semicolon, .semicolon): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.equal, .equal): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.atSign, .atSign): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.pound, .pound): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.prefixAmpersand, .prefixAmpersand): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.arrow, .arrow): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.backtick, .backtick): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.backslash, .backslash): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.exclamationMark, .exclamationMark): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.postfixQuestionMark, .postfixQuestionMark): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.infixQuestionMark, .infixQuestionMark): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.stringQuote, .stringQuote): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.multilineStringQuote, .multilineStringQuote): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.poundKeyPathKeyword, .poundKeyPathKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.poundLineKeyword, .poundLineKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.poundSelectorKeyword, .poundSelectorKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.poundFileKeyword, .poundFileKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.poundColumnKeyword, .poundColumnKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.poundFunctionKeyword, .poundFunctionKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.poundDsohandleKeyword, .poundDsohandleKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.poundAssertKeyword, .poundAssertKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.poundSourceLocationKeyword, .poundSourceLocationKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.poundWarningKeyword, .poundWarningKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.poundErrorKeyword, .poundErrorKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.poundIfKeyword, .poundIfKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.poundElseKeyword, .poundElseKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.poundElseifKeyword, .poundElseifKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.poundEndifKeyword, .poundEndifKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.poundAvailableKeyword, .poundAvailableKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.poundFileLiteralKeyword, .poundFileLiteralKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.poundImageLiteralKeyword, .poundImageLiteralKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.poundColorLiteralKeyword, .poundColorLiteralKeyword): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 117)
    case (.integerLiteral(let lhsText), .integerLiteral(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 117)
    case (.floatingLiteral(let lhsText), .floatingLiteral(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 117)
    case (.stringLiteral(let lhsText), .stringLiteral(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 117)
    case (.unknown(let lhsText), .unknown(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 117)
    case (.identifier(let lhsText), .identifier(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 117)
    case (.unspacedBinaryOperator(let lhsText), .unspacedBinaryOperator(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 117)
    case (.spacedBinaryOperator(let lhsText), .spacedBinaryOperator(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 117)
    case (.postfixOperator(let lhsText), .postfixOperator(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 117)
    case (.prefixOperator(let lhsText), .prefixOperator(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 117)
    case (.dollarIdentifier(let lhsText), .dollarIdentifier(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 117)
    case (.contextualKeyword(let lhsText), .contextualKeyword(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 117)
    case (.stringSegment(let lhsText), .stringSegment(let rhsText)):
      return lhsText == rhsText
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.stringInterpolationAnchor, .stringInterpolationAnchor): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 115)
    case (.yield, .yield): return true
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 121)
    default: return false
    }
  }
}

extension TokenKind: ByteTreeObjectDecodable {
  static func read(from reader: UnsafeMutablePointer<ByteTreeObjectReader>, 
                   numFields: Int, 
                   userInfo: UnsafePointer<[ByteTreeUserInfoKey: Any]>
  ) throws -> TokenKind {
    // Explicitly spell out all TokenKinds to keep the serialized value stable
    // even if its members get reordered or members get removed
    let kind = try reader.pointee.readField(UInt8.self, index: 0)
    switch kind {
    case 0: return .eof
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 1:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .associatedtypeKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 2:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .classKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 3:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .deinitKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 4:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .enumKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 5:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .extensionKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 6:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .funcKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 7:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .importKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 8:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .initKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 9:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .inoutKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 10:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .letKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 11:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .operatorKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 12:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .precedencegroupKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 13:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .protocolKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 14:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .structKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 15:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .subscriptKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 16:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .typealiasKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 17:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .varKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 18:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .fileprivateKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 19:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .internalKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 20:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .privateKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 21:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .publicKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 22:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .staticKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 23:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .deferKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 24:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .ifKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 25:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .guardKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 26:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .doKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 27:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .repeatKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 28:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .elseKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 29:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .forKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 30:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .inKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 31:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .whileKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 32:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .returnKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 33:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .breakKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 34:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .continueKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 35:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .fallthroughKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 36:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .switchKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 37:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .caseKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 38:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .defaultKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 39:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .whereKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 40:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .catchKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 50:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .throwKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 41:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .asKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 42:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .anyKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 43:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .falseKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 44:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .isKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 45:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .nilKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 46:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .rethrowsKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 47:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .superKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 48:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .selfKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 49:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .capitalSelfKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 51:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .trueKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 52:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .tryKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 53:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .throwsKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 54:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .__file__Keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 55:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .__line__Keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 56:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .__column__Keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 57:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .__function__Keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 58:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .__dso_handle__Keyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 59:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .wildcardKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 88:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .leftParen
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 89:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .rightParen
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 90:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .leftBrace
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 91:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .rightBrace
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 92:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .leftSquareBracket
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 93:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .rightSquareBracket
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 94:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .leftAngle
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 95:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .rightAngle
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 85:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .period
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 87:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .prefixPeriod
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 84:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .comma
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 82:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .colon
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 83:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .semicolon
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 86:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .equal
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 80:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .atSign
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 81:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .pound
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 96:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .prefixAmpersand
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 78:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .arrow
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 79:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .backtick
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 100:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .backslash
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 99:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .exclamationMark
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 97:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .postfixQuestionMark
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 98:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .infixQuestionMark
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 102:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .stringQuote
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 103:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .multilineStringQuote
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 74:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .poundKeyPathKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 69:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .poundLineKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 73:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .poundSelectorKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 68:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .poundFileKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 70:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .poundColumnKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 72:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .poundFunctionKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 71:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .poundDsohandleKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 117:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .poundAssertKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 65:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .poundSourceLocationKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 66:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .poundWarningKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 67:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .poundErrorKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 64:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .poundIfKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 62:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .poundElseKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 63:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .poundElseifKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 61:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .poundEndifKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 60:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .poundAvailableKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 76:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .poundFileLiteralKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 77:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .poundImageLiteralKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 75:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .poundColorLiteralKeyword
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 111:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 141)
      let text = try reader.pointee.readField(String.self, index: 1)
      return .integerLiteral(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 112:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 141)
      let text = try reader.pointee.readField(String.self, index: 1)
      return .floatingLiteral(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 113:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 141)
      let text = try reader.pointee.readField(String.self, index: 1)
      return .stringLiteral(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 115:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 141)
      let text = try reader.pointee.readField(String.self, index: 1)
      return .unknown(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 105:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 141)
      let text = try reader.pointee.readField(String.self, index: 1)
      return .identifier(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 107:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 141)
      let text = try reader.pointee.readField(String.self, index: 1)
      return .unspacedBinaryOperator(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 108:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 141)
      let text = try reader.pointee.readField(String.self, index: 1)
      return .spacedBinaryOperator(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 110:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 141)
      let text = try reader.pointee.readField(String.self, index: 1)
      return .postfixOperator(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 109:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 141)
      let text = try reader.pointee.readField(String.self, index: 1)
      return .prefixOperator(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 106:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 141)
      let text = try reader.pointee.readField(String.self, index: 1)
      return .dollarIdentifier(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 114:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 141)
      let text = try reader.pointee.readField(String.self, index: 1)
      return .contextualKeyword(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 104:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 141)
      let text = try reader.pointee.readField(String.self, index: 1)
      return .stringSegment(text)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 101:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .stringInterpolationAnchor
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 137)
    case 116:
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 139)
      return .yield
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/TokenKind.swift.gyb", line: 145)
    default:
      if numFields > 1 {
        // Default to an unknown token with the passed text if we don't know 
        // its kind.
        let text = try reader.pointee.readField(String.self, index: 1)
        return .unknown(text)
      } else {
        // If we were not passed the token's text, we cannot recover since we 
        // would lose roundtripness.
        throw ByteTreeDecodingError.invalidEnumRawValue(type: "\(self)", 
                                                        value: Int(kind))
      }
    }
  }
}
