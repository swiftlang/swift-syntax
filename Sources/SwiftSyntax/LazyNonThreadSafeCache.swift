//===--------------------- LazyNonThreadSafeCache.swift -------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2018 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation

/// LazyNonThreadSafeCache is a wrapper class around an uninitialized value.
/// It takes a closure that will be used to create the value when needed.
///
/// FIXME: the cache is no longer thread-safe. We need stdlib to provide proper
/// APIs to ensure thread safety
class LazyNonThreadSafeCache<Value: AnyObject> {
  /// The cached pointer that will be filled in the first time `value` is
  /// accessed.
  private var _cachedValue: AnyObject?

  /// The value inside this cache. If the value has not been initialized when
  /// this value is requested, then the closure will be called and its resulting
  /// value will be stored in the cache.
  /// - Parameter create: The closure that will return the fully realized value
  ///                     inside the cache.
  func value(_ create: () -> Value) -> Value {
    if _cachedValue == nil {
      _cachedValue = create()
    }
    return _cachedValue as! Value
  }

  /// Get the raw cache with the right type for debugging purposes.
  /// - note: Only for use in the debugger!
  @available(*, deprecated, message: "Only for use in the debugger.")
  var unsafeValue: Value? {
    return _cachedValue as? Value
  }
}
