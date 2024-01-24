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
  init?(_ node: some SyntaxProtocol)

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
public extension SyntaxProtocol {
  /// Initializes a new instance of the conforming type from a given specialized syntax node.
  ///
  /// Returns `nil` if the conversion isn't possible, or if the provided node is `nil`.
  init?<S: SyntaxProtocol>(_ node: S?) {
    guard let node = node else {
      return nil
    }
    self.init(node)
  }

  /// Checks if the current syntax node can be cast to a given specialized syntax type.
  ///
  /// - Returns: `true` if the node can be cast, `false` otherwise.
  func `is`<S: SyntaxProtocol>(_ syntaxType: S.Type) -> Bool {
    return self.as(syntaxType) != nil
  }

  /// Checks if the current syntax node can be upcast to ``Syntax`` node.
  ///
  /// - Returns: `true` since the node can always be upcast to ``Syntax`` node.
  ///
  /// - Note: This method overloads the general `is` method and is marked deprecated to produce a warning
  ///         informing the user that the upcast will always succeed.
  @available(*, deprecated, message: "This cast will always succeed")
  func `is`(_ syntaxType: Syntax.Type) -> Bool {
    return true
  }

  /// Checks if the current syntax node can be cast to its own type.
  ///
  /// - Returns: `true` since the node is already of its own type.
  ///
  /// - Note: This method overloads the general `is` method and is marked as deprecated to produce a warning,
  ///         informing the user that the cast will always succeed.
  @available(*, deprecated, message: "This cast will always succeed")
  func `is`(_ syntaxType: Self.Type) -> Bool {
    return true
  }

  /// Attempts to cast the current syntax node to a given specialized syntax type.
  ///
  /// - Returns: An instance of the specialized type, or `nil` if the cast fails.
  func `as`<S: SyntaxProtocol>(_ syntaxType: S.Type) -> S? {
    return S.init(self)
  }

  /// Attempts to upcast the current syntax node to ``Syntax`` node.
  ///
  /// - Returns: The ``Syntax`` node created from the current syntax node, as the node can always be upcast to ``Syntax`` node.
  ///
  /// - Note: This method overloads the general `as` method and is marked deprecated to produce a warning
  ///         informing the user the upcast should be performed using the base node's initializer.
  @available(*, deprecated, message: "Use `Syntax.init` for upcasting.")
  func `as`(_ syntaxType: Syntax.Type) -> Syntax? {
    return Syntax(self)
  }

  /// Casts the current syntax node to its own type.
  ///
  /// - Returns: The current syntax node.
  ///
  /// - Note: This method overloads the general `as` method and is marked as deprecated to produce a warning,
  ///         informing the user that the cast will always succeed.
  @available(*, deprecated, message: "This cast will always succeed")
  func `as`(_ syntaxType: Self.Type) -> Self? {
    return self
  }

  /// Force-casts the current syntax node to a given specialized syntax type.
  ///
  /// - Returns: An instance of the specialized type.
  /// - Warning: This function will crash if the cast is not possible. Use `as` to safely attempt a cast.
  func cast<S: SyntaxProtocol>(_ syntaxType: S.Type) -> S {
    return self.as(S.self)!
  }

  /// Force-cast the current syntax node to ``Syntax`` node..
  ///
  /// - Returns: The ``Syntax`` node created from the current syntax node, as the node can always be upcast to ``Syntax`` node.
  ///
  /// - Note: This method overloads the general `as` method and is marked deprecated to produce a warning
  ///         informing the user the upcast should be performed using the base node's initializer.
  @available(*, deprecated, message: "Use `Syntax.init` for upcasting.")
  func cast(_ syntaxType: Syntax.Type) -> Syntax {
    return Syntax(self)
  }

  /// Force-casts the current syntax node to its own type.
  ///
  /// - Returns: The current syntax node.
  ///
  /// - Note: This method overloads the general `cast` method and is marked as deprecated to produce a warning,
  ///         informing the user that the cast will always succeed.
  @available(*, deprecated, message: "This cast will always succeed")
  func cast(_ syntaxType: Self.Type) -> Self {
    return self
  }
}

// MARK: Modifying

public extension SyntaxProtocol {
  /// Returns a new syntax node that has the child at `keyPath` replaced by
  /// `value`.
  func with<T>(_ keyPath: WritableKeyPath<Self, T>, _ value: T) -> Self {
    var copy = self
    copy[keyPath: keyPath] = value
    return copy
  }

  /// Return this subtree with this node as the root, ie. detach this node
  /// from its parent.
  var detached: Self {
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

// MARK: Children / parent

public extension SyntaxProtocol {
  /// A sequence over the children of this node.
  func children(viewMode: SyntaxTreeViewMode) -> SyntaxChildren {
    return SyntaxChildren(_syntaxNode, viewMode: viewMode)
  }

  /// The index of this node in a ``SyntaxChildren`` collection.
  @available(*, deprecated, message: "Use index(of:) on the collection that contains this node")
  var index: SyntaxChildrenIndex {
    return indexInParent
  }

  /// The index of this node in a ``SyntaxChildren`` collection.
  internal var indexInParent: SyntaxChildrenIndex {
    return SyntaxChildrenIndex(Syntax(self).absoluteInfo)
  }

  /// The parent of this syntax node, or `nil` if this node is the root.
  var parent: Syntax? {
    return Syntax(self).parent
  }

  /// The root of the tree in which this node resides.
  var root: Syntax {
    var this = _syntaxNode
    while let parent = this.parent {
      this = parent
    }
    return this
  }

  /// Whether or not this node has a parent.
  var hasParent: Bool {
    return parent != nil
  }

  var keyPathInParent: AnyKeyPath? {
    guard let parent = self.parent else {
      return nil
    }
    guard case .layout(let childrenKeyPaths) = parent.kind.syntaxNodeType.structure else {
      return nil
    }
    return childrenKeyPaths[Syntax(self).indexInParent]
  }

  @available(*, deprecated, message: "Use previousToken(viewMode:) instead")
  var previousToken: TokenSyntax? {
    return self.previousToken(viewMode: .sourceAccurate)
  }
}

// MARK: Accessing tokens

public extension SyntaxProtocol {
  /// Recursively walks through the tree to find the token semantically before
  /// this node.
  func previousToken(viewMode: SyntaxTreeViewMode) -> TokenSyntax? {
    guard let parent = self.parent else {
      return nil
    }
    let siblings = NonNilRawSyntaxChildren(parent, viewMode: viewMode)
    // `self` could be a missing node at index 0 and `viewMode` be `.sourceAccurate`.
    // In that case `siblings` skips over the missing `self` node and has a `startIndex > 0`.
    if self.indexInParent >= siblings.startIndex {
      for absoluteRaw in siblings[..<self.indexInParent].reversed() {
        let child = Syntax(absoluteRaw, parent: parent)
        if let token = child.lastToken(viewMode: viewMode) {
          return token
        }
      }
    }
    return parent.previousToken(viewMode: viewMode)
  }

  @available(*, deprecated, message: "Use nextToken(viewMode:) instead")
  var nextToken: TokenSyntax? {
    return self.nextToken(viewMode: .sourceAccurate)
  }

  /// Recursively walks through the tree to find the next token semantically
  /// after this node.
  func nextToken(viewMode: SyntaxTreeViewMode) -> TokenSyntax? {
    guard let parent = self.parent else {
      return nil
    }
    let siblings = NonNilRawSyntaxChildren(parent, viewMode: viewMode)
    let nextSiblingIndex = siblings.index(after: self.indexInParent)
    for absoluteRaw in siblings[nextSiblingIndex...] {
      let child = Syntax(absoluteRaw, parent: parent)
      if let token = child.firstToken(viewMode: viewMode) {
        return token
      }
    }
    return parent.nextToken(viewMode: viewMode)
  }

  @available(*, deprecated, message: "Use firstToken(viewMode: .sourceAccurate) instead")
  var firstToken: TokenSyntax? {
    return self.firstToken(viewMode: .sourceAccurate)
  }

  /// Returns the first token node that is part of this syntax node.
  func firstToken(viewMode: SyntaxTreeViewMode) -> TokenSyntax? {
    guard viewMode.shouldTraverse(node: raw) else { return nil }
    if let token = _syntaxNode.as(TokenSyntax.self) {
      return token
    }

    for child in children(viewMode: viewMode) {
      if let token = child.firstToken(viewMode: viewMode) {
        return token
      }
    }
    return nil
  }

  @available(*, deprecated, message: "Use lastToken(viewMode: .sourceAccurate) instead")
  var lastToken: TokenSyntax? {
    return self.lastToken(viewMode: .sourceAccurate)
  }

  /// Returns the last token node that is part of this syntax node.
  func lastToken(viewMode: SyntaxTreeViewMode) -> TokenSyntax? {
    guard viewMode.shouldTraverse(node: raw) else { return nil }
    if let token = _syntaxNode.as(TokenSyntax.self) {
      return token
    }

    for child in children(viewMode: viewMode).reversed() {
      if let tok = child.lastToken(viewMode: viewMode) {
        return tok
      }
    }
    return nil
  }

  /// Sequence of tokens that are part of this Syntax node.
  func tokens(viewMode: SyntaxTreeViewMode) -> TokenSequence {
    return TokenSequence(_syntaxNode, viewMode: viewMode)
  }

  /// Find the syntax token at the given absolute position within this
  /// syntax node or any of its children.
  func token(at position: AbsolutePosition) -> TokenSyntax? {
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
}

// MARK: Recursive flags

public extension SyntaxProtocol {
  /// Whether the tree contained by this layout has any
  ///  - missing nodes or
  ///  - unexpected nodes or
  ///  - tokens with a ``TokenDiagnostic`` of severity ``TokenDiagnostic/Severity-swift.enum/error``.
  var hasError: Bool {
    return raw.hasError
  }

  /// Whether the tree contained by this layout has any tokens with a
  /// ``TokenDiagnostic`` of severity `warning`.
  var hasWarning: Bool {
    return raw.recursiveFlags.contains(.hasWarning)
  }

  /// Whether this tree contains a missing token or unexpected node.
  var hasSequenceExpr: Bool {
    return raw.recursiveFlags.contains(.hasSequenceExpr)
  }

  var hasMaximumNestingLevelOverflow: Bool {
    return raw.recursiveFlags.contains(.hasMaximumNestingLevelOverflow)
  }
}

// MARK: Position / length / range

public extension SyntaxProtocol {
  /// The absolute position of the starting point of this node. If the first token
  /// is with leading trivia, the position points to the start of the leading
  /// trivia.
  var position: AbsolutePosition {
    return Syntax(self).position
  }

  /// The absolute position of the starting point of this node, skipping any
  /// leading trivia attached to the first token syntax.
  var positionAfterSkippingLeadingTrivia: AbsolutePosition {
    return Syntax(self).positionAfterSkippingLeadingTrivia
  }

  /// The end position of this node's content, before any trailing trivia.
  var endPositionBeforeTrailingTrivia: AbsolutePosition {
    return Syntax(self).endPositionBeforeTrailingTrivia
  }

  /// The end position of this node, including its trivia.
  var endPosition: AbsolutePosition {
    return Syntax(self).endPosition
  }

  /// The length of this node including all of its trivia.
  var totalLength: SourceLength {
    return raw.totalLength
  }

  /// The length this node takes up spelled out in the source, excluding its
  /// leading or trailing trivia.
  ///
  /// - Note: If this node consists of multiple tokens, only the first token’s
  ///   leading and the last token’s trailing trivia will be trimmed.
  var trimmedLength: SourceLength {
    return raw.trimmedLength
  }

  /// The byte source range of this node including leading and trailing trivia.
  var totalByteRange: ByteSourceRange {
    return ByteSourceRange(offset: position.utf8Offset, length: totalLength.utf8Length)
  }

  /// The byte source range of this node excluding leading and trailing trivia.
  ///
  /// - Note: If this node consists of multiple tokens, only the first token’s
  ///   leading and the last token’s trailing trivia will be trimmed.
  var trimmedByteRange: ByteSourceRange {
    return ByteSourceRange(
      offset: positionAfterSkippingLeadingTrivia.utf8Offset,
      length: trimmedLength.utf8Length
    )
  }

  @available(*, deprecated, renamed: "trimmedLength")
  var contentLength: SourceLength {
    return trimmedLength
  }

  @available(*, deprecated, renamed: "totalByteRange")
  var byteRange: ByteSourceRange {
    return ByteSourceRange(offset: position.utf8Offset, length: totalLength.utf8Length)
  }

  /// The textual byte length of this node including leading and trailing trivia.
  @available(*, deprecated, message: "Use totalLength.utf8Length")
  var byteSize: Int {
    return totalLength.utf8Length
  }

  /// The textual byte length of this node excluding leading and trailing trivia.
  @available(*, deprecated, message: "Use trimmedLength.utf8Length")
  var byteSizeAfterTrimmingTrivia: Int {
    return trimmedLength.utf8Length
  }
}

// MARK: Trivia

public extension SyntaxProtocol {
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
  var leadingTrivia: Trivia {
    get {
      return raw.formLeadingTrivia()
    }
    set {
      self = Syntax(self).withLeadingTrivia(newValue, arena: SyntaxArena()).cast(Self.self)
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
  var trailingTrivia: Trivia {
    get {
      return raw.formTrailingTrivia()
    }
    set {
      self = Syntax(self).withTrailingTrivia(newValue, arena: SyntaxArena()).cast(Self.self)
    }
  }

  /// The length this node's leading trivia takes up spelled out in source.
  var leadingTriviaLength: SourceLength {
    return raw.leadingTriviaLength
  }

  /// The length this node's trailing trivia takes up spelled out in source.
  var trailingTriviaLength: SourceLength {
    return raw.trailingTriviaLength
  }
}

// MARK: Content

/// Provides the source-accurate text for a node
public extension SyntaxProtocol {
  /// A source-accurate description of this node.
  ///
  /// Note that the resulting String cannot represent invalid UTF-8 that
  /// occurs within the syntax nodes. Use `syntaxTextBytes` for a
  /// byte-accurate representation of this node in the presence of
  /// invalid UTF-8.
  var description: String {
    return Syntax(self).raw.description
  }

  /// Retrieve the syntax text as an array of bytes that models the input
  /// source even in the presence of invalid UTF-8.
  var syntaxTextBytes: [UInt8] {
    return Syntax(self).raw.syntaxTextBytes
  }

  /// Prints the raw value of this node to the provided stream.
  /// - Parameter stream: The stream to which to print the raw tree.
  func write<Target>(to target: inout Target)
  where Target: TextOutputStream {
    Syntax(self).raw.write(to: &target)
  }

  /// A copy of this node without the leading trivia of the first token in the
  /// node and the trailing trivia of the last token in the node.
  var trimmed: Self {
    // TODO: Should only need one new node here
    return self.with(\.leadingTrivia, []).with(\.trailingTrivia, [])
  }

  /// A copy of this node with pieces that match `matching` trimmed from the
  /// leading trivia of the first token and trailing trivia of the last token.
  func trimmed(matching filter: (TriviaPiece) -> Bool) -> Self {
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
  var trimmedDescription: String {
    // TODO: We shouldn't need to create to copies just to get the trimmed
    // description.
    return self.trimmed.description
  }

  /// The description of this node with pieces that match `matching` removed
  /// from the leading trivia of the first token and trailing trivia of the
  /// last token.
  func trimmedDescription(matching filter: (TriviaPiece) -> Bool) -> String {
    // TODO: We shouldn't need to create to copies just to get the trimmed
    // description.
    return self.trimmed(matching: filter).description
  }
}

// MARK: Miscellaneous

public extension SyntaxProtocol {
  /// When isImplicit is true, the syntax node doesn't include any
  /// underlying tokens, e.g. an empty CodeBlockItemList.
  @available(*, deprecated, message: "Check children(viewMode: .all).isEmpty instead")
  var isImplicit: Bool {
    return raw.isEmpty
  }

  /// Returns a value representing the unique identity of the node.
  var id: SyntaxIdentifier {
    return Syntax(self).id
  }
}

// MARK: Debug description

/// Provides debug descriptions for a node
public extension SyntaxProtocol {
  /// A simple description of this node (ie. its type).
  var debugDescription: String {
    debugDescription()
  }

  var customMirror: Mirror {
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
  ///   - indentLevel: The starting indent level, 0 by default. Each level is 2
  ///   spaces.
  func debugDescription(
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

public extension SyntaxChildChoices {

  /// Checks if the current ``SyntaxChildChoices`` instance can be cast to a given specialized syntax type.
  ///
  /// - Returns: `true` if the node can be cast, `false` otherwise.
  ///
  /// - Note: This method is marked as deprecated because it is advised not to use it for unrelated casts.
  @available(*, deprecated, message: "This cast will always fail")
  func `is`<S: SyntaxProtocol>(_ syntaxType: S.Type) -> Bool {
    return self.as(syntaxType) != nil
  }

  /// Attempts to cast the current ``SyntaxChildChoices`` instance to a given specialized syntax type.
  ///
  /// - Returns: An instance of the specialized syntax type, or `nil` if the cast fails.
  ///
  /// - Note: This method is marked as deprecated because it is advised not to use it for unrelated casts.
  @available(*, deprecated, message: "This cast will always fail")
  func `as`<S: SyntaxProtocol>(_ syntaxType: S.Type) -> S? {
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
  func cast<S: SyntaxProtocol>(_ syntaxType: S.Type) -> S {
    return self.as(S.self)!
  }
}
