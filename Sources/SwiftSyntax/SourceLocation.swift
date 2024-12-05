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
public final class SourceLocationConverter: Sendable {
  private let fileName: String
  /// The source of the file, modeled as data so it can contain invalid UTF-8.
  private let source: [UInt8]
  /// The line table.
  @_spi(Compiler)
  public let lineTable: SourceLineTable

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
    self.lineTable = .create(for: tree)
    precondition(self.lineTable.endOfFile.utf8Offset == self.source.count)
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
  public init(file: String, source sourceStr: String) {
    self.fileName = file
    self.source = Array(sourceStr.utf8)
    var sourceStr = sourceStr
    self.lineTable = sourceStr.withSyntaxText(computeLines(text:))
    precondition(self.lineTable.endOfFile == AbsolutePosition(utf8Offset: self.source.count))
  }

  var endOfFile: AbsolutePosition {
    self.lineTable.endOfFile
  }

  /// Execute the body with each source line text.
  func forEachSourceLine(_ body: (SyntaxText) throws -> Void) rethrows {
    try source.withUnsafeBufferPointer { (sourceBuffer: UnsafeBufferPointer<UInt8>) in
      guard let baseAddress = sourceBuffer.baseAddress else {
        // Empty file.
        try body("")
        return
      }

      var position: AbsolutePosition = .startOfFile
      try lineTable.forEachEndOfLinePosition { endOfLine in
        try body(
          SyntaxText(
            baseAddress: baseAddress.advanced(by: position.utf8Offset),
            count: endOfLine.utf8Offset - position.utf8Offset
          )
        )
        position = endOfLine
      }
    }
  }

  /// Return the source lines of the file as `String`s.
  /// Because `String` cannot model invalid UTF-8, the concatenation of these source lines might not be source-accurate in case there are Unicode errors in the source file, but for most practical purposes, this should not pose an issue.
  public var sourceLines: [String] {
    var result: [String] = []
    self.forEachSourceLine { line in
      result.append(String(syntaxText: line))
    }
    return result
  }

  /// Convert a ``AbsolutePosition`` to a ``SourceLocation``.
  ///
  /// If the position is exceeding the file length then the ``SourceLocation``
  /// for the end of file is returned. If position is negative the location for
  /// start of file is returned.
  public func location(for position: AbsolutePosition) -> SourceLocation {
    // Clamp the given position to the source range if needed.
    let pos = max(.startOfFile, min(position, self.endOfFile))
    return lineTable.location(for: pos, originalFileName: self.fileName)
  }

  /// Compute the location of `position` without taking `#sourceLocation`
  /// directives into account.
  ///
  /// If the position is
  /// exceeding the file length then the ``SourceLocation`` for the end of file
  /// is returned. If position is negative the location for start of file is
  /// returned.
  private func physicalLocation(for position: AbsolutePosition) -> SourceLocation {
    // Clamp the given position to the source range if needed.
    let pos = max(.startOfFile, min(position, self.endOfFile))

    let lineCol = lineTable.physicalLineAndColumn(for: pos)

    return SourceLocation(
      line: lineCol.line,
      column: lineCol.column,
      offset: pos.utf8Offset,
      file: self.fileName
    )
  }

  /// Convert a physical line/column to a ``AbsolutePosition``. If the
  /// line/column exceeds the boundaries of the file or the line, the position
  /// returned is one adjusted to the closest boundary (beginning/end of file or line).
  ///
  /// - Parameters:
  ///   - line: A 1-based line number.
  ///   - column: A 1-based, UTF8 offset from the start of line.
  public func position(ofLine line: Int, column: Int) -> AbsolutePosition {
    guard line >= 1 else {
      return .startOfFile
    }
    guard line <= lineTable.lineCount else {
      return self.endOfFile
    }
    let lineRange = lineTable.range(forLine: line)
    let lineLength = lineRange.end.utf8Offset - lineRange.start.utf8Offset

    // The last line is not terminated with a newline, clamp to the end of the line.
    // Otherwise the last column is the position of the newline character.
    let maxColumn = line == lineTable.lineCount ? lineLength + 1 : lineLength
    let column = max(1, min(column, maxColumn))

    return lineRange.start.advanced(by: column - 1)
  }

  /// Returns false if the `position` is out-of-bounds for the file.
  public func isValid(position pos: AbsolutePosition) -> Bool {
    return lineTable.isValid(position: pos)
  }

  /// Returns false if the `line`/`column` pair is out-of-bounds for the file or
  /// that specific line.
  public func isValid(line: Int, column: Int) -> Bool {
    guard 1 <= line, line <= lineTable.lineCount, 1 <= column else {
      return false
    }

    let lineRange = lineTable.range(forLine: line)
    let lineLength = lineRange.end.utf8Offset - lineRange.start.utf8Offset

    // The last line is not terminated with a newline, so the end position is valid.
    // Otherwise the end position is the start position of the next line.
    let maxColumn = line == lineTable.lineCount ? lineLength + 1 : lineLength
    return column <= maxColumn
  }
}

extension Syntax {
  /// The starting location, in the provided file, of this Syntax node.
  /// - Parameters:
  ///   - converter: The `SourceLocationConverter` that was previously
  ///     initialized using the root tree of this node.
  ///   - afterLeadingTrivia: Whether to skip leading trivia when getting
  ///                         the node's location. Defaults to `true`.
  public func startLocation(
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
  public func endLocation(
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
  public func sourceRange(
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

extension SyntaxProtocol {
  /// The starting location, in the provided file, of this Syntax node.
  /// - Parameters:
  ///   - converter: The `SourceLocationConverter` that was previously
  ///     initialized using the root tree of this node.
  ///   - afterLeadingTrivia: Whether to skip leading trivia when getting
  ///                         the node's location. Defaults to `true`.
  public func startLocation(
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
  public func endLocation(
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
  public func sourceRange(
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

/// `Array` wrapper to perform binary searches.
private struct SortedArray<Element>: RandomAccessCollection {
  typealias Storage = [Element]
  let storage: Storage

  /// Initialize with the pre-sorted array.
  ///
  /// It is the caller's responsibility to pre-sort the array. Otherwise, the
  /// behavior is undefined.
  init(sortedArray: [Element]) {
    self.storage = sortedArray
  }

  /// Find the first index where the element is ordered after `value`.
  func upperBoundIndex<Value>(_ val: Value, by areIncreasingOrder: (Value, Element) -> Bool) -> Storage.Index {
    var start = storage.startIndex
    var end = storage.endIndex
    while end > start {
      let idx = (end - start) / 2 + start
      if areIncreasingOrder(val, storage[idx]) {
        end = idx
      } else {
        start = idx + 1
      }
    }
    return start
  }

  /// Equivalent to `upperBoundIndex(val, by: <)`.
  func upperBoundIndex(_ val: Element) -> Storage.Index where Element: Comparable {
    self.upperBoundIndex(val, by: <)
  }

  var startIndex: Int { storage.startIndex }
  var endIndex: Int { storage.endIndex }
  subscript(index: Storage.Index) -> Element {
    storage[index]
  }
  func makeIterator() -> Storage.Iterator {
    storage.makeIterator()
  }
  func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R? {
    try storage.withUnsafeBufferPointer(body)
  }
}

extension SortedArray: Sendable where Element: Sendable {}

/// Represent a virtual file region in the source file.
///
/// This type corresponds to `swift::SourceManager::VirtualFile` in the compiler,
/// and is used for populating the virtual file information in it.
@_spi(Compiler)
public struct VirtualFile: Sendable {
  /// Start position of the virtual file region
  public var startPosition: AbsolutePosition
  /// End position of the virtual file region
  public var endPosition: AbsolutePosition
  /// Virtual file name.
  public var fileName: String
  /// Line number offset from the physical line number.
  public var lineOffset: Int
  /// The position of the file name string literal in the `#sourceLocation` directive.
  /// This can be used to diagnose the file name in the compiler.
  public var fileNamePosition: AbsolutePosition
}

@_spi(Compiler)
public final class SourceLineTable: Sendable {
  /// Array of the *end* of newline character of the each line.
  private let lineEnds: SortedArray<AbsolutePosition>

  /// Array of virtual files declared in the source tree.
  private let virtualFileTable: SortedArray<VirtualFile>

  /// The end position of the file.
  ///
  /// If the last line was terminated with a newline character, this must be the
  /// same value as `table.last`.
  let endOfFile: AbsolutePosition

  init(lineEnds: [AbsolutePosition], virtualFiles: [VirtualFile], endOfFile: AbsolutePosition) {
    precondition((lineEnds.last ?? .startOfFile) <= endOfFile)
    self.lineEnds = SortedArray(sortedArray: lineEnds)
    self.virtualFileTable = SortedArray(sortedArray: virtualFiles)
    self.endOfFile = endOfFile
  }

  /// Create an instance by traversing a Syntax tree.
  public static func create(for tree: some SyntaxProtocol) -> SourceLineTable {
    return computeLines(tree: Syntax(tree))
  }

  /// Line count.
  ///
  /// This is always 1 or greater, even for an empty file.
  public var lineCount: Int {
    return lineEnds.count + 1
  }

  public func isValid(position: AbsolutePosition) -> Bool {
    return .startOfFile <= position && position <= endOfFile
  }

  /// The line number at the given position.
  ///
  /// `position` must be `0 ... endOfFile`
  public func physicalLine(for position: AbsolutePosition) -> Int {
    precondition(isValid(position: position))
    let lineIdx = lineEnds.upperBoundIndex(position)
    return lineIdx + 1
  }

  /// The physical line number and column number at the given position.
  ///
  /// `position` must be `0 ... endOfFile`
  public func physicalLineAndColumn(for position: AbsolutePosition) -> (line: Int, column: Int) {
    precondition(isValid(position: position))
    let lineIdx = lineEnds.upperBoundIndex(position)
    let columnOffset: Int
    if lineIdx == 0 {
      columnOffset = position.utf8Offset
    } else {
      columnOffset = position.utf8Offset - lineEnds[lineIdx - 1].utf8Offset
    }
    return (lineIdx + 1, columnOffset + 1)
  }

  /// The location for the given position.
  ///
  /// `position` must be `0 ... endOfFile`
  public func location(for position: AbsolutePosition, originalFileName: String) -> SourceLocation {
    let lineCol = self.physicalLineAndColumn(for: position)
    let virtualFile = self.virtualFile(for: position)
    return SourceLocation(
      line: lineCol.line,
      column: lineCol.column,
      offset: position.utf8Offset,
      file: originalFileName,
      presumedLine: lineCol.line + (virtualFile?.lineOffset ?? 0),
      presumedFile: virtualFile?.fileName ?? originalFileName
    )
  }

  /// The position range of the given line number.
  ///
  /// `line` must be `1 ... lineCount`
  public func range(forLine line: Int) -> (start: AbsolutePosition, end: AbsolutePosition) {
    precondition(1 <= line && line <= self.lineCount)
    let start = line != 1 ? lineEnds[line - 2] : .startOfFile
    let end = line != self.lineCount ? lineEnds[line - 1] : self.endOfFile
    return (start, end)
  }

  /// Call `body` with the each end-of-line position.
  ///
  /// I.e. position of the end of each newline characters, _and_ the end of the file.
  public func forEachEndOfLinePosition(_ body: (AbsolutePosition) throws -> Void) rethrows {
    try lineEnds.forEach(body)
    try body(endOfFile)
  }

  /// The virtual file at the given position.
  public func virtualFile(for pos: AbsolutePosition) -> VirtualFile? {
    let idx = virtualFileTable.upperBoundIndex(pos, by: { pos, virtualFile in pos < virtualFile.endPosition })
    guard idx != virtualFileTable.endIndex else {
      return nil
    }

    let virtualFile = virtualFileTable[idx]
    if pos < virtualFile.startPosition {
      return nil
    }
    return virtualFile
  }

  public var virtualFiles: [VirtualFile] {
    virtualFileTable.storage
  }
}

/// Create ``SourceLineTable`` by traversing a Syntax tree.
private func computeLines(tree: Syntax) -> SourceLineTable {
  // Collected end-of-line positions.
  var lineEnds: [AbsolutePosition] = []
  // Collected pairs of #sourceLocation directive position and the RawSyntax.
  var directives: [(position: AbsolutePosition, lineIdx: Int, raw: RawSyntax)] = []

  let endOfTree = tree.raw.forEachEndOfLine(position: tree.position) { eol in
    lineEnds.append(eol)
  } handleSourceLocationDirective: { position, raw in
    directives.append((position: position, lineIdx: lineEnds.count, raw: raw))
  }
  precondition(endOfTree == tree.endPosition)

  // Create VirtualFiles from the collected #sourceLocation directives.
  var virtualFiles: [VirtualFile] = []
  LOOP: for (position, var lineIdx, raw) in directives {
    let directiveStartPosition = position + raw.leadingTriviaLength
    let directiveEndPosition = position + raw.totalLength - raw.trailingTriviaLength
    precondition(directiveEndPosition <= endOfTree && lineIdx <= lineEnds.count)

    // Close the last virtual file if it's open.
    // Make sure the #sourceLocation directive itself doesn't belong to any VirtualFile.
    if let lastEndPos = virtualFiles.last?.endPosition, lastEndPos > directiveStartPosition {
      virtualFiles[virtualFiles.count - 1].endPosition = directiveStartPosition
    }

    // 'lineIdx' is the line of the 'position', i.e. the start of the leading
    // trivia of the directive. Advance it to the end of the directive.
    while lineIdx < lineEnds.count && directiveEndPosition > lineEnds[lineIdx] {
      lineIdx += 1
    }

    // Ignore #sourceLocation at the end of file without following newline.
    guard lineIdx < lineEnds.count else {
      continue LOOP
    }

    // The virtual file starts at the _next_ line of the directive.
    let vFileStartPosition = lineEnds[lineIdx]

    // Parse the arguments.
    let directive = PoundSourceLocationSyntax(Syntax.forRoot(raw, rawNodeArena: raw.arenaReference.retained))!
    guard
      // If it's '#sourceLocation', we're done.
      let argsClause = directive.arguments,
      // Ignore #sourceLocation(...) with malformed arguments.
      let arguments = try? SourceLocationDirectiveArguments(argsClause)
    else {
      continue LOOP
    }
    let fileNamePosition =
      (position + SourceLength(utf8Length: argsClause.fileName.position.utf8Offset)
        + argsClause.fileName.leadingTriviaLength)

    // For example, if there is '#sourceLocation(file: "foo.in", line: 100)' on
    // line:1 (i.e. lineIdx:0), the virtual file starts on line:2, so the
    // physical line:2 is assumed to be line:100, thus the 'lineOffset' is 98.
    let lineOffset = arguments.line - lineIdx - 2

    // Open the virtual file to the end of the file.
    virtualFiles.append(
      VirtualFile(
        startPosition: vFileStartPosition,
        endPosition: endOfTree,
        fileName: arguments.file,
        lineOffset: lineOffset,
        fileNamePosition: fileNamePosition
      )
    )
  }

  return SourceLineTable(lineEnds: lineEnds, virtualFiles: virtualFiles, endOfFile: endOfTree)
}

/// Compute ``SourceLineTable`` from a ``SyntaxText``.
fileprivate func computeLines(text: SyntaxText) -> SourceLineTable {
  var lineEnds: [AbsolutePosition] = []
  let endPos = text.forEachEndOfLine(position: .startOfFile) { pos in
    lineEnds.append(pos)
  }
  precondition(endPos.utf8Offset == text.count)
  return SourceLineTable(lineEnds: lineEnds, virtualFiles: [], endOfFile: endPos)
}

fileprivate extension SyntaxText {
  /// Walks and passes to `body` the ``AbsolutePosition`` _after_ every newline.
  ///
  /// - Parameter position: The start position of the callee.
  /// - Returns: The position at the end of the walk.
  func forEachEndOfLine(
    position: AbsolutePosition,
    body: (AbsolutePosition) -> ()
  ) -> AbsolutePosition {
    guard let startPtr = buffer.baseAddress else {
      return position
    }
    let endPtr = startPtr.advanced(by: buffer.count)
    var ptr = startPtr

    while ptr != endPtr {
      let chr = ptr.pointee
      ptr += 1

      /// From https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#grammar_line-break
      /// * line-break → U+000A
      /// * line-break → U+000D
      /// * line-break → U+000D followed by U+000A
      switch chr {
      case UInt8(ascii: "\n"):
        break
      case UInt8(ascii: "\r"):
        if ptr != endPtr && ptr.pointee == UInt8(ascii: "\n") {
          ptr += 1
        }
        break
      default:
        continue
      }
      body(position.advanced(by: startPtr.distance(to: ptr)))
    }
    return position.advanced(by: buffer.count)
  }

  func containsSwiftNewline() -> Bool {
    return self.contains { $0 == UInt8(ascii: "\n") || $0 == UInt8(ascii: "\r") }
  }
}

fileprivate extension RawTriviaPiece {
  /// Walks and passes to `body` the ``AbsolutePosition`` _after_ every newline.
  ///
  /// - Parameter position: The start position of the callee.
  /// - Returns: The position at the end of the walk.
  func forEachEndOfLine(
    position: AbsolutePosition,
    body: (AbsolutePosition) -> ()
  ) -> AbsolutePosition {
    var position = position
    switch self {
    case let .spaces(count),
      let .tabs(count),
      let .verticalTabs(count),
      let .formfeeds(count),
      let .backslashes(count),
      let .pounds(count):
      position = position.advanced(by: count)
    case let .newlines(count),
      let .carriageReturns(count):
      for _ in 0..<count {
        position = position.advanced(by: 1)
        body(position)
      }
    case let .carriageReturnLineFeeds(count):
      for _ in 0..<count {
        position = position.advanced(by: 2)
        body(position)
      }
    case let .lineComment(text),
      let .docLineComment(text):
      // Line comments are not supposed to contain newlines.
      precondition(!text.containsSwiftNewline(), "line comment created that contained a new-line character")
      position = position.advanced(by: text.count)
    case let .blockComment(text),
      let .docBlockComment(text),
      let .unexpectedText(text):
      position = text.forEachEndOfLine(position: position, body: body)
    }
    return position
  }
}

fileprivate extension RawTriviaPieceBuffer {
  /// Walks and passes to `body` the ``AbsolutePosition`` _after_ every newline.
  ///
  /// - Parameter position: The start position of the callee.
  /// - Returns: The position at the end of the walk.
  func forEachEndOfLine(
    position: AbsolutePosition,
    body: (AbsolutePosition) -> ()
  ) -> AbsolutePosition {
    var position = position
    for piece in self {
      position = piece.forEachEndOfLine(position: position, body: body)
    }
    return position
  }
}

fileprivate extension RawSyntax {
  /// Walks and passes to `body` the ``AbsolutePosition`` _after_ every newline character,
  ///
  /// - Parameters:
  ///   - position: The start position of the callee.
  ///   - body: Called for each end-of-line position.
  ///   - handleSourceLocationDirective: Called for each `#sourceLocation` node in the tree.
  ///     - position: position of the directive raw syntax.
  ///     - rawSyntax: ``RawSyntax`` of the directive.
  /// - Returns: The position at the end of the walk.
  func forEachEndOfLine(
    position: AbsolutePosition,
    body: (AbsolutePosition) -> (),
    handleSourceLocationDirective: (_ position: AbsolutePosition, _ rawSyntax: RawSyntax) -> ()
  ) -> AbsolutePosition {
    var position = position
    switch self.rawData.payload {
    case .parsedToken(let dat):
      position = dat.wholeText.forEachEndOfLine(position: position, body: body)
    case .materializedToken(let dat):
      position = dat.leadingTrivia.forEachEndOfLine(position: position, body: body)
      position = dat.tokenText.forEachEndOfLine(position: position, body: body)
      position = dat.trailingTrivia.forEachEndOfLine(position: position, body: body)
    case .layout(let dat):
      // Handle '#sourceLocation' directive.
      if dat.kind == .poundSourceLocation {
        // Do this before `node.forEachEndOfLine` call below so the caller can
        // know the exact position of the directive.
        handleSourceLocationDirective(position, self)
      }

      for case let node? in dat.layout where SyntaxTreeViewMode.sourceAccurate.shouldTraverse(node: node) {
        position = node.forEachEndOfLine(
          position: position,
          body: body,
          handleSourceLocationDirective: handleSourceLocationDirective
        )
      }
    }
    return position
  }
}
