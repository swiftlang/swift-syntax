//===------------------ RawSyntax.swift - Raw Syntax nodes ----------------===//
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

typealias RawSyntaxBuffer = UnsafeBufferPointer<RawSyntax?>
typealias RawTriviaPieceBuffer = UnsafeBufferPointer<RawTriviaPiece>

/// Node data for RawSyntax tree. Tagged union plus common data.
internal struct RawSyntaxData {
  internal enum Payload {
    case materializedToken(MaterializedToken)
    case layout(Layout)
  }

  /// Token tyoically created with `SyntaxFactory.makeToken()`.
  struct MaterializedToken {
    var tokenKind: RawTokenKind
    var tokenText: SyntaxText
    var triviaPieces: RawTriviaPieceBuffer
    var numLeadingTrivia: UInt32
    var byteLength: UInt32
  }

  /// Layout node including collections.
  struct Layout {
    var kind: SyntaxKind
    var layout: RawSyntaxBuffer
    var byteLength: Int
    var descendantCount: Int
  }

  fileprivate var payload: Payload
  fileprivate var arenaReference: SyntaxArenaRef
}

extension RawSyntaxData.MaterializedToken {
  var leadingTrivia: RawTriviaPieceBuffer {
    RawTriviaPieceBuffer(rebasing: triviaPieces[..<Int(numLeadingTrivia)])
  }
  var trailingTrivia: RawTriviaPieceBuffer {
    RawTriviaPieceBuffer(rebasing: triviaPieces[Int(numLeadingTrivia)...])
  }
}

/// Represents the raw tree structure underlying the syntax tree. These nodes
/// have no notion of identity and only provide structure to the tree. They
/// are immutable and can be freely shared between syntax nodes.
struct RawSyntax {

  /// Pointer to the actual data which resides in a SyntaxArena.
  var pointer: UnsafePointer<RawSyntaxData>
  init(pointer: UnsafePointer<RawSyntaxData>) {
    self.pointer = pointer
  }

  init(arena: __shared SyntaxArena, payload: RawSyntaxData.Payload) {
    let arenaRef = SyntaxArenaRef(arena)
    self.init(pointer: arena.intern(RawSyntaxData(payload: payload, arenaReference: arenaRef)))
  }

  private var rawData: RawSyntaxData {
    unsafeAddress { pointer }
  }

  internal var arenaReference: SyntaxArenaRef {
    rawData.arenaReference
  }

  internal var arena: SyntaxArena {
    rawData.arenaReference.value
  }

  internal var payload: RawSyntaxData.Payload {
    _read { yield rawData.payload }
  }
}

extension RawSyntax: Identifiable {
  var id: Int {
    Int(bitPattern: pointer)
  }

  static func === (lhs: Self, rhs: Self) -> Bool {
    return lhs.pointer == rhs.pointer
  }
}

// MARK: - Accessors

/// APIs only for token syntax node.
extension RawSyntax {
  /// Token kind of this node assuming this node is a token.
  var rawTokenKind: RawTokenKind {
    switch rawData.payload {
    case .materializedToken(let dat):
      return dat.tokenKind
    case .layout(_):
      preconditionFailure("'tokenKind' is not available for non-token node")
    }
  }

  /// Token text of this node assuming this node is a token.
  var rawTokenText: SyntaxText {
    switch rawData.payload {
    case .materializedToken(let dat):
      return dat.tokenText
    case .layout(_):
      preconditionFailure("'tokenText' is not available for non-token node")
    }
  }

  /// Leading trivia text of this node if this node is a token. 'nil' otherwise.
  var tokenLeadingTriviaByteLength: Int {
    switch rawData.payload {
    case .materializedToken(let dat):
      return dat.leadingTrivia.reduce(0) { $0 + $1.byteLength }
    case .layout(_):
      preconditionFailure("'tokenLeadingTriviaByteLength' is not available for non-token node")
    }
  }

  /// Leading trivia text of this node if this node is a token. 'nil' otherwise.
  var tokenTrailingTriviaByteLength: Int {
    switch rawData.payload {
    case .materializedToken(let dat):
      return dat.trailingTrivia.reduce(0) { $0 + $1.byteLength }
    case .layout(_):
      preconditionFailure("'tokenTrailingTriviaByteLength' is not available for non-token node")
    }
  }

  var tokenLeadingRawTriviaPieces: RawTriviaPieceBuffer {
    switch rawData.payload {
    case .materializedToken(let dat):
      return dat.leadingTrivia
    case .layout(_):
      preconditionFailure("tokenLeadingRawTriviaPieces is called on non-token raw syntax")
    }
  }

  var tokenTrailingRawTriviaPieces: RawTriviaPieceBuffer {
    switch rawData.payload {
    case .materializedToken(let dat):
      return dat.trailingTrivia
    case .layout(_):
      preconditionFailure("tokenTrailingRawTriviaPieces is called on non-token raw syntax")
    }
  }
}

extension RawSyntax {
  /// The syntax kind of this raw syntax.
  var kind: SyntaxKind {
    switch rawData.payload {
    case .materializedToken(_): return .token
    case .layout(let dat): return dat.kind
    }
  }

  /// Whether or not this node is a token one.
  var isToken: Bool {
    kind == .token
  }

  /// Whether or not this node is a collection one.
  var isCollection: Bool {
    kind.isSyntaxCollection
  }

  /// Whether or not this node is an unknown one.
  var isUnknown: Bool {
    kind.isUnknown
  }

  /// Child nodes.
  var children: RawSyntaxBuffer {
    switch rawData.payload {
    case .materializedToken(_): return .init(start: nil, count: 0)
    case .layout(let dat): return dat.layout
    }
  }

  func child(at index: Int) -> RawSyntax? {
    guard hasChild(at: index) else { return nil }
    return children[index]
  }

  func hasChild(at index: Int) -> Bool {
    children[index] != nil
  }

  /// The number of children, `present` or `missing`, in this node.
  var numberOfChildren: Int {
    return children.count
  }

  /// Total number of nodes in this sub-tree, including `self` node.
  var totalNodes: Int {
    switch rawData.payload {
    case .materializedToken(_): return 1
    case .layout(let dat): return dat.descendantCount + 1
    }
  }

  var presence: SourcePresence {
    let isMissing = (self.byteLength == 0 &&
                     !self.isCollection &&
                     !self.isUnknown &&
                     !(isToken && self.rawTokenKind == .eof))
    return isMissing ? .missing : .present
  }

  /// The "width" of the node.
  ///
  /// Sum of text byte lengths of all descendant token nodes.
  var byteLength: Int {
    switch rawData.payload {
    case .materializedToken(let dat): return Int(dat.byteLength)
    case .layout(let dat): return dat.byteLength
    }
  }

  var totalLength: SourceLength {
    SourceLength(utf8Length: byteLength)
  }

  func formTokenKind() -> TokenKind? {
    switch rawData.payload {
    case .materializedToken(let dat):
      return TokenKind.fromRaw(kind: dat.tokenKind, text: dat.tokenText)
    case .layout(_):
      return nil
    }
  }

  /// Returns the leading `Trivia` length for a token node.
  /// - Returns: .zero if called on a layout node.
  var tokenLeadingTriviaLength: SourceLength {
    return SourceLength(utf8Length: tokenLeadingTriviaByteLength)
  }

  /// Returns the trailing `Trivia` length for a token node.
  /// - Returns: .zero if called on a layout node.
  var tokenTrailingTriviaLength: SourceLength {
    return SourceLength(utf8Length: tokenTrailingTriviaByteLength)
  }

  /// Returns the leading `Trivia` for a token node.
  /// - Returns: nil if called on a layout node.
  func formTokenLeadingTrivia() -> Trivia? {
    guard isToken else { return nil }
    return Trivia(pieces: tokenLeadingRawTriviaPieces.map({ TriviaPiece(raw: $0) }))
  }

  /// Returns the trailing `Trivia` for a token node.
  /// - Returns: nil if called on a layout node.
  func formTokenTrailingTrivia() -> Trivia? {
    guard isToken else { return nil }
    return Trivia(pieces: tokenTrailingRawTriviaPieces.map({ TriviaPiece(raw: $0) }))
  }

  /// Passes token info to the provided closure as `UnsafeTokenText`.
  /// - Parameters:
  ///   - body: The closure that accepts the `UnsafeTokenText` value. This value
  ///     must not escape the closure.
  /// - Returns: Return value of `body`.
  func withUnsafeTokenText<Result>(
    _ body: (SyntaxText?) -> Result
  ) -> Result {
    body(rawTokenText)
  }

  func formLayoutArray() -> [RawSyntax?] {
    Array(children)
  }

  func withTokenKind(_ newValue: TokenKind) -> RawSyntax {
    switch payload {
    case .materializedToken(var payload):
      let decomposed = newValue.decomposeToRaw()
      let rawKind = decomposed.rawKind
      let text: SyntaxText = (decomposed.string.map({arena.intern($0)}) ??
                              decomposed.rawKind.defaultText ??
                              "")
      payload.tokenKind = rawKind
      payload.tokenText = text
      return RawSyntax(arena: arena, payload: .materializedToken(payload))
    default:
      preconditionFailure("withTokenKind() is called on non-token raw syntax")
    }
  }

  /// Replaces the leading trivia of the first token in this syntax tree by `leadingTrivia`.
  /// If the syntax tree did not contain a token and thus no trivia could be attached to it, `nil` is returned.
  /// - Parameters:
  ///   - leadingTrivia: The trivia to attach.
  func withLeadingTrivia(_ leadingTrivia: Trivia) -> RawSyntax? {
    if isToken {
      return .makeMaterializedToken(
        arena: arena, kind: formTokenKind()!,
        leadingTrivia: leadingTrivia,
        trailingTrivia: formTokenTrailingTrivia()!)
    }

    for (index, child) in children.enumerated() {
      if let replaced = child?.withLeadingTrivia(leadingTrivia) {
        return replacingChild(at: index, with: replaced, arena: arena)
      }
    }
    return nil
  }

  /// Replaces the trailing trivia of the first token in this syntax tree by `trailingTrivia`.
   /// If the syntax tree did not contain a token and thus no trivia could be attached to it, `nil` is returned.
  /// - Parameters:
  ///   - trailingTrivia: The trivia to attach.
  func withTrailingTrivia(_ trailingTrivia: Trivia) -> RawSyntax? {
    if isToken {
      return .makeMaterializedToken(
        arena: arena, kind: formTokenKind()!,
        leadingTrivia: formTokenLeadingTrivia()!,
        trailingTrivia: trailingTrivia)
    }

    for (index, child) in children.enumerated().reversed() {
      if let replaced = child?.withTrailingTrivia(trailingTrivia) {
        return replacingChild(at: index, with: replaced, arena: arena)
      }
    }
    return nil
  }

  /// Creates a RawSyntax node that's marked missing in the source with the
  /// provided kind and layout.
  /// - Parameters:
  ///   - kind: The syntax kind underlying this node.
  ///   - layout: The children of this node.
  /// - Returns: A new RawSyntax `.node` with the provided kind and layout, with
  ///            `.missing` source presence.
  // @available(*, deprecated, message: "use 'makeEmptyLayout()' with SyntaxArena")
  static func missing(_ kind: SyntaxKind) -> RawSyntax {
    .makeEmptyLayout(arena: .default, kind: kind)
  }

  /// Creates a RawSyntax token that's marked missing in the source with the
  /// provided kind and no leading/trailing trivia.
  /// - Parameter kind: The token kind.
  /// - Returns: A new RawSyntax `.token` with the provided kind, no
  ///            leading/trailing trivia, and `.missing` source presence.
  // @available(*, deprecated, message: "use 'makeEmptyToken()' with SyntaxArena")
  static func missingToken(_ kind: TokenKind) -> RawSyntax {
    .makeEmptyToken(arena: .default, kind: kind)
  }

  func replacingLayout<C: Collection>(
    with elements: C,
    arena: SyntaxArena
  ) -> RawSyntax where C.Element == RawSyntax? {
    assert(!isToken)
    return .makeLayout(arena: arena,
                       kind: kind,
                       uninitializedCount: elements.count) { buffer in
      if buffer.isEmpty { return }
      _ = buffer.initialize(from: elements)
    }
  }

  /// Returns a new RawSyntax node with the provided layout instead of the
  /// existing layout.
  /// - Note: This function does nothing with `.token` nodes --- the same token
  ///         is returned.
  /// - Parameter newLayout: The children of the new node you're creating.
  // @available(*, deprecated, message: "use 'replacingLayout(with:arena:)'")
  func replacingLayout(_ layout: [RawSyntax?]) -> RawSyntax {
    if isToken { return self }
    return self.replacingLayout(with: layout, arena: arena)
  }

  func insertingChild(
    _ newChild: RawSyntax?,
    at index: Int,
    arena: SyntaxArena
  ) -> RawSyntax {
    precondition(!self.isToken && self.children.count >= index)
    return .makeLayout(arena: arena,
                       kind: kind,
                       uninitializedCount: self.children.count + 1) { buffer in
      var childIterator = self.children.makeIterator()
      let base = buffer.baseAddress!
      for i in 0..<buffer.count {
        base.advanced(by: i)
          .initialize(to: i == index ? newChild : childIterator.next()!)
      }
    }
  }

  func removingChild(
    at index: Int,
    arena: SyntaxArena
  ) -> RawSyntax {
    precondition(self.children.count > index)
    let count = self.children.count - 1
    return .makeLayout(arena: arena,
                       kind: kind,
                       uninitializedCount: count) { buffer in
      if buffer.isEmpty { return }
      let newBase = buffer.baseAddress!
      let oldBase = children.baseAddress!

      // Copy elements up to the index.
      newBase.initialize(from: oldBase, count: index)

      // Copy elements from the index + 1.
      newBase.advanced(by: index)
        .initialize(from: oldBase.advanced(by: index + 1),
                    count: children.count - index - 1)
    }
  }

  func appending(_ newChild: RawSyntax?, arena: SyntaxArena) -> RawSyntax {
    self.insertingChild(newChild, at: children.count, arena: arena)
  }

  /// Creates a new RawSyntax with the provided child appended to its layout.
  /// - Parameter child: The child to append
  /// - Note: This function does nothing with `.token` nodes --- the same token
  ///         is returned.
  /// - Return: A new RawSyntax node with the provided child at the end.
  // @available(*, deprecated, message: "use 'appending(_:arena:)'")
  func appending(_ child: RawSyntax?) -> RawSyntax {
    if isToken { return self }
    return self.insertingChild(child, at: children.count, arena: arena)
  }

  /// Returns the child at the provided cursor in the layout.
  /// - Parameter index: The index of the child you're accessing.
  /// - Returns: The child at the provided index.
  subscript<CursorType: RawRepresentable>(_ index: CursorType) -> RawSyntax?
    where CursorType.RawValue == Int {
    return child(at: index.rawValue)
  }

  func replacingChildSubrange<C: Collection>(
    _ range: Range<Int>,
    with elements: C,
    arena: SyntaxArena
  ) -> RawSyntax where C.Element == RawSyntax? {
    let newCount = children.count - range.count + elements.count
    return .makeLayout(arena: arena,
                       kind: kind,
                       uninitializedCount: newCount) { buffer in
      if buffer.isEmpty { return }
      var current = buffer.baseAddress!

      // Intialize
      current.initialize(from: children.baseAddress!, count: range.lowerBound)
      current = current.advanced(by: range.lowerBound)
      for elem in elements {
        current.initialize(to: elem)
        current += 1
      }
      current.initialize(from: children.baseAddress!.advanced(by: range.upperBound),
                         count: children.count - range.upperBound)
    }
  }

  func replacingChild(
    at index: Int,
    with newChild: RawSyntax?,
    arena: SyntaxArena
  ) -> RawSyntax {
    precondition(!self.isToken && self.children.count > index)
    return .makeLayout(arena: arena,
                       kind: kind,
                       uninitializedCount: self.children.count) { buffer in
      _ = buffer.initialize(from: self.children)
      buffer[index] = newChild
    }
  }

  /// Replaces the child at the provided index in this node with the provided
  /// child.
  /// - Parameters:
  ///   - index: The index of the child to replace.
  ///   - newChild: The new child that should occupy that index in the node.
  // @available(*, deprecated, message: "use 'replacingChild(at:with:arena:)'")
  func replacingChild(_ index: Int,
                      with newChild: RawSyntax?) -> RawSyntax {
    if isToken { return self }
    return self.replacingChild(at: index, with: newChild, arena: .default)
  }
}

extension RawSyntax {
  func toOpaque() -> UnsafeRawPointer {
    UnsafeRawPointer(pointer)
  }

  static func fromOpaque(_ pointer: UnsafeRawPointer) -> RawSyntax {
    Self(pointer: pointer.assumingMemoryBound(to: RawSyntaxData.self))
  }
}

extension RawSyntax: TextOutputStreamable, CustomStringConvertible {
  /// Prints the RawSyntax node, and all of its children, to the provided
  /// stream. This implementation must be source-accurate.
  /// - Parameter stream: The stream on which to output this node.
  func write<Target: TextOutputStream>(to target: inout Target) {
    switch rawData.payload {
    case .materializedToken(let dat):
      for p in dat.leadingTrivia { p.write(to: &target) }
      String(syntaxText: dat.tokenText).write(to: &target)
      for p in dat.trailingTrivia { p.write(to: &target) }
      break
    case .layout(let dat):
      for case let child? in dat.layout {
        child.write(to: &target)
      }
      break
    }
  }

  /// A source-accurate description of this node.
  var description: String {
    var s = ""
    self.write(to: &s)
    return s
  }
}

extension RawSyntax {
  /// Return the first `present` token of a layout node or self if it is a token.
  func firstToken(viewMode: SyntaxTreeViewMode) -> RawSyntax? {
    guard viewMode.shouldTraverse(node: self) else { return nil }
    if isToken { return self }
    for child in children {
      if let token = child?.firstToken(viewMode: viewMode) {
        return token
      }
    }
    return nil
  }

  /// Return the last `present` token of a layout node or self if it is a token.
  func lastToken(viewMode: SyntaxTreeViewMode) -> RawSyntax? {
    guard viewMode.shouldTraverse(node: self) else { return nil }
    if isToken { return self }
    for child in children.reversed() {
      if let token = child?.lastToken(viewMode: viewMode) {
        return token
      }
    }
    return nil
  }

  func formLeadingTrivia() -> Trivia? {
    firstToken(viewMode: .sourceAccurate)?.formTokenLeadingTrivia()
  }

  func formTrailingTrivia() -> Trivia? {
    lastToken(viewMode: .sourceAccurate)?.formTokenTrailingTrivia()
  }
}

extension RawSyntax {
  var leadingTriviaByteLength: Int {
    firstToken(viewMode: .sourceAccurate)?.tokenLeadingTriviaByteLength ?? 0
  }

  var trailingTriviaByteLength: Int {
    lastToken(viewMode: .sourceAccurate)?.tokenTrailingTriviaByteLength ?? 0
  }

  var contentByteLength: Int {
    let result = byteLength - leadingTriviaByteLength - trailingTriviaByteLength
    assert(result >= 0)
    return result
  }

  var tokenTextByteLength: Int {
    switch rawData.payload {
    case .materializedToken(let dat):
      return dat.tokenText.count
    case .layout(_):
      preconditionFailure("'tokenTextByteLength' is not available for non-token node")
    }
  }

  var leadingTriviaLength: SourceLength {
    SourceLength(utf8Length: leadingTriviaByteLength)
  }

  var trailingTriviaLength: SourceLength {
    SourceLength(utf8Length: trailingTriviaByteLength)
  }

  /// The length of this node excluding its leading and trailing trivia.
  var contentLength: SourceLength {
    SourceLength(utf8Length: contentByteLength)
  }

  var tokenContentLength: SourceLength {
    SourceLength(utf8Length: tokenTextByteLength)
  }
}

private func makeRawTriviaPieces(arena: SyntaxArena, leadingTrivia: Trivia, trailingTrivia: Trivia) -> (pieces: RawTriviaPieceBuffer, byteLength: Int) {
  let totalTriviaCount = leadingTrivia.count + trailingTrivia.count

  if totalTriviaCount != 0 {
    var byteLength = 0
    let buffer = arena.allocateRawTriviaPieceBuffer(count: totalTriviaCount)
    var ptr = buffer.baseAddress!
    for piece in leadingTrivia + trailingTrivia {
      byteLength += piece.sourceLength.utf8Length
      ptr.initialize(to: .make(arena: arena, piece))
      ptr = ptr.advanced(by: 1)
    }
    return (pieces: .init(buffer), byteLength: byteLength)
  } else {

    return (pieces: .init(start: nil, count: 0), byteLength: 0)
  }
}

// MARK: - Factories.

extension RawSyntax {
  /// "Designated" factory method to create a materialized token node.
  ///
  /// This should not be called directly.
  /// Use `makeMaterializedToken(arena:kind:leadingTrivia:trailingTrivia:)` or
  /// `makeEmptyToken(arena:kind:)` instead.
  ///
  /// - Parameters:
  ///   - arena: SyntaxArea to the result node data resides.
  ///   - kind: Token kind.
  ///   - text: Token text.
  ///   - triviaPieces: Raw trivia pieces including leading and trailing trivia.
  ///   - numLeadingTrivia: Number of leading trivia pieces in `triviaPieces`.
  ///   - byteLength: Byte length of this token including trivia.
  internal static func materializedToken(
    arena: SyntaxArena,
    kind: RawTokenKind,
    text: SyntaxText,
    triviaPieces: RawTriviaPieceBuffer,
    numLeadingTrivia: UInt32,
    byteLength: UInt32
  ) -> RawSyntax {
    let payload = RawSyntaxData.MaterializedToken(
      tokenKind: kind, tokenText: text,
      triviaPieces: triviaPieces,
      numLeadingTrivia: numLeadingTrivia,
      byteLength: byteLength)
    return RawSyntax(arena: arena, payload: .materializedToken(payload))
  }

  /// Factory method to create a materialized token node.
  ///
  /// - Parameters:
  ///   - arena: SyntaxArea to the result node data resides.
  ///   - kind: Token kind.
  ///   - text: Token text.
  ///   - leadingTrivia: Leading trivia.
  ///   - trailingTrivia: Trailing trivia.
  static func makeMaterializedToken(
    arena: SyntaxArena,
    kind: TokenKind,
    leadingTrivia: Trivia,
    trailingTrivia: Trivia
  ) -> RawSyntax {
    let decomposed = kind.decomposeToRaw()
    let rawKind = decomposed.rawKind
    let text: SyntaxText = (decomposed.string.map({arena.intern($0)}) ??
                            decomposed.rawKind.defaultText ??
                            "")

    var byteLength = text.count

    let triviaPieces = makeRawTriviaPieces(
      arena: arena, leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)

    byteLength += triviaPieces.byteLength

    return .materializedToken(
      arena: arena, kind: rawKind, text: text,
      triviaPieces: triviaPieces.pieces,
      numLeadingTrivia: numericCast(leadingTrivia.count),
      byteLength: numericCast(byteLength))
  }

  static func makeEmptyToken(
    arena: SyntaxArena,
    kind: TokenKind
  ) -> RawSyntax {
    let (rawKind, _) = kind.decomposeToRaw()
    return .materializedToken(
      arena: arena, kind: rawKind, text: "",
      triviaPieces: .init(start: nil, count: 0),
      numLeadingTrivia: 0,
      byteLength: 0)
  }
}

extension RawSyntax {
  /// "Designated" factory method to create a layout node.
  ///
  /// This should not be called directly.
  /// Use `makeLayout(arena:kind:uninitializedCount:initializingWith:)` or
  /// `makeEmptyLayout(arena:kind:)` instead.
  ///
  /// - Parameters:
  ///   - arena: SyntaxArea to the result node data resides.
  ///   - kind: Syntax kind. This should not be `.token`.
  ///   - layout: Layout buffer of the children.
  ///   - byteLength: Computed total byte length of this node.
  ///   - descedantCount: Total number of the descendant nodes in `layout`.
  fileprivate static func layout(
    arena: SyntaxArena,
    kind: SyntaxKind,
    layout: RawSyntaxBuffer,
    byteLength: Int,
    descendantCount: Int
  ) -> RawSyntax {
    let payload = RawSyntaxData.Layout(
      kind: kind, layout: layout,
      byteLength: byteLength, descendantCount: descendantCount)
    return RawSyntax(arena: arena, payload: .layout(payload))
  }

  /// Factory method to create a layout node.
  ///
  /// - Parameters:
  ///   - arena: SyntaxArea to the result node data resides.
  ///   - kind: Syntax kind.
  ///   - count: Number of children.
  ///   - initializer: A closure that initializes elements.
  static func makeLayout(
    arena: SyntaxArena,
    kind: SyntaxKind,
    uninitializedCount count: Int,
    initializingWith initializer: (UnsafeMutableBufferPointer<RawSyntax?>) -> Void
  ) -> RawSyntax {
    // Allocate and initialize the list.
    let layoutBuffer = arena.allocateRawSyntaxBuffer(count: count)
    initializer(layoutBuffer)
    // validateLayout(layout: RawSyntaxBuffer(layoutBuffer), as: kind)

    // Calculate the "byte width".
    var byteLength = 0
    var descendantCount = 0
    for case let node? in layoutBuffer {
      byteLength += node.byteLength
      descendantCount += node.totalNodes
      arena.addChild(node.arenaReference)
    }
    return .layout(
      arena: arena, kind: kind, layout: RawSyntaxBuffer(layoutBuffer),
      byteLength: byteLength, descendantCount: descendantCount)
  }

  static func makeEmptyLayout(
    arena: SyntaxArena,
    kind: SyntaxKind
  ) -> RawSyntax {
    return .layout(
      arena: arena, kind: kind, layout: .init(start: nil, count: 0),
      byteLength: 0, descendantCount: 0)
  }

  static func makeLayout<C: Collection>(
    arena: SyntaxArena,
    kind: SyntaxKind,
    from collection: C
  ) -> RawSyntax where C.Element == RawSyntax? {
    .makeLayout(arena: arena, kind: kind, uninitializedCount: collection.count) {
      _ = $0.initialize(from: collection)
    }
  }
}

extension RawSyntax {
  /// Convenience function to create a RawSyntax when its byte length is not
  /// known in advance, e.g. it is programmatically constructed instead of
  /// created by the parser.
  ///
  /// This is a separate function than in the initializer to make it more
  /// explicit and visible in the code for the instances where we don't have
  /// the length of the raw node already available.
  // @available(*, deprecated, message: "use 'makeLayout()' with SyntaxArena")
  static func createAndCalcLength(kind: SyntaxKind, layout: [RawSyntax?],
      presence: SourcePresence) -> RawSyntax {
    .makeLayout(arena: .default, kind: kind, from: layout)
  }

  /// Convenience function to create a RawSyntax when its byte length is not
  /// known in advance, e.g. it is programmatically constructed instead of
  /// created by the parser.
  ///
  /// This is a separate function than in the initializer to make it more
  /// explicit and visible in the code for the instances where we don't have
  /// the length of the raw node already available.
  // @available(*, deprecated, message: "use 'makeMaterializedToken()' with SyntaxArena")
  static func createAndCalcLength(kind: TokenKind, leadingTrivia: Trivia,
      trailingTrivia: Trivia, presence: SourcePresence) -> RawSyntax {
    let arena = SyntaxArena.default

    // Translate 'TokenKind' to pure 'RawTokenKind'
    let (rawTokenKind, tokenString) = kind.decomposeToRaw()
    let tokenText: SyntaxText
    if presence == .missing {
      // If it's missing, the text should be empty.
      tokenText = SyntaxText()
    } else if tokenString != nil {
      // If the TokenKind had a text. Copy it to the arena and use it.
      tokenText = arena.intern(tokenString!)
    } else {
      // Otherwise, the token kind must have a default text.
      // i.e. keyword or panctuator
      tokenText = rawTokenKind.defaultText!
    }

    let triviaPieces = makeRawTriviaPieces(
      arena: arena, leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)

    return .materializedToken(
      arena: arena, kind: rawTokenKind, text: tokenText,
      triviaPieces: triviaPieces.pieces,
      numLeadingTrivia: numericCast(leadingTrivia.count),
      byteLength: numericCast(tokenText.count + triviaPieces.byteLength))
  }

  /// Create a layout node using the programmatic APIs.
  // @available(*, deprecated, message: "use 'makeLayout()' with SyntaxArena")
  static func create(
    kind: SyntaxKind,
    layout: [RawSyntax?],
    length: SourceLength,
    presence: SourcePresence
  ) -> RawSyntax {
    let raw = createAndCalcLength(kind: kind, layout: layout, presence: presence)
    assert(length.utf8Length == raw.totalLength.utf8Length)
    return raw
  }
}

// MARK: - Debugging.

extension RawSyntax: CustomDebugStringConvertible {

  private func debugWrite<Target: TextOutputStream>(to target: inout Target, indent: Int, withChildren: Bool = false) {
    let childIndent = indent + 2
    switch rawData.payload {
    case .materializedToken(let dat):
      target.write(".materializedToken(")
      target.write(String(describing: dat.tokenKind))
      target.write(" text=\(dat.tokenText.debugDescription)")
      target.write(" numLeadingTrivia=\(dat.numLeadingTrivia)")
      target.write(" byteLength=\(dat.byteLength)")
      break
    case .layout(let dat):
      target.write(".layout(")
      target.write(String(describing: kind))
      target.write(" byteLength=\(dat.byteLength)")
      target.write(" descendantCount=\(dat.descendantCount)")
      if withChildren {
        for (num, child) in dat.layout.enumerated() {
          target.write("\n")
          target.write(String(repeating: " ", count: childIndent))
          target.write("\(num): ")
          if let child = child {
            child.debugWrite(to: &target, indent: childIndent)
          } else {
            target.write("<nil>")
          }
        }
      }
      break
    }
    target.write(")")
  }

  var debugDescription: String {
    var string = ""
    debugWrite(to: &string, indent: 0, withChildren: false)
    return string
  }
}

extension RawSyntax: CustomReflectable {
  var customMirror: Mirror {
    let mirrorChildren: [Any] = children.map {
      child in child ?? (nil as Any?) as Any
    }
    return Mirror(self, unlabeledChildren: mirrorChildren)
  }
}
