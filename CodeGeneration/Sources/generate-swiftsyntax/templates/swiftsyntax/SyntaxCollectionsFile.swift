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

let syntaxCollectionsFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  DeclSyntax(
    """
    public protocol SyntaxCollection: SyntaxProtocol, Sequence where Element: SyntaxProtocol {
      /// Creates a new collection with the elements.
      init(_ children: [Element])
      /// The number of elements, `present` or `missing`, in this collection.
      var count: Int { get }
    }
    """
  )

  DeclSyntax(
    """
    public extension SyntaxCollection {
      static var structure: SyntaxNodeStructure {
        return .collection(Element.self)
      }
    }
    """
  )

  for node in SYNTAX_NODES.compactMap(\.collectionNode) {
    let documentation =
      !node.documentation.isEmpty
      ? node.documentation
      : """
      /// `\(node.kind.syntaxType)` represents a collection of one or more
      /// `\(node.collectionElementType.syntaxBaseName)` nodes. \(node.kind.syntaxType) behaves
      /// as a regular Swift collection, and has accessors that return new
      /// versions of the collection with different children.
      """

    try! StructDeclSyntax(
      """
      \(raw: documentation)
      public struct \(raw: node.kind.syntaxType): SyntaxCollection, SyntaxHashable
      """
    ) {
      if let onlyElement = node.elementChoices.only {
        DeclSyntax("public typealias Element = \(onlyElement.syntaxType)")
      } else {
        try EnumDeclSyntax(
          """
          public enum Element: SyntaxChildChoices
          """
        ) {
          for choiceName in node.elementChoices {
            let choice = SYNTAX_NODE_MAP[choiceName]!
            DeclSyntax("case `\(choice.varOrCaseName)`(\(choice.kind.syntaxType))")
          }

          try VariableDeclSyntax("public var _syntaxNode: Syntax") {
            SwitchExprSyntax(switchKeyword: .keyword(.switch), expression: ExprSyntax("self")) {
              for choiceName in node.elementChoices {
                let choice = SYNTAX_NODE_MAP[choiceName]!
                SwitchCaseSyntax("case .\(choice.varOrCaseName)(let node):") {
                  StmtSyntax("return node._syntaxNode")
                }
              }
            }
          }

          DeclSyntax("init(_ data: SyntaxData) { self.init(Syntax(data))! }")

          for choiceName in node.elementChoices {
            let choiceNode = SYNTAX_NODE_MAP[choiceName]!
            if choiceNode.kind.isBase {
              DeclSyntax(
                """
                public init(_ node: some \(choiceNode.kind.protocolType)) {
                  self = .\(choiceNode.varOrCaseName)(\(choiceNode.kind.syntaxType)(node))
                }
                """
              )

            } else {
              DeclSyntax(
                """
                public init(_ node: \(choiceNode.kind.syntaxType)) {
                  self = .\(choiceNode.varOrCaseName)(node)
                }
                """
              )
            }
          }

          try InitializerDeclSyntax("public init?(_ node: some SyntaxProtocol)") {
            for choiceName in node.elementChoices {
              let choiceNode = SYNTAX_NODE_MAP[choiceName]!
              StmtSyntax(
                """
                if let node = node.as(\(choiceNode.kind.syntaxType).self) {
                  self = .\(choiceNode.varOrCaseName)(node)
                  return
                }
                """
              )
            }

            StmtSyntax("return nil")
          }

          try VariableDeclSyntax("public static var structure: SyntaxNodeStructure") {
            let choices = ArrayExprSyntax {
              for choiceName in node.elementChoices {
                let choice = SYNTAX_NODE_MAP[choiceName]!
                ArrayElementSyntax(
                  leadingTrivia: .newline,
                  expression: ExprSyntax(".node(\(choice.kind.syntaxType).self)")
                )
              }
            }

            StmtSyntax("return .choices(\(choices))")
          }
        }
      }

      DeclSyntax("public let _syntaxNode: Syntax")

      DeclSyntax(
        """
        private var layoutView: RawSyntaxLayoutView {
          data.raw.layoutView!
        }
        """
      )

      DeclSyntax(
        """
        public init?(_ node: some SyntaxProtocol) {
          guard node.raw.kind == .\(node.varOrCaseName) else { return nil }
          self._syntaxNode = node._syntaxNode
        }
        """
      )

      DeclSyntax(
        """
        /// Creates a Syntax node from the provided root and data. This assumes
        /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
        /// is undefined.
        internal init(_ data: SyntaxData) {
          precondition(data.raw.kind == .\(node.varOrCaseName))
          self._syntaxNode = Syntax(data)
        }
        """
      )

      DeclSyntax(
        """
        public init(_ children: [Element]) {
          let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
            let raw = RawSyntax.makeLayout(kind: SyntaxKind.\(node.varOrCaseName),
                                           from: children.map { $0.raw }, arena: arena)
            return SyntaxData.forRoot(raw)
          }
          self.init(data)
        }
        """
      )

      DeclSyntax(
        """
        /// The number of elements, `present` or `missing`, in this collection.
        public var count: Int { return layoutView.children.count }
        """
      )

      DeclSyntax(
        """
        /// Creates a new `\(node.kind.syntaxType)` by replacing the underlying layout with
        /// a different set of raw syntax nodes.
        ///
        /// - Parameter layout: The new list of raw syntax nodes underlying this
        ///                     collection.
        /// - Returns: A new `\(node.kind.syntaxType)` with the new layout underlying it.
        internal func replacingLayout(_ layout: [RawSyntax?]) -> \(node.kind.syntaxType) {
          let arena = SyntaxArena()
          let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
          let newData = data.replacingSelf(newRaw, arena: arena)
          return \(node.kind.syntaxType)(newData)
        }
        """
      )

      DeclSyntax(
        """
        /// Creates a new `\(node.kind.syntaxType)` by appending the provided syntax element
        /// to the children.
        ///
        /// - Parameter syntax: The element to append.
        /// - Returns: A new `\(node.kind.syntaxType)` with that element appended to the end.
        public func appending(_ syntax: Element) -> \(node.kind.syntaxType) {
          var newLayout = layoutView.formLayoutArray()
          newLayout.append(syntax.raw)
          return replacingLayout(newLayout)
        }
        """
      )

      DeclSyntax(
        """
        /// Creates a new `\(node.kind.syntaxType)` by prepending the provided syntax element
        /// to the children.
        ///
        /// - Parameter syntax: The element to prepend.
        /// - Returns: A new `\(node.kind.syntaxType)` with that element prepended to the
        ///            beginning.
        public func prepending(_ syntax: Element) -> \(node.kind.syntaxType) {
          return inserting(syntax, at: 0)
        }
        """
      )

      DeclSyntax(
        """
        /// Creates a new `\(node.kind.syntaxType)` by inserting the provided syntax element
        /// at the provided index in the children.
        ///
        /// - Parameters:
        ///   - syntax: The element to insert.
        ///   - index: The index at which to insert the element in the collection.
        ///
        /// - Returns: A new `\(node.kind.syntaxType)` with that element appended to the end.
        public func inserting(_ syntax: Element, at index: Int) -> \(node.kind.syntaxType) {
          var newLayout = layoutView.formLayoutArray()
          /// Make sure the index is a valid insertion index (0 to 1 past the end)
          precondition((newLayout.startIndex...newLayout.endIndex).contains(index),
                       "inserting node at invalid index \\(index)")
          newLayout.insert(syntax.raw, at: index)
          return replacingLayout(newLayout)
        }
        """
      )

      DeclSyntax(
        """
        /// Creates a new `\(node.kind.syntaxType)` by replacing the syntax element
        /// at the provided index.
        ///
        /// - Parameters:
        ///   - index: The index at which to replace the element in the collection.
        ///   - syntax: The element to replace with.
        ///
        /// - Returns: A new `\(node.kind.syntaxType)` with the new element at the provided index.
        public func replacing(childAt index: Int, with syntax: Element) -> \(node.kind.syntaxType) {
          var newLayout = layoutView.formLayoutArray()
          /// Make sure the index is a valid index for replacing
          precondition((newLayout.startIndex..<newLayout.endIndex).contains(index),
                       "replacing node at invalid index \\(index)")
          newLayout[index] = syntax.raw
          return replacingLayout(newLayout)
        }
        """
      )

      DeclSyntax(
        """
        /// Creates a new `\(node.kind.syntaxType)` by removing the syntax element at the
        /// provided index.
        ///
        /// - Parameter index: The index of the element to remove from the collection.
        /// - Returns: A new `\(node.kind.syntaxType)` with the element at the provided index
        ///            removed.
        public func removing(childAt index: Int) -> \(node.kind.syntaxType) {
          var newLayout = layoutView.formLayoutArray()
          newLayout.remove(at: index)
          return replacingLayout(newLayout)
        }
        """
      )

      DeclSyntax(
        """
        /// Creates a new `\(node.kind.syntaxType)` by removing the first element.
        ///
        /// - Returns: A new `\(node.kind.syntaxType)` with the first element removed.
        public func removingFirst() -> \(node.kind.syntaxType) {
          var newLayout = layoutView.formLayoutArray()
          newLayout.removeFirst()
          return replacingLayout(newLayout)
        }
        """
      )

      DeclSyntax(
        """
        /// Creates a new `\(node.kind.syntaxType)` by removing the last element.
        ///
        /// - Returns: A new `\(node.kind.syntaxType)` with the last element removed.
        public func removingLast() -> \(node.kind.syntaxType) {
          var newLayout = layoutView.formLayoutArray()
          newLayout.removeLast()
          return replacingLayout(newLayout)
        }
        """
      )
    }

    try! ExtensionDeclSyntax(
      """
      /// Conformance for `\(node.kind.syntaxType)` to the `BidirectionalCollection` protocol.
      extension \(node.kind.syntaxType): BidirectionalCollection
      """
    ) {
      DeclSyntax("public typealias Index = SyntaxChildrenIndex")

      DeclSyntax(
        """
        public struct Iterator: IteratorProtocol {
          private let parent: Syntax
          private var iterator: RawSyntaxChildren.Iterator

          init(parent: Syntax, rawChildren: RawSyntaxChildren) {
            self.parent = parent
            self.iterator = rawChildren.makeIterator()
          }

          public mutating func next() -> Element? {
            guard let (raw, info) = self.iterator.next() else {
              return nil
            }
            let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
            let data = SyntaxData(absoluteRaw, parent: parent)
            return Element(data)
          }
        }
        """
      )

      DeclSyntax(
        """
        public func makeIterator() -> Iterator {
          return Iterator(parent: Syntax(self), rawChildren: rawChildren)
        }
        """
      )

      DeclSyntax(
        """
        private var rawChildren: RawSyntaxChildren {
          // We know children in a syntax collection cannot be missing. So we can
          // use the low-level and faster RawSyntaxChildren collection instead of
          // NonNilRawSyntaxChildren.
          return RawSyntaxChildren(self.data.absoluteRaw)
        }
        """
      )

      DeclSyntax(
        """
        public var startIndex: SyntaxChildrenIndex {
          return rawChildren.startIndex
        }
        """
      )

      DeclSyntax(
        """
        public var endIndex: SyntaxChildrenIndex {
          return rawChildren.endIndex
        }
        """
      )

      DeclSyntax(
        """
        public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
          return rawChildren.index(after: index)
        }
        """
      )

      DeclSyntax(
        """
        public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
          return rawChildren.index(before: index)
        }
        """
      )

      DeclSyntax(
        """
        public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
        -> Int {
          return rawChildren.distance(from: start, to: end)
        }
        """
      )

      DeclSyntax(
        """
        public subscript(position: SyntaxChildrenIndex) -> Element {
          let (raw, info) = rawChildren[position]
          let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
          let data = SyntaxData(absoluteRaw, parent: Syntax(self))
          return Element(data)
        }
        """
      )
    }
  }
}
