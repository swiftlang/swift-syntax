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

@_spi(RawSyntax)
public typealias RawSyntaxBuffer = UnsafeBufferPointer<RawSyntax?>

/// Node data for RawSyntax tree. Tagged union plus common data.
internal struct RawSyntaxData {
  internal enum Payload {
    case parsedToken(ParsedToken)
    case materializedToken(MaterializedToken)
    case layout(Layout)
//    case garbage(Garbage)
//    case unparsed(Unparsed)
  }

  /// Parsed token. The text is a slice from the source buffer whose lifetime
  /// extends past this node. I.e. the buffer should be managed by the
  /// SyntaxArena.
  struct ParsedToken {
    var tokenKind: TokenKind
    var wholeText: StringRef
    var tokenTextRange: Range<StringRef.Index>
  }

  /// Token tyoically created with `SyntaxFactory.makeToken()`.
  struct MaterializedToken {
    var tokenKind: TokenKind
    var tokenText: StringRef
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

  /// [UNUSED] Collection of tokens.
  struct Garbage {
    var content: RawSyntaxBuffer
    var byteLength: Int
  }

  /// [UNUSED] Source region to be parsed. (delayed parsing)
  struct Unparsed {
    var kind: SyntaxKind
    var content: StringRef
  }

  fileprivate var payload: Payload
  fileprivate unowned(unsafe) var arena: SyntaxArena
}

extension RawSyntaxData.ParsedToken {
  var leadingTriviaText: StringRef {
    wholeText[..<tokenTextRange.lowerBound]
  }
  var tokenText: StringRef {
    wholeText[tokenTextRange]
  }
  var trailingTriviaText: StringRef {
    wholeText[tokenTextRange.upperBound...]
  }
  var byteLength: Int {
    wholeText.count
  }
}

extension RawSyntaxData.MaterializedToken {
  var leadingTrivia: RawTriviaPieceBuffer {
    RawTriviaPieceBuffer(rebasing: triviaPieces[..<Int(numLeadingTrivia)])
  }
  var trailingTrivia: RawTriviaPieceBuffer {
    RawTriviaPieceBuffer(rebasing: triviaPieces[Int(numLeadingTrivia)...])
  }
}

/// Represents the raw tree structure underlying the syntax tree.
///
/// Each node have no notion of identity nor a parent reference, and only
/// provide structure to the tree. They are immutable and can be freely shared
/// between syntax nodes.
@_spi(RawSyntax)
public struct RawSyntax {

  /// Pointer to the actual data which resides in a SyntaxArena.
  var pointer: UnsafePointer<RawSyntaxData>
  init(pointer: UnsafePointer<RawSyntaxData>) {
    self.pointer = pointer
  }

  init(arena: SyntaxArena, payload: RawSyntaxData.Payload) {
    self.init(pointer: arena.intern(RawSyntaxData(payload: payload, arena: arena)))
  }

  public static func parsedToken(
    arena: SyntaxArena,
    kind: TokenKind,
    wholeText: StringRef,
    tokenTextRange: Range<StringRef.Index>
  ) -> RawSyntax {
    let payload = RawSyntaxData.ParsedToken(
      tokenKind: kind, wholeText: wholeText, tokenTextRange: tokenTextRange)
    return RawSyntax(arena: arena, payload: .parsedToken(payload))
  }

  /// Factory method to create a materialized token node.
  ///
  /// - Parameters:
  ///   - arena: SyntaxArea to the result node data resides.
  ///   - kind: Token kind.
  ///   - text: Token text.
  ///   - leadingTrivia: Leading trivia.
  ///   - trailingTrivia: Trailing trivia.
  public static func materializedToken(
    arena: SyntaxArena,
    kind: TokenKind,
    text: StringRef,
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

  public static func layout(
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

  private var rawData: RawSyntaxData {
    unsafeAddress { pointer }
  }

  internal var arena: SyntaxArena {
    _read { yield rawData.arena }
  }

  internal var payload: RawSyntaxData.Payload {
    _read { yield rawData.payload }
  }
}

extension RawSyntax {
  @_spi(RawSyntax)
  public func toOpaque() -> UnsafeRawPointer {
    UnsafeRawPointer(pointer)
  }

  @_spi(RawSyntax)
  public static func fromOpaque(_ pointer: UnsafeRawPointer) -> RawSyntax {
    Self(pointer: pointer.assumingMemoryBound(to: RawSyntaxData.self))
  }
}

// MARK: - Accessors

extension RawSyntax {
  /// The "width" of the node.
  ///
  /// Sum of text byte lengths of all descendant token nodes.
  @_spi(RawSyntax)
  public var byteLength: Int {
    switch rawData.payload {
    case .materializedToken(let dat): return Int(dat.byteLength)
    case .parsedToken(let dat): return dat.byteLength
    case .layout(let dat): return dat.byteLength
//    case .garbage(let dat): return dat.byteLength
//    case .unparsed(let dat): return dat.content.count
    }
  }

  /// Total number of nodes in this sub-tree, including `self` node.
  @_spi(RawSyntax)
  public var nodeCount: Int {
    switch rawData.payload {
    case .materializedToken(_): return 1
    case .parsedToken(_): return 1
    case .layout(let dat): return dat.descendantCount + 1
//    case .garbage(_): return 0
//    case .unparsed(_): return 1
    }
  }

  /// Child nodes.
  @_spi(RawSyntax)
  public var children: RawSyntaxBuffer {
    switch rawData.payload {
    case .materializedToken(_): return .init(start: nil, count: 0)
    case .parsedToken(_): return .init(start: nil, count: 0)
    case .layout(let dat): return dat.layout
//    case .garbage(let dat): return dat.content
//    case .unparsed(_): return .init(start: nil, count: 0)
    }
  }

  /// Syntax kind of this node.
  @_spi(RawSyntax)
  public var syntaxKind: SyntaxKind {
    switch rawData.payload {
    case .materializedToken(_): return .token
    case .parsedToken(_): return .token
    case .layout(let dat): return dat.kind
//    case .garbage(_): return .unknown
//    case .unparsed(let dat): return dat.kind
    }
  }

  @_spi(RawSyntax)
  public var isToken: Bool {
    syntaxKind == .token
  }

  @_spi(RawSyntax)
  public var isCollection: Bool {
    syntaxKind.isSyntaxCollection
  }

  @_spi(RawSyntax)
  public var isUnknown: Bool {
    syntaxKind.isUnknown
  }

  @_spi(RawSyntax)
  public var isMissing: Bool {
    self.byteLength == 0 && !self.isCollection && !self.isUnknown
  }
  
  /// Token kind of this node if this node is a token. '.unknown' otherwise.
  @_spi(RawSyntax)
  public var tokenKind: TokenKind {
    // FIXME: Should we trap if it's not a token?
    switch rawData.payload {
    case .layout(_): return .unknown
    case .materializedToken(let dat): return dat.tokenKind
    case .parsedToken(let dat): return dat.tokenKind
//    case .garbage(_): return .unknown
//    case .unparsed(_): return .unknown
    }
  }

  /// Token text of this node if this node is a token. 'nil' otherwise.
  @_spi(RawSyntax)
  public var tokenText: StringRef? {
    // FIXME: Should we trap if it's not a token?
    switch rawData.payload {
    case .materializedToken(let dat): return dat.tokenText
    case .parsedToken(let dat): return dat.tokenText
    case .layout(_): return nil
//    case .garbage(_): return nil
//    case .unparsed(_): return nil
    }
  }

  /// Leading trivia text of this node if this node is a token. 'nil' otherwise.
  @_spi(RawSyntax)
  var leadingTrivia: RawTrivia? {
    // FIXME: Should we trap if it's not a token?
    switch rawData.payload {
    case .materializedToken(let dat): return .materialized(dat.leadingTrivia)
    case .parsedToken(let dat): return .unparsed(dat.leadingTriviaText)
    case .layout(_): return nil
//    case .garbage(_): return nil
//    case .unparsed(_): return nil
    }
  }

  /// Trailing trivia text of this node if this node is a token. 'nil' otherwise.
  @_spi(RawSyntax)
  var trailingTrivia: RawTrivia? {
    // FIXME: Should we trap if it's not a token?
    switch rawData.payload {
    case .materializedToken(let dat): return .materialized(dat.trailingTrivia)
    case .parsedToken(let dat): return .unparsed(dat.trailingTriviaText)
    case .layout(_): return nil
//    case .garbage(_): return nil
//    case .unparsed(_): return nil
    }
  }

  /// Leading trivia text of this node if this node is a token. 'nil' otherwise.
  var leadingTriviaByteLength: Int {
    // FIXME: Should we trap if it's not a token?
    switch rawData.payload {
    case .materializedToken(let dat):
      return dat.leadingTrivia.reduce(0) { $0 + $1.byteLength }
    case .parsedToken(let dat):
      return dat.leadingTriviaText.count
    case .layout(_):
      return 0
//    case .garbage(_): return nil
//    case .unparsed(_): return nil
    }
  }

  /// Leading trivia text of this node if this node is a token. 'nil' otherwise.
  var trailingTriviaByteLength: Int {
    // FIXME: Should we trap if it's not a token?
    switch rawData.payload {
    case .materializedToken(let dat):
      return dat.trailingTrivia.reduce(0) { $0 + $1.byteLength }
    case .parsedToken(let dat):
      return dat.trailingTriviaText.count
    case .layout(_):
      return 0
//    case .garbage(_): return nil
//    case .unparsed(_): return nil
    }
  }

}

extension RawSyntax: Identifiable {
  public var id: Int {
    Int(bitPattern: pointer)
  }

  public static func === (lhs: Self, rhs: Self) -> Bool {
    return lhs.pointer == rhs.pointer
  }
}

extension RawSyntax: TextOutputStreamable {
  public func write<Target: TextOutputStream>(to target: inout Target) {
    switch rawData.payload {
    case .parsedToken(let dat):
      String(describing: dat.wholeText).write(to: &target)
      break
    case .materializedToken(let dat):
      for p in dat.leadingTrivia { p.write(to: &target) }
      String(stringRef: dat.tokenText).write(to: &target)
      for p in dat.trailingTrivia { p.write(to: &target) }
      break
    case .layout(let dat):
      for case let child? in dat.layout {
        child.write(to: &target)
      }
      break
//    case .garbage(let dat):
//      for case let child? in dat.content {
//        child.write(to: &target)
//      }
//      break
//    case .unparsed(let dat):
//      target.write(dat.content.description)
//      break
    }
  }
}

// MARK: - Debugging.

extension RawSyntax: CustomDebugStringConvertible {

  private func debugWrite<Target: TextOutputStream>(to target: inout Target, indent: Int, withChildren: Bool = false) {
    let childIndent = indent + 2
    switch rawData.payload {
    case .parsedToken(let dat):
      target.write(".parsedToken(")
      target.write(dat.tokenKind.kind)
      target.write(" wholeText=\(dat.wholeText.debugDescription)")
      target.write(" textRange=\(dat.tokenTextRange.debugDescription)")
      break
    case .materializedToken(let dat):
      target.write(".materializedToken(")
      target.write(dat.tokenKind.kind)
      target.write(" text=\(dat.tokenText.debugDescription)")
      target.write(" numLeadingTrivia=\(dat.numLeadingTrivia)")
      target.write(" byteLength=\(dat.byteLength)")
      break
    case .layout(let dat):
      target.write(".layout(")
      target.write(String(describing: syntaxKind))
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
//    case .garbage(let dat):
//      target.write(".garbage(")
//      for (num, child) in dat.content.enumerated() {
//        target.write("\n")
//        target.write(String(repeating: " ", count: childIndent))
//        target.write("\(num): ")
//        child!.debugWrite(to: &target, indent: childIndent)
//      }
//      break
//    case .unparsed(let dat):
//      target.write(".unparsed(")
//      target.write(dat.content.debugDescription)
    }
    target.write(")")
  }

  public var debugDescription: String {
    var string = ""
    debugWrite(to: &string, indent: 0, withChildren: false)
    return string
  }
}

extension RawSyntax: CustomReflectable {
  public var customMirror: Mirror {
    let mirrorChildren: [Any] = children.map {
      child in child ?? (nil as Any?) as Any
    }
    return Mirror(self, unlabeledChildren: mirrorChildren)
  }
}
