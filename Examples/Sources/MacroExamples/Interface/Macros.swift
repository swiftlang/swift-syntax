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

import Foundation

/// "Stringify" the provided value and produce a tuple that includes both the
/// original value as well as the source code that generated it.
@freestanding(expression) public macro stringify<T>(_ value: T) -> (T, String) = #externalMacro(module: "MacroExamplesImplementation", type: "StringifyMacro")

/// Macro that produces a warning on "+" operators within the expression, and
/// suggests changing them to "-".
@freestanding(expression) public macro addBlocker<T>(_ value: T) -> T = #externalMacro(module: "MacroExamplesImplementation", type: "AddBlocker")

/// Macro that produces a warning, as a replacement for the built-in
/// #warning("...").
@freestanding(expression) public macro myWarning(_ message: String) = #externalMacro(module: "MacroExamplesImplementation", type: "WarningMacro")

public enum FontWeight {
  case thin
  case normal
  case medium
  case semiBold
  case bold
}

public protocol ExpressibleByFontLiteral {
  init(fontLiteralName: String, size: Int, weight: FontWeight)
}

/// Font literal similar to, e.g., #colorLiteral.
@freestanding(expression) public macro fontLiteral<T>(name: String, size: Int, weight: FontWeight) -> T =
  #externalMacro(module: "MacroExamplesImplementation", type: "FontLiteralMacro")
where T: ExpressibleByFontLiteral

/// Check if provided string literal is a valid URL and produce a non-optional
/// URL value. Emit error otherwise.
@freestanding(expression) public macro URL(_ stringLiteral: String) -> URL = #externalMacro(module: "MacroExamplesImplementation", type: "URLMacro")

/// Apply the specified attribute to each of the stored properties within the
/// type or member to which the macro is attached. The string can be
/// any attribute (without the `@`).
@attached(memberAttribute)
public macro wrapStoredProperties(_ attributeName: String) = #externalMacro(module: "MacroExamplesImplementation", type: "WrapStoredPropertiesMacro")

/// Wrap up the stored properties of the given type in a dictionary,
/// turning them into computed properties.
///
/// This macro composes two different kinds of macro expansion:
///   * Member-attribute macro expansion, to put `DictionaryStorageProperty` macro on
///    all stored properties of the type it is attached to.
///   * Member macro expansion, to add a `_storage` property with the actual
///     dictionary.
@attached(memberAttribute)
@attached(member, names: named(_storage))
public macro DictionaryStorage() = #externalMacro(module: "MacroExamplesImplementation", type: "DictionaryStorageMacro")

@attached(accessor)
public macro DictionaryStorageProperty() = #externalMacro(module: "MacroExamplesImplementation", type: "DictionaryStoragePropertyMacro")

public protocol Observable {}

public protocol Observer<Subject> {
  associatedtype Subject: Observable
}

public struct ObservationRegistrar<Subject: Observable> {
  public init() {}

  public func addObserver(_ observer: some Observer<Subject>) {}

  public func removeObserver(_ observer: some Observer<Subject>) {}

  public func beginAccess<Value>(_ keyPath: KeyPath<Subject, Value>) {
    print("beginning access for \(keyPath)")
  }

  public func beginAccess() {
    print("beginning access in \(Subject.self)")
  }

  public func endAccess() {
    print("ending access in \(Subject.self)")
  }

  public func register<Value>(observable: Subject, willSet: KeyPath<Subject, Value>, to: Value) {
    print("registering willSet event for \(willSet)")
  }

  public func register<Value>(observable: Subject, didSet: KeyPath<Subject, Value>) {
    print("registering didSet event for \(didSet)")
  }
}

@attached(member, names: named(Storage), named(_storage), named(_registrar), named(addObserver), named(removeObserver), named(withTransaction))
@attached(memberAttribute)
@attached(extension, conformances: Observable)
public macro Observable() = #externalMacro(module: "MacroExamplesImplementation", type: "ObservableMacro")

@attached(accessor)
public macro ObservableProperty() = #externalMacro(module: "MacroExamplesImplementation", type: "ObservablePropertyMacro")

/// Adds a "completionHandler" variant of an async function, which creates a new
/// task , calls thh original async function, and delivers its result to the completion
/// handler.
@attached(peer, names: overloaded)
public macro AddCompletionHandler() =
  #externalMacro(module: "MacroExamplesImplementation", type: "AddCompletionHandlerMacro")

@attached(peer, names: overloaded)
public macro AddAsync() =
  #externalMacro(module: "MacroExamplesImplementation", type: "AddAsyncMacro")

/// Add computed properties named `is<Case>` for each case element in the enum.
@attached(member, names: arbitrary)
public macro CaseDetection() = #externalMacro(module: "MacroExamplesImplementation", type: "CaseDetectionMacro")

@attached(member, names: named(Meta))
public macro MetaEnum() = #externalMacro(module: "MacroExamplesImplementation", type: "MetaEnumMacro")

@attached(peer)
public macro CodableKey(name: String) = #externalMacro(module: "MacroExamplesImplementation", type: "CodableKey")

@attached(member, names: named(CodingKeys))
public macro CustomCodable() = #externalMacro(module: "MacroExamplesImplementation", type: "CustomCodable")

/// Create an option set from a struct that contains a nested `Options` enum.
///
/// Attach this macro to a struct that contains a nested `Options` enum
/// with an integer raw value. The struct will be transformed to conform to
/// `OptionSet` by
///   1. Introducing a `rawValue` stored property to track which options are set,
///    along with the necessary `RawType` typealias and initializers to satisfy
///    the `OptionSet` protocol.
///   2. Introducing static properties for each of the cases within the `Options`
///    enum, of the type of the struct.
///
/// The `Options` enum must have a raw value, where its case elements
/// each indicate a different option in the resulting option set. For example,
/// the struct and its nested `Options` enum could look like this:
///
///     @MyOptionSet
///     struct ShippingOptions {
///       private enum Options: Int {
///         case nextDay
///         case secondDay
///         case priority
///         case standard
///       }
///     }
@attached(member, names: arbitrary)
@attached(extension, conformances: OptionSet)
public macro MyOptionSet<RawType>() = #externalMacro(module: "MacroExamplesImplementation", type: "OptionSetMacro")
