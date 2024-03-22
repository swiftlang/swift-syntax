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

import Darwin
import Foundation
import MachO
import SwiftRefactor

extension SourceEditorExtension {
  static func forEachRefactoringProvider(_ action: (any SyntaxRefactoringProvider.Type) -> Void) {
    guard let header = _dyld_get_image_header(0) else {
      return
    }

    var size: UInt = 0
    let section = header.withMemoryRebound(to: mach_header_64.self, capacity: 1) { pointer in
      getsectiondata(pointer, "__TEXT", "__swift5_proto", &size)
    }

    guard let section = section else {
      return
    }

    let rawSection = UnsafeRawPointer(section)
    for start in stride(from: rawSection, to: rawSection + Int(size), by: MemoryLayout<Int32>.stride) {
      let address = start.load(as: RelativeDirectPointer<ConformanceDescriptor>.self).address(from: start)
      let conformance = Conformance(raw: address)

      guard let context = conformance.context, context.moduleDescriptor.isSwiftRefactorModule else {
        continue
      }

      guard let typeMetadata = context.metadata(), let provider = typeMetadata as? any SyntaxRefactoringProvider.Type
      else {
        continue
      }

      action(provider)
    }
  }
}

struct Conformance {
  enum Kind: UInt16 {
    case direct = 0x0
    case indirect = 0x1
  }

  var raw: UnsafeRawPointer

  var `protocol`: Context {
    let maybeProtocol = RelativeIndirectablePointer<ContextDescriptor>(
      offset: self.raw.load(as: ConformanceDescriptor.self).protocol
    )
    return Context(raw: maybeProtocol.address(from: self.raw))
  }

  var context: Context? {
    let start = self.raw + MemoryLayout<Int32>.size
    let offset = start.load(as: Int32.self)
    let addr = start + Int(offset)
    let kind = UInt16(self.raw.load(as: ConformanceDescriptor.self).flags & (0x7 << 3)) >> 3
    switch Conformance.Kind(rawValue: kind) {
    case .direct:
      return Context(raw: addr)
    case .indirect:
      return addr.load(as: Context.self)
    case nil:
      return nil
    }
  }
}

struct Context: Hashable {
  struct Flags: OptionSet {
    var rawValue: UInt32

    var kind: Context.Kind? {
      return Context.Kind(rawValue: UInt8(self.rawValue & 0x1F))
    }
  }

  enum Kind: UInt8 {
    case `class` = 0x11
    case `struct` = 0x12
    case `enum` = 0x13
  }

  var raw: UnsafeRawPointer

  var parent: Context? {
    let parent = RelativeIndirectablePointer<ContextDescriptor>(
      offset: self.raw.load(as: ContextDescriptor.self).parent
    )

    guard parent.offset != 0 else {
      return nil
    }

    let start = self.raw + MemoryLayout<Int32>.size
    return Context(raw: parent.address(from: start))
  }

  var moduleDescriptor: ModuleContext {
    var result = self

    while let parent = result.parent {
      result = parent
    }

    return ModuleContext(raw: result.raw)
  }

  func metadata() -> Any.Type? {
    guard Context.Flags(rawValue: self.raw.load(as: ContextDescriptor.self).flags).kind != nil else {
      return nil
    }

    let typeDescriptor = self.raw.load(as: TypeContextDescriptor.self)
    let start = self.raw + MemoryLayout<TypeContextDescriptor>.offset(of: \.accessor)!
    let accessor = RelativeDirectPointer<Void>(offset: typeDescriptor.accessor)
    let access = MetadataAccessor(raw: accessor.address(from: start))
    let fn = unsafeBitCast(access.raw, to: (@convention(thin) (Int) -> MetadataResponse).self)
    return fn(0).type
  }
}

struct MetadataAccessor {
  var raw: UnsafeRawPointer
}

struct MetadataResponse {
  let type: Any.Type
  let state: Int
}

struct ModuleContext {
  var raw: UnsafeRawPointer

  var name: String {
    let typeDescriptor = self.raw.load(as: ModuleContextDescriptor.self)
    let start = self.raw + MemoryLayout<ModuleContextDescriptor>.offset(of: \.name)!
    let name = RelativeDirectPointer<CChar>(offset: typeDescriptor.name)
    return
      name
      .address(from: start)
      .withMemoryRebound(to: CChar.self, capacity: 1) { pointer in
        return String(cString: pointer)
      }
  }
}

extension ModuleContext {
  var isSwiftRefactorModule: Bool {
    return self.name == "SwiftRefactor"
  }
}

struct RelativeDirectPointer<Pointee> {
  var offset: Int32

  func address(from pointer: UnsafeRawPointer) -> UnsafeRawPointer {
    return pointer + UnsafeRawPointer.Stride(self.offset)
  }
}

struct RelativeIndirectablePointer<Pointee> {
  var offset: Int32

  func address(from pointer: UnsafeRawPointer) -> UnsafeRawPointer {
    let dest = pointer + Int(self.offset & ~1)

    // If the low bit is set, then this is an indirect address. Otherwise,
    // it's direct.
    if Int(offset) & 1 == 1 {
      return dest.load(as: UnsafeRawPointer.self)
    } else {
      return dest
    }
  }
}
