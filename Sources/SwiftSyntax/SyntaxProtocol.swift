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

/// Provide common functionality for specialized syntax nodes. Extend this
/// protocol to provide common functionality for all syntax nodes.
///
/// - Important: Do not conform to this protocol yourself.
public protocol SyntaxProtocol: CustomStringConvertible,
  CustomDebugStringConvertible, TextOutputStreamable, CustomReflectable, Sendable
{

  /// Retrieve the generic syntax node that is represented by this node.
  /// Do not retrieve this property directly. Use `Syntax(self)` instead.
  var _syntaxNode: Syntax { get }

  /// Converts the given specialized node to this type. Returns `nil` if the
  /// conversion is not possible.
  init?(_ node: __shared some SyntaxProtocol)

  /// The statically allowed structure of the syntax node.
  static var structure: SyntaxNodeStructure { get }
}

// MARK: Access underlying data

extension SyntaxProtocol {
  @_spi(RawSyntax)
  public var raw: RawSyntax {
    return _syntaxNode.raw
  }
}

// MARK: Casting

// Casting functions to specialized syntax nodes.
extension SyntaxProtocol {
  /// Initializes a new instance of the conforming type from a given specialized syntax node.
  ///
  /// Returns `nil` if the conversion isn't possible, or if the provided node is `nil`.
  public init?<S: SyntaxProtocol>(_ node: S?) {
    guard let node = node else {
      return nil
    }
    self.init(node)
  }

  /// Checks if the current syntax node can be cast to a given specialized syntax type.
  ///
  /// - Returns: `true` if the node can be cast, `false` otherwise.
  public func `is`<S: SyntaxProtocol>(_ syntaxType: S.Type) -> Bool {
    return self.as(syntaxType) != nil
  }

  /// Checks if the current syntax node can be upcast to ``Syntax`` node.
  ///
  /// - Returns: `true` since the node can always be upcast to ``Syntax`` node.
  ///
  /// - Note: This method overloads the general `is` method and is marked deprecated to produce a warning
  ///         informing the user that the upcast will always succeed.
  @available(*, deprecated, message: "This cast will always succeed")
  public func `is`(_ syntaxType: Syntax.Type) -> Bool {
    return true
  }

  /// Checks if the current syntax node can be cast to its own type.
  ///
  /// - Returns: `true` since the node is already of its own type.
  ///
  /// - Note: This method overloads the general `is` method and is marked as deprecated to produce a warning,
  ///         informing the user that the cast will always succeed.
  @available(*, deprecated, message: "This cast will always succeed")
  public func `is`(_ syntaxType: Self.Type) -> Bool {
    return true
  }

  /// Attempts to cast the current syntax node to a given specialized syntax type.
  ///
  /// - Returns: An instance of the specialized type, or `nil` if the cast fails.
  public func `as`<S: SyntaxProtocol>(_ syntaxType: S.Type) -> S? {
    return S.init(self)
  }

  /// Attempts to upcast the current syntax node to ``Syntax`` node.
  ///
  /// - Returns: The ``Syntax`` node created from the current syntax node, as the node can always be upcast to ``Syntax`` node.
  ///
  /// - Note: This method overloads the general `as` method and is marked deprecated to produce a warning
  ///         informing the user the upcast should be performed using the base node's initializer.
  @available(*, deprecated, message: "Use `Syntax.init` for upcasting.")
  public func `as`(_ syntaxType: Syntax.Type) -> Syntax? {
    return Syntax(self)
  }

  /// Casts the current syntax node to its own type.
  ///
  /// - Returns: The current syntax node.
  ///
  /// - Note: This method overloads the general `as` method and is marked as deprecated to produce a warning,
  ///         informing the user that the cast will always succeed.
  @available(*, deprecated, message: "This cast will always succeed")
  public func `as`(_ syntaxType: Self.Type) -> Self? {
    return self
  }

  /// Force-casts the current syntax node to a given specialized syntax type.
  ///
  /// - Returns: An instance of the specialized type.
  /// - Warning: This function will crash if the cast is not possible. Use `as` to safely attempt a cast.
  public func cast<S: SyntaxProtocol>(_ syntaxType: S.Type) -> S {
    return self.as(S.self)!
  }

  /// Force-cast the current syntax node to ``Syntax`` node..
  ///
  /// - Returns: The ``Syntax`` node created from the current syntax node, as the node can always be upcast to ``Syntax`` node.
  ///
  /// - Note: This method overloads the general `as` method and is marked deprecated to produce a warning
  ///         informing the user the upcast should be performed using the base node's initializer.
  @available(*, deprecated, message: "Use `Syntax.init` for upcasting.")
  public func cast(_ syntaxType: Syntax.Type) -> Syntax {
    return Syntax(self)
  }

  /// Force-casts the current syntax node to its own type.
  ///
  /// - Returns: The current syntax node.
  ///
  /// - Note: This method overloads the general `cast` method and is marked as deprecated to produce a warning,
  ///         informing the user that the cast will always succeed.
  @available(*, deprecated, message: "This cast will always succeed")
  public func cast(_ syntaxType: Self.Type) -> Self {
    return self
  }
}

// MARK: Modifying

extension SyntaxProtocol {
  /// Returns a new syntax node that has the child at `keyPath` replaced by
  /// `value`.
  public func with<T>(_ keyPath: WritableKeyPath<Self, T>, _ value: T) -> Self {
    var copy = self
    copy[keyPath: keyPath] = value
    return copy
  }

  /// Return this subtree with this node as the root, ie. detach this node
  /// from its parent.
  public var detached: Self {
    if !self.hasParent {
      return self
    }
    // Make sure `self` (and thus the arena of `self.raw`) can’t get deallocated
    // before the detached node can be created.
    return withExtendedLifetime(self) {
      return Syntax(raw: self.raw, rawNodeArena: self.raw.arenaReference.retained).cast(Self.self)
    }
  }
}

// MARK: Type information

extension SyntaxProtocol {
  /// The kind of the syntax node, e.g. if it is a ``SyntaxKind/functionDecl``.
  ///
  /// If you want to check for a node's kind and cast the node to that type, see
  /// `self.as(FunctionDeclSyntax.self)` or `self.as(SyntaxEnum.self)`.
  public var kind: SyntaxKind {
    return raw.kind
  }

  /// The dynamic metatype of the concrete node.
  ///
  /// You almost always want to prefer this over `type(of: self)` because if
  /// `self` is a ``DeclSyntax`` representing a ``FunctionDeclSyntax``,
  /// `type(of: self)` will return ``DeclSyntax``, while `syntaxNodeType` looks
  /// at the dynamic kind of this node and returns ``FunctionDeclSyntax``.
  public var syntaxNodeType: SyntaxProtocol.Type {
    return self.raw.kind.syntaxNodeType
  }
}

// MARK: Children / parent / ancestor

extension SyntaxProtocol {
  /// A sequence over the children of this node.
  public func children(viewMode: SyntaxTreeViewMode) -> SyntaxChildren {
    return SyntaxChildren(_syntaxNode, viewMode: viewMode)
  }

  /// The index of this node in a ``SyntaxChildren`` collection.
  @available(*, deprecated, message: "Use index(of:) on the collection that contains this node")
  public var index: SyntaxChildrenIndex {
    return indexInParent
  }

  /// The index of this node in a ``SyntaxChildren`` collection.
  internal var indexInParent: SyntaxChildrenIndex {
    return SyntaxChildrenIndex(value: Syntax(self).layoutIndexInParent)
  }

  /// The parent of this syntax node, or `nil` if this node is the root.
  public var parent: Syntax? {
    return Syntax(self).parent
  }

  /// The root of the tree in which this node resides.
  public var root: Syntax {
    return Syntax(self).root
  }

  /// Whether or not this node has a parent.
  public var hasParent: Bool {
    return Syntax(self).hasParent
  }

  public var keyPathInParent: AnyKeyPath? {
    guard let parent = self.parent else {
      return nil
    }
    guard case .layout(let childrenKeyPaths) = parent.kind.syntaxNodeType.structure else {
      return nil
    }
    return childrenKeyPaths[Syntax(self).layoutIndexInParent]
  }

  @available(*, deprecated, message: "Use previousToken(viewMode:) instead")
  public var previousToken: TokenSyntax? {
    return self.previousToken(viewMode: .sourceAccurate)
  }

  /// Applies `map` to this node and each of its ancestors until a non-`nil`
  /// value is produced, then returns that value.
  ///
  /// If no node has a non-`nil` mapping, returns `nil`.
  public func ancestorOrSelf<T>(mapping map: (Syntax) -> T?) -> T? {
    Syntax(self).ancestorOrSelf(mapping: map)
  }
}

// MARK: Accessing tokens

extension SyntaxProtocol {
  /// Recursively walks through the tree to find the token semantically before
  /// this node.
  public func previousToken(viewMode: SyntaxTreeViewMode) -> TokenSyntax? {
    return self._syntaxNode.previousToken(viewMode: viewMode)
  }

  @available(*, deprecated, message: "Use nextToken(viewMode:) instead")
  public var nextToken: TokenSyntax? {
    return self.nextToken(viewMode: .sourceAccurate)
  }

  /// Recursively walks through the tree to find the next token semantically
  /// after this node.
  public func nextToken(viewMode: SyntaxTreeViewMode) -> TokenSyntax? {
    return self._syntaxNode.nextToken(viewMode: viewMode)
  }

  @available(*, deprecated, message: "Use firstToken(viewMode: .sourceAccurate) instead")
  public var firstToken: TokenSyntax? {
    return self.firstToken(viewMode: .sourceAccurate)
  }

  /// Returns the first token node that is part of this syntax node.
  public func firstToken(viewMode: SyntaxTreeViewMode) -> TokenSyntax? {
    return self._syntaxNode.firstToken(viewMode: viewMode)
  }

  @available(*, deprecated, message: "Use lastToken(viewMode: .sourceAccurate) instead")
  public var lastToken: TokenSyntax? {
    return self.lastToken(viewMode: .sourceAccurate)
  }

  /// Returns the last token node that is part of this syntax node.
  public func lastToken(viewMode: SyntaxTreeViewMode) -> TokenSyntax? {
    return self._syntaxNode.lastToken(viewMode: viewMode)
  }

  /// Sequence of tokens that are part of this Syntax node.
  public func tokens(viewMode: SyntaxTreeViewMode) -> TokenSequence {
    return TokenSequence(_syntaxNode, viewMode: viewMode)
  }

  /// Find the syntax token at the given absolute position within this
  /// syntax node or any of its children.
  public func token(at position: AbsolutePosition) -> TokenSyntax? {
    // If the position isn't within this node at all, return early.
    guard position >= self.position && position < self.endPosition else {
      return nil
    }

    // If we are a token syntax, that's it!
    if let token = Syntax(self).as(TokenSyntax.self) {
      return token
    }

    // Otherwise, it must be one of our children.
    for child in children(viewMode: .sourceAccurate) {
      if let token = child.token(at: position) {
        return token
      }
    }

    fatalError("Children of syntax node do not cover all positions in it")
  }

  /// If the node with the given `syntaxIdentifier` is a (recursive) child of this node, return the node with that
  /// identifier.
  ///
  /// If the identifier references a node from a different tree (ie. one that has a different root ID in the
  /// ``SyntaxIdentifier``) or if no node with the given identifier is a child of this syntax node, returns `nil`.
  public func node(at syntaxIdentifier: SyntaxIdentifier) -> Syntax? {
    let syntax = Syntax(self)
    guard syntax.raw.id == syntaxIdentifier.rootId else {
      return nil
    }

    func _node(at indexInTree: UInt32, in node: Syntax) -> Syntax? {
      let i = node.absoluteInfo.indexInTree
      if i == indexInTree {
        return node
      }
      guard i < indexInTree, indexInTree < i &+ UInt32(truncatingIfNeeded: node.raw.totalNodes) else {
        return nil
      }
      for child in node.children(viewMode: .all) {
        if let node = _node(at: indexInTree, in: child) {
          return node
        }
      }
      preconditionFailure("syntaxIdentifier is covered by this node but not any of its children?")
    }
    return _node(at: syntaxIdentifier.indexInTree.indexInTree, in: syntax)
  }
}

// MARK: Recursive flags

extension SyntaxProtocol {
  /// Whether the tree contained by this layout has any
  ///  - missing nodes or
  ///  - unexpected nodes or
  ///  - tokens with a ``TokenDiagnostic`` of severity ``TokenDiagnostic/Severity-swift.enum/error``.
  public var hasError: Bool {
    return raw.recursiveFlags.contains(.hasError)
  }

  /// Whether the tree contained by this layout has any tokens with a
  /// ``TokenDiagnostic`` of severity `warning`.
  public var hasWarning: Bool {
    return raw.recursiveFlags.contains(.hasWarning)
  }

  /// Whether this tree contains a missing token or unexpected node.
  public var hasSequenceExpr: Bool {
    return raw.recursiveFlags.contains(.hasSequenceExpr)
  }

  public var hasMaximumNestingLevelOverflow: Bool {
    return raw.recursiveFlags.contains(.hasMaximumNestingLevelOverflow)
  }
}

// MARK: Position / length / range

extension SyntaxProtocol {
  /// The absolute position of the starting point of this node. If the first token
  /// is with leading trivia, the position points to the start of the leading
  /// trivia.
  public var position: AbsolutePosition {
    return Syntax(self).position
  }

  /// The absolute position of the starting point of this node, skipping any
  /// leading trivia attached to the first token syntax.
  public var positionAfterSkippingLeadingTrivia: AbsolutePosition {
    return Syntax(self).positionAfterSkippingLeadingTrivia
  }

  /// The end position of this node's content, before any trailing trivia.
  public var endPositionBeforeTrailingTrivia: AbsolutePosition {
    return Syntax(self).endPositionBeforeTrailingTrivia
  }

  /// The end position of this node, including its trivia.
  public var endPosition: AbsolutePosition {
    return Syntax(self).endPosition
  }

  /// The length of this node including all of its trivia.
  public var totalLength: SourceLength {
    return raw.totalLength
  }

  /// The length this node takes up spelled out in the source, excluding its
  /// leading or trailing trivia.
  ///
  /// - Note: If this node consists of multiple tokens, only the first token’s
  ///   leading and the last token’s trailing trivia will be trimmed.
  public var trimmedLength: SourceLength {
    return raw.trimmedLength
  }

  /// The byte source range of this node including leading and trailing trivia.
  @available(*, deprecated, renamed: "range")
  public var totalByteRange: ByteSourceRange {
    return ByteSourceRange(offset: position.utf8Offset, length: totalLength.utf8Length)
  }

  /// The range of this node including leading and trailing trivia.
  public var range: Range<AbsolutePosition> {
    return position..<endPosition
  }

  /// The byte source range of this node excluding leading and trailing trivia.
  ///
  /// - Note: If this node consists of multiple tokens, only the first token’s
  ///   leading and the last token’s trailing trivia will be trimmed.
  @available(*, deprecated, renamed: "trimmedRange")
  public var trimmedByteRange: ByteSourceRange {
    return ByteSourceRange(
      offset: positionAfterSkippingLeadingTrivia.utf8Offset,
      length: trimmedLength.utf8Length
    )
  }

  /// The range of this node excluding leading and trailing trivia.
  ///
  /// - Note: If this node consists of multiple tokens, only the first token’s
  ///   leading and the last token’s trailing trivia will be trimmed.
  public var trimmedRange: Range<AbsolutePosition> {
    return positionAfterSkippingLeadingTrivia..<endPositionBeforeTrailingTrivia
  }

  @available(*, deprecated, renamed: "trimmedLength")
  public var contentLength: SourceLength {
    return trimmedLength
  }

  @available(*, deprecated, renamed: "totalByteRange")
  public var byteRange: ByteSourceRange {
    return ByteSourceRange(offset: position.utf8Offset, length: totalLength.utf8Length)
  }

  /// The textual byte length of this node including leading and trailing trivia.
  @available(*, deprecated, message: "Use totalLength.utf8Length")
  public var byteSize: Int {
    return totalLength.utf8Length
  }

  /// The textual byte length of this node excluding leading and trailing trivia.
  @available(*, deprecated, message: "Use trimmedLength.utf8Length")
  public var byteSizeAfterTrimmingTrivia: Int {
    return trimmedLength.utf8Length
  }
}

// MARK: Trivia

extension SyntaxProtocol {
  /// The leading trivia of this syntax node.
  ///
  /// Trivia is always attached to tokens, not to layout nodes. This will return the leading trivia of the first token
  /// within the subtree. If no such token exists, this returns empty trivia.
  ///
  /// - Note: ``Trivia`` is not able to represent invalid UTF-8 sequences. To get
  /// the leading trivia text including all invalid UTF-8 sequences, use
  /// ```
  /// node.syntaxTextBytes.prefix(self.leadingTriviaLength.utf8Length)
  /// ```
  public var leadingTrivia: Trivia {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = Syntax(self).withLeadingTrivia(newValue, rawAllocationArena: RawSyntaxArena()).cast(Self.self)
    }
  }

  /// The trailing trivia of this syntax node.
  ///
  /// Trivia is always attached to tokens, not to layout nodes. This will return the trailing trivia of the last token
  /// within the subtree. If no such token exists, this returns empty trivia.
  ///
  /// Note: ``Trivia`` is not able to represent invalid UTF-8 sequences. To get
  /// the leading trivia text including all invalid UTF-8 sequences, use
  /// ```
  /// node.syntaxTextBytes[(node.byteSize - node.trailingTriviaLength.utf8Length)...]
  /// ```
  public var trailingTrivia: Trivia {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = Syntax(self).withTrailingTrivia(newValue, rawAllocationArena: RawSyntaxArena()).cast(Self.self)
    }
  }

  /// The length this node's leading trivia takes up spelled out in source.
  public var leadingTriviaLength: SourceLength {
    return raw.leadingTriviaLength
  }

  /// The length this node's trailing trivia takes up spelled out in source.
  public var trailingTriviaLength: SourceLength {
    return raw.trailingTriviaLength
  }
}

// MARK: Content

/// Provides the source-accurate text for a node
extension SyntaxProtocol {
  /// A source-accurate description of this node.
  ///
  /// Note that the resulting String cannot represent invalid UTF-8 that
  /// occurs within the syntax nodes. Use `syntaxTextBytes` for a
  /// byte-accurate representation of this node in the presence of
  /// invalid UTF-8.
  public var description: String {
    return Syntax(self).raw.description
  }

  /// Retrieve the syntax text as an array of bytes that models the input
  /// source even in the presence of invalid UTF-8.
  public var syntaxTextBytes: [UInt8] {
    return Syntax(self).raw.syntaxTextBytes
  }

  /// Prints the raw value of this node to the provided stream.
  /// - Parameter stream: The stream to which to print the raw tree.
  public func write<Target>(to stream: inout Target)
  where Target: TextOutputStream {
    Syntax(self).raw.write(to: &stream)
  }

  /// A copy of this node without the leading trivia of the first token in the
  /// node and the trailing trivia of the last token in the node.
  ///
  /// The trimmed node is detached from its parent.
  public var trimmed: Self {
    // TODO: Should only need one new node here
    return self.detached.with(\.leadingTrivia, []).with(\.trailingTrivia, [])
  }

  /// A copy of this node with pieces that match `matching` trimmed from the
  /// leading trivia of the first token and trailing trivia of the last token.
  public func trimmed(matching filter: (TriviaPiece) -> Bool) -> Self {
    // TODO: Should only need one new node here
    return self.with(
      \.leadingTrivia,
      Trivia(pieces: leadingTrivia.pieces.drop(while: filter))
    ).with(
      \.trailingTrivia,
      Trivia(pieces: trailingTrivia.pieces.reversed().drop(while: filter).reversed())
    )
  }

  /// The description of this node with leading whitespace of the first token
  /// and trailing whitespace of the last token removed.
  public var trimmedDescription: String {
    // TODO: We shouldn't need to create to copies just to get the trimmed
    // description.
    return self.trimmed.description
  }

  /// The description of this node with pieces that match `matching` removed
  /// from the leading trivia of the first token and trailing trivia of the
  /// last token.
  public func trimmedDescription(matching filter: (TriviaPiece) -> Bool) -> String {
    // TODO: We shouldn't need to create to copies just to get the trimmed
    // description.
    return self.trimmed(matching: filter).description
  }
}

// MARK: Miscellaneous

extension SyntaxProtocol {
  /// When isImplicit is true, the syntax node doesn't include any
  /// underlying tokens, e.g. an empty CodeBlockItemList.
  @available(*, deprecated, message: "Check children(viewMode: .all).isEmpty instead")
  public var isImplicit: Bool {
    return raw.byteLength == 0
  }

  /// Returns a value representing the unique identity of the node.
  public var id: SyntaxIdentifier {
    return Syntax(self).id
  }
}

// MARK: Debug description

/// Provides debug descriptions for a node
extension SyntaxProtocol {
  /// A simple description of this node (ie. its type).
  public var debugDescription: String {
    debugDescription()
  }

  public var customMirror: Mirror {
    // Suppress printing of children when doing `po node` in the debugger.
    // `debugDescription` already prints them in a nicer way.
    return Mirror(self, children: [:])
  }

  /// Returns a summarized dump of this node.
  /// - Parameters:
  ///   - includeTrivia: Add trivia to each dumped node, which the default
  ///   dump skips.
  ///   - converter: The location converter for the root of the tree. Adds
  ///   `[startLine:startCol...endLine:endCol]` to each node.
  ///   - mark: Adds `***` around the given node, intended to highlight it in
  ///   the dump.
  ///   - indentString: The starting indentation, empty by default. Each
  ///   additional indentation will add 2 spaces.
  public func debugDescription(
    includeTrivia: Bool = false,
    converter: SourceLocationConverter? = nil,
    mark: SyntaxProtocol? = nil,
    indentString: String = ""
  ) -> String {
    var str = ""
    debugWrite(
      to: &str,
      includeTrivia: includeTrivia,
      converter: converter,
      mark: mark,
      indentString: indentString
    )
    return str
  }

  private func debugWrite<Target: TextOutputStream>(
    to target: inout Target,
    includeTrivia: Bool,
    converter: SourceLocationConverter? = nil,
    mark: SyntaxProtocol? = nil,
    indentString: String
  ) {
    if let mark, self.id == mark.id {
      target.write("*** ")
    }

    if let token = Syntax(self).as(TokenSyntax.self) {
      target.write(String(describing: token.tokenKind))
      if includeTrivia {
        if !leadingTrivia.isEmpty {
          target.write(" leadingTrivia=\(leadingTrivia.debugDescription)")
        }
        if !trailingTrivia.isEmpty {
          target.write(" trailingTrivia=\(trailingTrivia.debugDescription)")
        }
      }
    } else {
      target.write(String(describing: syntaxNodeType))
    }

    let allChildren = children(viewMode: .all)

    if let converter {
      let range = sourceRange(converter: converter)
      target.write(" [\(range.start.line):\(range.start.column)...\(range.end.line):\(range.end.column)]")
    }

    if let tokenView = raw.tokenView, tokenView.presence == .missing {
      target.write(" MISSING")
    }

    if let mark, self.id == mark.id {
      target.write(" ***")
    }

    for (num, child) in allChildren.enumerated() {
      let isLastChild = num == allChildren.count - 1
      target.write("\n")
      target.write(indentString)
      target.write(isLastChild ? "╰─" : "├─")
      if let keyPath = child.keyPathInParent, let name = childName(keyPath) {
        target.write("\(name): ")
      } else if self.kind.isSyntaxCollection {
        target.write("[\(num)]: ")
      }
      let childIndentString = indentString + (isLastChild ? "  " : "│ ")
      child.debugWrite(
        to: &target,
        includeTrivia: includeTrivia,
        converter: converter,
        mark: mark,
        indentString: childIndentString
      )
    }
  }
}

/// Protocol for the enums nested inside ``Syntax`` nodes that enumerate all the
/// possible types a child node might have.
public protocol SyntaxChildChoices: SyntaxProtocol {}

extension SyntaxChildChoices {

  /// Checks if the current ``SyntaxChildChoices`` instance can be cast to a given specialized syntax type.
  ///
  /// - Returns: `true` if the node can be cast, `false` otherwise.
  ///
  /// - Note: This method is marked as deprecated because it is advised not to use it for unrelated casts.
  @available(*, deprecated, message: "This cast will always fail")
  public func `is`<S: SyntaxProtocol>(_ syntaxType: S.Type) -> Bool {
    return self.as(syntaxType) != nil
  }

  /// Attempts to cast the current ``SyntaxChildChoices`` instance to a given specialized syntax type.
  ///
  /// - Returns: An instance of the specialized syntax type, or `nil` if the cast fails.
  ///
  /// - Note: This method is marked as deprecated because it is advised not to use it for unrelated casts.
  @available(*, deprecated, message: "This cast will always fail")
  public func `as`<S: SyntaxProtocol>(_ syntaxType: S.Type) -> S? {
    return S.init(self)
  }

  /// Force-casts the current ``SyntaxChildChoices`` instance to a given specialized syntax type.
  ///
  /// - Returns: An instance of the specialized syntax type.
  ///
  /// - Warning: This function will crash if the cast is not possible. Use `as` for a safe attempt.
  ///
  /// - Note: This method is marked as deprecated because it is advised not to use it for unrelated casts.
  @available(*, deprecated, message: "This cast will always fail")
  public func cast<S: SyntaxProtocol>(_ syntaxType: S.Type) -> S {
    return self.as(S.self)!
  }
}
