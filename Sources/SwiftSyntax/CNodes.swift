//===---------------------------- CNodes.swift ----------------------------===//
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

@_implementationOnly import _CSwiftSyntax

// These two types need to be exposed publicly, so they can't rely on the C
// types defined in _CSwiftSyntax.
public typealias CSyntaxKind = UInt16
public typealias CClientNode = UnsafeMutableRawPointer

typealias CSyntaxNode = swiftparse_syntax_node_t
typealias CSyntaxNodePtr = UnsafePointer<CSyntaxNode>
typealias CTokenKind = swiftparse_token_kind_t
typealias CTriviaKind = swiftparse_trivia_kind_t
typealias CTokenData = swiftparse_token_data_t
typealias CLayoutData = swiftparse_layout_data_t
typealias CTriviaPiecePtr = UnsafePointer<CTriviaPiece>
typealias CTriviaPiece = swiftparse_trivia_piece_t

/// Computes a hash value that describes the layout of all C nodes which are
/// passed as opaque values between `SwiftSyntaxParser` and `SwiftSyntax`.
/// This should match the value returned by the `cNodeLayoutHash` function in
/// the `SwiftSyntaxParser` module.
public func cNodeLayoutHash() -> Int {
  var hasher = Hasher()

  // These two types are not defined in terms of the C types in SwiftSyntax.
  // Let's include them specifically in the hash as well.
  hasher.combine(MemoryLayout<CSyntaxKind>.size)
  hasher.combine(MemoryLayout<CClientNode>.size)

  hasher.combine(MemoryLayout<swiftparse_range_t>.size)
  hasher.combine(MemoryLayout<swiftparse_range_t>.offset(of: \.offset))
  hasher.combine(MemoryLayout<swiftparse_range_t>.offset(of: \.length))

  hasher.combine(MemoryLayout<swiftparse_trivia_kind_t>.size)
  hasher.combine(MemoryLayout<swiftparse_token_kind_t>.size)
  hasher.combine(MemoryLayout<swiftparse_syntax_kind_t>.size)

  hasher.combine(MemoryLayout<swiftparse_client_node_t>.size)

  hasher.combine(MemoryLayout<swiftparse_trivia_piece_t>.size)
  hasher.combine(MemoryLayout<swiftparse_trivia_piece_t>.offset(of: \.length))
  hasher.combine(MemoryLayout<swiftparse_trivia_piece_t>.offset(of: \.kind))

  hasher.combine(MemoryLayout<swiftparse_token_data_t>.size)
  hasher.combine(MemoryLayout<swiftparse_token_data_t>.offset(of: \.leading_trivia))
  hasher.combine(MemoryLayout<swiftparse_token_data_t>.offset(of: \.trailing_trivia))
  hasher.combine(MemoryLayout<swiftparse_token_data_t>.offset(of: \.leading_trivia_count))
  hasher.combine(MemoryLayout<swiftparse_token_data_t>.offset(of: \.trailing_trivia_count))
  hasher.combine(MemoryLayout<swiftparse_token_data_t>.offset(of: \.kind))
  hasher.combine(MemoryLayout<swiftparse_token_data_t>.offset(of: \.range))

  hasher.combine(MemoryLayout<swiftparse_layout_data_t>.size)
  hasher.combine(MemoryLayout<swiftparse_layout_data_t>.offset(of: \.nodes))
  hasher.combine(MemoryLayout<swiftparse_layout_data_t>.offset(of: \.nodes_count))

  hasher.combine(MemoryLayout<swiftparse_syntax_node_t>.size)
  hasher.combine(MemoryLayout<swiftparse_syntax_node_t>.offset(of: \.kind))
  hasher.combine(MemoryLayout<swiftparse_syntax_node_t>.offset(of: \.present))

  return hasher.finalize()
}
