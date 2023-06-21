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
import SwiftParser
import XCTest

/// This function is used to verify the correctness of incremental parsing
/// containing three parts:
/// 1. Round-trip on the incrementally parsed syntax tree.
/// 2. verify that incrementally parsing the edited source base on the original source produces the same syntax tree as reparsing the post-edit file from scratch.
/// 3. verify the reused nodes fall into expectations.
public func assertIncrementalParse(
  _ source: String,
  reusedNodes expectedReusedNodes: [ReusedNodeSpec] = [],
  file: StaticString = #file,
  line: UInt = #line
) {
  let (concurrentEdits, originalSource, editedSource) = getEditsAndSources(source)

  let originalString = String(originalSource)
  let editedString = String(editedSource)

  let originalTree = Parser.parse(source: originalString)

  let reusedNodesCollector = IncrementalParseReusedNodeCollector()
  let transition = IncrementalParseTransition(previousTree: originalTree, edits: concurrentEdits, reusedNodeDelegate: reusedNodesCollector)

  let newTree = Parser.parse(source: editedString)
  let incrementallyParsedNewTree = Parser.parse(source: editedString, parseTransition: transition)

  // Round-trip
  assertStringsEqualWithDiff(
    editedString,
    "\(incrementallyParsedNewTree)",
    additionalInfo: """
      Source failed to round-trip when parsing incrementally

      Actual syntax tree:
      \(incrementallyParsedNewTree.debugDescription)
      """,
    file: file,
    line: line
  )

  // Substructure
  let subtreeMatcher = SubtreeMatcher(Syntax(incrementallyParsedNewTree), markers: [:])
  do {
    try subtreeMatcher.assertSameStructure(Syntax(newTree), includeTrivia: true, file: file, line: line)
  } catch {
    XCTFail("Matching for a subtree failed with error: \(error)", file: file, line: line)
  }

  // Re-used nodes
  if reusedNodesCollector.rangeAndNodes.count != expectedReusedNodes.count {
    XCTFail(
      """
      Expected \(expectedReusedNodes.count) re-used nodes but received \(reusedNodesCollector.rangeAndNodes.count):
      \(reusedNodesCollector.rangeAndNodes.map {$0.1.description}.joined(separator: "\n"))
      """,
      file: file,
      line: line
    )
    return
  }

  for expectedReusedNode in expectedReusedNodes {
    guard let range = getByteSourceRange(for: expectedReusedNode.source, in: originalString) else {
      XCTFail("Fail to find string in original source,", file: expectedReusedNode.file, line: expectedReusedNode.line)
      continue
    }

    guard let reusedNode = reusedNodesCollector.rangeAndNodes.first(where: { $0.0 == range })?.1 else {
      XCTFail(
        """
        Fail to match the range of \(expectedReusedNode.source) in:
        \(reusedNodesCollector.rangeAndNodes.map({"\($0.0): \($0.1.description)"}).joined(separator: "\n"))
        """,
        file: expectedReusedNode.file,
        line: expectedReusedNode.line
      )
      continue
    }

    XCTAssertEqual(
      expectedReusedNode.kind,
      expectedReusedNode.kind,
      """
      Expected \(expectedReusedNode.kind) syntax kind but received \(reusedNode.kind)
      """,
      file: expectedReusedNode.file,
      line: expectedReusedNode.line
    )
  }
}

fileprivate func getByteSourceRange(for substring: String, in sourceString: String) -> ByteSourceRange? {
  if let range = sourceString.range(of: substring) {
    return ByteSourceRange(
      offset: sourceString.utf8.distance(from: sourceString.startIndex, to: range.lowerBound),
      length: sourceString.utf8.distance(from: range.lowerBound, to: range.upperBound)
    )
  }
  return nil
}

/// An abstract data structure to describe the how a re-used node produced by the incremental parse should look like.
public struct ReusedNodeSpec {
  /// The re-used string in original source without any ``Trivia``
  let source: String
  /// The ``SyntaxKind`` of re-used node
  let kind: SyntaxKind
  /// The file and line at which this ``ReusedNodeSpec`` was created, so that assertion failures can be reported at its location.
  let file: StaticString
  let line: UInt

  public init(
    _ source: String,
    kind: SyntaxKind,
    file: StaticString = #file,
    line: UInt = #line
  ) {
    self.source = source
    self.kind = kind
    self.file = file
    self.line = line
  }
}

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
  var concurrentEdits: [IncrementalEdit] = []

  var lastStartIndex = source.startIndex
  while let startIndex = source[lastStartIndex...].firstIndex(where: { $0 == "⏩️" }),
    let separateIndex = source[startIndex...].firstIndex(where: { $0 == "⏸️" }),
    let endIndex = source[separateIndex...].firstIndex(where: { $0 == "⏪️" })
  {

    originalSource += source[lastStartIndex..<startIndex]
    let edit = IncrementalEdit(
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
  _ edits: [IncrementalEdit],
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
