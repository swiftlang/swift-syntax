//===------ SyntaxVerifier.swift - Syntax Verifier ------------------------===//
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
// Verifier to check that there are no unknown syntax nodes in the tree.
//
//===----------------------------------------------------------------------===//

public enum SyntaxVerifierError: Error, CustomStringConvertible {
  case unknownSyntaxFound(node: Syntax)

  public var description: String {
    switch self {
      case .unknownSyntaxFound(let node):
        return "unknown syntax node for \"\(node)\""
    }
  }
}

/// Verifier to check that there are no unknown syntax nodes in the tree.
public class SyntaxVerifier: SyntaxAnyVisitor {

  var unknownNodes: [Syntax] = []

  init() {
    super.init(viewMode: .all)
  }

  public override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    if node.isUnknown {
      unknownNodes.append(node)
    }
    return .visitChildren
  }

  private func verify(_ node: Syntax) throws {
    self.walk(node)
    if let unknownNode = unknownNodes.first {
      throw SyntaxVerifierError.unknownSyntaxFound(node: unknownNode)
    }
  }

  public static func verify(_ node: Syntax) throws {
    let verifier = SyntaxVerifier()
    try verifier.verify(node)
  }
}
