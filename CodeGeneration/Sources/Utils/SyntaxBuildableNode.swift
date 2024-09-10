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

import SyntaxSupport

extension LayoutNode {
  /// Assuming this node has a single child without a default value, that child.
  public var singleNonDefaultedChild: Child {
    let nonDefaultedParams = children.filter { $0.defaultInitialization == nil }
    precondition(nonDefaultedParams.count == 1)
    return nonDefaultedParams[0]
  }
}

extension CollectionNode {
  /// Assuming this node is a syntax collection, the type of its elements.
  public var collectionElementType: SyntaxNodeKind {
    if let only = self.elementChoices.only {
      only
    } else {
      .syntax
    }
  }
}
