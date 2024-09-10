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

let rawSyntaxValidationFile = try! SourceFileSyntax(leadingTrivia: copyrightHeader) {
  try FunctionDeclSyntax(
    """
    /// Check that the `layout` is valid for the given 'SyntaxKind'.
    ///
    /// Note that this only validates the immediate children.
    /// Results in an assertion failure if the layout is invalid.
    func validateLayout(layout: RawSyntaxBuffer, as kind: SyntaxKind)
    """
  ) {
    IfConfigDeclSyntax(
      clauses: try IfConfigClauseListSyntax {
        IfConfigClauseSyntax(
          poundKeyword: .poundIfToken(),
          condition: ExprSyntax("SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION"),
          elements: .statements(
            try CodeBlockItemListSyntax {
              DeclSyntax(
                #"""
                enum TokenChoice: CustomStringConvertible {
                  case keyword(StaticString)
                  case tokenKind(RawTokenKind)

                  var description: String {
                    switch self {
                    case .keyword(let keyword):
                      return "keyword('\(keyword)')"
                    case .tokenKind(let kind):
                      return "\(kind)"
                    }
                  }
                }
                """#
              )

              DeclSyntax(
                #"""
                enum ValidationError: CustomStringConvertible {
                  case expectedNonNil(expectedKind: RawSyntaxNodeProtocol.Type, file: StaticString, line: UInt)
                  case kindMismatch(expectedKind: RawSyntaxNodeProtocol.Type, actualKind: SyntaxKind, file: StaticString, line: UInt)
                  case tokenMismatch(expectedTokenChoices: [TokenChoice], actualKind: RawTokenKind, actualText: SyntaxText, file: StaticString, line: UInt)

                  var description: String {
                    switch self {
                    case .expectedNonNil(expectedKind: let expectedKind, file: _, line: _):
                      return "Expected non-nil node of type \(expectedKind) but received nil"
                    case .kindMismatch(expectedKind: let expectedKind, actualKind: let actualKind, file: _, line: _):
                      return "Expected node of type \(expectedKind) but received \(actualKind)"
                    case .tokenMismatch(expectedTokenChoices: let tokenChoices, actualKind: let actualKind, actualText: let actualText, file: _, line: _):
                      return "Expected token with one of \(tokenChoices) but received \(actualKind) with text '\(actualText)'"
                    }
                  }

                  var fileAndLine: (StaticString, UInt) {
                    switch self {
                    case .expectedNonNil(expectedKind: _, file: let file, line: let line):
                      return (file, line)
                    case .kindMismatch(expectedKind: _, actualKind: _, file: let file, line: let line):
                      return (file, line)
                    case .tokenMismatch(expectedTokenChoices: _, actualKind: _, actualText: _, file: let file, line: let line):
                      return (file, line)
                    }
                  }
                }
                """#
              )

              DeclSyntax(
                """
                func verify<Node: RawSyntaxNodeProtocol>(_ raw: RawSyntax?, as _: Node.Type, file: StaticString = #fileID, line: UInt = #line) -> ValidationError? {
                  guard let raw = raw else {
                    return .expectedNonNil(expectedKind: Node.self, file: file, line: line)
                  }
                  guard Node.isKindOf(raw) else {
                    return .kindMismatch(expectedKind: Node.self, actualKind: raw.kind, file: file, line: line)
                  }
                  return nil
                }
                """
              )

              DeclSyntax(
                """
                func verify<Node: RawSyntaxNodeProtocol>(_ raw: RawSyntax?, as _: Node?.Type, file: StaticString = #fileID, line: UInt = #line) -> ValidationError? {
                  if raw != nil {
                    return verify(raw, as: Node.self, file: file, line: line)
                  }
                  return nil
                }
                """
              )

              DeclSyntax(
                """
                func verify(_ raw: RawSyntax?, as _: RawTokenSyntax?.Type, tokenChoices: [TokenChoice], file: StaticString = #fileID, line: UInt = #line) -> ValidationError? {
                  // Validation of token choice is currently causing assertion failures where
                  // the list of expected token choices in the syntax tree doesn't match those
                  // the parser generates. Disable the verification for now until all issues
                  // regarding it are fixed.
                  if raw != nil {
                    return verify(raw, as: RawTokenSyntax.self, tokenChoices: tokenChoices, file: file, line: line)
                  }
                  return nil
                }
                """
              )

              DeclSyntax(
                """
                func verify(_ raw: RawSyntax?, as _: RawTokenSyntax.Type, tokenChoices: [TokenChoice], file: StaticString = #fileID, line: UInt = #line) -> ValidationError? {
                  // Validation of token choice is currently causing assertion failures where
                  // the list of expected token choices in the syntax tree doesn't match those
                  // the parser generates. Disable the verification for now until all issues
                  // regarding it are fixed.
                  guard let raw = raw else {
                    return .expectedNonNil(expectedKind: RawTokenSyntax.self, file: file, line: line)
                  }
                  if let error = verify(raw, as: RawTokenSyntax?.self) {
                    return error
                  }
                  let tokenView = raw.tokenView!
                  for tokenChoice in tokenChoices {
                    switch tokenChoice {
                    case .tokenKind(let tokenKind):
                      if raw.tokenView?.rawKind == tokenKind {
                        return nil
                      }
                    case .keyword(let keyword):
                      if tokenView.rawKind == .keyword && tokenView.rawText == SyntaxText(keyword) {
                        return nil
                      }
                    }
                  }
                  return ValidationError.tokenMismatch(expectedTokenChoices: tokenChoices, actualKind: tokenView.rawKind, actualText: tokenView.rawText, file: file, line: line)
                }

                """
              )

              DeclSyntax(
                #"""
                func assertNoError(_ nodeKind: SyntaxKind, _ index: Int, _ error: ValidationError?) {
                  if let error {
                    let (file, line) = error.fileAndLine
                    assertionFailure("""
                      Error validating child at index \(index) of \(nodeKind):
                      \(error.description)

                      See "RawSyntax Validation" in CONTRIBUTING.md to reproduce the failure locally.
                      """, file: file, line: line)
                  }
                }
                """#
              )

              try SwitchExprSyntax("switch kind") {
                SwitchCaseSyntax(
                  """
                  case .token:
                    assertionFailure("validateLayout for .token kind is not supported")
                  """
                )

                for node in NON_BASE_SYNTAX_NODES {
                  try SwitchCaseSyntax("case .\(node.enumCaseCallName):") {
                    if let node = node.layoutNode {
                      ExprSyntax("assert(layout.count == \(raw: node.children.count))")
                      for (index, child) in node.children.enumerated() {
                        switch child.kind {
                        case .nodeChoices(let choices):
                          ExprSyntax(
                            "assertNoError(kind, \(raw: index), verify(layout[\(raw: index)], as: \(node.raw.syntaxType).\(child.raw.actualType).self))"
                          )
                        case .token(choices: let choices, requiresLeadingSpace: _, requiresTrailingSpace: _):
                          let choices = ArrayExprSyntax {
                            for choice in choices {
                              switch choice {
                              case .keyword(let keyword):
                                ArrayElementSyntax(expression: ExprSyntax(".keyword(\(literal: keyword.spec.name))"))
                              case .token(let token):
                                ArrayElementSyntax(expression: ExprSyntax(".tokenKind(.\(token.spec.memberCallName))"))
                              }
                            }
                          }
                          let verifyCall = ExprSyntax(
                            "verify(layout[\(raw: index)], as: \(child.raw.actualType).self, tokenChoices: \(choices))"
                          )
                          ExprSyntax("assertNoError(kind, \(raw: index), \(verifyCall))")
                        default:
                          ExprSyntax(
                            "assertNoError(kind, \(raw: index), verify(layout[\(raw: index)], as: \(child.raw.actualType).self))"
                          )
                        }
                      }
                    } else if let node = node.collectionNode {
                      try ForStmtSyntax("for (index, element) in layout.enumerated()") {
                        if let onlyElement = node.elementChoices.only {
                          ExprSyntax(
                            "assertNoError(kind, index, verify(element, as: \(onlyElement.raw.syntaxType).self))"
                          )
                        } else {
                          ExprSyntax(
                            "assertNoError(kind, index, verify(element, as: \(node.raw.syntaxType).Element.self))"
                          )
                        }
                      }
                    }
                  }
                }
              }
            }
          )
        )
      }
    )
  }
}
