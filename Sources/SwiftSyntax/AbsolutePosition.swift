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

/// An absolute position in a source file as text - the absolute utf8Offset from
/// the start of the file.
public struct AbsolutePosition: Comparable, Hashable, Sendable {
  public let utf8Offset: Int

  static let startOfFile = AbsolutePosition(utf8Offset: 0)

  public init(utf8Offset: Int) {
    self.utf8Offset = utf8Offset
  }

  public func advanced(by offset: Int) -> AbsolutePosition {
    return AbsolutePosition(utf8Offset: self.utf8Offset + offset)
  }

  public static func < (lhs: AbsolutePosition, rhs: AbsolutePosition) -> Bool {
    return lhs.utf8Offset < rhs.utf8Offset
  }
}
