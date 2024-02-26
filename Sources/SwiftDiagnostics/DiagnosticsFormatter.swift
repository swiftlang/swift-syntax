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

/// A utility for generating human-readable, annotated representations of source code with diagnostic messages.
///
/// The primary function of ``DiagnosticsFormatter`` is to enrich source code representation with comprehensive diagnostic
/// messages, thereby providing developers with clear context for understanding, debugging, and addressing compiler or linting errors
/// and warnings. By integrating diagnostic information directly into the source syntax tree, it facilitates a deeper insight into code issues.
/// The formatter supports customization through various decorators, allowing for tailored output formats. Additionally, it enables specifying
/// the extent of code context included with diagnostic messages, enhancing its utility in debugging processes.
///
/// ### Example
///
/// ```swift
/// // Swift source code with issues
/// class Iterator: {
///   var counter = 0
///   var wasCounterCalled: Bool { counter > 0 }
///
///   init(counter: Int = 0) {
///     self.counter = counter
///   }
///
///   // Description of the `loopOver` function
///   func loopOver() {
///     for (i = 0; i != 10; i += 1) { }
///   }
/// }
///
/// // Diagnostics produced by a parser could be applied to produce an annotated output like:
/// """
///  1 │ class Iterator: {
///    │                 ╰─ error: expected type in inherited type
///  2 │   var counter = 0
///  3 │   var wasCounterCalled: Bool { counter > 0 }
///    ┆
///  9 │   // Description of the `loopOver` function
/// 10 │   func loopOver() {
/// 11 │     for (i = 0; i != 10; i += 1) { }
///    │         ~~~~~~~~~~~~~~~~~~~~~~~~
///    │     │   │  ╰─ error: expected ')' to end tuple pattern
///    │     │   ╰─ note: to match this opening '('
///    │     ╰─ error: C-style for statement has been removed in Swift 3
/// 12 │   }
/// 13 │ }
/// """
/// ```
///
/// ### Motivation
///
/// This formatter enables better development practices by:
///
/// - **Improving Debugging**: Diagnostic messages, including errors, warnings, notes, fix-its, highlights, and remarks,
///   are aligned in context to the source code, making it easier to understand what needs to be corrected or considered.
///
/// - **Enhanced Readability**: The formatter enriches the source code with line numbers,
///   annotations, and optional text suffixes, providing a full picture to the developer.
///
/// - **Flexible Customization**: Through the `DiagnosticDecorator` protocol, you can customize
///   the appearance of diagnostic output.
public struct DiagnosticsFormatter {
  /// An enumeration that describes the amount of contextual lines to display around each diagnostic message.
  enum ContextRange {
    /// A limited number of lines around each diagnostic.
    /// - Parameter Int: The number of lines before and after the diagnostic message to display.
    case limited(Int)

    /// The entire source code along with the diagnostics.
    /// Useful for getting a full overview, but could result in a large output.
    case full
  }

  /// Specifies the number of contextual lines that will be displayed around each diagnostic message in the output.
  ///
  /// - If set to `.limited(n)`, exactly `n` lines will be displayed before and after each diagnostic message.
  ///   This is useful for focusing on the specific lines where the diagnostic messages are.
  ///
  /// - If set to `.full`, the entire source code will be displayed alongside the diagnostic messages.
  ///   This provides a comprehensive view but may generate a long output.
  let contextRange: ContextRange

  /// Instance of a type conforming to the `DiagnosticDecorator` protocol, responsible for formatting diagnostic output.
  ///
  /// The type of this property allows for flexible customization of the appearance and format of diagnostic messages,
  /// buffer outlines, and code highlights. Different implementations can be used to adapt the output according to
  /// user preferences or environmental conditions.
  let diagnosticDecorator: DiagnosticDecorator

  /// Initializes a new `DiagnosticsFormatter` instance.
  ///
  /// - Parameters:
  ///   - contextRange: Specifies the number of contextual lines around each diagnostic message. Default is `.limited(2)`.
  ///   - diagnosticDecorator: The decorator used for formatting diagnostic output. Default is `BasicDiagnosticDecorator`.
  init(
    contextRange: ContextRange = .limited(2),
    diagnosticDecorator: DiagnosticDecorator = BasicDiagnosticDecorator()
  ) {
    self.contextRange = contextRange
    self.diagnosticDecorator = diagnosticDecorator
  }

  /// Produces a fully annotated representation of source code by applying diagnostics, suffixes, and indentation to a given syntax tree.
  ///
  /// This function meticulously crafts an annotated source code representation, integrating diagnostics, line numbers, optional text suffixes,
  /// and any lines to skip or mark as skipped.
  ///
  /// ### Examples
  ///
  /// For example, given the following `tree`:
  /// ```swift
  /// class Iterator: {
  ///   var counter = 0
  ///   var wasCounterCalled: Bool { counter > 0 }
  ///
  ///   init(counter: Int = 0) {
  ///     self.counter = counter
  ///   }
  ///
  ///   // Description of the `loopOver` function
  ///   func loopOver() {
  ///     for (i = 🐮; i != 👩‍👩‍👦‍👦; i += 1) { }
  ///   }
  /// }
  /// ```
  /// When provided with an empty `indentString` and `suffixTexts`, and utilizing a `BasicDiagnosticDecorator`,
  /// along with diagnostics generated by a parser, this function will produce the following output:
  /// ```swift
  /// """
  ///  1 │ class Iterator: {
  ///    │                 ╰─ error: expected type in inherited type
  ///  2 │   var counter = 0
  ///  3 │   var wasCounterCalled: Bool { counter > 0 }
  ///    ┆
  ///  9 │   // Description of the `loopOver` function
  /// 10 │   func loopOver() {
  /// 11 │     for (i = 🐮; i != 👩‍👩‍👦‍👦; i += 1) { }
  ///    │     │   │ ╰─ error: expected ')' to end tuple pattern
  ///    │     │   ╰─ note: to match this opening '('
  ///    │     ╰─ error: C-style for statement has been removed in Swift 3
  /// 12 │   }
  /// 13 │ }
  /// """
  /// ```
  ///
  /// - Parameters:
  ///   - tree: A syntax tree conforming to `SyntaxProtocol`, representing the source code to annotate.
  ///   - diagnostics: An array of `Diagnostic` instances to be annotated alongside the source lines.
  ///   - indentString: An optional string for the indentation at the beginning of each source line.
  ///   - suffixTexts: A dictionary mapping `AbsolutePosition` to strings to be used as suffix text for the source lines.
  ///   - sourceLocationConverter: An optional `SourceLocationConverter` object to find source locations.
  ///
  /// - Returns: A string containing the fully annotated source code.
  public func annotatedSource(
    inSyntaxTree tree: some SyntaxProtocol,
    withDiagnostics diagnostics: [Diagnostic],
    usingIndentString indentString: String = "",
    appendingSuffixTexts suffixTexts: [AbsolutePosition: String] = [:],
    employingSourceLocationConverter sourceLocationConverter: SourceLocationConverter? = nil
  ) -> String {
    let sourceLocationConverter = sourceLocationConverter ?? SourceLocationConverter(fileName: "<unknown>", tree: tree)

    // First, we need to put each line and its diagnostics and notes together.
    let annotatedSourceLines = createAnnotatedLines(
      fromSourceLines: sourceLocationConverter.sourceLines,
      usingDiagnostics: diagnostics,
      appendingSuffixTexts: suffixTexts,
      withSourceLocationConverter: sourceLocationConverter
    )

    // Calculate the ranges of line numbers that should be displayed, taking into account annotations and context.
    let rangesToPrint = computeLinesToPrintRanges(from: annotatedSourceLines)

    // Accumulate the fully annotated source files here.
    var annotatedSource = ""

    // Keep track if a line missing char should be printed.
    var hasLineBeenSkipped = false

    // Maximum numbers of digits in line number mark.
    let maxNumberOfDigits = String(annotatedSourceLines.count).count

    for annotatedLine in annotatedSourceLines {
      /// If the current line number is not within the 'rangesToPrint', we continue to the next line
      /// and set the 'hasLineBeenSkipped' flag, so that we can later insert a marker for the skipped lines.
      guard rangesToPrint.contains(where: { $0.contains(annotatedLine.sourceLineNumber) }) else {
        hasLineBeenSkipped = true
        continue
      }

      /// Add a skipped line marker to indicate that lines have been omitted, but only under two conditions:
      /// 1. Lines have actually been skipped ('hasLineBeenSkipped' is true).
      /// 2. There's already annotated content in 'annotatedSource', meaning this isn't the start of the annotated lines.
      /// This ensures that skipped line markers only appear between annotated lines.
      if hasLineBeenSkipped && !annotatedSource.isEmpty {
        let skippedLineMarker = diagnosticDecorator.decorateBufferOutline("┆")
        let skippedLine = indentString + String(repeating: " ", count: maxNumberOfDigits) + " " + skippedLineMarker + "\n"
        annotatedSource += skippedLine
      }
      hasLineBeenSkipped = false

      // Append a decorated current source line
      annotatedSource += decorateSourceLine(
        annotatedLine,
        within: tree,
        using: sourceLocationConverter,
        withIndent: indentString,
        aligningTo: maxNumberOfDigits
      )

      // If the line did not end with new line (e.g. the last line), append it manually
      if annotatedSource.last?.isNewline == false {
        annotatedSource += "\n"
      }

      // Append all diagnostic messages for the current line
      annotatedSource += formatDiagnostics(
        from: annotatedLine,
        using: sourceLocationConverter,
        withIndent: indentString,
        aligningTo: maxNumberOfDigits
      )

      // Add suffix text.
      annotatedSource += annotatedLine.suffixText

      if annotatedSource.last?.isNewline == false {
        annotatedSource += "\n"
      }
    }

    return annotatedSource
  }

  /// Creates an array of `AnnotatedSourceLine` by annotating the provided source lines.
  ///
  /// The function enumerates over the source lines and for each line, identifies associated diagnostics
  /// and notes. These are then used to create an `AnnotatedSourceLine`. The function also
  /// looks for any text suffixes that should be added to the source line based on their absolute positions.
  ///
  /// - Parameters:
  ///   - sourceLines: An array of strings, each representing a source code line to be annotated.
  ///   - diagnostics: An array of ``Diagnostic``.
  ///   - suffixTexts: A dictionary mapping ``AbsolutePosition`` to strings, which are used as suffix text
  ///     for the source lines. The source line for each suffix is determined by the ``SourceLocationConverter``.
  ///   - sourceLocationConverter: A ``SourceLocationConverter`` object that is used to convert absolute positions
  ///     to line numbers.
  ///
  /// - Returns: An array of `AnnotatedSourceLine` containing the annotated source lines.
  private func createAnnotatedLines(
    fromSourceLines sourceLines: [String],
    usingDiagnostics diagnostics: [Diagnostic],
    appendingSuffixTexts suffixTexts: [AbsolutePosition: String],
    withSourceLocationConverter sourceLocationConverter: SourceLocationConverter
  ) -> [AnnotatedSourceLine] {
    sourceLines
      .enumerated()
      .map { (sourceLineIndex, sourceLine) in
        let sourceLineNumber = sourceLineIndex + 1

        var diagnosticsInSourceLine: [FlattenDiagnostic] = []

        // Append diagnostics related to the current source line
        diagnosticsInSourceLine +=
          diagnostics
          .filter { diagnostic in
            diagnostic.location(converter: sourceLocationConverter).line == sourceLineNumber
          }
          .map(FlattenDiagnostic.diagnostic)

        // Append notes related to the current source line
        diagnosticsInSourceLine +=
          diagnostics
          .flatMap(\.notes)
          .filter { note in
            note.location(converter: sourceLocationConverter).line == sourceLineNumber
          }
          .map(FlattenDiagnostic.note)

        let suffixText =
          suffixTexts
          .compactMap { (position, text) in
            sourceLocationConverter.location(for: position).line == sourceLineNumber ? text : nil
          }
          .joined()

        return AnnotatedSourceLine(
          diagnostics: diagnosticsInSourceLine,
          sourceString: sourceLine,
          sourceLineNumber: sourceLineNumber,
          suffixText: suffixText
        )
      }
  }

  /// Computes line number ranges that should be printed, based on the presence of annotations and the selected context.
  ///
  /// This function scans an array of `AnnotatedSourceLine` to determine which lines are
  /// annotated with diagnostics or notes. Depending on the `context` property, this method behaves as follows:
  ///
  /// - `.limited(n)`: For each annotated line, a `Range<Int>` is created to
  ///   indicate the span of lines around the annotated line that should also be printed, limited to `n` lines before and after.
  ///
  /// - `.full`: A single range spanning all the lines will be returned, effectively printing the entire source code alongside diagnostics.
  ///
  /// - Parameter annotatedSourceLines: An array of `AnnotatedSourceLine`, each of which represents a line
  ///   of source code and any annotations associated with it.
  ///
  /// - Returns: An array of `Range<Int>`, each specifying a range of line numbers that should be
  ///   printed due to the presence of annotations or the context setting.
  private func computeLinesToPrintRanges(from annotatedSourceLines: [AnnotatedSourceLine]) -> [Range<Int>] {
    switch contextRange {
    case .limited(let contextSizeLimit):
      return
        annotatedSourceLines
        .compactMap { annotatedLine -> Range<Int>? in
          let lineNumber = annotatedLine.sourceLineNumber
          if annotatedLine.isFreeOfAnnotations {
            return nil
          } else {
            return (lineNumber - contextSizeLimit)..<(lineNumber + contextSizeLimit + 1)
          }
        }
    case .full:
      return [0..<annotatedSourceLines.count]
    }
  }

  /// Decorates a line of source code with line numbers, highlighting, and indentation.
  ///
  /// The method performs the following tasks:
  /// * It decorates the provided source line with highlights to emphasize specific parts of the code.
  /// * It creates a right-aligned line number prefix, ensuring that line numbers are neatly aligned regardless of their length.
  /// * It constructs the decorated source line, incorporating the line number prefix and any highlights. If there is an additional highlighted
  ///   line (for instance, to underline a part of the code), this line is appended below the decorated source line.
  ///
  /// For example, given:
  /// - `annotatedSourceLine` contains a diagnostic with `foo` highlighted,
  /// - `indentString` is an empty string,
  /// - `maxNumberOfDigits` is 3,
  ///
  /// The output would look like the following:
  /// ```swift
  /// """
  ///  12 │ func foo(with bar: String) -> Int {
  ///     │      ~~~
  /// """
  /// ```
  ///
  /// - Parameters:
  ///   - annotatedSourceLine: The source line to be decorated.
  ///   - tree: The syntax tree that includes the source line.
  ///   - sourceLocationConverter: The converter used to find source locations.
  ///   - indentString: The string used for indentation, enhancing the visual hierarchy of the decorated source line.
  ///   - maxNumberOfDigits: The maximum number of digits in line numbers, used to align line numbers properly.
  ///
  /// - Returns: A string containing the decorated source line. It includes the right-aligned line number, any necessary highlighting, and proper indentation.
  ///   If an additional highlighted line exists (for example, to underline a specific part of the code), it is appended below the source line.
  private func decorateSourceLine(
    _ annotatedSourceLine: AnnotatedSourceLine,
    within tree: SyntaxProtocol,
    using sourceLocationConverter: SourceLocationConverter,
    withIndent indentString: String,
    aligningTo maxNumberOfDigits: Int
  ) -> String {
    // Decorate source line with highlights
    let (highlightedSourceCode, additionalHighlightedLine) = decorateSourceLineWithHighlights(
      annotatedSourceLine: annotatedSourceLine,
      inSyntaxTree: tree,
      using: sourceLocationConverter
    )

    // Create right-aligned line number prefix
    let lineNumberString = String(annotatedSourceLine.sourceLineNumber)
    let leadingSpacesForLineNumber = String(repeating: " ", count: maxNumberOfDigits - lineNumberString.count)
    let colorizedLineNumberWithBar = diagnosticDecorator.decorateBufferOutline("\(lineNumberString) │")
    let rightAlignedLineNumberPrefix = leadingSpacesForLineNumber + colorizedLineNumberWithBar + " "

    // Construct decorated source with highlights and line number prefix
    var decoratedSourceLine = indentString + rightAlignedLineNumberPrefix + highlightedSourceCode

    // Handle and append additional highlighted line, if exists
    if let additionalHighlightedLine = additionalHighlightedLine {
      let leadingSpacesForAdditionalLine = String(repeating: " ", count: maxNumberOfDigits)
      let colorizedBar = diagnosticDecorator.decorateBufferOutline("│")
      let additionalLinePrefix = leadingSpacesForAdditionalLine + " " + colorizedBar + " "
      decoratedSourceLine += indentString + additionalLinePrefix + additionalHighlightedLine
    }

    return decoratedSourceLine
  }

  /// Decorates a source line with highlights based on the associated diagnostic messages.
  ///
  /// - Parameters:
  ///   - annotatedSourceLine: The source line to be highlight.
  ///   - tree: The syntax tree that includes the source line.
  ///   - sourceLocationConverter: The converter used for converting between binary offset and line/column.
  ///
  /// - Returns: A tuple containing:
  ///   - `highlightedSourceCode`: A string that includes the decorated source line.
  ///   - `additionalHighlightedLine`: An optional string that provides further contextual highlights. This is `nil` if there are no additional highlight line.
  private func decorateSourceLineWithHighlights(
    annotatedSourceLine: AnnotatedSourceLine,
    inSyntaxTree tree: SyntaxProtocol,
    using sourceLocationConverter: SourceLocationConverter
  ) -> (highlightedSourceCode: String, additionalHighlightedLine: String?) {
    if annotatedSourceLine.diagnostics.isEmpty {
      return (highlightedSourceCode: annotatedSourceLine.sourceString, additionalHighlightedLine: nil)
    }

    let highlightRanges = computeHighlightRanges(
      forLine: annotatedSourceLine,
      fromTree: tree,
      usingSourceLocationConverter: sourceLocationConverter
    )

    // Map the column ranges into index ranges within the source string itself.
    let highlightIndexRanges: [Range<String.Index>] =
      highlightRanges
      .map { highlightRange in
        let sourceStringUTF8 = annotatedSourceLine.sourceString.utf8
        let startIndex = sourceStringUTF8.index(sourceStringUTF8.startIndex, offsetBy: highlightRange.lowerBound - 1)
        let endIndex = sourceStringUTF8.index(startIndex, offsetBy: highlightRange.count)
        return startIndex..<endIndex
      }

    let sourceString = annotatedSourceLine.sourceString

    var highlightedSourceCode = ""
    var additionalHighlightedLine = ""
    var lastIndex = sourceString.startIndex

    // Iterate over each range and decorate it.
    for highlightIndexRange in highlightIndexRanges {
      // Append the non-highlighted part to the result string.
      let nonHighlighted = sourceString[lastIndex..<highlightIndexRange.lowerBound]
      highlightedSourceCode += nonHighlighted
      additionalHighlightedLine += String(repeating: " ", count: nonHighlighted.count)

      // Extract the highlighted part from the source string and decorate it.
      let highlight = String(sourceString[highlightIndexRange])
      let (decoratedHighlight, decoratedAdditionalLine) = diagnosticDecorator.decorateHighlight(highlight)

      // Append the decorated highlight to the result string.
      highlightedSourceCode += decoratedHighlight

      // If there's an additional line, append it.
      if let decoratedAdditionalLine {
        additionalHighlightedLine += decoratedAdditionalLine
      } else {
        additionalHighlightedLine += String(repeating: " ", count: decoratedHighlight.count)
      }

      lastIndex = highlightIndexRange.upperBound
    }

    // Append any remaining part of the source string.
    let remaining = sourceString[lastIndex...]
    highlightedSourceCode += remaining
    additionalHighlightedLine += String(repeating: " ", count: remaining.count)

    return (
      highlightedSourceCode: highlightedSourceCode,
      /// Using `allSatisfy` to check if the `additionalHighlightedLine` consists only of whitespace characters.
      /// If it does, we return `nil` to indicate that no additional highlighting exists.
      additionalHighlightedLine: additionalHighlightedLine.allSatisfy(\.isWhitespace) ? nil : additionalHighlightedLine
    )
  }

  /// Computes the set of highlight ranges for a given annotated source line.
  ///
  /// This function takes an `annotatedSourceLine` which contains diagnostics and returns an array of `Range<Int>` objects.
  /// These ranges are sorted and merged to provide a concise collection of highlight regions for the source code line.
  ///
  /// - Parameters:
  ///   - annotatedSourceLine: The line annotated with diagnostics.
  ///   - tree: The syntax tree representing the entire source file.
  ///   - sourceLocationConverter: The `SourceLocationConverter` used for converting between absolute and line/column positions.
  ///
  /// - Returns: An array of sorted and merged `Range<Int>` objects representing the highlight regions on the line.
  private func computeHighlightRanges(
    forLine annotatedSourceLine: AnnotatedSourceLine,
    fromTree tree: some SyntaxProtocol,
    usingSourceLocationConverter sourceLocationConverter: SourceLocationConverter
  ) -> [Range<Int>] {
    annotatedSourceLine.diagnostics
      .flatMap {
        switch $0 {
        case let .diagnostic(diagnostic):
          return diagnostic.highlights
        case .note:
          return []
        }
      }
      .compactMap { (highlight) -> Range<Int>? in
        if highlight.root != Syntax(tree) {
          return nil
        }

        let startLocation = highlight.startLocation(converter: sourceLocationConverter, afterLeadingTrivia: true)
        let startLine = startLocation.line

        let startColumn: Int
        if startLine < annotatedSourceLine.sourceLineNumber {
          startColumn = 1
        } else if startLine == annotatedSourceLine.sourceLineNumber {
          startColumn = startLocation.column
        } else {
          return nil
        }

        let endLocation = highlight.endLocation(converter: sourceLocationConverter, afterTrailingTrivia: false)
        let endLine = endLocation.line

        let endColumn: Int
        if endLine > annotatedSourceLine.sourceLineNumber {
          endColumn = annotatedSourceLine.sourceString.count
        } else if endLine == annotatedSourceLine.sourceLineNumber {
          endColumn = endLocation.column
        } else {
          return nil
        }

        if startColumn == endColumn {
          return nil
        }

        return startColumn..<endColumn
      }
      .sorted { (lhs, rhs) in
        lhs.lowerBound < rhs.lowerBound
      }
      .mergingOverlappingRanges()
  }

  /// Formats diagnostic messages for a line of source code, organizing and aligning them based on their column positions.
  ///
  /// For example, given:
  /// - `annotatedSourceLine` contains three diagnostic messages pointing to three different columns in the same line,
  /// - `indentString` is an empty string,
  /// - `maxNumberOfDigits` is 1,
  ///
  /// The output would look like the following:
  /// ```swift
  /// """
  ///   │     │  │  ╰─ error: expected name in member access
  ///   │     │  ╰─ error: expected name in member access
  ///   │     ╰─ error: expected name in member access
  /// """
  /// ```
  ///
  /// - Parameters:
  ///   - annotatedSourceLine: The source line containing the diagnostics that need to be formatted.
  ///   - sourceLocationConverter: The converter used to convert absolute positions to line numbers.
  ///   - indentString: The string used for indentation, enhancing the visual hierarchy of the decorated source line.
  ///   - maxNumberOfDigits: The maximum number of digits in the line numbers, used for alignment.
  ///
  /// - Returns: A string containing all formatted diagnostic messages for the specified source line. Each message is prefixed with an alignment string and
  ///   a marker (`├─` for all but the last diagnostic in a column, and `╰─` for the last one), indicating the column of the source code they refer to.
  ///   The messages are sorted in descending order based on their column positions, with the rightmost diagnostic appearing first.
  private func formatDiagnostics(
    from annotatedSourceLine: AnnotatedSourceLine,
    using sourceLocationConverter: SourceLocationConverter,
    withIndent indentString: String,
    aligningTo maxNumberOfDigits: Int
  ) -> String {
    let columnsWithDiagnostics = Set(annotatedSourceLine.diagnostics.map { $0.location(using: sourceLocationConverter).column })
    let diagnosticsPerColumn = Dictionary(grouping: annotatedSourceLine.diagnostics) { $0.location(using: sourceLocationConverter).column }
      .sorted { $0.key > $1.key }

    var annotations = ""

    for (column, diagnostics) in diagnosticsPerColumn {
      /// Construct the string prefix to be shown before each diagnostic message.
      /// The prefix starts with the 'indentString', followed by padding spaces to align the message
      /// with the maximum number of digits in the source line number, and a vertical line "│".
      /// Additional vertical lines or spaces are then appended based on the column locations
      /// where diagnostics are present, up to the current column.
      let diagnosticMessagePrefix: String = {
        var message = indentString + String(repeating: " ", count: maxNumberOfDigits) + " " + diagnosticDecorator.decorateBufferOutline("│")
        for c in 0..<column {
          if columnsWithDiagnostics.contains(c) {
            message += "│"
          } else {
            message += " "
          }
        }
        return message
      }()

      func createAnnotatedSourceLine(with diagnostic: FlattenDiagnostic, using marker: String) -> String {
        let colorizedMessage = diagnosticDecorator.decorateMessage(diagnostic.message, basedOnSeverity: diagnostic.severity)
        return diagnosticMessagePrefix + marker + " " + colorizedMessage + "\n"
      }

      // Append all but the last diagnostic with the appropriate marker
      for diagnostic in diagnostics.dropLast() {
        let annotation = createAnnotatedSourceLine(with: diagnostic, using: "├─")
        annotations += annotation
      }

      // Append the last diagnostic with a different marker; use force unwrapping because it always exists
      let lastDiagnostic = diagnostics.last!
      let finalAnnotation = createAnnotatedSourceLine(with: lastDiagnostic, using: "╰─")
      annotations += finalAnnotation
    }

    return annotations
  }
}

extension DiagnosticsFormatter {
  /// Generates a string containing source code with annotated diagnostics.
  ///
  /// - SeeAlso: ``annotatedSource(inSyntaxTree:withDiagnostics:usingIndentString:appendingSuffixTexts:employingSourceLocationConverter:)``
  static func annotatedSource(
    inSyntaxTree tree: some SyntaxProtocol,
    withDiagnostics diagnostics: [Diagnostic],
    usingIndentation indentString: String = "",
    appendingSuffixTexts suffixTexts: [AbsolutePosition: String] = [:],
    usingSourceLocationConverter sourceLocationConverter: SourceLocationConverter? = nil,
    limitedToContextRange contextRange: ContextRange = .limited(2),
    withDiagnosticDecorator decorator: DiagnosticDecorator = BasicDiagnosticDecorator()
  ) -> String {
    let formatter = Self(contextRange: contextRange, diagnosticDecorator: decorator)
    return formatter.annotatedSource(
      inSyntaxTree: tree,
      withDiagnostics: diagnostics,
      usingIndentString: indentString,
      appendingSuffixTexts: suffixTexts,
      employingSourceLocationConverter: sourceLocationConverter
    )
  }
}

// MARK: - Private helper models

/// Consolidates different types of diagnostic information, such as messages and notes, under a unified structure.
///
/// `FlattenDiagnostic` offers a unified approach to managing and processing various forms of diagnostic information.
/// It abstracts away the differences between diagnostic messages and informational notes, allowing for seamless integration
/// and handling within the diagnostics formatting process.
private enum FlattenDiagnostic {
  /// Represents a diagnostic message.
  case diagnostic(Diagnostic)

  /// Represents an informational note from a diagnostic
  case note(Note)

  /// Returns the message text associated with the diagnostic entity.
  var message: String {
    switch self {
    case let .diagnostic(diagnostic):
      return diagnostic.message
    case let .note(note):
      return note.message
    }
  }

  /// Specifies the severity level of the diagnostic entity.
  var severity: DiagnosticSeverity {
    switch self {
    case let .diagnostic(diagnostic):
      return diagnostic.diagMessage.severity
    case .note:
      return .note
    }
  }

  /// Location of diagnostic entity in the source code
  func location(using converter: SourceLocationConverter) -> SourceLocation {
    switch self {
    case let .diagnostic(diagnostic):
      return diagnostic.location(converter: converter)
    case let .note(note):
      return note.location(converter: converter)
    }
  }
}

/// A representation of a single source line, potentially enriched with diagnostics or annotations.
///
/// `AnnotatedSourceLine` encapsulates a line of source code alongside any associated diagnostics (errors, notes, etc.)
/// or annotations for enhanced code readability and insight. The diagnostics are represented by the `FlattenDiagnostic`
/// enum, which generalizes the handling of diagnostic messages and informational notes, providing a unified
/// approach to represent and process various types of diagnostic information.
///
/// - Note: This struct is designed for internal use by the `DiagnosticsFormatter` to organize and manage
///   source lines with their related diagnostics and annotations, facilitating a clearer understanding of code issues
///   and contextual notes.
private struct AnnotatedSourceLine {
  /// A collection of diagnostics associated with this line of source code.
  ///
  /// The diagnostics, encapsulated by instances of `FlattenDiagnostic`, offer insights into issues
  /// identified at this specific location in the source. This enables quick identification and
  /// resolution of problems, with `FlattenDiagnostic` providing a common interface for accessing
  /// message text, severity, and location of diagnostics or informational notes.
  let diagnostics: [FlattenDiagnostic]

  /// The content of the source line.
  ///
  /// This string contains the actual code from the source file at the specified line number, serving
  /// as a reference point for diagnostics and annotations.
  let sourceString: String

  /// The line number in the source file corresponding to `sourceString`.
  ///
  /// This value facilitates easy navigation to and within the source file, providing a clear reference
  /// to where the source line is located within its broader context.
  let sourceLineNumber: Int

  /// Additional text appended to the source line for extra context or information.
  ///
  /// This text can include annotations, explanations, or excerpts from relevant macro expansions,
  /// aimed at providing further insight or clarification.
  let suffixText: String

  /// Determines if the source line lacks any associated diagnostics or annotations.
  ///
  /// This property returns `true` when there are no diagnostics related to the line and when the
  /// `suffixText` is empty, indicating that the line is clean or unannotated. It offers a quick
  /// way to assess the line's status in relation to issues or annotations.
  var isFreeOfAnnotations: Bool {
    return diagnostics.isEmpty && suffixText.isEmpty
  }
}

// MARK: - Capabilities Layer

// Extension providing all necessary APIs to maintain backward compatibility. In the future,
// upon committing to the new API of `DiagnosticsFormatter` and diagnostic decorators,
// all members will be marked as deprecated.
extension DiagnosticsFormatter {
  public var contextSize: Int {
    switch contextRange {
    case .limited(let size):
      return size
    case .full:
      return -1
    }
  }

  @available(*, deprecated, message: "Store the `colorize` property passed to the initializer instead")
  public var colorize: Bool {
    diagnosticDecorator is ANSIDiagnosticDecorator
  }

  public init(contextSize: Int = 2, colorize: Bool = false) {
    self.init(contextRange: .limited(contextSize), diagnosticDecorator: colorize ? .ANSI : .basic)
  }

  public func annotatedSource(
    tree: some SyntaxProtocol,
    diags: [Diagnostic]
  ) -> String {
    annotatedSource(inSyntaxTree: tree, withDiagnostics: diags)
  }

  public static func annotatedSource(
    tree: some SyntaxProtocol,
    diags: [Diagnostic],
    contextSize: Int = 2,
    colorize: Bool = false
  ) -> String {
    Self.annotatedSource(
      inSyntaxTree: tree,
      withDiagnostics: diags,
      limitedToContextRange: .limited(contextSize),
      withDiagnosticDecorator: colorize ? .ANSI : .basic
    )
  }
}

extension Sequence<Range<Int>> {
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
