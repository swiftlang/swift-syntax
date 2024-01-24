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

@_spi(RawSyntax) public typealias RawSyntaxBuffer = SyntaxArenaAllocatedBufferPointer<RawSyntax?>

typealias RawTriviaPieceBuffer = SyntaxArenaAllocatedBufferPointer<RawTriviaPiece>

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

/// Node data for RawSyntax tree. Tagged union plus common data.
internal struct RawSyntaxData: Sendable {
  internal enum Payload: Sendable {
    /// - Important: A raw syntax node for a parsed token must always be allocated in a `ParsingSyntaxArena` so we can
    ///   parse the trivia in the token.
    case parsedToken(ParsedToken)
    case materializedToken(MaterializedToken)
    case layout(Layout)
  }

  /// Token with lazy trivia parsing.
  ///
  /// The RawSyntax's `arena` must have a valid trivia parsing function to
  /// lazily materialize the leading/trailing trivia pieces.
  struct ParsedToken: Sendable {
    var tokenKind: RawTokenKind

    /// Whole text of this token including leading/trailing trivia.
    var wholeText: SyntaxText

    /// Range of the actual token’s text.
    ///
    /// Text in `wholeText` before `textRange.lowerBound` is leading trivia and
    /// after `textRange.upperBound` is trailing trivia.
    var textRange: Range<SyntaxText.Index>

    var presence: SourcePresence

    /// Store the members of ``TokenDiagnostic`` individually so the compiler can pack
    /// `ParsedToken` more efficiently (saving 2 bytes)
    /// `tokenDiagnosticByteOffset` is ignored if `tokenDiagnosticKind` is `nil`
    private var tokenDiagnosticKind: TokenDiagnostic.Kind?
    private var tokenDiagnosticByteOffset: UInt16

    var tokenDiagnostic: TokenDiagnostic? {
      get {
        if let kind = tokenDiagnosticKind {
          return TokenDiagnostic(kind, byteOffset: tokenDiagnosticByteOffset)
        } else {
          return nil
        }
      }
      set {
        if let newValue {
          self.tokenDiagnosticKind = newValue.kind
          self.tokenDiagnosticByteOffset = newValue.byteOffset
        } else {
          self.tokenDiagnosticKind = nil
          self.tokenDiagnosticByteOffset = 0
        }
      }
    }

    init(tokenKind: RawTokenKind, wholeText: SyntaxText, textRange: Range<SyntaxText.Index>, presence: SourcePresence, tokenDiagnostic: TokenDiagnostic?) {
      self.tokenKind = tokenKind
      self.wholeText = wholeText
      self.textRange = textRange
      self.presence = presence
      self.tokenDiagnosticKind = tokenDiagnostic?.kind
      self.tokenDiagnosticByteOffset = tokenDiagnostic?.byteOffset ?? 0
    }
  }

  /// Token typically created with `TokenSyntax.<someToken>`.
  struct MaterializedToken: Sendable {
    var tokenKind: RawTokenKind
    var tokenText: SyntaxText
    var triviaPieces: RawTriviaPieceBuffer
    var numLeadingTrivia: UInt32
    var byteLength: UInt32
    var presence: SourcePresence
    /// Store the members of ``TokenDiagnostic`` individually so the compiler can pack
    /// `ParsedToken` more efficiently (saving 2 bytes)
    /// `tokenDiagnosticByteOffset` is ignored if `tokenDiagnosticKind` is `nil`
    private var tokenDiagnosticKind: TokenDiagnostic.Kind?
    private var tokenDiagnosticByteOffset: UInt16

    init(
      tokenKind: RawTokenKind,
      tokenText: SyntaxText,
      triviaPieces: RawTriviaPieceBuffer,
      numLeadingTrivia: UInt32,
      byteLength: UInt32,
      presence: SourcePresence,
      tokenDiagnostic: TokenDiagnostic?
    ) {
      self.tokenKind = tokenKind
      self.tokenText = tokenText
      self.triviaPieces = triviaPieces
      self.numLeadingTrivia = numLeadingTrivia
      self.byteLength = byteLength
      self.presence = presence
      self.tokenDiagnosticKind = tokenDiagnostic?.kind
      self.tokenDiagnosticByteOffset = tokenDiagnostic?.byteOffset ?? 0
    }

    var tokenDiagnostic: TokenDiagnostic? {
      get {
        if let kind = tokenDiagnosticKind {
          return TokenDiagnostic(kind, byteOffset: tokenDiagnosticByteOffset)
        } else {
          return nil
        }
      }
      set {
        if let newValue {
          self.tokenDiagnosticKind = newValue.kind
          self.tokenDiagnosticByteOffset = newValue.byteOffset
        } else {
          self.tokenDiagnosticKind = nil
          self.tokenDiagnosticByteOffset = 0
        }
      }
    }
  }

  /// Layout node including collections.
  struct Layout: Sendable {
    var kind: SyntaxKind
    var layout: RawSyntaxBuffer
    var byteLength: Int
    /// Number of nodes in this subtree, excluding this node.
    var descendantCount: Int
    var recursiveFlags: RecursiveRawSyntaxFlags
  }

  var payload: Payload
  var arenaReference: SyntaxArenaRef
}

extension RawSyntaxData.ParsedToken {
  var tokenText: SyntaxText {
    SyntaxText(rebasing: wholeText[textRange])
  }
  var leadingTriviaText: SyntaxText {
    SyntaxText(rebasing: wholeText[..<textRange.lowerBound])
  }
  var trailingTriviaText: SyntaxText {
    SyntaxText(rebasing: wholeText[textRange.upperBound...])
  }
}

extension RawSyntaxData.MaterializedToken {
  var leadingTrivia: RawTriviaPieceBuffer {
    triviaPieces[..<Int(numLeadingTrivia)]
  }
  var trailingTrivia: RawTriviaPieceBuffer {
    triviaPieces[Int(numLeadingTrivia)...]
  }
}

/// Represents the raw tree structure underlying the syntax tree. These nodes
/// have no notion of identity and only provide structure to the tree. They
/// are immutable and can be freely shared between syntax nodes.
@_spi(RawSyntax)
public struct RawSyntax: Sendable {

  /// Pointer to the actual data which resides in a SyntaxArena.
  var pointer: SyntaxArenaAllocatedPointer<RawSyntaxData>
  init(pointer: SyntaxArenaAllocatedPointer<RawSyntaxData>) {
    self.pointer = pointer
  }

  init(arena: __shared SyntaxArena, payload: RawSyntaxData.Payload) {
    let arenaRef = SyntaxArenaRef(arena)
    let data = RawSyntaxData(
      payload: payload,
      arenaReference: arenaRef
    )
    self.init(pointer: SyntaxArenaAllocatedPointer(arena.intern(data)))
  }

  var rawData: RawSyntaxData {
    pointer.pointee
  }

  internal var arenaReference: SyntaxArenaRef {
    rawData.arenaReference
  }

  internal var payload: RawSyntaxData.Payload {
    get { rawData.payload }
  }
}

// MARK: - Accessors

extension RawSyntax {
  /// The syntax kind of this raw syntax.
  @_spi(RawSyntax)
  public var kind: SyntaxKind {
    switch rawData.payload {
    case .parsedToken(_): return .token
    case .materializedToken(_): return .token
    case .layout(let dat): return dat.kind
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

  /// Total number of nodes in this sub-tree, including `self` node.
  var totalNodes: Int {
    switch rawData.payload {
    case .parsedToken(_),
      .materializedToken(_):
      return 1
    case .layout(let dat):
      return dat.descendantCount + 1
    }
  }

  /// The "width" of the node.
  ///
  /// Sum of text byte lengths of all present descendant token nodes.
  @_spi(RawSyntax)
  public var byteLength: Int {
    switch rawData.payload {
    case .parsedToken(let dat):
      if dat.presence == .present {
        return dat.wholeText.count
      } else {
        return 0
      }
    case .materializedToken(let dat):
      if dat.presence == .present {
        return Int(dat.byteLength)
      } else {
        return 0
      }
    case .layout(let dat):
      return dat.byteLength
    }
  }

  var totalLength: SourceLength {
    SourceLength(utf8Length: byteLength)
  }

  /// Replaces the leading trivia of the first token in this syntax tree by `leadingTrivia`.
  /// If the syntax tree did not contain a token and thus no trivia could be attached to it, `nil` is returned.
  /// - Parameters:
  ///   - leadingTrivia: The trivia to attach.
  ///   - arena: SyntaxArena to the result node data resides.
  @_spi(RawSyntax)
  public func withLeadingTrivia(_ leadingTrivia: Trivia, arena: SyntaxArena) -> RawSyntax? {
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
  ///   - arena: SyntaxArena to the result node data resides.
  @_spi(RawSyntax)
  public func withTrailingTrivia(_ trailingTrivia: Trivia, arena: SyntaxArena) -> RawSyntax? {
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
  /// Enumerate all of the syntax text present in this node, and all
  /// of its children, to give a source-accurate view of the bytes.
  ///
  /// Unlike `description`, this provides a source-accurate representation
  /// even in the presence of malformed UTF-8 in the input source.
  ///
  /// The ``SyntaxText`` arguments passed to the visitor are only guaranteed
  /// to be valid within that call. It is unsafe to escape the `SyntaxValue`
  /// values outside of the closure.
  public func withEachSyntaxText(body: (SyntaxText) throws -> Void) rethrows {
    switch rawData.payload {
    case .parsedToken(let dat):
      if dat.presence == .present {
        try body(dat.wholeText)
      }
    case .materializedToken(let dat):
      if dat.presence == .present {
        for p in dat.leadingTrivia {
          try p.withSyntaxText(body: body)
        }
        try body(dat.tokenText)
        for p in dat.trailingTrivia {
          try p.withSyntaxText(body: body)
        }
      }
    case .layout(let dat):
      for case let child? in dat.layout {
        try child.withEachSyntaxText(body: body)
      }
    }
  }

  /// Retrieve the syntax text as an array of bytes that models the input
  /// source even in the presence of invalid UTF-8.
  public var syntaxTextBytes: [UInt8] {
    var result: [UInt8] = []
    withEachSyntaxText { syntaxText in
      result.append(contentsOf: syntaxText)
    }
    return result
  }
}

extension RawSyntax: TextOutputStreamable, CustomStringConvertible {
  /// Prints the RawSyntax node, and all of its children, to the provided
  /// stream. This implementation must be source-accurate.
  /// - Parameter stream: The stream on which to output this node.
  public func write<Target: TextOutputStream>(to target: inout Target) {
    switch rawData.payload {
    case .parsedToken(let dat):
      if dat.presence == .present {
        String(syntaxText: dat.wholeText).write(to: &target)
      }
    case .materializedToken(let dat):
      if dat.presence == .present {
        for p in dat.leadingTrivia { p.write(to: &target) }
        String(syntaxText: dat.tokenText).write(to: &target)
        for p in dat.trailingTrivia { p.write(to: &target) }
      }
    case .layout(let dat):
      for case let child? in dat.layout {
        child.write(to: &target)
      }
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
  /// "Designated" factory method to create a parsed token node.
  ///
  /// - Parameters:
  ///   - kind: Token kind.
  ///   - wholeText: Whole text of this token including trailing/leading trivia.
  ///   - textRange: Range of the token text in `wholeText`.
  ///   - presence: Whether the token appeared in the source code or if it was synthesized.
  ///   - arena: SyntaxArena to the result node data resides.
  internal static func parsedToken(
    kind: RawTokenKind,
    wholeText: SyntaxText,
    textRange: Range<SyntaxText.Index>,
    presence: SourcePresence,
    tokenDiagnostic: TokenDiagnostic?,
    arena: __shared ParsingSyntaxArena
  ) -> RawSyntax {
    assert(
      arena.contains(text: wholeText),
      "token text must be managed by the arena"
    )
    let payload = RawSyntaxData.ParsedToken(
      tokenKind: kind,
      wholeText: wholeText,
      textRange: textRange,
      presence: presence,
      tokenDiagnostic: tokenDiagnostic
    )
    precondition(kind != .keyword || Keyword(payload.tokenText) != nil, "If kind is keyword, the text must be a known token kind")
    return RawSyntax(arena: arena, payload: .parsedToken(payload))
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
  ///   - arena: SyntaxArena to the result node data resides.
  internal static func materializedToken(
    kind: RawTokenKind,
    text: SyntaxText,
    triviaPieces: RawTriviaPieceBuffer,
    numLeadingTrivia: UInt32,
    byteLength: UInt32,
    presence: SourcePresence,
    tokenDiagnostic: TokenDiagnostic?,
    arena: __shared SyntaxArena
  ) -> RawSyntax {
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
    return RawSyntax(arena: arena, payload: .materializedToken(payload))
  }

  /// Factory method to create a materialized token node.
  ///
  /// - Parameters:
  ///   - kind: Token kind.
  ///   - text: Token text.
  ///   - leadingTriviaPieceCount: Number of leading trivia pieces.
  ///   - trailingTriviaPieceCount: Number of trailing trivia pieces.
  ///   - presence: Whether the token appeared in the source code or if it was synthesized.
  ///   - arena: SyntaxArena to the result node data resides.
  ///   - initializingLeadingTriviaWith: A closure that initializes leading trivia pieces.
  ///   - initializingTrailingTriviaWith: A closure that initializes trailing trivia pieces.
  public static func makeMaterializedToken(
    kind: RawTokenKind,
    text: SyntaxText,
    leadingTriviaPieceCount: Int,
    trailingTriviaPieceCount: Int,
    presence: SourcePresence,
    tokenDiagnostic: TokenDiagnostic?,
    arena: __shared SyntaxArena,
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
  ///   - arena: SyntaxArena to the result node data resides.
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
    arena: __shared SyntaxArena
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
    arena: __shared SyntaxArena
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
  /// "Designated" factory method to create a layout node.
  ///
  /// This should not be called directly.
  /// Use `makeLayout(arena:kind:uninitializedCount:initializingWith:)` or
  /// `makeEmptyLayout(arena:kind:)` instead.
  ///
  /// - Parameters:
  ///   - arena: SyntaxArena to the result node data resides.
  ///   - kind: Syntax kind. This should not be `.token`.
  ///   - layout: Layout buffer of the children.
  ///   - byteLength: Computed total byte length of this node.
  ///   - descendantCount: Total number of the descendant nodes in `layout`.
  fileprivate static func layout(
    kind: SyntaxKind,
    layout: RawSyntaxBuffer,
    byteLength: Int,
    descendantCount: Int,
    recursiveFlags: RecursiveRawSyntaxFlags,
    arena: __shared SyntaxArena
  ) -> RawSyntax {
    validateLayout(layout: layout, as: kind)
    let payload = RawSyntaxData.Layout(
      kind: kind,
      layout: layout,
      byteLength: byteLength,
      descendantCount: descendantCount,
      recursiveFlags: recursiveFlags
    )
    return RawSyntax(arena: arena, payload: .layout(payload))
  }

  /// Factory method to create a layout node.
  ///
  /// - Parameters:
  ///   - arena: SyntaxArena to the result node data resides.
  ///   - kind: Syntax kind.
  ///   - count: Number of children.
  ///   - initializer: A closure that initializes elements.
  public static func makeLayout(
    kind: SyntaxKind,
    uninitializedCount count: Int,
    isMaximumNestingLevelOverflow: Bool = false,
    arena: __shared SyntaxArena,
    initializingWith initializer: (UnsafeMutableBufferPointer<RawSyntax?>) -> Void
  ) -> RawSyntax {
    // Allocate and initialize the list.
    let layoutBuffer = arena.allocateRawSyntaxBuffer(count: count)
    initializer(layoutBuffer)

    // Calculate the "byte width".
    var byteLength = 0
    var descendantCount = 0
    var recursiveFlags = RecursiveRawSyntaxFlags()
    if kind.hasError {
      recursiveFlags.insert(.hasError)
    }
    for case let node? in layoutBuffer {
      byteLength += node.byteLength
      descendantCount += node.totalNodes
      recursiveFlags.insert(node.recursiveFlags)
      arena.addChild(node.arenaReference)
    }
    if kind == .sequenceExpr {
      recursiveFlags.insert(.hasSequenceExpr)
    }
    if isMaximumNestingLevelOverflow {
      recursiveFlags.insert(.hasMaximumNestingLevelOverflow)
    }
    return .layout(
      kind: kind,
      layout: RawSyntaxBuffer(UnsafeBufferPointer(layoutBuffer)),
      byteLength: byteLength,
      descendantCount: descendantCount,
      recursiveFlags: recursiveFlags,
      arena: arena
    )
  }

  static func makeEmptyLayout(
    kind: SyntaxKind,
    arena: __shared SyntaxArena
  ) -> RawSyntax {
    var recursiveFlags = RecursiveRawSyntaxFlags()
    if kind.hasError {
      recursiveFlags.insert(.hasError)
    }
    return .layout(
      kind: kind,
      layout: RawSyntaxBuffer(),
      byteLength: 0,
      descendantCount: 0,
      recursiveFlags: recursiveFlags,
      arena: arena
    )
  }

  static func makeLayout(
    kind: SyntaxKind,
    from collection: some Collection<RawSyntax?>,
    arena: __shared SyntaxArena,
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil
  ) -> RawSyntax {
    if leadingTrivia != nil || trailingTrivia != nil {
      var layout = Array(collection)
      if let leadingTrivia = leadingTrivia,
        // Find the index of the first non-empty node so we can attach the trivia to it.
        let idx = layout.firstIndex(where: { $0 != nil && ($0!.isToken || $0!.totalNodes > 1) })
      {
        layout[idx] = layout[idx]!.withLeadingTrivia(leadingTrivia + (layout[idx]?.formLeadingTrivia() ?? []), arena: arena)
      }
      if let trailingTrivia = trailingTrivia,
        // Find the index of the first non-empty node so we can attach the trivia to it.
        let idx = layout.lastIndex(where: { $0 != nil && ($0!.isToken || $0!.totalNodes > 1) })
      {
        layout[idx] = layout[idx]!.withTrailingTrivia((layout[idx]?.formTrailingTrivia() ?? []) + trailingTrivia, arena: arena)
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
    switch rawData.payload {
    case .parsedToken(let dat):
      target.write(".parsedToken(")
      target.write(String(describing: dat.tokenKind))
      target.write(" wholeText=\(dat.wholeText.debugDescription)")
      target.write(" textRange=\(dat.textRange.description)")
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
    switch raw.payload {
    case .parsedToken, .materializedToken:
      return .token(tokenView!)
    case .layout:
      return .layout(layoutView!)
    }
  }
}

extension RawSyntax: Identifiable {
  public struct ID: Hashable, @unchecked Sendable {
    /// The pointer to the start of the `RawSyntax` node.
    private var pointer: UnsafeRawPointer
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
  "RawSyntaxData.Layout": .init(RawSyntaxData.Layout.self),
  "RawSyntaxData.ParsedToken": .init(RawSyntaxData.ParsedToken.self),
  "RawSyntaxData.MaterializedToken": .init(RawSyntaxData.MaterializedToken.self),
  "RawSyntax?": .init(RawSyntax?.self),
]
