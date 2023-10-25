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

extension DiagnosticDecorator where Self == BasicDiagnosticDecorator {
  /// - Seealso: ``BasicDiagnosticDecorator``
  static var basic: Self {
    Self()
  }
}

/// An implementation of the `DiagnosticDecorator` protocol that enhances diagnostic elements—such as messages,
/// buffer outlines, and code highlights—by appending severity-based prefixes.
///
/// Unlike `ANSIDiagnosticDecorator`, this decorator does not use ANSI color codes and solely relies on textual cues.
@_spi(Testing) public struct BasicDiagnosticDecorator: DiagnosticDecorator {

  @_spi(Testing) public init() {}

  /// Decorates a diagnostic message by appending a severity-based prefix.
  ///
  /// - Parameters:
  ///   - message: The diagnostic message that needs to be decorated.
  ///   - severity: The severity level associated with the diagnostic message.
  ///
  /// - Returns: A string that combines the severity-specific prefix and the original diagnostic message.
  @_spi(Testing) public func decorateMessage(_ message: String, basedOnSeverity severity: DiagnosticSeverity) -> String {
    let severityText: String

    switch severity {
    case .error:
      severityText = "error"
    case .warning:
      severityText = "warning"
    case .note:
      severityText = "note"
    case .remark:
      severityText = "remark"
    }

    return severityText + ": " + message
  }

  /// Passes through the source code buffer outline without modification.
  ///
  /// - Parameter bufferOutline: The string representation of the source code buffer outline.
  ///
  /// - Returns: The original source code buffer outline.
  @_spi(Testing) public func decorateBufferOutline(_ bufferOutline: String) -> String {
    return bufferOutline
  }

  /// Passes through the text segment within a source code snippet without modification.
  ///
  /// - Parameter highlight: The text segment within the source code snippet that should be emphasized.
  ///
  /// - Returns: A tuple containing:
  ///   - `highlightedSourceCode`: The original text segment.
  ///   - `additionalHighlightedLine`: Always nil.
  @_spi(Testing) public func decorateHighlight(_ highlight: String) -> (highlightedSourceCode: String, additionalHighlightedLine: String?) {
    return (highlightedSourceCode: highlight, additionalHighlightedLine: nil)
  }
}
