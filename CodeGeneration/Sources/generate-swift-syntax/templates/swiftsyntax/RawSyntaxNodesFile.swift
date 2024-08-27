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

fileprivate extension Node {
  var childrenChoicesEnums: [(name: TypeSyntax, choices: [(caseName: TokenSyntax, kind: SyntaxNodeKind)])] {
    let node = self
    if let node = node.layoutNode {
      return node.children.compactMap {
        child -> (name: TypeSyntax, choices: [(caseName: TokenSyntax, kind: SyntaxNodeKind)])? in
        switch child.kind {
        case .nodeChoices(let choices):
          return (child.syntaxChoicesType, choices.map { ($0.identifier, $0.syntaxNodeKind) })
        default:
          return nil
        }
      }
    } else if let node = node.collectionNode, node.elementChoices.count > 1 {
      let choices = node.elementChoices.map { choice -> (TokenSyntax, SyntaxNodeKind) in
        (SYNTAX_NODE_MAP[choice]!.identifier, SYNTAX_NODE_MAP[choice]!.kind)
      }
      return [("Element", choices)]
    } else {
      return []
    }
  }
}

func rawSyntaxNodesFile(nodesStartingWith: [Character]) -> SourceFileSyntax {
  return SourceFileSyntax(leadingTrivia: copyrightHeader) {
    for node in SYNTAX_NODES
    where node.kind.isBase
      && nodesStartingWith.contains(node.kind.syntaxType.description.droppingLeadingUnderscores.first!)
      && !node.kind.isDeprecated
    {
      DeclSyntax(
        """
        \(node.apiAttributes(forRaw: true))\
        public protocol \(node.kind.rawType)NodeProtocol: \(node.base.rawProtocolType) {}
        """
      )
    }

    for node in SYNTAX_NODES
    where nodesStartingWith.contains(node.kind.syntaxType.description.droppingLeadingUnderscores.first!) {
      try! StructDeclSyntax(
        """
        \(node.apiAttributes(forRaw: true))\
        public struct \(node.kind.rawType): \(node.kind.isBase ? node.kind.rawProtocolType : node.base.rawProtocolType)
        """
      ) {
        for (name, choices) in node.childrenChoicesEnums {
          try EnumDeclSyntax(
            """
            public enum \(name): RawSyntaxNodeProtocol
            """
          ) {
            for (caseName, kind) in choices {
              DeclSyntax("case \(caseName.declNameOrVarCallName)(\(kind.rawType))")
            }

            DeclSyntax(
              """
              public static func isKindOf(_ raw: RawSyntax) -> Bool {
                return \(raw: choices.map { "\($0.kind.rawType).isKindOf(raw)" }.joined(separator: " || "))
              }
              """
            )

            try VariableDeclSyntax("public var raw: RawSyntax") {
              try SwitchExprSyntax("switch self") {
                for (swiftName, _) in choices {
                  SwitchCaseSyntax("case .\(swiftName.nonVarCallNameOrLabelDeclName)(let node): return node.raw")
                }
              }
            }

            try InitializerDeclSyntax("public init?(_ other: some RawSyntaxNodeProtocol)") {
              for (swiftName, kind) in choices {
                StmtSyntax(
                  """
                  if let node = \(kind.rawType)(other) {
                    self = .\(swiftName.nonVarCallNameOrLabelDeclName)(node)
                    return
                  }
                  """
                )
              }

              StmtSyntax("return nil")
            }

            for (swiftName, kind) in choices {
              if let choiceNode = SYNTAX_NODE_MAP[kind], choiceNode.kind.isBase {
                DeclSyntax(
                  """
                  public init(\(swiftName.nonVarCallNameOrLabelDeclName): some \(choiceNode.kind.rawProtocolType)) {
                    self = .\(swiftName.nonVarCallNameOrLabelDeclName)(\(choiceNode.kind.rawType)(\(swiftName.declNameOrVarCallName)))
                  }
                  """
                )
              }
            }
          }
        }

        DeclSyntax(
          """
          @_spi(RawSyntax)
          public var layoutView: RawSyntaxLayoutView {
            return raw.layoutView!
          }
          """
        )

        try FunctionDeclSyntax("public static func isKindOf(_ raw: RawSyntax) -> Bool") {
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

        DeclSyntax("public var raw: RawSyntax")

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
          public init?(_ other: some RawSyntaxNodeProtocol) {
            guard Self.isKindOf(other.raw) else { return nil }
            self.init(unchecked: other.raw)
          }
          """
        )

        if node.kind.isBase {
          DeclSyntax(
            """
            public init(_ other: some \(node.kind.rawType)NodeProtocol) {
              self.init(unchecked: other.raw)
            }
            """
          )
        }

        if let node = node.collectionNode {
          let element = node.elementChoices.only != nil ? node.elementChoices.only!.rawType : "Element"
          DeclSyntax(
            """
            public init(elements: [\(element)], arena: __shared SyntaxArena) {
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
            public var elements: [Raw\(node.collectionElementType.syntaxBaseName)] {
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

            FunctionParameterSyntax("arena: __shared SyntaxArena")
          }
          try InitializerDeclSyntax("public init(\(params))") {
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
              "public var \(child.varDeclName): Raw\(child.buildableType.buildable)"
            ) {
              let exclamationMark = child.isOptional ? "" : "!"

              if child.syntaxNodeKind == .syntax {
                ExprSyntax("layoutView.children[\(raw: index)]\(raw: exclamationMark)")
              } else {
                ExprSyntax(
                  "layoutView.children[\(raw: index)].map(\(child.syntaxNodeKind.rawType).init(raw:))\(raw: exclamationMark)"
                )
              }
            }
          }
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
      paramType = "some \(syntaxNodeKind.rawProtocolType)"
    } else {
      paramType = syntaxNodeKind.rawType
    }

    return buildableType.optionalWrapped(type: paramType)
  }
}
