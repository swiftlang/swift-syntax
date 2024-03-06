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
import SwiftDiagnostics
public import SwiftParser
import SwiftParserDiagnostics
import SwiftSyntax
#else
import SwiftDiagnostics
import SwiftParser
import SwiftParserDiagnostics
import SwiftSyntax
#endif

// Don't introduce a dependency on OSLog when building SwiftSyntax using CMake
// for the compiler.
#if canImport(OSLog) && !SWIFTSYNTAX_NO_OSLOG_DEPENDENCY
import OSLog
#endif

/// Only set from `withStringInterpolationParsingErrorsSuppressed`, which is only intended for testing purposes that are
/// single-threaded.
#if swift(>=6)
fileprivate nonisolated(unsafe) var suppressStringInterpolationParsingErrors = false
#else
fileprivate var suppressStringInterpolationParsingErrors = false
#endif

/// Run the body, disabling any runtime warnings about syntax error in string
/// interpolation inside the body.
///
/// Used to test the behavior of string interpolation with syntax errors.
@_spi(Testing)
public func withStringInterpolationParsingErrorsSuppressed<T>(_ body: () throws -> T) rethrows -> T {
  suppressStringInterpolationParsingErrors = true
  defer {
    suppressStringInterpolationParsingErrors = false
  }
  return try body()
}

extension SyntaxParseable {
  public typealias StringInterpolation = SyntaxStringInterpolation

  /// Assuming that this node contains a syntax error, log it using OSLog if we
  /// are on a platform that supports OSLog, otherwise don't do anything.
  private func logStringInterpolationParsingError() {
    #if canImport(OSLog) && !SWIFTSYNTAX_NO_OSLOG_DEPENDENCY
    if #available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, macCatalyst 14.0, *),
      !suppressStringInterpolationParsingErrors
    {
      let diagnostics = ParseDiagnosticsGenerator.diagnostics(for: self)
      let formattedDiagnostics = DiagnosticsFormatter().annotatedSource(tree: self, diags: diagnostics)
      Logger(subsystem: "org.swift.swift-syntax", category: "ParseError").fault(
        """
        Parsing a `\(Self.self)` node from string interpolation produced the following parsing errors.
        Set a breakpoint in `SyntaxParseable.logStringInterpolationParsingError()` to debug the failure.

        To explicitly support parsing of invalid source code, import SwiftParser and invoke the parser as follows
          var parser = Parser(source)
          \(Self.self).parse(from: &parser)
        \(formattedDiagnostics, privacy: .private)
        """
      )
    }
    #endif
  }

  /// Initialize the syntax node from a string interpolation.
  ///
  /// - Important: This assumes that the string interpolation produces a valid
  ///              syntax tree. If the syntax tree is not valid, a fault will
  ///              be logged using OSLog on Darwin platforms.
  public init(stringInterpolation: SyntaxStringInterpolation) {
    self = stringInterpolation.sourceText.withUnsafeBufferPointer { buffer in
      var parser = Parser(buffer)
      let result = Self.parse(from: &parser)
      return result
    }
    if self.hasError {
      self.logStringInterpolationParsingError()
    }
  }
}
