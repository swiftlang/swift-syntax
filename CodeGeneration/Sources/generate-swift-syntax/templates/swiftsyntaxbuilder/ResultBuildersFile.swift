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
  DeclSyntax("import SwiftSyntax")

  for node in SYNTAX_NODES.compactMap(\.collectionNode) {
    let type = SyntaxBuildableType(kind: .node(kind: node.kind))

    try! StructDeclSyntax(
      """
      // MARK: - \(type.resultBuilderType)

      @resultBuilder
      \(node.node.apiAttributes())\
      public struct \(type.resultBuilderType): ListBuilder
      """
    ) {
      DeclSyntax(
        """
        public typealias FinalResult = \(type.syntaxBaseName)
        """
      )

      if node.elementChoices.count > 1 {
        for elementChoice in node.elementChoices {
          DeclSyntax(
            """
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
      public extension \(type.syntaxBaseName) {
        init(@\(type.resultBuilderType) itemsBuilder: () throws -> \(type.syntaxBaseName)) rethrows {
          self = try itemsBuilder()
        }
      }
      """
    )
  }
}
