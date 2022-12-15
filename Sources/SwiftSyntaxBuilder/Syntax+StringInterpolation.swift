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

import SwiftBasicFormat
import SwiftDiagnostics
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
        node: Syntax(indentedNode),
        startIndex: startIndex,
        endIndex: sourceText.count
      )
    )
    self.lastIndentation = nil
  }

  // Append a value of any CustomStringConvertible type as source text.
  // Deprecated because this can cause code injection bugs (and we want the
  // error message to tell users what to do instead).
  @available(*, deprecated, renamed: "appendInterpolation(raw:)", message: "use '\\(raw: <value>)' to interpolate a plain string directly into Swift code, or use '\\(literal: <value>)' to add it in a literal")
  public mutating func appendInterpolation<T: CustomStringConvertible>(
    _ value: T
  ) {
    sourceText.append(contentsOf: value.description.utf8)
    self.lastIndentation = nil
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

  public mutating func appendInterpolation<Buildable: SyntaxProtocol>(
    _ buildable: Buildable,
    format: BasicFormat = BasicFormat()
  ) {
    self.appendInterpolation(buildable.formatted(using: format))
  }

  /// Interpolates a literal or similar expression syntax equivalent to `value`.
  ///
  /// - SeeAlso: ``Expr.init(literal:)``
  public mutating func appendInterpolation<Literal: ExpressibleByLiteralSyntax>(
    literal value: Literal,
    format: BasicFormat = BasicFormat()
  ) {
    self.appendInterpolation(Expr(literal: value), format: format)
  }

  // This overload is technically redundant with the previous one, except that
  // it silences a warning about interpolating Optionals.
  /// Interpolates a literal or similar expression syntax equivalent to `value`.
  ///
  /// - SeeAlso: ``Expr.init(literal:)``
  public mutating func appendInterpolation<Literal: ExpressibleByLiteralSyntax>(
    literal value: Literal?,
    format: BasicFormat = BasicFormat()
  ) {
    self.appendInterpolation(Expr(literal: value), format: format)
  }
}

/// Syntax nodes that can be formed by a string interpolation involve source
/// code and interpolated syntax nodes.
public protocol SyntaxExpressibleByStringInterpolation:
  ExpressibleByStringInterpolation, SyntaxProtocol
where Self.StringInterpolation == SyntaxStringInterpolation {
  init(stringInterpolationOrThrow stringInterpolation: SyntaxStringInterpolation) throws
}

enum SyntaxStringInterpolationError: Error, CustomStringConvertible {
  case producedInvalidNodeType(expectedType: SyntaxProtocol.Type, actualType: SyntaxProtocol.Type)
  case diagnostics([Diagnostic], tree: Syntax)

  var description: String {
    switch self {
    case .producedInvalidNodeType(expectedType: let expectedType, actualType: let actualType):
      return "Parsing the code snippet was expected to produce a \(expectedType) but produced a \(actualType)"
    case .diagnostics(let diagnostics, let tree):
      // Start the diagnostic on a new line so it isn't prefixed with the file, which messes up the
      // column-aligned message from `DiagnosticsFormatter`.
      return "\n" + DiagnosticsFormatter.annotatedSource(tree: tree, diags: diagnostics)
    }
  }
}

/// A Swift type whose value can be represented directly in source code by a
/// Swift literal.
///
/// Conforming types do not *contain* Swift source code; rather, they can be
/// *expressed* in Swift source code, and this protocol can be used to get
/// whatever source code would do that. For example, `String` is
/// `ExpressibleByLiteralSyntax` but `StringLiteralExprSyntax` is not.
///
/// This protocol is usually not used directly. Instead, conforming types can
/// be turned into syntax trees using ``Expr.init(literal:)``:
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
  /// be turned into syntax trees using ``Expr.init(literal:)``:
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
}

// MARK: ExpressibleByLiteralSyntax conformances

extension Substring: ExpressibleByLiteralSyntax {
  public func makeLiteralSyntax() -> StringLiteralExpr {
    String(self).makeLiteralSyntax()
  }
}

extension String: ExpressibleByLiteralSyntax {
  public func makeLiteralSyntax() -> StringLiteralExpr {
    // TODO: Use a multi-line literal if there are more than N inner newlines.
    StringLiteralExpr(content: self)
  }
}

extension ExpressibleByLiteralSyntax where Self: BinaryInteger {
  public func makeLiteralSyntax() -> IntegerLiteralExpr {
    // TODO: Radix selection? Thousands separators?
    let digits = String(self, radix: 10)
    return IntegerLiteralExpr(digits: digits)
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
      return ExprSyntax(MemberAccessExpr(name: "infinity"))

    case .quietNaN:
      return ExprSyntax(MemberAccessExpr(name: "nan"))

    case .signalingNaN:
      return ExprSyntax(MemberAccessExpr(name: "signalingNaN"))

    case .negativeInfinity, .negativeZero:
      return ExprSyntax(
        PrefixOperatorExpr(
          operatorToken: "-",
          postfixExpression: (-self).makeLiteralSyntax()
        )
      )

    case .negativeNormal, .negativeSubnormal, .positiveZero, .positiveSubnormal, .positiveNormal:
      // TODO: Thousands separators?
      let digits = String(self)
      return ExprSyntax(FloatLiteralExpr(floatingDigits: digits))
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
  public func makeLiteralSyntax() -> BooleanLiteralExpr {
    BooleanLiteralExpr(self)
  }
}

extension ArraySlice: ExpressibleByLiteralSyntax where Element: ExpressibleByLiteralSyntax {
  public func makeLiteralSyntax() -> ArrayExprSyntax {
    ArrayExprSyntax(
      leftSquare: .leftSquareBracket,
      elements: ArrayElementList {
        for elem in self {
          ArrayElementSyntax(expression: elem.makeLiteralSyntax())
        }
      },
      rightSquare: .rightSquareBracket
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
      leftSquare: .leftSquareBracket,
      elements: ArrayElementList {
        for elemSyntax in elemSyntaxes {
          ArrayElementSyntax(expression: elemSyntax)
        }
      },
      rightSquare: .rightSquareBracket
    )
  }
}

extension KeyValuePairs: ExpressibleByLiteralSyntax where Key: ExpressibleByLiteralSyntax, Value: ExpressibleByLiteralSyntax {
  public func makeLiteralSyntax() -> DictionaryExprSyntax {
    DictionaryExprSyntax(leftSquare: .leftSquareBracket, rightSquare: .rightSquareBracket) {
      for elem in self {
        DictionaryElementSyntax(
          keyExpression: elem.key.makeLiteralSyntax(),
          colon: .colon,
          valueExpression: elem.value.makeLiteralSyntax()
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

    return DictionaryExprSyntax(leftSquare: .leftSquareBracket, rightSquare: .rightSquareBracket) {
      for elemSyntax in elemSyntaxes {
        DictionaryElementSyntax(
          keyExpression: elemSyntax.key,
          colon: .colon,
          valueExpression: elemSyntax.value
        )
      }
    }
  }
}

extension Optional: ExpressibleByLiteralSyntax where Wrapped: ExpressibleByLiteralSyntax {
  public func makeLiteralSyntax() -> ExprSyntax {
    func containsNil(_ expr: ExprSyntaxProtocol) -> Bool {
      if expr.is(NilLiteralExpr.self) {
        return true
      }

      if let call = expr.as(FunctionCallExpr.self),
        let memberAccess = call.calledExpression.as(MemberAccessExpr.self),
        memberAccess.name.text == "some",
        let argument = call.argumentList.first?.expression
      {
        return containsNil(argument)
      }

      return false
    }

    switch self {
    case nil:
      return ExprSyntax(NilLiteralExpr())

    case let wrapped?:
      let wrappedExpr = wrapped.makeLiteralSyntax()

      // If this is a nested optional type, and the wrapped value is `nil` or
      // e.g. `.some(nil)`, add a layer of `.some(_:)` around it to preserve the
      // depth of the data structure.
      if containsNil(wrappedExpr) {
        return ExprSyntax(
          FunctionCallExpr(callee: MemberAccessExpr(name: "some")) {
            TupleExprElement(expression: wrappedExpr)
          }
        )
      }

      return ExprSyntax(wrappedExpr)
    }
  }
}
