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

extension Sequence where Element == Range<Int> {
  /// Given a set of ranges that are sorted in order of nondecreasing lower
  /// bound, merge any overlapping ranges to produce a sequence of
  /// nonoverlapping ranges.
  fileprivate func mergingOverlappingRanges() -> [Range<Int>] {
    var result: [Range<Int>] = []

    var prior: Range<Int>? = nil
    for range in self {
      // If this is the first range we've seen, note it as the prior and
      // continue.
      guard let priorRange = prior else {
        prior = range
        continue
      }

      // If the ranges overlap, expand the prior range.
      precondition(priorRange.lowerBound <= range.lowerBound)
      if priorRange.overlaps(range) {
        let lower = priorRange.lowerBound
        let upper = Swift.max(priorRange.upperBound, range.upperBound)
        prior = lower..<upper
        continue
      }

      // Append the prior range, then take this new range as the prior
      result.append(priorRange)
      prior = range
    }

    if let priorRange = prior {
      result.append(priorRange)
    }
    return result
  }
}

public struct DiagnosticsFormatter {

  /// A wrapper struct for a source line, its diagnostics, and any
  /// non-diagnostic text that follows the line.
  private struct AnnotatedSourceLine {
    var diagnostics: [Diagnostic]
    var sourceString: String

    /// Non-diagnostic text that is appended after this source line.
    ///
    /// Suffix text can be used to provide more information following a source
    /// line, such as to provide an inset source buffer for a macro expansion
    /// that occurs on that line.
    var suffixText: String

    /// Whether this line is free of annotations.
    var isFreeOfAnnotations: Bool {
      return diagnostics.isEmpty && suffixText.isEmpty
    }
  }

  /// Number of lines which should be printed before and after the diagnostic message
  public let contextSize: Int

  /// Whether to colorize formatted diagnostics.
  public let colorize: Bool

  public init(contextSize: Int = 2, colorize: Bool = false) {
    self.contextSize = contextSize
    self.colorize = colorize
  }

  public static func annotatedSource(
    tree: some SyntaxProtocol,
    diags: [Diagnostic],
    contextSize: Int = 2,
    colorize: Bool = false
  ) -> String {
    let formatter = DiagnosticsFormatter(contextSize: contextSize, colorize: colorize)
    return formatter.annotatedSource(tree: tree, diags: diags)
  }

  /// Colorize the given source line by applying highlights from diagnostics.
  private func colorizeSourceLine(
    _ annotatedLine: AnnotatedSourceLine,
    lineNumber: Int,
    tree: some SyntaxProtocol,
    sourceLocationConverter slc: SourceLocationConverter
  ) -> String {
    guard colorize, !annotatedLine.diagnostics.isEmpty else {
      return annotatedLine.sourceString
    }

    // Compute the set of highlight ranges that land on this line. These
    // are column ranges, sorted in order of increasing starting column, and
    // with overlapping ranges merged.
    let highlightRanges: [Range<Int>] = annotatedLine.diagnostics.map {
      $0.highlights
    }.joined().compactMap { (highlight) -> Range<Int>? in
      if highlight.root != Syntax(tree) {
        return nil
      }

      let startLoc = highlight.startLocation(converter: slc, afterLeadingTrivia: true)
      let startLine = startLoc.line

      // Find the starting column.
      let startColumn: Int
      if startLine < lineNumber {
        startColumn = 1
      } else if startLine == lineNumber {
        startColumn = startLoc.column
      } else {
        return nil
      }

      // Find the ending column.
      let endLoc = highlight.endLocation(converter: slc, afterTrailingTrivia: false)
      let endLine = endLoc.line

      let endColumn: Int
      if endLine > lineNumber {
        endColumn = annotatedLine.sourceString.count
      } else if endLine == lineNumber {
        endColumn = endLoc.column
      } else {
        return nil
      }

      if startColumn == endColumn {
        return nil
      }

      return startColumn..<endColumn
    }.sorted { (lhs, rhs) in
      lhs.lowerBound < rhs.lowerBound
    }.mergingOverlappingRanges()

    // Map the column ranges into index ranges within the source string itself.
    let sourceStringUTF8 = annotatedLine.sourceString.utf8
    let highlightIndexRanges: [Range<String.Index>] = highlightRanges.map { highlightRange in
      let startIndex = sourceStringUTF8.index(sourceStringUTF8.startIndex, offsetBy: highlightRange.lowerBound - 1)
      let endIndex = sourceStringUTF8.index(startIndex, offsetBy: highlightRange.count)
      return startIndex..<endIndex
    }

    // Form the annotated string by copying in text from the original source,
    // highlighting the column ranges.
    var resultSourceString: String = ""
    let annotation = ANSIAnnotation.sourceHighlight
    let sourceString = annotatedLine.sourceString
    var sourceIndex = sourceString.startIndex
    for highlightRange in highlightIndexRanges {
      // Text before the highlight range
      resultSourceString += sourceString[sourceIndex..<highlightRange.lowerBound]

      // Highlighted source text
      let highlightString = String(sourceString[highlightRange])
      resultSourceString += annotation.applied(to: highlightString)

      sourceIndex = highlightRange.upperBound
    }

    resultSourceString += sourceString[sourceIndex...]
    return resultSourceString
  }

  /// Print given diagnostics for a given syntax tree on the command line
  ///
  /// - Parameters:
  ///   - suffixTexts: suffix text to be printed at the given absolute
  ///                  locations within the source file.
  func annotatedSource(
    tree: some SyntaxProtocol,
    diags: [Diagnostic],
    indentString: String,
    suffixTexts: [AbsolutePosition: String],
    sourceLocationConverter: SourceLocationConverter? = nil
  ) -> String {
    let slc = sourceLocationConverter ?? SourceLocationConverter(fileName: "<unknown>", tree: tree)

    // First, we need to put each line and its diagnostics together
    var annotatedSourceLines = [AnnotatedSourceLine]()

    for (sourceLineIndex, sourceLine) in slc.sourceLines.enumerated() {
      let diagsForLine = diags.filter { diag in
        return diag.location(converter: slc).line == (sourceLineIndex + 1)
      }
      let suffixText = suffixTexts.compactMap { (position, text) in
        if slc.location(for: position).line == (sourceLineIndex + 1) {
          return text
        }

        return nil
      }.joined()

      annotatedSourceLines.append(AnnotatedSourceLine(diagnostics: diagsForLine, sourceString: sourceLine, suffixText: suffixText))
    }

    // Only lines with diagnostic messages should be printed, but including some context
    let rangesToPrint = annotatedSourceLines.enumerated().compactMap { (lineIndex, sourceLine) -> Range<Int>? in
      let lineNumber = lineIndex + 1
      if !sourceLine.isFreeOfAnnotations {
        return Range<Int>(uncheckedBounds: (lower: lineNumber - contextSize, upper: lineNumber + contextSize + 1))
      }
      return nil
    }

    // Accumulate the fully annotated source files here.
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
      let linePrefix = "\(leadingSpaces)\(colorizeBufferOutline("\(lineNumberString) │")) "

      // If necessary, print a line that indicates that there was lines skipped in the source code
      if hasLineBeenSkipped && !annotatedSource.isEmpty {
        let lineMissingInfoLine = indentString + String(repeating: " ", count: maxNumberOfDigits) + " \(colorizeBufferOutline("┆"))"
        annotatedSource.append("\(lineMissingInfoLine)\n")
      }
      hasLineBeenSkipped = false

      // add indentation
      annotatedSource.append(indentString)

      // print the source line
      annotatedSource.append(linePrefix)
      annotatedSource.append(
        colorizeSourceLine(
          annotatedLine,
          lineNumber: lineNumber,
          tree: tree,
          sourceLocationConverter: slc
        )
      )

      // If the line did not end with \n (e.g. the last line), append it manually
      if annotatedSource.last != "\n" {
        annotatedSource.append("\n")
      }

      let columnsWithDiagnostics = Set(annotatedLine.diagnostics.map { $0.location(converter: slc).column })
      let diagsPerColumn = Dictionary(grouping: annotatedLine.diagnostics) { diag in
        diag.location(converter: slc).column
      }.sorted { lhs, rhs in
        lhs.key > rhs.key
      }

      for (column, diags) in diagsPerColumn {
        // compute the string that is shown before each message
        var preMessage = indentString + String(repeating: " ", count: maxNumberOfDigits) + " " + colorizeBufferOutline("│")
        for c in 0..<column {
          if columnsWithDiagnostics.contains(c) {
            preMessage.append("│")
          } else {
            preMessage.append(" ")
          }
        }

        for diag in diags.dropLast(1) {
          annotatedSource.append("\(preMessage)├─ \(colorizeIfRequested(diag.diagMessage))\n")
        }
        annotatedSource.append("\(preMessage)╰─ \(colorizeIfRequested(diags.last!.diagMessage))\n")
      }

      // Add suffix text.
      annotatedSource.append(annotatedLine.suffixText)
      if annotatedSource.last != "\n" {
        annotatedSource.append("\n")
      }
    }
    return annotatedSource
  }

  /// Print given diagnostics for a given syntax tree on the command line
  public func annotatedSource(
    tree: some SyntaxProtocol,
    diags: [Diagnostic]
  ) -> String {
    return annotatedSource(
      tree: tree,
      diags: diags,
      indentString: "",
      suffixTexts: [:]
    )
  }

  /// Annotates the given ``DiagnosticMessage`` with an appropriate ANSI color code (if the value of the `colorize`
  /// property is `true`) and returns the result as a printable string.
  func colorizeIfRequested(_ message: DiagnosticMessage) -> String {
    colorizeIfRequested(severity: message.severity, message: message.message)
  }

  /// Annotates a diagnostic message with the given severity and text with an appropriate ANSI color code.
  func colorizeIfRequested(severity: DiagnosticSeverity, message: String) -> String {
    let severityText: String
    let severityAnnotation: ANSIAnnotation

    switch severity {
    case .error:
      severityText = "error"
      severityAnnotation = .errorText

    case .warning:
      severityText = "warning"
      severityAnnotation = .warningText

    case .note:
      severityText = "note"
      severityAnnotation = .noteText

    case .remark:
      severityText = "remark"
      severityAnnotation = .remarkText
    }

    let prefix = colorizeIfRequested("\(severityText): ", annotation: severityAnnotation, resetAfter: false)

    return prefix + colorizeIfRequested(message, annotation: .diagnosticText);
  }

  /// Apply the given color and trait to the specified text, when we are
  /// supposed to color the output.
  private func colorizeIfRequested(
    _ text: String,
    annotation: ANSIAnnotation,
    resetAfter: Bool = true
  ) -> String {
    guard colorize, !text.isEmpty else {
      return text
    }

    return annotation.applied(to: text, resetAfter: resetAfter)
  }

  /// Colorize for the buffer outline and line numbers.
  func colorizeBufferOutline(_ text: String) -> String {
    colorizeIfRequested(text, annotation: .bufferOutline)
  }
}

struct ANSIAnnotation {
  enum Color: UInt8 {
    case normal = 0
    case black = 30
    case red = 31
    case green = 32
    case yellow = 33
    case blue = 34
    case magenta = 35
    case cyan = 36
    case white = 37
    case `default` = 39
  }

  enum Trait: UInt8 {
    case normal = 0
    case bold = 1
    case underline = 4
  }

  var color: Color
  var trait: Trait

  /// The textual representation of the annotation.
  var code: String {
    "\u{001B}[\(trait.rawValue);\(color.rawValue)m"
  }

  init(color: Color, trait: Trait = .normal) {
    self.color = color
    self.trait = trait
  }

  func withTrait(_ trait: Trait) -> Self {
    return ANSIAnnotation(color: self.color, trait: trait)
  }

  func applied(to message: String, resetAfter: Bool = true) -> String {
    guard resetAfter else {
      return "\(code)\(message)"
    }

    // Resetting after the message ensures that we don't color unintended lines in the output
    return "\(code)\(message)\(ANSIAnnotation.normal.code)"
  }

  /// The "normal" or "reset" ANSI code used to unset any previously added annotation.
  static var normal: ANSIAnnotation {
    self.init(color: .normal, trait: .normal)
  }

  /// Annotation used for the outline and line numbers of a buffer.
  static var bufferOutline: ANSIAnnotation {
    ANSIAnnotation(color: .cyan, trait: .normal)
  }

  /// Annotation used for highlighting source text.
  static var sourceHighlight: ANSIAnnotation {
    ANSIAnnotation(color: .default, trait: .underline)
  }

  static var diagnosticText: ANSIAnnotation {
    ANSIAnnotation(color: .default, trait: .bold)
  }

  static var errorText: ANSIAnnotation {
    ANSIAnnotation(color: .red, trait: .bold)
  }

  static var warningText: ANSIAnnotation {
    ANSIAnnotation(color: .yellow, trait: .bold)
  }

  static var noteText: ANSIAnnotation {
    ANSIAnnotation(color: .default, trait: .bold)
  }

  static var remarkText: ANSIAnnotation {
    ANSIAnnotation(color: .blue, trait: .bold)
  }
}
