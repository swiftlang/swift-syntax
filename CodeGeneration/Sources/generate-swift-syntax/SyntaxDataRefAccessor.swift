//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax
import SwiftSyntaxBuilder

/// The 'SyntaxProtocol._syntaxDataRef' witness for a node type that stores its
/// '_syntaxNode'.
///
/// Reading the trivial reference out of the stored property borrows it, so unlike the
/// default implementation this doesn't retain and release the arena.
let syntaxDataRefDecl: DeclSyntax = DeclSyntax(
  """
  @_spi(RawSyntax)
  public var _syntaxDataRef: SyntaxDataRef {
    return SyntaxDataRef(_syntaxNode.dataRef)
  }
  """
)
