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

func rawSyntaxNodesFile(nodesStartingWith: [Character]) -> SourceFileSyntax {
  return SourceFileSyntax(leadingTrivia: copyrightHeader) {

    importSwiftSyntax(accessLevel: .internal)

    for node in SYNTAX_NODES
    where node.kind.isBase
      && nodesStartingWith.contains(node.kind.syntaxType.description.droppingLeadingUnderscores.first!)
      && !node.kind.isDeprecated
    {
      DeclSyntax(
        """
        protocol \(node.kind.raw.protocolType): \(node.base.raw.protocolType) {}
        """
      )
    }

    for node in SYNTAX_NODES
    where nodesStartingWith.contains(node.kind.syntaxType.description.droppingLeadingUnderscores.first!) {
      try! StructDeclSyntax(
        """
        struct \(node.kind.raw.syntaxType): \(node.kind.isBase ? node.kind.raw.protocolType : node.base.raw.protocolType)
        """
      ) {
        for childNodeChoices in node.childrenNodeChoices(forRaw: true) {
          childNodeChoices.rawEnumDecl
        }

        DeclSyntax(
          """
          var layoutView: RawSyntaxLayoutView {
            return raw.layoutView!
          }
          """
        )

        try FunctionDeclSyntax("static func isKindOf(_ raw: RawSyntax) -> Bool") {
          if node.kind.isBase {

            let cases = SwitchCaseItemListSyntax {
              for n in SYNTAX_NODES where n.base == node.kind {
                SwitchCaseItemSyntax(
                  pattern: ExpressionPatternSyntax(
                    expression: ExprSyntax(".\(n.memberCallName)")
                  )
                )
              }
            }

            ExprSyntax(
              """
              switch raw.kind {
              case \(cases): return true
              default: return false
              }
              """
            )
          } else {
            StmtSyntax("return raw.kind == .\(node.memberCallName)")
          }
        }

        DeclSyntax("var raw: RawSyntax")

        DeclSyntax(
          """
          init(raw: RawSyntax) {
            precondition(Self.isKindOf(raw))
            self.raw = raw
          }
          """
        )

        DeclSyntax(
          """
          private init(unchecked raw: RawSyntax) {
            self.raw = raw
          }
          """
        )

        DeclSyntax(
          """
          init?(_ other: some RawSyntaxNodeProtocol) {
            guard Self.isKindOf(other.raw) else { return nil }
            self.init(unchecked: other.raw)
          }
          """
        )

        if node.kind.isBase {
          DeclSyntax(
            """
            init(_ other: some \(node.kind.raw.protocolType)) {
              self.init(unchecked: other.raw)
            }
            """
          )
        }

        if let node = node.collectionNode {
          let element = node.elementChoices.only != nil ? node.elementChoices.only!.raw.syntaxType : "Element"
          DeclSyntax(
            """
            init(elements: [\(element)], arena: __shared RawSyntaxArena) {
              let raw = RawSyntax.makeLayout(
                kind: .\(node.memberCallName), uninitializedCount: elements.count, arena: arena) { layout in
                  guard var ptr = layout.baseAddress else { return }
                  for elem in elements {
                    ptr.initialize(to: elem.raw)
                    ptr += 1
                  }
              }
              self.init(unchecked: raw)
            }
            """
          )

          DeclSyntax(
            """
            var elements: [Raw\(node.collectionElementType.syntaxBaseName)] {
              layoutView.children.map { Raw\(node.collectionElementType.syntaxBaseName)(raw: $0!) }
            }
            """
          )
        }

        if let node = node.layoutNode {
          let params = FunctionParameterListSyntax {
            for child in node.children {
              FunctionParameterSyntax(
                firstName: child.isUnexpectedNodes ? .wildcardToken(trailingTrivia: .space) : child.labelDeclName,
                secondName: child.isUnexpectedNodes ? child.labelDeclName : nil,
                colon: .colonToken(),
                type: child.rawParameterType,
                defaultValue: child.isUnexpectedNodes ? child.defaultInitialization : nil
              )
            }

            FunctionParameterSyntax("arena: __shared RawSyntaxArena")
          }
          try InitializerDeclSyntax("init(\(params))") {
            if !node.children.isEmpty {
              let list = ExprListSyntax {
                ExprSyntax("layout.initialize(repeating: nil)")
                for (index, child) in node.children.enumerated() {
                  let optionalMark = child.isOptional ? "?" : ""

                  ExprSyntax(
                    "layout[\(raw: index)] = \(child.baseCallName)\(raw: optionalMark).raw"
                  )
                  .with(\.leadingTrivia, .newline)
                }
              }

              DeclSyntax(
                """
                let raw = RawSyntax.makeLayout(
                  kind: .\(node.memberCallName), uninitializedCount: \(raw: node.children.count), arena: arena) { layout in
                  \(list)
                }
                """
              )
            } else {
              DeclSyntax("let raw = RawSyntax.makeEmptyLayout(kind: .\(node.memberCallName), arena: arena)")
            }
            ExprSyntax("self.init(unchecked: raw)")
          }

          for (index, child) in node.children.enumerated() {
            try VariableDeclSyntax(
              "var \(child.varDeclName): Raw\(child.buildableType.buildable)"
            ) {
              let exclamationMark = child.isOptional ? "" : "!"

              if child.syntaxNodeKind == .syntax {
                ExprSyntax("layoutView.children[\(raw: index)]\(raw: exclamationMark)")
              } else {
                ExprSyntax(
                  "layoutView.children[\(raw: index)].map(\(child.syntaxNodeKind.raw.syntaxType).init(raw:))\(raw: exclamationMark)"
                )
              }
            }
          }
        }
      }
    }
  }
}

private extension ChildNodeChoices {
  var rawEnumDecl: EnumDeclSyntax {
    try! EnumDeclSyntax("enum \(self.name): RawSyntaxNodeProtocol") {
      for choice in self.choices {
        choice.enumCaseDecl(internal: true)
      }

      self.isKindOfFuncDecl(parameterName: "raw", parameterType: "RawSyntax", accessLevel: nil)

      self.syntaxGetter(propertyName: "raw", propertyType: "RawSyntax", accessLevel: nil)

      self.syntaxInitDecl(inputType: "__shared some RawSyntaxNodeProtocol", accessLevel: nil)

      for choice in self.choices {
        if let baseTypeInitDecl = choice.baseTypeInitDecl(hasArgumentName: true, accessLevel: nil) {
          baseTypeInitDecl
        }
      }
    }
  }
}

fileprivate extension Child {
  var rawParameterType: TypeSyntax {
    var paramType: TypeSyntax
    if !kind.isNodeChoicesEmpty {
      paramType = "\(syntaxChoicesType)"
    } else if hasBaseType && !isOptional {
      // we restrict the use of generic type to non-optional parameter types, otherwise call sites would no longer be
      // able to just pass `nil` to this parameter without specializing `(some Raw<Kind>SyntaxNodeProtocol)?`
      //
      // we've opted out of providing a default value to the parameter (e.g. `RawExprSyntax?.none`) as a workaround,
      // as passing an explicit `nil` would prompt developers to think clearly whether this parameter should be parsed
      paramType = "some \(syntaxNodeKind.raw.protocolType)"
    } else {
      paramType = syntaxNodeKind.raw.syntaxType
    }

    return buildableType.optionalWrapped(type: paramType)
  }
}
