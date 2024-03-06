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
public import SwiftSyntax
#else
import SwiftSyntax
#endif

/// The location of a declaration name, resolved by ``NameMatcher`` and that can
/// be used to rename the declaration name and, if it is a function, its
/// argument labels.
@_spi(Compiler)
public struct DeclNameLocation: Equatable {
  /// A single argument inside a ``DeclNameLocation``.
  public enum Argument: Equatable {
    /// The argument has an explicit label.
    ///
    /// The ranges are the ranges of the first name and second name, both without trivia.
    ///
    /// ## Examples
    /// - `a` in `func foo(a: Int) {}`
    /// - `a` and `b` in `func foo(a b: Int) {}`
    /// - `additionalTrailingClosure:` in `foo {} additionalTrailingClosure: {}`
    ///   - We cannot use `labeledCall` here because when changing the parameter label to `_`, we need to change the
    ///     call to `foo {} _: {}`. If we used `labeledCall`, the label would be removed, leaving us with `foo {} {}`.
    case labeled(firstName: Range<AbsolutePosition>, secondName: Range<AbsolutePosition>?)

    /// The argument of a call.
    ///
    /// The range of the label does not include trivia.
    ///
    /// The range of the colon *does* include trivia. This is so we can remove the colon including the space after it
    /// when changing a labeled parameter to an unlabeled parameter.
    ///
    /// ## Examples
    /// - `a` and `:` in `foo(a: 1)`
    case labeledCall(label: Range<AbsolutePosition>, colon: Range<AbsolutePosition>)

    /// The argument is unlabeled (like `foo(1)`).
    ///
    /// The position points to the position of the argument after skipping leading trivia.
    case unlabeled(argumentPosition: AbsolutePosition)

    static func labeled(firstName: TokenSyntax, secondName: TokenSyntax?) -> Argument {
      return .labeled(firstName: firstName.rangeWithoutTrivia, secondName: secondName?.rangeWithoutTrivia)
    }

    static func labeledCall(label: TokenSyntax, colon: TokenSyntax) -> Argument {
      return .labeledCall(label: label.rangeWithoutTrivia, colon: colon.position..<colon.endPosition)
    }

    static func unlabeled(argument: some SyntaxProtocol) -> Argument {
      return .unlabeled(argumentPosition: argument.positionAfterSkippingLeadingTrivia)
    }

    public var range: Range<AbsolutePosition> {
      switch self {
      case .labeled(let firstName, let secondName):
        let endPosition = secondName?.upperBound ?? firstName.upperBound
        return firstName.lowerBound..<endPosition
      case .labeledCall(label: let label, colon: let colon):
        return label.lowerBound..<colon.upperBound
      case .unlabeled(argumentPosition: let argumentPosition):
        return argumentPosition..<argumentPosition
      }
    }

    /// Shift the ranges `utf8Offset` bytes to the right, ie. add `utf8Offset` to the upper and lower bound.
    func advanced(by utf8Offset: Int) -> DeclNameLocation.Argument {
      switch self {
      case .labeled(firstName: let firstName, secondName: let secondName):
        return .labeled(firstName: firstName.advanced(by: utf8Offset), secondName: secondName?.advanced(by: utf8Offset))
      case .labeledCall(label: let label, colon: let colon):
        return .labeledCall(label: label.advanced(by: utf8Offset), colon: colon.advanced(by: utf8Offset))
      case .unlabeled(argumentPosition: let argumentPosition):
        return .unlabeled(argumentPosition: argumentPosition.advanced(by: utf8Offset))
      }
    }
  }

  /// The arguments of a ``DeclNameLocation``.
  public enum Arguments: Equatable {
    /// The location doesn't have any arguments
    case noArguments

    /// A function call, like `foo(a: 2)`
    ///
    /// If the call contains a trailing closure, `firstTrailingClosureIndex` is the index to the first argument that
    /// is a trailing closure, otherwise `firstTrailingClosureIndex` is `nil`.
    case call([Argument], firstTrailingClosureIndex: Int?)

    /// The parameter of a function declaration, like `func foo(a b: Int)`
    case parameters([Argument])

    /// Same as `param` but the parameters can't be collapsed if they are the same. This is the case for subscript
    /// declarations.
    ///
    /// For example, `subscript(a a: Int)` requires both the first and the second parameter label.
    case noncollapsibleParameters([Argument])

    /// The argument label to disambiguate multiple functions with the same base name, like `foo(a:)`.
    case selector([Argument])

    /// Shift the ranges `utf8Offset` bytes to the right, ie. add `utf8Offset` to the upper and lower bound.
    func advanced(by utf8Offset: Int) -> DeclNameLocation.Arguments {
      switch self {
      case .noArguments:
        return .noArguments
      case .call(let arguments, firstTrailingClosureIndex: let firstTrailingClosureIndex):
        return .call(arguments.map { $0.advanced(by: utf8Offset) }, firstTrailingClosureIndex: firstTrailingClosureIndex)
      case .parameters(let parameters):
        return .parameters(parameters.map { $0.advanced(by: utf8Offset) })
      case .noncollapsibleParameters(let parameters):
        return .noncollapsibleParameters(parameters.map { $0.advanced(by: utf8Offset) })
      case .selector(let arguments):
        return .selector(arguments.map { $0.advanced(by: utf8Offset) })
      }
    }
  }

  public enum Context {
    /// The name occurs anywhere in normal Swift code.
    case `default`

    /// The name occurs inside a `#selector`.
    case selector

    /// The name occurs inside a comment.
    case comment

    /// The name occurs inside a string literal.
    case stringLiteral
  }

  /// The range of the base name, without trivia.
  ///
  /// ## Examples
  /// - For `foo(a: 1)`, the range of `foo`.
  /// - For `myArray[1]`, the base name range is `[`.
  /// - For a variable that is a closure, and a call `closure(1)`, the call has the base name `(`.
  public let baseNameRange: Range<AbsolutePosition>

  public let arguments: Arguments

  /// The context in which the name occurs, eg. in code, a comment or a string
  /// literal.
  public let context: Context

  /// If the name occurs in an inactive `#if` region, `false`, otherwise `true`.
  ///
  /// - Note: Currently `NameMatcher` does not evaluate `#if` conditions and all
  ///   occurances within `#if`, `#elseif` or `#else` blocks are considered inactive.
  public let isActive: Bool
}
