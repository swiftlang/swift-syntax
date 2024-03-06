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

let buildableNodesFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  DeclSyntax(
    """
    #if swift(>=6)
    @_spi(ExperimentalLanguageFeatures) public import SwiftSyntax
    #else
    @_spi(ExperimentalLanguageFeatures) import SwiftSyntax
    #endif
    """
  )

  for node in SYNTAX_NODES.compactMap(\.layoutNode) {
    let type = node.type

    if let convenienceInit = try! node.createConvenienceBuilderInitializer() {
      DeclSyntax(
        """
        extension \(type.syntaxBaseName) {
        \(convenienceInit)
        }
        """
      )
    }
  }
}
