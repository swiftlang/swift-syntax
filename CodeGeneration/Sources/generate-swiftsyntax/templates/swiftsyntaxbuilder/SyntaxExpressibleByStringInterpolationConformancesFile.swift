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
import SyntaxSupport
import SwiftSyntaxBuilder
import Utils

let syntaxExpressibleByStringInterpolationConformancesFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  DeclSyntax("import SwiftSyntax")
  DeclSyntax("import SwiftParser")
  DeclSyntax("import SwiftParserDiagnostics")

  try! ExtensionDeclSyntax("extension SyntaxParseable") {
    DeclSyntax("public typealias StringInterpolation = SyntaxStringInterpolation")

    DeclSyntax(
      """
      public init(stringInterpolation: SyntaxStringInterpolation) {
        self = performParse(source: stringInterpolation.sourceText, parse: { parser in
          return Self.parse(from: &parser)
        })
      }
      """
    )
  }

  for node in SYNTAX_NODES where node.parserFunction != nil {
    DeclSyntax("extension \(node.kind.syntaxType): SyntaxExpressibleByStringInterpolation {}")
  }

  DeclSyntax(
    """
    // TODO: This should be inlined in SyntaxParseable.init(stringInterpolation:),
    // but is currently used in `ConvenienceInitializers.swift`.
    // See the corresponding TODO there.
    func performParse<SyntaxType: SyntaxProtocol>(source: [UInt8], parse: (inout Parser) -> SyntaxType) -> SyntaxType {
      return source.withUnsafeBufferPointer { buffer in
        var parser = Parser(buffer)
        // FIXME: When the parser supports incremental parsing, put the
        // interpolatedSyntaxNodes in so we don't have to parse them again.
        let result = parse(&parser)
        return result
      }
    }
    """
  )
}
