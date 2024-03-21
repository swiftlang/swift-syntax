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

// MARK: - Add Async

@attached(peer, names: overloaded)
public macro AddAsync() = #externalMacro(module: "MacroExamplesImplementation", type: "AddAsyncMacro")

// MARK: - Add Completion Handler

/// Adds a "completionHandler" variant of an async function, which creates a new
/// task , calls the original async function, and delivers its result to the completion
/// handler.
@attached(peer, names: overloaded)
public macro AddCompletionHandler() =
  #externalMacro(module: "MacroExamplesImplementation", type: "AddCompletionHandlerMacro")

// MARK: - Peer Value With Suffix Name

@attached(peer, names: suffixed(_peer))
public macro PeerValueWithSuffixName() =
  #externalMacro(module: "MacroExamplesImplementation", type: "PeerValueWithSuffixNameMacro")
