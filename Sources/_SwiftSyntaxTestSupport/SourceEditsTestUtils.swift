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

/// Get `ConcurrentEdits` in source whose edited zones are marked with markers
/// Also extract the markers from source to get original source and edited source
///
/// `⏩️` is  *start marker*, `⏸️` is *separate marker*, `⏪️` is *end marker*
/// Contents between `⏩️` and `⏸️` are source text that before modification, contents
/// betwwen `⏸️` and `⏪️` are source text that after modification
/// i.e. `⏩️foo⏸️bar⏪️`, the original source is `foo` and the edited source is `bar`
public func getEditsAndSources(_ source: String) -> (edits: ConcurrentEdits, orignialSource: Substring, editedSource: Substring) {
  var editedSource = Substring()
  var originalSource = Substring()
  var concurrentEdits: [SourceEdit] = []

  var lastStartIndex = source.startIndex
  while let startIndex = source[lastStartIndex...].firstIndex(where: { $0 == "⏩️" }),
    let separateIndex = source[startIndex...].firstIndex(where: { $0 == "⏸️" }),
    let endIndex = source[separateIndex...].firstIndex(where: { $0 == "⏪️" })
  {

    originalSource += source[lastStartIndex..<startIndex]
    let edit = SourceEdit(
      offset: originalSource.utf8.count,
      length: source.utf8.distance(
        from: source.index(after: startIndex),
        to: separateIndex
      ),
      replacementLength: source.utf8.distance(
        from: source.index(after: separateIndex),
        to: endIndex
      )
    )
    originalSource += source[source.index(after: startIndex)..<separateIndex]

    editedSource += source[lastStartIndex..<startIndex] + source[source.index(after: separateIndex)..<endIndex]

    concurrentEdits.append(edit)

    lastStartIndex = source.index(after: endIndex)
  }

  editedSource += source[lastStartIndex...]
  originalSource += source[lastStartIndex...]

  do {
    let edits = try ConcurrentEdits(concurrent: concurrentEdits)
    return (edits, originalSource, editedSource)
  } catch {
    fatalError("ConcurrentEdits created by the test case do not satisfy ConcurrentEdits requirements, please check the test setup")
  }
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
