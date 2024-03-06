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
    to tree: any SyntaxProtocol
  ) -> String {
    let messages = messages ?? diagnostics.compactMap { $0.fixIts.first?.message.message }

    let edits =
      diagnostics
      .flatMap(\.fixIts)
      .filter { messages.contains($0.message.message) }
      .flatMap(\.edits)

    return self.apply(edits: edits, to: tree)
  }

  /// Apply the given edits to the syntax tree.
  ///
  /// - Parameters:
  ///   - edits: The edits to apply to the syntax tree
  ///   - tree: he syntax tree to which the edits should be applied.
  /// - Returns: A `String` representation of the modified syntax tree after applying the edits.
  public static func apply(
    edits: [SourceEdit],
    to tree: any SyntaxProtocol
  ) -> String {
    var edits = edits
    var source = tree.description

    while let edit = edits.first {
      edits = Array(edits.dropFirst())

      let startIndex = source.utf8.index(source.utf8.startIndex, offsetBy: edit.startUtf8Offset)
      let endIndex = source.utf8.index(source.utf8.startIndex, offsetBy: edit.endUtf8Offset)

      source.replaceSubrange(startIndex..<endIndex, with: edit.replacement)

      edits = edits.compactMap { remainingEdit -> SourceEdit? in
        if remainingEdit.replacementRange.overlaps(edit.replacementRange) {
          // The edit overlaps with the previous edit. We can't apply both
          // without conflicts. Apply the one that's listed first and drop the
          // later edit.
          return nil
        }

        // If the remaining edit starts after or at the end of the edit that we just applied,
        // shift it by the current edit's difference in length.
        if edit.endUtf8Offset <= remainingEdit.startUtf8Offset {
          let startPosition = AbsolutePosition(utf8Offset: remainingEdit.startUtf8Offset - edit.replacementRange.count + edit.replacementLength)
          let endPosition = AbsolutePosition(utf8Offset: remainingEdit.endUtf8Offset - edit.replacementRange.count + edit.replacementLength)
          return SourceEdit(range: startPosition..<endPosition, replacement: remainingEdit.replacement)
        }

        return remainingEdit
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

  var replacementLength: Int {
    return replacement.utf8.count
  }

  var replacementRange: Range<Int> {
    return startUtf8Offset..<endUtf8Offset
  }
}
