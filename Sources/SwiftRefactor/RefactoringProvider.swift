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

import SwiftSyntax

/// A type that transforms syntax to provide a (context-sensitive)
/// refactoring.
///
/// A type conforming to the `RefactoringProvider` protocol defines
/// a refactoring action against a family of Swift syntax trees.
///
/// Refactoring
/// ===========
///
/// Refactoring is the act of transforming source code to be more effective.
/// A refactoring does not affect the semantics of code it is transforming.
/// Rather, it makes that code easier to read and reason about.
///
/// Code Transformation
/// ===================
///
/// Refactoring is expressed as structural transformations of Swift
/// syntax trees. The SwiftSyntax API provides a natural, easy-to-use,
/// and compositional set of updates to the syntax tree. For example, a
/// refactoring action that wishes to exchange the leading trivia of a node
/// would call `withLeadingTrivia(_:)` against its input syntax and return
/// the resulting syntax node. For compound syntax nodes, entire sub-trees
/// can be added, exchanged, or removed by calling the corresponding `with`
/// API.
///
/// - Note: The syntax trees returned by SwiftSyntax are immutable: any
///         transformation made against the tree results in a distinct tree.
///
/// Handling Malformed Syntax
/// =========================
///
/// A refactoring provider cannot assume that the syntax it is given is
/// neessarily well-formed. As the SwiftSyntax library is capable of recovering
/// from a variety of erroneous inputs, a refactoring provider has to be
/// prepared to fail gracefully as well. Many refactoring providers follow a
/// common validation pattern that "preflights" the refactoring by testing the
/// structure of the provided syntax nodes. If the tests fail, the refactoring
/// provider exits early by returning `nil`. It is recommended that refactoring
/// actions fail as quickly as possible to give any associated tooling
/// space to recover as well.
public protocol RefactoringProvider {
  /// The type of syntax this refactoring action accepts.
  associatedtype Input: SyntaxProtocol = SourceFileSyntax
  /// The type of syntax this refactoring action returns.
  associatedtype Output: SyntaxProtocol = SourceFileSyntax
  /// Contextual information used by the refactoring action.
  associatedtype Context = Void

  /// Perform the refactoring action on the provided syntax node.
  ///
  /// - Parameters:
  ///   - syntax: The syntax to transform.
  ///   - context: Contextual information used by the refactoring action.
  /// - Returns: The result of applying the refactoring action, or `nil` if the
  ///            action could not be performed.
  static func refactor(syntax: Self.Input, in context: Self.Context) -> Self.Output?
}

extension RefactoringProvider where Context == Void {
  /// Perform the refactoring action on the provided syntax node.
  ///
  /// This method provides a convenient way to invoke a refactoring action that
  /// requires no context.
  ///
  /// - Parameters:
  ///   - syntax: The syntax to transform.
  /// - Returns: The result of applying the refactoring action, or `nil` if the
  ///            action could not be performed.
  public static func refactor(syntax: Self.Input) -> Self.Output? {
    return self.refactor(syntax: syntax, in: ())
  }
}
