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

import SwiftSyntax
import SwiftSyntaxBuilder
import SyntaxSupport
import Utils

let renamedChildrenBuilderCompatibilityFile = try! SourceFileSyntax(leadingTrivia: copyrightHeader) {
  DeclSyntax(
    """
    #if swift(>=6)
    public import SwiftSyntax
    #else
    import SwiftSyntax
    #endif
    """
  )

  for layoutNode in SYNTAX_NODES.compactMap(\.layoutNode).filter({ !$0.childHistory.isEmpty }) {
    let deprecatedMembers = SYNTAX_COMPATIBILITY_LAYER.deprecatedMembers(for: layoutNode)

    for signature in deprecatedMembers.inits {
      if let convenienceInit = try signature.createConvenienceBuilderInitializer() {
        let deprecatedNames = layoutNode.children
          .filter { !$0.isUnexpectedNodes && !signature.children.contains($0) }
          .compactMap { $0.identifier.description }
          .joined(separator: ", ")

        DeclSyntax(
          """
          extension \(layoutNode.type.syntaxBaseName) {
          @available(*, deprecated, message: "Use an initializer with \(raw: deprecatedNames) argument(s).")
          @_disfavoredOverload
          \(convenienceInit)
          }
          """
        )
      }
    }
  }
}
