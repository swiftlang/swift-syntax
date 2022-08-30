//===----------------------------------------------------------------------===//
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

@_implementationOnly import _CSwiftSyntax

/// Provides API to get an atomically increasing counter value.
struct AtomicCounter {
  /// Get an atomically increasing counter value.
  static func next() -> UInt64 {
    return cswiftsyntax_get_unique_counter()
  }
}
