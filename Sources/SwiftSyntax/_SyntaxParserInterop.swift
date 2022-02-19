//===--------------------- _SyntaxParserInterop.swift ---------------------===//
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

/// Namespace for methods needed by the `SwiftSyntaxParser` module to
/// efficiently create `SwiftSyntax` nodes from the C nodes created by the
/// parser.
public enum _SyntaxParserInterop {
  private static func getRetainedOpaque(rawSyntax: RawSyntax) -> CClientNode {
    return Unmanaged.passRetained(rawSyntax).toOpaque()
  }

  /// Create a `RawSyntax` node for the given `cnode` and return an opaque
  /// pointer to the `RawSyntax` node (a `CClientNode`).
  /// After this method finishes, the `RawSyntax` node has a retain count of 1
  /// and is owned by whoever manages the returned `CClientNode`. Passing the
  /// `CClientNode` to `nodeFromRetainedOpaqueRawSyntax` transfers ownership
  /// back to `SwiftSyntax`.
  public static func getRetainedOpaqueRawSyntax(
    cnode: UnsafeRawPointer, source: String
  ) -> CClientNode {
    let cnode = cnode.assumingMemoryBound(to: CSyntaxNode.self)
    // Transfer ownership of the object to the C parser. We get ownership back
    // via `moveFromCRawNode()`.
    let node = RawSyntax.create(from: cnode, source: source)
    return getRetainedOpaque(rawSyntax: node)
  }

  /// Return an opaque pointer to the given `node`.
  /// After this method finishes, the `RawSyntax` node has a retain count of 1
  /// and is owned by whoever manages the returned `CClientNode`. Passing the
  /// `CClientNode` to `nodeFromRetainedOpaqueRawSyntax` transfers ownership
  /// back to `SwiftSyntax`.
  public static func getRetainedOpaqueRawSyntax(node: SyntaxNode)
      -> CClientNode {
    return getRetainedOpaque(rawSyntax: node.raw)
  }

  /// After an opaque pointer to a `RawSyntax` node has been created using one
  /// of the methods above, transfer its ownership back to a `Syntax` node,
  /// which is managed by `SwiftSyntax`.
  public static func nodeFromRetainedOpaqueRawSyntax(_ cRoot: CClientNode)
      -> Syntax {
    return Syntax(SyntaxData.forRoot(RawSyntax.moveFromOpaque(cRoot)))
  }
}
