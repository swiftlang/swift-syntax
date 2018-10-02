//===----------- WeakLookupTable.swift - Swift Syntax Library -------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2018 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//
// This file provides lookup table with weak reference.
//===----------------------------------------------------------------------===//

/// Protocol for self-identifiable object
protocol Identifiable {
  associatedtype Identifier : Hashable
  var id: Identifier { get }
}

private struct WeakReference<T: AnyObject>: ExpressibleByNilLiteral {
  weak var value: T?
  init(_ value: T?) {
    self.value = value
  }
  init(nilLiteral: ()) {
    self.value = nil
  }
}

/// 'Set' like container providing lookup table for objects with identifier.
/// This doesn't take ownership of the objects. Instead, the objects are
/// held by weak references.
/// 
/// References are stored in a hash table with simple open adressing. Because
/// of weak reference, unlike normal open addressing, erased bucket are simply
/// turned into 'nil'.
class WeakLookupTable<Element: Identifiable & AnyObject> {

  /// Storage for the hash table.
  private var buckets: UnsafeMutablePointer<WeakReference<Element>>
  private var bucketCount: Int

  /// Estimated count of inserted values. This is greater than or equal to
  /// the number of actually occupied buckets.
  /// i.e. estimatedCount >= _countOccupiedBuckets()
  private var estimatedCount: Int

  init(capacity: Int = 0) {
    bucketCount = WeakLookupTable<Element>._bucketCount(for: capacity)
    buckets = .allocate(capacity: bucketCount)
    buckets.initialize(repeating: nil, count: bucketCount)
    estimatedCount = 0
  }

  deinit {
    buckets.deinitialize(count: bucketCount)
    buckets.deallocate()
  }

  /// Constant max load factor for hash table.
  private static var maxLoadFactor: Double {
    @inline(__always) get {
      return 0.75
    }
  }

  /// Minimal number of bucket count enough to hold specified capacity of
  /// objects with taking max load factor into account.
  private static func _minimalBucketCount(for capacity: Int) -> Int {
    return Int((Double(capacity) / maxLoadFactor).rounded(.up))
  }

  /// Number of bucket count to allocate to hold specified number of objects.
  /// This is the next power of 2 greater than or equal to
  /// '_minimalBucketCount(for: capacity)'
  private static func _bucketCount(for capacity: Int,
                                   from current: Int = 2) -> Int {
    // Bucket count must always be power of 2.
    precondition((current & (current - 1)) == 0)
    // Minimum is 2 to guarantee at least 1 hole.
    precondition(current >= 2)

    let minimalBucketCount = _minimalBucketCount(for: capacity)

    // Make sure it's representable. If 'minimalBucketCount' here is over
    // 0x4000_..., the bucket count must be 0x8000_... thus overflows.
    precondition(minimalBucketCount <= (Int.max >> 1) + 1)

    var bucketCount = current
    while bucketCount < minimalBucketCount {
      // '&*=' for performance. Guaranteed by above 'precondition()'.
      bucketCount &*= 2
    }
    return bucketCount
  }

  private var _bucketMask: Int {
    @inline(__always) get {
      // '&-' for performance. We know 'bucketCount >= 2'.
      return bucketCount &- 1
    }
  }

  @inline(__always)
  private func _idealBucket(for id: Element.Identifier) -> Int {
    return id.hashValue & _bucketMask
  }

  /// Finds the bucket where the object with the specified id should be stored
  /// to.
  private
  func _findHole(_ id: Element.Identifier) -> (pos: Int, alreadyExists: Bool) {
    var bucket = _idealBucket(for: id)

    // Starting from the ideal bucket for the id, search an available bucket,
    // or the bucket holding the id.
    while true {
      guard let obj = buckets[bucket].value else {
        return (bucket, false)
      }
      if obj.id == id {
        return (bucket, true)
      }
      // '&+' for performance. 'bucketCount' is 0x4000_... or below.
      bucket = (bucket &+ 1) & _bucketMask
    }
  }

  /// Reserves enough space to store the specified number of elements. Returns
  /// true if resizing happened.
  func reserveCapacity(_ requiredCapacity: Int) -> Bool {
    let requiredBucketCount = WeakLookupTable<Element>
      ._bucketCount(for: requiredCapacity, from: bucketCount)
    if (bucketCount >= requiredBucketCount) {
      return false
    }

    // Slow path. Resizing.
    let oldBuckets = buckets
    let oldBucketRange = buckets ..< buckets.advanced(by: bucketCount)

    bucketCount = requiredBucketCount
    buckets = .allocate(capacity: requiredBucketCount)
    buckets.initialize(repeating: nil, count: requiredBucketCount)

    // Move all nodes from the old buffer.
    for oldBucket in oldBucketRange {
      if let id = oldBucket.pointee.value?.id {
        let newBucket = buckets.advanced(by: _findHole(id).pos)
        newBucket.moveAssign(from: oldBucket, count: 1)
      } else {
        oldBucket.deinitialize(count: 1)
      }
    }

    oldBuckets.deallocate()

    return true
  }

  /// Count the actual number of occupied buckets.
  @inline(__always)
  private func _countOccupiedBuckets() -> Int {
    var count = 0
    for i in 0 ..< bucketCount where buckets[i].value != nil {
      // '&+=' for performance. 'bucketCount' is 0x4000_... or below.
      count &+= 1
    }
    return count
  }

  /// Reserves enough space to store a single new object. Returns true if
  /// resizing happened.
  private func _ensurePlusOneCapacity() -> Bool {
    // '&+' for performance. 'estimatedCount' is always less than 'bucketCount'
    // which is 0x4000_... or below.
    if bucketCount >= WeakLookupTable<Element>
                        ._minimalBucketCount(for: estimatedCount &+ 1) {
      return false
    }

    // Slow path.
    estimatedCount = _countOccupiedBuckets()
    // '&+' for performance. We know 'estimatedCount' derived by
    // '_countOccupiedBuckets()' is equal to or less than previous
    // 'estimatedCount'.
    return reserveCapacity(estimatedCount &+ 1)
  }

  /// Inserts the given object into the table if the table doesn't already
  /// contain an object with the same identifier.
  /// - returns: true if the object was inserted
  @discardableResult
  func insert(_ obj: Element) -> Bool {
    var (pos, alreadyExists) = _findHole(obj.id)
    if alreadyExists {
      return false
    }

    if /*resized=*/_ensurePlusOneCapacity() {
      pos = _findHole(obj.id).pos
    }
    buckets[pos].value = obj
    // '&+=' for performance. '_ensurePlusOneCapacity()' ensures it's safe.
    estimatedCount &+= 1
    return true
  }

  /// Get a object with specified id. Returns 'nil' if the object hasn't been
  /// insert()-ed or it's already been freed.
  subscript(id: Element.Identifier) -> Element? {
    // Since we don't fill the bucket when the object is freed (because we don't
    // know), we can't stop iteration at a hole. So in the worst case (i.e. if
    // the object doesn't exist in the table), full linear search is needed.
    // However, since we assume the object exists and hasn't been freed yet,
    // we expect it's stored near the 'idealBucket' anyway.
    let idealBucket = _idealBucket(for: id)
    var bucket = idealBucket
    repeat {
      if let obj = buckets[bucket].value, obj.id == id {
        return obj
      }
      // '&+' for performance. 'bucketCount' is 0x4000_... or below.
      bucket = (bucket &+ 1) & _bucketMask
    } while bucket != idealBucket

    return nil
  }
}
