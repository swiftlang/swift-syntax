//===------ SyntaxParser.swift - Syntax Parsing ---------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2019 Apple Inc. and the Swift project authors
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

import _InternalSwiftSyntaxParser
import Foundation

typealias CSyntaxNode = swiftparse_syntax_node_t
typealias CTriviaPiece = swiftparse_trivia_piece_t
typealias CSyntaxNodePtr = UnsafePointer<CSyntaxNode>
typealias CTriviaPiecePtr = UnsafePointer<CTriviaPiece>
typealias CSyntaxKind = swiftparse_syntax_kind_t
typealias CTokenKind = swiftparse_token_kind_t
typealias CTriviaKind = swiftparse_trivia_kind_t
typealias CTokenData = swiftparse_token_data_t
typealias CLayoutData = swiftparse_layout_data_t
typealias CParseLookupResult = swiftparse_lookup_result_t
typealias CClientNode = swiftparse_client_node_t
typealias CDiagnostic = swiftparser_diagnostic_t
typealias CFixit = swiftparse_diagnostic_fixit_t
typealias CRange = swiftparse_range_t

/// A list of possible errors that could be encountered while parsing a
/// Syntax tree.
public enum ParserError: Error, CustomStringConvertible {
  /// Parser created an invalid syntax data. That should never occur under
  /// normal circumstances, and it should be reported as a bug.
  case invalidSyntaxData

  /// The SwiftSyntax parser library isn't compatible with this client
  case parserCompatibilityCheckFailed

  public var description: String {
    switch self {
    case .invalidSyntaxData:
      return "parser created invalid syntax data"
    case .parserCompatibilityCheckFailed:
      return "SwiftSyntax parser library isn't compatible"
    }
  }
}

/// Namespace for functions to parse swift source and retrieve a syntax tree.
public enum SyntaxParser {

  /// True if the parser library is compatible with the SwiftSyntax client;
  /// false otherwise.
  fileprivate static var nodeHashVerifyResult: Bool = verifyNodeDeclarationHash()

  /// Parses the string into a full-fidelity Syntax tree.
  ///
  /// - Parameters:
  ///   - source: The source string to parse.
  ///   - parseTransition: Optional mechanism for incremental re-parsing.
  ///   - filenameForDiagnostics: Optional file name used for SourceLocation.
  ///   - diagnosticEngine: Optional diagnotic engine to where the parser will
  ///       emit diagnostics
  /// - Returns: A top-level Syntax node representing the contents of the tree,
  ///            if the parse was successful.
  /// - Throws: `ParserError`
  public static func parse(
    source: String,
    parseTransition: IncrementalParseTransition? = nil,
    filenameForDiagnostics: String = "",
    diagnosticEngine: DiagnosticEngine? = nil
  ) throws -> SourceFileSyntax {
    guard nodeHashVerifyResult else {
      throw ParserError.parserCompatibilityCheckFailed
    }
    // Get a native UTF8 string for efficient indexing with UTF8 byte offsets.
    // If the string is backed by an NSString then such indexing will become
    // extremely slow.
    var utf8Source = source
    utf8Source.makeNativeUTF8IfNeeded()

    let rawSyntax = parseRaw(utf8Source, parseTransition, filenameForDiagnostics,
                             diagnosticEngine)

    guard let file = makeSyntax(.forRoot(rawSyntax)) as? SourceFileSyntax else {
      throw ParserError.invalidSyntaxData
    }
    return file
  }

  /// Parses the file `URL` into a full-fidelity Syntax tree.
  ///
  /// - Parameters:
  ///   - url: The file URL to parse.
  ///   - diagnosticEngine: Optional diagnotic engine to where the parser will
  ///       emit diagnostics
  /// - Returns: A top-level Syntax node representing the contents of the tree,
  ///            if the parse was successful.
  /// - Throws: `ParserError`
  public static func parse(_ url: URL,
      diagnosticEngine: DiagnosticEngine? = nil) throws -> SourceFileSyntax {
    // Avoid using `String(contentsOf:)` because it creates a wrapped NSString.
    let fileData = try Data(contentsOf: url)
    let source = fileData.withUnsafeBytes { buf in
      return String.fromBuffer(buf.bindMemory(to: UInt8.self))
    }
    return try parse(source: source, filenameForDiagnostics: url.path,
                     diagnosticEngine: diagnosticEngine)
  }

  private static func parseRaw(
    _ source: String,
    _ parseTransition: IncrementalParseTransition?,
    _ filenameForDiagnostics: String,
    _ diagnosticEngine: DiagnosticEngine?
  ) -> RawSyntax {
    assert(source.isNativeUTF8)
    let c_parser = swiftparse_parser_create()
    defer {
      swiftparse_parser_dispose(c_parser)
    }

    let nodeHandler = { (cnode: CSyntaxNodePtr!) -> UnsafeMutableRawPointer in
      let node = RawSyntax.create(from: cnode, source: source)
      // Transfer ownership of the object to the C parser. We get ownership back
      // via `moveFromCRawNode()`.
      let bits = Unmanaged.passRetained(node)
      return bits.toOpaque()
    }
    swiftparse_parser_set_node_handler(c_parser, nodeHandler);

    if let parseTransition = parseTransition {
      var parseLookup = IncrementalParseLookup(transition: parseTransition)
      let nodeLookup = {
            (offset: Int, kind: CSyntaxKind) -> CParseLookupResult in
        guard let foundNode =
            parseLookup.lookUp(offset, kind: .fromRawValue(kind)) else {
          return CParseLookupResult(length: 0, node: nil)
        }
        let lengthToSkip = foundNode.byteSize
        let bits = Unmanaged.passRetained(foundNode.raw)
        return CParseLookupResult(length: lengthToSkip, node: bits.toOpaque())
      }
      swiftparse_parser_set_node_lookup(c_parser, nodeLookup);
    }

    var pendingDiag : Diagnostic?
    var pendingNotes: [Note] = []
    defer {
      // Consume the pending diagnostic if  present
      if let diagnosticEngine = diagnosticEngine {
        if let pendingDiag = pendingDiag {
          diagnosticEngine.diagnose(Diagnostic(pendingDiag, pendingNotes))
        }
      }
    }
    // Set up diagnostics consumer if requested by the caller.
    if let diagnosticEngine = diagnosticEngine {
      // If requested, we should set up a source location converter to calculate
      // line and column.
      let converter = diagnosticEngine.needsLineColumn ?
        SourceLocationConverter(file: filenameForDiagnostics, source: source) : nil
      let diagHandler = { (diag: CDiagnostic!) in
        // If the coming diagnostic is a note, we cache the pending note
        if swiftparse_diagnostic_get_severity(diag) ==
            SWIFTPARSER_DIAGNOSTIC_SEVERITY_NOTE {
          pendingNotes.append(Note(Diagnostic(diag: diag, using: converter)))
        } else {
          // Cosume the pending diagnostic
          if let pendingDiag = pendingDiag {
            diagnosticEngine.diagnose(Diagnostic(pendingDiag, pendingNotes))
            // Clear pending notes
            pendingNotes = []
          }
          // Cache the new coming diagnostic and wait for further notes.
          pendingDiag = Diagnostic(diag: diag, using: converter)
        }
      }
      swiftparse_parser_set_diagnostic_handler(c_parser, diagHandler)
    }

    let c_top = swiftparse_parse_string(c_parser, source)

  // Get ownership back from the C parser.
    return RawSyntax.moveFromOpaque(c_top)!
  }
}

extension SourceRange {
  init(_ range: CRange, _ converter: SourceLocationConverter?) {
    let start = SourceLocation(offset: Int(range.offset), converter: converter)
    let end = SourceLocation(offset: Int(range.offset + range.length),
                             converter: converter)
    self.init(start: start, end: end)
  }
}

extension Diagnostic.Message {
  init(_ diag: CDiagnostic) {
    let message = String(cString: swiftparse_diagnostic_get_message(diag))
    switch swiftparse_diagnostic_get_severity(diag) {
    case SWIFTPARSER_DIAGNOSTIC_SEVERITY_ERROR:
      self.init(.error, message)
    case SWIFTPARSER_DIAGNOSTIC_SEVERITY_WARNING:
      self.init(.warning, message)
    case SWIFTPARSER_DIAGNOSTIC_SEVERITY_NOTE:
      self.init(.note, message)
    default:
      fatalError("unrecognized diagnostic level")
    }
  }
}

extension FixIt {
  init(_ cfixit: CFixit, _ converter: SourceLocationConverter?) {
    let replacement = String(cString: cfixit.text)
    let range = SourceRange(cfixit.range, converter)
    if cfixit.range.length == 0 {
      // Insert
      self = .insert(SourceLocation(offset: Int(cfixit.range.offset),
                                    converter: converter), replacement)
    } else if replacement.isEmpty {
      // Remove
      self = .remove(range)
    } else {
      // Replace
      self = .replace(range, replacement)
    }
  }
}

extension Note {
  init(_ diag: Diagnostic) {
    self.init(message: diag.message, location: diag.location,
              highlights: diag.highlights, fixIts: diag.fixIts)
  }
}

extension Diagnostic {
  init(diag: CDiagnostic, using converter: SourceLocationConverter?) {
    // Collect highlighted ranges
    let highlights = (0..<swiftparse_diagnostic_get_range_count(diag)).map {
      return SourceRange(swiftparse_diagnostic_get_range(diag, $0), converter)
    }
    // Collect fixits
    let fixits = (0..<swiftparse_diagnostic_get_fixit_count(diag)).map {
      return FixIt(swiftparse_diagnostic_get_fixit(diag, $0), converter)
    }
    self.init(message: Diagnostic.Message(diag),
      location: SourceLocation(offset: Int(swiftparse_diagnostic_get_source_loc(diag)),
                               converter: converter),
      notes: [], highlights: highlights, fixIts: fixits)
  }

  init(_ diag: Diagnostic, _ notes: [Note]) {
    self.init(message: diag.message, location: diag.location, notes: notes,
              highlights: diag.highlights, fixIts: diag.fixIts)
  }
}
