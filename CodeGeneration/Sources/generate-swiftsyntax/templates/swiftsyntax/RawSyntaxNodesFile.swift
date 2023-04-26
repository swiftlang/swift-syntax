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

let rawSyntaxNodesFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  for node in SYNTAX_NODES where node.isBase {
    DeclSyntax(
      """
      @_spi(RawSyntax)
      public protocol Raw\(raw: node.name)NodeProtocol: Raw\(raw: node.baseType.syntaxKind)NodeProtocol {}
      """
    )
  }

  for node in SYNTAX_NODES {
    try! StructDeclSyntax(
      """
      @_spi(RawSyntax)
      public struct Raw\(raw: node.name): Raw\(raw: (node.isBase ? node.name : node.baseType.syntaxBaseName))NodeProtocol
      """
    ) {
      let enums: [(String, [(swiftName: String, typeName: String)])] =
        node.children.compactMap { child -> (String, [(String, String)])? in
          switch child.kind {
          case .nodeChoices(let choices):
            return (child.name, choices.map { ($0.swiftName, $0.typeName) })
          default:
            return nil
          }
        }
        + (node.collectionElementChoices?.isEmpty == false
          ? [("Element", node.collectionElementChoices!.map { choice -> (String, String) in (SYNTAX_NODE_MAP[choice]!.swiftSyntaxKind, SYNTAX_NODE_MAP[choice]!.name) })]
          : [])

      for (name, choices) in enums {
        try EnumDeclSyntax(
          """
          @frozen // FIXME: Not actually stable, works around a miscompile
          public enum \(raw: name): RawSyntaxNodeProtocol
          """
        ) {
          for (swiftName, typeName) in choices {
            DeclSyntax("case `\(raw: swiftName)`(Raw\(raw: typeName))")
          }

          DeclSyntax(
            """
            public static func isKindOf(_ raw: RawSyntax) -> Bool {
              return \(raw: choices.map { "Raw\($0.typeName).isKindOf(raw)" }.joined(separator: " || "))
            }
            """
          )

          try VariableDeclSyntax("public var raw: RawSyntax") {
            try SwitchExprSyntax("switch self") {
              for (swiftName, _) in choices {
                SwitchCaseSyntax("case .\(raw: swiftName)(let node): return node.raw")
              }
            }
          }

          try InitializerDeclSyntax("public init?<T>(_ other: T) where T : RawSyntaxNodeProtocol") {
            for (swiftName, typeName) in choices {
              StmtSyntax(
                """
                if let node = Raw\(raw: typeName)(other) {
                  self = .\(raw: swiftName)(node)
                  return
                }
                """
              )
            }

            StmtSyntax("return nil")
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
        if node.isBase {

          let cases = CaseItemListSyntax {
            for n in SYNTAX_NODES where n.baseKind == node.syntaxKind {
              CaseItemSyntax(
                pattern: ExpressionPatternSyntax(
                  expression: ExprSyntax(".\(raw: n.swiftSyntaxKind)")
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
          StmtSyntax("return raw.kind == .\(raw: node.swiftSyntaxKind)")
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
        public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
          guard Self.isKindOf(other.raw) else { return nil }
          self.init(unchecked: other.raw)
        }
        """
      )

      if node.isBase {
        DeclSyntax(
          """
          public init<Node: Raw\(raw: node.name)NodeProtocol>(_ other: Node) {
            self.init(unchecked: other.raw)
          }
          """
        )
      }

      if node.isSyntaxCollection {
        let element = node.collectionElementChoices?.isEmpty == false ? "Element" : "Raw\(node.collectionElementType.syntaxBaseName)"
        DeclSyntax(
          """
          public init(elements: [\(raw: element)], arena: __shared SyntaxArena) {
            let raw = RawSyntax.makeLayout(
              kind: .\(raw: node.swiftSyntaxKind), uninitializedCount: elements.count, arena: arena) { layout in
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
          public var elements: [Raw\(raw: node.collectionElementType.syntaxBaseName)] {
            layoutView.children.map { Raw\(raw: node.collectionElementType.syntaxBaseName)(raw: $0!) }
          }
          """
        )
      }

      if node.isBuildable || node.isMissing {
        let params = FunctionParameterListSyntax {
          for child in node.children {
            FunctionParameterSyntax(
              firstName: child.isUnexpectedNodes ? .wildcardToken(trailingTrivia: .space) : .identifier(child.swiftName),
              secondName: child.isUnexpectedNodes ? .identifier(child.swiftName) : nil,
              colon: .colonToken(),
              type: child.rawParameterType,
              defaultArgument: child.isUnexpectedNodes ? child.defaultInitialization : nil
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
                ExprSyntax("layout[\(raw: index)] = \(raw: child.swiftName)\(raw: optionalMark).raw")
                  .with(\.leadingTrivia, .newline)
              }
            }

            DeclSyntax(
              """
              let raw = RawSyntax.makeLayout(
                kind: .\(raw: node.swiftSyntaxKind), uninitializedCount: \(raw: node.children.count), arena: arena) { layout in
                \(list)
              }
              """
            )
          } else {
            DeclSyntax("let raw = RawSyntax.makeEmptyLayout(kind: .\(raw: node.swiftSyntaxKind), arena: arena)")
          }
          ExprSyntax("self.init(unchecked: raw)")
        }

        for (index, child) in node.children.enumerated() {
          try VariableDeclSyntax("public var \(raw: child.swiftName): Raw\(raw: child.type.buildable)") {
            let iuoMark = child.isOptional ? "" : "!"

            if child.typeName == "Syntax" {
              ExprSyntax("layoutView.children[\(raw: index)]\(raw: iuoMark)")
            } else {
              ExprSyntax("layoutView.children[\(raw: index)].map(Raw\(raw: child.typeName).init(raw:))\(raw: iuoMark)")
            }
          }
        }
      }
    }
  }
}

fileprivate extension Child {
  var rawParameterType: TypeSyntax {
    let paramType: String
    if case ChildKind.nodeChoices = kind {
      paramType = name
    } else {
      paramType = "Raw\(typeName)"
    }

    return type.optionalWrapped(type: SimpleTypeIdentifierSyntax(name: .identifier(paramType)))
  }
}
