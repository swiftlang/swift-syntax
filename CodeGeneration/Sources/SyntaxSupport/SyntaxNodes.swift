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

public let SYNTAX_NODES: [Node] = COMMON_NODES
  + EXPR_NODES
  + DECL_NODES
  + ATTRIBUTE_NODES
  + STMT_NODES
  + GENERIC_NODES
  + TYPE_NODES
  + PATTERN_NODES
  + AVAILABILITY_NODES

/// A lookup table of nodes indexed by their kind.
public let SYNTAX_NODE_MAP: [String: Node] = Dictionary(
  uniqueKeysWithValues: SYNTAX_NODES.map { node in (node.syntaxKind, node) }
)
