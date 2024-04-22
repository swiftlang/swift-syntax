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

import SwiftSyntax
import SwiftSyntaxBuilder
import SyntaxSupport
import Utils

let syntaxExpressibleByStringInterpolationConformancesFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  DeclSyntax(
    """
    #if swift(>=6)
    internal import SwiftSyntax
    #else
    import SwiftSyntax
    #endif
    """
  )

  let typesExpressibleByStringInterpolation =
    SYNTAX_NODES
    .filter { $0.parserFunction != nil }
    .map { $0.kind.syntaxType }
    // `SyntaxParsable` conformance for collection nodes is hand-written.
    + [
      "AccessorDeclListSyntax",
      "AttributeListSyntax",
      "CodeBlockItemListSyntax",
      "MemberBlockItemListSyntax",
    ]

  for type in typesExpressibleByStringInterpolation {
    DeclSyntax("extension \(type): SyntaxExpressibleByStringInterpolation {}")
    DeclSyntax(
      """
      #if compiler(>=6)
      extension \(type): @retroactive ExpressibleByStringInterpolation {}
      #endif
      """
    )
  }
}
