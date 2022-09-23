//// Automatically Generated From NodeDeclarationHash.swift.gyb.
//// Do Not Edit Directly!
//===--------------------- NodeDeclarationHash.swift ----------------------===//
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

@_implementationOnly import _InternalSwiftSyntaxParser

extension SyntaxParser {
  static func verifyNodeDeclarationHash() -> Bool {
    return String(cString: swiftparse_syntax_structure_versioning_identifier()!) ==
      "02005359b9e133d40bc189a32fb0fee13480b5a1"
  }
}
