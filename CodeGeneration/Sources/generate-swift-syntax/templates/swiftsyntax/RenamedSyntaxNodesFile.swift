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

func deprecationAttribute(for syntaxKind: SyntaxNodeKind) -> AttributeSyntax {
  if let deprecationMessage = syntaxKind.deprecationMessage {
    return AttributeSyntax("@available(*, deprecated, message: \(literal: deprecationMessage))")
  }
  return AttributeSyntax(#"@available(*, deprecated, renamed: "\#(syntaxKind.syntaxType)")"#)
}

let renamedSyntaxNodesFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  for syntaxKind in SyntaxNodeKind.allCases.sorted(by: { $0.deprecatedRawValue ?? "" < $1.deprecatedRawValue ?? "" }) {
    if let deprecatedName = syntaxKind.deprecatedRawValue {
      DeclSyntax(
        """
        \(deprecationAttribute(for: syntaxKind))
        public typealias \(raw: deprecatedName.withFirstCharacterUppercased)Syntax = \(syntaxKind.syntaxType)
        """
      )
    }
  }

  try! ExtensionDeclSyntax("extension SyntaxKind") {
    let syntaxKinds = SyntaxNodeKind.allCases.sorted(by: { $0.deprecatedRawValue ?? "" < $1.deprecatedRawValue ?? "" })
    for syntaxKind in syntaxKinds {
      if let deprecatedName = syntaxKind.deprecatedRawValue {
        DeclSyntax(
          """
          \(deprecationAttribute(for: syntaxKind))
          public static var \(raw: deprecatedName): Self {
            return .\(syntaxKind.varOrCaseName)
          }
          """
        )
      }
    }
  }
}
