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

import SwiftSyntax

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
    case labeled(firstName: Range<AbsolutePosition>, secondName: Range<AbsolutePosition>?)

    /// The argument of a call.
    ///
    /// The range of the label does not include trivia. The range of the colon *does* include trivia.
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
      // FIXME: (NameMatcher) The `labeledCall` case is problematic for two reasons
      // 1. The fact that `colon` includes trivia is inconsistent with the associated values in `label` and `labeledCall`
      // 2. If `colon` didn't need to contain trivia, we wouldn't need the `labeledCall` case at all.
      // See if we can unify `labeledCall` and `labeled`.
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
