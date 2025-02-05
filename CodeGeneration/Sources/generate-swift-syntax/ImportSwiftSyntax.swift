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
import SyntaxSupport

enum ImportAccessLevel {
  case `public`
  case `internal`
}

func importSwiftSyntax(accessLevel: ImportAccessLevel = .internal) -> DeclSyntax {
  // Import all '@_spi'.
  let importingAttrs = AttributeListSyntax {
    var seen: Set<String> = []
    AttributeSyntax("@_spi(RawSyntax)").with(\.trailingTrivia, .space)
    AttributeSyntax("@_spi(ExperimentalLanguageFeatures)").with(\.trailingTrivia, .space)
    for node in NON_BASE_SYNTAX_NODES {
      if let spi = node.spi, seen.insert(spi.text).inserted {
        AttributeSyntax("@_spi(\(spi))").with(\.trailingTrivia, .space)
      }
    }
  }
  let visibilityKeyword: TokenSyntax
  switch accessLevel {
  case .internal:
    visibilityKeyword = "internal"
  case .public:
    visibilityKeyword = "public"
  }

  return DeclSyntax(
    """
    #if compiler(>=6)
    \(importingAttrs)\(visibilityKeyword) import SwiftSyntax
    #else
    \(importingAttrs)import SwiftSyntax
    #endif
    """
  )
}
