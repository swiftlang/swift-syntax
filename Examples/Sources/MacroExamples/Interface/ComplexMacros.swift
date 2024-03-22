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

// MARK: - Dictionary Storage

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
public macro DictionaryStorageProperty() =
  #externalMacro(module: "MacroExamplesImplementation", type: "DictionaryStoragePropertyMacro")

// MARK: - Observable

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

@attached(
  member,
  names: named(Storage),
  named(_storage),
  named(_registrar),
  named(addObserver),
  named(removeObserver),
  named(withTransaction)
)
@attached(memberAttribute)
@attached(extension, conformances: Observable)
public macro Observable() = #externalMacro(module: "MacroExamplesImplementation", type: "ObservableMacro")

@attached(accessor)
public macro ObservableProperty() =
  #externalMacro(module: "MacroExamplesImplementation", type: "ObservablePropertyMacro")

// MARK: - Option Set

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
