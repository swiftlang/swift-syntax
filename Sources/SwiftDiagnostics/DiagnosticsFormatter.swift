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

public struct DiagnosticsFormatter {

  /// A wrapper struct for a source line and its diagnostics
  private struct AnnotatedSourceLine {
    var diagnostics: [Diagnostic]
    var sourceString: String
  }

  /// Number of lines which should be printed before and after the diagnostic message
  public let contextSize: Int

  /// Whether to colorize formatted diagnostics.
  public let colorize: Bool

  public init(contextSize: Int = 2, colorize: Bool = false) {
    self.contextSize = contextSize
    self.colorize = colorize
  }

  public static func annotatedSource<SyntaxType: SyntaxProtocol>(
    tree: SyntaxType,
    diags: [Diagnostic],
    contextSize: Int = 2,
    colorize: Bool = false
  ) -> String {
    let formatter = DiagnosticsFormatter(contextSize: contextSize, colorize: colorize)
    return formatter.annotatedSource(tree: tree, diags: diags)
  }

  /// Print given diagnostics for a given syntax tree on the command line
  public func annotatedSource<SyntaxType: SyntaxProtocol>(tree: SyntaxType, diags: [Diagnostic]) -> String {
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
        return Range<Int>(uncheckedBounds: (lower: lineNumber - contextSize, upper: lineNumber + contextSize + 1))
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
          annotatedSource.append("\(preMessage)├─ \(colorizeIfRequested(diag.diagMessage))\n")
        }
        annotatedSource.append("\(preMessage)╰─ \(colorizeIfRequested(diags.last!.diagMessage))\n")
      }
    }
    return annotatedSource
  }

  /// Annotates the given ``DiagnosticMessage`` with an appropriate ANSI color code (if the value of the `colorize`
  /// property is `true`) and returns the result as a printable string.
  private func colorizeIfRequested(_ message: DiagnosticMessage) -> String {
    guard colorize else {
      return message.message
    }

    switch message.severity {
    case .error:
      let annotation = ANSIAnnotation(color: .red, trait: .bold)
      return annotation.applied(to: "error: \(message.message)")
    case .warning:
      let color = ANSIAnnotation(color: .yellow)
      let prefix = color.withTrait(.bold).applied(to: "warning: ")
      return prefix + color.applied(to: message.message)
    case .note:
      return message.message
    }
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

  func applied(to message: String) -> String {
    // Resetting after the message ensures that we don't color unintended lines in the output
    return "\(code)\(message)\(ANSIAnnotation.normal.code)"
  }

  /// The "normal" or "reset" ANSI code used to unset any previously added annotation.
  static var normal: ANSIAnnotation {
    self.init(color: .normal, trait: .normal)
  }
}
