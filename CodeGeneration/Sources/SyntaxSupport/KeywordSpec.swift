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
  public let experimentalFeature2: ExperimentalFeature?

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
    guard isExperimental else { return "" }
    return AttributeListSyntax("@_spi(ExperimentalLanguageFeatures)").with(\.trailingTrivia, .newline)
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
    self.experimentalFeature2 = nil
    self.isLexerClassified = isLexerClassified
  }

  /// Initializes a new `KeywordSpec` instance.
  ///
  /// - Parameters:
  ///   - name: A name of the keyword.
  ///   - experimentalFeature: The experimental feature the keyword is part of, or `nil` if this isn't for an experimental feature.
  ///   - or: A second experimental feature the keyword is also part of, or `nil` if this isn't for an experimental feature.
  ///   - isLexerClassified: Indicates if the token kind is switched from being an identifier to a keyword in the lexer.
  init(
    _ name: String,
    experimentalFeature: ExperimentalFeature,
    or experimentalFeature2: ExperimentalFeature,
    isLexerClassified: Bool = false
  ) {
    self.name = name
    self.experimentalFeature = experimentalFeature
    self.experimentalFeature2 = experimentalFeature2
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
  case _consume
  case _consuming
  case _copy
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
  case _mutate
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
  case _resultDependsOn
  case _resultDependsOnSelf
  case `rethrows`
  case retroactive
  case `return`
  case reverse
  case right
  case safe
  case `self`
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
  case transferring
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
      return KeywordSpec("_borrowing", experimentalFeature: .referenceBindings, or: .borrowingSwitch)
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
    case ._consume:
      return KeywordSpec("_consume", experimentalFeature: .nonescapableTypes)
    case ._consuming:
      return KeywordSpec("_consuming", experimentalFeature: .referenceBindings)
    case ._copy:
      return KeywordSpec("_copy", experimentalFeature: .nonescapableTypes)
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
    case ._mutate:
      return KeywordSpec("_mutate", experimentalFeature: .nonescapableTypes)
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
    case ._resultDependsOn:
      return KeywordSpec("_resultDependsOn", experimentalFeature: .nonescapableTypes)
    case ._resultDependsOnSelf:
      return KeywordSpec("_resultDependsOnSelf", experimentalFeature: .nonescapableTypes)
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
    case .transferring:
      return KeywordSpec(
        "transferring",
        experimentalFeature: .transferringArgsAndResults
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
}
