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

/// Simple LRU cache.
@_spi(Testing)
public class LRUCache<Key: Hashable, Value> {
  private class _Node {
    unowned var prev: _Node? = nil
    unowned var next: _Node? = nil

    let key: Key
    var value: Value

    init(key: Key, value: Value) {
      self.key = key
      self.value = value
    }
  }

  private var table: [Key: _Node]

  // Double linked list
  private unowned var head: _Node?
  private unowned var tail: _Node?

  public let capacity: Int

  public init(capacity: Int) {
    self.table = [:]
    self.head = nil
    self.tail = nil
    self.capacity = capacity
  }

  public var count: Int {
    return table.count
  }

  public subscript(key: Key) -> Value? {
    get {
      guard let node = table[key] else {
        return nil
      }
      moveToHead(node: node)
      return node.value
    }

    set {
      switch (table[key], newValue) {
      case let (nil, newValue?):  // create.
        self.ensureCapacityForNewValue()
        let node = _Node(key: key, value: newValue)
        addToHead(node: node)
        table[key] = node

      case let (node?, newValue?):  // update.
        moveToHead(node: node)
        node.value = newValue

      case let (node?, nil):  // delete.
        remove(node: node)
        table[key] = nil

      case (nil, nil):  // no-op.
        break
      }
    }
  }

  private func ensureCapacityForNewValue() {
    while self.table.count >= self.capacity, let tail = self.tail {
      remove(node: tail)
      table[tail.key] = nil
    }
  }

  private func moveToHead(node: _Node) {
    if node === self.head {
      return
    }
    remove(node: node)
    addToHead(node: node)
  }

  private func addToHead(node: _Node) {
    node.next = self.head
    node.next?.prev = node
    node.prev = nil
    self.head = node
    if self.tail == nil {
      self.tail = node
    }
  }

  private func remove(node: _Node) {
    node.next?.prev = node.prev
    node.prev?.next = node.next
    if node === self.head {
      self.head = node.next
    }
    if node === self.tail {
      self.tail = node.prev
    }
    node.prev = nil
    node.next = nil
  }
}
