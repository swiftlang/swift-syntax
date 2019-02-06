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
typealias CParseLookupResult = swiftparse_lookup_result_t

/// A list of possible errors that could be encountered while parsing a
/// Syntax tree.
public enum ParserError: Error, CustomStringConvertible {
  /// Parser created an invalid syntax data. That should never occur under
  /// normal circumstances, and it should be reported as a bug.
  case invalidSyntaxData

  /// The SwiftSyntax parser library isn't compatible with this client
  case hashVerificationFailed

  public var description: String {
    switch self {
    case .invalidSyntaxData:
      return "parser created invalid syntax data"
    case .hashVerificationFailed:
      return "SwiftSyntax parser library isn't compatible"
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

  /// True if the parser library is compatible with the SwiftSyntax client;
  /// false otherwise.
  fileprivate static var nodeHashVerifyResult: Bool = verifyNodeDeclarationHash()

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

    let rawSyntax = try parseRaw(utf8Source, parseLookup: parseLookup)

    guard let file = makeSyntax(rawSyntax) as? SourceFileSyntax else {
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
  ) throws -> RawSyntax {
    assert(source.isNativeUTF8)
    guard nodeHashVerifyResult else {
      throw ParserError.hashVerificationFailed
    }
    let c_parser = swiftparse_parser_create()
    defer {
      swiftparse_parser_dispose(c_parser)
    }

    let nodeHandler = { (cnode: CSyntaxNodePtr!) -> UnsafeMutableRawPointer in
      let node = makeRawNode(cnode, source: source)
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
    return moveFromCRawNode(c_top)!
  }
}

fileprivate
func makeRawToken(_ c_node: CSyntaxNode, source: String) -> RawSyntax {
  let tokdat = c_node.token_data
  let kind = tokdat.kind
  var leadingTriviaLen = 0
  for i in 0..<Int(tokdat.leading_trivia_count) {
    leadingTriviaLen += Int(tokdat.leading_trivia![i].length)
  }
  var trailingTriviaLen = 0
  for i in 0..<Int(tokdat.trailing_trivia_count) {
    trailingTriviaLen += Int(tokdat.trailing_trivia![i].length)
  }

  let offset = Int(c_node.range.offset)
  let totalLen = Int(c_node.range.length)
  let tokOffset = offset + leadingTriviaLen
  let tokLen = totalLen - (leadingTriviaLen + trailingTriviaLen)

  let text = source.utf8Slice(offset: tokOffset, length: tokLen)
  let tokKind = TokenKind.fromRawValue(kind: kind, text: text)
  let leadingTrivia = toTrivia(tokdat.leading_trivia,
                               count: Int(tokdat.leading_trivia_count),
                               offset: offset, source: source)
  let trailingTrivia = toTrivia(tokdat.trailing_trivia,
                                count: Int(tokdat.trailing_trivia_count),
                                offset: tokOffset+tokLen, source: source)
  let presence: SourcePresence = c_node.present ? .present : .missing
  return RawSyntax(kind: tokKind, leadingTrivia: leadingTrivia,
                   trailingTrivia: trailingTrivia,
                   length: SourceLength(utf8Length: totalLen),
                   presence: presence)
}

fileprivate
func makeRawNode(_ cnodeptr: CSyntaxNodePtr, source: String) -> RawSyntax {
  let cnode = cnodeptr.pointee
  let kind = SyntaxKind.fromRawValue(cnode.kind)
  if kind == .token {
    return makeRawToken(cnode, source: source)
  } else {
    var layout = [RawSyntax?]()
    layout.reserveCapacity(Int(cnode.layout_data.nodes_count))
    for i in 0..<Int(cnode.layout_data.nodes_count) {
      // The parser guarantees that the `RawSyntax` pointers we passed via the
      // node handler, we'll get them back in a depth-first fashion.
      // From the memory management perspective we gave ownership of the
      // `RawSyntax` object to the C parser via the node handler and now we get
      // ownership back.
      let subnode = moveFromCRawNode(cnode.layout_data.nodes![i])
      layout.append(subnode)
    }
    let totalLen = Int(cnode.range.length)
    let presence: SourcePresence = cnode.present ? .present : .missing
    return RawSyntax(kind: kind, layout: layout,
      length: SourceLength(utf8Length: totalLen), presence: presence)
  }
}

fileprivate
func moveFromCRawNode(_ ptr: UnsafeMutableRawPointer?) -> RawSyntax? {
  guard let ptr = ptr else {
    return nil
  }
  // Get ownership back from the C parser.
  let node: RawSyntax = Unmanaged.fromOpaque(ptr).takeRetainedValue()
  return node
}

fileprivate
func toTrivia(_ cptr: CTriviaPiecePtr?, count: Int, offset: Int,
              source: String) -> Trivia {
  var pieces = [TriviaPiece]()
  pieces.reserveCapacity(count)
  var offs = offset
  for i in 0..<count {
    let c_piece = cptr![i]
    let piece = toTriviaPiece(c_piece, offset: offs, source: source)
    pieces.append(piece)
    offs += Int(c_piece.length)
  }
  return Trivia(pieces: pieces)
}

fileprivate
func toTriviaPiece(_ c_piece: CTriviaPiece, offset: Int,
                   source: String) -> TriviaPiece {
  let kind = c_piece.kind
  let text = source.utf8Slice(offset: offset, length: Int(c_piece.length))
  return TriviaPiece.fromRawValue(kind: kind, length: Int(c_piece.length),
                                  text: text)
}
