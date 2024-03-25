//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if canImport(SwiftUI)

import SwiftUI

// MARK: - EnvironmentValue Accessor

/// Adds getter / setter to an attached environment value with specified EnvironmentKey
@attached(accessor)
public macro EnvironmentValue(for key: any EnvironmentKey.Type) =
  #externalMacro(module: "MacroExamplesImplementation", type: "EnvironmentValueMacro")

#endif
