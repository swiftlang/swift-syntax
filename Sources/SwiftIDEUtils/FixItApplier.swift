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

#if compiler(>=6)
public import SwiftDiagnostics
public import SwiftSyntax
#else
import SwiftDiagnostics
import SwiftSyntax
#endif

@_spi(FixItApplier)
public enum FixItApplier {
  /// Applies selected or all Fix-Its from the provided diagnostics to a given syntax tree.
  ///
  /// - Parameters:
  ///   - diagnostics: An array of `Diagnostic` objects, each containing one or more Fix-Its.
  ///   - filterByMessages: An optional array of message strings to filter which Fix-Its to apply.
  ///     If `nil`, the first Fix-It from each diagnostic is applied.
  ///   - tree: The syntax tree to which the Fix-Its will be applied.
  ///   - allowDuplicateInsertions: Whether to apply duplicate insertions.
  ///     Defaults to `true`.
  ///
  /// - Returns: A `String` representation of the modified syntax tree after applying the Fix-Its.
  public static func applyFixes(
    from diagnostics: [Diagnostic],
    filterByMessages messages: [String]?,
    to tree: some SyntaxProtocol,
    allowDuplicateInsertions: Bool = true
  ) -> String {
    let messages = messages ?? diagnostics.compactMap { $0.fixIts.first?.message.message }

    // FIXME: This assumes every fix-it is applied to a node in the 'tree', which is not guaranteed.
    let edits =
      diagnostics
      .flatMap(\.fixIts)
      .filter { messages.contains($0.message.message) }
      .flatMap(\.edits)

    return self.apply(edits: edits, to: tree, allowDuplicateInsertions: allowDuplicateInsertions)
  }

  /// Applies the given edits to the given syntax tree.
  ///
  /// - Parameters:
  ///   - edits: The edits to apply.
  ///   - tree: The syntax tree to which the edits should be applied.
  ///   - allowDuplicateInsertions: Whether to apply duplicate insertions.
  ///     Defaults to `true`.
  ///
  /// - Returns: A `String` representation of the modified syntax tree.
  public static func apply(
    edits: [SourceEdit],
    to tree: some SyntaxProtocol,
    allowDuplicateInsertions: Bool = true
  ) -> String {
    var edits = edits
    var source = tree.description

    for var editIndex in edits.indices {
      let edit = edits[editIndex]

      // Empty edits do nothing.
      guard !edit.isEmpty else {
        continue
      }

      do {
        let utf8 = source.utf8
        let startIndex = utf8.index(utf8.startIndex, offsetBy: edit.startUtf8Offset)
        let endIndex = utf8.index(utf8.startIndex, offsetBy: edit.endUtf8Offset)

        source.replaceSubrange(startIndex..<endIndex, with: edit.replacement)
      }

      // Drop any subsequent edits that conflict with one we just applied, and
      // adjust the range of the rest.
      while edits.formIndex(after: &editIndex) != edits.endIndex {
        let remainingEdit = edits[editIndex]

        // Empty edits do nothing.
        guard !remainingEdit.isEmpty else {
          continue
        }

        func shouldDropRemainingEdit() -> Bool {
          // Insertions never conflict between themselves, unless we were asked
          // to drop duplicate insertions.
          if edit.range.isEmpty && remainingEdit.range.isEmpty {
            if allowDuplicateInsertions {
              return false
            }

            return edit == remainingEdit
          }

          // Edits conflict in the following cases:
          //
          // - Their ranges have a common element.
          // - One's range is empty and its lower bound is strictly within the
          //   other's range. So 0..<2 also conflicts with 1..<1, but not with
          //   0..<0 or 2..<2.
          //
          return edit.endUtf8Offset > remainingEdit.startUtf8Offset
            && edit.startUtf8Offset < remainingEdit.endUtf8Offset
        }

        guard !shouldDropRemainingEdit() else {
          // Drop the edit by swapping it for an empty one.
          edits[editIndex] = SourceEdit()
          continue
        }

        // If the remaining edit starts after or at the end of the edit that we just applied,
        // shift it by the current edit's difference in length.
        if edit.endUtf8Offset <= remainingEdit.startUtf8Offset {
          let shift = edit.replacementLength.utf8Length - edit.range.count
          let startPosition = AbsolutePosition(utf8Offset: remainingEdit.startUtf8Offset + shift)
          let endPosition = AbsolutePosition(utf8Offset: remainingEdit.endUtf8Offset + shift)

          edits[editIndex] = SourceEdit(range: startPosition..<endPosition, replacement: remainingEdit.replacement)
        }
      }
    }

    return source
  }
}

private extension Collection {
  func formIndex(after index: inout Index) -> Index {
    self.formIndex(after: &index) as Void
    return index
  }
}

private extension SourceEdit {
  var startUtf8Offset: Int {
    return range.lowerBound.utf8Offset
  }

  var endUtf8Offset: Int {
    return range.upperBound.utf8Offset
  }

  var isEmpty: Bool {
    self.range.isEmpty && self.replacement.isEmpty
  }

  init() {
    self = SourceEdit(
      range: AbsolutePosition(utf8Offset: 0)..<AbsolutePosition(utf8Offset: 0),
      replacement: []
    )
    precondition(self.isEmpty)
  }
}
