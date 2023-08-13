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

let childNameForKeyPathFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  try! FunctionDeclSyntax(
    """
    /// If the keyPath is one from a layout structure, return the property name
    /// of it.
    @_spi(RawSyntax)
    public func childName(_ keyPath: AnyKeyPath) -> String?
    """
  ) {
    try! SwitchExprSyntax("switch keyPath") {
      for node in NON_BASE_SYNTAX_NODES.compactMap(\.layoutNode) {
        for child in node.children {
          SwitchCaseSyntax(
            """
            case \\\(node.type.syntaxBaseName).\(child.varOrCaseName):
              return \(literal: child.varOrCaseName.description)
            """
          )
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
