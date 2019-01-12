//===--------------- SwiftSyntax.swift - Swift Syntax Library -------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2018 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//
// This file provides main entry point into the Syntax library.
//===----------------------------------------------------------------------===//

import Foundation

#if os(macOS)
import Darwin
#elseif os(Linux)
import Glibc
#endif

public enum SerializationFormat {
  case json
  case byteTree
}

// For WeakLookupTable.
extension RawSyntax : Identifiable {}

/// Deserializes the syntax tree from its serialized form to an object tree in
/// Swift. To deserialize incrementally transferred syntax trees, the same
/// instance of the deserializer must be used for all subsequent
/// deserializations.
public final class SyntaxTreeDeserializer {
  /// Syntax nodes that have already been parsed and are able to be reused if
  /// they were omitted in an incremental syntax tree transfer
  private var nodeLookupTable: WeakLookupTable<RawSyntax> = .init()

  /// Keep a strong reference to the syntax tree that contains the nodes in the
  /// `nodeLookupTable`. Because `nodeLookupTable` only holds a weak reference 
  /// to the RawSyntax nodes, all retired `RawSyntax` nodes will be deallocated
  /// once we set a new tree. The weak references in `nodeLookupTable` will then
  /// become `nil` and the slot will be reused to refer another node.
  private var nodeLookupTree: RawSyntax? = nil

  /// The IDs of the nodes that were reused as part of incremental syntax
  /// parsing during the last deserialization
  public var reusedNodeIds: Set<SyntaxNodeId> = []

  public init() {
  }

  /// Deserialize the given data as a JSON encoded syntax tree
  private func deserializeJSON(_ data: Data) throws -> RawSyntax {
    let decoder = JSONDecoder()
    decoder.userInfo[.rawSyntaxDecodedCallback] = self.addToLookupTable
    decoder.userInfo[.omittedNodeLookupFunction] = self.lookupNode
    let tree = try decoder.decode(RawSyntax.self, from: data)
    self.nodeLookupTree = tree
    return tree
  }

  /// Deserialize the given data as a ByteTree encoded syntax tree
  private func deserializeByteTree(_ data: Data) throws -> RawSyntax {
    var userInfo: [ByteTreeUserInfoKey: Any] = [:]
    userInfo[.rawSyntaxDecodedCallback] = self.addToLookupTable
    userInfo[.omittedNodeLookupFunction] = self.lookupNode
    let tree = try ByteTreeReader.read(RawSyntax.self, from: data,
                                            userInfo: &userInfo) {
      (version: ByteTreeProtocolVersion) in
      return version.major == 1
    }
    self.nodeLookupTree = tree
    return tree
  }

  /// Decode a serialized form of SourceFileSyntax to a syntax tree.
  /// - Parameter data: The UTF-8 represenation of the serialized syntax tree
  /// - Parameter serializationFormat: The format in which the syntax tree was
  ///                                  serialized
  /// - Returns: A top-level Syntax node representing the contents of the tree,
  ///            if the parse was successful.
  public func deserialize(
    _ data: Data, serializationFormat: SerializationFormat
  ) throws -> SourceFileSyntax {
    reusedNodeIds = []
    let rawSyntax: RawSyntax
    switch serializationFormat {
    case .json:
      rawSyntax = try deserializeJSON(data)
    case .byteTree:
      rawSyntax = try deserializeByteTree(data)
    }
    guard let file = makeSyntax(rawSyntax) as? SourceFileSyntax else {
      throw ParserError.invalidSyntaxData
    }
    return file
  }

  // MARK: Incremental deserialization helper functions

  private func lookupNode(id: SyntaxNodeId) -> RawSyntax? {
    reusedNodeIds.insert(id)
    return nodeLookupTable[id]
  }

  private func addToLookupTable(_ node: RawSyntax) {
    nodeLookupTable.insert(node)
  }
}

fileprivate extension Array {
  func withUnsafeData<T>(_ body: (Data) throws -> T) rethrows -> T {
    return try self.withUnsafeBufferPointer {
        (pointer: UnsafeBufferPointer<Element>) -> T in
      let data = Data(buffer: pointer)
      return try body(data)
    }
  }
}
