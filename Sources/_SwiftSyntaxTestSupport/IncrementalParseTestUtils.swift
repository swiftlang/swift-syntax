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

#if swift(>=6)
public import SwiftParser
public import SwiftSyntax
private import XCTest
#else
import SwiftParser
import SwiftSyntax
import XCTest
#endif

/// This function is used to verify the correctness of incremental parsing
/// containing three parts:
/// 1. Round-trip on the incrementally parsed syntax tree.
/// 2. verify that incrementally parsing the edited source base on the original source produces the same syntax tree as reparsing the post-edit file from scratch.
/// 3. verify the reused nodes fall into expectations.
///
/// - parameter reusedNodes: The element order should respect to the order of  `ReusedNodeSpec.source` in `source`.
///   e.g. for `source`
///   ```
///   func foo() {}
///   foo()
///   ```
///   The `reusedNodes` should be
///   ```
///   [
///     ReusedNodeSpec("func foo() {}", kind: .codeBlockItem),
///     ReusedNodeSpec("foo()", kind: .codeBlockItem)
///   ]
///    ```
public func assertIncrementalParse(
  _ source: String,
  reusedNodes expectedReusedNodes: [ReusedNodeSpec] = [],
  file: StaticString = #filePath,
  line: UInt = #line
) {
  let (concurrentEdits, originalSource, editedSource) = extractEditsAndSources(from: source)

  let originalString = String(originalSource)
  let editedString = String(editedSource)

  let parseResult = Parser.parseIncrementally(source: originalString, parseTransition: nil)

  var reusedNodes: [Syntax] = []
  let transition = IncrementalParseTransition(
    previousIncrementalParseResult: parseResult,
    edits: concurrentEdits,
    reusedNodeCallback: { reusedNodes.append($0) }
  )

  let newTree = Parser.parse(source: editedString)
  let incrementallyParsedNewTree = Parser.parseIncrementally(source: editedString, parseTransition: transition).tree

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
  let subtreeMatcher = SubtreeMatcher(incrementallyParsedNewTree, markers: [:])
  do {
    try subtreeMatcher.assertSameStructure(newTree, includeTrivia: true, file: file, line: line)
  } catch {
    XCTFail("Matching for a subtree failed with error: \(error)", file: file, line: line)
  }

  // Re-used nodes
  if reusedNodes.count != expectedReusedNodes.count {
    XCTFail(
      """
      Expected \(expectedReusedNodes.count) re-used nodes but received \(reusedNodes.count):
      \(reusedNodes.map {$0.description}.joined(separator: "\n"))
      """,
      file: file,
      line: line
    )
    return
  }

  var lastRangeUpperBound = originalString.startIndex
  for expectedReusedNode in expectedReusedNodes {
    guard let range = byteSourceRange(for: expectedReusedNode.source, in: originalString, after: lastRangeUpperBound) else {
      XCTFail("Fail to find string in original source,", file: expectedReusedNode.file, line: expectedReusedNode.line)
      continue
    }

    guard let reusedNode = reusedNodes.first(where: { $0.trimmedByteRange == range }) else {
      XCTFail(
        """
        Fail to match the range of \(expectedReusedNode.source) in:
        \(reusedNodes.map({"\($0.trimmedByteRange): \($0.description)"}).joined(separator: "\n"))
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

    lastRangeUpperBound = originalString.index(originalString.startIndex, offsetBy: range.endOffset)
  }
}

public func byteSourceRange(for substring: String, in sourceString: String, after: String.Index) -> ByteSourceRange? {
  if let range = sourceString[after...].range(of: substring) {
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
    file: StaticString = #filePath,
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
public func extractEditsAndSources(from source: String) -> (edits: ConcurrentEdits, orignialSource: Substring, editedSource: Substring) {
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
      replacement: Array(source.utf8[source.index(after: separateIndex)..<endIndex])
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
  to testString: String
) -> String {
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
    bytes.insert(contentsOf: edit.replacement, at: edit.offset)
  }
  return String(bytes: bytes, encoding: .utf8)!
}
