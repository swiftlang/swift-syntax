//===--------------- SourceLocation.swift - Source Locations --------------===//
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

/// Represent the user-facing part of SourceLocation that can be calculated
/// on demand.
struct ComputedLocation: Hashable, Codable, CustomDebugStringConvertible {
  /// The line in the file where this location resides. 1-based.
  let line: Int

  /// The UTF-8 byte offset from the beginning of the line where this location
  /// resides. 1-based.
  let column: Int

  /// The file in which this location resides.
  let file: String

  var debugDescription: String {
    // Print file name?
    return "\(line):\(column)"
  }

  init(line: Int, column: Int, file: String) {
    self.line = line
    self.column = column
    self.file = file
  }
  init(offset: Int, using converter: SourceLocationConverter) {
    let loc = converter.location(for: AbsolutePosition(utf8Offset: offset))
    assert(loc.offset == offset)
    self.line = loc.line!
    self.column = loc.column!
    self.file = loc.file!
  }
}

/// Represents a source location in a Swift file.
public struct SourceLocation: Hashable, Codable, CustomDebugStringConvertible {

  /// Line and column that can be computed on demand.
  private var compLoc: ComputedLocation?

  /// The UTF-8 byte offset into the file where this location resides.
  public let offset: Int

  /// The line in the file where this location resides. 1-based.
  public var line: Int? {
    return compLoc?.line
  }

  /// The UTF-8 byte offset from the beginning of the line where this location
  /// resides. 1-based.
  public var column: Int? {
    return compLoc?.column
  }

  /// The file in which this location resides.
  public var file: String? {
    return compLoc?.file
  }

  public var debugDescription: String {
    guard let compLoc = compLoc else {
      return "\(offset)"
    }
    return compLoc.debugDescription
  }

  public init(line: Int, column: Int, offset: Int, file: String) {
    self.offset = offset
    self.compLoc = ComputedLocation(line: line, column: column, file: file)
  }

  /// Initialize SourceLocation with a utf8 offset.
  /// If a SourceLocationConverter is given, line, column and file will be populated;
  /// otherwise they will be nil.
  public init(offset: Int, converter: SourceLocationConverter? = nil) {
    self.offset = offset
    if let converter = converter {
      self.compLoc = ComputedLocation(offset: offset, using: converter)
    }
  }
}

/// Represents a start and end location in a Swift file.
public struct SourceRange: Hashable, Codable, CustomDebugStringConvertible {

  /// The beginning location in the source range.
  public let start: SourceLocation

  /// The beginning location in the source range.
  public let end: SourceLocation

  public var debugDescription: String {
    return "(\(start.debugDescription),\(end.debugDescription))"
  }

  public init(start: SourceLocation, end: SourceLocation) {
    self.start = start
    self.end = end
  }
}

/// Converts `AbsolutePosition`s of syntax nodes to `SourceLocation`s, and
/// vice-versa. The `AbsolutePosition`s must be originating from nodes that are
/// part of the same tree that was used to initialize this class.
public final class SourceLocationConverter {
  let file: String
  /// Array of lines and the position at the start of the line.
  let lines: [AbsolutePosition]
  /// Position at end of file.
  let endOfFile: AbsolutePosition

  /// - Parameters:
  ///   - file: The file path associated with the syntax tree.
  ///   - tree: The root of the syntax tree to convert positions to line/columns for.
  public init<SyntaxType: SyntaxProtocol>(file: String, tree: SyntaxType) {
    assert(tree.parent == nil, "SourceLocationConverter must be passed the root of the syntax tree")
    self.file = file
    (self.lines, endOfFile) = computeLines(tree: Syntax(tree))
    assert(tree.byteSize == endOfFile.utf8Offset)
  }

  /// - Parameters:
  ///   - file: The file path associated with the syntax tree.
  ///   - source: The source code to convert positions to line/columns for.
  public init(file: String, source: String) {
    self.file = file
    (self.lines, endOfFile) = computeLines(source)
    assert(source.utf8.count == endOfFile.utf8Offset)
  }

  /// Convert a `AbsolutePosition` to a `SourceLocation`. If the position is
  /// exceeding the file length then the `SourceLocation` for the end of file
  /// is returned. If position is negative the location for start of file is
  /// returned.
  public func location(for origpos: AbsolutePosition) -> SourceLocation {
    // Clamp the given position to the end of file if needed.
    let pos = min(origpos, endOfFile)
    if pos.utf8Offset < 0 {
      return SourceLocation(line: 1, column: 1, offset: 0, file: self.file)
    }

    assert(!lines.isEmpty)
    var first = lines.startIndex
    var i: Int
    var step: Int
    var count = lines.endIndex - first
    // Do an upper bound search, first element that is > value. This provides
    // the line index coming after the one where the position belongs to.
    while count > 0 {
      step = count / 2
      i = first + step
      if !(pos < lines[i]) {
        first = i + 1
        count -= step + 1
      } else {
        count = step
      }
    }

    assert(first > 0)
    let lineIdx = first-1
    let lineStartOffset = lines[lineIdx].utf8Offset
    let colOffset = pos.utf8Offset - lineStartOffset

    let line = lineIdx+1
    let column = colOffset+1

    return SourceLocation(line: line, column: column,
      offset: pos.utf8Offset, file: self.file)
  }

  /// Convert a line/column to a `SourceLocation`. If the line/column exceeds
  /// the boundaries of the file or the line, the position returned is one
  /// adjusted to the closest boundary (beginning/end of file or line).
  ///
  /// - Parameters:
  ///   - line: A 1-based line number.
  ///   - column: A 1-based, UTF8 offset from the start of line.
  public func position(ofLine line: Int, column: Int) -> AbsolutePosition {
    let lineIdx = line-1
    guard lineIdx >= lines.startIndex else {
      return .startOfFile
    }
    guard lineIdx < lines.endIndex else {
      return self.endOfFile
    }
    let lineStart = lines[lineIdx]
    let lineEnd = lineIdx+1 < lines.endIndex ? lines[lineIdx+1] : self.endOfFile
    let colOffset = column-1
    guard colOffset >= 0 else {
      return lineStart
    }
    return min(lineStart+SourceLength(utf8Length: colOffset), lineEnd)
  }

  /// Returns false if the `position` is out-of-bounds for the file.
  public func isValid(position pos: AbsolutePosition) -> Bool {
    return pos >= .startOfFile && pos <= self.endOfFile
  }

  /// Returns false if the `line`/`column` pair is out-of-bounds for the file or
  /// that specific line.
  public func isValid(line: Int, column: Int) -> Bool {
    let lineIdx = line-1
    guard lineIdx >= lines.startIndex else {
      return false
    }
    guard lineIdx < lines.endIndex else {
      return false
    }
    let lineStart = lines[lineIdx]
    let lineEnd = lineIdx+1 < lines.endIndex ? lines[lineIdx+1] : self.endOfFile
    let colOffset = column-1
    guard colOffset >= 0 else {
      return false
    }
    return lineStart+SourceLength(utf8Length: colOffset) <= lineEnd
  }
}

public extension Syntax {
  /// The starting location, in the provided file, of this Syntax node.
  /// - Parameters:
  ///   - converter: The `SourceLocationConverter` that was previously
  ///     initialized using the root tree of this node.
  ///   - afterLeadingTrivia: Whether to skip leading trivia when getting
  ///                         the node's location. Defaults to `true`.
  func startLocation(
    converter: SourceLocationConverter,
    afterLeadingTrivia: Bool = true
  ) -> SourceLocation {
    let pos = afterLeadingTrivia ?
      data.positionAfterSkippingLeadingTrivia :
      data.position
    return converter.location(for: pos)
  }

  /// The ending location, in the provided file, of this Syntax node.
  /// - Parameters:
  ///   - converter: The `SourceLocationConverter` that was previously
  ///     initialized using the root tree of this node.
  ///   - afterTrailingTrivia: Whether to skip trailing trivia when getting
  ///                          the node's location. Defaults to `false`.
  func endLocation(
    converter: SourceLocationConverter,
    afterTrailingTrivia: Bool = false
  ) -> SourceLocation {
    var pos = data.position
    pos += raw.leadingTriviaLength
    pos += raw.contentLength
    if afterTrailingTrivia {
      pos += raw.trailingTriviaLength
    }
    return converter.location(for: pos)
  }

  /// The source range, in the provided file, of this Syntax node.
  /// - Parameters:
  ///   - converter: The `SourceLocationConverter` that was previously
  ///     initialized using the root tree of this node.
  ///   - afterLeadingTrivia: Whether to skip leading trivia when getting
  ///                          the node's start location. Defaults to `true`.
  ///   - afterTrailingTrivia: Whether to skip trailing trivia when getting
  ///                          the node's end location. Defaults to `false`.
  func sourceRange(
    converter: SourceLocationConverter,
    afterLeadingTrivia: Bool = true,
    afterTrailingTrivia: Bool = false
  ) -> SourceRange {
    let start = startLocation(converter: converter, 
                              afterLeadingTrivia: afterLeadingTrivia)
    let end = endLocation(converter: converter, 
                          afterTrailingTrivia: afterTrailingTrivia)
    return SourceRange(start: start, end: end)
  }
}

public extension SyntaxProtocol {
  /// The starting location, in the provided file, of this Syntax node.
  /// - Parameters:
  ///   - converter: The `SourceLocationConverter` that was previously
  ///     initialized using the root tree of this node.
  ///   - afterLeadingTrivia: Whether to skip leading trivia when getting
  ///                         the node's location. Defaults to `true`.
  func startLocation(
    converter: SourceLocationConverter,
    afterLeadingTrivia: Bool = true
  ) -> SourceLocation {
    return _syntaxNode.startLocation(converter: converter, 
                                    afterLeadingTrivia: afterLeadingTrivia)
  }

  /// The ending location, in the provided file, of this Syntax node.
  /// - Parameters:
  ///   - converter: The `SourceLocationConverter` that was previously
  ///     initialized using the root tree of this node.
  ///   - afterTrailingTrivia: Whether to skip trailing trivia when getting
  ///                          the node's location. Defaults to `false`.
  func endLocation(
    converter: SourceLocationConverter,
    afterTrailingTrivia: Bool = false
  ) -> SourceLocation {
    return _syntaxNode.endLocation(converter: converter, 
                                  afterTrailingTrivia: afterTrailingTrivia)
  }

  /// The source range, in the provided file, of this Syntax node.
  /// - Parameters:
  ///   - converter: The `SourceLocationConverter` that was previously
  ///     initialized using the root tree of this node.
  ///   - afterLeadingTrivia: Whether to skip leading trivia when getting
  ///                          the node's start location. Defaults to `true`.
  ///   - afterTrailingTrivia: Whether to skip trailing trivia when getting
  ///                          the node's end location. Defaults to `false`.
  func sourceRange(
    converter: SourceLocationConverter,
    afterLeadingTrivia: Bool = true,
    afterTrailingTrivia: Bool = false
  ) -> SourceRange {
    return _syntaxNode.sourceRange(converter: converter, 
                                  afterLeadingTrivia: afterLeadingTrivia,
                                  afterTrailingTrivia: afterTrailingTrivia)
  }
}

/// Returns array of lines with the position at the start of the line and
/// the end-of-file position.
fileprivate func computeLines(
  tree: Syntax
) -> ([AbsolutePosition], AbsolutePosition) {
  var lines: [AbsolutePosition] = []
  // First line starts from the beginning.
  lines.append(.startOfFile)
  var position: AbsolutePosition = .startOfFile
  let addLine = { (lineLength: SourceLength) in
    position += lineLength
    lines.append(position)
  }
  var curPrefix: SourceLength = .zero
  for token in tree.tokens(viewMode: .sourceAccurate) {
    curPrefix = token.forEachLineLength(prefix: curPrefix, body: addLine)
  }
  position += curPrefix
  return (lines, position)
}

fileprivate func computeLines(_ source: String) ->
    ([AbsolutePosition], AbsolutePosition) {
  var lines: [AbsolutePosition] = []
  // First line starts from the beginning.
  lines.append(.startOfFile)
  var position: AbsolutePosition = .startOfFile
  let addLine = { (lineLength: SourceLength) in
    position += lineLength
    lines.append(position)
  }
  var curPrefix: SourceLength = .zero
  curPrefix = source.forEachLineLength(prefix: curPrefix, body: addLine)
  position += curPrefix
  return (lines, position)
}

fileprivate extension String {
  /// Walks and passes to `body` the `SourceLength` for every detected line,
  /// with the newline character included.
  /// - Returns: The leftover `SourceLength` at the end of the walk.
  func forEachLineLength(
    prefix: SourceLength = .zero, body: (SourceLength) -> ()
  ) -> SourceLength {
    let utf8 = self.utf8
    let startIndex = utf8.startIndex
    let endIndex = utf8.endIndex
    var curIdx = startIndex
    var lineLength = prefix
    let advanceLengthByOne = { ()->() in
      lineLength += SourceLength(utf8Length: 1)
      curIdx = utf8.index(after: curIdx)
    }

    while curIdx < endIndex {
      let char = utf8[curIdx]
      advanceLengthByOne()

      /// From https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#grammar_line-break
      /// * line-break → U+000A
      /// * line-break → U+000D
      /// * line-break → U+000D followed by U+000A
      let isNewline = { () -> Bool in
        if char == 10 { return true }
        if char == 13 {
          if curIdx < endIndex && utf8[curIdx] == 10 { advanceLengthByOne() }
          return true
        }
        return false
      }

      if isNewline() {
        body(lineLength)
        lineLength = .zero
      }
    }
    return lineLength
  }

  func containsSwiftNewline() -> Bool {
    return utf8.contains { $0 == 10 || $0 == 13 }
  }
}

fileprivate extension TriviaPiece {
  /// Walks and passes to `body` the `SourceLength` for every detected line,
  /// with the newline character included.
  /// - Returns: The leftover `SourceLength` at the end of the walk.
  func forEachLineLength(
    prefix: SourceLength = .zero, body: (SourceLength) -> ()
  ) -> SourceLength {
    var lineLength = prefix
    switch self {
    case let .spaces(count),
         let .tabs(count),
         let .verticalTabs(count),
         let .formfeeds(count):
      lineLength += SourceLength(utf8Length: count)
    case let .newlines(count),
         let .carriageReturns(count):
      let newLineLength = SourceLength(utf8Length: 1)
      body(lineLength + newLineLength)
      for _ in 1..<count {
        body(newLineLength)
      }
      lineLength = .zero
    case let .carriageReturnLineFeeds(count):
      let carriageReturnLineLength = SourceLength(utf8Length: 2)
      body(lineLength + carriageReturnLineLength)
      for _ in 1..<count {
        body(carriageReturnLineLength)
      }
      lineLength = .zero
    case let .shebang(text),
         let .lineComment(text),
         let .docLineComment(text):
      // Line comments are not supposed to contain newlines.
      assert(!text.containsSwiftNewline(), "line comment created that contained a new-line character")
      lineLength += SourceLength(utf8Length: text.utf8.count)
    case let .blockComment(text),
         let .docBlockComment(text),
         let .unexpectedText(text):
      lineLength = text.forEachLineLength(prefix: lineLength, body: body)
    }
    return lineLength
  }
}

fileprivate extension Trivia {
  /// Walks and passes to `body` the `SourceLength` for every detected line,
  /// with the newline character included.
  /// - Returns: The leftover `SourceLength` at the end of the walk.
  func forEachLineLength(
    prefix: SourceLength = .zero, body: (SourceLength) -> ()
  ) -> SourceLength {
    var curPrefix = prefix
    for piece in self {
      curPrefix = piece.forEachLineLength(prefix: curPrefix, body: body)
    }
    return curPrefix
  }
}

fileprivate extension TokenSyntax {
  /// Walks and passes to `body` the `SourceLength` for every detected line,
  /// with the newline character included.
  /// - Returns: The leftover `SourceLength` at the end of the walk.
  func forEachLineLength(
    prefix: SourceLength = .zero, body: (SourceLength) -> ()
  ) -> SourceLength {
    var curPrefix = prefix
    curPrefix = self.leadingTrivia.forEachLineLength(prefix: curPrefix, body: body)
    curPrefix = self.text.forEachLineLength(prefix: curPrefix, body: body)
    curPrefix = self.trailingTrivia.forEachLineLength(prefix: curPrefix, body: body)
    return curPrefix
  }
}
