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

let resultBuildersFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  DeclSyntax(
    """
    #if swift(>=6)
    @_spi(ExperimentalLanguageFeatures) public import SwiftSyntax
    #else
    @_spi(ExperimentalLanguageFeatures) import SwiftSyntax
    #endif
    """
  )

  for node in SYNTAX_NODES.compactMap(\.collectionNode) {
    try! StructDeclSyntax(
      """
      // MARK: - \(node.resultBuilderType)

      \(node.apiAttributes)\
      @resultBuilder
      public struct \(node.resultBuilderType): ListBuilder
      """
    ) {
      DeclSyntax(
        """
        public typealias FinalResult = \(node.syntaxType)
        """
      )

      if node.elementChoices.count > 1 {
        for elementChoice in node.elementChoices {
          DeclSyntax(
            """
            \(elementChoice.node?.apiAttributes ?? [])\
            public static func buildExpression(_ expression: \(elementChoice.syntaxType)) -> Component {
              buildExpression(.init(expression))
            }
            """
          )
        }
      }
    }

    DeclSyntax(
      """
      extension \(node.syntaxType) {
        public init(@\(node.resultBuilderType) itemsBuilder: () throws -> \(node.syntaxType)) rethrows {
          self = try itemsBuilder()
        }
      }
      """
    )
  }
}
