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
@_spi(Testing)
public class BumpPtrAllocator {
  typealias Slab = UnsafeMutableRawBufferPointer

  static private var SLAB_SIZE: Int = 4096
  static private var GLOWTH_DELAY: Int = 128
  static private var SLAB_ALIGNMENT: Int = 8

  private var slabs: [Slab]
  /// Points to the next unused address in `slabs.last`.
  private var currentPtr: UnsafeMutableRawPointer?
  /// Points to the end address of `slabs.last`. If `slabs` is not empty, this
  /// is equivalent to `slabs.last!.baseAddress! + slabs.last!.count`
  private var endPtr: UnsafeMutableRawPointer?
  private var customSizeSlabs: [Slab]
  private var _totalBytesAllocated: Int

  public init() {
    slabs = []
    currentPtr = nil
    endPtr = nil
    customSizeSlabs = []
    _totalBytesAllocated = 0
  }

  deinit {
    /// Deallocate all memory.
    _totalBytesAllocated = 0
    currentPtr = nil
    endPtr = nil
    while let slab = slabs.popLast() {
      slab.deallocate()
    }
    while let slab = customSizeSlabs.popLast() {
      slab.deallocate()
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
  ///
  /// The returned buffer is not bound to any types, nor initialized.
  /// Clients should never call `deallocate()` on the returned buffer.
  public func allocate(byteCount: Int, alignment: Int) -> UnsafeMutableRawBufferPointer {

    precondition(alignment <= Self.SLAB_ALIGNMENT)
    guard byteCount > 0 else {
      return .init(start: nil, count: 0)
    }

    // Track the total size we allocated.
    _totalBytesAllocated += byteCount

    // Check if the current slab has enough space.
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

  /// Allocate a chunk of bound memory of `MemoryLayout<T>.stride * count'.
  ///
  /// The returned buffer is bound to the type, but not initialized.
  /// Clients should never call `deallocate()` on the returned buffer.
  /// In general, using `BumpPtrAllocator` for placing non-trivial values (e.g.
  /// class instances, existentials, etc.) is strongly discouraged because they
  /// are not automatically deinitialized.
  public func allocate<T>(_: T.Type, count: Int) -> UnsafeMutableBufferPointer<T> {
    let allocated = allocate(byteCount: MemoryLayout<T>.stride * count,
                             alignment: MemoryLayout<T>.alignment)
    return allocated.bindMemory(to: T.self)
  }

  /// Check if the address is managed by this allocator.
  public func contains(address: UnsafeRawPointer) -> Bool {
    func test(_ slab: Slab) -> Bool {
      UnsafeRawPointer(slab.baseAddress!) <= address && address < UnsafeRawPointer(slab.baseAddress!) + slab.count
    }
    return slabs.contains(where: test(_:)) || customSizeSlabs.contains(where: test(_:))
  }

  /// Estimated total memory size this allocator itself is consuming.
  ///
  /// This is always bigger than or equal to `totalByteSizeAllocated`.
  public var totalMemorySize: Int {
    var size = 0
    /// Slab sizes.
    size = slabs.reduce(size, { $0 + $1.count })
    size = customSizeSlabs.reduce(size, { $0 + $1.count })
    /// And the size of slab storage.
    size += MemoryLayout<Slab>.stride * (slabs.capacity + customSizeSlabs.capacity)
    return size
  }

  /// Total number of bytes allocated to the clients.
  ///
  /// This allocator is wasting `totalMemorySize - totalByteSizeAllocated` bytes
  /// of memory.
  public var totalByteSizeAllocated: Int {
    _totalBytesAllocated
  }
}

// MARK: Compatibilty Shims

#if swift(<5.7)
extension UnsafeMutableRawPointer {
  /// Obtain the next pointer whose bit pattern is a multiple of alignment.
  ///
  /// - Parameter alignment: The alignment of the returned pointer, in bytes.
  ///                        Alignment must be a whole power of 2.
  /// - Returns: A pointer aligned to `alignment`.
  fileprivate func alignedUp(toMultipleOf alignment: Int) -> Self {
    let mask = UInt(alignment) &- 1
    assert(
      alignment > 0 && UInt(alignment) & mask == 0,
      "alignment must be a whole power of 2."
    )
    let bits = (UInt(bitPattern: self) &+ mask) & ~mask
    return .init(bitPattern: bits)!
  }
}
#endif
