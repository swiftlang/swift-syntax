//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

public struct DiagnosticsFormatter {

  /// A wrapper struct for a source line and its diagnostics
  private struct AnnotatedSourceLine {
    var diagnostics: [Diagnostic]
    var sourceString: String
  }

  /// Number of lines which should be printed before and after the diagnostic message
  static let contextSize = 2

  /// Print given diagnostics for a given syntax tree on the command line
  public static func annotatedSource<SyntaxType: SyntaxProtocol>(tree: SyntaxType, diags: [Diagnostic]) -> String {
    let slc = SourceLocationConverter(file: "", tree: tree)

    // First, we need to put each line and its diagnostics together
    var annotatedSourceLines = [AnnotatedSourceLine]()

    for (sourceLineIndex, sourceLine) in slc.sourceLines.enumerated() {
      let diagsForLine = diags.filter { diag in
        return diag.location(converter: slc).line == (sourceLineIndex + 1)
      }
      annotatedSourceLines.append(AnnotatedSourceLine(diagnostics: diagsForLine, sourceString: sourceLine))
    }

    // Only lines with diagnostic messages should be printed, but including some context
    let rangesToPrint = annotatedSourceLines.enumerated().compactMap { (lineIndex, sourceLine) -> Range<Int>? in
      let lineNumber = lineIndex + 1
      if !sourceLine.diagnostics.isEmpty {
        return Range<Int>(uncheckedBounds: (lower: lineNumber - Self.contextSize, upper: lineNumber + Self.contextSize + 1))
      }
      return nil
    }

    var annotatedSource = ""

    /// Keep track if a line missing char should be printed
    var hasLineBeenSkipped = false

    let maxNumberOfDigits = String(annotatedSourceLines.count).count

    for (lineIndex, annotatedLine) in annotatedSourceLines.enumerated() {
      let lineNumber = lineIndex + 1
      guard
        rangesToPrint.contains(where: { range in
          range.contains(lineNumber)
        })
      else {
        hasLineBeenSkipped = true
        continue
      }

      // line numbers should be right aligned
      let lineNumberString = String(lineNumber)
      let leadingSpaces = String(repeating: " ", count: maxNumberOfDigits - lineNumberString.count)
      let linePrefix = "\(leadingSpaces)\(lineNumberString) │ "

      // If necessary, print a line that indicates that there was lines skipped in the source code
      if hasLineBeenSkipped && !annotatedSource.isEmpty {
        let lineMissingInfoLine = String(repeating: " ", count: maxNumberOfDigits) + " ┆"
        annotatedSource.append("\(lineMissingInfoLine)\n")
      }
      hasLineBeenSkipped = false

      // print the source line
      annotatedSource.append("\(linePrefix)\(annotatedLine.sourceString)")

      // If the line did not end with \n (e.g. the last line), append it manually
      if annotatedSource.last != "\n" {
        annotatedSource.append("\n")
      }

      let columnsWithDiagnostics = Set(annotatedLine.diagnostics.map { $0.location(converter: slc).column ?? 0 })
      let diagsPerColumn = Dictionary(grouping: annotatedLine.diagnostics) { diag in
        diag.location(converter: slc).column ?? 0
      }.sorted { lhs, rhs in
        lhs.key > rhs.key
      }

      for (column, diags) in diagsPerColumn {
        // compute the string that is shown before each message
        var preMessage = String(repeating: " ", count: maxNumberOfDigits) + " ∣"
        for c in 0..<column {
          if columnsWithDiagnostics.contains(c) {
            preMessage.append("│")
          } else {
            preMessage.append(" ")
          }
        }

        for diag in diags.dropLast(1) {
          annotatedSource.append("\(preMessage)├─ \(diag.message)\n")
        }
        annotatedSource.append("\(preMessage)╰─ \(diags.last!.message)\n")

      }
    }
    return annotatedSource
  }
}
