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

public class Attribute {
  public let name: String
  public let swiftName: String

  public init(name: String, swiftName: String? = nil) {
    self.name = name
    self.swiftName = swiftName ?? name
  }
}

public class TypeAttribute: Attribute {
  public init(name: String) {
    super.init(name: name)
  }
}

public class DeclAttribute: Attribute {
  public let className: String

  public init(name: String, className: String, swiftName: String? = nil) {
    self.className = className
    super.init(name: name, swiftName: swiftName)
  }
}

public class SimpleDeclAttribute: DeclAttribute {}

public class ContextualDeclAttribute: DeclAttribute {
  public init(name: String, className: String) {
    super.init(name: name, className: className)
  }
}

public class ContextualSimpleDeclAttribute: SimpleDeclAttribute {
  public init(name: String, className: String) {
    super.init(name: name, className: className)
  }
}

public class DeclAttributeAlias: Attribute {
  public let className: String

  public init(name: String, className: String, swiftName: String? = nil) {
    self.className = className
    super.init(name: name, swiftName: swiftName)

  }
}

public class ContextualDeclAttributeAlias: DeclAttributeAlias {}

public class BuiltinDeclModifier: Attribute {}

// Type attributes
public let TYPE_ATTR_KINDS = [
  TypeAttribute(name: "autoclosure"),
  TypeAttribute(name: "convention"),
  TypeAttribute(name: "noescape"),
  TypeAttribute(name: "escaping"),
  TypeAttribute(name: "differentiable"),
  TypeAttribute(name: "noDerivative"),
  TypeAttribute(name: "async"),
  TypeAttribute(name: "Sendable"),
  TypeAttribute(name: "unchecked"),
  TypeAttribute(name: "_local"),
  TypeAttribute(name: "_noMetadata"),
  TypeAttribute(name: "_opaqueReturnTypeOf"),
]

// Schema for `DeclAttribute`s:
//
// - Attribute name.
// - C++ class name without the 'Attr' suffix
// - Options for the attribute, including:
//    * the declarations the attribute can appear on
//    * whether duplicates are allowed
// - Unique attribute identifier used for serialization. This
//   can never be changed.
//
// SimpleDeclAttribute is the same, but the class becomes
// SimpleDeclAttr<DAK_##NAME> on the C++ side.
//
// Please help ease code review/audits:
// - Please place the "OnXYZ" flags together on the next line.
// - Please place the non-OnXYZ flags together on the next to last line.
// - Please place the unique code number on the last line.
// - Please sort attributes by serialization number.
// - Please create a "NOTE" comment if a unique number is skipped.
//
// If you're adding a new kind of "attribute" that is spelled without a leading
// '@' symbol, add an entry to the `DECL_MODIFIER_KINDS` array instead.
//
// If you're adding a new underscored attribute here, please document it in
// docs/ReferenceGuides/UnderscoredAttributes.md.
public let DECL_ATTR_KINDS: [Attribute] = [
  DeclAttribute(
    name: "_silgen_name",
    className: "SILGenName",
    swiftName: "_silgen_name"
  ),
  DeclAttribute(
    name: "available",
    className: "Available",
    swiftName: "available"
  ),
  DeclAttribute(
    name: "objc",
    className: "ObjC",
    swiftName: "objc"
  ),
  SimpleDeclAttribute(
    name: "dynamicCallable",
    className: "DynamicCallable",
    swiftName: "dynamicCallable"
  ),
  DeclAttribute(
    name: "main",
    className: "MainType",
    swiftName: "main"
  ),
  SimpleDeclAttribute(
    name: "_exported",
    className: "Exported",
    swiftName: "_exported"
  ),
  SimpleDeclAttribute(
    name: "dynamicMemberLookup",
    className: "DynamicMemberLookup",
    swiftName: "dynamicMemberLookup"
  ),
  SimpleDeclAttribute(
    name: "NSCopying",
    className: "NSCopying",
    swiftName: "NSCopying"
  ),
  SimpleDeclAttribute(
    name: "IBAction",
    className: "IBAction",
    swiftName: "IBAction"
  ),
  SimpleDeclAttribute(
    name: "IBDesignable",
    className: "IBDesignable",
    swiftName: "IBDesignable"
  ),
  SimpleDeclAttribute(
    name: "IBInspectable",
    className: "IBInspectable",
    swiftName: "IBInspectable"
  ),
  SimpleDeclAttribute(
    name: "IBOutlet",
    className: "IBOutlet",
    swiftName: "IBOutlet"
  ),
  SimpleDeclAttribute(
    name: "NSManaged",
    className: "NSManaged",
    swiftName: "NSManaged"
  ),
  SimpleDeclAttribute(
    name: "LLDBDebuggerFunction",
    className: "LLDBDebuggerFunction",
    swiftName: "LLDBDebuggerFunction"
  ),
  SimpleDeclAttribute(
    name: "UIApplicationMain",
    className: "UIApplicationMain",
    swiftName: "UIApplicationMain"
  ),
  SimpleDeclAttribute(
    name: "unsafe_no_objc_tagged_pointer",
    className: "UnsafeNoObjCTaggedPointer",
    swiftName: "unsafe_no_objc_tagged_pointer"
  ),
  DeclAttribute(
    name: "inline",
    className: "Inline",
    swiftName: "inline"
  ),
  DeclAttribute(
    name: "_semantics",
    className: "Semantics",
    swiftName: "_semantics"
  ),
  SimpleDeclAttribute(
    name: "_transparent",
    className: "Transparent",
    swiftName: "_transparent"
  ),
  SimpleDeclAttribute(
    name: "requires_stored_property_inits",
    className: "RequiresStoredPropertyInits",
    swiftName: "requires_stored_property_inits"
  ),
  SimpleDeclAttribute(
    name: "nonobjc",
    className: "NonObjC",
    swiftName: "nonobjc"
  ),
  SimpleDeclAttribute(
    name: "_fixed_layout",
    className: "FixedLayout",
    swiftName: "_fixed_layout"
  ),
  SimpleDeclAttribute(
    name: "inlinable",
    className: "Inlinable",
    swiftName: "inlinable"
  ),
  DeclAttribute(
    name: "_specialize",
    className: "Specialize",
    swiftName: "_specialize"
  ),
  SimpleDeclAttribute(
    name: "objcMembers",
    className: "ObjCMembers",
    swiftName: "objcMembers"
  ),
  ContextualSimpleDeclAttribute(
    name: "_compilerInitialized",
    className: "CompilerInitialized"
  ),
  SimpleDeclAttribute(
    name: "_hasStorage",
    className: "HasStorage",
    swiftName: "_hasStorage"
  ),
  DeclAttribute(
    name: "__raw_doc_comment",
    className: "RawDocComment",
    swiftName: "__raw_doc_comment"
  ),
  DeclAttribute(
    name: "_effects",
    className: "Effects",
    swiftName: "_effects"
  ),
  DeclAttribute(
    name: "__objc_bridged",
    className: "ObjCBridged",
    swiftName: "__objc_bridged"
  ),
  SimpleDeclAttribute(
    name: "NSApplicationMain",
    className: "NSApplicationMain",
    swiftName: "NSApplicationMain"
  ),
  SimpleDeclAttribute(
    name: "_objc_non_lazy_realization",
    className: "ObjCNonLazyRealization",
    swiftName: "_objc_non_lazy_realization"
  ),
  DeclAttribute(
    name: "__synthesized_protocol",
    className: "SynthesizedProtocol",
    swiftName: "__synthesized_protocol"
  ),
  SimpleDeclAttribute(
    name: "testable",
    className: "Testable",
    swiftName: "testable"
  ),
  DeclAttribute(
    name: "_alignment",
    className: "Alignment",
    swiftName: "_alignment"
  ),
  SimpleDeclAttribute(
    name: "rethrows",
    className: "AtRethrows",
    swiftName: "atRethrows"
  ),
  DeclAttribute(
    name: "_swift_native_objc_runtime_base",
    className: "SwiftNativeObjCRuntimeBase",
    swiftName: "_swift_native_objc_runtime_base"
  ),
  SimpleDeclAttribute(
    name: "warn_unqualified_access",
    className: "WarnUnqualifiedAccess",
    swiftName: "warn_unqualified_access"
  ),
  SimpleDeclAttribute(
    name: "_show_in_interface",
    className: "ShowInInterface",
    swiftName: "_show_in_interface"
  ),
  DeclAttribute(
    name: "_cdecl",
    className: "CDecl",
    swiftName: "_cdecl"
  ),
  SimpleDeclAttribute(
    name: "usableFromInline",
    className: "UsableFromInline",
    swiftName: "usableFromInline"
  ),
  SimpleDeclAttribute(
    name: "discardableResult",
    className: "DiscardableResult",
    swiftName: "discardableResult"
  ),
  SimpleDeclAttribute(
    name: "GKInspectable",
    className: "GKInspectable",
    swiftName: "GKInspectable"
  ),
  DeclAttribute(
    name: "_implements",
    className: "Implements",
    swiftName: "_implements"
  ),
  DeclAttribute(
    name: "_objcRuntimeName",
    className: "ObjCRuntimeName",
    swiftName: "_objcRuntimeName"
  ),
  SimpleDeclAttribute(
    name: "_staticInitializeObjCMetadata",
    className: "StaticInitializeObjCMetadata",
    swiftName: "_staticInitializeObjCMetadata"
  ),
  DeclAttribute(
    name: "_restatedObjCConformance",
    className: "RestatedObjCConformance",
    swiftName: "_restatedObjCConformance"
  ),

  // NOTE: 71 is unused

  DeclAttribute(
    name: "_objcImplementation",
    className: "ObjCImplementation",
    swiftName: "_objcImplementation"
  ),
  DeclAttribute(
    name: "_optimize",
    className: "Optimize",
    swiftName: "_optimize"
  ),
  DeclAttribute(
    name: "_clangImporterSynthesizedType",
    className: "ClangImporterSynthesizedType",
    swiftName: "_clangImporterSynthesizedType"
  ),
  SimpleDeclAttribute(
    name: "_weakLinked",
    className: "WeakLinked",
    swiftName: "_weakLinked"
  ),
  SimpleDeclAttribute(
    name: "frozen",
    className: "Frozen",
    swiftName: "frozen"
  ),
  DeclAttributeAlias(
    name: "_frozen",
    className: "Frozen",
    swiftName: "_frozen"
  ),
  SimpleDeclAttribute(
    name: "_forbidSerializingReference",
    className: "ForbidSerializingReference",
    swiftName: "_forbidSerializingReference"
  ),
  SimpleDeclAttribute(
    name: "_hasInitialValue",
    className: "HasInitialValue",
    swiftName: "_hasInitialValue"
  ),
  SimpleDeclAttribute(
    name: "_nonoverride",
    className: "NonOverride",
    swiftName: "_nonoverride"
  ),
  DeclAttribute(
    name: "_dynamicReplacement",
    className: "DynamicReplacement",
    swiftName: "_dynamicReplacement"
  ),
  SimpleDeclAttribute(
    name: "_borrowed",
    className: "Borrowed",
    swiftName: "_borrowed"
  ),
  DeclAttribute(
    name: "_private",
    className: "PrivateImport",
    swiftName: "_private"
  ),
  SimpleDeclAttribute(
    name: "_alwaysEmitIntoClient",
    className: "AlwaysEmitIntoClient",
    swiftName: "_alwaysEmitIntoClient"
  ),
  SimpleDeclAttribute(
    name: "_implementationOnly",
    className: "ImplementationOnly",
    swiftName: "_implementationOnly"
  ),
  DeclAttribute(
    name: "_custom",
    className: "Custom",
    swiftName: "_custom"
  ),
  SimpleDeclAttribute(
    name: "propertyWrapper",
    className: "PropertyWrapper",
    swiftName: "propertyWrapper"
  ),
  SimpleDeclAttribute(
    name: "_disfavoredOverload",
    className: "DisfavoredOverload",
    swiftName: "_disfavoredOverload"
  ),
  SimpleDeclAttribute(
    name: "resultBuilder",
    className: "ResultBuilder",
    swiftName: "resultBuilder"
  ),
  DeclAttribute(
    name: "_projectedValueProperty",
    className: "ProjectedValueProperty",
    swiftName: "_projectedValueProperty"
  ),
  SimpleDeclAttribute(
    name: "_nonEphemeral",
    className: "NonEphemeral",
    swiftName: "_nonEphemeral"
  ),
  DeclAttribute(
    name: "differentiable",
    className: "Differentiable",
    swiftName: "differentiable"
  ),
  SimpleDeclAttribute(
    name: "_hasMissingDesignatedInitializers",
    className: "HasMissingDesignatedInitializers",
    swiftName: "_hasMissingDesignatedInitializers"
  ),
  SimpleDeclAttribute(
    name: "_inheritsConvenienceInitializers",
    className: "InheritsConvenienceInitializers",
    swiftName: "_inheritsConvenienceInitializers"
  ),
  DeclAttribute(
    name: "_typeEraser",
    className: "TypeEraser",
    swiftName: "_typeEraser"
  ),
  SimpleDeclAttribute(
    name: "IBSegueAction",
    className: "IBSegueAction",
    swiftName: "IBSegueAction"
  ),
  DeclAttribute(
    name: "_originallyDefinedIn",
    className: "OriginallyDefinedIn",
    swiftName: "_originallyDefinedIn"
  ),
  DeclAttribute(
    name: "derivative",
    className: "Derivative",
    swiftName: "derivative"
  ),
  DeclAttribute(
    name: "_spi",
    className: "SPIAccessControl",
    swiftName: "_spi"
  ),
  DeclAttribute(
    name: "transpose",
    className: "Transpose",
    swiftName: "transpose"
  ),
  SimpleDeclAttribute(
    name: "noDerivative",
    className: "NoDerivative",
    swiftName: "noDerivative"
  ),

  // 101 was @asyncHandler and is now unused

  SimpleDeclAttribute(
    name: "globalActor",
    className: "GlobalActor",
    swiftName: "globalActor"
  ),

  SimpleDeclAttribute(
    name: "_specializeExtension",
    className: "SpecializeExtension",
    swiftName: "_specializeExtension"
  ),
  SimpleDeclAttribute(
    name: "Sendable",
    className: "Sendable",
    swiftName: "Sendable"
  ),
  SimpleDeclAttribute(
    name: "_marker",
    className: "Marker",
    swiftName: "_marker"
  ),
  SimpleDeclAttribute(
    name: "reasync",
    className: "AtReasync",
    swiftName: "atReasync"
  ),

  // 111 was an experimental @completionHandlerAsync and is now unused

  // 113 was experimental _unsafeSendable and is now unused

  // Previously experimental _unsafeMainActor
  SimpleDeclAttribute(
    name: "_unsafeInheritExecutor",
    className: "UnsafeInheritExecutor",
    swiftName: "_unsafeInheritExecutor"
  ),
  SimpleDeclAttribute(
    name: "_implicitSelfCapture",
    className: "ImplicitSelfCapture",
    swiftName: "_implicitSelfCapture"
  ),
  SimpleDeclAttribute(
    name: "_inheritActorContext",
    className: "InheritActorContext",
    swiftName: "_inheritActorContext"
  ),
  SimpleDeclAttribute(
    name: "_eagerMove",
    className: "EagerMove",
    swiftName: "_eagerMove"
  ),
  SimpleDeclAttribute(
    name: "_lexicalLifetimes",
    className: "LexicalLifetimes",
    swiftName: "_lexicalLifetimes"
  ),
  SimpleDeclAttribute(
    name: "_noEagerMove",
    className: "NoEagerMove",
    swiftName: "_noEagerMove"
  ),
  SimpleDeclAttribute(
    name: "_assemblyVision",
    className: "EmitAssemblyVisionRemarks",
    swiftName: "_assemblyVision"
  ),
  DeclAttribute(
    name: "_nonSendable",
    className: "NonSendable",
    swiftName: "_nonSendable"
  ),
  SimpleDeclAttribute(
    name: "_noImplicitCopy",
    className: "NoImplicitCopy",
    swiftName: "_noImplicitCopy"
  ),
  SimpleDeclAttribute(
    name: "_noLocks",
    className: "NoLocks",
    swiftName: "_noLocks"
  ),
  SimpleDeclAttribute(
    name: "_noAllocation",
    className: "NoAllocation",
    swiftName: "_noAllocation"
  ),
  SimpleDeclAttribute(
    name: "preconcurrency",
    className: "Preconcurrency",
    swiftName: "preconcurrency"
  ),
  DeclAttribute(
    name: "_unavailableFromAsync",
    className: "UnavailableFromAsync",
    swiftName: "_unavailableFromAsync"
  ),
  DeclAttribute(
    name: "exclusivity",
    className: "Exclusivity",
    swiftName: "exclusivity"
  ),
  DeclAttribute(
    name: "backDeployed",
    className: "BackDeployed",
    swiftName: "backDeployed"
  ),
  DeclAttributeAlias(
    name: "_backDeploy",
    className: "BackDeployed",
    swiftName: "_backDeploy"
  ),
  SimpleDeclAttribute(
    name: "_moveOnly",
    className: "MoveOnly",
    swiftName: "_moveOnly"
  ),
  SimpleDeclAttribute(
    name: "_alwaysEmitConformanceMetadata",
    className: "AlwaysEmitConformanceMetadata",
    swiftName: "_alwaysEmitConformanceMetadata"
  ),
  DeclAttribute(
    name: "_expose",
    className: "Expose",
    swiftName: "_expose"
  ),
  SimpleDeclAttribute(
    name: "typeWrapper",
    className: "TypeWrapper",
    swiftName: "typeWrapper"
  ),
  SimpleDeclAttribute(
    name: "_spiOnly",
    className: "SPIOnly",
    swiftName: "_spiOnly"
  ),
  DeclAttribute(
    name: "_documentation",
    className: "Documentation",
    swiftName: "_documentation"
  ),
  SimpleDeclAttribute(
    name: "typeWrapperIgnored",
    className: "TypeWrapperIgnored",
    swiftName: "typeWrapperIgnored"
  ),
  SimpleDeclAttribute(
    name: "_noMetadata",
    className: "NoMetadata",
    swiftName: "_noMetadata"
  ),
  SimpleDeclAttribute(
    name: "runtimeMetadata",
    className: "RuntimeMetadata",
    swiftName: "runtimeMetadata"
  ),
]

/// Schema for declaration modifiers:
///
/// - Modifier name.
/// - C++ class name without the 'Attr' suffix
/// - Options for the attribute, including:
///    * the declarations the attribute can appear on
///    * whether duplicates are allowed
/// - Unique attribute identifier used for serialization. This
///   can never be changed.
///
/// SimpleDeclAttribute is the same, but the class becomes
/// SimpleDeclAttr<DAK_##NAME> on the C++ side.
///
/// Please help ease code review/audits:
/// - Please place the "OnXYZ" flags together on the next line.
/// - Please place the non-OnXYZ flags together on the next to last line.
/// - Please place the unique code number on the last line.
/// - Please sort attributes by serialization number.
/// - Please create a "NOTE" comment if a unique number is skipped.
///
/// If you're adding a new kind of attribute that is spelled with a leading
/// '@' symbol, add an entry to the `DECL_ATTR_KINDS` array instead.
public let DECL_MODIFIER_KINDS: [Attribute] = [
  // These are not really attributes or modifiers in the C++ AST and they are
  // serialized directly into the ASTs they are attached to rather than using
  // the generic attribute serialization infrastructure.
  BuiltinDeclModifier(
    name: "static",
    swiftName: "`static`"
  ),
  BuiltinDeclModifier(
    name: "class",
    swiftName: "`class`"
  ),
  ContextualSimpleDeclAttribute(
    name: "final",
    className: "Final"
  ),
  ContextualSimpleDeclAttribute(
    name: "required",
    className: "Required"
  ),
  ContextualSimpleDeclAttribute(
    name: "optional",
    className: "Optional"
  ),
  ContextualSimpleDeclAttribute(
    name: "lazy",
    className: "Lazy"
  ),
  ContextualSimpleDeclAttribute(
    name: "dynamic",
    className: "Dynamic"
  ),
  ContextualSimpleDeclAttribute(
    name: "infix",
    className: "Infix"
  ),
  ContextualSimpleDeclAttribute(
    name: "prefix",
    className: "Prefix"
  ),
  ContextualSimpleDeclAttribute(
    name: "postfix",
    className: "Postfix"
  ),
  ContextualSimpleDeclAttribute(
    name: "__consuming",
    className: "LegacyConsuming"
  ),
  ContextualSimpleDeclAttribute(
    name: "mutating",
    className: "Mutating"
  ),
  ContextualSimpleDeclAttribute(
    name: "nonmutating",
    className: "NonMutating"
  ),
  ContextualSimpleDeclAttribute(
    name: "convenience",
    className: "Convenience"
  ),
  ContextualSimpleDeclAttribute(
    name: "override",
    className: "Override"
  ),
  DeclAttribute(
    name: "private",
    className: "AccessControl",
    swiftName: "`private`"
  ),
  DeclAttributeAlias(
    name: "fileprivate",
    className: "AccessControl",
    swiftName: "`fileprivate`"
  ),
  DeclAttributeAlias(
    name: "internal",
    className: "AccessControl",
    swiftName: "`internal`"
  ),
  DeclAttributeAlias(
    name: "public",
    className: "AccessControl",
    swiftName: "`public`"
  ),
  ContextualDeclAttributeAlias(
    name: "package",
    className: "AccessControl",
    swiftName: "package"
  ),
  ContextualDeclAttributeAlias(
    name: "open",
    className: "AccessControl",
    swiftName: "open"
  ),
  DeclAttribute(
    name: "__setter_access",
    className: "SetterAccess",
    swiftName: "__setter_access"
  ),
  ContextualDeclAttribute(
    name: "weak",
    className: "ReferenceOwnership"
  ),
  ContextualDeclAttributeAlias(
    name: "unowned",
    className: "ReferenceOwnership",
    swiftName: "unowned"
  ),
  SimpleDeclAttribute(
    name: "rethrows",
    className: "Rethrows",
    swiftName: "`rethrows`"
  ),
  ContextualSimpleDeclAttribute(
    name: "indirect",
    className: "Indirect"
  ),
  ContextualSimpleDeclAttribute(
    name: "isolated",
    className: "Isolated"
  ),
  ContextualSimpleDeclAttribute(
    name: "async",
    className: "Async"
  ),
  SimpleDeclAttribute(
    name: "reasync",
    className: "Reasync",
    swiftName: "reasync"
  ),
  ContextualSimpleDeclAttribute(
    name: "nonisolated",
    className: "Nonisolated"
  ),
  ContextualSimpleDeclAttribute(
    name: "distributed",
    className: "DistributedActor"
  ),
  ContextualSimpleDeclAttribute(
    name: "_const",
    className: "CompileTimeConst"
  ),
  ContextualSimpleDeclAttribute(
    name: "_local",
    className: "KnownToBeLocal"
  ),
  ContextualSimpleDeclAttribute(
    name: "consuming",
    className: "Consuming"
  ),
  ContextualSimpleDeclAttribute(
    name: "borrowing",
    className: "Borrowing"
  ),
]

public let DEPRECATED_MODIFIER_KINDS: [Attribute] = [
  // TODO: Remove this once we don't need to support 'actor' as a modifier
  ContextualSimpleDeclAttribute(
    name: "actor",
    className: "Actor"
  )
]
