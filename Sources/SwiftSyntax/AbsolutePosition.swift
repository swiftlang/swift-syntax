//===--------------- AbsolutePosition.swift - Source Positions ------------===//
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

/// An absolute position in a source file as text - the absolute utf8Offset from
/// the start of the file.
public struct AbsolutePosition: Comparable {
  public let utf8Offset: Int

  static let startOfFile = AbsolutePosition(utf8Offset: 0)

  public init(utf8Offset: Int) {
    self.utf8Offset = utf8Offset
  }

  public static func <(lhs: AbsolutePosition, rhs: AbsolutePosition) -> Bool {
    return lhs.utf8Offset < rhs.utf8Offset
  }
}


extension SyntaxProtocol {
  public var position: AbsolutePosition {
    AbsolutePosition(utf8Offset: byteOffset)
  }

  public var positionAfterSkippingLeadingTrivia: AbsolutePosition {
    guard let tok = self.isToken ? self.syntax : firstToken?.syntax else {
      return position
    }
    return AbsolutePosition(
      utf8Offset: byteOffset + tok.raw.leadingTriviaByteLength)
  }

  public var endPositionBeforeTrailingTrivia: AbsolutePosition {
    guard let tok = self.isToken ? self.syntax : lastToken?.syntax else {
      return endPosition
    }
    return AbsolutePosition(
      utf8Offset: byteOffset + byteLength - tok.raw.trailingTriviaByteLength)
  }

  public var endPosition: AbsolutePosition {
    AbsolutePosition(utf8Offset: byteOffset + byteLength)
  }
}
