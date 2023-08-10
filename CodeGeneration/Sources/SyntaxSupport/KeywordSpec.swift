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
  public var name: String

  /// If `true`, this is for an experimental language feature, and any public
  /// API generated should be SPI.
  public var isExperimental: Bool

  public var isLexerClassified: Bool
  public var requiresLeadingSpace: Bool
  public var requiresTrailingSpace: Bool

  public var escapedName: String {
    if isLexerClassified || name == "Type" || name == "Protocol" {
      return "`\(name)`"
    } else {
      return name
    }
  }

  /// Retrieve the attributes that should be printed on any API for the
  /// generated keyword.
  public var apiAttributes: AttributeListSyntax {
    guard isExperimental else { return "" }
    return AttributeListSyntax("@_spi(ExperimentalLanguageFeatures)").with(\.trailingTrivia, .newline)
  }

  /// `isLexerClassified` determines whether the token kind is switched from being an identifier to a keyword in the lexer.
  /// This is true for keywords that used to be considered non-contextual.
  init(_ name: String, isExperimental: Bool = false, isLexerClassified: Bool = false, requiresLeadingSpace: Bool = false, requiresTrailingSpace: Bool = false) {
    self.name = name
    self.isExperimental = isExperimental
    self.isLexerClassified = isLexerClassified
    self.requiresLeadingSpace = requiresLeadingSpace
    self.requiresTrailingSpace = requiresTrailingSpace
  }
}

public let KEYWORDS: [KeywordSpec] = [
  // Please keep these sorted alphabetically

  KeywordSpec("__consuming"),
  KeywordSpec("__owned"),
  KeywordSpec("__setter_access"),
  KeywordSpec("__shared"),
  KeywordSpec("_alignment"),
  KeywordSpec("_backDeploy"),
  KeywordSpec("_borrow"),
  KeywordSpec("_cdecl"),
  KeywordSpec("_Class"),
  KeywordSpec("_compilerInitialized"),
  KeywordSpec("_const"),
  KeywordSpec("_documentation"),
  KeywordSpec("_dynamicReplacement"),
  KeywordSpec("_effects"),
  KeywordSpec("_expose"),
  KeywordSpec("_forward"),
  KeywordSpec("_implements"),
  KeywordSpec("_linear"),
  KeywordSpec("_local"),
  KeywordSpec("_modify"),
  KeywordSpec("_move"),
  KeywordSpec("_NativeClass"),
  KeywordSpec("_NativeRefCountedObject"),
  KeywordSpec("_noMetadata"),
  KeywordSpec("_nonSendable"),
  KeywordSpec("_objcImplementation"),
  KeywordSpec("_objcRuntimeName"),
  KeywordSpec("_opaqueReturnTypeOf"),
  KeywordSpec("_optimize"),
  KeywordSpec("_originallyDefinedIn"),
  KeywordSpec("_PackageDescription"),
  KeywordSpec("_private"),
  KeywordSpec("_projectedValueProperty"),
  KeywordSpec("_read"),
  KeywordSpec("_RefCountedObject"),
  KeywordSpec("_semantics"),
  KeywordSpec("_specialize"),
  KeywordSpec("_spi"),
  KeywordSpec("_spi_available"),
  KeywordSpec("_swift_native_objc_runtime_base"),
  KeywordSpec("_Trivial"),
  KeywordSpec("_TrivialAtMost"),
  KeywordSpec("_typeEraser"),
  KeywordSpec("_unavailableFromAsync"),
  KeywordSpec("_underlyingVersion"),
  KeywordSpec("_UnknownLayout"),
  KeywordSpec("_version"),
  KeywordSpec("accesses"),
  KeywordSpec("actor"),
  KeywordSpec("addressWithNativeOwner"),
  KeywordSpec("addressWithOwner"),
  KeywordSpec("any"),
  KeywordSpec("Any", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("as", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("assignment"),
  KeywordSpec("associatedtype", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("associativity"),
  KeywordSpec("async", requiresTrailingSpace: true),
  KeywordSpec("attached"),
  KeywordSpec("autoclosure"),
  KeywordSpec("availability"),
  KeywordSpec("available"),
  KeywordSpec("await", requiresTrailingSpace: true),
  KeywordSpec("backDeployed"),
  KeywordSpec("before"),
  KeywordSpec("block"),
  KeywordSpec("borrowing"),
  KeywordSpec("break", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("canImport"),
  KeywordSpec("case", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("catch", isLexerClassified: true, requiresLeadingSpace: true),
  KeywordSpec("class", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("compiler"),
  KeywordSpec("consume"),
  KeywordSpec("copy"),
  KeywordSpec("consuming"),
  KeywordSpec("continue", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("convenience"),
  KeywordSpec("convention"),
  KeywordSpec("cType"),
  KeywordSpec("default", isLexerClassified: true),
  KeywordSpec("defer", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("deinit", isLexerClassified: true),
  KeywordSpec("deprecated"),
  KeywordSpec("derivative"),
  KeywordSpec("didSet"),
  KeywordSpec("differentiable"),
  KeywordSpec("distributed"),
  KeywordSpec("do", isLexerClassified: true),
  KeywordSpec("dynamic"),
  KeywordSpec("each"),
  KeywordSpec("else", isLexerClassified: true, requiresLeadingSpace: true, requiresTrailingSpace: true),
  KeywordSpec("enum", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("escaping"),
  KeywordSpec("exclusivity"),
  KeywordSpec("exported"),
  KeywordSpec("extension", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("fallthrough", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("false", isLexerClassified: true),
  KeywordSpec("file"),
  KeywordSpec("fileprivate", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("final"),
  KeywordSpec("for", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("_forget"),  // NOTE: support for deprecated _forget
  KeywordSpec("discard"),
  KeywordSpec("forward"),
  KeywordSpec("func", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("get"),
  KeywordSpec("guard", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("higherThan"),
  KeywordSpec("if", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("import", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("in", isLexerClassified: true, requiresLeadingSpace: true, requiresTrailingSpace: true),
  KeywordSpec("indirect"),
  KeywordSpec("infix"),
  KeywordSpec("init", isLexerClassified: true),
  KeywordSpec("initializes"),
  KeywordSpec("inline"),
  KeywordSpec("inout", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("internal", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("introduced"),
  KeywordSpec("is", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("isolated"),
  KeywordSpec("kind"),
  KeywordSpec("lazy"),
  KeywordSpec("left"),
  KeywordSpec("let", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("line"),
  KeywordSpec("linear"),
  KeywordSpec("lowerThan"),
  KeywordSpec("macro"),
  KeywordSpec("message"),
  KeywordSpec("metadata"),
  KeywordSpec("module"),
  KeywordSpec("mutableAddressWithNativeOwner"),
  KeywordSpec("mutableAddressWithOwner"),
  KeywordSpec("mutating"),
  KeywordSpec("nil", isLexerClassified: true),
  KeywordSpec("noasync"),
  KeywordSpec("noDerivative"),
  KeywordSpec("noescape"),
  KeywordSpec("none"),
  KeywordSpec("nonisolated"),
  KeywordSpec("nonmutating"),
  KeywordSpec("objc"),
  KeywordSpec("obsoleted"),
  KeywordSpec("of"),
  KeywordSpec("open"),
  KeywordSpec("operator", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("optional"),
  KeywordSpec("override"),
  KeywordSpec("package"),
  KeywordSpec("postfix"),
  KeywordSpec("precedencegroup", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("prefix"),
  KeywordSpec("private", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("Protocol"),
  KeywordSpec("protocol", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("public", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("reasync"),
  KeywordSpec("renamed"),
  KeywordSpec("repeat", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("required"),
  KeywordSpec("rethrows", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("return", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("reverse"),
  KeywordSpec("right"),
  KeywordSpec("safe"),
  KeywordSpec("self", isLexerClassified: true),
  KeywordSpec("Self", isLexerClassified: true),
  KeywordSpec("Sendable"),
  KeywordSpec("set"),
  KeywordSpec("some"),
  KeywordSpec("sourceFile"),
  KeywordSpec("spi"),
  KeywordSpec("spiModule"),
  KeywordSpec("static", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("struct", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("subscript", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("super", isLexerClassified: true),
  KeywordSpec("swift"),
  KeywordSpec("switch", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("target"),
  KeywordSpec("throw", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("throws", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("transpose"),
  KeywordSpec("true", isLexerClassified: true),
  KeywordSpec("try", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("Type"),
  KeywordSpec("typealias", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("unavailable"),
  KeywordSpec("unchecked"),
  KeywordSpec("unowned"),
  KeywordSpec("unsafe"),
  KeywordSpec("unsafeAddress"),
  KeywordSpec("unsafeMutableAddress"),
  KeywordSpec("var", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("visibility"),
  KeywordSpec("weak"),
  KeywordSpec("where", isLexerClassified: true, requiresLeadingSpace: true, requiresTrailingSpace: true),
  KeywordSpec("while", isLexerClassified: true, requiresTrailingSpace: true),
  KeywordSpec("willSet"),
  KeywordSpec("witness_method"),
  KeywordSpec("wrt"),
  KeywordSpec("yield"),
]

public func keywordsByLength() -> [(Int, [KeywordSpec])] {
  var result: [Int: [KeywordSpec]] = [:]
  for keyword in KEYWORDS {
    result[keyword.name.count, default: []].append(keyword)
  }
  return result.sorted(by: { $0.key < $1.key })
}
