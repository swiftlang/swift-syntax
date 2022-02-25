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

/// Represents the tail-allocated elements of `RawSyntax`'s `ManagedBuffer`.
typealias RawSyntaxDataElement = UInt64
fileprivate typealias DataElementPtr = UnsafePointer<RawSyntaxDataElement>
fileprivate typealias MutableDataElementPtr = UnsafeMutablePointer<RawSyntaxDataElement>

/// Convenience function to write a value into a `RawSyntaxDataElement`.
fileprivate func initializeElement<T>(_ ptr: MutableDataElementPtr, with value: T) {
  castElementAs(ptr).initialize(to: value)
}

/// Convenience function to read a value from a `RawSyntaxDataElement`.
fileprivate func readElement<T>(_ ptr: DataElementPtr) -> T {
  return castElementAs(ptr).pointee
}

fileprivate func castElementAs<T>(_ ptr: DataElementPtr) -> UnsafePointer<T> {
  assert(MemoryLayout<T>.alignment <= MemoryLayout<RawSyntaxDataElement>.alignment)
  return UnsafePointer<T>(OpaquePointer(ptr))
}

fileprivate func castElementAs<T>(_ ptr: MutableDataElementPtr) -> UnsafeMutablePointer<T> {
  assert(MemoryLayout<T>.alignment <= MemoryLayout<RawSyntaxDataElement>.alignment)
  return UnsafeMutableRawPointer(ptr).assumingMemoryBound(to: T.self)
}

/// Calculates the number of `RawSyntaxDataElement`s needed to fit the given
/// number of bytes.
fileprivate func numberOfElements(forBytes size: Int) -> Int {
  let (words, remainder) = size.quotientAndRemainder(
    dividingBy: MemoryLayout<RawSyntaxDataElement>.stride)
  let numOfElems = remainder == 0 ? words : words+1
  return numOfElems
}

/// Calculates the number of `RawSyntaxDataElement`s needed to fit the given
/// value.
fileprivate func numberOfElements<T>(for value: T) -> Int {
  return numberOfElements(forBytes: MemoryLayout<T>.size)
}

/// Convenience property to refer to an empty string buffer.
fileprivate var emptyStringBuffer: UnsafeBufferPointer<UInt8> {
  return .init(start: nil, count: 0)
}

/// Low-level data specific to token nodes.
///
/// There's additional data that are tail-allocated. The data are as follows:
///
/// * For a parsed token (`TokenData.isConstructed` is false):
///   * List of leading `CTriviaPiece`s
///   * List of trailing `CTriviaPiece`s
///   * A string buffer. If `TokenData.hasCustomText` is false then the buffer is empty
///     otherwise it contains the full text for the token, including the trivia.
///     `TokenData.hasCustomText` is true if there's any custom text in any of the trivia
///     or the token kind.
/// * For a constructed token (`TokenData.isConstructed` is true):
///   * A `ConstructedTokenData` value
///
/// Testing showed that, during parsing, copying the full token length, when
/// there is any custom text, is more efficient than trying to copy only the
/// individual strings from trivia or token kind containing custom text.
fileprivate struct TokenData {
  let leadingTriviaCount: UInt16
  let trailingTriviaCount: UInt16
  let tokenKind: CTokenKind
  /// Returns true if there's any custom text in any of the trivia or the token kind.
  ///
  /// If true then there is a string buffer in the tail-allocated storage for
  /// the full token range (including trivia).
  /// It is ignored for a constructed token node (`isConstructed` == true).
  let hasCustomText: Bool
  private let isConstructed: Bool

  private init(
    kind: CTokenKind,
    leadingTriviaCount: UInt16,
    trailingTriviaCount: UInt16,
    hasCustomText: Bool,
    isConstructed: Bool
  ) {
    self.tokenKind = kind
    self.leadingTriviaCount = leadingTriviaCount
    self.trailingTriviaCount = trailingTriviaCount
    self.hasCustomText = hasCustomText
    self.isConstructed = isConstructed
  }

  /// Returns header `RawSyntaxData` value and number of elements to tail-allocate.
  static func dataAndExtraCapacity(
    for cnode: CSyntaxNode
  ) -> (RawSyntaxData, Int) {
    assert(cnode.kind == 0)
    let data = cnode.token_data
    let leadingTriviaCount = Int(data.leading_trivia_count)
    let trailingTriviaCount = Int(data.trailing_trivia_count)
    let totalTrivia = leadingTriviaCount + trailingTriviaCount

    let hasTriviaText = { (count: Int, p: CTriviaPiecePtr?) -> Bool in
      for i in 0..<count {
        if TriviaPiece.hasText(kind: p![i].kind) { return true }
      }
      return false
    }
    let hasCustomText = TokenKind.hasText(kind: data.kind) ||
      hasTriviaText(leadingTriviaCount, data.leading_trivia) ||
      hasTriviaText(trailingTriviaCount, data.trailing_trivia)
    let textSize = hasCustomText ? Int(data.range.length) : 0

    let rawData: RawSyntaxData = .token(.init(kind: data.kind,
      leadingTriviaCount: data.leading_trivia_count,
      trailingTriviaCount: data.trailing_trivia_count,
      hasCustomText: hasCustomText, isConstructed: false))

    let capacity = totalTrivia + numberOfElements(forBytes: textSize)
    return (rawData, capacity)
  }

  /// Initializes the tail-allocated elements.
  static func initializeExtra(
    _ cnode: CSyntaxNode,
    source: String,
    hasCustomText: Bool,
    extraPtr: MutableDataElementPtr
  ) {
    let data = cnode.token_data
    let leadingTriviaCount = Int(data.leading_trivia_count)
    let trailingTriviaCount = Int(data.trailing_trivia_count)
    var curPtr = extraPtr
    for i in 0..<leadingTriviaCount {
      assert(MemoryLayout.size(ofValue: data.leading_trivia![i])
              <= MemoryLayout<RawSyntaxDataElement>.size)
      initializeElement(curPtr, with: data.leading_trivia![i])
      curPtr = curPtr.successor()
    }
    for i in 0..<trailingTriviaCount {
      assert(MemoryLayout.size(ofValue: data.trailing_trivia![i])
              <= MemoryLayout<RawSyntaxDataElement>.size)
      initializeElement(curPtr, with: data.trailing_trivia![i])
      curPtr = curPtr.successor()
    }

    if hasCustomText {
      // Copy the full token text, including trivia.
      let startOffset = Int(data.range.offset)
      let length = Int(data.range.length)
      let utf8 = source.utf8
      precondition(startOffset <= utf8.count)
      precondition(startOffset + length <= utf8.count)
      let begin = utf8.index(utf8.startIndex, offsetBy: startOffset)
      let end = utf8.index(begin, offsetBy: length)

      var charPtr = UnsafeMutableRawPointer(curPtr).assumingMemoryBound(to: UInt8.self)
      for ch in utf8[begin..<end] {
        charPtr.pointee = ch
        charPtr = charPtr.successor()
      }
    }
  }

  /// Returns header `RawSyntaxData` value and number of elements to tail-allocate.
  static func dataAndExtraCapacity(
    for data: ConstructedTokenData
  ) -> (RawSyntaxData, Int) {
    let rawData: RawSyntaxData = .token(.init(kind: /*irrelevant*/0,
      leadingTriviaCount: UInt16(truncatingIfNeeded: data.leadingTrivia.count),
      trailingTriviaCount: UInt16(truncatingIfNeeded: data.trailingTrivia.count),
      hasCustomText: /*irrelevant*/false, isConstructed: true))
    let capacity = numberOfElements(for: data)
    return (rawData, capacity)
  }

  /// Initializes the tail-allocated elements.
  static func initializeExtra(
    _ data: ConstructedTokenData,
    extraPtr: MutableDataElementPtr
  ) {
    initializeElement(extraPtr, with: data)
  }

  /// De-initializes memory from tail-allocated data.
  fileprivate func deinitialize(extraPtr: MutableDataElementPtr) {
    if isConstructed {
      let ptr: UnsafeMutablePointer<ConstructedTokenData> = castElementAs(extraPtr)
      ptr.deinitialize(count: 1)
    }
  }

  private var isParsed: Bool { return !isConstructed }

  private func parsedData(
    length: UInt32, extraPtr: DataElementPtr
  ) -> UnsafeParsedTokenData {
    assert(isParsed)
    let leadingTriviaCount = Int(self.leadingTriviaCount)
    let trailingTriviaCount = Int(self.trailingTriviaCount)
    var curPtr = extraPtr
    let leadingTriviaBuffer: UnsafeBufferPointer<CTriviaPiece> =
      .init(start: castElementAs(curPtr), count: leadingTriviaCount)
    curPtr = curPtr.advanced(by: leadingTriviaCount)
    let trailingTriviaBuffer: UnsafeBufferPointer<CTriviaPiece> =
      .init(start: castElementAs(curPtr), count: trailingTriviaCount)
    curPtr = curPtr.advanced(by: trailingTriviaCount)
    let textSize = hasCustomText ? Int(length) : 0
    let textBuffer: UnsafeBufferPointer<UInt8> =
      .init(start: castElementAs(curPtr), count: textSize)
    return .init(length: length, tokenKind: tokenKind,
      leadingTriviaBuffer: leadingTriviaBuffer,
      trailingTriviaBuffer: trailingTriviaBuffer,
      fullTextBuffer: textBuffer, hasCustomText: hasCustomText)
  }

  fileprivate func formTokenKind(
    length: UInt32, extraPtr: DataElementPtr
  ) -> TokenKind {
    if isParsed {
      let data = parsedData(length: length, extraPtr: extraPtr)
      return data.formTokenKind()
    } else {
      let tok: ConstructedTokenData = castElementAs(extraPtr).pointee
      return tok.kind
    }
  }

  /// Returns the leading `Trivia` length for a token node.
  /// - Returns: .zero if called on a layout node.
  fileprivate func getLeadingTriviaLength(
    length: UInt32, extraPtr: DataElementPtr
  ) -> SourceLength {
    if isParsed {
      let data = parsedData(length: length, extraPtr: extraPtr)
      return SourceLength(utf8Length: data.getLeadingTriviaLength())
    } else {
      let tok: ConstructedTokenData = castElementAs(extraPtr).pointee
      return tok.leadingTrivia.sourceLength
    }
  }

  /// Returns the trailing `Trivia` length for a token node.
  /// - Returns: .zero if called on a layout node.
  fileprivate func getTrailingTriviaLength(
    length: UInt32, extraPtr: DataElementPtr
  ) -> SourceLength {
    if isParsed {
      let data = parsedData(length: length, extraPtr: extraPtr)
      return SourceLength(utf8Length: data.getTrailingTriviaLength())
    } else {
      let tok: ConstructedTokenData = castElementAs(extraPtr).pointee
      return tok.trailingTrivia.sourceLength
    }
  }

  /// Returns the leading `Trivia` for a token node.
  /// - Returns: nil if called on a layout node.
  fileprivate func formLeadingTrivia(
    length: UInt32, extraPtr: DataElementPtr
  ) -> Trivia {
    if isParsed {
      let data = parsedData(length: length, extraPtr: extraPtr)
      return data.formLeadingTrivia()
    } else {
      let tok: ConstructedTokenData = castElementAs(extraPtr).pointee
      return tok.leadingTrivia
    }
  }

  /// Returns the trailing `Trivia` for a token node.
  /// - Returns: nil if called on a layout node.
  fileprivate func formTrailingTrivia(
    length: UInt32, extraPtr: DataElementPtr
  ) -> Trivia {
    if isParsed {
      let data = parsedData(length: length, extraPtr: extraPtr)
      return data.formTrailingTrivia()
    } else {
      let tok: ConstructedTokenData = castElementAs(extraPtr).pointee
      return tok.trailingTrivia
    }
  }

  fileprivate func withUnsafeTokenText<Result>(
    relativeOffset: Int,
    length: UInt32,
    extraPtr: DataElementPtr,
    _ body: (UnsafeTokenText) -> Result
  ) -> Result {
    if isParsed {
      let data = parsedData(length: length, extraPtr: extraPtr)
      return body(data.getTokenText(relativeOffset: relativeOffset))
    } else {
      let tok: ConstructedTokenData = castElementAs(extraPtr).pointee
      return tok.kind.withUnsafeTokenText(body)
    }
  }

  fileprivate func withUnsafeLeadingTriviaPiece<Result>(
    at index: Int,
    relativeOffset: Int,
    length: UInt32,
    extraPtr: DataElementPtr,
    _ body: (UnsafeTriviaPiece?) -> Result
  ) -> Result {
    if isParsed {
      let data = parsedData(length: length, extraPtr: extraPtr)
      return body(data.getLeadingTriviaPiece(at: index, relativeOffset: relativeOffset))
    } else {
      let tok: ConstructedTokenData = castElementAs(extraPtr).pointee
      guard index < tok.leadingTrivia.count else { return body(nil) }
      return tok.leadingTrivia[index].withUnsafeTriviaPiece(body)
    }
  }

  fileprivate func withUnsafeTrailingTriviaPiece<Result>(
    at index: Int,
    relativeOffset: Int,
    length: UInt32,
    extraPtr: DataElementPtr,
    _ body: (UnsafeTriviaPiece?) -> Result
  ) -> Result {
    if isParsed {
      let data = parsedData(length: length, extraPtr: extraPtr)
      return body(data.getTrailingTriviaPiece(at: index, relativeOffset: relativeOffset))
    } else {
      let tok: ConstructedTokenData = castElementAs(extraPtr).pointee
      guard index < tok.trailingTrivia.count else { return body(nil) }
      return tok.trailingTrivia[index].withUnsafeTriviaPiece(body)
    }
  }

  /// Prints the RawSyntax token.
  fileprivate func write<Target>(
    to target: inout Target, length: UInt32, extraPtr: DataElementPtr
  ) where Target: TextOutputStream {
    if isParsed {
      let data = parsedData(length: length, extraPtr: extraPtr)
      return data.write(to: &target)
    } else {
      let tok: ConstructedTokenData = castElementAs(extraPtr).pointee
      tok.write(to: &target)
    }
  }
}

/// Convenience wrapper over the tail-allocated data for a token node.
/// This is used only for tokens created during parsing.
fileprivate struct UnsafeParsedTokenData {
  let length: UInt32
  let tokenKind: CTokenKind
  let leadingTriviaBuffer: UnsafeBufferPointer<CTriviaPiece>
  let trailingTriviaBuffer: UnsafeBufferPointer<CTriviaPiece>
  let fullTextBuffer: UnsafeBufferPointer<UInt8>
  let hasCustomText: Bool

  func formTokenKind() -> TokenKind {
    if fullTextBuffer.isEmpty {
      // Fast path, there's no text in the buffer so no need to determine the
      // token length.
      return TokenKind.fromRawValue(kind: tokenKind, textBuffer: emptyStringBuffer)
    }
    let leadingTriviaLength = self.getLeadingTriviaLength()
    let trailingTriviaLength = self.getTrailingTriviaLength()
    let tokenLength = Int(length) - (leadingTriviaLength + trailingTriviaLength)
    let tokenText = getTextSlice(start: leadingTriviaLength, length: tokenLength)
    return TokenKind.fromRawValue(kind: tokenKind, textBuffer: tokenText)
  }

  func formLeadingTrivia() -> Trivia {
    var newPieces: [TriviaPiece] = []
    newPieces.reserveCapacity(leadingTriviaBuffer.count)
    if fullTextBuffer.isEmpty {
      // Fast path, there's no text in the buffer so no need to determine the
      // trivia piece length.
      for cpiece in leadingTriviaBuffer {
        let newPiece = TriviaPiece.fromRawValue(cpiece, textBuffer: emptyStringBuffer)
        newPieces.append(newPiece)
      }
    } else {
      var textOffset = 0
      for cpiece in leadingTriviaBuffer {
        let len = Int(cpiece.length)
        let textBuffer = getTextSlice(start: textOffset, length: len)
        let newPiece = TriviaPiece.fromRawValue(cpiece, textBuffer: textBuffer)
        newPieces.append(newPiece)
        textOffset += len
      }
    }
    return .init(pieces: newPieces)
  }

  func formTrailingTrivia() -> Trivia {
    var newPieces: [TriviaPiece] = []
    newPieces.reserveCapacity(trailingTriviaBuffer.count)
    if fullTextBuffer.isEmpty {
      // Fast path, there's no text in the buffer so no need to determine the
      // trivia piece length.
      for cpiece in trailingTriviaBuffer {
        let newPiece = TriviaPiece.fromRawValue(cpiece, textBuffer: emptyStringBuffer)
        newPieces.append(newPiece)
      }
    } else {
      let leadingTriviaLength = self.getLeadingTriviaLength()
      let trailingTriviaLength = self.getTrailingTriviaLength()
      let tokenLength = Int(length) - (leadingTriviaLength + trailingTriviaLength)
      var textOffset = leadingTriviaLength + tokenLength
      for cpiece in trailingTriviaBuffer {
        let len = Int(cpiece.length)
        let textBuffer = getTextSlice(start: textOffset, length: len)
        let newPiece = TriviaPiece.fromRawValue(cpiece, textBuffer: textBuffer)
        newPieces.append(newPiece)
        textOffset += len
      }
    }
    return .init(pieces: newPieces)
  }

  func getTokenText(relativeOffset: Int) -> UnsafeTokenText {
    let leadingTriviaLength = relativeOffset
    let trailingTriviaLength = self.getTrailingTriviaLength()
    let tokenLength = Int(length) - (leadingTriviaLength + trailingTriviaLength)
    let customText = fullTextBuffer.isEmpty ? emptyStringBuffer :
      getTextSlice(start: relativeOffset, length: tokenLength)
    return .init(kind: .fromRawValue(tokenKind), length: tokenLength, customText: customText)
  }

  func getLeadingTriviaPiece(
    at index: Int, relativeOffset: Int
  ) -> UnsafeTriviaPiece? {
    return getTriviaPiece(at: index, relativeOffset: relativeOffset,
      trivia: leadingTriviaBuffer)
  }

  func getTrailingTriviaPiece(
    at index: Int, relativeOffset: Int
  ) -> UnsafeTriviaPiece? {
    return getTriviaPiece(at: index, relativeOffset: relativeOffset,
      trivia: trailingTriviaBuffer)
  }

  private func getTriviaPiece(
    at index: Int,
    relativeOffset: Int,
    trivia: UnsafeBufferPointer<CTriviaPiece>
  ) -> UnsafeTriviaPiece? {
    guard index < trivia.count else { return nil }
    let cpiece = trivia[index]
    let length = Int(cpiece.length)
    let customText = fullTextBuffer.isEmpty ? emptyStringBuffer :
      getTextSlice(start: relativeOffset, length: length)
    return .init(kind: .fromRawValue(cpiece.kind), length: length, customText: customText)
  }

  func write<Target>(
    to target: inout Target
  ) where Target: TextOutputStream {
    if hasCustomText {
      // Fast path, we recorded the full token text, including trivia.
      // FIXME: A way to print the buffer directly and avoid the copy ?
      target.write(String.fromBuffer(fullTextBuffer))
    } else {
      func printTrivia(_ buf: UnsafeBufferPointer<CTriviaPiece>) {
        for cpiece in buf {
          let newPiece = TriviaPiece.fromRawValue(cpiece, textBuffer: emptyStringBuffer)
          newPiece.write(to: &target)
        }
      }
      printTrivia(leadingTriviaBuffer)
      let tokKind = TokenKind.fromRawValue(kind: tokenKind,
        textBuffer: emptyStringBuffer)
      target.write(tokKind.text)
      printTrivia(trailingTriviaBuffer)
    }
  }

  func getLeadingTriviaLength() -> Int {
    var len = 0
    for piece in leadingTriviaBuffer { len += Int(piece.length) }
    return len
  }

  func getTrailingTriviaLength() -> Int {
    var len = 0
    for piece in trailingTriviaBuffer { len += Int(piece.length) }
    return len
  }

  func getTextSlice(start: Int, length: Int) -> UnsafeBufferPointer<UInt8> {
    return .init(rebasing: fullTextBuffer[start..<start+length])
  }
}

/// Low-level data specific to layout nodes.
///
/// There's additional data that are tail-allocated. The data are as follows:
///
/// * For a parsed token (`LayoutData.isConstructed` is false):
///   * List of `CClientNode?` values
/// * For a constructed token (`LayoutData.isConstructed` is true):
///   * A `ConstructedLayoutData` value
fileprivate struct LayoutData {
  let nodeCount: UInt32
  let totalSubNodeCount: UInt32
  let syntaxKind: SyntaxKind
  private let isConstructed: Bool

  private init(
    kind: SyntaxKind,
    nodeCount: UInt32,
    totalSubNodeCount: UInt32,
    isConstructed: Bool
  ) {
    assert(kind != .token)
    self.syntaxKind = kind
    self.nodeCount = nodeCount
    self.totalSubNodeCount = totalSubNodeCount
    self.isConstructed = isConstructed
  }

  /// Returns header `RawSyntaxData` value, number of elements to tail-allocate
  /// and the total byte length of the node.
  static func dataExtraCapacityAndTotalLength(
    for kind: SyntaxKind,
    data: CLayoutData
  ) -> (data: RawSyntaxData, extraCapacity: Int, totalLength: Int) {
    var totalCount = 0
    var totalLength: Int = 0
    for i in 0..<Int(data.nodes_count) {
      if let raw = RawSyntax.getFromOpaque(data.nodes![i]) {
        totalCount += raw.totalNodes
        totalLength += raw.totalLength.utf8Length
      }
    }
    let totalSubNodeCount = UInt32(truncatingIfNeeded: totalCount)
    let rawData: RawSyntaxData = .layout(.init(kind: kind,
      nodeCount: data.nodes_count, totalSubNodeCount: totalSubNodeCount,
      isConstructed: false))
    return (rawData, Int(data.nodes_count), totalLength)
  }

  /// Initializes the tail-allocated elements.
  static func initializeExtra(
    _ data: CLayoutData,
    extraPtr: MutableDataElementPtr
  ) {
    var curPtr = extraPtr
    for i in 0..<Int(data.nodes_count) {
      assert(MemoryLayout.size(ofValue: data.nodes![i])
              <= MemoryLayout<RawSyntaxDataElement>.size)
      initializeElement(curPtr, with: data.nodes![i])
      curPtr = curPtr.successor()
    }
  }

  /// Returns header `RawSyntaxData` value and number of elements to tail-allocate.
  static func dataAndExtraCapacity(
    for kind: SyntaxKind,
    data: ConstructedLayoutData
  ) -> (RawSyntaxData, Int) {
    var totalCount = 0
    for raw in data.layout {
      totalCount += raw?.totalNodes ?? 0
    }
    let rawData: RawSyntaxData = .layout(.init(kind: kind,
      nodeCount: UInt32(truncatingIfNeeded: data.layout.count),
      totalSubNodeCount: UInt32(truncatingIfNeeded: totalCount),
      isConstructed: true))
    let capacity = numberOfElements(for: data)
    return (rawData, capacity)
  }

  /// Initializes the tail-allocated elements.
  static func initializeExtra(
    _ data: ConstructedLayoutData,
    extraPtr: MutableDataElementPtr
  ) {
    initializeElement(extraPtr, with: data)
  }

  /// De-initializes memory from tail-allocated data.
  fileprivate func deinitialize(extraPtr: MutableDataElementPtr) {
    if isParsed {
      for i in 0..<numberOfChildren {
        let cnode: CClientNode? = readElement(extraPtr.advanced(by: i))
        _ = RawSyntax.moveFromOpaque(cnode)
      }
    } else {
      let ptr: UnsafeMutablePointer<ConstructedLayoutData> = castElementAs(extraPtr)
      ptr.deinitialize(count: 1)
    }
  }

  private var isParsed: Bool { return !isConstructed }

  /// Total number of nodes in this sub-tree, including `self` node.
  var totalNodes: Int {
    return Int(totalSubNodeCount) + 1
  }

  var numberOfChildren: Int {
    return Int(nodeCount)
  }

  func child(
    at index: Int,
    extraPtr: DataElementPtr
  ) -> RawSyntax? {
    if isParsed {
      let cnode: CClientNode? = readElement(extraPtr.advanced(by: index))
      return RawSyntax.getFromOpaque(cnode)
    } else {
      let p: UnsafePointer<ConstructedLayoutData> = castElementAs(extraPtr)
      return p.pointee.layout[index]
    }
  }

  func hasChild(
    at index: Int,
    extraPtr: DataElementPtr
  ) -> Bool {
    if isParsed {
      let cnode: CClientNode? = readElement(extraPtr.advanced(by: index))
      return cnode != nil
    } else {
      let p: UnsafePointer<ConstructedLayoutData> = castElementAs(extraPtr)
      return p.pointee.layout[index] != nil
    }
  }

  func formLayoutArray(extraPtr: DataElementPtr) -> [RawSyntax?] {
    if isParsed {
      var layout: [RawSyntax?] = []
      layout.reserveCapacity(numberOfChildren)
      let p: UnsafePointer<CClientNode?> = castElementAs(extraPtr)
      for i in 0..<numberOfChildren {
        layout.append(.getFromOpaque(p[i]))
      }
      return layout
    } else {
      let p: UnsafePointer<ConstructedLayoutData> = castElementAs(extraPtr)
      return p.pointee.layout
    }
  }
}

/// Value used when a token is programmatically constructed, instead of the
/// parser producing it.
fileprivate struct ConstructedTokenData {
  let kind: TokenKind
  let leadingTrivia: Trivia
  let trailingTrivia: Trivia

  func write<Target>(
    to target: inout Target
  ) where Target: TextOutputStream {
    for piece in leadingTrivia {
      piece.write(to: &target)
    }
    target.write(kind.text)
    for piece in trailingTrivia {
      piece.write(to: &target)
    }
  }
}

/// Value used when a layout node is programmatically constructed, instead of the
/// parser producing it.
fileprivate struct ConstructedLayoutData {
  let layout: [RawSyntax?]
}

/// The data that is specific to a tree or token node
fileprivate enum RawSyntaxData {
  /// A token with a token kind, leading trivia, and trailing trivia
  case token(TokenData)
  /// A tree node with a kind and an array of children
  case layout(LayoutData)
}

/// Header for `RawSyntax`.
struct RawSyntaxBase {
  fileprivate let data: RawSyntaxData
  fileprivate let byteLength: UInt32
  fileprivate let isPresent: Bool

  fileprivate init(data: RawSyntaxData, byteLength: Int, isPresent: Bool) {
    self.data = data
    self.byteLength = UInt32(truncatingIfNeeded: byteLength)
    self.isPresent = isPresent
  }

  fileprivate func deinitialize(extraPtr: MutableDataElementPtr) {
    switch data {
    case .token(let data): data.deinitialize(extraPtr: extraPtr)
    case .layout(let data): data.deinitialize(extraPtr: extraPtr)
    }
  }

  fileprivate var kind: SyntaxKind {
    switch data {
    case .token(_): return .token
    case .layout(let data): return data.syntaxKind
    }
  }

  fileprivate var isToken: Bool {
    switch data {
    case .token(_): return true
    case .layout(_): return false
    }
  }

  fileprivate func child(
    at index: Int,
    extraPtr: DataElementPtr
  ) -> RawSyntax? {
    switch data {
    case .token(_): return nil
    case .layout(let data): return data.child(at: index, extraPtr: extraPtr)
    }
  }

  fileprivate func hasChild(
    at index: Int,
    extraPtr: DataElementPtr
  ) -> Bool {
    switch data {
    case .token(_): return false
    case .layout(let data): return data.hasChild(at: index, extraPtr: extraPtr)
    }
  }

  /// The number of children, `present` or `missing`, in this node.
  fileprivate var numberOfChildren: Int {
    switch data {
    case .token(_): return 0
    case .layout(let data): return data.numberOfChildren
    }
  }

  /// Total number of nodes in this sub-tree, including `self` node.
  fileprivate var totalNodes: Int {
    switch data {
    case .token(_): return 1
    case .layout(let data): return data.totalNodes
    }
  }

  fileprivate func formLayoutArray(extraPtr: DataElementPtr) -> [RawSyntax?] {
    switch data {
    case .token(_): return []
    case .layout(let data): return data.formLayoutArray(extraPtr: extraPtr)
    }
  }

  /// Returns the `TokenKind` for a token node.
  /// - Returns: nil if called on a layout node.
  fileprivate func formTokenKind(extraPtr: DataElementPtr) -> TokenKind? {
    switch data {
    case .token(let data):
      return data.formTokenKind(length: byteLength, extraPtr: extraPtr)
    case .layout(_): return nil
    }
  }

  /// Returns the leading `Trivia` length for a token node.
  /// - Returns: .zero if called on a layout node.
  fileprivate func getTokenLeadingTriviaLength(
    extraPtr: DataElementPtr
  ) -> SourceLength {
    switch data {
    case .token(let data):
      return data.getLeadingTriviaLength(length: byteLength, extraPtr: extraPtr)
    case .layout(_): return .zero
    }
  }

  /// Returns the trailing `Trivia` length for a token node.
  /// - Returns: .zero if called on a layout node.
  fileprivate func getTokenTrailingTriviaLength(
    extraPtr: DataElementPtr
  ) -> SourceLength {
    switch data {
    case .token(let data):
      return data.getTrailingTriviaLength(length: byteLength, extraPtr: extraPtr)
    case .layout(_): return .zero
    }
  }

  /// Returns the leading `Trivia` for a token node.
  /// - Returns: nil if called on a layout node.
  fileprivate func formTokenLeadingTrivia(extraPtr: DataElementPtr) -> Trivia? {
    switch data {
    case .token(let data):
      return data.formLeadingTrivia(length: byteLength, extraPtr: extraPtr)
    case .layout(_): return nil
    }
  }

  /// Returns the trailing `Trivia` for a token node.
  /// - Returns: nil if called on a layout node.
  fileprivate func formTokenTrailingTrivia(extraPtr: DataElementPtr) -> Trivia? {
    switch data {
    case .token(let data):
      return data.formTrailingTrivia(length: byteLength, extraPtr: extraPtr)
    case .layout(_): return nil
    }
  }

  fileprivate func withUnsafeTokenText<Result>(
    relativeOffset: Int,
    extraPtr: DataElementPtr,
    _ body: (UnsafeTokenText?) -> Result
  ) -> Result {
    switch data {
    case .token(let data):
      return data.withUnsafeTokenText(relativeOffset: relativeOffset,
        length: byteLength, extraPtr: extraPtr, body)
    case .layout(_): return body(nil)
    }
  }

  fileprivate func withUnsafeLeadingTriviaPiece<Result>(
    at index: Int,
    relativeOffset: Int,
    extraPtr: DataElementPtr,
    _ body: (UnsafeTriviaPiece?) -> Result
  ) -> Result {
    switch data {
    case .token(let data):
      return data.withUnsafeLeadingTriviaPiece(at: index, relativeOffset: relativeOffset,
        length: byteLength, extraPtr: extraPtr, body)
    case .layout(_): return body(nil)
    }
  }

  fileprivate func withUnsafeTrailingTriviaPiece<Result>(
    at index: Int,
    relativeOffset: Int,
    extraPtr: DataElementPtr,
    _ body: (UnsafeTriviaPiece?) -> Result
  ) -> Result {
    switch data {
    case .token(let data):
      return data.withUnsafeTrailingTriviaPiece(at: index, relativeOffset: relativeOffset,
        length: byteLength, extraPtr: extraPtr, body)
    case .layout(_): return body(nil)
    }
  }

  /// Prints the RawSyntax token. If self is a layout node it does nothing.
  fileprivate func writeToken<Target>(
    to target: inout Target, extraPtr: DataElementPtr
  ) where Target: TextOutputStream {
    switch data {
    case .token(let data):
      data.write(to: &target, length: byteLength, extraPtr: extraPtr)
    case .layout(_): return
    }
  }
}

/// Represents the raw tree structure underlying the syntax tree. These nodes
/// have no notion of identity and only provide structure to the tree. They
/// are immutable and can be freely shared between syntax nodes.
///
/// This is using ManagedBuffer as its underlying storage in order to reduce
/// heap allocations down to a single one, when it's created by the parser.
final class RawSyntax: ManagedBuffer<RawSyntaxBase, RawSyntaxDataElement> {
  /// Create a token or layout node using the C parser library object.
  static func create(
    from p: UnsafePointer<CSyntaxNode>,
    source: String
  ) -> RawSyntax {
    let cnode = p.pointee
    let isPresent = cnode.present

    let data: RawSyntaxData
    let capacity: Int
    let byteLength: Int
    if cnode.kind == 0 {
      (data, capacity) = TokenData.dataAndExtraCapacity(for: cnode)
      byteLength = Int(cnode.token_data.range.length)
    } else {
      (data, capacity, byteLength) = LayoutData.dataExtraCapacityAndTotalLength(
        for: SyntaxKind.fromRawValue(cnode.kind), data: cnode.layout_data)
    }
    let buffer = self.create(minimumCapacity: capacity) { _ in
      RawSyntaxBase(data: data, byteLength: byteLength, isPresent: isPresent)
    }

    let raw = unsafeDowncast(buffer, to: RawSyntax.self)
    raw.withUnsafeMutablePointers {
      switch $0.pointee.data {
      case .token(let tokdata):
        TokenData.initializeExtra(cnode, source: source,
          hasCustomText: tokdata.hasCustomText, extraPtr: $1)
      case .layout(_):
        LayoutData.initializeExtra(cnode.layout_data, extraPtr: $1)
      }
    }
    return raw
  }

  /// Create a layout node using the programmatic APIs.
  static func create(
    kind: SyntaxKind,
    layout: [RawSyntax?],
    length: SourceLength,
    presence: SourcePresence
  ) -> RawSyntax {
    let layoutData = ConstructedLayoutData(layout: layout)
    let (data, capacity) =
      LayoutData.dataAndExtraCapacity(for: kind, data: layoutData)
    let buffer = self.create(minimumCapacity: capacity) { _ in
      RawSyntaxBase(data: data, byteLength: length.utf8Length,
        isPresent: presence == .present)
    }
    let raw = unsafeDowncast(buffer, to: RawSyntax.self)
    raw.withUnsafeMutablePointerToElements {
      LayoutData.initializeExtra(layoutData, extraPtr: $0)
    }
    return raw
  }

  /// Create a token node using the programmatic APIs.
  static func create(
    kind: TokenKind,
    leadingTrivia: Trivia,
    trailingTrivia: Trivia,
    length: SourceLength,
    presence: SourcePresence
  ) -> RawSyntax {
    let tokdata = ConstructedTokenData(kind: kind, leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia)
    let (data, capacity) = TokenData.dataAndExtraCapacity(for: tokdata)
    let buffer = self.create(minimumCapacity: capacity) { _ in
      RawSyntaxBase(data: data, byteLength: length.utf8Length,
        isPresent: presence == .present)
    }
    let raw = unsafeDowncast(buffer, to: RawSyntax.self)
    raw.withUnsafeMutablePointerToElements {
      TokenData.initializeExtra(tokdata, extraPtr: $0)
    }
    return raw
  }

  deinit {
    return withUnsafeMutablePointers {
      $0.pointee.deinitialize(extraPtr: $1)
    }
  }

  /// The syntax kind of this raw syntax.
  var kind: SyntaxKind {
    return header.kind
  }

  /// Whether or not this node is a token one.
  var isToken: Bool {
    return header.isToken
  }

  func child(at index: Int) -> RawSyntax? {
    return withUnsafeMutablePointers {
      $0.pointee.child(at: index, extraPtr: $1)
    }
  }

  func hasChild(at index: Int) -> Bool {
    return withUnsafeMutablePointers {
      $0.pointee.hasChild(at: index, extraPtr: $1)
    }
  }

  /// The number of children, `present` or `missing`, in this node.
  var numberOfChildren: Int {
    return header.numberOfChildren
  }

  /// Total number of nodes in this sub-tree, including `self` node.
  var totalNodes: Int {
    return header.totalNodes
  }

  /// Whether this node is present in the original source.
  var isPresent: Bool {
    return header.isPresent
  }

  /// Whether this node is missing from the original source.
  var isMissing: Bool {
    return !isPresent
  }

  var presence: SourcePresence {
    return isPresent ? .present : .missing
  }

  var totalLength: SourceLength {
    return SourceLength(utf8Length: Int(header.byteLength))
  }

  func formTokenKind() -> TokenKind? {
    return withUnsafeMutablePointers {
      $0.pointee.formTokenKind(extraPtr: $1)
    }
  }

  /// Returns the leading `Trivia` length for a token node.
  /// - Returns: .zero if called on a layout node.
  var tokenLeadingTriviaLength: SourceLength {
    return withUnsafeMutablePointers {
      $0.pointee.getTokenLeadingTriviaLength(extraPtr: $1)
    }
  }

  /// Returns the trailing `Trivia` length for a token node.
  /// - Returns: .zero if called on a layout node.
  var tokenTrailingTriviaLength: SourceLength {
    return withUnsafeMutablePointers {
      $0.pointee.getTokenTrailingTriviaLength(extraPtr: $1)
    }
  }

  /// Returns the leading `Trivia` for a token node.
  /// - Returns: nil if called on a layout node.
  func formTokenLeadingTrivia() -> Trivia? {
    return withUnsafeMutablePointers {
      $0.pointee.formTokenLeadingTrivia(extraPtr: $1)
    }
  }

  /// Returns the trailing `Trivia` for a token node.
  /// - Returns: nil if called on a layout node.
  func formTokenTrailingTrivia() -> Trivia? {
    return withUnsafeMutablePointers {
      $0.pointee.formTokenTrailingTrivia(extraPtr: $1)
    }
  }

  /// Passes token info to the provided closure as `UnsafeTokenText`.
  /// - Parameters:
  ///   - relativeOffset: For efficiency, the caller keeps track of the relative
  ///     byte offset (from start of leading trivia) of the token text, to avoid
  ///     calculating it within this function.
  ///   - body: The closure that accepts the `UnsafeTokenText` value. This value
  ///     must not escape the closure.
  /// - Returns: Return value of `body`.
  func withUnsafeTokenText<Result>(
    relativeOffset: Int,
    _ body: (UnsafeTokenText?) -> Result
  ) -> Result {
    return withUnsafeMutablePointers {
      $0.pointee.withUnsafeTokenText(relativeOffset: relativeOffset,
        extraPtr: $1, body)
    }
  }

  /// Passes trivia piece info to the provided closure as `UnsafeTriviaPiece`.
  /// - Parameters:
  ///   - at: The index for the trivia piace.
  ///   - relativeOffset: For efficiency, the caller keeps track of the relative
  ///     byte offset (from start of leading trivia) of the trivia piece text,
  ///     to avoid calculating it within this function.
  ///   - body: The closure that accepts the `UnsafeTokenText` value. This value
  ///     must not escape the closure.
  /// - Returns: Return value of `body`.
  func withUnsafeLeadingTriviaPiece<Result>(
    at index: Int,
    relativeOffset: Int,
    _ body: (UnsafeTriviaPiece?) -> Result
  ) -> Result {
    return withUnsafeMutablePointers {
      $0.pointee.withUnsafeLeadingTriviaPiece(at: index,
        relativeOffset: relativeOffset, extraPtr: $1, body)
    }
  }

  /// Passes trivia piece info to the provided closure as `UnsafeTriviaPiece`.
  /// - Parameters:
  ///   - at: The index for the trivia piace.
  ///   - relativeOffset: For efficiency, the caller keeps track of the relative
  ///     byte offset (from start of leading trivia) of the trivia piece text,
  ///     to avoid calculating it within this function.
  ///   - body: The closure that accepts the `UnsafeTokenText` value. This value
  ///     must not escape the closure.
  /// - Returns: Return value of `body`.
  func withUnsafeTrailingTriviaPiece<Result>(
    at index: Int,
    relativeOffset: Int,
    _ body: (UnsafeTriviaPiece?) -> Result
  ) -> Result {
    return withUnsafeMutablePointers {
      $0.pointee.withUnsafeTrailingTriviaPiece(at: index,
        relativeOffset: relativeOffset, extraPtr: $1, body)
    }
  }

  func formLayoutArray() -> [RawSyntax?] {
    return withUnsafeMutablePointers {
      $0.pointee.formLayoutArray(extraPtr: $1)
    }
  }

  /// Replaces the leading trivia of the first token in this syntax tree by `leadingTrivia`.
  /// If the syntax tree did not contain a token and thus no trivia could be attached to it, `nil` is returned.
  /// - Parameters:
  ///   - leadingTrivia: The trivia to attach.
  func withLeadingTrivia(_ leadingTrivia: Trivia) -> RawSyntax? {
    if isToken {
      return RawSyntax.createAndCalcLength(
        kind: formTokenKind()!,
        leadingTrivia: leadingTrivia,
        trailingTrivia: formTrailingTrivia()!,
        presence: presence)
    } else {
      var layout = formLayoutArray()
      for (index, raw) in layout.enumerated() {
        if let raw = raw, let newRaw = raw.withLeadingTrivia(leadingTrivia) {
          layout[index] = newRaw
          return replacingLayout(layout)
        }
      }
      return nil
    }
  }

  /// Replaces the trailing trivia of the first token in this syntax tree by `trailingTrivia`.
  /// If the syntax tree did not contain a token and thus no trivia could be attached to it, `nil` is returned.
  /// - Parameters:
  ///   - trailingTrivia: The trivia to attach.
  func withTrailingTrivia(_ trailingTrivia: Trivia) -> RawSyntax? {
    if isToken {
      return RawSyntax.createAndCalcLength(
        kind: formTokenKind()!,
        leadingTrivia: formLeadingTrivia()!,
        trailingTrivia: trailingTrivia,
        presence: presence)
    } else {
      var layout = formLayoutArray()
      for (index, raw) in layout.enumerated().reversed() {
        if let raw = raw, let newRaw = raw.withTrailingTrivia(trailingTrivia) {
          layout[index] = newRaw
          return replacingLayout(layout)
        }
      }
      return nil
    }
  }

  /// Creates a RawSyntax node that's marked missing in the source with the
  /// provided kind and layout.
  /// - Parameters:
  ///   - kind: The syntax kind underlying this node.
  ///   - layout: The children of this node.
  /// - Returns: A new RawSyntax `.node` with the provided kind and layout, with
  ///            `.missing` source presence.
  static func missing(_ kind: SyntaxKind) -> RawSyntax {
    return create(kind: kind, layout: [], length: .zero, presence: .missing)
  }

  /// Creates a RawSyntax token that's marked missing in the source with the
  /// provided kind and no leading/trailing trivia.
  /// - Parameter kind: The token kind.
  /// - Returns: A new RawSyntax `.token` with the provided kind, no
  ///            leading/trailing trivia, and `.missing` source presence.
  static func missingToken(_ kind: TokenKind) -> RawSyntax {
    return create(kind: kind, leadingTrivia: [], trailingTrivia: [],
      length: .zero, presence: .missing)
  }

  /// Returns a new RawSyntax node with the provided layout instead of the
  /// existing layout.
  /// - Note: This function does nothing with `.token` nodes --- the same token
  ///         is returned.
  /// - Parameter newLayout: The children of the new node you're creating.
  func replacingLayout(_ newLayout: [RawSyntax?]) -> RawSyntax {
    if isToken { return self }
    return .createAndCalcLength(kind: kind, layout: newLayout, presence: presence)
  }

  /// Creates a new RawSyntax with the provided child appended to its layout.
  /// - Parameter child: The child to append
  /// - Note: This function does nothing with `.token` nodes --- the same token
  ///         is returned.
  /// - Return: A new RawSyntax node with the provided child at the end.
  func appending(_ child: RawSyntax) -> RawSyntax {
    var newLayout = formLayoutArray()
    newLayout.append(child)
    return replacingLayout(newLayout)
  }

  /// Returns the child at the provided cursor in the layout.
  /// - Parameter index: The index of the child you're accessing.
  /// - Returns: The child at the provided index.
  subscript<CursorType: RawRepresentable>(_ index: CursorType) -> RawSyntax?
    where CursorType.RawValue == Int {
      return child(at: index.rawValue)
  }

  /// Replaces the child at the provided index in this node with the provided
  /// child.
  /// - Parameters:
  ///   - index: The index of the child to replace.
  ///   - newChild: The new child that should occupy that index in the node.
  func replacingChild(_ index: Int,
                      with newChild: RawSyntax?) -> RawSyntax {
    precondition(index < numberOfChildren, "Cursor \(index) reached past layout")
    var newLayout = formLayoutArray()
    newLayout[index] = newChild
    return replacingLayout(newLayout)
  }
}

extension RawSyntax {
  static func moveFromOpaque(_ cn: CClientNode) -> RawSyntax {
    return Unmanaged<RawSyntax>.fromOpaque(cn).takeRetainedValue()
  }

  static func moveFromOpaque(_ cn: CClientNode?) -> RawSyntax? {
    return cn.map(moveFromOpaque)
  }

  static func getFromOpaque(_ cn: CClientNode?) -> RawSyntax? {
    if let subnode = cn {
      return Unmanaged<RawSyntax>.fromOpaque(subnode).takeUnretainedValue()
    } else {
      return nil
    }
  }
}

extension RawSyntax: TextOutputStreamable, CustomStringConvertible {
  /// Prints the RawSyntax node, and all of its children, to the provided
  /// stream. This implementation must be source-accurate.
  /// - Parameter stream: The stream on which to output this node.
  func write<Target>(to target: inout Target)
    where Target: TextOutputStream {
    guard isPresent else { return }
    if isToken {
      withUnsafeMutablePointers {
        $0.pointee.writeToken(to: &target, extraPtr: $1)
      }
    } else {
      for i in 0..<self.numberOfChildren {
        self.child(at: i)?.write(to: &target)
      }
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
  var firstPresentToken: RawSyntax? {
    guard isPresent else { return nil }
    if isToken { return self }
    for i in 0..<self.numberOfChildren {
      if let token = self.child(at: i)?.firstPresentToken {
        return token
      }
    }
    return nil
  }

  /// Return the last `present` token of a layout node or self if it is a token.
  var lastPresentToken: RawSyntax? {
    guard isPresent else { return nil }
    if isToken { return self }
    for i in (0..<self.numberOfChildren).reversed() {
      if let token = self.child(at: i)?.lastPresentToken {
        return token
      }
    }
    return nil
  }

  func formLeadingTrivia() -> Trivia? {
    guard let token = self.firstPresentToken else { return nil }
    return token.formTokenLeadingTrivia()
  }

  func formTrailingTrivia() -> Trivia? {
    guard let token = self.lastPresentToken else { return nil }
    return token.formTokenTrailingTrivia()
  }
}

extension RawSyntax {
  var leadingTriviaLength: SourceLength {
    guard let token = self.firstPresentToken else { return .zero }
    return token.tokenLeadingTriviaLength
  }

  var trailingTriviaLength: SourceLength {
    guard let token = self.lastPresentToken else { return .zero }
    return token.tokenTrailingTriviaLength
  }

  /// The length of this node excluding its leading and trailing trivia.
  var contentLength: SourceLength {
    return totalLength - (leadingTriviaLength + trailingTriviaLength)
  }

  var tokenContentLength: SourceLength {
    return totalLength - (tokenLeadingTriviaLength + tokenTrailingTriviaLength)
  }

  /// Convenience function to create a RawSyntax when its byte length is not
  /// known in advance, e.g. it is programmatically constructed instead of
  /// created by the parser.
  ///
  /// This is a separate function than in the initializer to make it more
  /// explicit and visible in the code for the instances where we don't have
  /// the length of the raw node already available.
  static func createAndCalcLength(kind: SyntaxKind, layout: [RawSyntax?],
      presence: SourcePresence) -> RawSyntax {
    let length: SourceLength
    if case .missing = presence {
      length = SourceLength.zero
    } else {
      var totalen = SourceLength.zero
      for child in layout {
        totalen += child?.totalLength ?? .zero
      }
      length = totalen
    }
    return create(kind: kind, layout: layout, length: length, presence: presence)
  }

  /// Convenience function to create a RawSyntax when its byte length is not
  /// known in advance, e.g. it is programmatically constructed instead of
  /// created by the parser.
  ///
  /// This is a separate function than in the initializer to make it more
  /// explicit and visible in the code for the instances where we don't have
  /// the length of the raw node already available.
  static func createAndCalcLength(kind: TokenKind, leadingTrivia: Trivia,
      trailingTrivia: Trivia, presence: SourcePresence) -> RawSyntax {
    let length: SourceLength
    if case .missing = presence {
      length = SourceLength.zero
    } else {
      length = kind.sourceLength + leadingTrivia.sourceLength +
        trailingTrivia.sourceLength
    }
    return create(kind: kind, leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia, length: length, presence: presence)
  }
}

/// Token info with its custom text as `UnsafeBufferPointer`. This is only safe
/// to use from within the `withUnsafeTokenText` methods.
internal struct UnsafeTokenText {
  let kind: RawTokenKind
  let length: Int
  let customText: UnsafeBufferPointer<UInt8>

  init(kind: RawTokenKind, length: Int) {
    self.kind = kind
    self.length = length
    self.customText = .init(start: nil, count: 0)
  }

  init(kind: RawTokenKind, length: Int, customText: UnsafeBufferPointer<UInt8>) {
    self.kind = kind
    self.length = length
    self.customText = customText
  }
}

/// Trivia piece info with its custom text as `UnsafeBufferPointer`. This is
/// only safe to use from within the `withUnsafeLeadingTriviaPiece` and
/// `withUnsafeTrailingTriviaPiece` methods.
internal struct UnsafeTriviaPiece {
  let kind: TriviaPieceKind
  let length: Int
  let customText: UnsafeBufferPointer<UInt8>

  init(kind: TriviaPieceKind, length: Int) {
    self.kind = kind
    self.length = length
    self.customText = .init(start: nil, count: 0)
  }

  init(kind: TriviaPieceKind, length: Int, customText: UnsafeBufferPointer<UInt8>) {
    self.kind = kind
    self.length = length
    self.customText = customText
  }

  static func fromRawValue(
    _ piece: CTriviaPiece, textBuffer: UnsafeBufferPointer<UInt8>
  ) -> UnsafeTriviaPiece {
    return UnsafeTriviaPiece(kind: .fromRawValue(piece.kind),
      length: Int(piece.length), customText: textBuffer)
  }
}
