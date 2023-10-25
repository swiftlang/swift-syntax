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

/// Protocol that defines a standard interface for decorating diagnostic output in source code.
///
/// This protocol is intended to be used by entities such as ``DiagnosticsFormatter`` and ``GroupedDiagnostics``
/// to apply custom decorations to diagnostic messages, buffer outlines, and code highlights.
///
/// ## Conforming to `DiagnosticDecorator`:
///
/// To conform to the `DiagnosticDecorator` protocol, you must implement three required methods:
///
/// 1. `decorateMessage(_:basedOnSeverity:)`: For decorating diagnostic messages.
/// 2. `decorateBufferOutline(_:)`: For decorating the outlines of source code buffers.
/// 3. `decorateHighlight(_:)`: For decorating individual highlights within a source code snippet.
///
/// ## Customization:
///
/// The protocol is designed to be easily customizable. Developers can create their own entities that conform
/// to `DiagnosticDecorator` to implement custom decorating logic. This allows for different visual representations,
/// such as using ANSI colors, underscores, emoji-based or other markers, for diagnostics in source code.
protocol DiagnosticDecorator {
  /// Decorates a diagnostic message based on its severity level.
  ///
  /// Implementations are expected to prepend a severity-specific prefix (e.g., "error: ", "warning: ") to the diagnostic message.
  ///
  /// - Parameters:
  ///   - message: The diagnostic message that needs to be decorated.
  ///   - severity: The severity level associated with the diagnostic message.
  ///
  /// - Returns: A decorated version of the diagnostic message, enhanced by visual cues like color, text styles, or other markers,
  ///            as well as a severity-specific prefix, based on its severity level.
  func decorateMessage(_ message: String, basedOnSeverity severity: DiagnosticSeverity) -> String

  /// Decorates the outline of a source code buffer to visually enhance its structure.
  ///
  /// - Parameter bufferOutline: The string representation of the source code buffer outline.
  ///
  /// - Returns: A decorated version of the buffer outline, improved with visual cues like color, text styles, or other markers.
  func decorateBufferOutline(_ bufferOutline: String) -> String

  /// Decorates a highlight within a source code snippet to emphasize it.
  ///
  /// - Parameter highlight: The text segment within the source code snippet that should be emphasized.
  ///
  /// - Returns: A tuple containing:
  ///   - `highlightedSourceCode`: A string that represents the decorated version of the original source code snippet.
  ///   - `additionalHighlightedLine`: An optional string containing additional lines of highlighting, if applicable.
  ///
  /// - Note: The method returns a tuple to offer more flexibility in decorating highlights.
  ///         This allows for a variety of techniques to be used, such as ANSI codes for color
  ///         and additional lines for contextual emphasis, which will be combined during the rendering process.
  func decorateHighlight(_ highlight: String) -> (highlightedSourceCode: String, additionalHighlightedLine: String?)
}

extension DiagnosticDecorator {
  /// Decorates a ``DiagnosticMessage`` instance by delegating to the `decorateMessage(_:basedOnSeverity:)` method.
  ///
  /// - Parameter diagnosticMessage: The ``DiagnosticMessage`` instance that encapsulates both the message and its severity level.
  ///
  /// - Returns: A decorated version of the diagnostic message, determined by its severity level.
  func decorateDiagnosticMessage(_ diagnosticMessage: DiagnosticMessage) -> String {
    decorateMessage(diagnosticMessage.message, basedOnSeverity: diagnosticMessage.severity)
  }
}
