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

//==========================================================================//
// IMPORTANT: The macros defined in this file are intended to test the      //
// behavior of MacroSystem. Many of them do not serve as good examples of   //
// how macros should be written. In particular, they often lack error       //
// handling because it is not needed in the few test cases in which these   //
// macros are invoked.                                                      //
//==========================================================================//

import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

fileprivate struct DeclsFromStringsMacro: DeclarationMacro {
  static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    var strings: [String] = []
    for arg in node.arguments {
      guard let value = arg.expression.as(StringLiteralExprSyntax.self)?.representedLiteralValue else {
        continue
      }
      strings.append(value)
    }

    return strings.map { "\(raw: $0)" }
  }
}

final class CodeItemMacroTests: XCTestCase {
  private let indentationWidth: Trivia = .spaces(2)

  func testUnwrap() {
    struct UnwrapMacro: CodeItemMacro {
      static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
      ) throws -> [CodeBlockItemSyntax] {
        guard !node.arguments.isEmpty else {
          throw SwiftSyntaxMacros.MacroExpansionErrorMessage("'#unwrap' requires arguments")
        }
        let errorThrower = node.trailingClosure
        let identifiers = try node.arguments.map { argument in
          guard let declReferenceExpr = argument.expression.as(DeclReferenceExprSyntax.self) else {
            throw SwiftSyntaxMacros.MacroExpansionErrorMessage("Arguments must be identifiers")
          }
          return declReferenceExpr.baseName
        }

        func elseBlock(_ token: TokenSyntax) -> CodeBlockSyntax {
          let expr: ExprSyntax
          if let errorThrower {
            expr = """
              \(errorThrower)("\(raw: token.text)")
              """
          } else {
            expr = """
              fatalError("'\(raw: token.text)' is nil")
              """
          }
          return .init(
            statements: .init([
              .init(
                leadingTrivia: " ",
                item: .expr(expr),
                trailingTrivia: " "
              )
            ])
          )
        }

        return identifiers.map { (identifier) -> CodeBlockItemSyntax in
          "guard let \(raw: identifier.text) else \(elseBlock(identifier))"
        }
      }
    }

    assertMacroExpansion(
      #"""
      let x: Int? = 1
      let y: Int? = nil
      let z: Int? = 3
      #unwrap(x, y, z)
      #unwrap(x, y, z) {
        fatalError("nil is \\($0)")
      }
      """#,
      expandedSource: #"""
        let x: Int? = 1
        let y: Int? = nil
        let z: Int? = 3
        guard let x else {
          fatalError("'x' is nil")
        }
        guard let y else {
          fatalError("'y' is nil")
        }
        guard let z else {
          fatalError("'z' is nil")
        }
        guard let x else {
          {
            fatalError("nil is \\($0)")
          }("x")
        }
        guard let y else {
          {
            fatalError("nil is \\($0)")
          }("y")
        }
        guard let z else {
          {
            fatalError("nil is \\($0)")
          }("z")
        }
        """#,
      macros: ["unwrap": UnwrapMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testEmpty() {
    struct TestMacro: CodeItemMacro {
      static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
      ) throws -> [CodeBlockItemSyntax] {
        return []
      }
    }

    assertMacroExpansion(
      "#test",
      expandedSource: "",
      macros: [
        "test": TestMacro.self
      ]
    )
  }
}
