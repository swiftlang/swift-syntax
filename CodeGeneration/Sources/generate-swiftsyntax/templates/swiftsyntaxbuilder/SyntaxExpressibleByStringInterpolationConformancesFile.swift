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
import SyntaxSupport
import SwiftSyntaxBuilder
import Utils

let syntaxExpressibleByStringInterpolationConformancesFile = SourceFile {
  ImportDecl(
    """
    \(raw: generateCopyrightHeader(for: "generate-swiftsyntaxbuilder"))
    import SwiftSyntax
    """)
  ImportDecl("import SwiftParser")
  ImportDecl("import SwiftParserDiagnostics")
  
  ExtensionDecl("extension SyntaxParseable") {
    InitializerDecl(
      """
      public init(stringInterpolationOrThrow stringInterpolation: SyntaxStringInterpolation) throws {
        self = try performParse(source: stringInterpolation.sourceText, parse: { parser in
          return Self.parse(from: &parser)
        })
      }
      """)
  }
  
  for node in SYNTAX_NODES {
    if node.isBase {
      ExtensionDecl("extension \(node.name)Protocol") {
        InitializerDecl(
          """
          public init(stringInterpolationOrThrow stringInterpolation: SyntaxStringInterpolation) throws {
            self = try performParse(source: stringInterpolation.sourceText, parse: { parser in
              let node = \(raw: node.name).parse(from: &parser)
              guard let result = node.as(Self.self) else {
                throw SyntaxStringInterpolationError.producedInvalidNodeType(expectedType: Self.self, actualType: node.kind.syntaxNodeType)
              }
              return result
            })
          }
          """)
      }
    }

    if node.parserFunction != nil {
      ExtensionDecl("extension \(node.name): SyntaxExpressibleByStringInterpolation") {
        InitializerDecl(
          """
          public init(stringInterpolationOrThrow stringInterpolation: SyntaxStringInterpolation) throws {
            self = try performParse(source: stringInterpolation.sourceText, parse: { parser in
              return Self.parse(from: &parser)
            })
          }
          """)
      }
    } else if !node.isMissing && node.baseType.baseName != "Syntax" && node.baseType.baseName != "SyntaxCollection" {
      ExtensionDecl("extension \(raw: node.name): SyntaxExpressibleByStringInterpolation { }")
    }
  }
  
  FunctionDecl(
    """
    // TODO: This should be fileprivate, but is currently used in
    // `ConvenienceInitializers.swift`. See the corresponding TODO there.
    func performParse<SyntaxType: SyntaxProtocol>(source: [UInt8], parse: (inout Parser) throws -> SyntaxType) throws -> SyntaxType {
      return try source.withUnsafeBufferPointer { buffer in
        var parser = Parser(buffer)
        // FIXME: When the parser supports incremental parsing, put the
        // interpolatedSyntaxNodes in so we don't have to parse them again.
        let result = try parse(&parser)
        if result.hasError {
          let diagnostics = ParseDiagnosticsGenerator.diagnostics(for: result)
          assert(!diagnostics.isEmpty)
          throw SyntaxStringInterpolationError.diagnostics(diagnostics, tree: Syntax(result))
        }
        return result
      }
    }
    """)
}
