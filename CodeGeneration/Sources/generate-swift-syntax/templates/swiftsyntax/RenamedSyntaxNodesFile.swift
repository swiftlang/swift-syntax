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

let renamedSyntaxNodesFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  for syntaxKind in SyntaxNodeKind.allCases.sorted(by: { $0.deprecatedRawValue ?? "" < $1.deprecatedRawValue ?? "" }) {
    if let deprecatedName = syntaxKind.deprecatedRawValue {
      DeclSyntax(
        """
        @available(*, deprecated, renamed: "\(syntaxKind.syntaxType)")
        public typealias \(raw: deprecatedName.withFirstCharacterUppercased)Syntax = \(syntaxKind.syntaxType)
        """
      )
    }
  }

  try! ExtensionDeclSyntax("public extension SyntaxKind") {
    let syntaxKinds = SyntaxNodeKind.allCases.sorted(by: { $0.deprecatedRawValue ?? "" < $1.deprecatedRawValue ?? "" })
    for syntaxKind in syntaxKinds {
      if let deprecatedName = syntaxKind.deprecatedRawValue {
        DeclSyntax(
          """
          static var \(raw: deprecatedName): Self {
            return .\(syntaxKind.varOrCaseName)
          }
          """
        )
      }
    }
  }
}
