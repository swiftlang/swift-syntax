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
import SwiftBasicFormat

let typealiasesFile = SourceFile {
  ImportDecl(
    leadingTrivia: .docLineComment(generateCopyrightHeader(for: "generate-swiftsyntaxbuilder")),
    path: [AccessPathComponent(name: "SwiftSyntax")]
  )

  TypealiasDecl("public typealias Token = TokenSyntax")
  
  for node in SYNTAX_NODES where !node.isUnknown && !node.isMissing {
    TypealiasDecl("public typealias \(raw: node.type.shorthandName) = \(raw: node.type.syntaxBaseName)")
  }
}
