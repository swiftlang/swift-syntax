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

extension DiagnosticDecorator where Self == ANSIDiagnosticDecorator {
  /// - SeeAlso: ``ANSIDiagnosticDecorator``
  static var ANSI: Self {
    Self()
  }
}

/// An implementation of the `DiagnosticDecorator` protocol that enhances various diagnostic elements—including messages,
/// buffer outlines, and code highlights—by applying severity-based prefixes and ANSI color codes.
///
/// This decorator uses ANSI codes—control characters specialized for text formatting in terminals—to provide visual cues.
@_spi(Testing) public struct ANSIDiagnosticDecorator: DiagnosticDecorator {

  @_spi(Testing) public init() {}

  /// Decorates a diagnostic message by appending a severity-based prefix and applying ANSI color codes.
  ///
  /// - Parameters:
  ///   - message: The diagnostic message that needs to be decorated.
  ///   - severity: The severity level associated with the diagnostic message.
  ///
  /// - Returns: A string that combines the severity-specific prefix and the original diagnostic message, with ANSI colorization.
  ///
  /// ## Example
  ///
  /// ```swift
  /// let decorator = ANSIDiagnosticDecorator()
  /// let decoratedMessage = decorator.decorateMessage("File not found", basedOnSeverity: .error)
  /// // Output would be: "[1;31merror: [1;39mFile not found[0;0m"
  /// ```
  /// In this example, the "error: " prefix is colorized, likely appearing in red, while the message retains its default text color.
  ///
  /// For a similar colorized output in the console, you can use `printf` in Bash:
  /// ```bash
  /// printf "\e[1;31merror: \e[1;39mFile not found\e[0;0m\n"
  /// ```
  @_spi(Testing) public func decorateMessage(_ message: String, basedOnSeverity severity: DiagnosticSeverity) -> String {
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

    let prefix = colorizeIfNotEmpty("\(severityText): ", usingAnnotation: severityAnnotation, resetAfterApplication: false)

    return prefix + colorizeIfNotEmpty(message, usingAnnotation: .diagnosticText)
  }

  /// Decorates a source code buffer outline using ANSI cyan color codes.
  ///
  /// - Parameter bufferOutline: The string representation of the source code buffer outline.
  ///
  /// - Returns: A string featuring ANSI cyan color codes applied to the source code buffer outline.
  @_spi(Testing) public func decorateBufferOutline(_ bufferOutline: String) -> String {
    colorizeIfNotEmpty(bufferOutline, usingAnnotation: .bufferOutline)
  }

  /// Emphasizes a specific text segment within a source code snippet using ANSI color codes.
  ///
  /// - Parameter highlight: The text segment within the source code snippet that should be emphasized.
  ///
  /// - Returns: A tuple containing:
  ///   - `highlightedSourceCode`: The underlined version of the original source code snippet.
  ///   - `additionalHighlightedLine`: Always nil.
  ///
  /// ## Example
  ///
  /// ```swift
  /// let decorator = ANSIDiagnosticDecorator()
  /// let decoratedHighlight = decorator.decorateHighlight("let x = 10")
  /// // Output would be: ["\u{1B}[4;39mlet x = 10\u{1B}[0;0m"]
  /// ```
  ///
  /// To reproduce a similar colorized output manually in the console, you can use `printf` in Bash:
  /// ```bash
  /// printf "\e[4;39mlet x = 10\e[0;0m\n"
  /// ```
  @_spi(Testing) public func decorateHighlight(_ highlight: String) -> (highlightedSourceCode: String, additionalHighlightedLine: String?) {
    (highlightedSourceCode: colorizeIfNotEmpty(highlight, usingAnnotation: .sourceHighlight), additionalHighlightedLine: nil)
  }

  /// Applies ANSI annotation to a given text segment, if the text is not empty.
  ///
  /// - Parameters:
  ///   - text: The text segment to which the annotation should be applied.
  ///   - annotation: The ANSI annotation to apply.
  ///   - resetAfter: A flag indicating whether to reset ANSI settings after applying them. Defaults to true.
  ///
  /// - Returns: A potentially colorized version of the input text.
  private func colorizeIfNotEmpty(
    _ text: String,
    usingAnnotation annotation: ANSIAnnotation,
    resetAfterApplication resetAfter: Bool = true
  ) -> String {
    if text.isEmpty {
      return text
    } else {
      return annotation.applied(to: text, resetAfter: resetAfter)
    }
  }
}

/// Defines text attributes to be applied to console output.
private struct ANSIAnnotation {
  /// Represents ANSI color codes.
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

  /// Represents ANSI text traits.
  enum Trait: UInt8 {
    case normal = 0
    case bold = 1
    case underline = 4
  }

  /// The ANSI color to be used.
  let color: Color

  /// The ANSI text trait to be used.
  let trait: Trait

  /// Returns ANSI code as a string, including both trait and color.
  var code: String {
    "\u{001B}[\(trait.rawValue);\(color.rawValue)m"
  }

  /// Applies the ANSI code to a message string. Optionally resets the code after the message.
  func applied(to message: String, resetAfter: Bool = true) -> String {
    guard resetAfter else {
      return "\(code)\(message)"
    }
    return "\(code)\(message)\(ANSIAnnotation.normal.code)"
  }

  /// The default 'normal' ANSIAnnotation used to reset styles.
  static var normal: Self {
    Self(color: .normal, trait: .normal)
  }

  /// Annotation used for the outline and line numbers of a buffer.
  static var bufferOutline: Self {
    Self(color: .cyan, trait: .normal)
  }

  /// Annotation used for highlighting source text.
  static var sourceHighlight: Self {
    Self(color: .default, trait: .underline)
  }

  /// Annotation used for making text bold, commonly used in diagnostic messages.
  static var diagnosticText: Self {
    Self(color: .default, trait: .bold)
  }

  /// Annotation used for error text.
  static var errorText: Self {
    Self(color: .red, trait: .bold)
  }

  /// Annotation used for warning text.
  static var warningText: Self {
    Self(color: .yellow, trait: .bold)
  }

  /// Annotation used for note text.
  static var noteText: Self {
    Self(color: .default, trait: .bold)
  }

  /// Annotation used for remarks or less critical text.
  static var remarkText: Self {
    Self(color: .blue, trait: .bold)
  }
}
