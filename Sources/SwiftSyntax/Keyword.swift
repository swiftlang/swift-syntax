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

/// Make `StaticString` equatable so we can use it as the raw value for Keyword.
extension StaticString: Equatable {
  public static func == (lhs: StaticString, rhs: StaticString) -> Bool {
    return SyntaxText(lhs) == SyntaxText(rhs)
  }
}

@frozen  // FIXME: Not actually stable, works around a miscompile
public enum Keyword: StaticString, Hashable {
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
    return SyntaxText(self.rawValue)
  }
}
