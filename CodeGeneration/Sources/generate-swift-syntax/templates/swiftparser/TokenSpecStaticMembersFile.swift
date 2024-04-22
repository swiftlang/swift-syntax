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

let tokenSpecStaticMembersFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  DeclSyntax(
    """
    #if swift(>=6)
    @_spi(RawSyntax) internal import SwiftSyntax
    #else
    @_spi(RawSyntax) import SwiftSyntax
    #endif
    """
  )

  try! ExtensionDeclSyntax("extension TokenSpec") {
    for tokenSpec in Token.allCases.map(\.spec) where tokenSpec.kind != .keyword {
      DeclSyntax("static var \(tokenSpec.varOrCaseName): TokenSpec { return TokenSpec(.\(tokenSpec.varOrCaseName)) }")
    }

    DeclSyntax("static func keyword(_ keyword: Keyword) -> TokenSpec { return TokenSpec(keyword) }")
  }
}
