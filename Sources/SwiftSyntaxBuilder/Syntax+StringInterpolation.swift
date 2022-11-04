//===----------------------------------------------------------------------===//
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

@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import SwiftParserDiagnostics
import SwiftDiagnostics
import SwiftBasicFormat

func performParse<SyntaxType: SyntaxProtocol>(source: [UInt8], parse: (inout Parser) throws -> SyntaxType) throws -> SyntaxType {
  return try source.withUnsafeBufferPointer { buffer in
    var parser = Parser(buffer)
    // FIXME: When the parser supports incremental parsing, put the
    // interpolatedSyntaxNodes in so we don't have to parse them again.
    let result = try parse(&parser)
    if !parser.at(.eof) {
      var remainingTokens: [TokenSyntax] = []
      while !parser.at(.eof) {
        remainingTokens.append(parser.consumeAnyToken().syntax)
      }
      throw SyntaxStringInterpolationError.didNotConsumeAllTokens(remainingTokens: remainingTokens)
    }
    if result.hasError {
      let diagnostics = ParseDiagnosticsGenerator.diagnostics(for: result)
      assert(!diagnostics.isEmpty)
      throw SyntaxStringInterpolationError.diagnostics(diagnostics, tree: Syntax(result))
    }
    return result
  }
}

/// An individual interpolated syntax node.
struct InterpolatedSyntaxNode {
  let node: Syntax
  let startIndex: Int
  let endIndex: Int
}

/// The string interpolation type used for creating syntax nodes.
public struct SyntaxStringInterpolation {
  /// The source text in UTF-8.
  ///
  /// We use an array of UTF-8 for the representation of the source text
  /// because that's what the parser uses, and we need the stable indices
  /// that arrays provide when appending new nodes to this array.
  var sourceText: [UInt8] = []

  /// If we appended a string literal last and the last line only consisted of
  /// whitespace, that trivia. This allows us to apply this indentation to all
  /// lines of an interpolated syntax node.
  var lastIndentation: Trivia?

  /// Tracks of all of the syntax nodes that were interpolated into the
  /// syntax.
  ///
  /// For each node, we record the syntax node, its start position within the
  /// source text, and its UTF-8 length.
  var interpolatedSyntaxNodes: [InterpolatedSyntaxNode] = []
}

extension SyntaxStringInterpolation: StringInterpolationProtocol {
  public init(literalCapacity: Int, interpolationCount: Int) {
    interpolatedSyntaxNodes.reserveCapacity(interpolationCount)
  }

  /// Append source text to the interpolation.
  public mutating func appendLiteral(_ text: String) {
    sourceText.append(contentsOf: text.utf8)
    let lines = text.split(whereSeparator: \.isNewline)
    if let lastLine = lines.last, lastLine.allSatisfy({ $0 == " " }) {
      self.lastIndentation = .spaces(lastLine.count)
    } else if let lastLine = lines.last, lastLine.allSatisfy({ $0 == "\t" }) {
      self.lastIndentation = .tabs(lastLine.count)
    } else {
      self.lastIndentation = nil
    }
  }

  /// Append a syntax node to the interpolation.
  public mutating func appendInterpolation<Node: SyntaxProtocol>(
    _ node: Node
  ) {
    let startIndex = sourceText.count
    let indentedNode: Node
    if let lastIndentation = lastIndentation {
      indentedNode = Indenter.indent(node, indentation: lastIndentation)
    } else {
      indentedNode = node
    }
    sourceText.append(contentsOf: indentedNode.syntaxTextBytes)
    interpolatedSyntaxNodes.append(
      .init(
        node: Syntax(indentedNode), startIndex: startIndex, endIndex: sourceText.count
      )
    )
    self.lastIndentation = nil
  }

  // Append a value of any CustomStringConvertible type as source text.
  public mutating func appendInterpolation<T: CustomStringConvertible>(
    _ value: T
  ) {
    sourceText.append(contentsOf: value.description.utf8)
    self.lastIndentation = nil
  }

  public mutating func appendInterpolation<Buildable: SyntaxProtocol>(
    _ buildable: Buildable,
    format: BasicFormat = BasicFormat()
  ) {
    self.appendInterpolation(buildable.formatted(using: format))
  }
}

/// Syntax nodes that can be formed by a string interpolation involve source
/// code and interpolated syntax nodes.
public protocol SyntaxExpressibleByStringInterpolation:
    ExpressibleByStringInterpolation, SyntaxProtocol
    where Self.StringInterpolation == SyntaxStringInterpolation {
  /// Create an instance of this syntax node by parsing it from the given
  /// parser.
  static func parse(from parser: inout Parser) throws -> Self
}

enum SyntaxStringInterpolationError: Error, CustomStringConvertible {
  case didNotConsumeAllTokens(remainingTokens: [TokenSyntax])
  case producedInvalidNodeType(expectedType: SyntaxProtocol.Type, actualType: SyntaxProtocol.Type)
  case diagnostics([Diagnostic], tree: Syntax)

  var description: String {
    switch self {
    case .didNotConsumeAllTokens(remainingTokens: let tokens):
      return "Extraneous text in snippet: '\(tokens.map(\.description).joined())'"
    case .producedInvalidNodeType(expectedType: let expectedType, actualType: let actualType):
      return "Parsing the code snippet was expected to produce a \(expectedType) but produced a \(actualType)"
    case .diagnostics(let diagnostics, let tree):
      // Start the diagnostc on a new line so it isn't prefixed with the file, which messes up the
      // column-aligned message from `DiagnosticsFormatter`.
      return "\n" + DiagnosticsFormatter.annotatedSource(tree: tree, diags: diagnostics)
    }
  }
}

extension SyntaxExpressibleByStringInterpolation {
  /// Initialize a syntax node by parsing the contents of the interpolation.
  /// This function is marked `@_transparent` so that fatalErrors raised here
  /// are reported at the string literal itself.
  /// This makes debugging easier because Xcode will jump to the string literal
  /// that had a parsing error instead of the initializer that raised the `fatalError`
  @_transparent
  public init(stringInterpolation: SyntaxStringInterpolation) {
    do {
      try self.init(stringInterpolationOrThrow: stringInterpolation)
    } catch {
      fatalError(String(describing: error))
    }
  }

  public init(stringInterpolationOrThrow stringInterpolation: SyntaxStringInterpolation) throws {
    self = try performParse(source: stringInterpolation.sourceText, parse: Self.parse)
  }

  @_transparent
  public init(stringLiteral value: String) {
    do {
      try self.init(stringLiteralOrThrow: value)
    } catch {
      fatalError(String(describing: error))
    }
  }

  /// Initialize a syntax node from a string literal.
  public init(stringLiteralOrThrow value: String) throws {
    var interpolation = SyntaxStringInterpolation()
    interpolation.appendLiteral(value)
    try self.init(stringInterpolationOrThrow: interpolation)
  }

  /// Construct this node by parsing `source`. If parsing fails, raise a `fatalError`.
  public init(_ source: String) {
    self.init(stringLiteral: source)
  }
}
