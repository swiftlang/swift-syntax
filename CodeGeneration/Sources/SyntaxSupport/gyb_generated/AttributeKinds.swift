//// Automatically Generated From AttributeKinds.swift.gyb.
//// Do Not Edit Directly!
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
  public let options: [String]
  public let code: Int
  
  public convenience init(name: String, className: String, options: String..., code: Int, swiftName: String? = nil) {
    self.init(name: name, className: className, options: options, code: code, swiftName: swiftName)
  }
  
  public init(name: String, className: String, options: [String], code: Int, swiftName: String? = nil) {
    self.className = className
    self.options = options
    self.code = code
    super.init(name: name, swiftName: swiftName)
  }
}

public class SimpleDeclAttribute: DeclAttribute { }

public class ContextualDeclAttribute: DeclAttribute {
  public init(name: String, className: String, options: String..., code: Int) {
    super.init(name: name, className: className, options: options, code: code)
  }
}

public class ContextualSimpleDeclAttribute: SimpleDeclAttribute {
  public init(name: String, className: String, options: String..., code: Int) {
    super.init(name: name, className: className, options: options, code: code)
  }
}

public class DeclAttributeAlias: Attribute {
  public let className: String
  
  public init(name: String, className: String, swiftName: String? = nil) {
    self.className = className
    super.init(name: name, swiftName: swiftName)
    
  }
}

public class ContextualDeclAttributeAlias: DeclAttributeAlias { }

public class BuiltinDeclModifier: Attribute { }

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
  BuiltinDeclModifier(name: "static",
                swiftName: "`static`"),
  BuiltinDeclModifier(name: "class",
                swiftName: "`class`"),
  ContextualSimpleDeclAttribute(name: "final",
                className: "Final",
                options: 
                  "OnClass",
                  "OnFunc",
                  "OnAccessor",
                  "OnVar",
                  "OnSubscript",
                  "DeclModifier",
                  "ABIBreakingToAdd",
                  "ABIBreakingToRemove",
                  "APIStableToAdd",
                  "APIStableToRemove",
                code: 2),
  ContextualSimpleDeclAttribute(name: "required",
                className: "Required",
                options: 
                  "OnConstructor",
                  "DeclModifier",
                  "ABIStableToAdd",
                  "ABIStableToRemove",
                  "APIStableToAdd",
                  "APIStableToRemove",
                code: 4),
  ContextualSimpleDeclAttribute(name: "optional",
                className: "Optional",
                options: 
                  "OnConstructor",
                  "OnFunc",
                  "OnAccessor",
                  "OnVar",
                  "OnSubscript",
                  "DeclModifier",
                  "ABIStableToAdd",
                  "ABIStableToRemove",
                  "APIStableToAdd",
                  "APIStableToRemove",
                code: 5),
  ContextualSimpleDeclAttribute(name: "lazy",
                className: "Lazy",
                options: 
                  "DeclModifier",
                  "OnVar",
                  "ABIStableToAdd",
                  "ABIStableToRemove",
                  "APIStableToAdd",
                  "APIStableToRemove",
                code: 16),
  ContextualSimpleDeclAttribute(name: "dynamic",
                className: "Dynamic",
                options: 
                  "OnFunc",
                  "OnAccessor",
                  "OnVar",
                  "OnSubscript",
                  "OnConstructor",
                  "DeclModifier",
                  "ABIBreakingToAdd",
                  "ABIBreakingToRemove",
                  "APIStableToAdd",
                  "APIStableToRemove",
                code: 22),
  ContextualSimpleDeclAttribute(name: "infix",
                className: "Infix",
                options: 
                  "OnFunc",
                  "OnOperator",
                  "DeclModifier",
                  "ABIStableToAdd",
                  "ABIStableToRemove",
                  "APIStableToAdd",
                  "APIStableToRemove",
                code: 23),
  ContextualSimpleDeclAttribute(name: "prefix",
                className: "Prefix",
                options: 
                  "OnFunc",
                  "OnOperator",
                  "DeclModifier",
                  "ABIStableToAdd",
                  "ABIStableToRemove",
                  "APIStableToAdd",
                  "APIStableToRemove",
                code: 24),
  ContextualSimpleDeclAttribute(name: "postfix",
                className: "Postfix",
                options: 
                  "OnFunc",
                  "OnOperator",
                  "DeclModifier",
                  "ABIStableToAdd",
                  "ABIStableToRemove",
                  "APIStableToAdd",
                  "APIStableToRemove",
                code: 25),
  ContextualSimpleDeclAttribute(name: "__consuming",
                className: "Consuming",
                options: 
                  "OnFunc",
                  "OnAccessor",
                  "DeclModifier",
                  "UserInaccessible",
                  "NotSerialized",
                  "ABIStableToAdd",
                  "ABIStableToRemove",
                  "APIStableToAdd",
                  "APIStableToRemove",
                code: 40),
  ContextualSimpleDeclAttribute(name: "mutating",
                className: "Mutating",
                options: 
                  "OnFunc",
                  "OnAccessor",
                  "DeclModifier",
                  "NotSerialized",
                  "ABIStableToAdd",
                  "ABIStableToRemove",
                  "APIStableToAdd",
                  "APIStableToRemove",
                code: 41),
  ContextualSimpleDeclAttribute(name: "nonmutating",
                className: "NonMutating",
                options: 
                  "OnFunc",
                  "OnAccessor",
                  "DeclModifier",
                  "NotSerialized",
                  "ABIStableToAdd",
                  "ABIStableToRemove",
                  "APIStableToAdd",
                  "APIStableToRemove",
                code: 42),
  ContextualSimpleDeclAttribute(name: "convenience",
                className: "Convenience",
                options: 
                  "OnConstructor",
                  "DeclModifier",
                  "NotSerialized",
                  "ABIBreakingToAdd",
                  "ABIStableToRemove",
                  "APIStableToAdd",
                  "APIStableToRemove",
                code: 43),
  ContextualSimpleDeclAttribute(name: "override",
                className: "Override",
                options: 
                  "OnFunc",
                  "OnAccessor",
                  "OnVar",
                  "OnSubscript",
                  "OnConstructor",
                  "OnAssociatedType",
                  "DeclModifier",
                  "NotSerialized",
                  "ABIStableToAdd",
                  "ABIStableToRemove",
                  "APIStableToAdd",
                  "APIStableToRemove",
                code: 44),
  DeclAttribute(name: "private",
                className: "AccessControl",
                options: 
                  "OnFunc",
                  "OnAccessor",
                  "OnExtension",
                  "OnGenericType",
                  "OnVar",
                  "OnSubscript",
                  "OnConstructor",
                  "OnMacro",
                  "DeclModifier",
                  "NotSerialized",
                  "ABIStableToAdd",
                  "ABIStableToRemove",
                  "APIStableToAdd",
                  "APIStableToRemove",
                code: 46,
                swiftName: "`private`"),
  DeclAttributeAlias(name: "fileprivate",
                className: "AccessControl",
                swiftName: "`fileprivate`"),
  DeclAttributeAlias(name: "internal",
                className: "AccessControl",
                swiftName: "`internal`"),
  DeclAttributeAlias(name: "public",
                className: "AccessControl",
                swiftName: "`public`"),
  ContextualDeclAttributeAlias(name: "package",
                className: "AccessControl",
                swiftName: "package"),
  ContextualDeclAttributeAlias(name: "open",
                className: "AccessControl",
                swiftName: "open"),
  DeclAttribute(name: "__setter_access",
                className: "SetterAccess",
                options: 
                  "OnVar",
                  "OnSubscript",
                  "DeclModifier",
                  "RejectByParser",
                  "NotSerialized",
                  "ABIStableToAdd",
                  "ABIStableToRemove",
                  "APIStableToAdd",
                  "APIStableToRemove",
                code: 47,
                swiftName: "__setter_access"),
  ContextualDeclAttribute(name: "weak",
                className: "ReferenceOwnership",
                options: 
                  "OnVar",
                  "DeclModifier",
                  "NotSerialized",
                  "ABIStableToAdd",
                  "ABIStableToRemove",
                  "APIStableToAdd",
                  "APIStableToRemove",
                code: 49),
  ContextualDeclAttributeAlias(name: "unowned",
                className: "ReferenceOwnership",
                swiftName: "unowned"),
  SimpleDeclAttribute(name: "rethrows",
                className: "Rethrows",
                options: 
                  "OnFunc",
                  "OnConstructor",
                  "RejectByParser",
                  "ABIBreakingToAdd",
                  "ABIBreakingToRemove",
                  "APIBreakingToAdd",
                  "APIBreakingToRemove",
                code: 57,
                swiftName: "`rethrows`"),
  ContextualSimpleDeclAttribute(name: "indirect",
                className: "Indirect",
                options: 
                  "DeclModifier",
                  "OnEnum",
                  "OnEnumElement",
                  "ABIBreakingToAdd",
                  "ABIBreakingToRemove",
                  "APIStableToAdd",
                  "APIStableToRemove",
                code: 60),
  ContextualSimpleDeclAttribute(name: "isolated",
                className: "Isolated",
                options: 
                  "DeclModifier",
                  "OnParam",
                  "ABIBreakingToAdd",
                  "ABIBreakingToRemove",
                  "APIBreakingToAdd",
                  "APIBreakingToRemove",
                code: 103),
  ContextualSimpleDeclAttribute(name: "async",
                className: "Async",
                options: 
                  "DeclModifier",
                  "OnVar",
                  "OnFunc",
                  "ABIBreakingToAdd",
                  "ABIBreakingToRemove",
                  "APIBreakingToAdd",
                  "APIBreakingToRemove",
                code: 106),
  SimpleDeclAttribute(name: "reasync",
                className: "Reasync",
                options: 
                  "OnFunc",
                  "OnConstructor",
                  "RejectByParser",
                  "ABIBreakingToAdd",
                  "ABIBreakingToRemove",
                  "APIBreakingToAdd",
                  "APIBreakingToRemove",
                code: 109,
                swiftName: "reasync"),
  ContextualSimpleDeclAttribute(name: "nonisolated",
                className: "Nonisolated",
                options: 
                  "DeclModifier",
                  "OnFunc",
                  "OnConstructor",
                  "OnVar",
                  "OnSubscript",
                  "ABIStableToAdd",
                  "ABIStableToRemove",
                  "APIBreakingToAdd",
                  "APIStableToRemove",
                code: 112),
  ContextualSimpleDeclAttribute(name: "distributed",
                className: "DistributedActor",
                options: 
                  "DeclModifier",
                  "OnClass",
                  "OnFunc",
                  "OnAccessor",
                  "OnVar",
                  "ABIBreakingToAdd",
                  "ABIBreakingToRemove",
                  "APIBreakingToAdd",
                  "APIBreakingToRemove",
                code: 118),
  ContextualSimpleDeclAttribute(name: "_const",
                className: "CompileTimeConst",
                options: 
                  "DeclModifier",
                  "OnParam",
                  "OnVar",
                  "UserInaccessible",
                  "ABIStableToAdd",
                  "ABIStableToRemove",
                  "APIBreakingToAdd",
                  "APIStableToRemove",
                code: 126),
  ContextualSimpleDeclAttribute(name: "_local",
                className: "KnownToBeLocal",
                options: 
                  "DeclModifier",
                  "OnFunc",
                  "OnParam",
                  "OnVar",
                  "UserInaccessible",
                  "ABIBreakingToAdd",
                  "ABIBreakingToRemove",
                  "APIBreakingToAdd",
                  "APIBreakingToRemove",
                code: 130),
]

public let DEPRECATED_MODIFIER_KINDS: [Attribute] = [
  ContextualSimpleDeclAttribute(name: "actor",
                className: "Actor",
                options: 
                  "DeclModifier",
                  "OnClass",
                  "ConcurrencyOnly",
                  "ABIBreakingToAdd",
                  "ABIBreakingToRemove",
                  "APIBreakingToAdd",
                  "APIBreakingToRemove",
                code: 102),
]
