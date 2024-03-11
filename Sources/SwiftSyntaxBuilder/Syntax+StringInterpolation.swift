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

#if swift(>=6)
public import SwiftBasicFormat
import SwiftDiagnostics
@_spi(RawSyntax) @_spi(Testing) import SwiftParser
@_spi(RawSyntax) public import SwiftSyntax
#else
import SwiftBasicFormat
import SwiftDiagnostics
@_spi(RawSyntax) @_spi(Testing) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax
#endif

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
  ///
  /// This method accepts a syntax node and appends it to the interpolation.
  /// If there was a previous indentation value, the method will indent the
  /// syntax node with that value. If not, it will use the syntax node as-is.
  ///
  /// - Parameter node: A syntax node that conforms to `SyntaxProtocol`.
  public mutating func appendInterpolation<Node: SyntaxProtocol>(
    _ node: Node
  ) {
    let startIndex = sourceText.count
    let indentedNode: Node
    if let lastIndentation {
      indentedNode = Indenter.indent(node, indentation: lastIndentation)
    } else {
      indentedNode = node
    }
    sourceText.append(contentsOf: indentedNode.syntaxTextBytes)
    interpolatedSyntaxNodes.append(
      .init(
        node: Syntax(indentedNode),
        startIndex: startIndex,
        endIndex: sourceText.count
      )
    )
    self.lastIndentation = nil
  }

  /// Append an optional syntax node to the interpolation.
  ///
  /// This method accepts an optional syntax node and appends it to the interpolation
  /// if it exists. If the syntax node is nil, this method does nothing.
  ///
  /// - Parameter node: An optional syntax node that conforms to `SyntaxProtocol`.
  public mutating func appendInterpolation<Node: SyntaxProtocol>(
    _ node: Node?
  ) {
    if let node {
      appendInterpolation(node)
    }
  }

  public mutating func appendInterpolation<T>(raw value: T) {
    sourceText.append(contentsOf: String(describing: value).utf8)
    self.lastIndentation = nil
  }

  // Append a value of any metatype as source text
  public mutating func appendInterpolation<T>(
    _ type: T.Type
  ) {
    sourceText.append(contentsOf: String(describing: type).utf8)
    self.lastIndentation = nil
  }

  public mutating func appendInterpolation(
    _ buildable: some SyntaxProtocol,
    format: BasicFormat = BasicFormat()
  ) {
    self.appendInterpolation(buildable.formatted(using: format))
  }

  public mutating func appendInterpolation(
    _ trivia: Trivia
  ) {
    self.appendInterpolation(raw: trivia.description)
  }

  /// Interpolates a literal or similar expression syntax equivalent to `value`.
  ///
  /// - SeeAlso: ``SwiftSyntax/ExprSyntax/init(literal:)``
  public mutating func appendInterpolation(
    literal value: some ExpressibleByLiteralSyntax,
    format: BasicFormat = BasicFormat()
  ) {
    self.appendInterpolation(ExprSyntax(literal: value), format: format)
  }

  // This overload is technically redundant with the previous one, except that
  // it silences a warning about interpolating Optionals.
  /// Interpolates a literal or similar expression syntax equivalent to `value`.
  ///
  /// - SeeAlso: ``SwiftSyntax/ExprSyntax/init(literal:)``
  public mutating func appendInterpolation<Literal: ExpressibleByLiteralSyntax>(
    literal value: Literal?,
    format: BasicFormat = BasicFormat()
  ) {
    self.appendInterpolation(ExprSyntax(literal: value), format: format)
  }
}

/// Syntax nodes that can be formed by a string interpolation involve source
/// code and interpolated syntax nodes.
public protocol SyntaxExpressibleByStringInterpolation:
  ExpressibleByStringInterpolation
where Self.StringInterpolation == SyntaxStringInterpolation {
  init(stringInterpolation: SyntaxStringInterpolation)
}

/// Describes an error when building a syntax node with string interpolation resulted in an unexpected node type.
public struct SyntaxStringInterpolationInvalidNodeTypeError: Error, CustomStringConvertible {
  let expectedType: SyntaxProtocol.Type
  let actualType: SyntaxProtocol.Type

  /// Initialize the invalid node type error providing an expected type, and the actual node that resulted.
  public init<S: SyntaxProtocol>(expectedType: SyntaxProtocol.Type, actualNode: S) {
    self.expectedType = expectedType
    self.actualType = type(of: actualNode)
  }

  public var description: String {
    return "Parsing the code snippet was expected to produce a \(expectedType) but produced a \(actualType)"
  }
}

/// A string interpolation error based on a ``SwiftDiagnostics/Diagnostic``.
struct SyntaxStringInterpolationDiagnosticError: Error, CustomStringConvertible {
  let diagnostics: [Diagnostic]
  let tree: Syntax

  var description: String {
    // Start the diagnostic on a new line so it isn't prefixed with the file, which messes up the
    // column-aligned message from ``DiagnosticsFormatter``.
    return "\n" + DiagnosticsFormatter.annotatedSource(tree: tree, diags: diagnostics)
  }
}

/// A Swift type whose value can be represented directly in source code by a
/// Swift literal.
///
/// Conforming types do not *contain* Swift source code; rather, they can be
/// *expressed* in Swift source code, and this protocol can be used to get
/// whatever source code would do that. For example, `String` is
/// `ExpressibleByLiteralSyntax` but ``SwiftSyntax/StringLiteralExprSyntax`` is not.
///
/// This protocol is usually not used directly. Instead, conforming types can
/// be turned into syntax trees using ``SwiftSyntax/ExprSyntax/init(literal:)``:
///
///     let expr2 = Expr(literal: [0+1, 1+1, 2+1])
///     // `expr2` is a syntax tree for `[1, 2, 3]`.
///
/// Or interpolated into a Swift source code literal with the syntax
/// `\(literal: <value>)`:
///
///     let greeting = "Hello, world!"
///     let expr1 = ExprSyntax("print(\(literal: greeting))")
///     // `expr1` is a syntax tree for `print("Hello, world!")`
///
/// Note that quote marks are automatically added around the contents of string
/// literals; you don't have to write them yourself. The conformance for
/// `String` will automatically ensure the contents are correctly escaped,
/// possibly by using raw literals or other language features:
///
///     let msPath = "c:\\windows\\system32"
///     let expr3 = ExprSyntax("open(\(literal: msPath))")
///     // `expr3` might be a syntax tree for `open(#"c:\windows\system32"#)`
///     // or for `open("c:\\windows\\system32")`.
///
/// Other conformances have similar intelligent behaviors: floating-point types
/// produce correct syntax trees for infinities and NaNs, nested optionals
/// produce `.some(nil)` where appropriate, etc.
public protocol ExpressibleByLiteralSyntax {
  associatedtype LiteralType where LiteralType: ExprSyntaxProtocol

  /// Returns a syntax tree that represents the value of this instance.
  ///
  /// This method is usually not called directly. Instead, conforming types can
  /// be turned into syntax trees using ``SwiftSyntax/ExprSyntax/init(literal:)``:
  ///
  ///     let expr2 = Expr(literal: [0+1, 1+1, 2+1])
  ///     // `expr2` is a syntax tree for `[1, 2, 3]`.
  ///
  /// Or interpolated into a Swift source code literal with the syntax
  /// `\(literal: <value>)`:
  ///
  ///     let greeting = "Hello, world!"
  ///     let expr1 = ExprSyntax("print(\(literal: greeting))")
  ///     // `expr1` is a syntax tree for `print("Hello, world!")`
  func makeLiteralSyntax() -> LiteralType
}

extension SyntaxExpressibleByStringInterpolation {
  public init(stringLiteral value: String) {
    var interpolation = SyntaxStringInterpolation()
    interpolation.appendLiteral(value)
    self.init(stringInterpolation: interpolation)
  }
}

// MARK: ExpressibleByLiteralSyntax conformances

extension Substring: ExpressibleByLiteralSyntax {
  public func makeLiteralSyntax() -> StringLiteralExprSyntax {
    String(self).makeLiteralSyntax()
  }
}

extension String: ExpressibleByLiteralSyntax {
  public func makeLiteralSyntax() -> StringLiteralExprSyntax {
    // TODO: Use a multi-line literal if there are more than N inner newlines.
    StringLiteralExprSyntax(content: self)
  }
}

extension ExpressibleByLiteralSyntax where Self: BinaryInteger {
  public func makeLiteralSyntax() -> IntegerLiteralExprSyntax {
    let digits = String(self, radix: 10)
    return IntegerLiteralExprSyntax(literal: .integerLiteral(digits))
  }
}
extension Int: ExpressibleByLiteralSyntax {}
extension Int8: ExpressibleByLiteralSyntax {}
extension Int16: ExpressibleByLiteralSyntax {}
extension Int32: ExpressibleByLiteralSyntax {}
extension Int64: ExpressibleByLiteralSyntax {}
extension UInt: ExpressibleByLiteralSyntax {}
extension UInt8: ExpressibleByLiteralSyntax {}
extension UInt16: ExpressibleByLiteralSyntax {}
extension UInt32: ExpressibleByLiteralSyntax {}
extension UInt64: ExpressibleByLiteralSyntax {}

extension ExpressibleByLiteralSyntax where Self: FloatingPoint, Self: LosslessStringConvertible {
  public func makeLiteralSyntax() -> ExprSyntax {
    switch floatingPointClass {
    case .positiveInfinity:
      return ExprSyntax(MemberAccessExprSyntax(name: "infinity"))

    case .quietNaN:
      return ExprSyntax(MemberAccessExprSyntax(name: "nan"))

    case .signalingNaN:
      return ExprSyntax(MemberAccessExprSyntax(name: "signalingNaN"))

    case .negativeInfinity, .negativeZero:
      return ExprSyntax(
        PrefixOperatorExprSyntax(
          operator: .prefixOperator("-"),
          expression: (-self).makeLiteralSyntax()
        )
      )

    case .negativeNormal, .negativeSubnormal, .positiveZero, .positiveSubnormal, .positiveNormal:
      let digits = String(self)
      return ExprSyntax(FloatLiteralExprSyntax(literal: .floatLiteral(digits)))
    }

  }
}
extension Float: ExpressibleByLiteralSyntax {}
extension Double: ExpressibleByLiteralSyntax {}

#if !((os(macOS) || targetEnvironment(macCatalyst)) && arch(x86_64))
@available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
extension Float16: ExpressibleByLiteralSyntax {}
#endif

extension Bool: ExpressibleByLiteralSyntax {
  public func makeLiteralSyntax() -> BooleanLiteralExprSyntax {
    BooleanLiteralExprSyntax(self)
  }
}

extension ArraySlice: ExpressibleByLiteralSyntax where Element: ExpressibleByLiteralSyntax {
  public func makeLiteralSyntax() -> ArrayExprSyntax {
    ArrayExprSyntax(
      leftSquare: .leftSquareToken(),
      elements: ArrayElementListSyntax {
        for elem in self {
          ArrayElementSyntax(expression: elem.makeLiteralSyntax())
        }
      },
      rightSquare: .rightSquareToken()
    )
  }
}

extension Array: ExpressibleByLiteralSyntax where Element: ExpressibleByLiteralSyntax {
  public func makeLiteralSyntax() -> ArrayExprSyntax {
    self[...].makeLiteralSyntax()
  }
}

extension Set: ExpressibleByLiteralSyntax where Element: ExpressibleByLiteralSyntax {
  public func makeLiteralSyntax() -> ArrayExprSyntax {
    // Sets are unordered. Sort the elements by their source-code representation to emit them in a stable order.
    let elemSyntaxes = map {
      $0.makeLiteralSyntax()
    }.sorted {
      $0.syntaxTextBytes.lexicographicallyPrecedes($1.syntaxTextBytes)
    }

    return ArrayExprSyntax(
      leftSquare: .leftSquareToken(),
      elements: ArrayElementListSyntax {
        for elemSyntax in elemSyntaxes {
          ArrayElementSyntax(expression: elemSyntax)
        }
      },
      rightSquare: .rightSquareToken()
    )
  }
}

extension KeyValuePairs: ExpressibleByLiteralSyntax where Key: ExpressibleByLiteralSyntax, Value: ExpressibleByLiteralSyntax {
  public func makeLiteralSyntax() -> DictionaryExprSyntax {
    DictionaryExprSyntax(leftSquare: .leftSquareToken(), rightSquare: .rightSquareToken()) {
      for elem in self {
        DictionaryElementSyntax(
          key: elem.key.makeLiteralSyntax(),
          colon: .colonToken(),
          value: elem.value.makeLiteralSyntax()
        )
      }
    }
  }
}

extension Dictionary: ExpressibleByLiteralSyntax where Key: ExpressibleByLiteralSyntax, Value: ExpressibleByLiteralSyntax {
  public func makeLiteralSyntax() -> DictionaryExprSyntax {
    // Dictionaries are unordered. Sort the elements by their keys' source-code representation to emit them in a stable order.
    let elemSyntaxes = map {
      (key: $0.key.makeLiteralSyntax(), value: $0.value.makeLiteralSyntax())
    }.sorted {
      $0.key.syntaxTextBytes.lexicographicallyPrecedes($1.key.syntaxTextBytes)
    }

    return DictionaryExprSyntax(leftSquare: .leftSquareToken(), rightSquare: .rightSquareToken()) {
      for elemSyntax in elemSyntaxes {
        DictionaryElementSyntax(
          key: elemSyntax.key,
          colon: .colonToken(),
          value: elemSyntax.value
        )
      }
    }
  }
}

extension Optional: ExpressibleByLiteralSyntax where Wrapped: ExpressibleByLiteralSyntax {
  public func makeLiteralSyntax() -> ExprSyntax {
    func containsNil(_ expr: ExprSyntaxProtocol) -> Bool {
      if expr.is(NilLiteralExprSyntax.self) {
        return true
      }

      if let call = expr.as(FunctionCallExprSyntax.self),
        let memberAccess = call.calledExpression.as(MemberAccessExprSyntax.self),
        memberAccess.declName.baseName.text == "some",
        let argument = call.arguments.first?.expression
      {
        return containsNil(argument)
      }

      return false
    }

    switch self {
    case nil:
      return ExprSyntax(NilLiteralExprSyntax())

    case let wrapped?:
      let wrappedExpr = wrapped.makeLiteralSyntax()

      // If this is a nested optional type, and the wrapped value is `nil` or
      // e.g. `.some(nil)`, add a layer of `.some(_:)` around it to preserve the
      // depth of the data structure.
      if containsNil(wrappedExpr) {
        return ExprSyntax(
          FunctionCallExprSyntax(callee: MemberAccessExprSyntax(name: "some")) {
            LabeledExprSyntax(expression: wrappedExpr)
          }
        )
      }

      return ExprSyntax(wrappedExpr)
    }
  }
}

extension TokenSyntax: SyntaxExpressibleByStringInterpolation {
  public init(stringInterpolation: SyntaxStringInterpolation) {
    let string = stringInterpolation.sourceText.withUnsafeBufferPointer { buf in
      // Technically, `buf` is not allocated in a `SyntaxArena` but it satisfies
      // all the required properties: `buf` will always outlive any references
      // to it.
      let syntaxArenaBuf = SyntaxArenaAllocatedBufferPointer(buf)
      return String(syntaxText: SyntaxText(buffer: syntaxArenaBuf))
    }
    self = .identifier(string)
  }
}

#if compiler(>=6)
// Silence warning that TokenSyntax has a retroactive conformance to `ExpressibleByStringInterpolation` through
// `SyntaxExpressibleByStringInterpolation`.
extension TokenSyntax: @retroactive ExpressibleByStringInterpolation {}
#endif

// MARK: - Trivia expressible as string

extension TriviaPiece {
  var isUnexpected: Bool {
    switch self {
    case .unexpectedText: return true
    default: return false
    }
  }
}

struct UnexpectedTrivia: DiagnosticMessage {
  let triviaContents: String

  let diagnosticID = MessageID(domain: "SwiftSyntaxBuilder", id: "UnexpectedTrivia")
  let severity = DiagnosticSeverity.error
  var message: String {
    "unexpected trivia '\(triviaContents)'"
  }

}

extension Trivia {
  public init(stringInterpolation: String.StringInterpolation) {
    var text = String(stringInterpolation: stringInterpolation)
    let pieces = text.withUTF8 { (buf) -> [TriviaPiece] in
      // Technically, `buf` is not allocated in a `SyntaxArena` but it satisfies
      // all the required properties: `buf` will always outlive any references
      // to it.
      let syntaxArenaBuf = SyntaxArenaAllocatedBufferPointer(buf)
      // The leading trivia position is a little bit less restrictive (it allows a shebang), so let's use it.
      let rawPieces = TriviaParser.parseTrivia(SyntaxText(buffer: syntaxArenaBuf), position: .leading)
      return rawPieces.map { TriviaPiece.init(raw: $0) }
    }

    self.init(pieces: pieces)
  }

  public init(stringLiteral value: String) {
    var interpolation = String.StringInterpolation(literalCapacity: 1, interpolationCount: 0)
    interpolation.appendLiteral(value)
    self.init(stringInterpolation: interpolation)
  }
}

#if compiler(>=6)
extension Trivia: @retroactive ExpressibleByStringInterpolation {}
#else
extension Trivia: ExpressibleByStringInterpolation {}
#endif
