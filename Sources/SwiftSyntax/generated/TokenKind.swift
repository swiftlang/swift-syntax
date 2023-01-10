

/// Enumerates the kinds of tokens in the Swift language.
@frozen // FIXME: Not actually stable, works around a miscompile
public enum TokenKind: Hashable {
  case eof
  
  case associatedtypeKeyword
  
  case classKeyword
  
  case deinitKeyword
  
  case enumKeyword
  
  case extensionKeyword
  
  case funcKeyword
  
  case importKeyword
  
  case initKeyword
  
  case inoutKeyword
  
  case letKeyword
  
  case operatorKeyword
  
  case precedencegroupKeyword
  
  case protocolKeyword
  
  case structKeyword
  
  case subscriptKeyword
  
  case typealiasKeyword
  
  case varKeyword
  
  case fileprivateKeyword
  
  case internalKeyword
  
  case privateKeyword
  
  case publicKeyword
  
  case staticKeyword
  
  case deferKeyword
  
  case ifKeyword
  
  case guardKeyword
  
  case doKeyword
  
  case repeatKeyword
  
  case elseKeyword
  
  case forKeyword
  
  case inKeyword
  
  case whileKeyword
  
  case returnKeyword
  
  case breakKeyword
  
  case continueKeyword
  
  case fallthroughKeyword
  
  case switchKeyword
  
  case caseKeyword
  
  case defaultKeyword
  
  case whereKeyword
  
  case catchKeyword
  
  case throwKeyword
  
  case asKeyword
  
  case anyKeyword
  
  case falseKeyword
  
  case isKeyword
  
  case nilKeyword
  
  case rethrowsKeyword
  
  case superKeyword
  
  case selfKeyword
  
  case capitalSelfKeyword
  
  case trueKeyword
  
  case tryKeyword
  
  case throwsKeyword
  
  case wildcardKeyword
  
  case leftParen
  
  case rightParen
  
  case leftBrace
  
  case rightBrace
  
  case leftSquareBracket
  
  case rightSquareBracket
  
  case leftAngle
  
  case rightAngle
  
  case period
  
  case comma
  
  case ellipsis
  
  case colon
  
  case semicolon
  
  case equal
  
  case atSign
  
  case pound
  
  case prefixAmpersand
  
  case arrow
  
  case backtick
  
  case backslash
  
  case exclamationMark
  
  case postfixQuestionMark
  
  case infixQuestionMark
  
  case stringQuote
  
  case singleQuote
  
  case multilineStringQuote
  
  case poundKeyPathKeyword
  
  case poundLineKeyword
  
  case poundSelectorKeyword
  
  case poundFileKeyword
  
  case poundFileIDKeyword
  
  case poundFilePathKeyword
  
  case poundColumnKeyword
  
  case poundFunctionKeyword
  
  case poundDsohandleKeyword
  
  case poundAssertKeyword
  
  case poundSourceLocationKeyword
  
  case poundWarningKeyword
  
  case poundErrorKeyword
  
  case poundIfKeyword
  
  case poundElseKeyword
  
  case poundElseifKeyword
  
  case poundEndifKeyword
  
  case poundAvailableKeyword
  
  case poundUnavailableKeyword
  
  case poundFileLiteralKeyword
  
  case poundImageLiteralKeyword
  
  case poundColorLiteralKeyword
  
  case poundHasSymbolKeyword
  
  case integerLiteral(String)
  
  case floatingLiteral(String)
  
  case stringLiteral(String)
  
  case regexLiteral(String)
  
  case unknown(String)
  
  case identifier(String)
  
  case binaryOperator(String)
  
  case postfixOperator(String)
  
  case prefixOperator(String)
  
  case dollarIdentifier(String)
  
  case contextualKeyword(Keyword)
  
  case rawStringDelimiter(String)
  
  case stringSegment(String)
  
  case yield
  
  /// Initializes a keyword token kind from its string representation. If the
  /// given string is not a keyword, this function returns `nil`.
  public init?(keyword: String) {
    switch keyword {
    case "associatedtype": 
      self = .associatedtypeKeyword
    case "class": 
      self = .classKeyword
    case "deinit": 
      self = .deinitKeyword
    case "enum": 
      self = .enumKeyword
    case "extension": 
      self = .extensionKeyword
    case "func": 
      self = .funcKeyword
    case "import": 
      self = .importKeyword
    case "init": 
      self = .initKeyword
    case "inout": 
      self = .inoutKeyword
    case "let": 
      self = .letKeyword
    case "operator": 
      self = .operatorKeyword
    case "precedencegroup": 
      self = .precedencegroupKeyword
    case "protocol": 
      self = .protocolKeyword
    case "struct": 
      self = .structKeyword
    case "subscript": 
      self = .subscriptKeyword
    case "typealias": 
      self = .typealiasKeyword
    case "var": 
      self = .varKeyword
    case "fileprivate": 
      self = .fileprivateKeyword
    case "internal": 
      self = .internalKeyword
    case "private": 
      self = .privateKeyword
    case "public": 
      self = .publicKeyword
    case "static": 
      self = .staticKeyword
    case "defer": 
      self = .deferKeyword
    case "if": 
      self = .ifKeyword
    case "guard": 
      self = .guardKeyword
    case "do": 
      self = .doKeyword
    case "repeat": 
      self = .repeatKeyword
    case "else": 
      self = .elseKeyword
    case "for": 
      self = .forKeyword
    case "in": 
      self = .inKeyword
    case "while": 
      self = .whileKeyword
    case "return": 
      self = .returnKeyword
    case "break": 
      self = .breakKeyword
    case "continue": 
      self = .continueKeyword
    case "fallthrough": 
      self = .fallthroughKeyword
    case "switch": 
      self = .switchKeyword
    case "case": 
      self = .caseKeyword
    case "default": 
      self = .defaultKeyword
    case "where": 
      self = .whereKeyword
    case "catch": 
      self = .catchKeyword
    case "throw": 
      self = .throwKeyword
    case "as": 
      self = .asKeyword
    case "Any": 
      self = .anyKeyword
    case "false": 
      self = .falseKeyword
    case "is": 
      self = .isKeyword
    case "nil": 
      self = .nilKeyword
    case "rethrows": 
      self = .rethrowsKeyword
    case "super": 
      self = .superKeyword
    case "self": 
      self = .selfKeyword
    case "Self": 
      self = .capitalSelfKeyword
    case "true": 
      self = .trueKeyword
    case "try": 
      self = .tryKeyword
    case "throws": 
      self = .throwsKeyword
    case "_": 
      self = .wildcardKeyword
    case "#keyPath": 
      self = .poundKeyPathKeyword
    case "#line": 
      self = .poundLineKeyword
    case "#selector": 
      self = .poundSelectorKeyword
    case "#file": 
      self = .poundFileKeyword
    case "#fileID": 
      self = .poundFileIDKeyword
    case "#filePath": 
      self = .poundFilePathKeyword
    case "#column": 
      self = .poundColumnKeyword
    case "#function": 
      self = .poundFunctionKeyword
    case "#dsohandle": 
      self = .poundDsohandleKeyword
    case "#assert": 
      self = .poundAssertKeyword
    case "#sourceLocation": 
      self = .poundSourceLocationKeyword
    case "#warning": 
      self = .poundWarningKeyword
    case "#error": 
      self = .poundErrorKeyword
    case "#if": 
      self = .poundIfKeyword
    case "#else": 
      self = .poundElseKeyword
    case "#elseif": 
      self = .poundElseifKeyword
    case "#endif": 
      self = .poundEndifKeyword
    case "#available": 
      self = .poundAvailableKeyword
    case "#unavailable": 
      self = .poundUnavailableKeyword
    case "#fileLiteral": 
      self = .poundFileLiteralKeyword
    case "#imageLiteral": 
      self = .poundImageLiteralKeyword
    case "#colorLiteral": 
      self = .poundColorLiteralKeyword
    case "#_hasSymbol": 
      self = .poundHasSymbolKeyword
    default: 
      return nil
    }
  }
  
  /// The textual representation of this token kind.
  @_spi(Testing) 
  public var text: String {
    switch self {
    case .associatedtypeKeyword: 
      return #"associatedtype"#
    case .classKeyword: 
      return #"class"#
    case .deinitKeyword: 
      return #"deinit"#
    case .enumKeyword: 
      return #"enum"#
    case .extensionKeyword: 
      return #"extension"#
    case .funcKeyword: 
      return #"func"#
    case .importKeyword: 
      return #"import"#
    case .initKeyword: 
      return #"init"#
    case .inoutKeyword: 
      return #"inout"#
    case .letKeyword: 
      return #"let"#
    case .operatorKeyword: 
      return #"operator"#
    case .precedencegroupKeyword: 
      return #"precedencegroup"#
    case .protocolKeyword: 
      return #"protocol"#
    case .structKeyword: 
      return #"struct"#
    case .subscriptKeyword: 
      return #"subscript"#
    case .typealiasKeyword: 
      return #"typealias"#
    case .varKeyword: 
      return #"var"#
    case .fileprivateKeyword: 
      return #"fileprivate"#
    case .internalKeyword: 
      return #"internal"#
    case .privateKeyword: 
      return #"private"#
    case .publicKeyword: 
      return #"public"#
    case .staticKeyword: 
      return #"static"#
    case .deferKeyword: 
      return #"defer"#
    case .ifKeyword: 
      return #"if"#
    case .guardKeyword: 
      return #"guard"#
    case .doKeyword: 
      return #"do"#
    case .repeatKeyword: 
      return #"repeat"#
    case .elseKeyword: 
      return #"else"#
    case .forKeyword: 
      return #"for"#
    case .inKeyword: 
      return #"in"#
    case .whileKeyword: 
      return #"while"#
    case .returnKeyword: 
      return #"return"#
    case .breakKeyword: 
      return #"break"#
    case .continueKeyword: 
      return #"continue"#
    case .fallthroughKeyword: 
      return #"fallthrough"#
    case .switchKeyword: 
      return #"switch"#
    case .caseKeyword: 
      return #"case"#
    case .defaultKeyword: 
      return #"default"#
    case .whereKeyword: 
      return #"where"#
    case .catchKeyword: 
      return #"catch"#
    case .throwKeyword: 
      return #"throw"#
    case .asKeyword: 
      return #"as"#
    case .anyKeyword: 
      return #"Any"#
    case .falseKeyword: 
      return #"false"#
    case .isKeyword: 
      return #"is"#
    case .nilKeyword: 
      return #"nil"#
    case .rethrowsKeyword: 
      return #"rethrows"#
    case .superKeyword: 
      return #"super"#
    case .selfKeyword: 
      return #"self"#
    case .capitalSelfKeyword: 
      return #"Self"#
    case .trueKeyword: 
      return #"true"#
    case .tryKeyword: 
      return #"try"#
    case .throwsKeyword: 
      return #"throws"#
    case .wildcardKeyword: 
      return #"_"#
    case .leftParen: 
      return #"("#
    case .rightParen: 
      return #")"#
    case .leftBrace: 
      return #"{"#
    case .rightBrace: 
      return #"}"#
    case .leftSquareBracket: 
      return #"["#
    case .rightSquareBracket: 
      return #"]"#
    case .leftAngle: 
      return #"<"#
    case .rightAngle: 
      return #">"#
    case .period: 
      return #"."#
    case .comma: 
      return #","#
    case .ellipsis: 
      return #"..."#
    case .colon: 
      return #":"#
    case .semicolon: 
      return #";"#
    case .equal: 
      return #"="#
    case .atSign: 
      return #"@"#
    case .pound: 
      return #"#"#
    case .prefixAmpersand: 
      return #"&"#
    case .arrow: 
      return #"->"#
    case .backtick: 
      return #"`"#
    case .backslash: 
      return #"\"#
    case .exclamationMark: 
      return #"!"#
    case .postfixQuestionMark: 
      return #"?"#
    case .infixQuestionMark: 
      return #"?"#
    case .stringQuote: 
      return #"""#
    case .singleQuote: 
      return #"'"#
    case .multilineStringQuote: 
      return #"""""#
    case .poundKeyPathKeyword: 
      return #"#keyPath"#
    case .poundLineKeyword: 
      return #"#line"#
    case .poundSelectorKeyword: 
      return #"#selector"#
    case .poundFileKeyword: 
      return #"#file"#
    case .poundFileIDKeyword: 
      return #"#fileID"#
    case .poundFilePathKeyword: 
      return #"#filePath"#
    case .poundColumnKeyword: 
      return #"#column"#
    case .poundFunctionKeyword: 
      return #"#function"#
    case .poundDsohandleKeyword: 
      return #"#dsohandle"#
    case .poundAssertKeyword: 
      return #"#assert"#
    case .poundSourceLocationKeyword: 
      return #"#sourceLocation"#
    case .poundWarningKeyword: 
      return #"#warning"#
    case .poundErrorKeyword: 
      return #"#error"#
    case .poundIfKeyword: 
      return #"#if"#
    case .poundElseKeyword: 
      return #"#else"#
    case .poundElseifKeyword: 
      return #"#elseif"#
    case .poundEndifKeyword: 
      return #"#endif"#
    case .poundAvailableKeyword: 
      return #"#available"#
    case .poundUnavailableKeyword: 
      return #"#unavailable"#
    case .poundFileLiteralKeyword: 
      return #"#fileLiteral"#
    case .poundImageLiteralKeyword: 
      return #"#imageLiteral"#
    case .poundColorLiteralKeyword: 
      return #"#colorLiteral"#
    case .poundHasSymbolKeyword: 
      return #"#_hasSymbol"#
    case .integerLiteral(let text): 
      return text
    case .floatingLiteral(let text): 
      return text
    case .stringLiteral(let text): 
      return text
    case .regexLiteral(let text): 
      return text
    case .unknown(let text): 
      return text
    case .identifier(let text): 
      return text
    case .binaryOperator(let text): 
      return text
    case .postfixOperator(let text): 
      return text
    case .prefixOperator(let text): 
      return text
    case .dollarIdentifier(let text): 
      return text
    case .contextualKeyword(let assoc): 
      return String(syntaxText: assoc.defaultText)
    case .rawStringDelimiter(let text): 
      return text
    case .stringSegment(let text): 
      return text
    case .yield: 
      return #"yield"#
    case .eof: 
      return ""
    }
  }
  
  /// If this token kind always has the same syntax text, that syntax text, otherwise `nil`.
  @_spi(RawSyntax) 
  public var defaultText: SyntaxText? {
    switch self {
    case .associatedtypeKeyword: 
      return #"associatedtype"#
    case .classKeyword: 
      return #"class"#
    case .deinitKeyword: 
      return #"deinit"#
    case .enumKeyword: 
      return #"enum"#
    case .extensionKeyword: 
      return #"extension"#
    case .funcKeyword: 
      return #"func"#
    case .importKeyword: 
      return #"import"#
    case .initKeyword: 
      return #"init"#
    case .inoutKeyword: 
      return #"inout"#
    case .letKeyword: 
      return #"let"#
    case .operatorKeyword: 
      return #"operator"#
    case .precedencegroupKeyword: 
      return #"precedencegroup"#
    case .protocolKeyword: 
      return #"protocol"#
    case .structKeyword: 
      return #"struct"#
    case .subscriptKeyword: 
      return #"subscript"#
    case .typealiasKeyword: 
      return #"typealias"#
    case .varKeyword: 
      return #"var"#
    case .fileprivateKeyword: 
      return #"fileprivate"#
    case .internalKeyword: 
      return #"internal"#
    case .privateKeyword: 
      return #"private"#
    case .publicKeyword: 
      return #"public"#
    case .staticKeyword: 
      return #"static"#
    case .deferKeyword: 
      return #"defer"#
    case .ifKeyword: 
      return #"if"#
    case .guardKeyword: 
      return #"guard"#
    case .doKeyword: 
      return #"do"#
    case .repeatKeyword: 
      return #"repeat"#
    case .elseKeyword: 
      return #"else"#
    case .forKeyword: 
      return #"for"#
    case .inKeyword: 
      return #"in"#
    case .whileKeyword: 
      return #"while"#
    case .returnKeyword: 
      return #"return"#
    case .breakKeyword: 
      return #"break"#
    case .continueKeyword: 
      return #"continue"#
    case .fallthroughKeyword: 
      return #"fallthrough"#
    case .switchKeyword: 
      return #"switch"#
    case .caseKeyword: 
      return #"case"#
    case .defaultKeyword: 
      return #"default"#
    case .whereKeyword: 
      return #"where"#
    case .catchKeyword: 
      return #"catch"#
    case .throwKeyword: 
      return #"throw"#
    case .asKeyword: 
      return #"as"#
    case .anyKeyword: 
      return #"Any"#
    case .falseKeyword: 
      return #"false"#
    case .isKeyword: 
      return #"is"#
    case .nilKeyword: 
      return #"nil"#
    case .rethrowsKeyword: 
      return #"rethrows"#
    case .superKeyword: 
      return #"super"#
    case .selfKeyword: 
      return #"self"#
    case .capitalSelfKeyword: 
      return #"Self"#
    case .trueKeyword: 
      return #"true"#
    case .tryKeyword: 
      return #"try"#
    case .throwsKeyword: 
      return #"throws"#
    case .wildcardKeyword: 
      return #"_"#
    case .leftParen: 
      return #"("#
    case .rightParen: 
      return #")"#
    case .leftBrace: 
      return #"{"#
    case .rightBrace: 
      return #"}"#
    case .leftSquareBracket: 
      return #"["#
    case .rightSquareBracket: 
      return #"]"#
    case .leftAngle: 
      return #"<"#
    case .rightAngle: 
      return #">"#
    case .period: 
      return #"."#
    case .comma: 
      return #","#
    case .ellipsis: 
      return #"..."#
    case .colon: 
      return #":"#
    case .semicolon: 
      return #";"#
    case .equal: 
      return #"="#
    case .atSign: 
      return #"@"#
    case .pound: 
      return #"#"#
    case .prefixAmpersand: 
      return #"&"#
    case .arrow: 
      return #"->"#
    case .backtick: 
      return #"`"#
    case .backslash: 
      return #"\"#
    case .exclamationMark: 
      return #"!"#
    case .postfixQuestionMark: 
      return #"?"#
    case .infixQuestionMark: 
      return #"?"#
    case .stringQuote: 
      return #"""#
    case .singleQuote: 
      return #"'"#
    case .multilineStringQuote: 
      return #"""""#
    case .poundKeyPathKeyword: 
      return #"#keyPath"#
    case .poundLineKeyword: 
      return #"#line"#
    case .poundSelectorKeyword: 
      return #"#selector"#
    case .poundFileKeyword: 
      return #"#file"#
    case .poundFileIDKeyword: 
      return #"#fileID"#
    case .poundFilePathKeyword: 
      return #"#filePath"#
    case .poundColumnKeyword: 
      return #"#column"#
    case .poundFunctionKeyword: 
      return #"#function"#
    case .poundDsohandleKeyword: 
      return #"#dsohandle"#
    case .poundAssertKeyword: 
      return #"#assert"#
    case .poundSourceLocationKeyword: 
      return #"#sourceLocation"#
    case .poundWarningKeyword: 
      return #"#warning"#
    case .poundErrorKeyword: 
      return #"#error"#
    case .poundIfKeyword: 
      return #"#if"#
    case .poundElseKeyword: 
      return #"#else"#
    case .poundElseifKeyword: 
      return #"#elseif"#
    case .poundEndifKeyword: 
      return #"#endif"#
    case .poundAvailableKeyword: 
      return #"#available"#
    case .poundUnavailableKeyword: 
      return #"#unavailable"#
    case .poundFileLiteralKeyword: 
      return #"#fileLiteral"#
    case .poundImageLiteralKeyword: 
      return #"#imageLiteral"#
    case .poundColorLiteralKeyword: 
      return #"#colorLiteral"#
    case .poundHasSymbolKeyword: 
      return #"#_hasSymbol"#
    case .contextualKeyword(let assoc): 
      return assoc.defaultText
    case .yield: 
      return #"yield"#
    case .eof: 
      return ""
    default: 
      return ""
    }
  }
  
  /// Returns `true` if the token is a Swift keyword.
  ///
  /// Keywords are reserved unconditionally for use by Swift and may not
  /// appear as identifiers in any position without being escaped. For example,
  /// `class`, `func`, or `import`.
  public var isKeyword: Bool {
    switch self {
    case .eof: 
      return false
    case .associatedtypeKeyword: 
      return true
    case .classKeyword: 
      return true
    case .deinitKeyword: 
      return true
    case .enumKeyword: 
      return true
    case .extensionKeyword: 
      return true
    case .funcKeyword: 
      return true
    case .importKeyword: 
      return true
    case .initKeyword: 
      return true
    case .inoutKeyword: 
      return true
    case .letKeyword: 
      return true
    case .operatorKeyword: 
      return true
    case .precedencegroupKeyword: 
      return true
    case .protocolKeyword: 
      return true
    case .structKeyword: 
      return true
    case .subscriptKeyword: 
      return true
    case .typealiasKeyword: 
      return true
    case .varKeyword: 
      return true
    case .fileprivateKeyword: 
      return true
    case .internalKeyword: 
      return true
    case .privateKeyword: 
      return true
    case .publicKeyword: 
      return true
    case .staticKeyword: 
      return true
    case .deferKeyword: 
      return true
    case .ifKeyword: 
      return true
    case .guardKeyword: 
      return true
    case .doKeyword: 
      return true
    case .repeatKeyword: 
      return true
    case .elseKeyword: 
      return true
    case .forKeyword: 
      return true
    case .inKeyword: 
      return true
    case .whileKeyword: 
      return true
    case .returnKeyword: 
      return true
    case .breakKeyword: 
      return true
    case .continueKeyword: 
      return true
    case .fallthroughKeyword: 
      return true
    case .switchKeyword: 
      return true
    case .caseKeyword: 
      return true
    case .defaultKeyword: 
      return true
    case .whereKeyword: 
      return true
    case .catchKeyword: 
      return true
    case .throwKeyword: 
      return true
    case .asKeyword: 
      return true
    case .anyKeyword: 
      return true
    case .falseKeyword: 
      return true
    case .isKeyword: 
      return true
    case .nilKeyword: 
      return true
    case .rethrowsKeyword: 
      return true
    case .superKeyword: 
      return true
    case .selfKeyword: 
      return true
    case .capitalSelfKeyword: 
      return true
    case .trueKeyword: 
      return true
    case .tryKeyword: 
      return true
    case .throwsKeyword: 
      return true
    case .wildcardKeyword: 
      return true
    case .leftParen: 
      return false
    case .rightParen: 
      return false
    case .leftBrace: 
      return false
    case .rightBrace: 
      return false
    case .leftSquareBracket: 
      return false
    case .rightSquareBracket: 
      return false
    case .leftAngle: 
      return false
    case .rightAngle: 
      return false
    case .period: 
      return false
    case .comma: 
      return false
    case .ellipsis: 
      return false
    case .colon: 
      return false
    case .semicolon: 
      return false
    case .equal: 
      return false
    case .atSign: 
      return false
    case .pound: 
      return false
    case .prefixAmpersand: 
      return false
    case .arrow: 
      return false
    case .backtick: 
      return false
    case .backslash: 
      return false
    case .exclamationMark: 
      return false
    case .postfixQuestionMark: 
      return false
    case .infixQuestionMark: 
      return false
    case .stringQuote: 
      return false
    case .singleQuote: 
      return false
    case .multilineStringQuote: 
      return false
    case .poundKeyPathKeyword: 
      return true
    case .poundLineKeyword: 
      return true
    case .poundSelectorKeyword: 
      return true
    case .poundFileKeyword: 
      return true
    case .poundFileIDKeyword: 
      return true
    case .poundFilePathKeyword: 
      return true
    case .poundColumnKeyword: 
      return true
    case .poundFunctionKeyword: 
      return true
    case .poundDsohandleKeyword: 
      return true
    case .poundAssertKeyword: 
      return true
    case .poundSourceLocationKeyword: 
      return true
    case .poundWarningKeyword: 
      return true
    case .poundErrorKeyword: 
      return true
    case .poundIfKeyword: 
      return true
    case .poundElseKeyword: 
      return true
    case .poundElseifKeyword: 
      return true
    case .poundEndifKeyword: 
      return true
    case .poundAvailableKeyword: 
      return true
    case .poundUnavailableKeyword: 
      return true
    case .poundFileLiteralKeyword: 
      return true
    case .poundImageLiteralKeyword: 
      return true
    case .poundColorLiteralKeyword: 
      return true
    case .poundHasSymbolKeyword: 
      return true
    case .integerLiteral: 
      return false
    case .floatingLiteral: 
      return false
    case .stringLiteral: 
      return false
    case .regexLiteral: 
      return false
    case .unknown: 
      return false
    case .identifier: 
      return false
    case .binaryOperator: 
      return false
    case .postfixOperator: 
      return false
    case .prefixOperator: 
      return false
    case .dollarIdentifier: 
      return false
    case .contextualKeyword: 
      return false
    case .rawStringDelimiter: 
      return false
    case .stringSegment: 
      return false
    case .yield: 
      return false
    }
  }
  
  /// Returns `true` if the token is a Swift punctuator.
  ///
  /// Punctuation tokens generally separate identifiers from each other. For
  /// example, the '<' and '>' characters in a generic parameter list, or the
  /// quote characters in a string literal.
  public var isPunctuation: Bool {
    switch self {
    case .eof: 
      return false
    case .associatedtypeKeyword: 
      return false
    case .classKeyword: 
      return false
    case .deinitKeyword: 
      return false
    case .enumKeyword: 
      return false
    case .extensionKeyword: 
      return false
    case .funcKeyword: 
      return false
    case .importKeyword: 
      return false
    case .initKeyword: 
      return false
    case .inoutKeyword: 
      return false
    case .letKeyword: 
      return false
    case .operatorKeyword: 
      return false
    case .precedencegroupKeyword: 
      return false
    case .protocolKeyword: 
      return false
    case .structKeyword: 
      return false
    case .subscriptKeyword: 
      return false
    case .typealiasKeyword: 
      return false
    case .varKeyword: 
      return false
    case .fileprivateKeyword: 
      return false
    case .internalKeyword: 
      return false
    case .privateKeyword: 
      return false
    case .publicKeyword: 
      return false
    case .staticKeyword: 
      return false
    case .deferKeyword: 
      return false
    case .ifKeyword: 
      return false
    case .guardKeyword: 
      return false
    case .doKeyword: 
      return false
    case .repeatKeyword: 
      return false
    case .elseKeyword: 
      return false
    case .forKeyword: 
      return false
    case .inKeyword: 
      return false
    case .whileKeyword: 
      return false
    case .returnKeyword: 
      return false
    case .breakKeyword: 
      return false
    case .continueKeyword: 
      return false
    case .fallthroughKeyword: 
      return false
    case .switchKeyword: 
      return false
    case .caseKeyword: 
      return false
    case .defaultKeyword: 
      return false
    case .whereKeyword: 
      return false
    case .catchKeyword: 
      return false
    case .throwKeyword: 
      return false
    case .asKeyword: 
      return false
    case .anyKeyword: 
      return false
    case .falseKeyword: 
      return false
    case .isKeyword: 
      return false
    case .nilKeyword: 
      return false
    case .rethrowsKeyword: 
      return false
    case .superKeyword: 
      return false
    case .selfKeyword: 
      return false
    case .capitalSelfKeyword: 
      return false
    case .trueKeyword: 
      return false
    case .tryKeyword: 
      return false
    case .throwsKeyword: 
      return false
    case .wildcardKeyword: 
      return false
    case .leftParen: 
      return true
    case .rightParen: 
      return true
    case .leftBrace: 
      return true
    case .rightBrace: 
      return true
    case .leftSquareBracket: 
      return true
    case .rightSquareBracket: 
      return true
    case .leftAngle: 
      return true
    case .rightAngle: 
      return true
    case .period: 
      return true
    case .comma: 
      return true
    case .ellipsis: 
      return true
    case .colon: 
      return true
    case .semicolon: 
      return true
    case .equal: 
      return true
    case .atSign: 
      return true
    case .pound: 
      return true
    case .prefixAmpersand: 
      return true
    case .arrow: 
      return true
    case .backtick: 
      return true
    case .backslash: 
      return true
    case .exclamationMark: 
      return true
    case .postfixQuestionMark: 
      return true
    case .infixQuestionMark: 
      return true
    case .stringQuote: 
      return true
    case .singleQuote: 
      return true
    case .multilineStringQuote: 
      return true
    case .poundKeyPathKeyword: 
      return false
    case .poundLineKeyword: 
      return false
    case .poundSelectorKeyword: 
      return false
    case .poundFileKeyword: 
      return false
    case .poundFileIDKeyword: 
      return false
    case .poundFilePathKeyword: 
      return false
    case .poundColumnKeyword: 
      return false
    case .poundFunctionKeyword: 
      return false
    case .poundDsohandleKeyword: 
      return false
    case .poundAssertKeyword: 
      return false
    case .poundSourceLocationKeyword: 
      return false
    case .poundWarningKeyword: 
      return false
    case .poundErrorKeyword: 
      return false
    case .poundIfKeyword: 
      return false
    case .poundElseKeyword: 
      return false
    case .poundElseifKeyword: 
      return false
    case .poundEndifKeyword: 
      return false
    case .poundAvailableKeyword: 
      return false
    case .poundUnavailableKeyword: 
      return false
    case .poundFileLiteralKeyword: 
      return false
    case .poundImageLiteralKeyword: 
      return false
    case .poundColorLiteralKeyword: 
      return false
    case .poundHasSymbolKeyword: 
      return false
    case .integerLiteral: 
      return false
    case .floatingLiteral: 
      return false
    case .stringLiteral: 
      return false
    case .regexLiteral: 
      return false
    case .unknown: 
      return false
    case .identifier: 
      return false
    case .binaryOperator: 
      return false
    case .postfixOperator: 
      return false
    case .prefixOperator: 
      return false
    case .dollarIdentifier: 
      return false
    case .contextualKeyword: 
      return false
    case .rawStringDelimiter: 
      return false
    case .stringSegment: 
      return false
    case .yield: 
      return false
    }
  }
}

extension TokenKind: Equatable {
  public static func == (lhs: TokenKind, rhs: TokenKind) -> Bool {
    switch (lhs, rhs) {
    case (.eof, .eof): 
      return true
    case (.associatedtypeKeyword, .associatedtypeKeyword): 
      return true
    case (.classKeyword, .classKeyword): 
      return true
    case (.deinitKeyword, .deinitKeyword): 
      return true
    case (.enumKeyword, .enumKeyword): 
      return true
    case (.extensionKeyword, .extensionKeyword): 
      return true
    case (.funcKeyword, .funcKeyword): 
      return true
    case (.importKeyword, .importKeyword): 
      return true
    case (.initKeyword, .initKeyword): 
      return true
    case (.inoutKeyword, .inoutKeyword): 
      return true
    case (.letKeyword, .letKeyword): 
      return true
    case (.operatorKeyword, .operatorKeyword): 
      return true
    case (.precedencegroupKeyword, .precedencegroupKeyword): 
      return true
    case (.protocolKeyword, .protocolKeyword): 
      return true
    case (.structKeyword, .structKeyword): 
      return true
    case (.subscriptKeyword, .subscriptKeyword): 
      return true
    case (.typealiasKeyword, .typealiasKeyword): 
      return true
    case (.varKeyword, .varKeyword): 
      return true
    case (.fileprivateKeyword, .fileprivateKeyword): 
      return true
    case (.internalKeyword, .internalKeyword): 
      return true
    case (.privateKeyword, .privateKeyword): 
      return true
    case (.publicKeyword, .publicKeyword): 
      return true
    case (.staticKeyword, .staticKeyword): 
      return true
    case (.deferKeyword, .deferKeyword): 
      return true
    case (.ifKeyword, .ifKeyword): 
      return true
    case (.guardKeyword, .guardKeyword): 
      return true
    case (.doKeyword, .doKeyword): 
      return true
    case (.repeatKeyword, .repeatKeyword): 
      return true
    case (.elseKeyword, .elseKeyword): 
      return true
    case (.forKeyword, .forKeyword): 
      return true
    case (.inKeyword, .inKeyword): 
      return true
    case (.whileKeyword, .whileKeyword): 
      return true
    case (.returnKeyword, .returnKeyword): 
      return true
    case (.breakKeyword, .breakKeyword): 
      return true
    case (.continueKeyword, .continueKeyword): 
      return true
    case (.fallthroughKeyword, .fallthroughKeyword): 
      return true
    case (.switchKeyword, .switchKeyword): 
      return true
    case (.caseKeyword, .caseKeyword): 
      return true
    case (.defaultKeyword, .defaultKeyword): 
      return true
    case (.whereKeyword, .whereKeyword): 
      return true
    case (.catchKeyword, .catchKeyword): 
      return true
    case (.throwKeyword, .throwKeyword): 
      return true
    case (.asKeyword, .asKeyword): 
      return true
    case (.anyKeyword, .anyKeyword): 
      return true
    case (.falseKeyword, .falseKeyword): 
      return true
    case (.isKeyword, .isKeyword): 
      return true
    case (.nilKeyword, .nilKeyword): 
      return true
    case (.rethrowsKeyword, .rethrowsKeyword): 
      return true
    case (.superKeyword, .superKeyword): 
      return true
    case (.selfKeyword, .selfKeyword): 
      return true
    case (.capitalSelfKeyword, .capitalSelfKeyword): 
      return true
    case (.trueKeyword, .trueKeyword): 
      return true
    case (.tryKeyword, .tryKeyword): 
      return true
    case (.throwsKeyword, .throwsKeyword): 
      return true
    case (.wildcardKeyword, .wildcardKeyword): 
      return true
    case (.leftParen, .leftParen): 
      return true
    case (.rightParen, .rightParen): 
      return true
    case (.leftBrace, .leftBrace): 
      return true
    case (.rightBrace, .rightBrace): 
      return true
    case (.leftSquareBracket, .leftSquareBracket): 
      return true
    case (.rightSquareBracket, .rightSquareBracket): 
      return true
    case (.leftAngle, .leftAngle): 
      return true
    case (.rightAngle, .rightAngle): 
      return true
    case (.period, .period): 
      return true
    case (.comma, .comma): 
      return true
    case (.ellipsis, .ellipsis): 
      return true
    case (.colon, .colon): 
      return true
    case (.semicolon, .semicolon): 
      return true
    case (.equal, .equal): 
      return true
    case (.atSign, .atSign): 
      return true
    case (.pound, .pound): 
      return true
    case (.prefixAmpersand, .prefixAmpersand): 
      return true
    case (.arrow, .arrow): 
      return true
    case (.backtick, .backtick): 
      return true
    case (.backslash, .backslash): 
      return true
    case (.exclamationMark, .exclamationMark): 
      return true
    case (.postfixQuestionMark, .postfixQuestionMark): 
      return true
    case (.infixQuestionMark, .infixQuestionMark): 
      return true
    case (.stringQuote, .stringQuote): 
      return true
    case (.singleQuote, .singleQuote): 
      return true
    case (.multilineStringQuote, .multilineStringQuote): 
      return true
    case (.poundKeyPathKeyword, .poundKeyPathKeyword): 
      return true
    case (.poundLineKeyword, .poundLineKeyword): 
      return true
    case (.poundSelectorKeyword, .poundSelectorKeyword): 
      return true
    case (.poundFileKeyword, .poundFileKeyword): 
      return true
    case (.poundFileIDKeyword, .poundFileIDKeyword): 
      return true
    case (.poundFilePathKeyword, .poundFilePathKeyword): 
      return true
    case (.poundColumnKeyword, .poundColumnKeyword): 
      return true
    case (.poundFunctionKeyword, .poundFunctionKeyword): 
      return true
    case (.poundDsohandleKeyword, .poundDsohandleKeyword): 
      return true
    case (.poundAssertKeyword, .poundAssertKeyword): 
      return true
    case (.poundSourceLocationKeyword, .poundSourceLocationKeyword): 
      return true
    case (.poundWarningKeyword, .poundWarningKeyword): 
      return true
    case (.poundErrorKeyword, .poundErrorKeyword): 
      return true
    case (.poundIfKeyword, .poundIfKeyword): 
      return true
    case (.poundElseKeyword, .poundElseKeyword): 
      return true
    case (.poundElseifKeyword, .poundElseifKeyword): 
      return true
    case (.poundEndifKeyword, .poundEndifKeyword): 
      return true
    case (.poundAvailableKeyword, .poundAvailableKeyword): 
      return true
    case (.poundUnavailableKeyword, .poundUnavailableKeyword): 
      return true
    case (.poundFileLiteralKeyword, .poundFileLiteralKeyword): 
      return true
    case (.poundImageLiteralKeyword, .poundImageLiteralKeyword): 
      return true
    case (.poundColorLiteralKeyword, .poundColorLiteralKeyword): 
      return true
    case (.poundHasSymbolKeyword, .poundHasSymbolKeyword): 
      return true
    case (.integerLiteral(let lhsText), .integerLiteral(let rhsText)): 
      return lhsText == rhsText
    case (.floatingLiteral(let lhsText), .floatingLiteral(let rhsText)): 
      return lhsText == rhsText
    case (.stringLiteral(let lhsText), .stringLiteral(let rhsText)): 
      return lhsText == rhsText
    case (.regexLiteral(let lhsText), .regexLiteral(let rhsText)): 
      return lhsText == rhsText
    case (.unknown(let lhsText), .unknown(let rhsText)): 
      return lhsText == rhsText
    case (.identifier(let lhsText), .identifier(let rhsText)): 
      return lhsText == rhsText
    case (.binaryOperator(let lhsText), .binaryOperator(let rhsText)): 
      return lhsText == rhsText
    case (.postfixOperator(let lhsText), .postfixOperator(let rhsText)): 
      return lhsText == rhsText
    case (.prefixOperator(let lhsText), .prefixOperator(let rhsText)): 
      return lhsText == rhsText
    case (.dollarIdentifier(let lhsText), .dollarIdentifier(let rhsText)): 
      return lhsText == rhsText
    case (.contextualKeyword(let lhsText), .contextualKeyword(let rhsText)): 
      return lhsText == rhsText
    case (.rawStringDelimiter(let lhsText), .rawStringDelimiter(let rhsText)): 
      return lhsText == rhsText
    case (.stringSegment(let lhsText), .stringSegment(let rhsText)): 
      return lhsText == rhsText
    case (.yield, .yield): 
      return true
    default: 
      return false
    }
  }
}

/// Plain token kind value, without an associated `String` value.
@frozen // FIXME: Not actually stable, works around a miscompile
public enum RawTokenKind: Equatable, Hashable {
  case eof
  
  case associatedtypeKeyword
  
  case classKeyword
  
  case deinitKeyword
  
  case enumKeyword
  
  case extensionKeyword
  
  case funcKeyword
  
  case importKeyword
  
  case initKeyword
  
  case inoutKeyword
  
  case letKeyword
  
  case operatorKeyword
  
  case precedencegroupKeyword
  
  case protocolKeyword
  
  case structKeyword
  
  case subscriptKeyword
  
  case typealiasKeyword
  
  case varKeyword
  
  case fileprivateKeyword
  
  case internalKeyword
  
  case privateKeyword
  
  case publicKeyword
  
  case staticKeyword
  
  case deferKeyword
  
  case ifKeyword
  
  case guardKeyword
  
  case doKeyword
  
  case repeatKeyword
  
  case elseKeyword
  
  case forKeyword
  
  case inKeyword
  
  case whileKeyword
  
  case returnKeyword
  
  case breakKeyword
  
  case continueKeyword
  
  case fallthroughKeyword
  
  case switchKeyword
  
  case caseKeyword
  
  case defaultKeyword
  
  case whereKeyword
  
  case catchKeyword
  
  case throwKeyword
  
  case asKeyword
  
  case anyKeyword
  
  case falseKeyword
  
  case isKeyword
  
  case nilKeyword
  
  case rethrowsKeyword
  
  case superKeyword
  
  case selfKeyword
  
  case capitalSelfKeyword
  
  case trueKeyword
  
  case tryKeyword
  
  case throwsKeyword
  
  case wildcardKeyword
  
  case leftParen
  
  case rightParen
  
  case leftBrace
  
  case rightBrace
  
  case leftSquareBracket
  
  case rightSquareBracket
  
  case leftAngle
  
  case rightAngle
  
  case period
  
  case comma
  
  case ellipsis
  
  case colon
  
  case semicolon
  
  case equal
  
  case atSign
  
  case pound
  
  case prefixAmpersand
  
  case arrow
  
  case backtick
  
  case backslash
  
  case exclamationMark
  
  case postfixQuestionMark
  
  case infixQuestionMark
  
  case stringQuote
  
  case singleQuote
  
  case multilineStringQuote
  
  case poundKeyPathKeyword
  
  case poundLineKeyword
  
  case poundSelectorKeyword
  
  case poundFileKeyword
  
  case poundFileIDKeyword
  
  case poundFilePathKeyword
  
  case poundColumnKeyword
  
  case poundFunctionKeyword
  
  case poundDsohandleKeyword
  
  case poundAssertKeyword
  
  case poundSourceLocationKeyword
  
  case poundWarningKeyword
  
  case poundErrorKeyword
  
  case poundIfKeyword
  
  case poundElseKeyword
  
  case poundElseifKeyword
  
  case poundEndifKeyword
  
  case poundAvailableKeyword
  
  case poundUnavailableKeyword
  
  case poundFileLiteralKeyword
  
  case poundImageLiteralKeyword
  
  case poundColorLiteralKeyword
  
  case poundHasSymbolKeyword
  
  case integerLiteral
  
  case floatingLiteral
  
  case stringLiteral
  
  case regexLiteral
  
  case unknown
  
  case identifier
  
  case binaryOperator
  
  case postfixOperator
  
  case prefixOperator
  
  case dollarIdentifier
  
  case contextualKeyword(Keyword)
  
  case rawStringDelimiter
  
  case stringSegment
  
  case yield
  
  @_spi(RawSyntax) 
  public var defaultText: SyntaxText? {
    switch self {
    case .eof: 
      return ""
    case .associatedtypeKeyword: 
      return #"associatedtype"#
    case .classKeyword: 
      return #"class"#
    case .deinitKeyword: 
      return #"deinit"#
    case .enumKeyword: 
      return #"enum"#
    case .extensionKeyword: 
      return #"extension"#
    case .funcKeyword: 
      return #"func"#
    case .importKeyword: 
      return #"import"#
    case .initKeyword: 
      return #"init"#
    case .inoutKeyword: 
      return #"inout"#
    case .letKeyword: 
      return #"let"#
    case .operatorKeyword: 
      return #"operator"#
    case .precedencegroupKeyword: 
      return #"precedencegroup"#
    case .protocolKeyword: 
      return #"protocol"#
    case .structKeyword: 
      return #"struct"#
    case .subscriptKeyword: 
      return #"subscript"#
    case .typealiasKeyword: 
      return #"typealias"#
    case .varKeyword: 
      return #"var"#
    case .fileprivateKeyword: 
      return #"fileprivate"#
    case .internalKeyword: 
      return #"internal"#
    case .privateKeyword: 
      return #"private"#
    case .publicKeyword: 
      return #"public"#
    case .staticKeyword: 
      return #"static"#
    case .deferKeyword: 
      return #"defer"#
    case .ifKeyword: 
      return #"if"#
    case .guardKeyword: 
      return #"guard"#
    case .doKeyword: 
      return #"do"#
    case .repeatKeyword: 
      return #"repeat"#
    case .elseKeyword: 
      return #"else"#
    case .forKeyword: 
      return #"for"#
    case .inKeyword: 
      return #"in"#
    case .whileKeyword: 
      return #"while"#
    case .returnKeyword: 
      return #"return"#
    case .breakKeyword: 
      return #"break"#
    case .continueKeyword: 
      return #"continue"#
    case .fallthroughKeyword: 
      return #"fallthrough"#
    case .switchKeyword: 
      return #"switch"#
    case .caseKeyword: 
      return #"case"#
    case .defaultKeyword: 
      return #"default"#
    case .whereKeyword: 
      return #"where"#
    case .catchKeyword: 
      return #"catch"#
    case .throwKeyword: 
      return #"throw"#
    case .asKeyword: 
      return #"as"#
    case .anyKeyword: 
      return #"Any"#
    case .falseKeyword: 
      return #"false"#
    case .isKeyword: 
      return #"is"#
    case .nilKeyword: 
      return #"nil"#
    case .rethrowsKeyword: 
      return #"rethrows"#
    case .superKeyword: 
      return #"super"#
    case .selfKeyword: 
      return #"self"#
    case .capitalSelfKeyword: 
      return #"Self"#
    case .trueKeyword: 
      return #"true"#
    case .tryKeyword: 
      return #"try"#
    case .throwsKeyword: 
      return #"throws"#
    case .wildcardKeyword: 
      return #"_"#
    case .leftParen: 
      return #"("#
    case .rightParen: 
      return #")"#
    case .leftBrace: 
      return #"{"#
    case .rightBrace: 
      return #"}"#
    case .leftSquareBracket: 
      return #"["#
    case .rightSquareBracket: 
      return #"]"#
    case .leftAngle: 
      return #"<"#
    case .rightAngle: 
      return #">"#
    case .period: 
      return #"."#
    case .comma: 
      return #","#
    case .ellipsis: 
      return #"..."#
    case .colon: 
      return #":"#
    case .semicolon: 
      return #";"#
    case .equal: 
      return #"="#
    case .atSign: 
      return #"@"#
    case .pound: 
      return #"#"#
    case .prefixAmpersand: 
      return #"&"#
    case .arrow: 
      return #"->"#
    case .backtick: 
      return #"`"#
    case .backslash: 
      return #"\"#
    case .exclamationMark: 
      return #"!"#
    case .postfixQuestionMark: 
      return #"?"#
    case .infixQuestionMark: 
      return #"?"#
    case .stringQuote: 
      return #"""#
    case .singleQuote: 
      return #"'"#
    case .multilineStringQuote: 
      return #"""""#
    case .poundKeyPathKeyword: 
      return #"#keyPath"#
    case .poundLineKeyword: 
      return #"#line"#
    case .poundSelectorKeyword: 
      return #"#selector"#
    case .poundFileKeyword: 
      return #"#file"#
    case .poundFileIDKeyword: 
      return #"#fileID"#
    case .poundFilePathKeyword: 
      return #"#filePath"#
    case .poundColumnKeyword: 
      return #"#column"#
    case .poundFunctionKeyword: 
      return #"#function"#
    case .poundDsohandleKeyword: 
      return #"#dsohandle"#
    case .poundAssertKeyword: 
      return #"#assert"#
    case .poundSourceLocationKeyword: 
      return #"#sourceLocation"#
    case .poundWarningKeyword: 
      return #"#warning"#
    case .poundErrorKeyword: 
      return #"#error"#
    case .poundIfKeyword: 
      return #"#if"#
    case .poundElseKeyword: 
      return #"#else"#
    case .poundElseifKeyword: 
      return #"#elseif"#
    case .poundEndifKeyword: 
      return #"#endif"#
    case .poundAvailableKeyword: 
      return #"#available"#
    case .poundUnavailableKeyword: 
      return #"#unavailable"#
    case .poundFileLiteralKeyword: 
      return #"#fileLiteral"#
    case .poundImageLiteralKeyword: 
      return #"#imageLiteral"#
    case .poundColorLiteralKeyword: 
      return #"#colorLiteral"#
    case .poundHasSymbolKeyword: 
      return #"#_hasSymbol"#
    case .contextualKeyword(let assoc): 
      return assoc.defaultText
    case .yield: 
      return #"yield"#
    default: 
      return nil
    }
  }
  
  public var nameForDiagnostics: String {
    switch self {
    case .eof: 
      return "end of file"
    case .associatedtypeKeyword: 
      return #"associatedtype"#
    case .classKeyword: 
      return #"class"#
    case .deinitKeyword: 
      return #"deinit"#
    case .enumKeyword: 
      return #"enum"#
    case .extensionKeyword: 
      return #"extension"#
    case .funcKeyword: 
      return #"func"#
    case .importKeyword: 
      return #"import"#
    case .initKeyword: 
      return #"init"#
    case .inoutKeyword: 
      return #"inout"#
    case .letKeyword: 
      return #"let"#
    case .operatorKeyword: 
      return #"operator"#
    case .precedencegroupKeyword: 
      return #"precedencegroup"#
    case .protocolKeyword: 
      return #"protocol"#
    case .structKeyword: 
      return #"struct"#
    case .subscriptKeyword: 
      return #"subscript"#
    case .typealiasKeyword: 
      return #"typealias"#
    case .varKeyword: 
      return #"var"#
    case .fileprivateKeyword: 
      return #"fileprivate"#
    case .internalKeyword: 
      return #"internal"#
    case .privateKeyword: 
      return #"private"#
    case .publicKeyword: 
      return #"public"#
    case .staticKeyword: 
      return #"static"#
    case .deferKeyword: 
      return #"defer"#
    case .ifKeyword: 
      return #"if"#
    case .guardKeyword: 
      return #"guard"#
    case .doKeyword: 
      return #"do"#
    case .repeatKeyword: 
      return #"repeat"#
    case .elseKeyword: 
      return #"else"#
    case .forKeyword: 
      return #"for"#
    case .inKeyword: 
      return #"in"#
    case .whileKeyword: 
      return #"while"#
    case .returnKeyword: 
      return #"return"#
    case .breakKeyword: 
      return #"break"#
    case .continueKeyword: 
      return #"continue"#
    case .fallthroughKeyword: 
      return #"fallthrough"#
    case .switchKeyword: 
      return #"switch"#
    case .caseKeyword: 
      return #"case"#
    case .defaultKeyword: 
      return #"default"#
    case .whereKeyword: 
      return #"where"#
    case .catchKeyword: 
      return #"catch"#
    case .throwKeyword: 
      return #"throw"#
    case .asKeyword: 
      return #"as"#
    case .anyKeyword: 
      return #"Any"#
    case .falseKeyword: 
      return #"false"#
    case .isKeyword: 
      return #"is"#
    case .nilKeyword: 
      return #"nil"#
    case .rethrowsKeyword: 
      return #"rethrows"#
    case .superKeyword: 
      return #"super"#
    case .selfKeyword: 
      return #"self"#
    case .capitalSelfKeyword: 
      return #"Self"#
    case .trueKeyword: 
      return #"true"#
    case .tryKeyword: 
      return #"try"#
    case .throwsKeyword: 
      return #"throws"#
    case .wildcardKeyword: 
      return #"_"#
    case .leftParen: 
      return #"("#
    case .rightParen: 
      return #")"#
    case .leftBrace: 
      return #"{"#
    case .rightBrace: 
      return #"}"#
    case .leftSquareBracket: 
      return #"["#
    case .rightSquareBracket: 
      return #"]"#
    case .leftAngle: 
      return #"<"#
    case .rightAngle: 
      return #">"#
    case .period: 
      return #"."#
    case .comma: 
      return #","#
    case .ellipsis: 
      return #"..."#
    case .colon: 
      return #":"#
    case .semicolon: 
      return #";"#
    case .equal: 
      return #"="#
    case .atSign: 
      return #"@"#
    case .pound: 
      return #"#"#
    case .prefixAmpersand: 
      return #"&"#
    case .arrow: 
      return #"->"#
    case .backtick: 
      return #"`"#
    case .backslash: 
      return #"\"#
    case .exclamationMark: 
      return #"!"#
    case .postfixQuestionMark: 
      return #"?"#
    case .infixQuestionMark: 
      return #"?"#
    case .stringQuote: 
      return #"""#
    case .singleQuote: 
      return #"'"#
    case .multilineStringQuote: 
      return #"""""#
    case .poundKeyPathKeyword: 
      return #"#keyPath"#
    case .poundLineKeyword: 
      return #"#line"#
    case .poundSelectorKeyword: 
      return #"#selector"#
    case .poundFileKeyword: 
      return #"#file"#
    case .poundFileIDKeyword: 
      return #"#fileID"#
    case .poundFilePathKeyword: 
      return #"#filePath"#
    case .poundColumnKeyword: 
      return #"#column"#
    case .poundFunctionKeyword: 
      return #"#function"#
    case .poundDsohandleKeyword: 
      return #"#dsohandle"#
    case .poundAssertKeyword: 
      return #"#assert"#
    case .poundSourceLocationKeyword: 
      return #"#sourceLocation"#
    case .poundWarningKeyword: 
      return #"#warning"#
    case .poundErrorKeyword: 
      return #"#error"#
    case .poundIfKeyword: 
      return #"#if"#
    case .poundElseKeyword: 
      return #"#else"#
    case .poundElseifKeyword: 
      return #"#elseif"#
    case .poundEndifKeyword: 
      return #"#endif"#
    case .poundAvailableKeyword: 
      return #"#available"#
    case .poundUnavailableKeyword: 
      return #"#unavailable"#
    case .poundFileLiteralKeyword: 
      return #"file reference"#
    case .poundImageLiteralKeyword: 
      return #"image"#
    case .poundColorLiteralKeyword: 
      return #"color"#
    case .poundHasSymbolKeyword: 
      return #"#_hasSymbol"#
    case .integerLiteral: 
      return #"integer literal"#
    case .floatingLiteral: 
      return #"floating literal"#
    case .stringLiteral: 
      return #"string literal"#
    case .regexLiteral: 
      return #"regex literal"#
    case .unknown: 
      return #"token"#
    case .identifier: 
      return #"identifier"#
    case .binaryOperator: 
      return #"binary operator"#
    case .postfixOperator: 
      return #"postfix operator"#
    case .prefixOperator: 
      return #"prefix operator"#
    case .dollarIdentifier: 
      return #"dollar identifier"#
    case .contextualKeyword: 
      return #"keyword"#
    case .rawStringDelimiter: 
      return #"raw string delimiter"#
    case .stringSegment: 
      return #"string segment"#
    case .yield: 
      return #"yield"#
    }
  }
  
  /// Returns `true` if the token is a Swift keyword.
  ///
  /// Keywords are reserved unconditionally for use by Swift and may not
  /// appear as identifiers in any position without being escaped. For example,
  /// `class`, `func`, or `import`.
  public var isKeyword: Bool {
    switch self {
    case .eof: 
      return false
    case .associatedtypeKeyword: 
      return true
    case .classKeyword: 
      return true
    case .deinitKeyword: 
      return true
    case .enumKeyword: 
      return true
    case .extensionKeyword: 
      return true
    case .funcKeyword: 
      return true
    case .importKeyword: 
      return true
    case .initKeyword: 
      return true
    case .inoutKeyword: 
      return true
    case .letKeyword: 
      return true
    case .operatorKeyword: 
      return true
    case .precedencegroupKeyword: 
      return true
    case .protocolKeyword: 
      return true
    case .structKeyword: 
      return true
    case .subscriptKeyword: 
      return true
    case .typealiasKeyword: 
      return true
    case .varKeyword: 
      return true
    case .fileprivateKeyword: 
      return true
    case .internalKeyword: 
      return true
    case .privateKeyword: 
      return true
    case .publicKeyword: 
      return true
    case .staticKeyword: 
      return true
    case .deferKeyword: 
      return true
    case .ifKeyword: 
      return true
    case .guardKeyword: 
      return true
    case .doKeyword: 
      return true
    case .repeatKeyword: 
      return true
    case .elseKeyword: 
      return true
    case .forKeyword: 
      return true
    case .inKeyword: 
      return true
    case .whileKeyword: 
      return true
    case .returnKeyword: 
      return true
    case .breakKeyword: 
      return true
    case .continueKeyword: 
      return true
    case .fallthroughKeyword: 
      return true
    case .switchKeyword: 
      return true
    case .caseKeyword: 
      return true
    case .defaultKeyword: 
      return true
    case .whereKeyword: 
      return true
    case .catchKeyword: 
      return true
    case .throwKeyword: 
      return true
    case .asKeyword: 
      return true
    case .anyKeyword: 
      return true
    case .falseKeyword: 
      return true
    case .isKeyword: 
      return true
    case .nilKeyword: 
      return true
    case .rethrowsKeyword: 
      return true
    case .superKeyword: 
      return true
    case .selfKeyword: 
      return true
    case .capitalSelfKeyword: 
      return true
    case .trueKeyword: 
      return true
    case .tryKeyword: 
      return true
    case .throwsKeyword: 
      return true
    case .wildcardKeyword: 
      return true
    case .leftParen: 
      return false
    case .rightParen: 
      return false
    case .leftBrace: 
      return false
    case .rightBrace: 
      return false
    case .leftSquareBracket: 
      return false
    case .rightSquareBracket: 
      return false
    case .leftAngle: 
      return false
    case .rightAngle: 
      return false
    case .period: 
      return false
    case .comma: 
      return false
    case .ellipsis: 
      return false
    case .colon: 
      return false
    case .semicolon: 
      return false
    case .equal: 
      return false
    case .atSign: 
      return false
    case .pound: 
      return false
    case .prefixAmpersand: 
      return false
    case .arrow: 
      return false
    case .backtick: 
      return false
    case .backslash: 
      return false
    case .exclamationMark: 
      return false
    case .postfixQuestionMark: 
      return false
    case .infixQuestionMark: 
      return false
    case .stringQuote: 
      return false
    case .singleQuote: 
      return false
    case .multilineStringQuote: 
      return false
    case .poundKeyPathKeyword: 
      return true
    case .poundLineKeyword: 
      return true
    case .poundSelectorKeyword: 
      return true
    case .poundFileKeyword: 
      return true
    case .poundFileIDKeyword: 
      return true
    case .poundFilePathKeyword: 
      return true
    case .poundColumnKeyword: 
      return true
    case .poundFunctionKeyword: 
      return true
    case .poundDsohandleKeyword: 
      return true
    case .poundAssertKeyword: 
      return true
    case .poundSourceLocationKeyword: 
      return true
    case .poundWarningKeyword: 
      return true
    case .poundErrorKeyword: 
      return true
    case .poundIfKeyword: 
      return true
    case .poundElseKeyword: 
      return true
    case .poundElseifKeyword: 
      return true
    case .poundEndifKeyword: 
      return true
    case .poundAvailableKeyword: 
      return true
    case .poundUnavailableKeyword: 
      return true
    case .poundFileLiteralKeyword: 
      return true
    case .poundImageLiteralKeyword: 
      return true
    case .poundColorLiteralKeyword: 
      return true
    case .poundHasSymbolKeyword: 
      return true
    case .integerLiteral: 
      return false
    case .floatingLiteral: 
      return false
    case .stringLiteral: 
      return false
    case .regexLiteral: 
      return false
    case .unknown: 
      return false
    case .identifier: 
      return false
    case .binaryOperator: 
      return false
    case .postfixOperator: 
      return false
    case .prefixOperator: 
      return false
    case .dollarIdentifier: 
      return false
    case .contextualKeyword: 
      return false
    case .rawStringDelimiter: 
      return false
    case .stringSegment: 
      return false
    case .yield: 
      return false
    }
  }
  
  /// Returns `true` if the token is a Swift punctuator.
  ///
  /// Punctuation tokens generally separate identifiers from each other. For
  /// example, the '<' and '>' characters in a generic parameter list, or the
  /// quote characters in a string literal.
  public var isPunctuation: Bool {
    switch self {
    case .eof: 
      return false
    case .associatedtypeKeyword: 
      return false
    case .classKeyword: 
      return false
    case .deinitKeyword: 
      return false
    case .enumKeyword: 
      return false
    case .extensionKeyword: 
      return false
    case .funcKeyword: 
      return false
    case .importKeyword: 
      return false
    case .initKeyword: 
      return false
    case .inoutKeyword: 
      return false
    case .letKeyword: 
      return false
    case .operatorKeyword: 
      return false
    case .precedencegroupKeyword: 
      return false
    case .protocolKeyword: 
      return false
    case .structKeyword: 
      return false
    case .subscriptKeyword: 
      return false
    case .typealiasKeyword: 
      return false
    case .varKeyword: 
      return false
    case .fileprivateKeyword: 
      return false
    case .internalKeyword: 
      return false
    case .privateKeyword: 
      return false
    case .publicKeyword: 
      return false
    case .staticKeyword: 
      return false
    case .deferKeyword: 
      return false
    case .ifKeyword: 
      return false
    case .guardKeyword: 
      return false
    case .doKeyword: 
      return false
    case .repeatKeyword: 
      return false
    case .elseKeyword: 
      return false
    case .forKeyword: 
      return false
    case .inKeyword: 
      return false
    case .whileKeyword: 
      return false
    case .returnKeyword: 
      return false
    case .breakKeyword: 
      return false
    case .continueKeyword: 
      return false
    case .fallthroughKeyword: 
      return false
    case .switchKeyword: 
      return false
    case .caseKeyword: 
      return false
    case .defaultKeyword: 
      return false
    case .whereKeyword: 
      return false
    case .catchKeyword: 
      return false
    case .throwKeyword: 
      return false
    case .asKeyword: 
      return false
    case .anyKeyword: 
      return false
    case .falseKeyword: 
      return false
    case .isKeyword: 
      return false
    case .nilKeyword: 
      return false
    case .rethrowsKeyword: 
      return false
    case .superKeyword: 
      return false
    case .selfKeyword: 
      return false
    case .capitalSelfKeyword: 
      return false
    case .trueKeyword: 
      return false
    case .tryKeyword: 
      return false
    case .throwsKeyword: 
      return false
    case .wildcardKeyword: 
      return false
    case .leftParen: 
      return true
    case .rightParen: 
      return true
    case .leftBrace: 
      return true
    case .rightBrace: 
      return true
    case .leftSquareBracket: 
      return true
    case .rightSquareBracket: 
      return true
    case .leftAngle: 
      return true
    case .rightAngle: 
      return true
    case .period: 
      return true
    case .comma: 
      return true
    case .ellipsis: 
      return true
    case .colon: 
      return true
    case .semicolon: 
      return true
    case .equal: 
      return true
    case .atSign: 
      return true
    case .pound: 
      return true
    case .prefixAmpersand: 
      return true
    case .arrow: 
      return true
    case .backtick: 
      return true
    case .backslash: 
      return true
    case .exclamationMark: 
      return true
    case .postfixQuestionMark: 
      return true
    case .infixQuestionMark: 
      return true
    case .stringQuote: 
      return true
    case .singleQuote: 
      return true
    case .multilineStringQuote: 
      return true
    case .poundKeyPathKeyword: 
      return false
    case .poundLineKeyword: 
      return false
    case .poundSelectorKeyword: 
      return false
    case .poundFileKeyword: 
      return false
    case .poundFileIDKeyword: 
      return false
    case .poundFilePathKeyword: 
      return false
    case .poundColumnKeyword: 
      return false
    case .poundFunctionKeyword: 
      return false
    case .poundDsohandleKeyword: 
      return false
    case .poundAssertKeyword: 
      return false
    case .poundSourceLocationKeyword: 
      return false
    case .poundWarningKeyword: 
      return false
    case .poundErrorKeyword: 
      return false
    case .poundIfKeyword: 
      return false
    case .poundElseKeyword: 
      return false
    case .poundElseifKeyword: 
      return false
    case .poundEndifKeyword: 
      return false
    case .poundAvailableKeyword: 
      return false
    case .poundUnavailableKeyword: 
      return false
    case .poundFileLiteralKeyword: 
      return false
    case .poundImageLiteralKeyword: 
      return false
    case .poundColorLiteralKeyword: 
      return false
    case .poundHasSymbolKeyword: 
      return false
    case .integerLiteral: 
      return false
    case .floatingLiteral: 
      return false
    case .stringLiteral: 
      return false
    case .regexLiteral: 
      return false
    case .unknown: 
      return false
    case .identifier: 
      return false
    case .binaryOperator: 
      return false
    case .postfixOperator: 
      return false
    case .prefixOperator: 
      return false
    case .dollarIdentifier: 
      return false
    case .contextualKeyword: 
      return false
    case .rawStringDelimiter: 
      return false
    case .stringSegment: 
      return false
    case .yield: 
      return false
    }
  }
  
  @_spi(RawSyntax)
  public init?(keyword text: SyntaxText) {
    switch text.count {
    case 1: 
      switch text {
      case "_": 
        self = .wildcardKeyword
      default: 
        return nil
      }
    case 2: 
      switch text {
      case "if": 
        self = .ifKeyword
      case "do": 
        self = .doKeyword
      case "in": 
        self = .inKeyword
      case "as": 
        self = .asKeyword
      case "is": 
        self = .isKeyword
      default: 
        return nil
      }
    case 3: 
      switch text {
      case "let": 
        self = .letKeyword
      case "var": 
        self = .varKeyword
      case "for": 
        self = .forKeyword
      case "Any": 
        self = .anyKeyword
      case "nil": 
        self = .nilKeyword
      case "try": 
        self = .tryKeyword
      case "#if": 
        self = .poundIfKeyword
      default: 
        return nil
      }
    case 4: 
      switch text {
      case "enum": 
        self = .enumKeyword
      case "func": 
        self = .funcKeyword
      case "init": 
        self = .initKeyword
      case "else": 
        self = .elseKeyword
      case "case": 
        self = .caseKeyword
      case "self": 
        self = .selfKeyword
      case "Self": 
        self = .capitalSelfKeyword
      case "true": 
        self = .trueKeyword
      default: 
        return nil
      }
    case 5: 
      switch text {
      case "class": 
        self = .classKeyword
      case "inout": 
        self = .inoutKeyword
      case "defer": 
        self = .deferKeyword
      case "guard": 
        self = .guardKeyword
      case "while": 
        self = .whileKeyword
      case "break": 
        self = .breakKeyword
      case "where": 
        self = .whereKeyword
      case "catch": 
        self = .catchKeyword
      case "throw": 
        self = .throwKeyword
      case "false": 
        self = .falseKeyword
      case "super": 
        self = .superKeyword
      case "#line": 
        self = .poundLineKeyword
      case "#file": 
        self = .poundFileKeyword
      case "#else": 
        self = .poundElseKeyword
      default: 
        return nil
      }
    case 6: 
      switch text {
      case "deinit": 
        self = .deinitKeyword
      case "import": 
        self = .importKeyword
      case "struct": 
        self = .structKeyword
      case "public": 
        self = .publicKeyword
      case "static": 
        self = .staticKeyword
      case "repeat": 
        self = .repeatKeyword
      case "return": 
        self = .returnKeyword
      case "switch": 
        self = .switchKeyword
      case "throws": 
        self = .throwsKeyword
      case "#error": 
        self = .poundErrorKeyword
      case "#endif": 
        self = .poundEndifKeyword
      default: 
        return nil
      }
    case 7: 
      switch text {
      case "private": 
        self = .privateKeyword
      case "default": 
        self = .defaultKeyword
      case "#fileID": 
        self = .poundFileIDKeyword
      case "#column": 
        self = .poundColumnKeyword
      case "#assert": 
        self = .poundAssertKeyword
      case "#elseif": 
        self = .poundElseifKeyword
      default: 
        return nil
      }
    case 8: 
      switch text {
      case "operator": 
        self = .operatorKeyword
      case "protocol": 
        self = .protocolKeyword
      case "internal": 
        self = .internalKeyword
      case "continue": 
        self = .continueKeyword
      case "rethrows": 
        self = .rethrowsKeyword
      case "#keyPath": 
        self = .poundKeyPathKeyword
      case "#warning": 
        self = .poundWarningKeyword
      default: 
        return nil
      }
    case 9: 
      switch text {
      case "extension": 
        self = .extensionKeyword
      case "subscript": 
        self = .subscriptKeyword
      case "typealias": 
        self = .typealiasKeyword
      case "#selector": 
        self = .poundSelectorKeyword
      case "#filePath": 
        self = .poundFilePathKeyword
      case "#function": 
        self = .poundFunctionKeyword
      default: 
        return nil
      }
    case 10: 
      switch text {
      case "#dsohandle": 
        self = .poundDsohandleKeyword
      case "#available": 
        self = .poundAvailableKeyword
      default: 
        return nil
      }
    case 11: 
      switch text {
      case "fileprivate": 
        self = .fileprivateKeyword
      case "fallthrough": 
        self = .fallthroughKeyword
      case "#_hasSymbol": 
        self = .poundHasSymbolKeyword
      default: 
        return nil
      }
    case 12: 
      switch text {
      case "#unavailable": 
        self = .poundUnavailableKeyword
      case "#fileLiteral": 
        self = .poundFileLiteralKeyword
      default: 
        return nil
      }
    case 13: 
      switch text {
      case "#imageLiteral": 
        self = .poundImageLiteralKeyword
      case "#colorLiteral": 
        self = .poundColorLiteralKeyword
      default: 
        return nil
      }
    case 14: 
      switch text {
      case "associatedtype": 
        self = .associatedtypeKeyword
      default: 
        return nil
      }
    case 15: 
      switch text {
      case "precedencegroup": 
        self = .precedencegroupKeyword
      case "#sourceLocation": 
        self = .poundSourceLocationKeyword
      default: 
        return nil
      }
    default: 
      return nil
    }
  }
}

extension TokenKind {
  /// If the `rawKind` has a `defaultText`, `text` can be empty.
  @_spi(RawSyntax)
  public static func fromRaw(kind rawKind: RawTokenKind, text: String) -> TokenKind {
    switch rawKind {
    case .eof: 
      return .eof
    case .associatedtypeKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .associatedtypeKeyword
    case .classKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .classKeyword
    case .deinitKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .deinitKeyword
    case .enumKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .enumKeyword
    case .extensionKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .extensionKeyword
    case .funcKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .funcKeyword
    case .importKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .importKeyword
    case .initKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .initKeyword
    case .inoutKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .inoutKeyword
    case .letKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .letKeyword
    case .operatorKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .operatorKeyword
    case .precedencegroupKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .precedencegroupKeyword
    case .protocolKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .protocolKeyword
    case .structKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .structKeyword
    case .subscriptKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .subscriptKeyword
    case .typealiasKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .typealiasKeyword
    case .varKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .varKeyword
    case .fileprivateKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .fileprivateKeyword
    case .internalKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .internalKeyword
    case .privateKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .privateKeyword
    case .publicKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .publicKeyword
    case .staticKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .staticKeyword
    case .deferKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .deferKeyword
    case .ifKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .ifKeyword
    case .guardKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .guardKeyword
    case .doKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .doKeyword
    case .repeatKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .repeatKeyword
    case .elseKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .elseKeyword
    case .forKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .forKeyword
    case .inKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .inKeyword
    case .whileKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .whileKeyword
    case .returnKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .returnKeyword
    case .breakKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .breakKeyword
    case .continueKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .continueKeyword
    case .fallthroughKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .fallthroughKeyword
    case .switchKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .switchKeyword
    case .caseKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .caseKeyword
    case .defaultKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .defaultKeyword
    case .whereKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .whereKeyword
    case .catchKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .catchKeyword
    case .throwKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .throwKeyword
    case .asKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .asKeyword
    case .anyKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .anyKeyword
    case .falseKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .falseKeyword
    case .isKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .isKeyword
    case .nilKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .nilKeyword
    case .rethrowsKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .rethrowsKeyword
    case .superKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .superKeyword
    case .selfKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .selfKeyword
    case .capitalSelfKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .capitalSelfKeyword
    case .trueKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .trueKeyword
    case .tryKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .tryKeyword
    case .throwsKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .throwsKeyword
    case .wildcardKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .wildcardKeyword
    case .leftParen: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .leftParen
    case .rightParen: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .rightParen
    case .leftBrace: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .leftBrace
    case .rightBrace: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .rightBrace
    case .leftSquareBracket: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .leftSquareBracket
    case .rightSquareBracket: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .rightSquareBracket
    case .leftAngle: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .leftAngle
    case .rightAngle: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .rightAngle
    case .period: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .period
    case .comma: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .comma
    case .ellipsis: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .ellipsis
    case .colon: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .colon
    case .semicolon: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .semicolon
    case .equal: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .equal
    case .atSign: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .atSign
    case .pound: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .pound
    case .prefixAmpersand: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .prefixAmpersand
    case .arrow: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .arrow
    case .backtick: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .backtick
    case .backslash: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .backslash
    case .exclamationMark: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .exclamationMark
    case .postfixQuestionMark: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .postfixQuestionMark
    case .infixQuestionMark: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .infixQuestionMark
    case .stringQuote: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .stringQuote
    case .singleQuote: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .singleQuote
    case .multilineStringQuote: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .multilineStringQuote
    case .poundKeyPathKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundKeyPathKeyword
    case .poundLineKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundLineKeyword
    case .poundSelectorKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundSelectorKeyword
    case .poundFileKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundFileKeyword
    case .poundFileIDKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundFileIDKeyword
    case .poundFilePathKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundFilePathKeyword
    case .poundColumnKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundColumnKeyword
    case .poundFunctionKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundFunctionKeyword
    case .poundDsohandleKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundDsohandleKeyword
    case .poundAssertKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundAssertKeyword
    case .poundSourceLocationKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundSourceLocationKeyword
    case .poundWarningKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundWarningKeyword
    case .poundErrorKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundErrorKeyword
    case .poundIfKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundIfKeyword
    case .poundElseKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundElseKeyword
    case .poundElseifKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundElseifKeyword
    case .poundEndifKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundEndifKeyword
    case .poundAvailableKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundAvailableKeyword
    case .poundUnavailableKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundUnavailableKeyword
    case .poundFileLiteralKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundFileLiteralKeyword
    case .poundImageLiteralKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundImageLiteralKeyword
    case .poundColorLiteralKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundColorLiteralKeyword
    case .poundHasSymbolKeyword: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .poundHasSymbolKeyword
    case .integerLiteral: 
      return .integerLiteral(text)
    case .floatingLiteral: 
      return .floatingLiteral(text)
    case .stringLiteral: 
      return .stringLiteral(text)
    case .regexLiteral: 
      return .regexLiteral(text)
    case .unknown: 
      return .unknown(text)
    case .identifier: 
      return .identifier(text)
    case .binaryOperator: 
      return .binaryOperator(text)
    case .postfixOperator: 
      return .postfixOperator(text)
    case .prefixOperator: 
      return .prefixOperator(text)
    case .dollarIdentifier: 
      return .dollarIdentifier(text)
    case .contextualKeyword(let assoc): 
      assert(text.isEmpty || String(syntaxText: assoc.defaultText) == text)
      return .contextualKeyword(assoc)
    case .rawStringDelimiter: 
      return .rawStringDelimiter(text)
    case .stringSegment: 
      return .stringSegment(text)
    case .yield: 
      assert(text.isEmpty || rawKind.defaultText.map(String.init ) == text)
      return .yield
    }
  }
  
  /// Returns the `RawTokenKind` of this `TokenKind` and, if this `TokenKind`
  /// has associated text, the associated text, otherwise `nil`.
  @_spi(RawSyntax)
  public func decomposeToRaw() -> (rawKind: RawTokenKind, string: String?) {
    switch self {
    case .eof: 
      return (.eof, nil)
    case .associatedtypeKeyword: 
      return (.associatedtypeKeyword, nil)
    case .classKeyword: 
      return (.classKeyword, nil)
    case .deinitKeyword: 
      return (.deinitKeyword, nil)
    case .enumKeyword: 
      return (.enumKeyword, nil)
    case .extensionKeyword: 
      return (.extensionKeyword, nil)
    case .funcKeyword: 
      return (.funcKeyword, nil)
    case .importKeyword: 
      return (.importKeyword, nil)
    case .initKeyword: 
      return (.initKeyword, nil)
    case .inoutKeyword: 
      return (.inoutKeyword, nil)
    case .letKeyword: 
      return (.letKeyword, nil)
    case .operatorKeyword: 
      return (.operatorKeyword, nil)
    case .precedencegroupKeyword: 
      return (.precedencegroupKeyword, nil)
    case .protocolKeyword: 
      return (.protocolKeyword, nil)
    case .structKeyword: 
      return (.structKeyword, nil)
    case .subscriptKeyword: 
      return (.subscriptKeyword, nil)
    case .typealiasKeyword: 
      return (.typealiasKeyword, nil)
    case .varKeyword: 
      return (.varKeyword, nil)
    case .fileprivateKeyword: 
      return (.fileprivateKeyword, nil)
    case .internalKeyword: 
      return (.internalKeyword, nil)
    case .privateKeyword: 
      return (.privateKeyword, nil)
    case .publicKeyword: 
      return (.publicKeyword, nil)
    case .staticKeyword: 
      return (.staticKeyword, nil)
    case .deferKeyword: 
      return (.deferKeyword, nil)
    case .ifKeyword: 
      return (.ifKeyword, nil)
    case .guardKeyword: 
      return (.guardKeyword, nil)
    case .doKeyword: 
      return (.doKeyword, nil)
    case .repeatKeyword: 
      return (.repeatKeyword, nil)
    case .elseKeyword: 
      return (.elseKeyword, nil)
    case .forKeyword: 
      return (.forKeyword, nil)
    case .inKeyword: 
      return (.inKeyword, nil)
    case .whileKeyword: 
      return (.whileKeyword, nil)
    case .returnKeyword: 
      return (.returnKeyword, nil)
    case .breakKeyword: 
      return (.breakKeyword, nil)
    case .continueKeyword: 
      return (.continueKeyword, nil)
    case .fallthroughKeyword: 
      return (.fallthroughKeyword, nil)
    case .switchKeyword: 
      return (.switchKeyword, nil)
    case .caseKeyword: 
      return (.caseKeyword, nil)
    case .defaultKeyword: 
      return (.defaultKeyword, nil)
    case .whereKeyword: 
      return (.whereKeyword, nil)
    case .catchKeyword: 
      return (.catchKeyword, nil)
    case .throwKeyword: 
      return (.throwKeyword, nil)
    case .asKeyword: 
      return (.asKeyword, nil)
    case .anyKeyword: 
      return (.anyKeyword, nil)
    case .falseKeyword: 
      return (.falseKeyword, nil)
    case .isKeyword: 
      return (.isKeyword, nil)
    case .nilKeyword: 
      return (.nilKeyword, nil)
    case .rethrowsKeyword: 
      return (.rethrowsKeyword, nil)
    case .superKeyword: 
      return (.superKeyword, nil)
    case .selfKeyword: 
      return (.selfKeyword, nil)
    case .capitalSelfKeyword: 
      return (.capitalSelfKeyword, nil)
    case .trueKeyword: 
      return (.trueKeyword, nil)
    case .tryKeyword: 
      return (.tryKeyword, nil)
    case .throwsKeyword: 
      return (.throwsKeyword, nil)
    case .wildcardKeyword: 
      return (.wildcardKeyword, nil)
    case .leftParen: 
      return (.leftParen, nil)
    case .rightParen: 
      return (.rightParen, nil)
    case .leftBrace: 
      return (.leftBrace, nil)
    case .rightBrace: 
      return (.rightBrace, nil)
    case .leftSquareBracket: 
      return (.leftSquareBracket, nil)
    case .rightSquareBracket: 
      return (.rightSquareBracket, nil)
    case .leftAngle: 
      return (.leftAngle, nil)
    case .rightAngle: 
      return (.rightAngle, nil)
    case .period: 
      return (.period, nil)
    case .comma: 
      return (.comma, nil)
    case .ellipsis: 
      return (.ellipsis, nil)
    case .colon: 
      return (.colon, nil)
    case .semicolon: 
      return (.semicolon, nil)
    case .equal: 
      return (.equal, nil)
    case .atSign: 
      return (.atSign, nil)
    case .pound: 
      return (.pound, nil)
    case .prefixAmpersand: 
      return (.prefixAmpersand, nil)
    case .arrow: 
      return (.arrow, nil)
    case .backtick: 
      return (.backtick, nil)
    case .backslash: 
      return (.backslash, nil)
    case .exclamationMark: 
      return (.exclamationMark, nil)
    case .postfixQuestionMark: 
      return (.postfixQuestionMark, nil)
    case .infixQuestionMark: 
      return (.infixQuestionMark, nil)
    case .stringQuote: 
      return (.stringQuote, nil)
    case .singleQuote: 
      return (.singleQuote, nil)
    case .multilineStringQuote: 
      return (.multilineStringQuote, nil)
    case .poundKeyPathKeyword: 
      return (.poundKeyPathKeyword, nil)
    case .poundLineKeyword: 
      return (.poundLineKeyword, nil)
    case .poundSelectorKeyword: 
      return (.poundSelectorKeyword, nil)
    case .poundFileKeyword: 
      return (.poundFileKeyword, nil)
    case .poundFileIDKeyword: 
      return (.poundFileIDKeyword, nil)
    case .poundFilePathKeyword: 
      return (.poundFilePathKeyword, nil)
    case .poundColumnKeyword: 
      return (.poundColumnKeyword, nil)
    case .poundFunctionKeyword: 
      return (.poundFunctionKeyword, nil)
    case .poundDsohandleKeyword: 
      return (.poundDsohandleKeyword, nil)
    case .poundAssertKeyword: 
      return (.poundAssertKeyword, nil)
    case .poundSourceLocationKeyword: 
      return (.poundSourceLocationKeyword, nil)
    case .poundWarningKeyword: 
      return (.poundWarningKeyword, nil)
    case .poundErrorKeyword: 
      return (.poundErrorKeyword, nil)
    case .poundIfKeyword: 
      return (.poundIfKeyword, nil)
    case .poundElseKeyword: 
      return (.poundElseKeyword, nil)
    case .poundElseifKeyword: 
      return (.poundElseifKeyword, nil)
    case .poundEndifKeyword: 
      return (.poundEndifKeyword, nil)
    case .poundAvailableKeyword: 
      return (.poundAvailableKeyword, nil)
    case .poundUnavailableKeyword: 
      return (.poundUnavailableKeyword, nil)
    case .poundFileLiteralKeyword: 
      return (.poundFileLiteralKeyword, nil)
    case .poundImageLiteralKeyword: 
      return (.poundImageLiteralKeyword, nil)
    case .poundColorLiteralKeyword: 
      return (.poundColorLiteralKeyword, nil)
    case .poundHasSymbolKeyword: 
      return (.poundHasSymbolKeyword, nil)
    case .integerLiteral(let str): 
      return (.integerLiteral, str)
    case .floatingLiteral(let str): 
      return (.floatingLiteral, str)
    case .stringLiteral(let str): 
      return (.stringLiteral, str)
    case .regexLiteral(let str): 
      return (.regexLiteral, str)
    case .unknown(let str): 
      return (.unknown, str)
    case .identifier(let str): 
      return (.identifier, str)
    case .binaryOperator(let str): 
      return (.binaryOperator, str)
    case .postfixOperator(let str): 
      return (.postfixOperator, str)
    case .prefixOperator(let str): 
      return (.prefixOperator, str)
    case .dollarIdentifier(let str): 
      return (.dollarIdentifier, str)
    case .contextualKeyword(let assoc): 
      return (.contextualKeyword(assoc), String(syntaxText: assoc.defaultText))
    case .rawStringDelimiter(let str): 
      return (.rawStringDelimiter, str)
    case .stringSegment(let str): 
      return (.stringSegment, str)
    case .yield: 
      return (.yield, nil)
    }
  }
}
