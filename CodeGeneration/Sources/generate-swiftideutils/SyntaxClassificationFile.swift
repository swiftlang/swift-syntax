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

// Collects the list of classifications to use for contextual classification.
var node_child_classifications: [ChildClassification] {
  var result = [ChildClassification]()
  for node in SYNTAX_NODES {
    for (index, child) in node.children.enumerated() where child.classification?.name != nil {
      result.append(
        ChildClassification(node: node, childIndex: index, child: child)
      )
    }
  }
  
  return result
}

let syntaxClassificationFile = SourceFile {
  ImportDecl(
    """
    \(raw: generateCopyrightHeader(for: "generate-ideutils"))
    @_spi(RawSyntax) import SwiftSyntax
    """
  )
  
  EnumDeclSyntax("public enum SyntaxClassification") {
    for classification in SYNTAX_CLASSIFICATIONS {
      EnumCaseDecl(
        """
        /// \(raw: classification.description)
        case \(raw: classification.swiftName)
        """
      )
    }
  }
  
  ExtensionDeclSyntax("extension SyntaxClassification") {
    FunctionDecl(
        """
        /// Checks if a node has a classification attached via its syntax definition.
        /// - Parameters:
        ///   - parentKind: The parent node syntax kind.
        ///   - indexInParent: The index of the node in its parent.
        ///   - childKind: The node syntax kind.
        /// - Returns: A pair of classification and whether it is "forced", or nil if
        ///   no classification is attached.
        internal static func classify(
            parentKind: SyntaxKind, indexInParent: Int, childKind: SyntaxKind
          ) -> (SyntaxClassification, Bool)?
        """) {
          IfStmt(
            leadingTrivia: [.docLineComment("// Separate checks for token nodes (most common checks) versus checks for layout nodes."), .newlines(1)],
            conditions: ConditionElementList {
              ConditionElement(condition: .expression("childKind == .token"))
            }
          ) {
            SwitchStmtSyntax(expression: ExprSyntax("(parentKind, indexInParent)")) {
              for childClassification in node_child_classifications where childClassification.isToken {
                SwitchCaseSyntax("case (.\(raw: childClassification.parent.swiftSyntaxKind), \(raw: childClassification.childIndex)):") {
                  ReturnStmt("return (.\(raw: childClassification.classification!.swiftName), \(raw: childClassification.force))")
                }
              }
              
              SwitchCaseSyntax("default: return nil")
            }
          } elseBody: {
            SwitchStmtSyntax(expression: ExprSyntax("(parentKind, indexInParent)")) {
              for childClassification in node_child_classifications where !childClassification.isToken {
                SwitchCaseSyntax("case (.\(raw: childClassification.parent.swiftSyntaxKind), \(raw: childClassification.childIndex)):") {
                  ReturnStmt("return (.\(raw: childClassification.classification!.swiftName), \(raw: childClassification.force))")
                }
              }
              
              SwitchCaseSyntax("default: return nil")
            }
          }
        }
  }
  
  ExtensionDecl("extension RawTokenKind") {
    VariableDeclSyntax(
      modifiers: [DeclModifier(name: .internal)],
      name: IdentifierPattern("classification"),
      type: TypeAnnotation(type: TypeSyntax("SyntaxClassification"))) {
        SwitchStmt(expression: ExprSyntax("self")) {
          for token in SYNTAX_TOKENS {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              if let classification = token.classification {
                ReturnStmt("return .\(raw: classification.swiftName)")
              } else {
                ReturnStmt("return .none)")
              }
            }
          }
          SwitchCaseSyntax("case .eof:") {
            ReturnStmt("return .none")
          }
        }
      }
  }
}
