//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// Copied from swift-foundation

//===----------------------------------------------------------------------===//
// Coding Path Node
//===----------------------------------------------------------------------===//

// This construction allows overall fewer and smaller allocations as the coding path is modified.
internal enum _CodingPathNode {
  case root
  indirect case node(CodingKey, _CodingPathNode)
  indirect case indexNode(Int, _CodingPathNode)

  var path: [any CodingKey] {
    switch self {
    case .root:
      return []
    case let .node(key, parent):
      return parent.path + [key]
    case let .indexNode(index, parent):
      return parent.path + [_CodingKey(index: index)]
    }
  }

  @inline(__always)
  func appending(_ key: __owned (some CodingKey)?) -> _CodingPathNode {
    if let key {
      return .node(key, self)
    } else {
      return self
    }
  }

  @inline(__always)
  func path(byAppending key: __owned (some CodingKey)?) -> [CodingKey] {
    if let key {
      return self.path + [key]
    }
    return self.path
  }

  // Specializations for indexes, commonly used by unkeyed containers.
  @inline(__always)
  func appending(index: __owned Int) -> _CodingPathNode {
    .indexNode(index, self)
  }

  func path(byAppendingIndex index: __owned Int) -> [CodingKey] {
    self.path + [_CodingKey(index: index)]
  }
}

//===----------------------------------------------------------------------===//
// Shared Key Type
//===----------------------------------------------------------------------===//

internal enum _CodingKey: CodingKey {
  case string(String)
  case int(Int)
  case index(Int)

  @inline(__always)
  public init?(stringValue: String) {
    self = .string(stringValue)
  }

  @inline(__always)
  public init?(intValue: Int) {
    self = .int(intValue)
  }

  @inline(__always)
  internal init(index: Int) {
    self = .index(index)
  }

  var stringValue: String {
    switch self {
    case let .string(str): return str
    case let .int(int): return "\(int)"
    case let .index(index): return "Index \(index)"
    }
  }

  var intValue: Int? {
    switch self {
    case .string: return nil
    case let .int(int): return int
    case let .index(index): return index
    }
  }
}
