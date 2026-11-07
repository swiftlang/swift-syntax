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

let childChoicesTypeNameFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  importSwiftSyntax(accessLevel: .internal)

  try! FunctionDeclSyntax(
    """
    /// The name of the `SyntaxChildChoices` type that the child at `property` is declared as,
    /// qualified by the type that nests it. `nil` if the child is not declared as a
    /// `SyntaxChildChoices` type.
    ///
    /// A value of this type has to be wrapped in the named type to be passed to the parent's
    /// initializer, whereas children declared as a base type are accepted by the initializer
    /// as `some XSyntaxProtocol` and need no wrapping.
    func childChoicesTypeName(_ property: SyntaxLayoutProperty) -> String?
    """
  ) {
    try! SwitchExprSyntax("switch property") {
      for node in NON_BASE_SYNTAX_NODES.compactMap(\.layoutNode) {
        for child in node.children where child.kind.isNodeChoices {
          SwitchCaseSyntax("case \(node.type.syntaxBaseName).layout[.\(child.memberCallName)]:") {
            StmtSyntax(#"return "\#(node.type.syntaxBaseName).\#(child.syntaxChoicesType)""#)
          }
        }
      }
      SwitchCaseSyntax(
        """
        default:
          return nil
        """
      )
    }
  }
}
