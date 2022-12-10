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

let typeAttributeFile = SourceFile {
  ImportDecl(
    """
    \(raw: generateCopyrightHeader(for: "generate-swiftparser"))
    @_spi(RawSyntax) import SwiftSyntax
    
    """
  )
  
  ExtensionDecl("extension Parser") {
    EnumDecl("enum TypeAttribute: SyntaxText, ContextualKeywords") {
      for attribute in TYPE_ATTR_KINDS {
        EnumCaseDecl("case \(raw: attribute.name) = \"\(raw: attribute.name)\"")
      }
    }
  }
}
