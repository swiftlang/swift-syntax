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

/// A list of possible errors that could be encountered while parsing a
/// Syntax tree.
public enum ParserError: Error, CustomStringConvertible {
  /// Parser created an invalid syntax data. That should never occur under
  /// normal circumstances, and it should be reported as a bug.
  case invalidSyntaxData

  public var description: String {
    switch self {
    case .invalidSyntaxData:
      return "parser created invalid syntax data"
    }
  }
}

/// Provides a mechanism for the parser to skip regions of an incrementally
/// updated source that were already parsed during a previous parse invocation.
public protocol IncrementalParseLookup {
  /// Does a lookup to see if the current source `offset` should be associated
  /// with a known `Syntax` node and its region skipped during parsing.
  ///
  /// The implementation is responsible for checking whether an incremental edit
  /// has invalidated the previous `Syntax` node.
  ///
  /// - Parameters:
  ///   - offset: The byte offset of the source string that is currently parsed.
  ///   - kind: The `SyntaxKind` that the parser expects at this position.
  /// - Returns: A `Syntax` node from the previous parse invocation,
  ///            representing the contents of this region, if it is still valid
  ///            to re-use. `nil` otherwise.
  func lookUp(_ offset: Int, kind: SyntaxKind) -> Syntax?
}

/// Namespace for functions to parse swift source and retrieve a syntax tree.
public struct SyntaxParser {
  /// Parses the string into a full-fidelity Syntax tree.
  ///
  /// - Parameters:
  ///   - source: The source string to parse.
  ///   - parseLookup: Optional mechanism for incremental re-parsing.
  /// - Returns: A top-level Syntax node representing the contents of the tree,
  ///            if the parse was successful.
  /// - Throws: `ParserError`
  public static func parse(
    source: String,
    parseLookup: IncrementalParseLookup? = nil
  ) throws -> SourceFileSyntax {
    // Get a native UTF8 string for efficient indexing with UTF8 byte offsets.
    // If the string is backed by an NSString then such indexing will become
    // extremely slow.
    var utf8Source = source
    utf8Source.makeNativeUTF8IfNeeded()

    let rawSyntax = parseRaw(utf8Source, parseLookup: parseLookup)

    guard let file = makeSyntax(.forRoot(rawSyntax)) as? SourceFileSyntax else {
      throw ParserError.invalidSyntaxData
    }
    return file
  }

  /// Parses the file `URL` into a full-fidelity Syntax tree.
  ///
  /// - Parameters:
  ///   - url: The file URL to parse.
  /// - Returns: A top-level Syntax node representing the contents of the tree,
  ///            if the parse was successful.
  /// - Throws: `ParserError`
  public static func parse(_ url: URL) throws -> SourceFileSyntax {
    // Avoid using `String(contentsOf:)` because it creates a wrapped NSString.
    var fileData = try Data(contentsOf: url)
    fileData.append(0) // null terminate.
    let source = fileData.withUnsafeBytes { (ptr: UnsafePointer<CChar>) in
      return String(cString: ptr)
    }
    return try parse(source: source)
  }

  private static func parseRaw(
    _ source: String,
    parseLookup: IncrementalParseLookup?
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

    if let parseLookup = parseLookup {
      let nodeLookup = {
            (offset: Int, kind: CSyntaxKind) -> CParseLookupResult in
        guard let foundNode =
            parseLookup.lookUp(offset,
                               kind: SyntaxKind.fromRawValue(kind)) else {
          return CParseLookupResult(length: 0, node: nil)
        }
        let lengthToSkip = foundNode.byteSize
        let bits = Unmanaged.passRetained(foundNode.raw)
        return CParseLookupResult(length: lengthToSkip, node: bits.toOpaque())
      }
      swiftparse_parser_set_node_lookup(c_parser, nodeLookup);
    }

    let c_top = swiftparse_parse_string(c_parser, source)

  // Get ownership back from the C parser.
    return RawSyntax.moveFromOpaque(c_top)!
  }
}
