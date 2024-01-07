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

// See `MemoryLayoutTest.swift`.
@_spi(Testing) public enum SyntaxMemoryLayout: Sendable {
  public struct Value: Equatable, Sendable {
    var size: Int
    var stride: Int
    var alignment: Int

    public init(size: Int, stride: Int, alignment: Int) {
      self.size = size
      self.stride = stride
      self.alignment = alignment
    }
    init<T>(_: T.Type) {
      self.init(
        size: MemoryLayout<T>.size,
        stride: MemoryLayout<T>.stride,
        alignment: MemoryLayout<T>.alignment
      )
    }
  }

  public static var values: [String: Value] {
    let uniq: (Value, Value) -> Value = { _, _ in preconditionFailure() }

    var result: [String: Value] = [:]
    result.merge(RawSyntaxDataMemoryLayouts, uniquingKeysWith: uniq)
    result.merge(SyntaxMemoryLayouts, uniquingKeysWith: uniq)
    return result
  }
}
