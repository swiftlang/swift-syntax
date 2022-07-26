//===---------- SyntaxText.swift - Unowned String Representation  ---------===//
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
#elseif canImport(Glibc)
import Glibc
#endif

/// Represent a string.
///
/// This type does not own the string data. The data reside in some other buffer
/// whose lifetime extends past that of the SyntaxText.
///
/// `SyntaxText` conforms to `Collection` where the element is `UInt8`.
@_spi(Testing) // SPI name is subject to change
public struct SyntaxText {
  var buffer: UnsafeBufferPointer<UInt8>

  public init(baseAddress: UnsafePointer<UInt8>?, count: Int) {
    assert(count == 0 || baseAddress != nil,
           "If count is not zero, base address must be exist")
    buffer = .init(start: baseAddress, count: count)
  }

  /// Creates an empty `SyntaxText`
  public init() {
    self.init(baseAddress: nil, count: 0)
  }

  /// Creates a `SyntaxText` from a `StaticString`
  public init(_ string: StaticString) {
    self.init(baseAddress: string.utf8Start, count: string.utf8CodeUnitCount)
  }

  /// Base address of the memory range this string refers to.
  public var baseAddress: UnsafePointer<UInt8>? {
    buffer.baseAddress
  }

  /// Byte length of this string.
  public var count: Int {
    buffer.count
  }

  /// A Boolean value indicating whether a string has no characters.
  public var isEmpty: Bool {
    buffer.isEmpty
  }

  /// Returns `true` if the memory range of this string is a part of `other`.
  ///
  /// `text[n ..< m].isSliceOf(text)` is always true as long as `n` and `m` are
  /// valid indices.
  public func isSliceOf(_ other: SyntaxText) -> Bool {
    guard !isEmpty && !other.isEmpty else {
      return isEmpty == other.isEmpty
    }
    return (other.baseAddress! <= baseAddress! &&
            baseAddress! + count <= other.baseAddress! + other.count)
  }

  /// Returns `true` if `other` is a substring of this `SyntaxText`.
  ///
  /// This should not be used because `SyntaxText` is a `Collection<UInt8>` and
  /// `contains(_:)` is usually for checking a collection contains the element.
  /// Using `contains(_:)` for subsequence is confusing.
  @available(*, deprecated, message: "Use 'firstRange(of:) != nil'")
  public func contains(_ other: SyntaxText) -> Bool {
    return firstRange(of: other) != nil
  }

  /// Finds and returns the range of the first occurrence of `other` within this
  /// string. Returns `nil` if `other` is not found.
  public func firstRange(of other: SyntaxText) -> Range<Index>? {
    if other.isEmpty { return nil }
    let needle = other.baseAddress!
    let stop = self.count - other.count
    var start = 0
    // If 'other' is longer than 'self', stop < 0.
    while start <= stop {
      if compareMemory(self.baseAddress! + start, needle, other.count) {
        return start ..< (start + other.count)
      } else {
        start += 1
      }
    }
    return nil
  }

  /// Returns `true` if the string begins with the specified prefix.
  public func hasPrefix(_ other: SyntaxText) -> Bool {
    guard self.count >= other.count else { return false }
    guard !other.isEmpty else { return true }
    return self[0..<other.count] == other
  }

  /// Returns `true` if the string ends with the specified suffix.
  public func hasSuffix(_ other: SyntaxText) -> Bool {
    guard self.count >= other.count else { return false }
    guard !other.isEmpty else { return true }
    return self[(self.count - other.count)..<self.count] == other
  }
}

/// `SyntaxText` is a collection of `UInt8`.
extension SyntaxText: RandomAccessCollection {
  public typealias Element = UInt8
  public typealias Index = Int
  public typealias SubSequence = SyntaxText

  public var startIndex: Index { buffer.startIndex }
  public var endIndex: Index { buffer.endIndex }

  public subscript(bounds: Range<Index>) -> SyntaxText {
    if isEmpty && bounds.isEmpty { return self }
    return SyntaxText(
      baseAddress: buffer.baseAddress! + bounds.lowerBound,
      count: bounds.count)
  }

  public subscript(position: Index) -> Element {
    unsafeAddress { buffer.baseAddress!.advanced(by: position) }
  }
}

extension SyntaxText: Hashable {
  public static func ==(lhs: SyntaxText, rhs: SyntaxText) -> Bool {
    if lhs.buffer.count != rhs.buffer.count {
      return false
    }
    if lhs.buffer.baseAddress == rhs.buffer.baseAddress {
      return true
    }
    return compareMemory(lhs.baseAddress!, rhs.baseAddress!, lhs.count)
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(bytes: .init(buffer))
  }
}

extension SyntaxText: ExpressibleByStringLiteral {
  public init(stringLiteral value: StaticString) { self.init(value) }
  public init(unicodeScalarLiteral value: StaticString) { self.init(value) }
  public init(extendedGraphemeClusterLiteral value: StaticString) { self.init(value) }
}

extension SyntaxText: CustomStringConvertible {
  public var description: String { String(syntaxText: self) }
}

extension SyntaxText: CustomDebugStringConvertible {
  public var debugDescription: String { description.debugDescription }
}

extension String {
  /// Creates a `String` from a `SyntaxText`.
  ///
  /// Ill-formed UTF-8 sequences in `syntaxText` are replaced with the Unicode
  /// replacement character `\u{FFFD}`.
  @_spi(Testing)
  public init(syntaxText: SyntaxText) {
    guard !syntaxText.isEmpty else {
      self = ""
      return
    }
    let count = syntaxText.count
    if #available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
      self.init(unsafeUninitializedCapacity: count) { strBuffer in
        copyMemory(strBuffer.baseAddress!, syntaxText.baseAddress!, count)
        return count
      }
    } else {
      self.init(decoding: syntaxText, as: UTF8.self)
    }
  }

  /// Runs `body` with a `SyntaxText` that refers the contiguous memory of this
  /// string. Like `String.withUTF8(_:)`, this may mutates the string if this
  /// string was not contiguous.
  @_spi(Testing)
  public mutating func withSyntaxText<R>(
    _ body: (SyntaxText) throws -> R
  ) rethrows -> R {
    try withUTF8 { utf8 in
      try body(SyntaxText(baseAddress: utf8.baseAddress, count: utf8.count))
    }
  }
}

private func compareMemory(
  _ s1: UnsafePointer<UInt8>, _ s2: UnsafePointer<UInt8>, _ count: Int
) -> Bool {
  assert(count > 0)
#if canImport(Darwin)
  return Darwin.memcmp(s1, s2, count) == 0
#elseif canImport(Glibc)
  return Glibc.memcmp(s1, s2, count) == 0
#else
  return UnsafeBufferPointer(start: s1, count: count)
    .elementsEqual(UnsafeBufferPointer(start: s2, count: count))
#endif
}

private func copyMemory(
  _ dst: UnsafeMutablePointer<UInt8>, _ src: UnsafePointer<UInt8>, _ count: Int
) {
  assert(count > 0)
#if canImport(Darwin)
  Darwin.memcpy(dst, src, count)
#elseif canImport(Glibc)
  Glibc.memcpy(dst, src, count)
#else
  dst.initialize(from: src, count: count)
#endif
}
