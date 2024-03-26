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

private let unsortedSyntaxNodes: [Node] =
  COMMON_NODES
  + EXPR_NODES
  + DECL_NODES
  + ATTRIBUTE_NODES
  + STMT_NODES
  + GENERIC_NODES
  + TYPE_NODES
  + PATTERN_NODES
  + AVAILABILITY_NODES

public let SYNTAX_NODES: [Node] =
  unsortedSyntaxNodes
  .sorted { (lhs: Node, rhs: Node) -> Bool in
    let lhsSortKey = lhs.kind.syntaxType.description.droppingLeadingUnderscores
    let rhsSortKey = rhs.kind.syntaxType.description.droppingLeadingUnderscores
    return lhsSortKey < rhsSortKey
  }

/// A lookup table of nodes indexed by their kind.
public let SYNTAX_NODE_MAP: [SyntaxNodeKind: Node] = Dictionary(
  uniqueKeysWithValues: SYNTAX_NODES.map { node in (node.kind, node) }
)

public let NON_BASE_SYNTAX_NODES = SYNTAX_NODES.filter { !$0.kind.isBase }
