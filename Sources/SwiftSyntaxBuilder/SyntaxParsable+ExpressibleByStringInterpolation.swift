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

import SwiftDiagnostics
import SwiftSyntax
import SwiftParser
import SwiftParserDiagnostics
// Don't introduce a dependency on OSLog when building SwiftSyntax using CMake
// for the compiler.
#if canImport(OSLog) && !SWIFTSYNTAX_NO_OSLOG_DEPENDENCY
import OSLog
#endif

extension SyntaxParseable {
  public typealias StringInterpolation = SyntaxStringInterpolation

  /// Assuming that this node contains a syntax error, log it using OSLog if we
  /// are on a platform that supports OSLog, otherwise don't do anything.
  private func logStringInterpolationParsingError() {
    #if canImport(OSLog) && !SWIFTSYNTAX_NO_OSLOG_DEPENDENCY
    if #available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, macCatalyst 14.0, *) {
      let diagnostics = ParseDiagnosticsGenerator.diagnostics(for: self)
      let formattedDiagnostics = DiagnosticsFormatter().annotatedSource(tree: self, diags: diagnostics)
      Logger(subsystem: "SwiftSyntax", category: "ParseError").fault(
        """
        Parsing a `\(Self.self)` node from string interpolation produced the following parsing errors.
        Set a breakpoint in `SyntaxParseable.logStringInterpolationParsingError()` to debug the failure.
        \(formattedDiagnostics)
        """
      )
    }
    #endif
  }

  /// Initialize the syntax node from a string interpolation.
  ///
  /// - Important: This asssumes that the string interpolation produces a valid
  ///              syntax tree. If the syntax tree is not valid, a fault will
  ///              be logged using OSLog on Darwin platforms.
  public init(stringInterpolation: SyntaxStringInterpolation) {
    self = stringInterpolation.sourceText.withUnsafeBufferPointer { buffer in
      var parser = Parser(buffer)
      // FIXME: When the parser supports incremental parsing, put the
      // interpolatedSyntaxNodes in so we don't have to parse them again.
      let result = Self.parse(from: &parser)
      return result
    }
    if self.hasError {
      self.logStringInterpolationParsingError()
    }
  }
}
