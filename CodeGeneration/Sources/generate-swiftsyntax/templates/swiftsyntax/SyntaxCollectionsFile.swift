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

  for node in SYNTAX_NODES where node.isSyntaxCollection {
    let documentation =
      node.description.map { "/// " + $0 }
        ?? """
        /// `\(node.name)` represents a collection of one or more
        /// `\(node.collectionElement)` nodes. \(node.name) behaves
        /// as a regular Swift collection, and has accessors that return new
        /// versions of the collection with different children.
        """

    try! StructDeclSyntax(
      """
      \(raw: documentation)
      public struct \(raw: node.name): SyntaxCollection, SyntaxHashable
      """
    ) {
      if let collectionElementChoices = node.collectionElementChoices, !collectionElementChoices.isEmpty {
        try EnumDeclSyntax(
          """
          @frozen // FIXME: Not actually stable, works around a miscompile
          public enum Element: SyntaxChildChoices
          """
        ) {
          for choiceName in collectionElementChoices {
            let choice = SYNTAX_NODE_MAP[choiceName]!
            DeclSyntax("case `\(raw: choice.swiftSyntaxKind)`(\(raw: choice.name))")
          }

          try VariableDeclSyntax("public var _syntaxNode: Syntax") {
            SwitchExprSyntax(switchKeyword: .keyword(.switch), expression: ExprSyntax("self")) {
              for choiceName in node.collectionElementChoices ?? [] {
                let choice = SYNTAX_NODE_MAP[choiceName]!
                SwitchCaseSyntax("case .\(raw: choice.swiftSyntaxKind)(let node):") {
                  StmtSyntax("return node._syntaxNode")
                }
              }
            }
          }

          DeclSyntax("init(_ data: SyntaxData) { self.init(Syntax(data))! }")

          for choiceName in node.collectionElementChoices ?? [] {
            let choiceNode = SYNTAX_NODE_MAP[choiceName]!
            if choiceNode.isBase {
              DeclSyntax(
                """
                public init<Node: \(raw: choiceNode.name)Protocol>(_ node: Node) {
                  self = .\(raw: choiceNode.swiftSyntaxKind)(\(raw: choiceNode.name)(node))
                }
                """
              )

            } else {
              DeclSyntax(
                """
                public init(_ node: \(raw: choiceNode.name)) {
                  self = .\(raw: choiceNode.swiftSyntaxKind)(node)
                }
                """
              )
            }
          }

          try InitializerDeclSyntax("public init?<S: SyntaxProtocol>(_ node: S)") {
            for choiceName in node.collectionElementChoices ?? [] {
              let choiceNode = SYNTAX_NODE_MAP[choiceName]!
              StmtSyntax(
                """
                if let node = node.as(\(raw: choiceNode.name).self) {
                  self = .\(raw: choiceNode.swiftSyntaxKind)(node)
                  return
                }
                """
              )
            }

            StmtSyntax("return nil")
          }

          try VariableDeclSyntax("public static var structure: SyntaxNodeStructure") {
            let choices = ArrayExprSyntax {
              for choiceName in node.collectionElementChoices ?? [] {
                let choice = SYNTAX_NODE_MAP[choiceName]!
                ArrayElementSyntax(
                  leadingTrivia: .newline,
                  expression: ExprSyntax(".node(\(raw: choice.name).self)")
                )
              }
            }

            StmtSyntax("return .choices(\(choices))")
          }
        }
      } else {
        DeclSyntax("public typealias Element = \(raw: node.collectionElementType.syntaxBaseName)")
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
        public init?<S: SyntaxProtocol>(_ node: S) {
          guard node.raw.kind == .\(raw: node.swiftSyntaxKind) else { return nil }
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
          precondition(data.raw.kind == .\(raw: node.swiftSyntaxKind))
          self._syntaxNode = Syntax(data)
        }
        """
      )

      DeclSyntax(
        """
        public init(_ children: [Element]) {
          let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
            let raw = RawSyntax.makeLayout(kind: SyntaxKind.\(raw: node.swiftSyntaxKind),
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
        /// Creates a new `\(raw: node.name)` by replacing the underlying layout with
        /// a different set of raw syntax nodes.
        ///
        /// - Parameter layout: The new list of raw syntax nodes underlying this
        ///                     collection.
        /// - Returns: A new `\(raw: node.name)` with the new layout underlying it.
        internal func replacingLayout(_ layout: [RawSyntax?]) -> \(raw: node.name) {
          let arena = SyntaxArena()
          let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
          let newData = data.replacingSelf(newRaw, arena: arena)
          return \(raw: node.name)(newData)
        }
        """
      )

      DeclSyntax(
        """
        /// Creates a new `\(raw: node.name)` by appending the provided syntax element
        /// to the children.
        ///
        /// - Parameter syntax: The element to append.
        /// - Returns: A new `\(raw: node.name)` with that element appended to the end.
        public func appending(_ syntax: Element) -> \(raw: node.name) {
          var newLayout = layoutView.formLayoutArray()
          newLayout.append(syntax.raw)
          return replacingLayout(newLayout)
        }
        """
      )

      DeclSyntax(
        """
        /// Creates a new `\(raw: node.name)` by prepending the provided syntax element
        /// to the children.
        ///
        /// - Parameter syntax: The element to prepend.
        /// - Returns: A new `\(raw: node.name)` with that element prepended to the
        ///            beginning.
        public func prepending(_ syntax: Element) -> \(raw: node.name) {
          return inserting(syntax, at: 0)
        }
        """
      )

      DeclSyntax(
        """
        /// Creates a new `\(raw: node.name)` by inserting the provided syntax element
        /// at the provided index in the children.
        ///
        /// - Parameters:
        ///   - syntax: The element to insert.
        ///   - index: The index at which to insert the element in the collection.
        ///
        /// - Returns: A new `\(raw: node.name)` with that element appended to the end.
        public func inserting(_ syntax: Element, at index: Int) -> \(raw: node.name) {
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
        /// Creates a new `\(raw: node.name)` by replacing the syntax element
        /// at the provided index.
        ///
        /// - Parameters:
        ///   - index: The index at which to replace the element in the collection.
        ///   - syntax: The element to replace with.
        ///
        /// - Returns: A new `\(raw: node.name)` with the new element at the provided index.
        public func replacing(childAt index: Int, with syntax: Element) -> \(raw: node.name) {
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
        /// Creates a new `\(raw: node.name)` by removing the syntax element at the
        /// provided index.
        ///
        /// - Parameter index: The index of the element to remove from the collection.
        /// - Returns: A new `\(raw: node.name)` with the element at the provided index
        ///            removed.
        public func removing(childAt index: Int) -> \(raw: node.name) {
          var newLayout = layoutView.formLayoutArray()
          newLayout.remove(at: index)
          return replacingLayout(newLayout)
        }
        """
      )

      DeclSyntax(
        """
        /// Creates a new `\(raw: node.name)` by removing the first element.
        ///
        /// - Returns: A new `\(raw: node.name)` with the first element removed.
        public func removingFirst() -> \(raw: node.name) {
          var newLayout = layoutView.formLayoutArray()
          newLayout.removeFirst()
          return replacingLayout(newLayout)
        }
        """
      )

      DeclSyntax(
        """
        /// Creates a new `\(raw: node.name)` by removing the last element.
        ///
        /// - Returns: A new `\(raw: node.name)` with the last element removed.
        public func removingLast() -> \(raw: node.name) {
          var newLayout = layoutView.formLayoutArray()
          newLayout.removeLast()
          return replacingLayout(newLayout)
        }
        """
      )
    }

    try! ExtensionDeclSyntax(
      """
      /// Conformance for `\(raw: node.name)` to the `BidirectionalCollection` protocol.
      extension \(raw: node.name): BidirectionalCollection
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
