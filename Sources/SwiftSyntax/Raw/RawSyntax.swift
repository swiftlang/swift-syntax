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

@_spi(RawSyntax) public typealias RawSyntaxBuffer = ArenaAllocatedBufferPointer<RawSyntax?>

typealias RawTriviaPieceBuffer = ArenaAllocatedBufferPointer<RawTriviaPiece>

fileprivate extension SyntaxKind {
  /// Whether this node kind should be considered as `hasError` for purposes of `RecursiveRawSyntaxFlags`.
  var hasError: Bool {
    return self == .unexpectedNodes || self.isMissing
  }
}

struct RecursiveRawSyntaxFlags: OptionSet, Sendable {
  let rawValue: UInt8

  /// Whether the tree contained by this layout has any
  ///  - missing nodes or
  ///  - unexpected nodes or
  ///  - tokens with a ``TokenDiagnostic`` of severity `error`
  static let hasError = RecursiveRawSyntaxFlags(rawValue: 1 << 0)
  /// Whether the tree contained by this layout has any tokens with a
  /// ``TokenDiagnostic`` of severity `warning`.
  static let hasWarning = RecursiveRawSyntaxFlags(rawValue: 1 << 1)
  static let hasSequenceExpr = RecursiveRawSyntaxFlags(rawValue: 1 << 2)
  static let hasMaximumNestingLevelOverflow = RecursiveRawSyntaxFlags(rawValue: 1 << 3)
}

/// Which shape a node's fields have, and the arena those fields live in.
///
/// One word wide: a class reference has spare bits, so the shape rides along
/// inside the reference rather than beside it. A node is this header followed by
/// the fields of whichever shape it names, so a node takes room for its own
/// shape instead of for the largest one.
enum RawSyntaxData: Sendable {
  /// A token that is present, carries no diagnostic, and whose text is short
  /// enough to measure in a byte, which is almost every token in a file.
  case smolParsedToken(RawSyntaxArenaRef)
  case parsedToken(RawSyntaxArenaRef)
  case materializedToken(RawSyntaxArenaRef)
  /// A node whose children lie one after another with no `unexpected` slots among
  /// them: every collection, and the layout kinds that opt out of interleaving.
  /// Its fields are a `Layout` followed by `childCount` slots, every one of which
  /// holds a child.
  case flat(RawSyntaxArenaRef)
  /// A layout node holding only its real children, which is every layout node that
  /// parsed with nothing unexpected in it. Its fields are a `Layout` followed by
  /// `childCount` slots.
  case layout(RawSyntaxArenaRef)
  /// A layout node with something in at least one of its `unexpected` slots, so it
  /// keeps them after its real children: a `Layout`, then `childCount` slots, then
  /// `childCount + 1` of them.
  case layoutWithUnexpected(RawSyntaxArenaRef)

  @inline(__always)
  var arenaReference: RawSyntaxArenaRef {
    switch self {
    case .smolParsedToken(let arenaRef), .parsedToken(let arenaRef),
      .materializedToken(let arenaRef), .flat(let arenaRef),
      .layout(let arenaRef), .layoutWithUnexpected(let arenaRef):
      return arenaRef
    }
  }

  /// The fields of a token whose presence, absent diagnostic and short text let
  /// four bytes say what twenty otherwise would.
  struct SmolParsedToken: Sendable {
    /// Byte count of this token's whole text, including leading and trailing trivia.
    var wholeTextLength: UInt8
    var textLowerBound: UInt8
    var textUpperBound: UInt8
    var tokenKind: RawTokenKind

    /// The largest text a token of this shape can hold.
    static let maximumTextLength = Int(UInt8.max)
  }

  /// Token with lazy trivia parsing.
  ///
  /// The RawSyntax's `arena` must have a valid trivia parsing function to
  /// lazily materialize the leading/trailing trivia pieces.
  struct ParsedToken: Sendable {
    /// Byte count of this token's whole text, including leading and trailing trivia.
    var wholeTextLength: UInt32
    var textLowerBound: UInt32
    var textUpperBound: UInt32
    var tokenDiagnostic: TokenDiagnostic?
    var tokenKind: RawTokenKind
    var presence: SourcePresence
  }

  /// Token typically created with `TokenSyntax.<someToken>`.
  struct MaterializedToken: Sendable {
    var tokenKind: RawTokenKind
    var tokenText: SyntaxText
    var triviaPieces: RawTriviaPieceBuffer
    var numLeadingTrivia: UInt32
    var byteLength: UInt32
    var presence: SourcePresence
    var tokenDiagnostic: TokenDiagnostic?
  }

  /// The fields of a layout node or a collection, followed in the node's tail by
  /// the slots holding its children.
  struct Layout: Sendable {
    /// Number of real children, which is every slot for a collection and for a
    /// layout kind that does not interleave.
    var childCount: UInt32

    /// Byte count of this subtree's text, which 32 bits hold because a tree cannot
    /// be larger: `AbsoluteSyntaxInfo` tracks a node's offset in 32 bits and
    /// `Syntax.forRoot` refuses anything longer. Widening this to an `Int` costs 8
    /// bytes of stride on every layout node — 11.8% of the memory a parse takes —
    /// and lifts no limit.
    var byteLength: UInt32

    /// Number of nodes in this subtree, excluding this node.
    var descendantCount: UInt32

    var kind: SyntaxKind
    var recursiveFlags: RecursiveRawSyntaxFlags
  }
}

/// The fields a node keeps at the start of its tail, immediately past its header.
protocol RawSyntaxDataFields: Sendable {
  /// Traps unless `header` names a node whose tail starts with these fields.
  ///
  /// A `switch` that traps rather than a `Bool`: once this is inlined where the
  /// header's case is already known, the optimizer removes a `switch` but not a
  /// test of the `Bool` one would return.
  static func requireShape(of header: RawSyntaxData)
}

extension RawSyntaxData.SmolParsedToken: RawSyntaxDataFields {
  @inline(__always)
  static func requireShape(of header: RawSyntaxData) {
    switch header {
    case .smolParsedToken: return
    default: preconditionFailure("not a short parsed token")
    }
  }
}

extension RawSyntaxData.ParsedToken: RawSyntaxDataFields {
  @inline(__always)
  static func requireShape(of header: RawSyntaxData) {
    switch header {
    case .parsedToken: return
    default: preconditionFailure("not a parsed token")
    }
  }
}

extension RawSyntaxData.MaterializedToken: RawSyntaxDataFields {
  @inline(__always)
  static func requireShape(of header: RawSyntaxData) {
    switch header {
    case .materializedToken: return
    default: preconditionFailure("not a materialized token")
    }
  }
}

extension RawSyntaxData.Layout: RawSyntaxDataFields {
  @inline(__always)
  static func requireShape(of header: RawSyntaxData) {
    switch header {
    case .flat, .layout, .layoutWithUnexpected: return
    default: preconditionFailure("not a layout node")
    }
  }
}

extension RawSyntaxData.SmolParsedToken {
  /// A short parsed token's fields in a node's tail, and the text laid out after
  /// them.
  ///
  /// - Important: The arena that owns the node must outlive this.
  struct Ref: Sendable {
    typealias Fields = RawSyntaxData.SmolParsedToken

    private let pointer: ArenaAllocatedPointer<Fields>

    @inline(__always)
    init(_ pointer: UnsafePointer<Fields>) {
      self.pointer = ArenaAllocatedPointer(pointer)
    }

    @inline(__always)
    var tokenKind: RawTokenKind { pointer.pointee.tokenKind }
    @inline(__always)
    var wholeTextLength: UInt8 { pointer.pointee.wholeTextLength }
    /// Range of the token's own text within `wholeText`.
    @inline(__always)
    var textRange: Range<SyntaxText.Index> {
      Int(pointer.pointee.textLowerBound)..<Int(pointer.pointee.textUpperBound)
    }

    /// Where this token's text begins, a fixed offset past its fields.
    @inline(__always)
    private var textBase: UnsafePointer<UInt8> {
      UnsafeRawPointer(pointer.pointer)
        .advanced(by: MemoryLayout<Fields>.stride)
        .assumingMemoryBound(to: UInt8.self)
    }

    @inline(__always)
    var wholeText: SyntaxText {
      SyntaxText(baseAddress: self.textBase, count: Int(self.wholeTextLength))
    }
    /// The token's own text, without its trivia.
    @inline(__always)
    var tokenText: SyntaxText {
      SyntaxText(rebasing: self.wholeText[self.textRange])
    }
    @inline(__always)
    var leadingTriviaText: SyntaxText {
      SyntaxText(rebasing: self.wholeText[..<self.textRange.lowerBound])
    }
    @inline(__always)
    var trailingTriviaText: SyntaxText {
      SyntaxText(rebasing: self.wholeText[self.textRange.upperBound...])
    }
  }
}

extension RawSyntaxData.ParsedToken {
  /// A parsed token's fields in a node's tail, and the text laid out after them.
  ///
  /// - Important: The arena that owns the node must outlive this.
  struct Ref: Sendable {
    typealias Fields = RawSyntaxData.ParsedToken

    private let pointer: ArenaAllocatedPointer<Fields>

    @inline(__always)
    init(_ pointer: UnsafePointer<Fields>) {
      self.pointer = ArenaAllocatedPointer(pointer)
    }

    /// The fields themselves, to make a token that differs from this one in a
    /// field or two.
    @inline(__always)
    var fields: Fields { pointer.pointee }

    @inline(__always)
    var tokenKind: RawTokenKind { pointer.pointee.tokenKind }
    @inline(__always)
    var wholeTextLength: UInt32 { pointer.pointee.wholeTextLength }
    /// Range of the token's own text within `wholeText`: what precedes it is
    /// leading trivia and what follows it is trailing.
    @inline(__always)
    var textRange: Range<SyntaxText.Index> {
      Int(pointer.pointee.textLowerBound)..<Int(pointer.pointee.textUpperBound)
    }
    @inline(__always)
    var presence: SourcePresence { pointer.pointee.presence }
    @inline(__always)
    var tokenDiagnostic: TokenDiagnostic? { pointer.pointee.tokenDiagnostic }

    /// Where this token's text begins, a fixed offset past its fields.
    @inline(__always)
    private var textBase: UnsafePointer<UInt8> {
      UnsafeRawPointer(pointer.pointer)
        .advanced(by: MemoryLayout<Fields>.stride)
        .assumingMemoryBound(to: UInt8.self)
    }

    @inline(__always)
    var wholeText: SyntaxText {
      SyntaxText(baseAddress: self.textBase, count: Int(self.wholeTextLength))
    }
    /// The token's own text, without its trivia.
    @inline(__always)
    var tokenText: SyntaxText {
      SyntaxText(rebasing: self.wholeText[self.textRange])
    }
    @inline(__always)
    var leadingTriviaText: SyntaxText {
      SyntaxText(rebasing: self.wholeText[..<self.textRange.lowerBound])
    }
    @inline(__always)
    var trailingTriviaText: SyntaxText {
      SyntaxText(rebasing: self.wholeText[self.textRange.upperBound...])
    }
  }
}

extension RawSyntaxData.MaterializedToken {
  /// A materialized token's fields in a node's tail.
  ///
  /// - Important: The arena that owns the node must outlive this.
  struct Ref: Sendable {
    typealias Fields = RawSyntaxData.MaterializedToken

    private let pointer: ArenaAllocatedPointer<Fields>

    @inline(__always)
    init(_ pointer: UnsafePointer<Fields>) {
      self.pointer = ArenaAllocatedPointer(pointer)
    }

    /// The fields themselves, to make a token that differs from this one in a
    /// field or two.
    @inline(__always)
    var fields: Fields { pointer.pointee }

    @inline(__always)
    var tokenKind: RawTokenKind { pointer.pointee.tokenKind }
    @inline(__always)
    var tokenText: SyntaxText { pointer.pointee.tokenText }
    @inline(__always)
    var byteLength: UInt32 { pointer.pointee.byteLength }
    @inline(__always)
    var numLeadingTrivia: UInt32 { pointer.pointee.numLeadingTrivia }
    @inline(__always)
    var triviaPieces: RawTriviaPieceBuffer { pointer.pointee.triviaPieces }
    @inline(__always)
    var presence: SourcePresence { pointer.pointee.presence }
    @inline(__always)
    var tokenDiagnostic: TokenDiagnostic? { pointer.pointee.tokenDiagnostic }

    @inline(__always)
    var leadingTrivia: RawTriviaPieceBuffer {
      RawTriviaPieceBuffer(rebasing: self.triviaPieces[..<Int(self.numLeadingTrivia)])
    }
    @inline(__always)
    var trailingTrivia: RawTriviaPieceBuffer {
      RawTriviaPieceBuffer(rebasing: self.triviaPieces[Int(self.numLeadingTrivia)...])
    }
  }
}

extension RawSyntaxData.Layout {
  /// A layout node's fields in a node's tail, and the slots laid out after them.
  ///
  /// - Important: The arena that owns the node must outlive this.
  struct Ref: Sendable {
    typealias Fields = RawSyntaxData.Layout

    private let pointer: ArenaAllocatedPointer<Fields>

    @inline(__always)
    init(_ pointer: UnsafePointer<Fields>) {
      self.pointer = ArenaAllocatedPointer(pointer)
    }

    @inline(__always)
    var kind: SyntaxKind { pointer.pointee.kind }
    @inline(__always)
    var childCount: UInt32 { pointer.pointee.childCount }
    @inline(__always)
    var byteLength: UInt32 { pointer.pointee.byteLength }
    @inline(__always)
    var descendantCount: UInt32 { pointer.pointee.descendantCount }
    @inline(__always)
    var recursiveFlags: RecursiveRawSyntaxFlags { pointer.pointee.recursiveFlags }

    /// Where this node's slots begin, a fixed offset past its fields.
    @inline(__always)
    var slotBase: UnsafePointer<RawSyntax?> {
      UnsafeRawPointer(pointer.pointer)
        .advanced(by: MemoryLayout<Fields>.stride)
        .assumingMemoryBound(to: RawSyntax?.self)
    }
  }
}

/// Represents the raw tree structure underlying the syntax tree. These nodes
/// have no notion of identity and only provide structure to the tree. They
/// are immutable and can be freely shared between syntax nodes.
@_spi(RawSyntax)
public struct RawSyntax: Sendable {

  /// Pointer to the node, which resides in a RawSyntaxArena: a one-word header
  /// followed by the fields of the shape it names.
  var pointer: ArenaAllocatedPointer<RawSyntaxData>
  init(pointer: ArenaAllocatedPointer<RawSyntaxData>) {
    self.pointer = pointer
  }

  /// Where a node's tail begins: immediately past its one-word header.
  @inline(__always)
  static var tailOffset: Int { MemoryLayout<RawSyntaxData>.stride }

  @inline(__always)
  private var tail: UnsafeRawPointer {
    UnsafeRawPointer(pointer.pointer).advanced(by: Self.tailOffset)
  }

  /// Allocates a node, writes its header, and binds the fields at the start of its
  /// tail without writing them, for a caller that knows them only once the rest of
  /// the tail is written. Hands back the node, its fields, and where the tail
  /// continues past them, for `trailingByteCount` more bytes.
  ///
  /// A node is aligned only to ``RawSyntaxArena/nodeAlignment``, and its fields
  /// begin at ``tailOffset``, so both the header and `Fields` have to fit that.
  @inline(__always)
  private static func allocate<Fields: RawSyntaxDataFields>(
    _ header: RawSyntaxData,
    binding fields: Fields.Type,
    trailingByteCount: Int = 0,
    arena: __shared RawSyntaxArena
  ) -> (node: RawSyntax, fields: UnsafeMutablePointer<Fields>, trailing: UnsafeMutableRawPointer) {
    Fields.requireShape(of: header)
    assert(
      MemoryLayout<RawSyntaxData>.alignment <= RawSyntaxArena.nodeAlignment,
      "a node's header needs more alignment than a node has"
    )
    assert(
      MemoryLayout<Fields>.alignment <= RawSyntaxArena.nodeAlignment
        && Self.tailOffset.isMultiple(of: MemoryLayout<Fields>.alignment),
      "\(Fields.self) needs more alignment than a node's tail has"
    )
    let fieldsSize = MemoryLayout<Fields>.stride
    let base = arena.allocateNode(byteCount: Self.tailOffset + fieldsSize + trailingByteCount)
    let headerPointer = base.bindMemory(to: RawSyntaxData.self, capacity: 1)
    headerPointer.initialize(to: header)
    let tail = base.advanced(by: Self.tailOffset)
    return (
      RawSyntax(pointer: ArenaAllocatedPointer(UnsafePointer(headerPointer))),
      tail.bindMemory(to: Fields.self, capacity: 1),
      tail.advanced(by: fieldsSize)
    )
  }

  /// Allocates a node, writes its header and `fields` at the start of its tail, and
  /// hands back the node together with where the tail continues past them, for
  /// `trailingByteCount` more bytes.
  @inline(__always)
  private static func allocate<Fields: RawSyntaxDataFields>(
    _ header: RawSyntaxData,
    _ fields: Fields,
    trailingByteCount: Int = 0,
    arena: __shared RawSyntaxArena
  ) -> (node: RawSyntax, trailing: UnsafeMutableRawPointer) {
    let (node, pointer, trailing) = Self.allocate(
      header,
      binding: Fields.self,
      trailingByteCount: trailingByteCount,
      arena: arena
    )
    pointer.initialize(to: fields)
    return (node, trailing)
  }

  /// Which of the three shapes this node has, and the arena that owns it.
  @inline(__always)
  var header: RawSyntaxData {
    pointer.pointer.pointee
  }

  /// The fields at the start of this node's tail.
  ///
  /// - Precondition: this node's header names a shape whose tail holds `Fields`.
  @inline(__always)
  private func fields<Fields: RawSyntaxDataFields>(as fields: Fields.Type) -> UnsafePointer<Fields> {
    Fields.requireShape(of: self.header)
    return tail.assumingMemoryBound(to: Fields.self)
  }

  /// - Precondition: this is a short parsed token.
  @inline(__always)
  var asSmolParsedToken: RawSyntaxData.SmolParsedToken.Ref {
    RawSyntaxData.SmolParsedToken.Ref(fields(as: RawSyntaxData.SmolParsedToken.self))
  }

  /// - Precondition: this is a parsed token.
  @inline(__always)
  var asParsedToken: RawSyntaxData.ParsedToken.Ref {
    RawSyntaxData.ParsedToken.Ref(fields(as: RawSyntaxData.ParsedToken.self))
  }

  /// - Precondition: this is a materialized token.
  @inline(__always)
  var asMaterializedToken: RawSyntaxData.MaterializedToken.Ref {
    RawSyntaxData.MaterializedToken.Ref(fields(as: RawSyntaxData.MaterializedToken.self))
  }

  /// - Precondition: this is a layout node or a collection.
  @inline(__always)
  var asLayout: RawSyntaxData.Layout.Ref {
    RawSyntaxData.Layout.Ref(fields(as: RawSyntaxData.Layout.self))
  }

  /// Calls `body` with each child this node holds, in source order.
  ///
  /// The same order as ``logicalChildren``, without the positions a node kept no
  /// room for: that collection reports two per child for a kind that interleaves,
  /// and answering each costs a bounds check, a branch and a division, where almost
  /// every node has nothing in its `unexpected` slots at all.
  ///
  /// - Precondition: this is a layout node or a collection.
  @inline(__always)
  func forEachChildInSourceOrder(_ body: (RawSyntax) throws -> Void) rethrows {
    let layout = self.asLayout
    let childCount = Int(layout.childCount)
    switch self.header {
    case .flat, .layout:
      // Every slot is a real child; a kind that interleaves keeps room for its
      // `unexpected` slots only when one of them is occupied.
      for case let child? in UnsafeBufferPointer(start: layout.slotBase, count: childCount) {
        try body(child)
      }
    case .layoutWithUnexpected:
      // Real children first, then the `unexpected` slots. Source order interleaves
      // them: a slot before each child, and one after the last.
      let real = layout.slotBase
      let unexpected = real + childCount
      for index in 0..<childCount {
        if let node = unexpected[index] { try body(node) }
        if let node = real[index] { try body(node) }
      }
      if let node = unexpected[childCount] { try body(node) }
    case .smolParsedToken, .parsedToken, .materializedToken:
      preconditionFailure("not a layout node")
    }
  }

  /// This node's children as the tree describes them, which for a node that kept no
  /// room for its `unexpected` slots means reading those as nil.
  ///
  /// - Precondition: this is a layout node or a collection.
  var logicalChildren: RawLayoutChildren {
    let layout = self.asLayout
    let childCount = Int(layout.childCount)
    let start = layout.slotBase
    let unexpected: UnsafeBufferPointer<RawSyntax?>
    let interleaves: Bool
    switch self.header {
    case .layoutWithUnexpected:
      unexpected = UnsafeBufferPointer(start: start + childCount, count: childCount + 1)
      interleaves = true
    case .layout:
      unexpected = UnsafeBufferPointer(start: nil, count: 0)
      interleaves = true
    case .flat:
      unexpected = UnsafeBufferPointer(start: nil, count: 0)
      interleaves = false
    case .smolParsedToken, .parsedToken, .materializedToken:
      preconditionFailure("not a layout node")
    }
    return RawLayoutChildren(
      real: UnsafeBufferPointer(start: start, count: childCount),
      unexpected: unexpected,
      interleaves: interleaves
    )
  }

  public var arena: RetainedRawSyntaxArena {
    arenaReference.retained
  }

  internal var arenaReference: RawSyntaxArenaRef {
    header.arenaReference
  }
}

// MARK: - Accessors

extension RawSyntax {
  /// The syntax kind of this raw syntax.
  @_spi(RawSyntax)
  public var kind: SyntaxKind {
    switch header {
    case .smolParsedToken, .parsedToken, .materializedToken: return .token
    case .flat, .layout, .layoutWithUnexpected: return asLayout.kind
    }
  }

  /// Whether or not this node is a token one.
  @_spi(RawSyntax)
  public var isToken: Bool {
    kind == .token
  }

  var recursiveFlags: RecursiveRawSyntaxFlags {
    switch view {
    case .token(let tokenView):
      var recursiveFlags: RecursiveRawSyntaxFlags = []
      if tokenView.presence == .missing {
        recursiveFlags.insert(.hasError)
      }
      switch tokenView.tokenDiagnostic?.severity {
      case .error:
        recursiveFlags.insert(.hasError)
      case .warning:
        recursiveFlags.insert(.hasWarning)
      case nil:
        break
      }
      return recursiveFlags
    case .layout(let layoutView):
      return layoutView.recursiveFlags
    }
  }

  /// ``totalNodes`` and ``byteLength`` as they are stored, for
  /// ``makeLayout(kind:childCount:storage:isMaximumNestingLevelOverflow:arena:initializingWith:)``,
  /// which sums both over every child of every node it builds — 300,000 times in
  /// parsing the performance test's declaration-heavy input. Going through the `Int`
  /// forms converts on each one.
  var totalNodes32: UInt32 {
    switch header {
    case .smolParsedToken, .parsedToken, .materializedToken:
      return 1
    case .flat, .layout, .layoutWithUnexpected:
      return asLayout.descendantCount + 1
    }
  }

  var byteLength32: UInt32 {
    switch header {
    case .smolParsedToken:
      // Present by construction, so nothing to test.
      return UInt32(asSmolParsedToken.wholeTextLength)
    case .parsedToken:
      let token = asParsedToken
      return token.presence == .present ? token.wholeTextLength : 0
    case .materializedToken:
      let token = asMaterializedToken
      return token.presence == .present ? token.byteLength : 0
    case .flat, .layout, .layoutWithUnexpected:
      return asLayout.byteLength
    }
  }

  /// Total number of nodes in this sub-tree, including `self` node.
  var totalNodes: Int {
    switch header {
    case .smolParsedToken, .parsedToken, .materializedToken:
      return 1
    case .flat, .layout, .layoutWithUnexpected:
      return Int(asLayout.descendantCount) + 1
    }
  }

  /// The "width" of the node.
  ///
  /// Sum of text byte lengths of all present descendant token nodes.
  @_spi(RawSyntax)
  public var byteLength: Int {
    switch header {
    case .smolParsedToken:
      // Present by construction, so nothing to test.
      return Int(asSmolParsedToken.wholeTextLength)
    case .parsedToken:
      if asParsedToken.presence == .present {
        return Int(asParsedToken.wholeTextLength)
      } else {
        return 0
      }
    case .materializedToken:
      if asMaterializedToken.presence == .present {
        return Int(asMaterializedToken.byteLength)
      } else {
        return 0
      }
    case .flat, .layout, .layoutWithUnexpected:
      return Int(asLayout.byteLength)
    }
  }

  var totalLength: SourceLength {
    SourceLength(utf8Length: byteLength)
  }

  /// Replaces the leading trivia of the first token in this syntax tree by `leadingTrivia`.
  /// If the syntax tree did not contain a token and thus no trivia could be attached to it, `nil` is returned.
  /// - Parameters:
  ///   - leadingTrivia: The trivia to attach.
  ///   - arena: RawSyntaxArena to the result node data resides.
  @_spi(RawSyntax)
  public func withLeadingTrivia(_ leadingTrivia: Trivia, arena: RawSyntaxArena) -> RawSyntax? {
    switch view {
    case .token(let tokenView):
      return .makeMaterializedToken(
        kind: tokenView.formKind(),
        leadingTrivia: leadingTrivia,
        trailingTrivia: tokenView.formTrailingTrivia(),
        presence: tokenView.presence,
        tokenDiagnostic: tokenView.tokenDiagnostic,
        arena: arena
      )
    case .layout(let layoutView):
      for (index, child) in layoutView.children.enumerated() {
        if let replaced = child?.withLeadingTrivia(leadingTrivia, arena: arena) {
          return layoutView.replacingChild(at: index, with: replaced, arena: arena)
        }
      }
      return nil
    }
  }

  /// Replaces the trailing trivia of the last token in this syntax tree by `trailingTrivia`.
  /// If the syntax tree did not contain a token and thus no trivia could be attached to it, `nil` is returned.
  /// - Parameters:
  ///   - trailingTrivia: The trivia to attach.
  ///   - arena: RawSyntaxArena to the result node data resides.
  @_spi(RawSyntax)
  public func withTrailingTrivia(_ trailingTrivia: Trivia, arena: RawSyntaxArena) -> RawSyntax? {
    switch view {
    case .token(let tokenView):
      return .makeMaterializedToken(
        kind: tokenView.formKind(),
        leadingTrivia: tokenView.formLeadingTrivia(),
        trailingTrivia: trailingTrivia,
        presence: tokenView.presence,
        tokenDiagnostic: tokenView.tokenDiagnostic,
        arena: arena
      )
    case .layout(let layoutView):
      for (index, child) in layoutView.children.enumerated().reversed() {
        if let replaced = child?.withTrailingTrivia(trailingTrivia, arena: arena) {
          return layoutView.replacingChild(at: index, with: replaced, arena: arena)
        }
      }
      return nil
    }
  }
}

extension RawTriviaPiece {
  /// Call `body` with the syntax text of this trivia piece.
  ///
  /// - Important: A piece that stores no text is described into a temporary, so the
  ///   text is only valid within the call.
  func withSyntaxText(body: (SyntaxText) throws -> Void) rethrows {
    if let syntaxText = storedText {
      try body(syntaxText)
      return
    }

    var description = ""
    write(to: &description)
    try description.withUTF8 { buffer in
      try body(SyntaxText(baseAddress: buffer.baseAddress, count: buffer.count))
    }
  }
}

extension RawSyntax {
  /// Retrieve the syntax text as an array of bytes that models the input
  /// source even in the presence of invalid UTF-8.
  ///
  /// The result is exactly ``byteLength`` bytes, so it is allocated once rather than
  /// grown, and a parsed token's text is copied a whole unit at a time — which is
  /// safe only where `copyText` wrote it into room rounded up for it, so the walk
  /// below has to know which shape it is reading.
  public var syntaxTextBytes: [UInt8] {
    let total = self.byteLength
    // `copyText` may write up to seven bytes past a token's text, so the destination
    // carries the same slack the node's tail does. Those bytes stay outside the
    // array's count.
    return [UInt8](unsafeUninitializedCapacity: total + 7) { buffer, initialized in
      var written = 0
      self.writeSyntaxTextBytes(to: buffer.baseAddress!, at: &written)
      assert(written == total, "a node's byte length must be the text it holds")
      initialized = total
    }
  }

  /// Writes this node's syntax text into `destination`, advancing `written` by what
  /// it wrote.
  private func writeSyntaxTextBytes(to destination: UnsafeMutablePointer<UInt8>, at written: inout Int) {
    /// Text a node's tail holds, which `copyText` padded to a whole unit.
    func padded(_ text: SyntaxText) {
      Self.copyText(
        text,
        to: UnsafeMutableRawPointer(destination + written),
        sourceBufferEnd: text.baseAddress.map { $0 + Self.textByteCount(for: text.count) }
      )
      written += text.count
    }
    /// Text the arena interned or a trivia piece described, which has no slack.
    func exact(_ text: SyntaxText) {
      if let base = text.baseAddress, !text.isEmpty {
        UnsafeMutableRawPointer(destination + written).copyMemory(from: base, byteCount: text.count)
      }
      written += text.count
    }

    switch header {
    case .smolParsedToken:
      // Present by construction.
      padded(asSmolParsedToken.wholeText)
    case .parsedToken:
      if asParsedToken.presence == .present {
        padded(asParsedToken.wholeText)
      }
    case .materializedToken:
      if asMaterializedToken.presence == .present {
        for piece in asMaterializedToken.leadingTrivia {
          piece.withSyntaxText { exact($0) }
        }
        exact(asMaterializedToken.tokenText)
        for piece in asMaterializedToken.trailingTrivia {
          piece.withSyntaxText { exact($0) }
        }
      }
    case .flat, .layout, .layoutWithUnexpected:
      var offset = written
      self.forEachChildInSourceOrder { child in
        child.writeSyntaxTextBytes(to: destination, at: &offset)
      }
      written = offset
    }
  }
}

extension RawSyntax: TextOutputStreamable, CustomStringConvertible {
  /// Prints the RawSyntax node, and all of its children, to the provided
  /// stream. This implementation must be source-accurate.
  /// - Parameter stream: The stream on which to output this node.
  public func write<Target: TextOutputStream>(to target: inout Target) {
    switch header {
    case .smolParsedToken:
      // Present by construction.
      String(syntaxText: asSmolParsedToken.wholeText).write(to: &target)
    case .parsedToken:
      if asParsedToken.presence == .present {
        String(syntaxText: asParsedToken.wholeText).write(to: &target)
      }
    case .materializedToken:
      if asMaterializedToken.presence == .present {
        for p in asMaterializedToken.leadingTrivia { p.write(to: &target) }
        String(syntaxText: asMaterializedToken.tokenText).write(to: &target)
        for p in asMaterializedToken.trailingTrivia { p.write(to: &target) }
      }
    case .flat, .layout, .layoutWithUnexpected:
      self.forEachChildInSourceOrder { $0.write(to: &target) }
    }
  }

  /// A source-accurate description of this node.
  public var description: String {
    var s = ""
    self.write(to: &s)
    return s
  }
}

extension RawSyntax {
  /// Return the first token of a layout node that should be traversed by `viewMode`.
  func firstToken(viewMode: SyntaxTreeViewMode) -> RawSyntaxTokenView? {
    guard viewMode.shouldTraverse(node: self) else { return nil }
    switch view {
    case .token(let tokenView):
      return tokenView
    case .layout(let layoutView):
      for child in layoutView.children {
        if let token = child?.firstToken(viewMode: viewMode) {
          return token
        }
      }
      return nil
    }
  }

  /// Return the last token of a layout node that should be traversed by `viewMode`.
  func lastToken(viewMode: SyntaxTreeViewMode) -> RawSyntaxTokenView? {
    guard viewMode.shouldTraverse(node: self) else { return nil }
    switch view {
    case .token(let tokenView):
      return tokenView
    case .layout(let layoutView):
      for child in layoutView.children.reversed() {
        if let token = child?.lastToken(viewMode: viewMode) {
          return token
        }
      }
      return nil
    }
  }

  func formLeadingTrivia() -> Trivia {
    firstToken(viewMode: .sourceAccurate)?.formLeadingTrivia() ?? []
  }

  func formTrailingTrivia() -> Trivia {
    lastToken(viewMode: .sourceAccurate)?.formTrailingTrivia() ?? []
  }
}

extension RawSyntax {
  @_spi(RawSyntax)
  public var leadingTriviaByteLength: Int {
    firstToken(viewMode: .sourceAccurate)?.leadingTriviaByteLength ?? 0
  }

  @_spi(RawSyntax)
  public var trailingTriviaByteLength: Int {
    lastToken(viewMode: .sourceAccurate)?.trailingTriviaByteLength ?? 0
  }

  @_spi(RawSyntax)
  public var leadingTriviaPieces: [RawTriviaPiece]? {
    firstToken(viewMode: .sourceAccurate)?.leadingRawTriviaPieces
  }

  @_spi(RawSyntax)
  public var trailingTriviaPieces: [RawTriviaPiece]? {
    lastToken(viewMode: .sourceAccurate)?.trailingRawTriviaPieces
  }

  /// The length of this node’s content, without the first leading and the last
  /// trailing trivia. Intermediate trivia inside a layout node is included in
  /// this.
  var trimmedByteLength: Int {
    let result = byteLength - leadingTriviaByteLength - trailingTriviaByteLength
    precondition(result >= 0)
    return result
  }

  var leadingTriviaLength: SourceLength {
    SourceLength(utf8Length: leadingTriviaByteLength)
  }

  var trailingTriviaLength: SourceLength {
    SourceLength(utf8Length: trailingTriviaByteLength)
  }

  /// The length of this node excluding its leading and trailing trivia.
  var trimmedLength: SourceLength {
    SourceLength(utf8Length: trimmedByteLength)
  }
}

// MARK: - Factories.

extension RawSyntax {
  /// Makes a parsed token from what the lexer already holds: the buffer it is
  /// reading, positioned at the token, and the token's byte lengths.
  ///
  /// Taking those rather than a `SyntaxText` and a `Range` means neither is built
  /// only to be taken apart again here, and the buffer answers both where the text
  /// is and how far ``copyText`` may read past it.
  ///
  /// The whole text is copied into the node, so the tree does not depend on the
  /// buffer outliving the parse.
  ///
  /// - Parameters:
  ///   - kind: Token kind.
  ///   - sourceBuffer: The buffer being lexed, positioned at the first byte of this
  ///     token's whole text.
  ///   - leadingTriviaByteLength: Bytes of leading trivia before the token's text.
  ///   - textByteLength: Bytes of the token's own text.
  ///   - wholeTextLength: Bytes of the whole text, both trivia included.
  ///   - presence: Whether the token appeared in the source or was synthesized.
  ///   - tokenDiagnostic: The diagnostic to carry, if the token has one.
  ///   - arena: RawSyntaxArena in which the node is allocated.
  internal static func parsedToken(
    kind: RawTokenKind,
    sourceBuffer: UnsafeBufferPointer<UInt8>,
    leadingTriviaByteLength: Int,
    textByteLength: Int,
    wholeTextLength: Int,
    presence: SourcePresence,
    tokenDiagnostic: TokenDiagnostic?,
    arena: __shared ParsingRawSyntaxArena
  ) -> RawSyntax {
    let wholeText = SyntaxText(baseAddress: sourceBuffer.baseAddress, count: wholeTextLength)
    // `&+` because these are byte counts within one token, taken from the lexer,
    // and cannot overflow: the check is a branch per token on a sum bounded by the
    // size of the source.
    let textRange = leadingTriviaByteLength..<(leadingTriviaByteLength &+ textByteLength)
    let sourceBufferEnd = sourceBuffer.baseAddress.map { $0 + sourceBuffer.count }
    precondition(
      kind != .keyword || Keyword(SyntaxText(rebasing: wholeText[textRange])) != nil,
      "If kind is keyword, the text must be a known token kind"
    )
    // Four bytes of fields rather than twenty, where the shape of the node can
    // imply the presence and the absent diagnostic, and a byte can hold each
    // length. `textRange` is 0-based within the whole text, so the copy does not
    // disturb it.
    if presence == .present, tokenDiagnostic == nil,
      wholeText.count <= RawSyntaxData.SmolParsedToken.maximumTextLength
    {
      return Self.allocateParsedToken(
        .smolParsedToken(RawSyntaxArenaRef(arena)),
        RawSyntaxData.SmolParsedToken(
          wholeTextLength: UInt8(wholeText.count),
          textLowerBound: UInt8(textRange.lowerBound),
          textUpperBound: UInt8(textRange.upperBound),
          tokenKind: kind
        ),
        wholeText: wholeText,
        sourceBufferEnd: sourceBufferEnd,
        arena: arena
      )
    }

    return Self.allocateParsedToken(
      .parsedToken(RawSyntaxArenaRef(arena)),
      RawSyntaxData.ParsedToken(
        wholeTextLength: UInt32(wholeText.count),
        textLowerBound: UInt32(textRange.lowerBound),
        textUpperBound: UInt32(textRange.upperBound),
        tokenDiagnostic: tokenDiagnostic,
        tokenKind: kind,
        presence: presence
      ),
      wholeText: wholeText,
      sourceBufferEnd: sourceBufferEnd,
      arena: arena
    )
  }

  /// Allocates a parsed token, in either of its two shapes: `header` names which,
  /// `fields` are that shape's, and the token's whole text follows them in the
  /// tail.
  ///
  /// The text is rounded up to a whole unit: it is the last thing in the node, the
  /// next node is word aligned anyway, and it lets the copy write whole units.
  ///
  /// - Important: A raw syntax node for a parsed token must always be allocated
  ///   in a `ParsingRawSyntaxArena` so we can parse the trivia in the token.
  static func allocateParsedToken<Fields: RawSyntaxDataFields>(
    _ header: RawSyntaxData,
    _ fields: Fields,
    wholeText: SyntaxText,
    sourceBufferEnd: UnsafePointer<UInt8>? = nil,
    arena: __shared RawSyntaxArena
  ) -> RawSyntax {
    let textByteCount = Self.textByteCount(for: wholeText.count)
    let (node, trailing) = Self.allocate(header, fields, trailingByteCount: textByteCount, arena: arena)
    Self.copyText(
      wholeText,
      to: Self.bindText(trailing, byteCount: textByteCount),
      sourceBufferEnd: sourceBufferEnd
    )
    return node
  }

  /// The room a token's text needs in a node's tail: enough for ``copyText`` to
  /// write whole units without spilling past what was allocated.
  ///
  /// Four-byte units for short texts, which most punctuation and operators are:
  /// a three-byte token then wastes one byte rather than five. Identifiers and
  /// keywords are longer and keep the eight-byte units.
  ///
  /// - Important: ``copyText`` writes exactly this much, so the two must agree.
  @inline(__always)
  static func textByteCount(for count: Int) -> Int {
    count <= 4 ? (count + 3) & ~3 : (count + 7) & ~7
  }

  /// Binds the `byteCount` bytes of room for a token's text in a node's tail, as
  /// ``textByteCount(for:)`` allots it, and returns it for ``copyText`` to write.
  @inline(__always)
  private static func bindText(_ start: UnsafeMutableRawPointer, byteCount: Int) -> UnsafeMutableRawPointer {
    UnsafeMutableRawPointer(start.bindMemory(to: UInt8.self, capacity: byteCount))
  }

  /// Copies `text` into a node's tail, which must have ``textByteCount(for:)``
  /// bytes of room.
  ///
  /// A short token is one load and one store this way, where `memcpy` spends
  /// longer choosing how to copy than it does copying. Reading the last unit runs
  /// past the token's end, so that form is taken only where those bytes are still
  /// inside the buffer being lexed.
  @inline(__always)
  private static func copyText(
    _ text: SyntaxText,
    to destination: UnsafeMutableRawPointer,
    sourceBufferEnd: UnsafePointer<UInt8>?
  ) {
    guard let source = text.baseAddress, !text.isEmpty else { return }
    let count = text.count
    guard let sourceBufferEnd,
      source + Self.textByteCount(for: count) <= sourceBufferEnd
    else {
      destination.copyMemory(from: source, byteCount: count)
      return
    }
    if count <= 4 {
      destination.storeBytes(
        of: UnsafeRawPointer(source).loadUnaligned(as: UInt32.self),
        as: UInt32.self
      )
    } else {
      var written = 0
      while written < count {
        destination.advanced(by: written).storeBytes(
          of: UnsafeRawPointer(source + written).loadUnaligned(as: UInt64.self),
          as: UInt64.self
        )
        written += 8
      }
    }
  }

  /// "Designated" factory method to create a materialized token node.
  ///
  /// This should not be called directly.
  /// Use `makeMaterializedToken(arena:kind:leadingTrivia:trailingTrivia:)` or
  /// `makeMissingToken(arena:kind:)` instead.
  ///
  /// - Parameters:
  ///   - kind: Token kind.
  ///   - text: Token text.
  ///   - triviaPieces: Raw trivia pieces including leading and trailing trivia.
  ///   - numLeadingTrivia: Number of leading trivia pieces in `triviaPieces`.
  ///   - byteLength: Byte length of this token including trivia.
  ///   - presence: Whether the token appeared in the source code or if it was synthesized.
  ///   - arena: RawSyntaxArena to the result node data resides.
  internal static func materializedToken(
    kind: RawTokenKind,
    text: SyntaxText,
    triviaPieces: RawTriviaPieceBuffer,
    numLeadingTrivia: UInt32,
    byteLength: UInt32,
    presence: SourcePresence,
    tokenDiagnostic: TokenDiagnostic?,
    arena: __shared RawSyntaxArena
  ) -> RawSyntax {
    // A materialized token's `text` must outlive the tree. Callers may pass text
    // that is already arena-managed, a static default (`kind.defaultText`), or -
    // during parsing - a slice of the `Parser`-owned source buffer, which does
    // *not* outlive the parse. Intern dynamic text so the token is always
    // self-contained. `intern` is a no-op for already-arena-managed (and empty)
    // text, and we skip static defaults to avoid copying constants into every
    // token.
    let text = kind.defaultText?.baseAddress == text.baseAddress ? text : arena.intern(text)
    let payload = RawSyntaxData.MaterializedToken(
      tokenKind: kind,
      tokenText: text,
      triviaPieces: triviaPieces,
      numLeadingTrivia: numLeadingTrivia,
      byteLength: byteLength,
      presence: presence,
      tokenDiagnostic: tokenDiagnostic
    )
    precondition(kind != .keyword || Keyword(text) != nil, "If kind is keyword, the text must be a known token kind")
    return Self.allocateMaterializedToken(payload, arena: arena)
  }

  static func allocateMaterializedToken(
    _ fields: RawSyntaxData.MaterializedToken,
    arena: __shared RawSyntaxArena
  ) -> RawSyntax {
    Self.allocate(.materializedToken(RawSyntaxArenaRef(arena)), fields, arena: arena).node
  }

  /// Factory method to create a materialized token node.
  ///
  /// - Parameters:
  ///   - kind: Token kind.
  ///   - text: Token text.
  ///   - leadingTriviaPieceCount: Number of leading trivia pieces.
  ///   - trailingTriviaPieceCount: Number of trailing trivia pieces.
  ///   - presence: Whether the token appeared in the source code or if it was synthesized.
  ///   - arena: RawSyntaxArena to the result node data resides.
  ///   - initializingLeadingTriviaWith: A closure that initializes leading trivia pieces.
  ///   - initializingTrailingTriviaWith: A closure that initializes trailing trivia pieces.
  public static func makeMaterializedToken(
    kind: RawTokenKind,
    text: SyntaxText,
    leadingTriviaPieceCount: Int,
    trailingTriviaPieceCount: Int,
    presence: SourcePresence,
    tokenDiagnostic: TokenDiagnostic?,
    arena: __shared RawSyntaxArena,
    initializingLeadingTriviaWith: (UnsafeMutableBufferPointer<RawTriviaPiece>) -> Void,
    initializingTrailingTriviaWith: (UnsafeMutableBufferPointer<RawTriviaPiece>) -> Void
  ) -> RawSyntax {
    precondition(kind.defaultText == nil || text.isEmpty || kind.defaultText == text)
    let totalTriviaCount = leadingTriviaPieceCount + trailingTriviaPieceCount
    let triviaBuffer = arena.allocateRawTriviaPieceBuffer(count: totalTriviaCount)
    initializingLeadingTriviaWith(
      UnsafeMutableBufferPointer(rebasing: triviaBuffer[..<leadingTriviaPieceCount])
    )
    initializingTrailingTriviaWith(
      UnsafeMutableBufferPointer(rebasing: triviaBuffer[leadingTriviaPieceCount...])
    )

    let byteLength = text.count + triviaBuffer.reduce(0, { $0 + $1.byteLength })
    return .materializedToken(
      kind: kind,
      text: text,
      triviaPieces: RawTriviaPieceBuffer(UnsafeBufferPointer(triviaBuffer)),
      numLeadingTrivia: numericCast(leadingTriviaPieceCount),
      byteLength: numericCast(byteLength),
      presence: presence,
      tokenDiagnostic: tokenDiagnostic,
      arena: arena
    )
  }

  /// Factory method to create a materialized token node.
  ///
  /// - Parameters:
  ///   - arena: RawSyntaxArena to the result node data resides.
  ///   - kind: Token kind.
  ///   - text: Token text.
  ///   - leadingTrivia: Leading trivia.
  ///   - trailingTrivia: Trailing trivia.
  static func makeMaterializedToken(
    kind: TokenKind,
    leadingTrivia: Trivia,
    trailingTrivia: Trivia,
    presence: SourcePresence,
    tokenDiagnostic: TokenDiagnostic?,
    arena: __shared RawSyntaxArena
  ) -> RawSyntax {
    let decomposed = kind.decomposeToRaw()
    let rawKind = decomposed.rawKind
    let text = (decomposed.string.map({ arena.intern($0) }) ?? decomposed.rawKind.defaultText ?? "")

    return .makeMaterializedToken(
      kind: rawKind,
      text: text,
      leadingTriviaPieceCount: leadingTrivia.count,
      trailingTriviaPieceCount: trailingTrivia.count,
      presence: presence,
      tokenDiagnostic: tokenDiagnostic,
      arena: arena,
      initializingLeadingTriviaWith: { buffer in
        guard var ptr = buffer.baseAddress else { return }
        for piece in leadingTrivia {
          ptr.initialize(to: .make(piece, arena: arena))
          ptr += 1
        }
      },
      initializingTrailingTriviaWith: { buffer in
        guard var ptr = buffer.baseAddress else { return }
        for piece in trailingTrivia {
          ptr.initialize(to: .make(piece, arena: arena))
          ptr += 1
        }
      }
    )
  }

  static func makeMissingToken(
    kind: TokenKind,
    arena: __shared RawSyntaxArena
  ) -> RawSyntax {
    let (rawKind, _) = kind.decomposeToRaw()
    return .materializedToken(
      kind: rawKind,
      text: rawKind.defaultText ?? "",
      triviaPieces: RawTriviaPieceBuffer(),
      numLeadingTrivia: 0,
      byteLength: 0,
      presence: .missing,
      tokenDiagnostic: nil,
      arena: arena
    )
  }
}

extension RawSyntax {
  /// Where a layout node keeps its children, which the node's header records and
  /// its caller knows: the generated initializers statically, from whether their
  /// node has `unexpected` slots at all, and `hasUnexpected` for whether any of
  /// them is occupied.
  public enum LayoutStorage {
    /// Children with no `unexpected` slots among them: every collection, and the
    /// layout kinds that do not interleave.
    case flat
    /// A kind that interleaves `unexpected` slots, in a node where every one of
    /// them is empty, so it keeps room only for its real children.
    case interleaved
    /// A kind that interleaves `unexpected` slots, in a node where at least one is
    /// occupied, so it keeps its real children and then all of them.
    case interleavedWithUnexpected
  }

  /// Makes a layout node whose caller knows how many real children it has and
  /// whether any of its `unexpected` slots is occupied, and writes them where they
  /// will live: the real children first, then the `unexpected` slots if there are
  /// any.
  ///
  /// The generated initializers know both statically, so this is what they call and
  /// nothing is written twice.
  ///
  /// - Parameters:
  ///   - kind: Syntax kind, which decides whether this node interleaves
  ///     `unexpected` slots with its children at all.
  ///   - childCount: Number of real children, which `initializer` writes first.
  ///   - storage: Where this node keeps its children. `initializer` writes the
  ///     `unexpected` slots after the real ones for `interleavedWithUnexpected`,
  ///     and writes only real children otherwise.
  ///   - isMaximumNestingLevelOverflow: Whether the parse gave up nesting here.
  ///   - arena: RawSyntaxArena in which the node is allocated.
  ///   - initializer: A closure that initializes every slot.
  /// - Important: `@inline(__always)` so that this stays inlined however `Layout`
  ///   grows. Every layout node in a tree is built here, and out of line it costs
  ///   about 0.19 ms of a parse, which no test would catch.
  @inline(__always)
  public static func makeLayout(
    kind: SyntaxKind,
    childCount: Int,
    storage: LayoutStorage,
    isMaximumNestingLevelOverflow: Bool = false,
    arena: __shared RawSyntaxArena,
    initializingWith initializer: (UnsafeMutableBufferPointer<RawSyntax?>) -> Void
  ) -> RawSyntax {
    assert(
      (storage == .flat) != kind.interleavesUnexpectedChildren,
      "a node's storage must agree with whether its kind interleaves"
    )
    let arenaRef = RawSyntaxArenaRef(arena)
    let header: RawSyntaxData
    let slotCount: Int
    switch storage {
    case .flat:
      header = .flat(arenaRef)
      slotCount = childCount
    case .interleaved:
      header = .layout(arenaRef)
      slotCount = childCount
    case .interleavedWithUnexpected:
      header = .layoutWithUnexpected(arenaRef)
      slotCount = 2 * childCount + 1
    }
    let (node, fields, trailing) = Self.allocate(
      header,
      binding: RawSyntaxData.Layout.self,
      trailingByteCount: slotCount * MemoryLayout<RawSyntax?>.stride,
      arena: arena
    )
    let slots = UnsafeMutableBufferPointer<RawSyntax?>(
      start: trailing.bindMemory(to: RawSyntax?.self, capacity: slotCount),
      count: slotCount
    )
    initializer(slots)
    // What ``RawSyntaxLayoutView/elements`` relies on: a collection has an element
    // in every slot.
    assert(
      kind.interleavesUnexpectedChildren || slots.allSatisfy { $0 != nil },
      "a node with a flat layout may not have an absent child"
    )

    // Summing over the slots needs no order, so it does not matter that they are
    // not in the order the tree describes.
    var byteLength: UInt32 = 0
    var descendantCount: UInt32 = 0
    var recursiveFlags = RecursiveRawSyntaxFlags()
    if kind.hasError {
      recursiveFlags.insert(.hasError)
    }
    for case let child? in slots {
      byteLength += child.byteLength32
      descendantCount += child.totalNodes32
      recursiveFlags.insert(child.recursiveFlags)
      arena.addChild(child.arenaReference)
    }
    if kind == .sequenceExpr {
      recursiveFlags.insert(.hasSequenceExpr)
    }
    if isMaximumNestingLevelOverflow {
      recursiveFlags.insert(.hasMaximumNestingLevelOverflow)
    }
    fields.initialize(
      to: RawSyntaxData.Layout(
        childCount: UInt32(childCount),
        byteLength: byteLength,
        descendantCount: descendantCount,
        kind: kind,
        recursiveFlags: recursiveFlags
      )
    )
    // Every layout node is built here, so this is the one place that has to ask. The
    // children are checked as the tree describes them, `unexpected` slots included,
    // which is what a node's kind names — a node that kept no room for them does not
    // store them that way, so ``logicalChildren`` is what reads them back.
    validateLayout(layout: node.logicalChildren, as: kind)
    return node
  }

  /// Makes a layout node from the layout as the tree describes it: an `unexpected`
  /// slot before the first child, between each pair, and after the last.
  ///
  /// Whether any of those slots is occupied decides how much memory the node needs,
  /// and that is not known until `initializer` has run, so it writes into a
  /// temporary and the node is built from what it wrote. A caller that knows the two
  /// counts up front should take the other form instead.
  ///
  /// - Parameters:
  ///   - kind: Syntax kind.
  ///   - count: Number of slots `initializer` writes, `unexpected` ones included.
  ///   - isMaximumNestingLevelOverflow: Whether the parse gave up nesting here.
  ///   - arena: RawSyntaxArena in which the node is allocated.
  ///   - initializer: A closure that initializes every slot.
  public static func makeLayout(
    kind: SyntaxKind,
    uninitializedCount count: Int,
    isMaximumNestingLevelOverflow: Bool = false,
    arena: __shared RawSyntaxArena,
    initializingWith initializer: (UnsafeMutableBufferPointer<RawSyntax?>) -> Void
  ) -> RawSyntax {
    // A layout node has at most 23 slots, so the temporary is small.
    return withUnsafeTemporaryAllocation(of: RawSyntax?.self, capacity: count) { logical in
      initializer(logical)

      let interleaves = kind.interleavesUnexpectedChildren
      // Real children are the odd slots when a kind interleaves, and all of them
      // when it does not.
      let childCount = interleaves ? (count - 1) / 2 : count

      var hasUnexpected = false
      if interleaves {
        for i in stride(from: 0, to: count, by: 2) where logical[i] != nil {
          hasUnexpected = true
          break
        }
      }

      let storage: LayoutStorage =
        !interleaves ? .flat : (hasUnexpected ? .interleavedWithUnexpected : .interleaved)
      return Self.makeLayout(
        kind: kind,
        childCount: childCount,
        storage: storage,
        isMaximumNestingLevelOverflow: isMaximumNestingLevelOverflow,
        arena: arena
      ) { slots in
        // Real children first, so that reaching one is the same constant index
        // whichever shape the node has, then the `unexpected` slots if the node kept
        // room for them.
        if interleaves {
          for k in 0..<childCount {
            slots.initializeElement(at: k, to: logical[2 * k + 1])
          }
          if hasUnexpected {
            for j in 0...childCount {
              slots.initializeElement(at: childCount + j, to: logical[2 * j])
            }
          }
        } else {
          for i in 0..<count {
            slots.initializeElement(at: i, to: logical[i])
          }
        }
      }
    }
  }

  static func makeLayout(
    kind: SyntaxKind,
    from collection: some Collection<RawSyntax?>,
    arena: __shared RawSyntaxArena,
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil
  ) -> RawSyntax {
    if leadingTrivia != nil || trailingTrivia != nil {
      var layout = Array(collection)
      if let leadingTrivia = leadingTrivia,
        // Find the index of the first non-empty node so we can attach the trivia to it.
        let idx = layout.firstIndex(where: { $0 != nil && ($0!.isToken || $0!.totalNodes > 1) })
      {
        layout[idx] = layout[idx]!.withLeadingTrivia(
          leadingTrivia + (layout[idx]?.formLeadingTrivia() ?? []),
          arena: arena
        )
      }
      if let trailingTrivia = trailingTrivia,
        // Find the index of the first non-empty node so we can attach the trivia to it.
        let idx = layout.lastIndex(where: { $0 != nil && ($0!.isToken || $0!.totalNodes > 1) })
      {
        layout[idx] = layout[idx]!.withTrailingTrivia(
          (layout[idx]?.formTrailingTrivia() ?? []) + trailingTrivia,
          arena: arena
        )
      }
      return .makeLayout(kind: kind, from: layout, arena: arena)
    }

    return .makeLayout(kind: kind, uninitializedCount: collection.count, arena: arena) {
      _ = $0.initialize(from: collection)
    }
  }
}

// MARK: - Debugging.

extension RawSyntax: CustomDebugStringConvertible {

  private func debugWrite(to target: inout some TextOutputStream, indent: Int, withChildren: Bool = false) {
    let childIndent = indent + 2
    switch header {
    case .smolParsedToken:
      target.write(".parsedToken(")
      target.write(String(describing: asSmolParsedToken.tokenKind))
      target.write(" wholeText=\(asSmolParsedToken.wholeText.debugDescription)")
      target.write(" textRange=\(asSmolParsedToken.textRange.description)")
    case .parsedToken:
      target.write(".parsedToken(")
      target.write(String(describing: asParsedToken.tokenKind))
      target.write(" wholeText=\(asParsedToken.wholeText.debugDescription)")
      target.write(" textRange=\(asParsedToken.textRange.description)")
    case .materializedToken:
      target.write(".materializedToken(")
      target.write(String(describing: asMaterializedToken.tokenKind))
      target.write(" text=\(asMaterializedToken.tokenText.debugDescription)")
      target.write(" numLeadingTrivia=\(asMaterializedToken.numLeadingTrivia)")
      target.write(" byteLength=\(asMaterializedToken.byteLength)")
      break
    case .flat, .layout, .layoutWithUnexpected:
      target.write(".layout(")
      target.write(String(describing: kind))
      target.write(" byteLength=\(Int(asLayout.byteLength))")
      target.write(" descendantCount=\(Int(asLayout.descendantCount))")
      if withChildren {
        for (num, child) in logicalChildren.enumerated() {
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

  @_spi(RawSyntax)
  public var debugDescription: String {
    var string = ""
    debugWrite(to: &string, indent: 0, withChildren: false)
    return string
  }
}

extension RawSyntax: CustomReflectable {
  @_spi(RawSyntax)
  public var customMirror: Mirror {

    let mirrorChildren: [Any]
    switch view {
    case .token:
      mirrorChildren = []
    case .layout(let layoutView):
      mirrorChildren = layoutView.children.map {
        child in child ?? (nil as Any?) as Any
      }
    }
    return Mirror(self, unlabeledChildren: mirrorChildren)
  }
}

enum RawSyntaxView {
  case token(RawSyntaxTokenView)
  case layout(RawSyntaxLayoutView)
}

extension RawSyntax {
  var view: RawSyntaxView {
    switch header {
    case .smolParsedToken, .parsedToken, .materializedToken:
      return .token(tokenView!)
    case .flat, .layout, .layoutWithUnexpected:
      return .layout(layoutView!)
    }
  }
}

extension RawSyntax: Identifiable {
  public struct ID: Hashable, @unchecked Sendable {
    /// The pointer to the start of the `RawSyntax` node.
    fileprivate var pointer: UnsafeRawPointer
    fileprivate init(_ raw: RawSyntax) {
      self.pointer = raw.pointer.unsafeRawPointer
    }
  }

  public var id: ID {
    return ID(self)
  }
}

/// See `SyntaxMemoryLayout`.
let RawSyntaxDataMemoryLayouts: [String: SyntaxMemoryLayout.Value] = [
  "RawSyntaxData": .init(RawSyntaxData.self),
  "RawSyntaxData.SmolParsedToken": .init(RawSyntaxData.SmolParsedToken.self),
  "RawSyntaxData.ParsedToken": .init(RawSyntaxData.ParsedToken.self),
  "RawSyntaxData.MaterializedToken": .init(RawSyntaxData.MaterializedToken.self),
  "RawSyntaxData.Layout": .init(RawSyntaxData.Layout.self),
  "RawSyntax?": .init(RawSyntax?.self),
]
