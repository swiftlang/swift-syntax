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

import SwiftSyntax
import XCTest

/// Returns the `ConcurrentEdits`s to transition from `base` to `new`.
public func getConcurrentEdits(from base: String, to new: String) -> ConcurrentEdits {
  let diffCollection = new.difference(from: base)

  let diffArray: [(offset: Int, isInsert: Bool)] =
    diffCollection
    .map { diff in
      switch diff {
      case .remove(offset: let offset, element: _, associatedWith: _):
        return (offset: offset, isInsert: false)
      case .insert(offset: let offset, element: _, associatedWith: _):
        return (offset: offset, isInsert: true)
      }
    }
    .sorted {
      // Change.remove should prior to Change.insert
      if $0.offset < $1.offset {
        return true
      } else if $0.offset == $1.offset {
        return !$0.isInsert
      } else {
        return false
      }
    }

  let sourceEdits = diffArray.map({
    if $0.isInsert {
      return SourceEdit(offset: $0.offset, length: 0, replacementLength: 1)
    } else {
      return SourceEdit(offset: $0.offset, length: 1, replacementLength: 0)
    }
  })

  return ConcurrentEdits(fromSequential: sourceEdits)
}

/// Apply the given edits to `testString` and return the resulting string.
/// `concurrent` specifies whether the edits should be interpreted as being
/// applied sequentially or concurrently.
public func applyEdits(
  _ edits: [SourceEdit],
  concurrent: Bool,
  to testString: String,
  replacementChar: Character = "?"
) -> String {
  guard let replacementAscii = replacementChar.asciiValue else {
    fatalError("replacementChar must be an ASCII character")
  }
  var edits = edits
  if concurrent {
    XCTAssert(ConcurrentEdits._isValidConcurrentEditArray(edits))

    // If the edits are concurrent, sorted and not overlapping (as guaranteed by
    // the check above, we can apply them sequentially to the string in reverse
    // order because later edits don't affect earlier edits.
    edits = edits.reversed()
  }
  var bytes = Array(testString.utf8)
  for edit in edits {
    assert(edit.endOffset <= bytes.count)
    bytes.removeSubrange(edit.offset..<edit.endOffset)
    bytes.insert(contentsOf: [UInt8](repeating: replacementAscii, count: edit.replacementLength), at: edit.offset)
  }
  return String(bytes: bytes, encoding: .utf8)!
}
