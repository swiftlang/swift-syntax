
extension RawSyntax {

  /// Factory method to create a parsed token node.
  ///
  /// - Parameters:
  ///   - arena: SyntaxArea to the result node data resides.
  ///   - kind: Token kind.
  ///   - wholeText: Parsed token text including leading/tailing Trivia.
  ///   - tokenTextRange: token range in 'wholeText'
  @_spi(RawSyntax)
  public static func makeParsedToken(
    arena: SyntaxArena,
    kind: TokenKind,
    wholeText: StringRef,
    tokenTextRange: Range<StringRef.Index>
  ) -> RawSyntax {
    return .parsedToken(
      arena: arena, kind: kind,
      wholeText: wholeText, tokenTextRange: tokenTextRange)
  }

  /// Create a 'ParsedToken' raw syntax node from Swift `String`s. This is not
  /// an efficient operation, and should be avoided.
  @_spi(RawSyntax)
  public static func makeParsedToken(
    arena: SyntaxArena,
    kind: TokenKind,
    text: String,
    leadingTrivia: String,
    trailingTrivia: String
  ) -> RawSyntax {
    let byteLength = text.utf8.count + leadingTrivia.utf8.count + trailingTrivia.utf8.count
    let wholeText: StringRef
    let textRange: Range<StringRef.Index>
    if byteLength > 0 {
      func initAndAdvance(_ p: UnsafeMutablePointer<UInt8>, from string: String) -> UnsafeMutablePointer<UInt8> {
        guard !string.isEmpty else { return p }
        var string = string
        return string.withUTF8 {
          p.initialize(from: $0.baseAddress!, count: $0.count)
          return p.advanced(by: $0.count)
        }
      }
      let buffer = arena.allocateTextBuffer(count: byteLength)
      let startPtr = buffer.baseAddress!
      let textStart = initAndAdvance(startPtr, from: leadingTrivia)
      let textEnd = initAndAdvance(textStart, from: text)
      let endPtr =  initAndAdvance(textEnd, from: trailingTrivia)
      assert(endPtr - startPtr == buffer.count, "couldn't initialze")
      wholeText = StringRef(baseAddress: startPtr, count: endPtr - startPtr)
      textRange = (textStart-startPtr) ..< (textEnd-startPtr)
    } else {
      wholeText = StringRef()
      textRange = 0..<0
    }
    return parsedToken(
      arena: arena, kind: kind,
      wholeText: wholeText, tokenTextRange: textRange)
  }


  /// Factory method to create a materialized token node.
  ///
  /// - Parameters:
  ///   - arena: SyntaxArea to the result node data resides.
  ///   - kind: Token kind.
  ///   - text: Token text.
  ///   - leadingTrivia: Leading trivia.
  ///   - trailingTrivia: Trailing trivia.
  @_spi(RawSyntax)
  public static func makeMaterializedToken(
    arena: SyntaxArena,
    kind: TokenKind,
    text: String,
    leadingTrivia: Trivia,
    trailingTrivia: Trivia
  ) -> RawSyntax {
    let text: StringRef = arena.intern(text)
    var byteLength = text.count

    let triviaBuffer: RawTriviaPieceBuffer
    let totalTriviaCount = leadingTrivia.count + trailingTrivia.count

    if totalTriviaCount != 0 {
      let buffer = arena.allocateRawTriviaPieceBuffer(count: totalTriviaCount)
      var ptr = buffer.baseAddress!
      for piece in leadingTrivia + trailingTrivia {
        byteLength += piece.byteLength
        ptr.initialize(to: .make(arena: arena, piece))
        ptr = ptr.advanced(by: 1)
      }
      triviaBuffer = .init(buffer)
    } else {
      triviaBuffer = .init(start: nil, count: 0)
    }
    return .materializedToken(
      arena: arena, kind: kind, text: text,
      triviaPieces: triviaBuffer, numLeadingTrivia: numericCast(leadingTrivia.count),
      byteLength: numericCast(byteLength))
  }

  @_spi(RawSyntax)
  public func withTokenKind(_ newValue: TokenKind) -> RawSyntax {
    switch payload {
    case .materializedToken(var payload):
      payload.tokenKind = newValue
      return RawSyntax(arena: arena, payload: .materializedToken(payload))
    case .parsedToken(var payload):
      payload.tokenKind = newValue
      return RawSyntax(arena: arena, payload: .parsedToken(payload))
    default:
      preconditionFailure("withTokenKind() is called on non-token raw syntax")
    }
  }

  @_spi(RawSyntax)
  public func withTokenText(_ newValue: String) -> RawSyntax {
    switch payload {
    case .materializedToken(var payload):
      payload.tokenText = arena.intern(newValue)
      return RawSyntax(arena: arena, payload: .materializedToken(payload))
    case .parsedToken(let payload):
      return .makeParsedToken(
        arena: arena, kind: payload.tokenKind,
        text: String(stringRef: payload.tokenText),
        leadingTrivia: String(stringRef: payload.leadingTriviaText),
        trailingTrivia: String(stringRef: payload.trailingTriviaText))
    default:
      preconditionFailure("withTokenText() is called on non-token raw syntax")
    }
  }
}

extension RawSyntax {
  /// Factory method to create a layout node.
  ///
  /// - Parameters:
  ///   - arena: SyntaxArea to the result node data resides.
  ///   - kind: Syntax kind.
  ///   - count: Number of children.
  ///   - initializer: A closure that initializes elements.
  @_spi(RawSyntax)
  public static func makeLayout(
    arena: SyntaxArena,
    kind: SyntaxKind,
    uninitializedCount count: Int,
    initializingWith initializer: (UnsafeMutableBufferPointer<RawSyntax?>) -> Void
  ) -> RawSyntax {
    // Allocate and initialize the list.
    let layoutBuffer = arena.allocateRawSyntaxBuffer(count: count)
    initializer(layoutBuffer)
    validateLayout(layout: RawSyntaxBuffer(layoutBuffer), as: kind)

    // Calculate the "width".
    var byteLength = 0
    var descendantCount = 0
    for case let node? in layoutBuffer {
      byteLength += node.byteLength
      descendantCount += node.nodeCount
      arena.addChild(node.arena)
    }
    return .layout(
      arena: arena, kind: kind, layout: RawSyntaxBuffer(layoutBuffer),
      byteLength: byteLength, descendantCount: descendantCount)
  }

  @_spi(RawSyntax)
  public static func makeEmptyLayout(
    arena: SyntaxArena,
    kind: SyntaxKind
  ) -> RawSyntax {
    return .layout(
      arena: arena, kind: kind, layout: .init(start: nil, count: 0),
      byteLength: 0, descendantCount: 0)
  }

  func replacingChild(
    at index: Int,
    with newChild: RawSyntax?,
    arena: SyntaxArena
  ) -> RawSyntax {
    precondition(self.children.count > index)
    return .makeLayout(arena: arena,
                       kind: syntaxKind,
                       uninitializedCount: self.children.count) { buffer in
      _ = buffer.initialize(from: self.children)
      buffer[index] = newChild
    }
  }

  @_spi(RawSyntax)
  public func insertingChild(
    _ newChild: RawSyntax?,
    at index: Int,
    arena: SyntaxArena
  ) -> RawSyntax {
    precondition(self.children.count >= index)
    return .makeLayout(arena: arena,
                       kind: syntaxKind,
                       uninitializedCount: self.children.count + 1) { buffer in
      var childIterator = self.children.makeIterator()
      let base = buffer.baseAddress!
      for i in 0..<buffer.count {
        base.advanced(by: i)
          .initialize(to: i == index ? newChild : childIterator.next()!)
      }
    }
  }

  @_spi(RawSyntax)
  public func appending(_ newChild: RawSyntax?, arena: SyntaxArena) -> RawSyntax {
    self.insertingChild(newChild, at: children.count, arena: arena)
  }

  @_spi(RawSyntax)
  public func removingChild(
    at index: Int,
    arena: SyntaxArena
  ) -> RawSyntax {
    precondition(self.children.count > index)
    let count = self.children.count - 1
    return .makeLayout(arena: arena,
                       kind: syntaxKind,
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

  @_spi(RawSyntax)
  public func replacingChildSubrange<C: Collection>(
    _ range: Range<Int>,
    with elements: C,
    arena: SyntaxArena
  ) -> RawSyntax where C.Element == RawSyntax? {
    let newCount = children.count - range.count + elements.count
    return .makeLayout(arena: arena,
                       kind: syntaxKind,
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

  @_spi(RawSyntax)
  public func replacingLayout<C: Collection>(
    with elements: C,
    arena: SyntaxArena
  ) -> RawSyntax where C.Element == RawSyntax? {
    return .makeLayout(arena: arena,
                       kind: syntaxKind,
                       uninitializedCount: elements.count) { buffer in
      if buffer.isEmpty { return }
      _ = buffer.initialize(from: elements)
    }
  }

  /// Replaces the leading trivia of the first token in this syntax tree by
  /// `leadingTrivia`.
  /// If the syntax tree did not contain a token and thus no trivia could be
  /// attached to it, `nil` is returned.
  /// - Parameters:
  ///   - leadingTrivia: The trivia to attach.
  func withLeadingTrivia(_ newValue: Trivia) -> RawSyntax? {
    if isToken {
      return .makeMaterializedToken(
        arena: arena, kind: tokenKind,
        text: String(stringRef: tokenText!),
        leadingTrivia: newValue,
        trailingTrivia: Trivia.make(arena: arena, raw: trailingTrivia!))
    } else {
      for (index, raw) in children.enumerated() {
        if let raw = raw, let newRaw = raw.withLeadingTrivia(newValue) {
          return self.replacingChild(at: index, with: newRaw, arena: arena)
        }
      }
      return nil
    }
  }

  /// Replaces the trailing trivia of the first token in this syntax tree by
  /// `trailingTrivia`.
  /// If the syntax tree did not contain a token and thus no trivia could be
  /// attached to it, `nil` is returned.
  /// - Parameters:
  ///   - trailingTrivia: The trivia to attach.
  func withTrailingTrivia(_ newValue: Trivia) -> RawSyntax? {
    if isToken {
      return .makeMaterializedToken(
        arena: arena, kind: tokenKind,
        text: String(stringRef: tokenText!),
        leadingTrivia: Trivia.make(arena: arena, raw: leadingTrivia!),
        trailingTrivia: newValue)
    } else {
      for (index, raw) in children.enumerated().reversed() {
        if let raw = raw, let newRaw = raw.withTrailingTrivia(newValue) {
          return self.replacingChild(at: index, with: newRaw, arena: arena)
        }
      }
      return nil
    }
  }
}
