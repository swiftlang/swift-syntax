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

// MARK: - Member Deprecated

@attached(memberAttribute)
public macro memberDeprecated() = #externalMacro(module: "MacroExamplesImplementation", type: "MemberDeprecatedMacro")

// MARK: - Wrap Stored Properties

/// Apply the specified attribute to each of the stored properties within the
/// type or member to which the macro is attached. The string can be
/// any attribute (without the `@`).
@attached(memberAttribute)
public macro wrapStoredProperties(_ attributeName: String) =
  #externalMacro(module: "MacroExamplesImplementation", type: "WrapStoredPropertiesMacro")
