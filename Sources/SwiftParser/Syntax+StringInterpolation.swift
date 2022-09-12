@_spi(RawSyntax)
import SwiftSyntax

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
  }

  /// Append a syntax node to the interpolation.
  public mutating func appendInterpolation<Node: SyntaxProtocol>(
    _ node: Node
  ) {
    let startIndex = sourceText.count
    sourceText.append(contentsOf: node.syntaxTextBytes)
    interpolatedSyntaxNodes.append(
      .init(
        node: Syntax(node), startIndex: startIndex, endIndex: sourceText.count
      )
    )
  }

  // Append a value of any CustomStringConvertible type as source text.
  public mutating func appendInterpolation<T: CustomStringConvertible>(
    _ value: T
  ) {
    sourceText.append(contentsOf: value.description.utf8)
  }
}

/// Syntax nodes that can be formed by a string interpolation involve source
/// code and interpolated syntax nodes.
protocol SyntaxExpressibleByStringInterpolation:
    ExpressibleByStringInterpolation, SyntaxProtocol
    where Self.StringInterpolation == SyntaxStringInterpolation {
  /// Create an instance of this syntax node by parsing it from the given
  /// parser.
  static func parse(from parser: inout Parser) -> Self
}

extension SyntaxExpressibleByStringInterpolation {
  /// Initialize a syntax node by parsing the contents of the interpolation.
  public init(stringInterpolation: SyntaxStringInterpolation) {
    self = stringInterpolation.sourceText.withUnsafeBufferPointer { buffer in
      var parser = Parser(buffer)
      // FIXME: When the parser supports incremental parsing, put the
      // interpolatedSyntaxNodes in so we don't have to parse them again.
      return Self.parse(from: &parser)
    }
  }

  /// Initialize a syntax node from a string literal.
  public init(stringLiteral value: String) {
    var interpolation = SyntaxStringInterpolation()
    interpolation.appendLiteral(value)
    self.init(stringInterpolation: interpolation)
  }
}

// Parsing support for the main kinds of syntax nodes.
extension DeclSyntaxProtocol {
  static func parse(from parser: inout Parser) -> Self {
    return Syntax(raw: parser.parseDeclaration().raw).as(Self.self)!
  }
}

extension ExprSyntaxProtocol {
  static func parse(from parser: inout Parser) -> Self {
    return Syntax(raw: parser.parseExpression().raw).as(Self.self)!
  }
}

extension StmtSyntaxProtocol {
  static func parse(from parser: inout Parser) -> Self {
    return Syntax(raw: parser.parseStatement().raw).as(Self.self)!
  }
}

extension TypeSyntaxProtocol {
  static func parse(from parser: inout Parser) -> Self {
    return Syntax(raw: parser.parseType().raw).as(Self.self)!
  }
}

extension PatternSyntaxProtocol {
  static func parse(from parser: inout Parser) -> Self {
    return Syntax(raw: parser.parsePattern().raw).as(Self.self)!
  }
}

// String interpolation support for the primary node kinds.
extension DeclSyntax: SyntaxExpressibleByStringInterpolation { }
extension ExprSyntax: SyntaxExpressibleByStringInterpolation { }
extension StmtSyntax: SyntaxExpressibleByStringInterpolation { }
extension TypeSyntax: SyntaxExpressibleByStringInterpolation { }
extension PatternSyntax: SyntaxExpressibleByStringInterpolation { }
