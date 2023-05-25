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

public let SYNTAX_NODES: [Node] =
  (COMMON_NODES
  + EXPR_NODES
  + DECL_NODES
  + ATTRIBUTE_NODES
  + STMT_NODES
  + GENERIC_NODES
  + TYPE_NODES
  + PATTERN_NODES
  + AVAILABILITY_NODES).sorted { $0.kind.syntaxType.description < $1.kind.syntaxType.description }

/// A lookup table of nodes indexed by their kind.
public let SYNTAX_NODE_MAP: [SyntaxNodeKind: Node] = Dictionary(
  uniqueKeysWithValues: SYNTAX_NODES.map { node in (node.kind, node) }
)

public let NON_BASE_SYNTAX_NODES = SYNTAX_NODES.filter { !$0.kind.isBase }
