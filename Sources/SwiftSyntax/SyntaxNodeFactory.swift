//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// Reusable 'Syntax.Info' storage.
private struct SyntaxInfoRepository {
  private final class _Buffer: ManagedBuffer<Int, Syntax.Info?> {
    deinit {
      self.withUnsafeMutablePointers { headerPtr, elementPtr in
        _ = elementPtr.deinitialize(count: headerPtr.pointee)
      }
    }
  }

  /// Fixed capacity which is enough for most use cases.
  static var capacity: Int { 64 }

  private let buffer: _Buffer

  init() {
    let buffer = _Buffer.create(minimumCapacity: Self.capacity, makingHeaderWith: { _ in 0 })
    self.buffer = buffer as! _Buffer
  }

  /// Take the 'Syntax.Info' object from the address.
  func push(_ info: UnsafeMutablePointer<Syntax.Info?>) {
    buffer.withUnsafeMutablePointers { headerPtr, elementPtr in
      guard headerPtr.pointee < Self.capacity else {
        return
      }
      assert(info.pointee != nil, "tried to push 'nil' info")
      elementPtr.advanced(by: headerPtr.pointee).moveInitialize(from: info, count: 1)
      info.initialize(to: nil)
      headerPtr.pointee += 1
    }
  }

  /// Vend a 'Swift.Info' object if available.
  func pop() -> Syntax.Info? {
    return buffer.withUnsafeMutablePointers { headerPtr, elementPtr in
      guard headerPtr.pointee > 0 else {
        return nil
      }
      headerPtr.pointee -= 1
      return elementPtr.advanced(by: headerPtr.pointee).move()
    }
  }
}

/// 'Syntax' object factory. This may hold some stocks of recycled 'Syntax.Info'.
struct SyntaxNodeFactory {
  private let syntaxInfoRepo: SyntaxInfoRepository = SyntaxInfoRepository()

  /// Create a 'Syntax' instance using the supplied info.
  ///
  /// If this factory has a recycled 'Syntax.Info', use one of them. Otherwise, just create a instance by allocating a new one.
  @inline(__always)
  func create(parent: Syntax, raw: RawSyntax, absoluteInfo: AbsoluteSyntaxInfo) -> Syntax {
    if let info = syntaxInfoRepo.pop() {
      info.info = .nonRoot(.init(parent: parent, absoluteInfo: absoluteInfo))
      return Syntax(raw, info: info)
    } else {
      return Syntax(raw, parent: parent, absoluteInfo: absoluteInfo)
    }
  }

  /// Dispose a 'Syntax' object.
  ///
  /// 'node.info' is collected for future reuse. 'node' is not usable after calling this.
  @inline(__always)
  func dispose(_ node: inout Syntax) {
    if isKnownUniquelyReferenced(&node.info) {
      node.info.unsafelyUnwrapped.info = nil
      syntaxInfoRepo.push(&node.info)
    }
  }
}
