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
public import SwiftSyntax
#else
import SwiftSyntax
#endif

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
  /// A wrapper struct for a source line, its annotations (diagnostics
  /// and notes), along with any non-diagnostic text that follows the line.
  private struct AnnotatedSourceLine {
    // An abstraction for a diagnostic or note that is anchored to a source line.
    enum Annotation {
      case diagnostic(Diagnostic)
      case note(Note, category: DiagnosticCategory?)

      func location(converter: SourceLocationConverter) -> SourceLocation {
        switch self {
        case .diagnostic(let diag):
          return diag.location(converter: converter)
        case .note(let note, _):
          return note.location(converter: converter)
        }
      }
    }

    /// Annotations (diagnostics or notes) anchored to this source line.
    var annotations: [Annotation]
    /// The source line itself.
    var sourceString: String

    /// Non-diagnostic text that is appended after this source line.
    ///
    /// Suffix text can be used to provide more information following a source
    /// line, such as to provide an inset source buffer for a macro expansion
    /// that occurs on that line.
    var suffixText: String

    /// Whether this line is free of annotations.
    var isFreeOfAnnotations: Bool {
      return annotations.isEmpty && suffixText.isEmpty
    }

    /// Converts a UTF-8 column index into an index that considers each character as a single column, not each UTF-8
    /// byte.
    ///
    /// For example the 👨‍👩‍👧‍👦 character is considered as a single character, not 25 bytes.
    ///
    /// Both the input and the output column are 1-based.
    func characterColumn(ofUtf8Column utf8Column: Int) -> Int {
      let index =
        sourceString.utf8.index(
          sourceString.utf8.startIndex,
          offsetBy: utf8Column - 1,
          limitedBy: sourceString.utf8.endIndex
        ) ?? sourceString.utf8.endIndex
      return sourceString.distance(from: sourceString.startIndex, to: index) + 1
    }
  }

  /// Number of lines which should be printed before and after the diagnostic message
  public let contextSize: Int

  /// An instance that conforms to the ``DiagnosticDecorator`` protocol, responsible for formatting diagnostic messages.
  ///
  /// This property allows for the flexible customization of diagnostic messages, buffer outlines, and code highlighting.
  /// Different implementations can be swapped in to tailor the output according to user preferences or specific environmental conditions.
  let diagnosticDecorator: DiagnosticDecorator

  @available(*, deprecated, message: "Store the `colorize` property passed to the initializer instead")
  public var colorize: Bool {
    return diagnosticDecorator is ANSIDiagnosticDecorator
  }

  public init(contextSize: Int = 2, colorize: Bool = false) {
    self.contextSize = contextSize
    self.diagnosticDecorator = colorize ? .ANSI : .basic
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
    if annotatedLine.annotations.isEmpty {
      return annotatedLine.sourceString
    }

    // Compute the set of highlight ranges that land on this line. These
    // are column ranges, sorted in order of increasing starting column, and
    // with overlapping ranges merged.
    let highlightRanges: [Range<Int>] = annotatedLine.annotations.map { annotation in 
      // Only diagnostics have highlights; notes don't.
      switch annotation {
      case .diagnostic(let diag):
        return diag.highlights
      case .note:
        // TODO: Should a note add a `note.node`
        return []
      }
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
        endColumn = annotatedLine.sourceString.utf8.count
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
    let sourceString = annotatedLine.sourceString
    var sourceIndex = sourceString.startIndex
    for highlightRange in highlightIndexRanges {
      // Text before the highlight range
      resultSourceString += sourceString[sourceIndex..<highlightRange.lowerBound]

      // Highlighted source text
      let highlightString = String(sourceString[highlightRange])
      resultSourceString += diagnosticDecorator.decorateHighlight(highlightString).highlightedSourceCode

      sourceIndex = highlightRange.upperBound
    }

    resultSourceString += sourceString[sourceIndex...]
    return resultSourceString
  }

  /// Print given diagnostics for a given syntax tree on the command line
  ///
  /// - Parameters:
  ///   - tree: The syntax tree for which diagnostics should be printed
  ///   - diags: The diagnostics to print
  ///   - indentString: The string prefixed to each line of the annotated 
  ///       source.
  ///   - suffixTexts: Suffix text to be printed at the given absolute
  ///       locations within the source file.
  ///   - includeNotes: Whether notes should be included in the annotated source
  ///   - sourceLocationConverter: The source location converter for computing
  ///       line and column information for the diagnostics
  func annotatedSource(
    tree: some SyntaxProtocol,
    diags: [Diagnostic],
    indentString: String,
    suffixTexts: [AbsolutePosition: String],
    includeNotes: Bool = false,
    sourceLocationConverter: SourceLocationConverter? = nil
  ) -> String {
    let slc = sourceLocationConverter ?? SourceLocationConverter(fileName: "<unknown>", tree: tree)

    // === Group Annotations By Line ===
    //
    // Group annotations by the line they are anchored to.
    var annotationsPerLine = [Int: [AnnotatedSourceLine.Annotation]]()
    // Add annotations to the map.
    for diagnostic in diags {
      // Add diagnostic to the map.
      let line = diagnostic.location(converter: slc).line
      annotationsPerLine[line, default: []].append(.diagnostic(diagnostic))

      // Add notes to the map if includeNotes is true.
      if includeNotes {
        for note in diagnostic.notes {
          let line = note.location(converter: slc).line
          annotationsPerLine[line, default: []].append(.note(note, category: diagnostic.diagMessage.category))
        }
      }
    }

    // Group suffix texts by the line they are anchored to, and add them to the map.
    var suffixTextPerLine = [Int: String]()
    for (position, text) in suffixTexts {
      let line = slc.location(for: position).line
      // Concatenate suffix texts if there are multiple for the same line.
      suffixTextPerLine[line, default: ""].append(text)
    }

    // Put each line and its diagnostics together.
    let annotatedSourceLines: [AnnotatedSourceLine] = slc.sourceLines.enumerated().map { (sourceLineIndex, sourceLine) in
      let lineNumber = sourceLineIndex + 1

      return AnnotatedSourceLine(
        annotations: annotationsPerLine[lineNumber] ?? [],
        sourceString: sourceLine, 
        suffixText: suffixTextPerLine[lineNumber] ?? ""
      )
    }

    // === Calculate Lines to Print ===
    //
    // Only lines with diagnostic messages should be printed, but including some context
    let rangesToPrint = annotatedSourceLines.enumerated().compactMap { (lineIndex, sourceLine) -> Range<Int>? in
      let lineNumber = lineIndex + 1
      if !sourceLine.isFreeOfAnnotations {
        return Range<Int>(uncheckedBounds: (lower: lineNumber - contextSize, upper: lineNumber + contextSize + 1))
      }
      return nil
    }

    // === Render Annotated Source ===
    //
    // Accumulate the fully annotated source files here.
    var annotatedSource = ""
    /// Keep track if a line missing char should be printed
    var hasLineBeenSkipped = false
    // The maximum number of digits in the line numbers.
    // Helps calculate padding for line numbers.
    let maxNumberOfDigits = String(annotatedSourceLines.count).count

    // Render each line and its annotations.
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

      // Line numbers should be right aligned
      let lineNumberString = String(lineNumber)
      let leadingSpaces = String(repeating: " ", count: maxNumberOfDigits - lineNumberString.count)
      let linePrefix = "\(leadingSpaces)\(diagnosticDecorator.decorateBufferOutline("\(lineNumberString) |")) "

      // If necessary, print a line that indicates that there was lines skipped in the source code
      if hasLineBeenSkipped && !annotatedSource.isEmpty {
        let lineMissingInfoLine =
          indentString + String(repeating: " ", count: maxNumberOfDigits)
          + " \(diagnosticDecorator.decorateBufferOutline(":"))"
        annotatedSource.append("\(lineMissingInfoLine)\n")
      }
      hasLineBeenSkipped = false

      // Add indentation
      annotatedSource.append(indentString)

      // Print the source line
      annotatedSource.append(linePrefix)
      annotatedSource.append(
        colorizeSourceLine(
          annotatedLine,
          lineNumber: lineNumber,
          tree: tree,
          sourceLocationConverter: slc
        )
      )

      // Remove any trailing newline and replace it.
      //
      // This may seem counterintuitive, but if we're running within CMake 
      // and we let a '\r\n' through, CMake will turn that into *two* newlines.
      if let last = annotatedSource.last, last.isNewline {
        annotatedSource.removeLast()
      }
      annotatedSource.append("\n")

      // Group annotations by column. 
      // 
      // Helps render multiple diagnostics in one line, e.g.
      // 1 | foo.[].[].[]
      //   |     |  |  `- error: expected name in member access
      //   |     |  `- error: expected name in member access
      //   |     `- error: expected name in member access
      //
      // First, identify the columns that have diagnostics. Helps
      // place the "|" characters in the prefix string's previous lines.
      let columnsWithDiagnostics = Set(
        annotatedLine.annotations.map { annotation in
          annotatedLine.characterColumn(ofUtf8Column: annotation.location(converter: slc).column)
        }
      )
      // Then, group annotations by column, and sort so that annotations for 
      // later columns are printed first.
      let annotationsPerColumn = Dictionary(grouping: annotatedLine.annotations) { annotation in
        annotatedLine.characterColumn(ofUtf8Column: annotation.location(converter: slc).column)
      }.sorted { lhs, rhs in
        lhs.key > rhs.key
      }

      // Print annotations from higher column to lower column.
      for (column, lineAnnotations) in annotationsPerColumn {
        // Compute the string that is shown before each message
        //
        // Add indentation and space for line numbers.
        var preMessage =
          indentString + String(repeating: " ", count: maxNumberOfDigits) + " "
          + diagnosticDecorator.decorateBufferOutline("|")
        // Add "|" characters for each column that has diagnostics, up to the current column.
        for c in 0..<column {
          if columnsWithDiagnostics.contains(c) {
            preMessage.append("|")
          } else {
            preMessage.append(" ")
          }
        }

        // Print annotations for this column.
        for (index, annotation) in lineAnnotations.enumerated() {
          // Decorate the diagnostic or note using the diagnostic decorator.
          let decoratedMessage = switch annotation {
          case .diagnostic(let diag):
            diagnosticDecorator.decorateDiagnosticMessage(diag.diagMessage)
          case .note(let note, let category):
            diagnosticDecorator.decorateMessage(note.message, basedOnSeverity: .note, category: category)
          }

          // Compute annotation header
          // We use "|-" for intermediate annotations, and "`-" for the last annotation.
          let annotationHeader = (index == lineAnnotations.count - 1) ? "`-" : "|-"

          // Add decorated message to the annotated source.
          annotatedSource.append("\(preMessage)\(annotationHeader) \(decoratedMessage)\n")
        }
      }

      // Add suffix text.
      if !annotatedLine.suffixText.isEmpty {
        annotatedSource.append(annotatedLine.suffixText)

        // See above for an explanation of why we do this
        if let last = annotatedSource.last, last.isNewline {
          annotatedSource.removeLast()
        }
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

  /// Produce a string that formats the given diagnostic message with any
  /// source-location information.
  public func formattedMessage(_ message: some DiagnosticMessage) -> String {
    diagnosticDecorator.decorateDiagnosticMessage(message)
  }

  /// Produce a string containing "footnotes" for each of the diagnostic
  /// category provided that has associated documentation. Each category
  /// is printed in Markdown link format, e.g.,
  ///
  /// ```
  /// [#categoryName]: <categoryDocumentationURL>
  /// ```
  ///
  /// This function also deduplicates entries and alphabetizes the results.
  ///
  /// - Parameters:
  ///   - categories: the categories to print
  ///   - leadingText: text that is prefixed to the list of categories when
  ///     there is at least one category to print.
  public func categoryFootnotes(
    _ categories: some Sequence<DiagnosticCategory>,
    leadingText: String = "\n"
  ) -> String {
    let categoriesInOrder = categories.compactMap { category in
      if let documentationURL = category.documentationURL {
        return (category.name, documentationURL)
      } else {
        return nil
      }
    }.sorted { $0.0.lowercased() < $1.0.lowercased() }

    if categoriesInOrder.isEmpty {
      return ""
    }

    return leadingText
      + categoriesInOrder.map { name, url in
        "[#\(name)]: <\(url)>"
      }.joined(separator: "\n")
  }
}
