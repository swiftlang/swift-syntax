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

/// Represents a source location in a Swift file.
public struct SourceLocation: Hashable, Codable, Sendable {

  /// The line in the file where this location resides. 1-based.
  ///
  /// - SeeAlso: ``SourceLocation/presumedLine``
  public var line: Int

  /// The UTF-8 byte offset from the beginning of the line where this location
  /// resides. 1-based.
  public let column: Int

  /// The UTF-8 byte offset into the file where this location resides.
  public let offset: Int

  /// The file in which this location resides.
  ///
  /// - SeeAlso: ``SourceLocation/presumedFile``
  public let file: String

  /// The line of this location when respecting `#sourceLocation` directives.
  ///
  /// If the location hasn’t been adjusted using `#sourceLocation` directives,
  /// this is the same as `line`.
  public let presumedLine: Int

  /// The file in which the location resides when respecting `#sourceLocation`
  /// directives.
  ///
  /// If the location has been adjusted using `#sourceLocation` directives, this
  /// is the file mentioned in the last `#sourceLocation` directive before this
  /// location, otherwise this is the same as `file`.
  public let presumedFile: String

  /// Create a new source location at the specified `line` and `column` in `file`.
  ///
  /// - Parameters:
  ///   - line: 1-based, i.e. the first line in the file has line number 1
  ///   - column: The UTF-8 byte offset of the location with its line, i.e. the
  ///             number of bytes all characters in the line before the location
  ///             occupy when encoded as UTF-8. 1-based, i.e. the leftmost
  ///             column in the file has column 1.
  ///   - offset: The UTF-8 offset of the location within the entire file, i.e.
  ///             the number of bytes all source code before the location
  ///             occupies when encoded as UTF-8. 0-based, i.e. the first
  ///             location in the source file has `offset` 0.
  ///   - file: A string describing the name of the file in which this location
  ///           is contained.
  ///   - presumedLine: If the location has been adjusted using `#sourceLocation`
  ///                   directives, the adjusted line. If `nil`, this defaults to
  ///                   `line`.
  ///   - presumedFile: If the location has been adjusted using `#sourceLocation`
  ///                   directives, the adjusted file. If `nil`, this defaults to
  ///                   `file`.
  public init(
    line: Int,
    column: Int,
    offset: Int,
    file: String,
    presumedLine: Int? = nil,
    presumedFile: String? = nil
  ) {
    self.line = line
    self.offset = offset
    self.column = column
    self.file = file
    self.presumedLine = presumedLine ?? line
    self.presumedFile = presumedFile ?? file
  }
}

/// Represents a half-open range in a Swift file.
public struct SourceRange: Hashable, Codable, Sendable {

  /// The beginning location of the source range.
  ///
  /// This location is included in the range
  public let start: SourceLocation

  /// The end location of the source range.
  ///
  /// The location of the character after the end of the range,
  /// ie. this location is not included in the range.
  public let end: SourceLocation

  /// Construct a new source range, starting at `start` (inclusive) and ending
  /// at `end` (exclusive).
  public init(start: SourceLocation, end: SourceLocation) {
    self.start = start
    self.end = end
  }
}

/// Collects all `PoundSourceLocationSyntax` directives in a file.
fileprivate class SourceLocationCollector: SyntaxVisitor {
  private var sourceLocationDirectives: [PoundSourceLocationSyntax] = []

  override func visit(_ node: PoundSourceLocationSyntax) -> SyntaxVisitorContinueKind {
    sourceLocationDirectives.append(node)
    return .skipChildren
  }

  static func collectSourceLocations(in tree: some SyntaxProtocol) -> [PoundSourceLocationSyntax] {
    let collector = SourceLocationCollector(viewMode: .sourceAccurate)
    collector.walk(tree)
    return collector.sourceLocationDirectives
  }
}

fileprivate struct SourceLocationDirectiveArguments {
  enum Error: Swift.Error, CustomStringConvertible {
    case nonDecimalLineNumber(TokenSyntax)
    case stringInterpolationInFileName(SimpleStringLiteralExprSyntax)

    var description: String {
      switch self {
      case .nonDecimalLineNumber(let token):
        return "'\(token.text)' is not a decimal integer"
      case .stringInterpolationInFileName(let stringLiteral):
        return "The string literal '\(stringLiteral)' contains string interpolation, which is not allowed"
      }
    }
  }

  /// The `file` argument of the `#sourceLocation` directive.
  let file: String

  /// The `line` argument of the `#sourceLocation` directive.
  let line: Int

  init(_ args: PoundSourceLocationArgumentsSyntax) throws {
    guard args.fileName.segments.count == 1,
      let segment = args.fileName.segments.first
    else {
      throw Error.stringInterpolationInFileName(args.fileName)
    }
    self.file = segment.content.text
    guard let line = Int(args.lineNumber.text) else {
      throw Error.nonDecimalLineNumber(args.lineNumber)
    }
    self.line = line
  }
}

/// Converts ``AbsolutePosition``s of syntax nodes to ``SourceLocation``s, and
/// vice-versa. The ``AbsolutePosition``s must be originating from nodes that are
/// part of the same tree that was used to initialize this class.
public final class SourceLocationConverter {
  private let fileName: String
  /// The source of the file, modeled as data so it can contain invalid UTF-8.
  private let source: [UInt8]
  /// Array of lines and the position at the start of the line.
  private let lines: [AbsolutePosition]
  /// Position at end of file.
  private let endOfFile: AbsolutePosition

  /// The information from all `#sourceLocation` directives in the file
  /// necessary to compute presumed locations.
  ///
  /// - `sourceLine` is the line at which the `#sourceLocation` statement occurs
  ///   within the current file.
  /// - `arguments` are the `file` and `line` arguments of the directive or `nil`
  ///   if spelled as `#sourceLocation()` to reset the source location directive.
  private var sourceLocationDirectives: [(sourceLine: Int, arguments: SourceLocationDirectiveArguments?)] = []

  /// Create a new ``SourceLocationConverter`` to convert between ``AbsolutePosition``
  /// and ``SourceLocation`` in a syntax tree.
  ///
  /// This converter ignores any malformed `#sourceLocation` directives, e.g.
  /// `#sourceLocation` directives with a non-decimal line number or with a file
  /// name that contains string interpolation.
  ///
  /// - Parameters:
  ///   - fileName: The file path associated with the syntax tree.
  ///   - tree: The root of the syntax tree to convert positions to line/columns for.
  public init(fileName: String, tree: some SyntaxProtocol) {
    precondition(tree.parent == nil, "SourceLocationConverter must be passed the root of the syntax tree")
    self.fileName = fileName
    self.source = tree.syntaxTextBytes
    (self.lines, endOfFile) = computeLines(tree: Syntax(tree))
    precondition(tree.totalLength.utf8Length == endOfFile.utf8Offset)

    for directive in SourceLocationCollector.collectSourceLocations(in: tree) {
      let location = self.physicalLocation(for: directive.positionAfterSkippingLeadingTrivia)
      if let args = directive.arguments {
        if let parsedArgs = try? SourceLocationDirectiveArguments(args) {
          // Ignore any malformed `#sourceLocation` directives.
          sourceLocationDirectives.append((sourceLine: location.line, arguments: parsedArgs))
        }
      } else {
        // `#sourceLocation()` without any arguments resets the `#sourceLocation` directive.
        sourceLocationDirectives.append((sourceLine: location.line, arguments: nil))
      }
    }
  }

  /// Create a new ``SourceLocationConverter`` to convert between ``AbsolutePosition``
  /// and ``SourceLocation`` in a syntax tree.
  ///
  /// This initializer is deprecated. Please use `init(fileName:source:)` instead.
  ///
  /// This converter ignores any malformed `#sourceLocation` directives, e.g.
  /// `#sourceLocation` directives with a non-decimal line number or with a file
  /// name that contains string interpolation.
  ///
  /// - Parameters:
  ///   - file: The file path associated with the syntax tree.
  ///   - tree: The root of the syntax tree to convert positions to line/columns for.
  @available(*, deprecated, message: "Use init(fileName:tree:) instead")
  public convenience init(file: String, tree: SyntaxProtocol) {
    self.init(fileName: file, tree: tree)
  }

  /// - Important: This initializer does not take `#sourceLocation` directives
  ///              into account and doesn’t produce `presumedFile` and
  ///              `presumedLine`.
  ///
  /// - Parameters:
  ///   - file: The file path associated with the syntax tree.
  ///   - source: The source code to convert positions to line/columns for.
  @available(*, deprecated, message: "Use init(fileName:tree:) instead")
  public init(file: String, source: String) {
    self.fileName = file
    self.source = Array(source.utf8)
    (self.lines, endOfFile) = self.source.withUnsafeBufferPointer { buf in
      // Technically, `buf` is not allocated in a `SyntaxArena` but it satisfies
      // all the required properties: `buf` will always outlive any references
      // to it.
      let syntaxArenaBuf = SyntaxArenaAllocatedBufferPointer(buf)
      return computeLines(SyntaxText(buffer: syntaxArenaBuf))
    }
    precondition(source.utf8.count == endOfFile.utf8Offset)
  }

  /// Execute the body with an array that contains each source line.
  func withSourceLines<T>(_ body: ([SyntaxText]) throws -> T) rethrows -> T {
    return try source.withUnsafeBufferPointer { (sourcePointer: UnsafeBufferPointer<UInt8>) in
      var result: [SyntaxText] = []
      var previousLoc = AbsolutePosition.startOfFile
      precondition(lines.first == AbsolutePosition.startOfFile)
      for lineStartLoc in lines.dropFirst() + [endOfFile] {
        result.append(
          SyntaxText(
            baseAddress: sourcePointer.baseAddress?.advanced(by: previousLoc.utf8Offset),
            count: lineStartLoc.utf8Offset - previousLoc.utf8Offset
          )
        )
        previousLoc = lineStartLoc
      }
      return try body(result)
    }
  }

  /// Return the source lines of the file as `String`s.
  /// Because `String` cannot model invalid UTF-8, the concatenation of these source lines might not be source-accurate in case there are Unicode errors in the source file, but for most practical purposes, this should not pose an issue.
  public var sourceLines: [String] {
    return withSourceLines { syntaxTextLines in
      return syntaxTextLines.map { String(syntaxText: $0) }
    }
  }

  /// Convert a ``AbsolutePosition`` to a ``SourceLocation``.
  ///
  /// If the position is exceeding the file length then the ``SourceLocation``
  /// for the end of file is returned. If position is negative the location for
  /// start of file is returned.
  public func location(for position: AbsolutePosition) -> SourceLocation {
    let physicalLocation = physicalLocation(for: position)
    if let lastSourceLocationDirective = sourceLocationDirectives.last(where: { $0.sourceLine < physicalLocation.line }),
      let arguments = lastSourceLocationDirective.arguments
    {
      let presumedLine = arguments.line + physicalLocation.line - lastSourceLocationDirective.sourceLine - 1
      return SourceLocation(
        line: physicalLocation.line,
        column: physicalLocation.column,
        offset: physicalLocation.offset,
        file: physicalLocation.file,
        presumedLine: presumedLine,
        presumedFile: arguments.file
      )
    }

    return physicalLocation
  }

  /// Compute the location of `position` without taking `#sourceLocation`
  /// directives into account.
  ///
  /// If the position is
  /// exceeding the file length then the ``SourceLocation`` for the end of file
  /// is returned. If position is negative the location for start of file is
  /// returned.
  private func physicalLocation(for position: AbsolutePosition) -> SourceLocation {
    // Clamp the given position to the end of file if needed.
    let pos = min(position, endOfFile)
    if pos.utf8Offset < 0 {
      return SourceLocation(line: 1, column: 1, offset: 0, file: self.fileName)
    }

    precondition(!lines.isEmpty)
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

    precondition(first > 0)
    let lineIdx = first - 1
    let lineStartOffset = lines[lineIdx].utf8Offset
    let colOffset = pos.utf8Offset - lineStartOffset

    let line = lineIdx + 1
    let column = colOffset + 1

    return SourceLocation(
      line: line,
      column: column,
      offset: pos.utf8Offset,
      file: self.fileName
    )
  }

  /// Convert a line/column to a ``SourceLocation``. If the line/column exceeds
  /// the boundaries of the file or the line, the position returned is one
  /// adjusted to the closest boundary (beginning/end of file or line).
  ///
  /// - Parameters:
  ///   - line: A 1-based line number.
  ///   - column: A 1-based, UTF8 offset from the start of line.
  public func position(ofLine line: Int, column: Int) -> AbsolutePosition {
    let lineIdx = line - 1
    guard lineIdx >= lines.startIndex else {
      return .startOfFile
    }
    guard lineIdx < lines.endIndex else {
      return self.endOfFile
    }
    let lineStart = lines[lineIdx]
    let lineEnd = lineIdx + 1 < lines.endIndex ? lines[lineIdx + 1] : self.endOfFile
    let colOffset = column - 1
    guard colOffset >= 0 else {
      return lineStart
    }
    return min(lineStart + SourceLength(utf8Length: colOffset), lineEnd)
  }

  /// Returns false if the `position` is out-of-bounds for the file.
  public func isValid(position pos: AbsolutePosition) -> Bool {
    return pos >= .startOfFile && pos <= self.endOfFile
  }

  /// Returns false if the `line`/`column` pair is out-of-bounds for the file or
  /// that specific line.
  public func isValid(line: Int, column: Int) -> Bool {
    let lineIdx = line - 1
    guard lineIdx >= lines.startIndex else {
      return false
    }
    guard lineIdx < lines.endIndex else {
      return false
    }
    let lineStart = lines[lineIdx]
    let lineEnd = lineIdx + 1 < lines.endIndex ? lines[lineIdx + 1] : self.endOfFile
    let colOffset = column - 1
    guard colOffset >= 0 else {
      return false
    }
    return lineStart + SourceLength(utf8Length: colOffset) <= lineEnd
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
    let pos = afterLeadingTrivia ? positionAfterSkippingLeadingTrivia : position
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
    var pos = position
    pos += raw.leadingTriviaLength
    pos += raw.trimmedLength
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
    let start = startLocation(
      converter: converter,
      afterLeadingTrivia: afterLeadingTrivia
    )
    let end = endLocation(
      converter: converter,
      afterTrailingTrivia: afterTrailingTrivia
    )
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
    return _syntaxNode.startLocation(
      converter: converter,
      afterLeadingTrivia: afterLeadingTrivia
    )
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
    return _syntaxNode.endLocation(
      converter: converter,
      afterTrailingTrivia: afterTrailingTrivia
    )
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
    return _syntaxNode.sourceRange(
      converter: converter,
      afterLeadingTrivia: afterLeadingTrivia,
      afterTrailingTrivia: afterTrailingTrivia
    )
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

fileprivate func computeLines(_ source: SyntaxText) -> ([AbsolutePosition], AbsolutePosition) {
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

fileprivate extension SyntaxText {
  /// Walks and passes to `body` the ``SourceLength`` for every detected line,
  /// with the newline character included.
  /// - Returns: The leftover ``SourceLength`` at the end of the walk.
  func forEachLineLength(
    prefix: SourceLength = .zero,
    body: (SourceLength) -> ()
  ) -> SourceLength {
    //    let startIndex = utf8.startIndex
    //    let endIndex = utf8.endIndex
    var curIdx = startIndex
    var lineLength = prefix
    let advanceLengthByOne = { () -> () in
      lineLength += SourceLength(utf8Length: 1)
      curIdx = self.index(after: curIdx)
    }

    while curIdx < endIndex {
      let char = self[curIdx]
      advanceLengthByOne()

      /// From https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#grammar_line-break
      /// * line-break → U+000A
      /// * line-break → U+000D
      /// * line-break → U+000D followed by U+000A
      let isNewline = { () -> Bool in
        if char == 10 { return true }
        if char == 13 {
          if curIdx < endIndex && self[curIdx] == 10 { advanceLengthByOne() }
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
    return self.contains { $0 == 10 || $0 == 13 }
  }
}

fileprivate extension RawTriviaPiece {
  /// Walks and passes to `body` the ``SourceLength`` for every detected line,
  /// with the newline character included.
  /// - Returns: The leftover ``SourceLength`` at the end of the walk.
  func forEachLineLength(
    prefix: SourceLength = .zero,
    body: (SourceLength) -> ()
  ) -> SourceLength {
    var lineLength = prefix
    switch self {
    case let .spaces(count),
      let .tabs(count),
      let .verticalTabs(count),
      let .formfeeds(count),
      let .backslashes(count),
      let .pounds(count):
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
    case let .lineComment(text),
      let .docLineComment(text):
      // Line comments are not supposed to contain newlines.
      precondition(!text.containsSwiftNewline(), "line comment created that contained a new-line character")
      lineLength += SourceLength(utf8Length: text.count)
    case let .blockComment(text),
      let .docBlockComment(text),
      let .unexpectedText(text):
      lineLength = text.forEachLineLength(prefix: lineLength, body: body)
    }
    return lineLength
  }
}

fileprivate extension Array where Element == RawTriviaPiece {
  /// Walks and passes to `body` the ``SourceLength`` for every detected line,
  /// with the newline character included.
  /// - Returns: The leftover ``SourceLength`` at the end of the walk.
  func forEachLineLength(
    prefix: SourceLength = .zero,
    body: (SourceLength) -> ()
  ) -> SourceLength {
    var curPrefix = prefix
    for piece in self {
      curPrefix = piece.forEachLineLength(prefix: curPrefix, body: body)
    }
    return curPrefix
  }
}

fileprivate extension TokenSyntax {
  /// Walks and passes to `body` the ``SourceLength`` for every detected line,
  /// with the newline character included.
  /// - Returns: The leftover ``SourceLength`` at the end of the walk.
  func forEachLineLength(
    prefix: SourceLength = .zero,
    body: (SourceLength) -> ()
  ) -> SourceLength {
    var curPrefix = prefix
    curPrefix = self.tokenView.leadingRawTriviaPieces.forEachLineLength(prefix: curPrefix, body: body)
    curPrefix = self.tokenView.rawText.forEachLineLength(prefix: curPrefix, body: body)
    curPrefix = self.tokenView.trailingRawTriviaPieces.forEachLineLength(prefix: curPrefix, body: body)
    return curPrefix
  }
}
