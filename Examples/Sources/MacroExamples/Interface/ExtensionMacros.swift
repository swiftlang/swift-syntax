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

// MARK: - Equatable Extension

@attached(extension, conformances: Equatable)
public macro equatable() = #externalMacro(module: "MacroExamplesImplementation", type: "EquatableExtensionMacro")

// MARK: - Default Fatal Error Implementation

/// A macro that provides default `fatalError` implementations for protocol methods.
///
/// This macro generates Swift extensions for the attached protocol,
/// adding a default `fatalError` implementation for each method defined within it.
///
/// ## Example usage:
/// ```swift
/// @defaultFatalErrorImplementation
/// protocol MyProtocol {
///   func someMethod()
/// }
/// ```
///
/// The generated code would look like:
/// ```swift
/// protocol MyProtocol {
///   func someMethod()
/// }
///
/// extension MyProtocol {
///   func someMethod() {
///     fatalError("whoops 😅")
///   }
/// }
/// ```
///
/// ## Edge Cases
/// - **No Methods in Protocol**: If the protocol does not contain any methods,
///   the macro will not generate an empty extension.
/// - **Incorrect Attachment**: If the macro is attached to a non-protocol declaration,
///   it will produce an error diagnostic stating that it can only be applied to a protocol.
@attached(extension, names: arbitrary)
public macro defaultFatalErrorImplementation() =
  #externalMacro(
    module: "MacroExamplesImplementation",
    type: "DefaultFatalErrorImplementationMacro"
  )
