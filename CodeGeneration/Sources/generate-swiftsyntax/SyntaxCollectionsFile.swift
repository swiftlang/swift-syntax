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

let syntaxCollectionsFile = SourceFile(leadingTrivia: [.blockComment(generateCopyrightHeader(for: "generate-swiftsyntax"))]) {
  ProtocolDecl("""
    public protocol SyntaxCollection: SyntaxProtocol, Sequence where Element: SyntaxProtocol {
      /// The number of elements, `present` or `missing`, in this collection.
      var count: Int { get }
    }
    """)
  
  ExtensionDecl("""
    public extension SyntaxCollection {
      static var structure: SyntaxNodeStructure {
        return .collection(Element.self)
      }
    }
    """)
  
  for node in SYNTAX_NODES where node.isSyntaxCollection {
    let documentation = node.description.map { "/// " + $0 } ?? """
      /// `\(node.name)` represents a collection of one or more
      /// `\(node.collectionElement)` nodes. \(node.name) behaves
      /// as a regular Swift collection, and has accessors that return new
      /// versions of the collection with different children.
      """
    
    StructDecl("""
      \(documentation)
      public struct \(node.name): SyntaxCollection, SyntaxHashable
      """) {
      if let collectionElementChoices = node.collectionElementChoices, !collectionElementChoices.isEmpty {
        EnumDecl("""
          @frozen // FIXME: Not actually stable, works around a miscompile
          public enum Element: SyntaxChildChoices
          """) {
          for choiceName in collectionElementChoices {
            if let choice = SYNTAX_NODE_MAP[choiceName] {
              EnumCaseDecl("case `\(raw: choice.swiftSyntaxKind)`(\(raw: choice.name))")
            }
          }
          
          VariableDecl(
            modifiers: [DeclModifier(name: .public)],
            name: IdentifierPattern("_syntaxNode"),
            type: TypeAnnotation(
              colon: .colon,
              type: TypeSyntax("Syntax")
            )
          ) {
            SwitchStmt(switchKeyword: .switch, expression: Expr("self")) {
              
              for choiceName in node.collectionElementChoices ?? [] {
                if let choice = SYNTAX_NODE_MAP[choiceName] {
                  SwitchCase("case .\(raw: choice.swiftSyntaxKind)(let node):") {
                    ReturnStmt("return node._syntaxNode")
                  }
                }
              }
            }
          }
          
          InitializerDecl("init(_ data: SyntaxData) { self.init(Syntax(data))! }")
          
          for choiceName in node.collectionElementChoices ?? [] {
            if let choiceNode = SYNTAX_NODE_MAP[choiceName] {
              if choiceNode.isBase {
                InitializerDecl("""
                  public init<Node: \(raw: choiceNode.name)Protocol>(_ node: Node) {
                    self = .\(raw: choiceNode.swiftSyntaxKind)(\(raw: choiceNode.name)(node))
                  }
                  """)
                                          
              } else {
                InitializerDecl("""
                  public init(_ node: \(raw: choiceNode.name)) {
                    self = .\(raw: choiceNode.swiftSyntaxKind)(node)
                  }
                  """)
              }
            }
          }

          InitializerDecl("public init?<S: SyntaxProtocol>(_ node: S)") {
            for choiceName in node.collectionElementChoices ?? [] {
              if let choiceNode = SYNTAX_NODE_MAP[choiceName] {
                IfStmt("""
                  if let node = node.as(\(raw: choiceNode.name).self) {
                    self = .\(raw: choiceNode.swiftSyntaxKind)(node)
                    return
                  }
                  """)
              }
            }
            
            ReturnStmt("return nil")
          }
          
          VariableDecl(
            modifiers: [DeclModifier(name: .public), DeclModifier(name: .static)],
            name: IdentifierPattern("structure"),
            type: TypeAnnotation(
              colon: .colon,
              type: TypeSyntax("SyntaxNodeStructure")
            )
          ) {
            ReturnStmt(
              expression: FunctionCallExpr(
                callee: MemberAccessExpr(".choices")) {
                  TupleExprElement(
                    expression: ArrayExprSyntax {
                      for choiceName in node.collectionElementChoices ?? [] {
                        if let choice = SYNTAX_NODE_MAP[choiceName] {
                          ArrayElement(
                            expression: FunctionCallExpr("\n.node(\(raw: choice.name).self)")
                          )
                        }
                      }
                    })
                }
            )
          }
        }
      } else {
        TypealiasDecl("public typealias Element = \(raw: node.collectionElementType.syntaxBaseName)")
      }
      
      VariableDecl("public let _syntaxNode: Syntax")
      
      VariableDecl("""
        @_spi(RawSyntax)
        public var layoutView: RawSyntaxLayoutView {
          data.raw.layoutView!
        }
        """)
      
      InitializerDecl("""
        public init?<S: SyntaxProtocol>(_ node: S) {
          guard node.raw.kind == .\(raw: node.swiftSyntaxKind) else { return nil }
          self._syntaxNode = node._syntaxNode
        }
        """)
      
      InitializerDecl("""
        /// Creates a Syntax node from the provided root and data. This assumes
        /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
        /// is undefined.
        internal init(_ data: SyntaxData) {
          assert(data.raw.kind == .\(raw: node.swiftSyntaxKind))
          self._syntaxNode = Syntax(data)
        }
        """)
      
      InitializerDecl("""
        public init(_ children: [Element]) {
          let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
            let raw = RawSyntax.makeLayout(kind: SyntaxKind.\(raw: node.swiftSyntaxKind),
                                           from: children.map { $0.raw }, arena: arena)
            return SyntaxData.forRoot(raw)
          }
          self.init(data)
        }
        """)
      
      VariableDecl("""
        /// The number of elements, `present` or `missing`, in this collection.
        public var count: Int { return raw.layoutView!.children.count }
        """)
      
      FunctionDecl("""
        /// Creates a new `\(raw: node.name)` by replacing the underlying layout with
        /// a different set of raw syntax nodes.
        ///
        /// - Parameter layout: The new list of raw syntax nodes underlying this
        ///                     collection.
        /// - Returns: A new `\(raw: node.name)` with the new layout underlying it.
        internal func replacingLayout(
          _ layout: [RawSyntax?]) -> \(raw: node.name) {
            let arena = SyntaxArena()
            let newRaw = layoutView.replacingLayout(with: layout, arena: arena)
            let newData = data.replacingSelf(newRaw, arena: arena)
            return \(raw: node.name)(newData)
          }
        """)
      
      FunctionDecl("""
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
        """)
      
      FunctionDecl("""
        /// Creates a new `\(raw: node.name)` by prepending the provided syntax element
        /// to the children.
        ///
        /// - Parameter syntax: The element to prepend.
        /// - Returns: A new `\(raw: node.name)` with that element prepended to the
        ///            beginning.
        public func prepending(_ syntax: Element) -> \(raw: node.name) {
          return inserting(syntax, at: 0)
        }
        """)
      
      
      FunctionDecl("""
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
        """)
      
      
      FunctionDecl("""
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
        """)
      
      
      FunctionDecl("""
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
        """)
      
      
      FunctionDecl("""
        /// Creates a new `\(raw: node.name)` by removing the first element.
        ///
        /// - Returns: A new `\(raw: node.name)` with the first element removed.
        public func removingFirst() -> \(raw: node.name) {
          var newLayout = layoutView.formLayoutArray()
          newLayout.removeFirst()
          return replacingLayout(newLayout)
        }
        """)
      
      FunctionDecl("""
        /// Creates a new `\(raw: node.name)` by removing the last element.
        ///
        /// - Returns: A new `\(raw: node.name)` with the last element removed.
        public func removingLast() -> \(raw: node.name) {
          var newLayout = layoutView.formLayoutArray()
          newLayout.removeLast()
          return replacingLayout(newLayout)
        }
        """)
      
      FunctionDecl("""
        /// Returns a new `\(raw: node.name)` with its leading trivia replaced
        /// by the provided trivia.
        public func withLeadingTrivia(_ leadingTrivia: Trivia) -> \(raw: node.name) {
          return \(raw: node.name)(data.withLeadingTrivia(leadingTrivia, arena: SyntaxArena()))
        }
        """)
      
      FunctionDecl("""
        /// Returns a new `\(raw: node.name)` with its trailing trivia replaced
        /// by the provided trivia.
        public func withTrailingTrivia(_ trailingTrivia: Trivia) -> \(raw: node.name) {
          return \(raw: node.name)(data.withTrailingTrivia(trailingTrivia, arena: SyntaxArena()))
        }
        """)
      
      FunctionDecl("""
        /// Returns a new `\(raw: node.name)` with its leading trivia removed.
        public func withoutLeadingTrivia() -> \(raw: node.name) {
          return withLeadingTrivia([])
        }
        """)
      
      
      FunctionDecl("""
        /// Returns a new `\(raw: node.name)` with its trailing trivia removed.
        public func withoutTrailingTrivia() -> \(raw: node.name) {
          return withTrailingTrivia([])
        }
        """)
      
      
      FunctionDecl("""
        /// Returns a new `\(raw: node.name)` with all trivia removed.
        public func withoutTrivia() -> \(raw: node.name) {
          return withoutLeadingTrivia().withoutTrailingTrivia()
        }
        """)
      
      VariableDecl("""
        /// The leading trivia (spaces, newlines, etc.) associated with this `\(raw: node.name)`.
        public var leadingTrivia: Trivia? {
          get {
            return raw.formLeadingTrivia()
          }
          set {
            self = withLeadingTrivia(newValue ?? [])
          }
        }
        """)
      
      VariableDecl("""
        /// The trailing trivia (spaces, newlines, etc.) associated with this `\(raw: node.name)`.
        public var trailingTrivia: Trivia? {
          get {
            return raw.formTrailingTrivia()
          }
          set {
            self = withTrailingTrivia(newValue ?? [])
          }
        }
        """)
      
      FunctionDecl("""
        public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
          return nil
        }
        """)
    }
    
    ExtensionDecl("""
      /// Conformance for `\(node.name)` to the `BidirectionalCollection` protocol.
      extension \(node.name): BidirectionalCollection
      """) {
      TypealiasDecl("public typealias Index = SyntaxChildrenIndex")
      
      StructDecl("""
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
        """)
      
      FunctionDecl("""
        public func makeIterator() -> Iterator {
          return Iterator(parent: Syntax(self), rawChildren: rawChildren)
        }
        """)
      
      VariableDecl("""
        private var rawChildren: RawSyntaxChildren {
          // We know children in a syntax collection cannot be missing. So we can
          // use the low-level and faster RawSyntaxChildren collection instead of
          // NonNilRawSyntaxChildren.
          return RawSyntaxChildren(self.data.absoluteRaw)
        }
        """)
      
      VariableDecl("""
        public var startIndex: SyntaxChildrenIndex {
          return rawChildren.startIndex
        }
        """)
      
      VariableDecl("""
        public var endIndex: SyntaxChildrenIndex {
          return rawChildren.endIndex
        }
        """)
      
      FunctionDecl("""
        public func index(after index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
          return rawChildren.index(after: index)
        }
        """)
      
      FunctionDecl("""
        public func index(before index: SyntaxChildrenIndex) -> SyntaxChildrenIndex {
          return rawChildren.index(before: index)
        }
        """)
      
      FunctionDecl("""
        public func distance(from start: SyntaxChildrenIndex, to end: SyntaxChildrenIndex)
        -> Int {
          return rawChildren.distance(from: start, to: end)
        }
        """)
      
      SubscriptDecl("""
        public subscript(position: SyntaxChildrenIndex) -> Element {
          let (raw, info) = rawChildren[position]
          let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
          let data = SyntaxData(absoluteRaw, parent: Syntax(self))
          return Element(data)
        }
        """)
    }
  }
  
  for node in SYNTAX_NODES where node.isSyntaxCollection{
    ExtensionDecl("""
      extension \(raw: node.name): CustomReflectable {
        public var customMirror: Mirror {
          return Mirror(self, unlabeledChildren: self.map{ $0 })
        }
      }
      """)
  }
}
