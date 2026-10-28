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

/// Wraps `decl` in the compilation condition that gates the static node structure reflection
/// API, `SyntaxProtocol.structure` and `SyntaxProtocol.keyPathInParent`.
///
/// Building with `-DSWIFTSYNTAX_NO_STRUCTURE_REFLECTION` drops that API, along with the key
/// paths and metatypes it keeps alive.
func ifStructureReflectionEnabled(_ decl: DeclSyntax) -> DeclSyntax {
  return DeclSyntax(
    """
    #if !SWIFTSYNTAX_NO_STRUCTURE_REFLECTION
    \(decl)
    #endif
    """
  )
}
