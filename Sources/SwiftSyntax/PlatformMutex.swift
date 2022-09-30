//===------ PlatformMutex.swift - Platform-specific Mutual Exclusion  -----===//
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

#if canImport(Darwin)
@_implementationOnly import Darwin
#elseif canImport(Glibc)
@_implementationOnly import Glibc
#elseif canImport(WinSDK)
@_implementationOnly import WinSDK
#endif

/// A protocol that platform-specific mutual exclusion primitives should conform to.
final class PlatformMutex {
  // FIXME: Use os_unfair_lock when we bump to macOS 12.0 on Darwin
#if canImport(Darwin) || canImport(Glibc)
  typealias Primitive = pthread_mutex_t
#elseif canImport(WinSDK)
  typealias Primitive = SRWLOCK
#endif
  typealias PlatformLock = UnsafeMutablePointer<Primitive>

  private let lock: PlatformLock

  /// Allocate memory for, and initialize, the mutex in a platform-specific fashion.
  ///
  /// - Parameter allocator: An allocator
  init(allocator: BumpPtrAllocator) {
    let storage = allocator.allocate(Primitive.self, count: 1).baseAddress!
    storage.initialize(to: Primitive())
    self.lock = storage
    Self.initialize(self.lock)
  }

  /// Deinitialize the memory associated with the mutex.
  ///
  /// - Warning: Do not call `.deallocate()` on  any pointers allocated by the
  ///            `BumpPtrAllocator` here.
  func deinitialize() {
#if canImport(Darwin) || canImport(Glibc)
    pthread_mutex_destroy(self.lock)
#endif
    self.lock.deinitialize(count: 1)
  }

  /// Invoke the provided block under the protection of the mutex.
  func withGuard<T>(body: () throws -> T) rethrows -> T {
    Self.lock(self.lock)
    defer { Self.unlock(self.lock) }
    return try body()
  }
}

extension PlatformMutex {
  private static func initialize(_ platformLock: PlatformLock) {
#if canImport(Darwin)
    // HACK: On Darwin, the value of PTHREAD_MUTEX_INITIALIZER installs
    // signature bits into the mutex that are later checked by other aspects
    // of the mutex API. This is a completely optional POSIX-ism that most
    // Linuxes don't implement - often so that (global) lock variables can be
    // stuck in .bss. Swift doesn't know how to import
    // PTHREAD_MUTEX_INITIALIZER, so we'll replicate its signature-installing
    // magic with the bit it can import.
    platformLock.pointee.__sig = Int(_PTHREAD_MUTEX_SIG_init)
    let result = pthread_mutex_init(platformLock, nil)
    precondition(result == 0)
#elseif canImport(Glibc)
    let result = pthread_mutex_init(platformLock, nil)
    precondition(result == 0)
#elseif canImport(WinSDK)
    InitializeSRWLock(platformLock)
#endif
  }

  private static func lock(_ platformLock: PlatformLock) {
#if canImport(Darwin) || canImport(Glibc)
    let result = pthread_mutex_lock(platformLock)
    assert(result == 0)
#elseif canImport(WinSDK)
    AcquireSRWLockExclusive(platformLock)
#endif
  }

  private static func unlock(_ platformLock: PlatformLock) {
#if canImport(Darwin) || canImport(Glibc)
    let result = pthread_mutex_unlock(platformLock)
    assert(result == 0)
#elseif canImport(WinSDK)
    ReleaseSRWLockExclusive(platformLock)
#endif
  }
}
