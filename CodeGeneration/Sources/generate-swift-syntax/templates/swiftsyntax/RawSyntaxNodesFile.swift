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
    for node in SYNTAX_NODES
    where node.kind.isBase
      && nodesStartingWith.contains(node.kind.syntaxType.description.droppingLeadingUnderscores.first!)
      && !node.kind.isDeprecated
    {
      DeclSyntax(
        """
        \(node.apiAttributes(forRaw: true))\
        public protocol \(node.kind.raw.protocolType): \(node.base.raw.protocolType) {}
        """
      )
    }

    for node in SYNTAX_NODES
    where nodesStartingWith.contains(node.kind.syntaxType.description.droppingLeadingUnderscores.first!) {
      try! StructDeclSyntax(
        """
        \(node.apiAttributes(forRaw: true))\
        public struct \(node.kind.raw.syntaxType): \(node.kind.isBase ? node.kind.raw.protocolType : node.base.raw.protocolType)
        """
      ) {
        for childNodeChoices in node.childrenNodeChoices(forRaw: true) {
          childNodeChoices.rawEnumDecl
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
            public init(_ other: some \(node.kind.raw.protocolType)) {
              self.init(unchecked: other.raw)
            }
            """
          )
        }

        if let node = node.collectionNode {
          let element = node.elementChoices.only != nil ? node.elementChoices.only!.raw.syntaxType : "Element"
          DeclSyntax(
            """
            public init(elements: RawSyntaxNodeList<\(element)>, arena: __shared RawSyntaxArena) {
              let raw = RawSyntax.makeLayout(
                kind: .\(node.memberCallName), childCount: elements.count, storage: .flat, arena: arena) { layout in
                  guard var ptr = layout.baseAddress else { return }
                  for elem in elements.buffer {
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

            FunctionParameterSyntax("arena: __shared RawSyntaxArena")
          }
          try InitializerDeclSyntax("public init(\(params))") {
            // A node that interleaves keeps its real children and its
            // `unexpected` slots in separate regions, real ones first, so that
            // the slots can be left out of a node that has nothing to put in
            // them. A node that does not interleave has only real children.
            let interleaves = node.interleavesUnexpectedChildren
            let realChildren = interleaves ? node.children.filter { !$0.isUnexpectedNodes } : node.children
            let unexpectedChildren = interleaves ? node.children.filter { $0.isUnexpectedNodes } : []

            // Every slot is written exactly once — the `unexpected` ones exist
            // only when they are being written — so initializing them and then
            // assigning over them would be a `memset` of the whole tail for
            // nothing.
            let list = ExprListSyntax {
              for (index, child) in realChildren.enumerated() {
                let optionalMark = child.isOptional ? "?" : ""
                ExprSyntax(
                  "layout.initializeElement(at: \(raw: index), to: \(child.baseCallName)\(raw: optionalMark).raw)"
                )
                .with(\.leadingTrivia, .newline)
              }
              if !unexpectedChildren.isEmpty {
                let assignments = unexpectedChildren.enumerated()
                  .map {
                    "layout.initializeElement(at: \(realChildren.count + $0.offset), to: \($0.element.baseCallName)?.raw)"
                  }
                  .joined(separator: "\n")
                ExprSyntax(
                  """
                  if hasUnexpected {
                    \(raw: assignments)
                  }
                  """
                )
                .with(\.leadingTrivia, .newline)
              }
            }

            // A kind interleaves `unexpected` slots exactly when its layout has any,
            // which is known here; whether one of them is occupied is not, so only an
            // interleaving node works that out.
            if !unexpectedChildren.isEmpty {
              let occupied = unexpectedChildren.map { "\($0.baseCallName) != nil" }.joined(separator: " || ")
              DeclSyntax("let hasUnexpected = \(raw: occupied)")
            }
            let storage =
              unexpectedChildren.isEmpty
              ? ".flat"
              : "hasUnexpected ? .interleavedWithUnexpected : .interleaved"
            DeclSyntax(
              """
              let raw = RawSyntax.makeLayout(
                kind: .\(node.memberCallName), childCount: \(raw: realChildren.count), storage: \(raw: storage), arena: arena) { layout in
                \(list)
              }
              """
            )
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
    try! EnumDeclSyntax("public enum \(self.name): RawSyntaxNodeProtocol") {
      for choice in self.choices {
        choice.enumCaseDecl
      }

      self.isKindOfFuncDecl(parameterName: "raw", parameterType: "RawSyntax")

      self.syntaxGetter(propertyName: "raw", propertyType: "RawSyntax")

      self.syntaxInitDecl(inputType: "__shared some RawSyntaxNodeProtocol")

      for choice in self.choices {
        if let baseTypeInitDecl = choice.baseTypeInitDecl(hasArgumentName: true) {
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
