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

/// Represents the specification for a Token in the TokenSyntax file.
public class Token {
  public let name: String
  public let kind: String
  public let serializationCode: Int
  public let unprefixedKind: String
  public let text: String?
  public let classification: String
  public let isKeyword: Bool
  public let requiresLeadingSpace: Bool
  public let requiresTrailingSpace: Bool

  public var swiftKind: String {
    let name = self.name

    if isKeyword {
      return name + "Keyword"
    } else {
      return name
    }
  }

  public init(name: String, kind: String, serializationCode: Int, unprefixedKind: String? = nil, text: String? = nil, classification: String = "None", isKeyword: Bool = false, requiresLeadingSpace: Bool = false, requiresTrailingSpace: Bool = false) {
    self.name = name
    self.kind = kind
    self.serializationCode = serializationCode
    if let unprefixedKind = unprefixedKind {
      self.unprefixedKind = unprefixedKind
    } else {
      self.unprefixedKind = kind
    }
    self.text = text
    self.classification = classification
    self.isKeyword = isKeyword
    self.requiresLeadingSpace = requiresLeadingSpace
    self.requiresTrailingSpace = requiresTrailingSpace
  }
}

/// Represents a keyword token.
public class Keyword: Token {
  public init(name: String, serializationCode: Int, text: String, classification: String = "Keyword") {
    super.init(name: name, kind: "kw_\(text)", serializationCode: serializationCode, unprefixedKind: text, text: text, classification: classification, isKeyword: true, requiresTrailingSpace: true)
  }
}

public class SwiftKeyword: Keyword { }

public class DeclKeyword: SwiftKeyword { }

public class StmtKeyword: SwiftKeyword { }

public class ExprKeyword: SwiftKeyword { }

public class PatternKeyword: SwiftKeyword { }

public class SilKeyword: Keyword { }

public class PoundKeyword: Token {
  public init(name: String, kind: String, serializationCode: Int, text: String, classification: String = "Keyword") {
    super.init(name: name, kind: "pound_\(kind)", serializationCode: serializationCode, unprefixedKind: kind, text: text, classification: classification, isKeyword: true, requiresTrailingSpace: true)
  }
}

public class PoundObjectLiteral: PoundKeyword {
  public let description: String
  public let `protocol`: String

  public init(name: String, kind: String, serializationCode: Int, text: String, classification: String = "ObjectLiteral", description: String, `protocol`: String) {
    self.description = `description`
    self.`protocol` = `protocol`
    super.init(name: name, kind: kind, serializationCode: serializationCode, text: text, classification: classification)
  }
}

public class PoundConfig: PoundKeyword { }

public class PoundDirectiveKeyword: PoundKeyword {
  public override init(name: String, kind: String, serializationCode: Int, text: String, classification: String = "PoundDirectiveKeyword") {
    super.init(name: name, kind: kind, serializationCode: serializationCode, text: text, classification: classification)
  }
}

public class PoundConditionalDirectiveKeyword: PoundDirectiveKeyword {
  public override init(name: String, kind: String, serializationCode: Int, text: String, classification: String = "PoundDirectiveKeyword") {
    super.init(name: name, kind: kind, serializationCode: serializationCode, text: text, classification: classification)
  }
}

public class Punctuator: Token { }

public class Literal: Token { }

public class Misc: Token { }

let SYNTAX_TOKENS: [Token] = [
    DeclKeyword(name: "Associatedtype", serializationCode: 1, text: "associatedtype"),
    DeclKeyword(name: "Class", serializationCode: 2, text: "class"),
    DeclKeyword(name: "Deinit", serializationCode: 3, text: "deinit"),
    DeclKeyword(name: "Enum", serializationCode: 4, text: "enum"),
    DeclKeyword(name: "Extension", serializationCode: 5, text: "extension"),
    DeclKeyword(name: "Func", serializationCode: 6, text: "func"),
    DeclKeyword(name: "Import", serializationCode: 7, text: "import"),
    DeclKeyword(name: "Init", serializationCode: 8, text: "init"),
    DeclKeyword(name: "Inout", serializationCode: 9, text: "inout"),
    DeclKeyword(name: "Let", serializationCode: 10, text: "let"),
    DeclKeyword(name: "Operator", serializationCode: 11, text: "operator"),
    DeclKeyword(name: "Precedencegroup", serializationCode: 12, text: "precedencegroup"),
    DeclKeyword(name: "Protocol", serializationCode: 13, text: "protocol"),
    DeclKeyword(name: "Struct", serializationCode: 14, text: "struct"),
    DeclKeyword(name: "Subscript", serializationCode: 15, text: "subscript"),
    DeclKeyword(name: "Typealias", serializationCode: 16, text: "typealias"),
    DeclKeyword(name: "Var", serializationCode: 17, text: "var"),
    DeclKeyword(name: "Fileprivate", serializationCode: 18, text: "fileprivate"),
    DeclKeyword(name: "Internal", serializationCode: 19, text: "internal"),
    DeclKeyword(name: "Private", serializationCode: 20, text: "private"),
    DeclKeyword(name: "Public", serializationCode: 21, text: "public"),
    DeclKeyword(name: "Static", serializationCode: 22, text: "static"),
    StmtKeyword(name: "Defer", serializationCode: 23, text: "defer"),
    StmtKeyword(name: "If", serializationCode: 24, text: "if"),
    StmtKeyword(name: "Guard", serializationCode: 25, text: "guard"),
    StmtKeyword(name: "Do", serializationCode: 26, text: "do"),
    StmtKeyword(name: "Repeat", serializationCode: 27, text: "repeat"),
    StmtKeyword(name: "Else", serializationCode: 28, text: "else"),
    StmtKeyword(name: "For", serializationCode: 29, text: "for"),
    StmtKeyword(name: "In", serializationCode: 30, text: "in"),
    StmtKeyword(name: "While", serializationCode: 31, text: "while"),
    StmtKeyword(name: "Return", serializationCode: 32, text: "return"),
    StmtKeyword(name: "Break", serializationCode: 33, text: "break"),
    StmtKeyword(name: "Continue", serializationCode: 34, text: "continue"),
    StmtKeyword(name: "Fallthrough", serializationCode: 35, text: "fallthrough"),
    StmtKeyword(name: "Switch", serializationCode: 36, text: "switch"),
    StmtKeyword(name: "Case", serializationCode: 37, text: "case"),
    StmtKeyword(name: "Default", serializationCode: 38, text: "default"),
    StmtKeyword(name: "Where", serializationCode: 39, text: "where"),
    StmtKeyword(name: "Catch", serializationCode: 40, text: "catch"),
    StmtKeyword(name: "Throw", serializationCode: 50, text: "throw"),
    ExprKeyword(name: "As", serializationCode: 41, text: "as"),
    ExprKeyword(name: "Any", serializationCode: 42, text: "Any"),
    ExprKeyword(name: "False", serializationCode: 43, text: "false"),
    ExprKeyword(name: "Is", serializationCode: 44, text: "is"),
    ExprKeyword(name: "Nil", serializationCode: 45, text: "nil"),
    ExprKeyword(name: "Rethrows", serializationCode: 46, text: "rethrows"),
    ExprKeyword(name: "Super", serializationCode: 47, text: "super"),
    ExprKeyword(name: "Self", serializationCode: 48, text: "self"),
    ExprKeyword(name: "CapitalSelf", serializationCode: 49, text: "Self"),
    ExprKeyword(name: "True", serializationCode: 51, text: "true"),
    ExprKeyword(name: "Try", serializationCode: 52, text: "try"),
    ExprKeyword(name: "Throws", serializationCode: 53, text: "throws"),
    Keyword(name: "__FILE__", serializationCode: 54, text: "__FILE__"),
    Keyword(name: "__LINE__", serializationCode: 55, text: "__LINE__"),
    Keyword(name: "__COLUMN__", serializationCode: 56, text: "__COLUMN__"),
    Keyword(name: "__FUNCTION__", serializationCode: 57, text: "__FUNCTION__"),
    Keyword(name: "__DSO_HANDLE__", serializationCode: 58, text: "__DSO_HANDLE__"),
    PatternKeyword(name: "Wildcard", serializationCode: 59, text: "_"),
    Punctuator(name: "LeftParen", kind: "l_paren", serializationCode: 88, text: "(", requiresLeadingSpace: false, requiresTrailingSpace: false),
    Punctuator(name: "RightParen", kind: "r_paren", serializationCode: 89, text: ")", requiresLeadingSpace: false, requiresTrailingSpace: false),
    Punctuator(name: "LeftBrace", kind: "l_brace", serializationCode: 90, text: "{", requiresLeadingSpace: false, requiresTrailingSpace: false),
    Punctuator(name: "RightBrace", kind: "r_brace", serializationCode: 91, text: "}", requiresLeadingSpace: false, requiresTrailingSpace: false),
    Punctuator(name: "LeftSquareBracket", kind: "l_square", serializationCode: 92, text: "[", requiresLeadingSpace: false, requiresTrailingSpace: false),
    Punctuator(name: "RightSquareBracket", kind: "r_square", serializationCode: 93, text: "]", requiresLeadingSpace: false, requiresTrailingSpace: false),
    Punctuator(name: "LeftAngle", kind: "l_angle", serializationCode: 94, text: "<", requiresLeadingSpace: true, requiresTrailingSpace: true),
    Punctuator(name: "RightAngle", kind: "r_angle", serializationCode: 95, text: ">", requiresLeadingSpace: true, requiresTrailingSpace: true),
    Punctuator(name: "Period", kind: "period", serializationCode: 85, text: ".", requiresLeadingSpace: false, requiresTrailingSpace: false),
    Punctuator(name: "PrefixPeriod", kind: "period_prefix", serializationCode: 87, text: ".", requiresLeadingSpace: false, requiresTrailingSpace: false),
    Punctuator(name: "Comma", kind: "comma", serializationCode: 84, text: ",", requiresLeadingSpace: false, requiresTrailingSpace: true),
    Punctuator(name: "Ellipsis", kind: "ellipsis", serializationCode: 118, text: "...", requiresLeadingSpace: false, requiresTrailingSpace: false),
    Punctuator(name: "Colon", kind: "colon", serializationCode: 82, text: ":", requiresLeadingSpace: false, requiresTrailingSpace: true),
    Punctuator(name: "Semicolon", kind: "semi", serializationCode: 83, text: ";", requiresLeadingSpace: false, requiresTrailingSpace: false),
    Punctuator(name: "Equal", kind: "equal", serializationCode: 86, text: "=", requiresLeadingSpace: true, requiresTrailingSpace: true),
    Punctuator(name: "AtSign", kind: "at_sign", serializationCode: 80, text: "@", requiresLeadingSpace: false, requiresTrailingSpace: false),
    Punctuator(name: "Pound", kind: "pound", serializationCode: 81, text: "#", requiresLeadingSpace: false, requiresTrailingSpace: false),
    Punctuator(name: "PrefixAmpersand", kind: "amp_prefix", serializationCode: 96, text: "&", requiresLeadingSpace: true, requiresTrailingSpace: true),
    Punctuator(name: "Arrow", kind: "arrow", serializationCode: 78, text: "->", requiresLeadingSpace: false, requiresTrailingSpace: true),
    Punctuator(name: "Backtick", kind: "backtick", serializationCode: 79, text: "`", requiresLeadingSpace: false, requiresTrailingSpace: false),
    Punctuator(name: "Backslash", kind: "backslash", serializationCode: 100, text: "\\", requiresLeadingSpace: false, requiresTrailingSpace: false),
    Punctuator(name: "ExclamationMark", kind: "exclaim_postfix", serializationCode: 99, text: "!", requiresLeadingSpace: false, requiresTrailingSpace: false),
    Punctuator(name: "PostfixQuestionMark", kind: "question_postfix", serializationCode: 97, text: "?", requiresLeadingSpace: false, requiresTrailingSpace: false),
    Punctuator(name: "InfixQuestionMark", kind: "question_infix", serializationCode: 98, text: "?", requiresLeadingSpace: false, requiresTrailingSpace: false),
    Punctuator(name: "StringQuote", kind: "string_quote", serializationCode: 102, text: "\"", requiresLeadingSpace: false, requiresTrailingSpace: false),
    Punctuator(name: "SingleQuote", kind: "single_quote", serializationCode: 120, text: "\'", requiresLeadingSpace: false, requiresTrailingSpace: false),
    Punctuator(name: "MultilineStringQuote", kind: "multiline_string_quote", serializationCode: 103, text: "\"\"\"", requiresLeadingSpace: false, requiresTrailingSpace: false),
    PoundKeyword(name: "PoundKeyPath", kind: "pound_keyPath", serializationCode: 74, text: "#keyPath"),
    PoundKeyword(name: "PoundLine", kind: "pound_line", serializationCode: 69, text: "#line"),
    PoundKeyword(name: "PoundSelector", kind: "pound_selector", serializationCode: 73, text: "#selector"),
    PoundKeyword(name: "PoundFile", kind: "pound_file", serializationCode: 68, text: "#file"),
    PoundKeyword(name: "PoundFileID", kind: "pound_fileID", serializationCode: 122, text: "#fileID"),
    PoundKeyword(name: "PoundFilePath", kind: "pound_filePath", serializationCode: 121, text: "#filePath"),
    PoundKeyword(name: "PoundColumn", kind: "pound_column", serializationCode: 70, text: "#column"),
    PoundKeyword(name: "PoundFunction", kind: "pound_function", serializationCode: 72, text: "#function"),
    PoundKeyword(name: "PoundDsohandle", kind: "pound_dsohandle", serializationCode: 71, text: "#dsohandle"),
    PoundKeyword(name: "PoundAssert", kind: "pound_assert", serializationCode: 117, text: "#assert"),
    PoundDirectiveKeyword(name: "PoundSourceLocation", kind: "pound_sourceLocation", serializationCode: 65, text: "#sourceLocation"),
    PoundDirectiveKeyword(name: "PoundWarning", kind: "pound_warning", serializationCode: 66, text: "#warning"),
    PoundDirectiveKeyword(name: "PoundError", kind: "pound_error", serializationCode: 67, text: "#error"),
    PoundConditionalDirectiveKeyword(name: "PoundIf", kind: "pound_if", serializationCode: 64, text: "#if"),
    PoundConditionalDirectiveKeyword(name: "PoundElse", kind: "pound_else", serializationCode: 62, text: "#else"),
    PoundConditionalDirectiveKeyword(name: "PoundElseif", kind: "pound_elseif", serializationCode: 63, text: "#elseif"),
    PoundConditionalDirectiveKeyword(name: "PoundEndif", kind: "pound_endif", serializationCode: 61, text: "#endif"),
    PoundConfig(name: "PoundAvailable", kind: "pound_available", serializationCode: 60, text: "#available"),
    PoundConfig(name: "PoundUnavailable", kind: "pound_unavailable", serializationCode: 123, text: "#unavailable"),
    PoundObjectLiteral(name: "PoundFileLiteral", kind: "pound_fileLiteral", serializationCode: 76, text: "#fileLiteral", description: "file reference", protocol: "ExpressibleByFileReferenceLiteral"),
    PoundObjectLiteral(name: "PoundImageLiteral", kind: "pound_imageLiteral", serializationCode: 77, text: "#imageLiteral", description: "image", protocol: "ExpressibleByImageLiteral"),
    PoundObjectLiteral(name: "PoundColorLiteral", kind: "pound_colorLiteral", serializationCode: 75, text: "#colorLiteral", description: "color", protocol: "ExpressibleByColorLiteral"),
    Literal(name: "IntegerLiteral", kind: "integer_literal", serializationCode: 111),
    Literal(name: "FloatingLiteral", kind: "floating_literal", serializationCode: 112),
    Literal(name: "StringLiteral", kind: "string_literal", serializationCode: 113),
    Literal(name: "RegexLiteral", kind: "regex_literal", serializationCode: 124),
    Misc(name: "Unknown", kind: "unknown", serializationCode: 115, requiresLeadingSpace: false, requiresTrailingSpace: false),
    Misc(name: "Identifier", kind: "identifier", serializationCode: 105, requiresLeadingSpace: false, requiresTrailingSpace: false),
    Misc(name: "UnspacedBinaryOperator", kind: "oper_binary_unspaced", serializationCode: 107, requiresLeadingSpace: false, requiresTrailingSpace: false),
    Misc(name: "SpacedBinaryOperator", kind: "oper_binary_spaced", serializationCode: 108, requiresLeadingSpace: true, requiresTrailingSpace: true),
    Misc(name: "PostfixOperator", kind: "oper_postfix", serializationCode: 110, requiresLeadingSpace: false, requiresTrailingSpace: false),
    Misc(name: "PrefixOperator", kind: "oper_prefix", serializationCode: 109, requiresLeadingSpace: false, requiresTrailingSpace: false),
    Misc(name: "DollarIdentifier", kind: "dollarident", serializationCode: 106, requiresLeadingSpace: false, requiresTrailingSpace: false),
    Misc(name: "ContextualKeyword", kind: "contextual_keyword", serializationCode: 114, requiresLeadingSpace: false, requiresTrailingSpace: false),
    Misc(name: "RawStringDelimiter", kind: "raw_string_delimiter", serializationCode: 119, requiresLeadingSpace: false, requiresTrailingSpace: false),
    Misc(name: "StringSegment", kind: "string_segment", serializationCode: 104, requiresLeadingSpace: false, requiresTrailingSpace: false),
    Misc(name: "StringInterpolationAnchor", kind: "string_interpolation_anchor", serializationCode: 101, text: ")", requiresLeadingSpace: false, requiresTrailingSpace: false),
    Misc(name: "Yield", kind: "kw_yield", serializationCode: 116, text: "yield", requiresLeadingSpace: false, requiresTrailingSpace: false),
]
