//===---------- StringRef.swift - Unowned String Representation  ----------===//
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
import Darwin
#endif

private func compareMemory(_ s1: UnsafePointer<UInt8>, _ s2: UnsafePointer<UInt8>, _ count: Int) -> Bool {
  // FIXME: Need performance check.
  assert(count > 0)
#if canImport(Darwin)
  return Darwin.memcmp(s1, s2, count) == 0
#else
  return UnsafeBufferPointer(start: s1, count: count)
    .elementsEqual(UnsafeBufferPointer(start: s2, count: count))
#endif
}
private func copyMemory(_ dst: UnsafeMutablePointer<UInt8>, _ src: UnsafePointer<UInt8>, _ count: Int) {
  // FIXME: Need performance check.
  assert(count > 0)
#if canImport(Darwin)
  Darwin.memcpy(dst, src, count)
#else
  dst.initialize(from: src, count: count)
#endif
}

/// Represent a string.
///
/// This type does not own the string data. The data reside in some other buffer
/// whose lifetime extends past that of the StringRef.
public struct StringRef {
  public var buffer: UnsafeBufferPointer<UInt8>

  @inlinable
  public init(baseAddress: UnsafePointer<UInt8>?, count: Int) {
    assert(count == 0 || baseAddress != nil,
           "If count is not zero, base address must be exist")
    buffer = .init(start: baseAddress, count: count)
  }

  @inlinable
  public init() {
    self.init(baseAddress: nil, count: 0)
  }

  @inlinable
  public init(_ string: StaticString) {
    self.init(baseAddress: string.utf8Start, count: string.utf8CodeUnitCount)
  }

  @inlinable
  public var baseAddress: UnsafePointer<UInt8>? {
    buffer.baseAddress
  }

  @inlinable
  public var count: Int {
    buffer.count
  }

  @inlinable
  public var isEmpty: Bool {
    buffer.isEmpty
  }

  @inlinable
  func isSliceOf(_ other: StringRef) -> Bool {
    guard !isEmpty && !other.isEmpty else {
      return isEmpty == other.isEmpty
    }
    return (other.baseAddress! <= baseAddress! &&
            baseAddress! + count <= other.baseAddress! + other.count)
  }

  @available(*, deprecated, message: "Use 'firstRange(of:) != nil'")
  public func contains(_ other: StringRef) -> Bool {
    return firstRange(of: other) != nil
  }

  public func firstRange(of other: StringRef) -> Range<Index>? {
    if other.isEmpty { return nil }
    let needle = other.baseAddress!
    let stop = self.count - other.count
    var start = 0
    // If 'other' is longer than 'self', stop < 0.
    while start <= stop {
      if compareMemory(self.baseAddress! + start, needle, other.count) {
        return start..<other.count
      } else {
        start += 1
      }
    }
    return nil
  }

  @inlinable
  public func hasPrefix(_ other: StringRef) -> Bool {
    guard self.count <= other.count else { return false }
    return self[0..<other.count] == other
  }

  @inlinable
  public func hasSuffix(_ other: StringRef) -> Bool {
    guard self.count <= other.count else { return false }
    return self[(self.count - other.count)..<self.count] == other
  }
}

/// `StringRef` is a collection of `UInt8`.
extension StringRef: RandomAccessCollection {
  public typealias Element = UInt8
  public typealias Index = Int
  public typealias SubSequence = StringRef

  @inlinable
  public var startIndex: Index { buffer.startIndex }
  @inlinable
  public var endIndex: Index { buffer.endIndex }

  @inlinable
  public subscript(bounds: Range<Index>) -> StringRef {
    if isEmpty && bounds.isEmpty { return self }
    return StringRef(baseAddress: buffer.baseAddress! + bounds.startIndex,
              count: bounds.count)
  }

  @inlinable
  public subscript(position: Index) -> Element {
    unsafeAddress { buffer.baseAddress!.advanced(by: position) }
  }
}

extension StringRef: Hashable {
  public static func ==(lhs: StringRef, rhs: StringRef) -> Bool {
    if lhs.buffer.count != rhs.buffer.count {
      return false
    }
    if lhs.buffer.baseAddress == rhs.buffer.baseAddress {
      return true
    }
    return compareMemory(lhs.baseAddress!, rhs.baseAddress!, lhs.count)
  }

  @inlinable
  public func hash(into hasher: inout Hasher) {
    hasher.combine(bytes: .init(buffer))
  }
}

extension StringRef: ExpressibleByStringLiteral {
  @inlinable public init(stringLiteral value: StaticString) { self.init(value) }
  @inlinable public init(unicodeScalarLiteral value: StaticString) { self.init(value) }
  @inlinable public init(extendedGraphemeClusterLiteral value: StaticString) { self.init(value) }
}

extension StringRef: CustomStringConvertible {
  @inlinable
  public var description: String { String(stringRef: self) }
}
extension StringRef: CustomDebugStringConvertible {
  @inlinable
  public var debugDescription: String { description.debugDescription }
}
extension StringRef: CustomReflectable {
  public var customMirror: Mirror {
    Mirror(self, children: [
      "baseAddress": baseAddress ?? (nil as Any?) as Any,
      "count": count,
    ])
  }
}

extension String {
  public init(stringRef: StringRef) {
    guard !stringRef.isEmpty else {
      self = ""
      return
    }
    let count = stringRef.count
    if #available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
      self.init(unsafeUninitializedCapacity: count) { strBuffer in
        copyMemory(strBuffer.baseAddress!, stringRef.baseAddress!, count)
        return count
      }
    } else {
      self.init(decoding: stringRef, as: UTF8.self)
    }
  }

  public mutating func withStringRef<T>(_ body: (StringRef) -> T) -> T {
    withUTF8 { buffer in
      body(StringRef(baseAddress: buffer.baseAddress, count: buffer.count))
    }
  }
}
