//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

// Describes the emission behavior state of a particular warning diagnostic group.
@_spi(ExperimentalLanguageFeatures)
public enum WarningGroupBehavior: String {
  /// Emitted as a fatal error, halting compilation
  case error
  /// Emitted as a warning
  case warning
  /// Fully suppressed, i.e. diagnostic not emitted
  case ignored
}
