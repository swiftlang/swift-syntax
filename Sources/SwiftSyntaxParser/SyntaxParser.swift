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
//
// Uses the C API for syntax parsing that is part of the Swift toolchain.
//
//===----------------------------------------------------------------------===//

import Foundation
@_spi(RawSyntax) import SwiftSyntax
@_implementationOnly import SwiftParser

/// A list of possible errors that could be encountered while parsing a
/// Syntax tree.
@available(*, deprecated, message: "The Swift parser does not throw errors")
public enum ParserError: Error, CustomStringConvertible {
  /// Parser created an invalid syntax data. That should never occur under
  /// normal circumstances, and it should be reported as a bug.
  case invalidSyntaxData

  /// The SwiftSyntax parser library isn't compatible with this SwiftSyntax version.
  ///
  /// This can never happen, because there is no SwiftSyntax library any more.
  case parserCompatibilityCheckFailed

  public var description: String {
    switch self {
    case .invalidSyntaxData:
      return "parser created invalid syntax data"
    case .parserCompatibilityCheckFailed:
      return "Incompatible nonexistent library"
    }
  }
}

/// Namespace for functions to parse swift source and retrieve a syntax tree.
public enum SyntaxParser {
  /// Parses the string into a full-fidelity Syntax tree.
  ///
  /// - Parameters:
  ///   - source: The source string to parse.
  ///   - parseTransition: Optional mechanism for incremental re-parsing.
  ///   - filenameForDiagnostics: Optional file name used for SourceLocation.
  ///   - languageVersion: Interpret input according to a specific Swift
  ///       language version number. If `nil`, this inherits the default from
  ///       the syntax parser library.
  ///   - enableBareSlashRegexLiteral: Enable or disable the use of forward
  ///       slash regular-expression literal syntax. If `nil`, this inherits the
  ///       default from the syntax parser library.
  ///   - diagnosticHandler: Optional callback that will be called for all
  ///       diagnostics the parser emits
  /// - Returns: A top-level Syntax node representing the contents of the tree,
  ///            if the parse was successful.
  /// - Throws: `ParserError`
  public static func parse(
    source: String,
    parseTransition: IncrementalParseTransition? = nil,
    filenameForDiagnostics: String = "",
    languageVersion: String? = nil,
    enableBareSlashRegexLiteral: Bool? = nil,
    diagnosticHandler: ((Diagnostic) -> Void)? = nil
  ) throws -> SourceFileSyntax {
    // Get a native UTF8 string for efficient indexing with UTF8 byte offsets.
    // If the string is backed by an NSString then such indexing will become
    // extremely slow.
    var utf8Source = source
    utf8Source.makeContiguousUTF8()

    return try parseImpl(
      source: utf8Source,
      parseTransition: parseTransition,
      filenameForDiagnostics: filenameForDiagnostics,
      languageVersion: languageVersion,
      enableBareSlashRegexLiteral: enableBareSlashRegexLiteral,
      diagnosticHandler: diagnosticHandler
    )
  }

  /// Parses the file `URL` into a full-fidelity Syntax tree.
  ///
  /// - Parameters:
  ///   - url: The file URL to parse.
  ///   - languageVersion: Interpret input according to a specific Swift
  ///       language version number. If `nil`, this inherits the default from
  ///       the syntax parser library.
  ///   - enableBareSlashRegexLiteral: Enable or disable the use of forward
  ///       slash regular-expression literal syntax. If `nil`, this inherits the
  ///       default from the syntax parser library.
  ///   - diagnosticHandler: Optional callback that will be called for all
  ///       diagnostics the parser emits
  /// - Returns: A top-level Syntax node representing the contents of the tree,
  ///            if the parse was successful.
  /// - Throws: `ParserError`
  public static func parse(
    _ url: URL,
    languageVersion: String? = nil,
    enableBareSlashRegexLiteral: Bool? = nil,
    diagnosticHandler: ((Diagnostic) -> Void)? = nil
  ) throws -> SourceFileSyntax {
    // Avoid using `String(contentsOf:)` because it creates a wrapped NSString.
    let fileData = try Data(contentsOf: url)
    let source = fileData.withUnsafeBytes { buf in
      return String(decoding: buf.bindMemory(to: UInt8.self), as: UTF8.self)
    }
    return try parse(
      source: source,
      filenameForDiagnostics: url.path,
      languageVersion: languageVersion,
      enableBareSlashRegexLiteral: enableBareSlashRegexLiteral,
      diagnosticHandler: diagnosticHandler
    )
  }

  private static func parseImpl(
    source: String,
    parseTransition: IncrementalParseTransition?,
    filenameForDiagnostics: String,
    languageVersion: String?,
    enableBareSlashRegexLiteral: Bool?,
    diagnosticHandler: ((Diagnostic) -> Void)?
  ) throws -> SourceFileSyntax {
    return Parser.parse(source: source, parseTransition: parseTransition)
  }
}

extension Note {
  init(_ diag: Diagnostic) {
    self.init(
      message: diag.message,
      location: diag.location,
      highlights: diag.highlights,
      fixIts: diag.fixIts
    )
  }
}

extension Diagnostic {
  init(_ diag: Diagnostic, _ notes: [Note]) {
    self.init(
      message: diag.message,
      location: diag.location,
      notes: notes,
      highlights: diag.highlights,
      fixIts: diag.fixIts
    )
  }
}
