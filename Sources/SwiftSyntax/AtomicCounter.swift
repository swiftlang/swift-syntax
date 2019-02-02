//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2019 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// This is using the C function from '_CSwiftSyntax/src/atomic-counter.c' by
// dynamically loading it using `dlsym`. The reason this mechanism is used
// instead of importing a header is so that we preserve the property that
// SwiftSyntax is a self-contained Swift module.
// (also see '_CSwiftSyntax/include/README.md')

#if os(Linux)
import Glibc
#else
import Darwin.C
#endif

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
  fileprivate let RTLD_DEFAULT = UnsafeMutableRawPointer(bitPattern: -2)
#elseif os(Linux)
  fileprivate let RTLD_DEFAULT = UnsafeMutableRawPointer(bitPattern: 0)
#endif

fileprivate typealias get_unique_counter_ty = (@convention(c) ()->UInt64)
fileprivate let get_unique_counter_str = "cswiftsyntax_get_unique_counter"

/// Provides API to get an atomically increasing counter value.
struct AtomicCounter {
  /// Get an atomically increasing counter value.
  static func next() -> UInt64 {
    return AtomicCounter.cswiftsyntax_get_unique_counter()
  }

  static fileprivate let cswiftsyntax_get_unique_counter: get_unique_counter_ty = { ()->get_unique_counter_ty in
    let ptr = dlsym(RTLD_DEFAULT, get_unique_counter_str)!
    return unsafeBitCast(ptr, to: get_unique_counter_ty.self)
  }()
}
