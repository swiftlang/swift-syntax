//===---------- BumpPtrAllocator.swift - Bump-pointer Allocaiton ----------===//
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

/// Bump-pointer allocation.
class BumpPtrAllocator {
  typealias Slab = UnsafeMutableRawBufferPointer

  static private var SLAB_SIZE: Int = 4096
  static private var GLOWTH_DELAY: Int = 128
  static private var SLAB_ALIGNMENT: Int = 8

  private var slabs: [Slab]
  private var currentPtr: UnsafeMutableRawPointer?
  private var endPtr: UnsafeMutableRawPointer?
  private var customSizeSlabs: [Slab]
  private(set) var totalSizeAllocated: Int

  init() {
    slabs = []
    currentPtr = nil
    endPtr = nil
    customSizeSlabs = []
    totalSizeAllocated = 0
  }

  deinit {
    /// Deallocate all memory.
    totalSizeAllocated = 0
    currentPtr = nil
    endPtr = nil
    while !slabs.isEmpty {
      slabs.removeLast().deallocate()
    }
    while !customSizeSlabs.isEmpty {
      customSizeSlabs.removeLast().deallocate()
    }
  }

  /// Calculate the size of the slab at the index.
  private static func slabSize(at index: Int) -> Int {
    // Double the slab size every 'GLOWTH_DELAY' slabs.
    return SLAB_SIZE * (1 << min(30, index / GLOWTH_DELAY))
  }

  private func startNewSlab() {
    let newSlabSize = Self.slabSize(at: slabs.count)
    let newSlab = Slab.allocate(
      byteCount: newSlabSize, alignment: Self.SLAB_ALIGNMENT)
    slabs.append(newSlab)
    currentPtr = newSlab.baseAddress!
    endPtr = currentPtr!.advanced(by: newSlabSize)
  }

  /// Allocate 'byteCount' of memory.
  func allocate(byteCount: Int, alignment: Int) -> UnsafeMutableRawBufferPointer {

    precondition(alignment <= Self.SLAB_ALIGNMENT)
    guard byteCount > 0 else {
      return .init(start: nil, count: 0)
    }

    // Track the total size we allocated.
    totalSizeAllocated += byteCount

    // Check if the current slab have enough space.
    if !slabs.isEmpty {
      let aligned = currentPtr!.alignedUp(toMultipleOf: alignment)
      if aligned + byteCount <= endPtr! {
        currentPtr = aligned + byteCount
        return .init(start: aligned, count: byteCount)
      }
    }

    // If the size is too big, allocate a dedicated slab for it.
    if byteCount >= Self.SLAB_SIZE {
      let customSlab = Slab.allocate(
        byteCount: byteCount, alignment: alignment)
      customSizeSlabs.append(customSlab)
      return customSlab
    }

    // Otherwise, start a new slab and try again.
    startNewSlab()
    let aligned = currentPtr!.alignedUp(toMultipleOf: alignment)
    assert(aligned + byteCount <= endPtr!, "Unable to allocate memory!")
    currentPtr = aligned + byteCount
    return .init(start: aligned, count: byteCount)
  }

  /// Allocate a chunk of memory of `MemoryLayout<T>.stride * count'.
  func allocate<T>(_: T.Type, count: Int) -> UnsafeMutableBufferPointer<T> {
    let allocated = allocate(byteCount: MemoryLayout<T>.stride * count,
                             alignment: MemoryLayout<T>.alignment)
    return allocated.bindMemory(to: T.self)
  }

  /// Check if the address is managed by this allocator.
  func contains(address: UnsafeRawPointer) -> Bool {
    func test(_ slab: Slab) -> Bool {
      slab.baseAddress! <= address && address < slab.baseAddress! + slab.count
    }
    return slabs.contains(where: test(_:)) || customSizeSlabs.contains(where: test(_:))
  }
}
