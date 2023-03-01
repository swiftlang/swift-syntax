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

let rawSyntaxValidationFile = try! SourceFileSyntax(leadingTrivia: generateCopyrightHeader(for: "generate-swiftsyntax")) {
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
          poundKeyword: .poundIfKeyword(),
          condition: ExprSyntax("DEBUG"),
          elements: .statements(
            try CodeBlockItemListSyntax {
              DeclSyntax(
                #"""
                enum ValidationError: CustomStringConvertible {
                  case expectedNonNil(expectedKind: RawSyntaxNodeProtocol.Type, file: StaticString, line: UInt)
                  case kindMismatch(expectedKind: RawSyntaxNodeProtocol.Type, actualKind: SyntaxKind, file: StaticString, line: UInt)

                  var description: String {
                    switch self {
                    case .expectedNonNil(expectedKind: let expectedKind, file: _, line: _):
                      return "Expected non-nil node of type \(expectedKind) but received nil"
                    case .kindMismatch(expectedKind: let expectedKind, actualKind: let actualKind, file: _, line: _):
                      return "Expected node of type \(expectedKind) but received \(actualKind)"
                    }
                  }

                  var fileAndLine: (StaticString, UInt) {
                    switch self {
                    case .expectedNonNil(expectedKind: _, file: let file, line: let line):
                      return (file, line)
                    case .kindMismatch(expectedKind: _, actualKind: _, file: let file, line: let line):
                      return (file, line)
                  }
                  }
                }
                """#
              )

              DeclSyntax(
                """
                func verify<Node: RawSyntaxNodeProtocol>(_ raw: RawSyntax?, as _: Node.Type, file: StaticString = #file, line: UInt = #line) -> ValidationError? {
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
                func verify<Node: RawSyntaxNodeProtocol>(_ raw: RawSyntax?, as _: Node?.Type, file: StaticString = #file, line: UInt = #line) -> ValidationError? {
                  if raw != nil {
                    return verify(raw, as: Node.self, file: file, line: line)
                  }
                  return nil
                }
                """
              )

              DeclSyntax(
                #"""
                 func assertNoError(_ nodeKind: SyntaxKind, _ index: Int, _ error: ValidationError?) {
                   if let error = error {
                     let (file, line) = error.fileAndLine
                     assertionFailure("""
                       Error validating child at index \(index) of \(nodeKind):
                       \(error.description)
                       """, file: file, line: line)
                  }
                }
                """#
              )

              DeclSyntax(
                #"""
                func assertAnyHasNoError(_ nodeKind: SyntaxKind, _ index: Int, _ errors: [ValidationError?]) {
                  let nonNilErrors = errors.compactMap({ $0 })
                  if nonNilErrors.count == errors.count, let firstError = nonNilErrors.first {
                    let (file, line) = firstError.fileAndLine
                    assertionFailure("""
                      Error validating child at index \(index) of \(nodeKind):
                      Node did not satisfy any node choice requirement.
                      Validation failures:
                      \(nonNilErrors.map({ "- \($0.description)" }).joined(separator: "\n"))
                      """, file: file, line: line)
                    _ = 1
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
                  try SwitchCaseSyntax("case .\(raw: node.swiftSyntaxKind):") {
                    if node.isBuildable || node.isMissing {
                      ExprSyntax("assert(layout.count == \(raw: node.children.count))")
                      for (index, child) in node.children.enumerated() {
                        switch child.kind {
                        case .nodeChoices(let choices):
                          let verifiedChoices = ArrayExprSyntax {
                            ArrayElementSyntax(
                              leadingTrivia: .newline,
                              expression: ExprSyntax("verify(layout[\(raw: index)], as: Raw\(raw: child.type.buildable).self)")
                            )
                          }

                          ExprSyntax("assertAnyHasNoError(kind, \(raw: index), \(verifiedChoices))")
                        default:
                          ExprSyntax("assertNoError(kind, \(raw: index), verify(layout[\(raw: index)], as: Raw\(raw: child.type.buildable).self))")
                        }
                      }
                    } else if node.isSyntaxCollection {
                      try ForInStmtSyntax("for (index, element) in layout.enumerated()") {
                        if let collectionElementChoices = node.collectionElementChoices, !collectionElementChoices.isEmpty {
                          let verifiedChoices = ArrayExprSyntax {
                            for choiceName in node.collectionElementChoices! {
                              let choice = SYNTAX_NODE_MAP[choiceName]!
                              ArrayElementSyntax(
                                leadingTrivia: .newline,
                                expression: ExprSyntax("verify(element, as: Raw\(raw: choice.name).self)")
                              )
                            }
                          }
                          ExprSyntax("assertAnyHasNoError(kind, index, \(verifiedChoices))")
                        } else {
                          ExprSyntax("assertNoError(kind, index, verify(element, as: Raw\(node.collectionElementType.buildable).self))")
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
