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

/// A ``BumpPtrAllocator`` that allocates `slabSize` at a time.
/// `slabSize` initiates with `initialSlabSize` and doubles periodically as allocations occur.
/// Once all memory in a slab has been used, it allocates a new slab and no
/// memory allocations are necessary until that slab is completely filled up.
@_spi(BumpPtrAllocator) @_spi(Testing)
public class BumpPtrAllocator {
  typealias Slab = UnsafeMutableRawBufferPointer

  static private let GROWTH_DELAY: Int = 128
  static private let SLAB_ALIGNMENT: Int = 8

  private let initialSlabSize: Int

  private var slabs: [Slab]
  /// Pair of pointers in the current slab.
  /// - pointer: Points to the next unused address in `slabs.last`.
  /// - end: Points to the end address of `slabs.last`. This is equivalent to
  ///        `slabs.last!.baseAddress! + slabs.last!.count`
  /// 'nil' if `slabs` is empty.
  private var current:
    (
      pointer: UnsafeMutableRawPointer,
      end: UnsafeMutableRawPointer
    )?
  private var customSizeSlabs: [Slab]
  private var _totalBytesAllocated: Int

  /// Construct a new ``BumpPtrAllocator``.
  public init(initialSlabSize: Int) {
    self.initialSlabSize = initialSlabSize
    slabs = []
    current = nil
    customSizeSlabs = []
    _totalBytesAllocated = 0
  }

  deinit {
    /// Deallocate all memory.
    while let slab = slabs.popLast() {
      slab.deallocate()
    }
    while let slab = customSizeSlabs.popLast() {
      slab.deallocate()
    }
  }

  /// Calculate the size of the slab at the index.
  private func slabSize(at index: Int) -> Int {
    // Double the slab size every 'GROWTH_DELAY' slabs.
    return self.initialSlabSize * (1 << min(30, index / Self.GROWTH_DELAY))
  }

  private func startNewSlab() {
    let newSlabSize = self.slabSize(at: slabs.count)
    let newSlab = Slab.allocate(
      byteCount: newSlabSize,
      alignment: Self.SLAB_ALIGNMENT
    )
    let pointer = newSlab.baseAddress!
    current = (pointer, pointer.advanced(by: newSlabSize))
    slabs.append(newSlab)
  }

  /// Allocate 'byteCount' of memory from the current slab if available.
  private func allocateFromCurrentSlab(
    _ byteCount: Int,
    _ alignment: Int
  ) -> UnsafeMutableRawBufferPointer? {
    guard let current = self.current else {
      return nil
    }

    let aligned = current.pointer.alignedUp(toMultipleOf: alignment)
    guard byteCount <= aligned.distance(to: current.end) else {
      return nil
    }

    // Bump the pointer, and return the allocated buffer.
    self.current = (aligned + byteCount, current.end)
    return .init(start: aligned, count: byteCount)
  }

  /// Allocate 'byteCount' of memory.
  ///
  /// The returned buffer is not bound to any types, nor initialized.
  /// Clients should never call `deallocate()` on the returned buffer.
  public func allocate(byteCount: Int, alignment: Int) -> UnsafeMutableRawBufferPointer {

    assert(alignment <= Self.SLAB_ALIGNMENT)
    guard byteCount > 0 else {
      return .init(start: nil, count: 0)
    }

    // Track the total size we allocated.
    _totalBytesAllocated += byteCount

    // Check if the current slab has enough space.
    if let allocated = allocateFromCurrentSlab(byteCount, alignment) {
      return allocated
    }

    // If the size is too big, allocate a dedicated slab for it.
    if byteCount >= self.initialSlabSize {
      let customSlab = Slab.allocate(
        byteCount: byteCount,
        alignment: alignment
      )
      customSizeSlabs.append(customSlab)
      return customSlab
    }

    // Otherwise, start a new slab and try again.
    startNewSlab()
    if let allocated = allocateFromCurrentSlab(byteCount, alignment) {
      return allocated
    }
    fatalError("Unable to allocate memory!")
  }

  /// Allocate a chunk of bound memory of `MemoryLayout<T>.stride * count'.
  ///
  /// The returned buffer is bound to the type, but not initialized.
  /// Clients should never call `deallocate()` on the returned buffer.
  /// In general, using ``BumpPtrAllocator`` for placing non-trivial values (e.g.
  /// class instances, existentials, etc.) is strongly discouraged because they
  /// are not automatically deinitialized.
  public func allocate<T>(_: T.Type, count: Int) -> UnsafeMutableBufferPointer<T> {
    let allocated = allocate(
      byteCount: MemoryLayout<T>.stride * count,
      alignment: MemoryLayout<T>.alignment
    )
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

// MARK: Compatibility Shims

extension UnsafeMutableRawPointer {
  /// Obtain the next pointer whose bit pattern is a multiple of alignment.
  ///
  /// - Parameter alignment: The alignment of the returned pointer, in bytes.
  ///                        Alignment must be a whole power of 2.
  /// - Returns: A pointer aligned to `alignment`.
  @_spi(Testing)
  public func alignedUp(toMultipleOf alignment: Int) -> Self {
    let mask = UInt(alignment) &- 1
    assert(
      alignment > 0 && UInt(alignment) & mask == 0,
      "alignment must be a whole power of 2."
    )
    let bits = (UInt(bitPattern: self) &+ mask) & ~mask
    return .init(bitPattern: bits)!
  }
}
