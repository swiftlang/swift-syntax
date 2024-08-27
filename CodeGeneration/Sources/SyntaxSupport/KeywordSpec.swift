//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

public struct KeywordSpec {
  /// The name of the keyword.
  public let name: String

  /// The experimental feature the keyword is part of, or `nil` if this isn't
  /// for an experimental feature.
  public let experimentalFeature: ExperimentalFeature?

  /// Indicates if the token kind is switched from being an identifier to a keyword in the lexer.
  public let isLexerClassified: Bool

  /// Indicates if the keyword is part of an experimental language feature.
  ///
  /// If `true`, this keyword is for an experimental language feature, and any public
  /// API generated should be marked as SPI
  public var isExperimental: Bool { experimentalFeature != nil }

  /// The name of this keyword that's suitable to be used for variable or enum case names.
  public var varOrCaseName: TokenSyntax {
    if name == "init" {
      return "`init`"
    } else {
      return TokenSyntax.identifier(name)
    }
  }

  /// The attributes that should be printed on any API for the generated keyword.
  ///
  /// This is typically used to mark APIs as SPI when the keyword is part of an experimental language feature.
  public var apiAttributes: AttributeListSyntax {
    let attrList = AttributeListSyntax {
      if isExperimental {
        let experimentalSPI: AttributeListSyntax = """
          #if compiler(>=5.8)
          @_spi(ExperimentalLanguageFeatures)
          #endif
          """
        experimentalSPI.with(\.trailingTrivia, .newline)
      }
    }
    return attrList.with(\.trailingTrivia, attrList.isEmpty ? [] : .newline)
  }

  /// Initializes a new `KeywordSpec` instance.
  ///
  /// - Parameters:
  ///   - name: A name of the keyword.
  ///   - experimentalFeature: The experimental feature the keyword is part of, or `nil` if this isn't for an experimental feature.
  ///   - isLexerClassified: Indicates if the token kind is switched from being an identifier to a keyword in the lexer.
  init(
    _ name: String,
    experimentalFeature: ExperimentalFeature? = nil,
    isLexerClassified: Bool = false
  ) {
    self.name = name
    self.experimentalFeature = experimentalFeature
    self.isLexerClassified = isLexerClassified
  }
}

public func keywordsByLength() -> [(Int, [KeywordSpec])] {
  var result: [Int: [KeywordSpec]] = [:]
  for keyword in Keyword.allCases.map(\.spec) {
    result[keyword.name.count, default: []].append(keyword)
  }
  return result.sorted(by: { $0.key < $1.key })
}

public func falseFriendKeywordsByLength() -> [(Int, [(Keyword.FalseFriend, KeywordSpec)])] {
  var result = [Int: [(Keyword.FalseFriend, KeywordSpec)]]()
  for keyword in Keyword.allCases {
    for falseFriend in keyword.falseFriends {
      result[falseFriend.text.utf8CodeUnitCount, default: []].append((falseFriend, keyword.spec))
    }
  }
  return result.sorted(by: { $0.key < $1.key })
}

public enum Keyword: CaseIterable {
  // Please keep these sorted alphabetically

  case __consuming
  case __owned
  case __setter_access
  case __shared
  case _alignment
  case _backDeploy
  case _borrow
  case _borrowing
  case _BridgeObject
  case _cdecl
  case _Class
  case _compilerInitialized
  case _const
  case _consuming
  case _documentation
  case _dynamicReplacement
  case _effects
  case _expose
  case _forward
  case _implements
  case _linear
  case _local
  case _modify
  case _move
  case _mutating
  case _NativeClass
  case _NativeRefCountedObject
  case _noMetadata
  case _nonSendable
  case _objcImplementation
  case _objcRuntimeName
  case _opaqueReturnTypeOf
  case _optimize
  case _originallyDefinedIn
  case _PackageDescription
  case _private
  case _projectedValueProperty
  case _read
  case _RefCountedObject
  case _semantics
  case _specialize
  case _spi
  case _spi_available
  case _swift_native_objc_runtime_base
  case _Trivial
  case _TrivialAtMost
  case _TrivialStride
  case _typeEraser
  case _unavailableFromAsync
  case _underlyingVersion
  case _UnknownLayout
  case _version
  case accesses
  case actor
  case addressWithNativeOwner
  case addressWithOwner
  case any
  case `Any`
  case `as`
  case assignment
  case `associatedtype`
  case associativity
  case async
  case attached
  case autoclosure
  case availability
  case available
  case await
  case backDeployed
  case before
  case block
  case borrowing
  case `break`
  case canImport
  case `case`
  case `catch`
  case `class`
  case compiler
  case consume
  case copy
  case consuming
  case `continue`
  case convenience
  case convention
  case cType
  case `default`
  case `defer`
  case `deinit`
  case dependsOn
  case deprecated
  case derivative
  case didSet
  case differentiable
  case distributed
  case `do`
  case dynamic
  case each
  case `else`
  case `enum`
  case escaping
  case exclusivity
  case exported
  case `extension`
  case `fallthrough`
  case `false`
  case file
  case `fileprivate`
  case final
  case `for`
  case discard
  case forward
  case `func`
  case freestanding
  case get
  case `guard`
  case higherThan
  case `if`
  case `import`
  case `in`
  case indirect
  case infix
  case `init`
  case initializes
  case inline
  case `inout`
  case `internal`
  case introduced
  case `is`
  case isolated
  case kind
  case lazy
  case left
  case `let`
  case line
  case linear
  case lowerThan
  case macro
  case message
  case metadata
  case module
  case mutableAddressWithNativeOwner
  case mutableAddressWithOwner
  case mutating
  case `nil`
  case noasync
  case noDerivative
  case noescape
  case none
  case nonisolated
  case nonmutating
  case objc
  case obsoleted
  case of
  case open
  case `operator`
  case optional
  case override
  case package
  case postfix
  case `precedencegroup`
  case preconcurrency
  case prefix
  case `private`
  case `Protocol`
  case `protocol`
  case `public`
  case reasync
  case renamed
  case `repeat`
  case required
  case `rethrows`
  case retroactive
  case `return`
  case reverse
  case right
  case safe
  case scoped
  case `self`
  case sending
  case `Self`
  case Sendable
  case set
  case some
  case sourceFile
  case spi
  case spiModule
  case `static`
  case `struct`
  case `subscript`
  case `super`
  case swift
  case `switch`
  case target
  case then
  case `throw`
  case `throws`
  case transpose
  case `true`
  case `try`
  case `Type`
  case `typealias`
  case unavailable
  case unchecked
  case unowned
  case unsafe
  case unsafeAddress
  case unsafeMutableAddress
  case `var`
  case visibility
  case weak
  case `where`
  case `while`
  case willSet
  case witness_method
  case wrt
  case yield

  public var spec: KeywordSpec {
    switch self {
    case .__consuming:
      return KeywordSpec("__consuming")
    case .__owned:
      return KeywordSpec("__owned")
    case .__setter_access:
      return KeywordSpec("__setter_access")
    case .__shared:
      return KeywordSpec("__shared")
    case ._alignment:
      return KeywordSpec("_alignment")
    case ._backDeploy:
      return KeywordSpec("_backDeploy")
    case ._borrow:
      return KeywordSpec("_borrow")
    case ._borrowing:
      return KeywordSpec("_borrowing")
    case ._BridgeObject:
      return KeywordSpec("_BridgeObject")
    case ._cdecl:
      return KeywordSpec("_cdecl")
    case ._Class:
      return KeywordSpec("_Class")
    case ._compilerInitialized:
      return KeywordSpec("_compilerInitialized")
    case ._const:
      return KeywordSpec("_const")
    case ._consuming:
      return KeywordSpec("_consuming", experimentalFeature: .referenceBindings)
    case ._documentation:
      return KeywordSpec("_documentation")
    case ._dynamicReplacement:
      return KeywordSpec("_dynamicReplacement")
    case ._effects:
      return KeywordSpec("_effects")
    case ._expose:
      return KeywordSpec("_expose")
    case ._forward:
      return KeywordSpec("_forward")
    case ._implements:
      return KeywordSpec("_implements")
    case ._linear:
      return KeywordSpec("_linear")
    case ._local:
      return KeywordSpec("_local")
    case ._modify:
      return KeywordSpec("_modify")
    case ._move:
      return KeywordSpec("_move")
    case ._mutating:
      return KeywordSpec("_mutating", experimentalFeature: .referenceBindings)
    case ._NativeClass:
      return KeywordSpec("_NativeClass")
    case ._NativeRefCountedObject:
      return KeywordSpec("_NativeRefCountedObject")
    case ._noMetadata:
      return KeywordSpec("_noMetadata")
    case ._nonSendable:
      return KeywordSpec("_nonSendable")
    case ._objcImplementation:
      return KeywordSpec("_objcImplementation")
    case ._objcRuntimeName:
      return KeywordSpec("_objcRuntimeName")
    case ._opaqueReturnTypeOf:
      return KeywordSpec("_opaqueReturnTypeOf")
    case ._optimize:
      return KeywordSpec("_optimize")
    case ._originallyDefinedIn:
      return KeywordSpec("_originallyDefinedIn")
    case ._PackageDescription:
      return KeywordSpec("_PackageDescription")
    case ._private:
      return KeywordSpec("_private")
    case ._projectedValueProperty:
      return KeywordSpec("_projectedValueProperty")
    case ._read:
      return KeywordSpec("_read")
    case ._RefCountedObject:
      return KeywordSpec("_RefCountedObject")
    case ._semantics:
      return KeywordSpec("_semantics")
    case ._specialize:
      return KeywordSpec("_specialize")
    case ._spi:
      return KeywordSpec("_spi")
    case ._spi_available:
      return KeywordSpec("_spi_available")
    case ._swift_native_objc_runtime_base:
      return KeywordSpec("_swift_native_objc_runtime_base")
    case ._Trivial:
      return KeywordSpec("_Trivial")
    case ._TrivialAtMost:
      return KeywordSpec("_TrivialAtMost")
    case ._TrivialStride:
      return KeywordSpec("_TrivialStride")
    case ._typeEraser:
      return KeywordSpec("_typeEraser")
    case ._unavailableFromAsync:
      return KeywordSpec("_unavailableFromAsync")
    case ._underlyingVersion:
      return KeywordSpec("_underlyingVersion")
    case ._UnknownLayout:
      return KeywordSpec("_UnknownLayout")
    case ._version:
      return KeywordSpec("_version")
    case .accesses:
      return KeywordSpec("accesses")
    case .actor:
      return KeywordSpec("actor")
    case .addressWithNativeOwner:
      return KeywordSpec("addressWithNativeOwner")
    case .addressWithOwner:
      return KeywordSpec("addressWithOwner")
    case .any:
      return KeywordSpec("any")
    case .Any:
      return KeywordSpec("Any", isLexerClassified: true)
    case .as:
      return KeywordSpec("as", isLexerClassified: true)
    case .assignment:
      return KeywordSpec("assignment")
    case .associatedtype:
      return KeywordSpec("associatedtype", isLexerClassified: true)
    case .associativity:
      return KeywordSpec("associativity")
    case .async:
      return KeywordSpec("async")
    case .attached:
      return KeywordSpec("attached")
    case .autoclosure:
      return KeywordSpec("autoclosure")
    case .availability:
      return KeywordSpec("availability")
    case .available:
      return KeywordSpec("available")
    case .await:
      return KeywordSpec("await")
    case .backDeployed:
      return KeywordSpec("backDeployed")
    case .before:
      return KeywordSpec("before")
    case .block:
      return KeywordSpec("block")
    case .borrowing:
      return KeywordSpec("borrowing")
    case .break:
      return KeywordSpec("break", isLexerClassified: true)
    case .canImport:
      return KeywordSpec("canImport")
    case .case:
      return KeywordSpec("case", isLexerClassified: true)
    case .catch:
      return KeywordSpec("catch", isLexerClassified: true)
    case .class:
      return KeywordSpec("class", isLexerClassified: true)
    case .compiler:
      return KeywordSpec("compiler")
    case .consume:
      return KeywordSpec("consume")
    case .copy:
      return KeywordSpec("copy")
    case .consuming:
      return KeywordSpec("consuming")
    case .continue:
      return KeywordSpec("continue", isLexerClassified: true)
    case .convenience:
      return KeywordSpec("convenience")
    case .convention:
      return KeywordSpec("convention")
    case .cType:
      return KeywordSpec("cType")
    case .default:
      return KeywordSpec("default", isLexerClassified: true)
    case .defer:
      return KeywordSpec("defer", isLexerClassified: true)
    case .deinit:
      return KeywordSpec("deinit", isLexerClassified: true)
    case .dependsOn:
      return KeywordSpec("dependsOn", experimentalFeature: .nonescapableTypes)
    case .deprecated:
      return KeywordSpec("deprecated")
    case .derivative:
      return KeywordSpec("derivative")
    case .didSet:
      return KeywordSpec("didSet")
    case .differentiable:
      return KeywordSpec("differentiable")
    case .distributed:
      return KeywordSpec("distributed")
    case .do:
      return KeywordSpec("do", isLexerClassified: true)
    case .dynamic:
      return KeywordSpec("dynamic")
    case .each:
      return KeywordSpec("each")
    case .else:
      return KeywordSpec("else", isLexerClassified: true)
    case .enum:
      return KeywordSpec("enum", isLexerClassified: true)
    case .escaping:
      return KeywordSpec("escaping")
    case .exclusivity:
      return KeywordSpec("exclusivity")
    case .exported:
      return KeywordSpec("exported")
    case .extension:
      return KeywordSpec("extension", isLexerClassified: true)
    case .fallthrough:
      return KeywordSpec("fallthrough", isLexerClassified: true)
    case .false:
      return KeywordSpec("false", isLexerClassified: true)
    case .file:
      return KeywordSpec("file")
    case .fileprivate:
      return KeywordSpec("fileprivate", isLexerClassified: true)
    case .final:
      return KeywordSpec("final")
    case .for:
      return KeywordSpec("for", isLexerClassified: true)
    case .discard:
      return KeywordSpec("discard")
    case .forward:
      return KeywordSpec("forward")
    case .func:
      return KeywordSpec("func", isLexerClassified: true)
    case .freestanding:
      return KeywordSpec("freestanding")
    case .get:
      return KeywordSpec("get")
    case .guard:
      return KeywordSpec("guard", isLexerClassified: true)
    case .higherThan:
      return KeywordSpec("higherThan")
    case .if:
      return KeywordSpec("if", isLexerClassified: true)
    case .import:
      return KeywordSpec("import", isLexerClassified: true)
    case .in:
      return KeywordSpec("in", isLexerClassified: true)
    case .indirect:
      return KeywordSpec("indirect")
    case .infix:
      return KeywordSpec("infix")
    case .`init`:
      return KeywordSpec("init", isLexerClassified: true)
    case .initializes:
      return KeywordSpec("initializes")
    case .inline:
      return KeywordSpec("inline")
    case .inout:
      return KeywordSpec("inout", isLexerClassified: true)
    case .internal:
      return KeywordSpec("internal", isLexerClassified: true)
    case .introduced:
      return KeywordSpec("introduced")
    case .is:
      return KeywordSpec("is", isLexerClassified: true)
    case .isolated:
      return KeywordSpec("isolated")
    case .kind:
      return KeywordSpec("kind")
    case .lazy:
      return KeywordSpec("lazy")
    case .left:
      return KeywordSpec("left")
    case .let:
      return KeywordSpec("let", isLexerClassified: true)
    case .line:
      return KeywordSpec("line")
    case .linear:
      return KeywordSpec("linear")
    case .lowerThan:
      return KeywordSpec("lowerThan")
    case .macro:
      return KeywordSpec("macro")
    case .message:
      return KeywordSpec("message")
    case .metadata:
      return KeywordSpec("metadata")
    case .module:
      return KeywordSpec("module")
    case .mutableAddressWithNativeOwner:
      return KeywordSpec("mutableAddressWithNativeOwner")
    case .mutableAddressWithOwner:
      return KeywordSpec("mutableAddressWithOwner")
    case .mutating:
      return KeywordSpec("mutating")
    case .nil:
      return KeywordSpec("nil", isLexerClassified: true)
    case .noasync:
      return KeywordSpec("noasync")
    case .noDerivative:
      return KeywordSpec("noDerivative")
    case .noescape:
      return KeywordSpec("noescape")
    case .none:
      return KeywordSpec("none")
    case .nonisolated:
      return KeywordSpec("nonisolated")
    case .nonmutating:
      return KeywordSpec("nonmutating")
    case .objc:
      return KeywordSpec("objc")
    case .obsoleted:
      return KeywordSpec("obsoleted")
    case .of:
      return KeywordSpec("of")
    case .open:
      return KeywordSpec("open")
    case .operator:
      return KeywordSpec("operator", isLexerClassified: true)
    case .optional:
      return KeywordSpec("optional")
    case .override:
      return KeywordSpec("override")
    case .package:
      return KeywordSpec("package")
    case .postfix:
      return KeywordSpec("postfix")
    case .precedencegroup:
      return KeywordSpec("precedencegroup", isLexerClassified: true)
    case .prefix:
      return KeywordSpec("prefix")
    case .private:
      return KeywordSpec("private", isLexerClassified: true)
    case .Protocol:
      return KeywordSpec("Protocol")
    case .protocol:
      return KeywordSpec("protocol", isLexerClassified: true)
    case .public:
      return KeywordSpec("public", isLexerClassified: true)
    case .reasync:
      return KeywordSpec("reasync")
    case .renamed:
      return KeywordSpec("renamed")
    case .repeat:
      return KeywordSpec("repeat", isLexerClassified: true)
    case .required:
      return KeywordSpec("required")
    case .rethrows:
      return KeywordSpec("rethrows", isLexerClassified: true)
    case .retroactive:
      return KeywordSpec("retroactive")
    case .return:
      return KeywordSpec("return", isLexerClassified: true)
    case .reverse:
      return KeywordSpec("reverse")
    case .right:
      return KeywordSpec("right")
    case .safe:
      return KeywordSpec("safe")
    case .scoped:
      return KeywordSpec("scoped", experimentalFeature: .nonescapableTypes)
    case .self:
      return KeywordSpec("self", isLexerClassified: true)
    case .Self:
      return KeywordSpec("Self", isLexerClassified: true)
    case .Sendable:
      return KeywordSpec("Sendable")
    case .set:
      return KeywordSpec("set")
    case .some:
      return KeywordSpec("some")
    case .sourceFile:
      return KeywordSpec("sourceFile")
    case .spi:
      return KeywordSpec("spi")
    case .spiModule:
      return KeywordSpec("spiModule")
    case .static:
      return KeywordSpec("static", isLexerClassified: true)
    case .struct:
      return KeywordSpec("struct", isLexerClassified: true)
    case .subscript:
      return KeywordSpec("subscript", isLexerClassified: true)
    case .super:
      return KeywordSpec("super", isLexerClassified: true)
    case .swift:
      return KeywordSpec("swift")
    case .switch:
      return KeywordSpec("switch", isLexerClassified: true)
    case .target:
      return KeywordSpec("target")
    case .then:
      return KeywordSpec("then")
    case .throw:
      return KeywordSpec("throw", isLexerClassified: true)
    case .throws:
      return KeywordSpec("throws", isLexerClassified: true)
    case .sending:
      return KeywordSpec(
        "sending",
        experimentalFeature: .sendingArgsAndResults
      )
    case .transpose:
      return KeywordSpec("transpose")
    case .true:
      return KeywordSpec("true", isLexerClassified: true)
    case .try:
      return KeywordSpec("try", isLexerClassified: true)
    case .Type:
      return KeywordSpec("Type")
    case .typealias:
      return KeywordSpec("typealias", isLexerClassified: true)
    case .unavailable:
      return KeywordSpec("unavailable")
    case .unchecked:
      return KeywordSpec("unchecked")
    case .preconcurrency:
      return KeywordSpec("preconcurrency")
    case .unowned:
      return KeywordSpec("unowned")
    case .unsafe:
      return KeywordSpec("unsafe")
    case .unsafeAddress:
      return KeywordSpec("unsafeAddress")
    case .unsafeMutableAddress:
      return KeywordSpec("unsafeMutableAddress")
    case .var:
      return KeywordSpec("var", isLexerClassified: true)
    case .visibility:
      return KeywordSpec("visibility")
    case .weak:
      return KeywordSpec("weak")
    case .where:
      return KeywordSpec("where", isLexerClassified: true)
    case .while:
      return KeywordSpec("while", isLexerClassified: true)
    case .willSet:
      return KeywordSpec("willSet")
    case .witness_method:
      return KeywordSpec("witness_method")
    case .wrt:
      return KeywordSpec("wrt")
    case .yield:
      return KeywordSpec("yield")
    }
  }

  public struct ProgrammingLanguages: OptionSet, Hashable, CustomStringConvertible {
    public let rawValue: Int

    public init(rawValue: Int) {
      self.rawValue = rawValue
    }

    public static let bash = ProgrammingLanguages(rawValue: 1 << 0)
    public static let c = ProgrammingLanguages(rawValue: 1 << 1)
    public static let cSharp = ProgrammingLanguages(rawValue: 1 << 2)
    public static let cxx = ProgrammingLanguages(rawValue: 1 << 3)
    public static let dart = ProgrammingLanguages(rawValue: 1 << 4)
    public static let go = ProgrammingLanguages(rawValue: 1 << 5)
    public static let java = ProgrammingLanguages(rawValue: 1 << 6)
    public static let javaScript = ProgrammingLanguages(rawValue: 1 << 7)
    public static let kotlin = ProgrammingLanguages(rawValue: 1 << 8)
    public static let objC = ProgrammingLanguages(rawValue: 1 << 9)
    public static let php = ProgrammingLanguages(rawValue: 1 << 10)
    public static let powerShell = ProgrammingLanguages(rawValue: 1 << 11)
    public static let python = ProgrammingLanguages(rawValue: 1 << 12)
    public static let ruby = ProgrammingLanguages(rawValue: 1 << 13)
    public static let rust = ProgrammingLanguages(rawValue: 1 << 14)
    public static let scala = ProgrammingLanguages(rawValue: 1 << 15)
    public static let typeScript = ProgrammingLanguages(rawValue: 1 << 16)
    public static let visualBasic = ProgrammingLanguages(rawValue: 1 << 17)
    public static let zig = ProgrammingLanguages(rawValue: 1 << 18)

    public static let cFamily: ProgrammingLanguages = [.c, .cxx, .objC]
    public static let ecmaScript: ProgrammingLanguages = [.javaScript, .typeScript]

    public static let descriptions: [(ProgrammingLanguages, String)] = [
      (.bash, "Bash"),
      (.c, "C"),
      (.cSharp, "C#"),
      (.cxx, "C++"),
      (.dart, "Dart"),
      (.go, "Go"),
      (.java, "Java"),
      (.javaScript, "JavaScript"),
      (.kotlin, "Kotlin"),
      (.objC, "Objective-C"),
      (.php, "PHP"),
      (.powerShell, "PowerShell"),
      (.python, "Python"),
      (.ruby, "Ruby"),
      (.rust, "Rust"),
      (.scala, "Scala"),
      (.typeScript, "TypeScript"),
      (.visualBasic, "Visual Basic"),
      (.zig, "Zig"),
    ]

    public var description: String {
      ProgrammingLanguages.descriptions.filter { language, _ in
        self.contains(language)
      }.map(\.1)
        .joined(separator: " / ")
    }
  }

  public enum FalseFriend: ExpressibleByStringLiteral {
    case mispelling(StaticString)
    case languages(StaticString, ProgrammingLanguages)

    public init(stringLiteral value: StaticString) {
      self = .mispelling(value)
    }

    public var text: StaticString {
      switch self {
      case .mispelling(let text), .languages(let text, _):
        return text
      }
    }

    public var remark: String {
      switch self {
      case .mispelling:
        return "misspelling"
      case .languages(_, let programmingLanguages):
        return "possible influences: \(programmingLanguages)"
      }
    }
  }

  public var falseFriends: [FalseFriend] {
    switch self {
    case .__consuming:
      return [
        "__consume",
        "__consumed",
      ]
    case .__owned:
      return [
        "__own",
        "__owning",
      ]
    case .__setter_access:
      return []
    case .__shared:
      return [
        "__sharing"
      ]
    case ._alignment:
      return [
        "_align",
        "_aligned",
      ]
    case ._backDeploy:
      return []
    case ._borrow:
      return [
        .mispelling("_borrowed"),
        .mispelling("_borrowing"),
      ]
    case ._borrowing:
      return [
        "_borrow",
        "_borrowed",
      ]
    case ._BridgeObject:
      return []
    case ._cdecl:
      return [
        "cdeclaration"
      ]
    case ._Class:
      return []
    case ._compilerInitialized:
      return []
    case ._const:
      return ["_final"]
    case ._consuming:
      return [
        "_consume",
        "_consumed",
      ]
    case ._documentation:
      return []
    case ._dynamicReplacement:
      return []
    case ._effects:
      return []
    case ._expose:
      return []
    case ._forward:
      return []
    case ._implements:
      return ["_extends"]
    case ._linear:
      return []
    case ._local:
      return []
    case ._modify:
      return []
    case ._move:
      return []
    case ._mutating:
      return [
        "_mutate",
        "_mutated",
      ]
    case ._NativeClass:
      return []
    case ._NativeRefCountedObject:
      return []
    case ._noMetadata:
      return []
    case ._nonSendable:
      return [
        "_noSend",
        "_nonSend",
        "_noSending",
        "_nonSending",
      ]
    case ._objcImplementation:
      return ["_objectiveCImplementation"]
    case ._objcRuntimeName:
      return ["_objectiveCRuntimeName"]
    case ._opaqueReturnTypeOf:
      return []
    case ._optimize:
      return []
    case ._originallyDefinedIn:
      return []
    case ._PackageDescription:
      return []
    case ._private:
      return []
    case ._projectedValueProperty:
      return []
    case ._read:
      return []
    case ._RefCountedObject:
      return []
    case ._semantics:
      return []
    case ._specialize:
      return []
    case ._spi:
      return []
    case ._spi_available:
      return []
    case ._swift_native_objc_runtime_base:
      return []
    case ._Trivial:
      return []
    case ._TrivialAtMost:
      return []
    case ._TrivialStride:
      return []
    case ._typeEraser:
      return []
    case ._unavailableFromAsync:
      return []
    case ._underlyingVersion:
      return []
    case ._UnknownLayout:
      return []
    case ._version:
      return []
    case .accesses:
      return []
    case .actor:
      return []
    case .addressWithNativeOwner:
      return []
    case .addressWithOwner:
      return []
    // FIXME: dyn => any?
    case .any:
      return [
        "dyn"  // Rust
      ]
    case .Any:
      return []
    case .as:
      return []
    case .assignment:
      return []
    case .associatedtype:
      return []
    case .associativity:
      return []
    case .async:
      return []
    case .attached:
      return [
        "attach",
        "attaching",
      ]
    case .autoclosure:
      return []
    case .availability:
      return []
    case .available:
      return []
    case .await:
      return []
    case .backDeployed:
      return []
    case .before:
      return []
    case .block:
      return []
    case .borrowing:
      return [
        "borrow",
        "borrowed",
      ]
    case .break:
      return []
    case .canImport:
      return []
    case .case:
      return []
    case .catch:
      return [
        .languages("except", .python),
        .languages("rescue", .ruby),
      ]
    case .class:
      return []
    case .compiler:
      return []
    case .consume:
      return ["consuming"]
    case .copy:
      return ["clone"]
    case .consuming:
      return [
        "consume",
        "consumed",
      ]
    case .continue:
      return [
        .languages("next", .ruby),
        "continuing",
      ]
    case .convenience:
      return ["convenient"]
    case .convention:
      return []
    case .cType:
      return []
    case .default:
      return []
    case .defer:
      return []
    case .deinit:
      return [
        .languages("dealloc", .objC)
      ]
    case .dependsOn:
      return []
    case .deprecated:
      return []
    case .derivative:
      return []
    case .didSet:
      return []
    case .differentiable:
      return []
    case .distributed:
      return ["distributing"]
    case .do:
      return []
    case .dynamic:
      return []
    case .each:
      return []
    // - TODO: 1-to-N
    case .else:
      return [
        .languages("elif", [.bash, .python]),
        .languages("elsif", .ruby),
        // FIXME: VB case-insensitive
        .languages("elseif", [.php, .powerShell, .visualBasic]),
      ]
    case .enum:
      return []
    case .escaping:
      return ["escape"]
    case .exclusivity:
      return []
    case .exported:
      return ["export"]
    case .extension:
      return [
        .languages("impl", .rust),
        // FIXME: partial => extension?
        .languages("partial", .cSharp),
      ]
    case .fallthrough:
      return []
    case .false:
      return [
        .languages("NO", .objC)
      ]
    case .file:
      return []
    case .fileprivate:
      return []
    // TODO: .final
    case .final:
      return []
    case .for:
      return [
        .languages("foreach", [.cSharp, .powerShell])
      ]
    case .discard:
      return []
    case .forward:
      return []
    case .func:
      // TODO: fun will be covered by Levenshtein Distance
      return [
        .languages("fn", [.rust, .zig]),
        .languages("def", [.python, .ruby, .rust, .scala]),
        // FIXME: VB case-insensitive
        .languages("sub", .visualBasic),
        // FIXME: VB case-insensitive
        .languages("function", [.ecmaScript, .visualBasic]),
      ]
    case .freestanding:
      return []
    case .get:
      return []
    case .guard:
      return [
        .languages("unless", .ruby)
      ]
    case .higherThan:
      return []
    case .if:
      return []
    case .import:
      return [
        .languages("include", .cFamily)
      ]
    case .in:
      return [
        // FIXME: : => in?
        .languages(":", [.cxx, .java])
      ]
    case .indirect:
      return []
    case .infix:
      return []
    case .`init`:
      return [
        .languages("constructor", [.ecmaScript, .kotlin])
      ]
    case .initializes:
      return []
    case .inline:
      return []
    case .inout:
      return [
        .languages("out", .cSharp),
        .languages("ref", .cSharp),
      ]
    case .internal:
      return [
        // FIXME: protected => internal?
        // FIXME: VB case-insensitive
        .languages("protected", [.cxx, .cSharp, .java, .kotlin, .php, .scala, .visualBasic])
      ]
    case .introduced:
      return []
    case .is:
      return [
        .languages("instanceof", [.ecmaScript, .java, .php])
      ]
    case .isolated:
      return ["isolating"]
    case .kind:
      return []
    case .lazy:
      return [
        .languages("late", .dart),
        .languages("lateinit", .kotlin),
      ]
    case .left:
      return []
    case .let:
      return [
        // FIXME: VB case-insensitive
        .languages("dim", .visualBasic),
        .languages("val", [.kotlin, .scala]),
        .languages("const", [.ecmaScript, .zig]),
        .languages("final", .dart),
        .languages("constexpr", .cxx),
      ]
    case .line:
      return []
    case .linear:
      return []
    case .lowerThan:
      return []
    case .macro:
      return []
    case .message:
      return []
    case .metadata:
      return []
    case .module:
      return [
        // FIXME: mod => module?
        .languages("mod", [.go, .rust])
      ]
    case .mutableAddressWithNativeOwner:
      return []
    case .mutableAddressWithOwner:
      return []
    case .mutating:
      return ["mutate"]
    case .nil:
      return [
        .languages("NaN", .ecmaScript),
        .languages("None", .python),
        .languages("null", [.cSharp, .java, .ecmaScript, .zig]),
        .languages("NULL", .cFamily),
        .languages("nullptr", .cxx),
        .languages("undefined", [.ecmaScript, .zig]),
      ]
    case .noasync:
      return []
    case .noDerivative:
      return []
    case .noescape:
      return ["noescaping"]
    case .none:
      return []
    case .nonisolated:
      return ["nonisolating"]
    case .nonmutating:
      return [
        .languages("const", .cxx),
        "nonmutate",
      ]
    case .objc:
      return ["objectiveC"]
    case .obsoleted:
      return []
    case .of:
      return []
    case .open:
      return []
    case .operator:
      return []
    case .optional:
      return []
    case .override:
      return []
    case .package:
      return []
    case .postfix:
      return []
    case .precedencegroup:
      return []
    case .preconcurrency:
      return []
    case .prefix:
      return []
    case .private:
      return []
    case .Protocol:
      return []
    case .protocol:
      return [
        .languages("trait", [.php, .rust, .scala]),
        .languages("interface", [.cSharp, .java, .php, .typeScript]),
        // FIXME: typeclass => protocol?
        .languages("typeclass", .scala),
      ]
    case .public:
      return [
        .languages("pub", [.rust, .zig]),
        // FIXME: VB case-insensitive
        .languages("friend", [.cxx, .visualBasic]),
      ]
    case .reasync:
      return []
    case .renamed:
      return []
    case .repeat:
      return []
    case .required:
      return []
    case .rethrows:
      return []
    case .retroactive:
      return []
    case .return:
      return []
    case .reverse:
      return []
    case .right:
      return []
    case .safe:
      return []
    case .scoped:
      return []
    case .self:
      return [
        .languages("this", [.cxx, .dart, .ecmaScript, .java, .kotlin, .scala])
      ]
    case .sending:
      return [
        "send",
        "sendable",
      ]
    case .Self:
      return []
    case .Sendable:
      return [
        "Send",
        "Sending",
      ]
    case .set:
      return []
    case .some:
      return []
    case .sourceFile:
      return []
    case .spi:
      return []
    case .spiModule:
      return []
    case .static:
      return []
    case .struct:
      return []
    case .subscript:
      return []
    case .super:
      return []
    case .swift:
      return []
    case .switch:
      return [
        .languages("when", .kotlin),
        .languages("match", .scala),
        // FIXME: VB case-insensitive
        .languages("select", .visualBasic),
      ]
    case .target:
      return []
    case .then:
      return []
    case .throw:
      return [
        .languages("raise", .python)
      ]
    case .throws:
      return []
    case .transpose:
      return []
    case .true:
      return [
        .languages("YES", .objC)
      ]
    case .try:
      return []
    case .Type:
      return [
        // FIXME: prototype => Type?
        .languages("prototype", .ecmaScript)
      ]
    case .typealias:
      return [
        .languages("type", [.go, .rust, .scala, .typeScript]),
        .languages("alias", .ruby),
        .languages("typedef", [.cFamily, .dart]),
      ]
    case .unavailable:
      return []
    case .unchecked:
      return []
    case .unowned:
      return []
    case .unsafe:
      return []
    case .unsafeAddress:
      return []
    case .unsafeMutableAddress:
      return []
    // FIXME: mut => var?
    case .var:
      return [
        .languages("mut", .rust)
      ]
    case .visibility:
      return []
    case .weak:
      return []
    case .where:
      return [
        .languages("when", .cSharp)
      ]
    case .while:
      return [
        .languages("until", .bash)
      ]
    case .willSet:
      return []
    case .witness_method:
      return []
    case .wrt:
      return []
    case .yield:
      return []
    }
  }
}
