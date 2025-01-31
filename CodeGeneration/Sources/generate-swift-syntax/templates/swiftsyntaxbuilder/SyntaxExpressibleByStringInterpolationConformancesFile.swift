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

  var importingAttrs = AttributeListSyntax {
    var seen: Set<String> = []
    AttributeSyntax("@_spi(ExperimentalLanguageFeatures)").with(\.trailingTrivia, .space)
    for node in NON_BASE_SYNTAX_NODES {
      if let spi = node.spi, seen.insert(spi.text).inserted {
        AttributeSyntax("@_spi(\(spi))").with(\.trailingTrivia, .space)
      }
    }
  }

  DeclSyntax(
    """
    #if compiler(>=6)
    \(importingAttrs) internal import SwiftSyntax
    #else
    \(importingAttrs) import SwiftSyntax
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
      extension \(type): Swift.ExpressibleByStringInterpolation {}
      #endif
      """
    )
  }
}
