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
  ///
  /// - Returns: A `String` representation of the modified syntax tree after applying the Fix-Its.
  public static func applyFixes(
    from diagnostics: [Diagnostic],
    filterByMessages messages: [String]?,
    to tree: some SyntaxProtocol
  ) -> String {
    let messages = messages ?? diagnostics.compactMap { $0.fixIts.first?.message.message }

    // FIXME: This assumes every fix-it is applied to a node in the 'tree', which is not guaranteed.
    let edits =
      diagnostics
      .flatMap(\.fixIts)
      .filter { messages.contains($0.message.message) }
      .flatMap(\.edits)

    return self.apply(edits: edits, to: tree)
  }

  /// Applies the given edits to the given syntax tree.
  ///
  /// - Parameters:
  ///   - edits: The edits to apply.
  ///   - tree: The syntax tree to which the edits should be applied.
  /// - Returns: A `String` representation of the modified syntax tree.
  public static func apply(
    edits: [SourceEdit],
    to tree: some SyntaxProtocol
  ) -> String {
    var edits = edits
    var source = tree.description

    while let edit = edits.first {
      edits = Array(edits.dropFirst())

      // Empty edits do nothing.
      guard !edit.isEmpty else {
        continue
      }

      let startIndex = source.utf8.index(source.utf8.startIndex, offsetBy: edit.startUtf8Offset)
      let endIndex = source.utf8.index(source.utf8.startIndex, offsetBy: edit.endUtf8Offset)

      source.replaceSubrange(startIndex..<endIndex, with: edit.replacement)

      // Drop any subsequent edits that conflict with one we just applied, and
      // adjust the range of the rest.
      for i in edits.indices {
        let remainingEdit = edits[i]

        guard !remainingEdit.range.overlaps(edit.range) else {
          // The edit overlaps with the previous edit. We can't apply both
          // without conflicts. Drop this one by swapping it for a no-op
          // edit.
          edits[i] = SourceEdit()
          continue
        }

        // If the remaining edit starts after or at the end of the edit that we just applied,
        // shift it by the current edit's difference in length.
        if edit.endUtf8Offset <= remainingEdit.startUtf8Offset {
          let shift = edit.replacementLength.utf8Length - edit.range.count
          let startPosition = AbsolutePosition(utf8Offset: remainingEdit.startUtf8Offset + shift)
          let endPosition = AbsolutePosition(utf8Offset: remainingEdit.endUtf8Offset + shift)

          edits[i] = SourceEdit(range: startPosition..<endPosition, replacement: remainingEdit.replacement)
        }
      }
    }

    return source
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
