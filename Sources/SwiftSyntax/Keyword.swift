//===--------------------------- Keyword.swift ----------------------------===//
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

@frozen  // FIXME: Not actually stable, works around a miscompile
public enum Keyword: Hashable {
  case `__consuming`
  case `__objc_bridged`
  case `__owned`
  case `__raw_doc_comment`
  case `__setter_access`
  case `__shared`
  case `__synthesized_protocol`
  case `_alignment`
  case `_alwaysEmitConformanceMetadata`
  case `_alwaysEmitIntoClient`
  case `_assemblyVision`
  case `_backDeploy`
  case `_borrow`
  case `_borrowed`
  case `_PackageDescription`
  case `_cdecl`
  case `_clangImporterSynthesizedType`
  case `_Class`
  case `_compilerInitialized`
  case `_const`
  case `_custom`
  case `_disfavoredOverload`
  case `_documentation`
  case `_dynamicReplacement`
  case `_eagerMove`
  case `_effects`
  case `_exported`
  case `_expose`
  case `_fixed_layout`
  case `_forbidSerializingReference`
  case `_forward`
  case `_frozen`
  case `_hasInitialValue`
  case `_hasMissingDesignatedInitializers`
  case `_hasStorage`
  case `_implementationOnly`
  case `_implements`
  case `_implicitSelfCapture`
  case `_inheritActorContext`
  case `_inheritsConvenienceInitializers`
  case `_linear`
  case `_local`
  case `_marker`
  case `_modify`
  case `_move`
  case `_moveOnly`
  case `_NativeClass`
  case `_NativeRefCountedObject`
  case `_noAllocation`
  case `_noEagerMove`
  case `_noImplicitCopy`
  case `_noLocks`
  case `_noMetadata`
  case `_nonEphemeral`
  case `_nonoverride`
  case `_nonSendable`
  case `_objc_non_lazy_realization`
  case `_objcImplementation`
  case `_objcRuntimeName`
  case `_opaqueReturnTypeOf`
  case `_optimize`
  case `_originallyDefinedIn`
  case `_private`
  case `_projectedValueProperty`
  case `_read`
  case `_RefCountedObject`
  case `_restatedObjCConformance`
  case `_semantics`
  case `_show_in_interface`
  case `_silgen_name`
  case `_specialize`
  case `_specializeExtension`
  case `_spi`
  case `_spi_available`
  case `_spiOnly`
  case `_staticInitializeObjCMetadata`
  case `_swift_native_objc_runtime_base`
  case `_transparent`
  case `_Trivial`
  case `_TrivialAtMost`
  case `_typeEraser`
  case `_unavailableFromAsync`
  case `_UnknownLayout`
  case `_unsafeInheritExecutor`
  case `_weakLinked`
  case `actor`
  case `addressWithNativeOwner`
  case `addressWithOwner`
  case `any`
  case `assignment`
  case `associativity`
  case `async`
  case `autoclosure`
  case `availability`
  case `available`
  case `await`
  case `Protocol`
  case `Type`
  case `convenience`
  case `convention`
  case `deprecated`
  case `derivative`
  case `didSet`
  case `differentiable`
  case `discardableResult`
  case `distributed`
  case `dynamic`
  case `dynamicCallable`
  case `dynamicMemberLookup`
  case `each`
  case `escaping`
  case `exclusivity`
  case `exported`
  case `final`
  case `frozen`
  case `get`
  case `GKInspectable`
  case `globalActor`
  case `higherThan`
  case `IBAction`
  case `IBDesignable`
  case `IBInspectable`
  case `IBOutlet`
  case `IBSegueAction`
  case `indirect`
  case `infix`
  case `inlinable`
  case `inline`
  case `introduced`
  case `isolated`
  case `kind`
  case `lazy`
  case `LLDBDebuggerFunction`
  case `lowerThan`
  case `macro`
  case `main`
  case `message`
  case `mutableAddressWithNativeOwner`
  case `mutableAddressWithOwner`
  case `mutating`
  case `noasync`
  case `noDerivative`
  case `noescape`
  case `nonisolated`
  case `nonmutating`
  case `nonobjc`
  case `NSApplicationMain`
  case `NSCopying`
  case `NSManaged`
  case `objc`
  case `objcMembers`
  case `obsoleted`
  case `of`
  case `open`
  case `optional`
  case `override`
  case `package`
  case `postfix`
  case `preconcurrency`
  case `prefix`
  case `propertyWrapper`
  case `reasync`
  case `renamed`
  case `required`
  case `requires_stored_property_inits`
  case `resultBuilder`
  case `rethrows`
  case `reverse`
  case `runtimeMetadata`
  case `safe`
  case `Sendable`
  case `set`
  case `some`
  case `spi`
  case `spiModule`
  case `static`
  case `swift`
  case `target`
  case `testable`
  case `transpose`
  case `typeWrapper`
  case `typeWrapperIgnored`
  case `UIApplicationMain`
  case `unavailable`
  case `unchecked`
  case `unowned`
  case `unsafe`
  case `unsafe_no_objc_tagged_pointer`
  case `unsafeAddress`
  case `unsafeMutableAddress`
  case `usableFromInline`
  case `warn_unqualified_access`
  case `weak`
  case `willSet`
  case `witness_method`
  case `wrt`
  case `yield`

  var defaultText: SyntaxText {
    switch self {
    case .__consuming: return "__consuming"
    case .__objc_bridged: return "__objc_bridged"
    case .__owned: return "__owned"
    case .__raw_doc_comment: return "__raw_doc_comment"
    case .__setter_access: return "__setter_access"
    case .__shared: return "__shared"
    case .__synthesized_protocol: return "__synthesized_protocol"
    case ._alignment: return "_alignment"
    case ._alwaysEmitConformanceMetadata: return "_alwaysEmitConformanceMetadata"
    case ._alwaysEmitIntoClient: return "_alwaysEmitIntoClient"
    case ._assemblyVision: return "_assemblyVision"
    case ._backDeploy: return "_backDeploy"
    case ._borrow: return "_borrow"
    case ._borrowed: return "_borrowed"
    case ._PackageDescription: return "_PackageDescription"
    case ._cdecl: return "_cdecl"
    case ._clangImporterSynthesizedType: return "_clangImporterSynthesizedType"
    case ._Class: return "_Class"
    case ._compilerInitialized: return "_compilerInitialized"
    case ._const: return "_const"
    case ._custom: return "_custom"
    case ._disfavoredOverload: return "_disfavoredOverload"
    case ._documentation: return "_documentation"
    case ._dynamicReplacement: return "_dynamicReplacement"
    case ._eagerMove: return "_eagerMove"
    case ._effects: return "_effects"
    case ._exported: return "_exported"
    case ._expose: return "_expose"
    case ._fixed_layout: return "_fixed_layout"
    case ._forbidSerializingReference: return "_forbidSerializingReference"
    case ._forward: return "_forward"
    case ._frozen: return "_frozen"
    case ._hasInitialValue: return "_hasInitialValue"
    case ._hasMissingDesignatedInitializers: return "_hasMissingDesignatedInitializers"
    case ._hasStorage: return "_hasStorage"
    case ._implementationOnly: return "_implementationOnly"
    case ._implements: return "_implements"
    case ._implicitSelfCapture: return "_implicitSelfCapture"
    case ._inheritActorContext: return "_inheritActorContext"
    case ._inheritsConvenienceInitializers: return "_inheritsConvenienceInitializers"
    case ._linear: return "_linear"
    case ._local: return "_local"
    case ._marker: return "_marker"
    case ._modify: return "_modify"
    case ._move: return "_move"
    case ._moveOnly: return "_moveOnly"
    case ._NativeClass: return "_NativeClass"
    case ._NativeRefCountedObject: return "_NativeRefCountedObject"
    case ._noAllocation: return "_noAllocation"
    case ._noEagerMove: return "_noEagerMove"
    case ._noImplicitCopy: return "_noImplicitCopy"
    case ._noLocks: return "_noLocks"
    case ._noMetadata: return "_noMetadata"
    case ._nonEphemeral: return "_nonEphemeral"
    case ._nonoverride: return "_nonoverride"
    case ._nonSendable: return "_nonSendable"
    case ._objc_non_lazy_realization: return "_objc_non_lazy_realization"
    case ._objcImplementation: return "_objcImplementation"
    case ._objcRuntimeName: return "_objcRuntimeName"
    case ._opaqueReturnTypeOf: return "_opaqueReturnTypeOf"
    case ._optimize: return "_optimize"
    case ._originallyDefinedIn: return "_originallyDefinedIn"
    case ._private: return "_private"
    case ._projectedValueProperty: return "_projectedValueProperty"
    case ._read: return "_read"
    case ._RefCountedObject: return "_RefCountedObject"
    case ._restatedObjCConformance: return "_restatedObjCConformance"
    case ._semantics: return "_semantics"
    case ._show_in_interface: return "_show_in_interface"
    case ._silgen_name: return "_silgen_name"
    case ._specialize: return "_specialize"
    case ._specializeExtension: return "_specializeExtension"
    case ._spi: return "_spi"
    case ._spi_available: return "_spi_available"
    case ._spiOnly: return "_spiOnly"
    case ._staticInitializeObjCMetadata: return "_staticInitializeObjCMetadata"
    case ._swift_native_objc_runtime_base: return "_swift_native_objc_runtime_base"
    case ._transparent: return "_transparent"
    case ._Trivial: return "_Trivial"
    case ._TrivialAtMost: return "_TrivialAtMost"
    case ._typeEraser: return "_typeEraser"
    case ._unavailableFromAsync: return "_unavailableFromAsync"
    case ._UnknownLayout: return "_UnknownLayout"
    case ._unsafeInheritExecutor: return "_unsafeInheritExecutor"
    case ._weakLinked: return "_weakLinked"
    case .actor: return "actor"
    case .addressWithNativeOwner: return "addressWithNativeOwner"
    case .addressWithOwner: return "addressWithOwner"
    case .any: return "any"
    case .assignment: return "assignment"
    case .associativity: return "associativity"
    case .async: return "async"
    case .autoclosure: return "autoclosure"
    case .availability: return "availability"
    case .available: return "available"
    case .await: return "await"
    case .Protocol: return "Protocol"
    case .Type: return "Type"
    case .convenience: return "convenience"
    case .convention: return "convention"
    case .deprecated: return "deprecated"
    case .derivative: return "derivative"
    case .didSet: return "didSet"
    case .differentiable: return "differentiable"
    case .discardableResult: return "discardableResult"
    case .distributed: return "distributed"
    case .dynamic: return "dynamic"
    case .dynamicCallable: return "dynamicCallable"
    case .dynamicMemberLookup: return "dynamicMemberLookup"
    case .each: return "each"
    case .escaping: return "escaping"
    case .exclusivity: return "exclusivity"
    case .exported: return "exported"
    case .final: return "final"
    case .frozen: return "frozen"
    case .get: return "get"
    case .GKInspectable: return "GKInspectable"
    case .globalActor: return "globalActor"
    case .higherThan: return "higherThan"
    case .IBAction: return "IBAction"
    case .IBDesignable: return "IBDesignable"
    case .IBInspectable: return "IBInspectable"
    case .IBOutlet: return "IBOutlet"
    case .IBSegueAction: return "IBSegueAction"
    case .indirect: return "indirect"
    case .infix: return "infix"
    case .inlinable: return "inlinable"
    case .inline: return "inline"
    case .introduced: return "introduced"
    case .isolated: return "isolated"
    case .kind: return "kind"
    case .lazy: return "lazy"
    case .LLDBDebuggerFunction: return "LLDBDebuggerFunction"
    case .lowerThan: return "lowerThan"
    case .macro: return "macro"
    case .main: return "main"
    case .message: return "message"
    case .mutableAddressWithNativeOwner: return "mutableAddressWithNativeOwner"
    case .mutableAddressWithOwner: return "mutableAddressWithOwner"
    case .mutating: return "mutating"
    case .noasync: return "noasync"
    case .noDerivative: return "noDerivative"
    case .noescape: return "noescape"
    case .nonisolated: return "nonisolated"
    case .nonmutating: return "nonmutating"
    case .nonobjc: return "nonobjc"
    case .NSApplicationMain: return "NSApplicationMain"
    case .NSCopying: return "NSCopying"
    case .NSManaged: return "NSManaged"
    case .objc: return "objc"
    case .objcMembers: return "objcMembers"
    case .obsoleted: return "obsoleted"
    case .of: return "of"
    case .open: return "open"
    case .optional: return "optional"
    case .override: return "override"
    case .package: return "package"
    case .postfix: return "postfix"
    case .preconcurrency: return "preconcurrency"
    case .prefix: return "prefix"
    case .propertyWrapper: return "propertyWrapper"
    case .reasync: return "reasync"
    case .renamed: return "renamed"
    case .required: return "required"
    case .requires_stored_property_inits: return "requires_stored_property_inits"
    case .resultBuilder: return "resultBuilder"
    case .rethrows: return "rethrows"
    case .reverse: return "reverse"
    case .runtimeMetadata: return "runtimeMetadata"
    case .safe: return "safe"
    case .Sendable: return "Sendable"
    case .set: return "set"
    case .some: return "some"
    case .spi: return "spi"
    case .spiModule: return "spiModule"
    case .static: return "static"
    case .swift: return "swift"
    case .target: return "target"
    case .testable: return "testable"
    case .transpose: return "transpose"
    case .typeWrapper: return "typeWrapper"
    case .typeWrapperIgnored: return "typeWrapperIgnored"
    case .UIApplicationMain: return "UIApplicationMain"
    case .unavailable: return "unavailable"
    case .unchecked: return "unchecked"
    case .unowned: return "unowned"
    case .unsafe: return "unsafe"
    case .unsafe_no_objc_tagged_pointer: return "unsafe_no_objc_tagged_pointer"
    case .unsafeAddress: return "unsafeAddress"
    case .unsafeMutableAddress: return "unsafeMutableAddress"
    case .usableFromInline: return "usableFromInline"
    case .warn_unqualified_access: return "warn_unqualified_access"
    case .weak: return "weak"
    case .willSet: return "willSet"
    case .witness_method: return "witness_method"
    case .wrt: return "wrt"
    case .yield: return "yield"
    }
  }
}
