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

#if swift(>=6.0)
#if canImport(Darwin)
private import Darwin
#elseif canImport(Glibc)
private import Glibc
#elseif canImport(Musl)
private import Musl
#endif
#else
#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#elseif canImport(Musl)
import Musl
#endif
#endif

/// Represent a string.
///
/// This type does not own the string data. The data reside in some other buffer
/// whose lifetime extends past that of the SyntaxText.
///
/// ``SyntaxText`` is a `Collection` of `UInt8` which is _expected_ to be a UTF8
/// encoded byte sequence. However, since that is essentially just a span of a
/// memory buffer, it may contain ill-formed UTF8 sequences. And their
/// comparison (e.g.`==`, hasPrefix()) are purely based on the byte sequences,
/// without any Unicode normalization or anything.
///
/// Since it's just a byte sequence, ``SyntaxText`` can represent the exact source
/// buffer regardless of whether it is a valid UTF8. When creating
/// `Swift.String`, ill-formed UTF8 sequences are replaced with the Unicode
/// replacement character (`\u{FFFD}`).
@_spi(RawSyntax)
public struct SyntaxText: Sendable {
  var buffer: SyntaxArenaAllocatedBufferPointer<UInt8>

  /// Construct a ``SyntaxText`` whose text is represented by the given `buffer`.
  public init(buffer: SyntaxArenaAllocatedBufferPointer<UInt8>) {
    self.buffer = buffer
  }

  /// Construct a ``SyntaxText`` whose text is represented by the memory starting
  /// at `baseAddress` and ranging `count` bytes.
  ///
  /// If count is not zero, `baseAddress` must not be `nil`.
  public init(baseAddress: UnsafePointer<UInt8>?, count: Int) {
    precondition(
      count == 0 || baseAddress != nil,
      "If count is not zero, base address must be exist"
    )
    buffer = .init(UnsafeBufferPointer(start: baseAddress, count: count))
  }

  /// Creates an empty ``SyntaxText``
  public init() {
    self.init(baseAddress: nil, count: 0)
  }

  /// Creates a ``SyntaxText`` from a `StaticString`
  public init(_ string: StaticString) {
    self.init(baseAddress: string.utf8Start, count: string.utf8CodeUnitCount)
  }

  /// Creates a ``SyntaxText`` over the same memory as the given slice.
  public init(rebasing slice: SubSequence) {
    self.init(
      baseAddress: slice.base.baseAddress?.advanced(by: slice.startIndex),
      count: slice.count
    )
  }

  /// Base address of the memory range this string refers to.
  ///
  /// If the `baseAddress` is `nil`, the text is empty. However, text can be
  /// `isEmpty` even with a non-`nil` base address.
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
  /// `SyntaxText(rebasing: text[n ..< m]).isSliceOf(text)` is always true as
  /// long as `n` and `m` are valid indices.
  public func isSlice(of other: SyntaxText) -> Bool {
    // If either of it is empty, returns 'true' only if both are empty.
    // Otherwise, returns 'false'.
    guard !self.isEmpty && !other.isEmpty else {
      return self.isEmpty && other.isEmpty
    }
    let selfEndBound = UnsafePointer<UInt8>(self.baseAddress! + count)
    let otherEndBound = UnsafePointer<UInt8>(other.baseAddress! + other.count)
    return (other.baseAddress! <= self.baseAddress!) && (selfEndBound <= otherEndBound)
  }

  /// Returns `true` if `other` is a substring of this ``SyntaxText``.
  public func contains(_ other: SyntaxText) -> Bool {
    return firstRange(of: other) != nil
  }

  /// Finds and returns the range of the first occurrence of `other` within this
  /// string. Returns `nil` if `other` is not found.
  public func firstRange(of other: SyntaxText) -> Range<Index>? {
    if other.isEmpty { return nil }
    let stop = self.count - other.count
    var start = 0
    // If 'other' is longer than 'self', 'stop' is less than zero, so the
    // condition is never satisfied.
    while start <= stop {
      // Force unwrappings are safe because we know 'self' and 'other' are both
      // not empty.
      if compareMemory(self.baseAddress! + start, other.baseAddress!, other.count) {
        return start..<(start + other.count)
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
    let prefixSlice = self[0..<other.count]
    return Self(rebasing: prefixSlice) == other
  }

  /// Returns `true` if the string ends with the specified suffix.
  public func hasSuffix(_ other: SyntaxText) -> Bool {
    guard self.count >= other.count else { return false }
    guard !other.isEmpty else { return true }
    let suffixSlice = self[(self.count - other.count)..<self.count]
    return Self(rebasing: suffixSlice) == other
  }
}

/// ``SyntaxText`` is a collection of `UInt8`.
extension SyntaxText: RandomAccessCollection {
  /// SyntaxText operates on bytes and each byte is represented by a `UInt8`.
  public typealias Element = UInt8

  /// ``SyntaxText`` is a continuous memory region that can be accessed by an integer.
  public typealias Index = Int

  /// `Slice<SyntaxText>` represents a part of a ``SyntaxText``.
  public typealias SubSequence = Slice<SyntaxText>

  /// The index of the first byte in ``SyntaxText``
  public var startIndex: Index { buffer.startIndex }

  /// The index one after the last byte in ``SyntaxText``.
  public var endIndex: Index { buffer.endIndex }

  /// Access the byte at `index`.
  public subscript(index: Index) -> Element {
    get { return buffer[index] }
  }
}

extension SyntaxText: Hashable {
  /// Returns `true` if `lhs` and `rhs` contain the same bytes.
  public static func == (lhs: SyntaxText, rhs: SyntaxText) -> Bool {
    if lhs.buffer.count != rhs.buffer.count {
      return false
    }
    guard let lBase = lhs.baseAddress, let rBase = rhs.baseAddress else {
      // If either `baseAddress` is `nil`, both are empty so returns `true`.
      return true
    }
    // We don't do `lhs.baseAddress == rhs.baseAddress` shortcut, because in
    // SwiftSyntax use cases, comparing the same SyntaxText instances is
    // extremely rare, and checking it causes extra branch.
    // The most common usage is comparing parsed text with a static text e.g.
    // `token.text == "func"`. In such cases `compareMemory`(`memcmp`) is
    // optimized to a `cmp` or similar opcode if either operand is a short static
    // text. So the same-baseAddress shortcut doesn't give us a huge performance
    // boost even if they actually refer the same memory.
    return compareMemory(lBase, rBase, lhs.count)
  }

  /// Hash the contents of this ``SyntaxText`` into `hasher`.
  public func hash(into hasher: inout Hasher) {
    hasher.combine(bytes: buffer.unsafeRawBufferPointer)
  }
}

extension SyntaxText: ExpressibleByStringLiteral {
  /// We can always safely create ``SyntaxText`` from a ``StaticString`` because
  /// ``StaticString`` is guaranteed to be alive for the entire execution
  /// duration of the process.
  public init(stringLiteral value: StaticString) { self.init(value) }

  /// We can always safely create ``SyntaxText`` from a ``StaticString`` because
  /// ``StaticString`` is guaranteed to be alive for the entire execution
  /// duration of the process.
  public init(unicodeScalarLiteral value: StaticString) { self.init(value) }

  /// We can always safely create ``SyntaxText`` from a ``StaticString`` because
  /// ``StaticString`` is guaranteed to be alive for the entire execution
  /// duration of the process.
  public init(extendedGraphemeClusterLiteral value: StaticString) { self.init(value) }
}

extension SyntaxText: CustomStringConvertible {
  /// The contents of this ``SyntaxText`` as a ``String``.
  ///
  /// Note that ``SyntaxText`` can represent invalid Unicode, while ``String``
  /// cannot, so if this text contains invalid UTF-8, the conversion is lossy.
  public var description: String { String(syntaxText: self) }
}

extension SyntaxText: CustomDebugStringConvertible {
  /// The string value of this text, which may be lossy if the text contains
  /// invalid Unicode. Don’t rely on this value being stable.
  public var debugDescription: String { description.debugDescription }
}

extension String {
  /// Creates a `String` from a ``SyntaxText``.
  ///
  /// Ill-formed UTF-8 sequences in `syntaxText` are replaced with the Unicode
  /// replacement character `\u{FFFD}`.
  @_spi(RawSyntax)
  public init(syntaxText: SyntaxText) {
    guard !syntaxText.isEmpty else {
      self = ""
      return
    }
    if #available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
      self.init(unsafeUninitializedCapacity: syntaxText.count) { strBuffer in
        strBuffer.initialize(from: syntaxText.buffer).1
      }
    } else {
      self.init(decoding: syntaxText, as: UTF8.self)
    }
  }

  /// Runs `body` with a ``SyntaxText`` that refers the contiguous memory of this
  /// string. Like `String.withUTF8(_:)`, this may mutate the string if this
  /// string was not contiguous.
  @_spi(RawSyntax)
  public mutating func withSyntaxText<R>(
    _ body: (SyntaxText) throws -> R
  ) rethrows -> R {
    try withUTF8 { utf8 in
      try body(SyntaxText(baseAddress: utf8.baseAddress, count: utf8.count))
    }
  }
}

private func compareMemory(
  _ s1: UnsafePointer<UInt8>,
  _ s2: UnsafePointer<UInt8>,
  _ count: Int
) -> Bool {
  precondition(count >= 0)
  #if canImport(Darwin)
  return Darwin.memcmp(s1, s2, count) == 0
  #elseif canImport(Glibc)
  return Glibc.memcmp(s1, s2, count) == 0
  #else
  return UnsafeBufferPointer(start: s1, count: count)
    .elementsEqual(UnsafeBufferPointer(start: s2, count: count))
  #endif
}
