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

import SwiftBasicFormat
import SwiftSyntax

/// Convert a call with inline closures to one that uses trailing closure
/// syntax. Returns `nil` if there's already trailing closures or there are no
/// closures within the call. Pass `startAtArgument` to specify the argument
/// index to start the conversion from, ie. to skip converting closures before
/// `startAtArgument`.
///
/// ## Before
/// ```
/// someCall(closure1: { arg in
///   return 1
/// }, closure2: { arg in
///   return 2
/// })
/// ```
///
/// ## After
/// ```
/// someCall { arg in
///   return 1
/// } closure2: { arg in
///   return 2
/// }
/// ```
public struct CallToTrailingClosures: SyntaxRefactoringProvider {
  public struct Context {
    public let startAtArgument: Int

    public init(startAtArgument: Int = 0) {
      self.startAtArgument = startAtArgument
    }
  }

  // TODO: Rather than returning nil, we should consider throwing errors with
  // appropriate messages instead.
  public static func refactor(syntax call: FunctionCallExprSyntax, in context: Context = Context()) -> FunctionCallExprSyntax? {
    return call.convertToTrailingClosures(from: context.startAtArgument)?.formatted().as(FunctionCallExprSyntax.self)
  }
}

extension FunctionCallExprSyntax {
  fileprivate func convertToTrailingClosures(from startAtArgument: Int) -> FunctionCallExprSyntax? {
    guard trailingClosure == nil, additionalTrailingClosures.isEmpty, leftParen != nil, rightParen != nil else {
      // Already have trailing closures
      return nil
    }

    var closures = [(original: LabeledExprSyntax, closure: ClosureExprSyntax)]()
    for arg in arguments.dropFirst(startAtArgument) {
      guard var closure = arg.expression.as(ClosureExprSyntax.self) else {
        closures.removeAll()
        continue
      }

      // Trailing comma won't exist any more, move its trivia to the end of
      // the closure instead
      if let comma = arg.trailingComma {
        closure = closure.with(\.trailingTrivia, closure.trailingTrivia.merging(triviaOf: comma))
      }
      closures.append((arg, closure))
    }

    guard !closures.isEmpty else {
      return nil
    }

    // First trailing closure won't have label/colon. Transfer their trivia.
    var trailingClosure = closures.first!.closure
      .with(
        \.leadingTrivia,
        Trivia()
          .merging(triviaOf: closures.first!.original.label)
          .merging(triviaOf: closures.first!.original.colon)
          .merging(closures.first!.closure.leadingTrivia)
      )
    let additionalTrailingClosures = closures.dropFirst().map {
      MultipleTrailingClosureElementSyntax(
        label: $0.original.label ?? .wildcardToken(),
        colon: $0.original.colon ?? .colonToken(),
        closure: $0.closure
      )
    }

    var converted = self.detached

    // Remove parens if there's no non-closure arguments left and remove the
    // last comma otherwise. Makes sure to keep the trivia of any removed node.
    var argList = Array(arguments.dropLast(closures.count))
    if argList.isEmpty {
      converted =
        converted
        .with(\.leftParen, nil)
        .with(\.rightParen, nil)

      // No left paren any more, right paren is handled below since it makes
      // sense to keep its trivia of the end of the call, regardless of whether
      // it was removed or not.
      if let leftParen = leftParen {
        trailingClosure = trailingClosure.with(
          \.leadingTrivia,
          Trivia()
            .merging(triviaOf: leftParen)
            .merging(trailingClosure.leadingTrivia)
        )
      }
    } else {
      let last = argList.last!
      if let comma = last.trailingComma {
        converted =
          converted
          .with(\.rightParen, TokenSyntax.rightParenToken(trailingTrivia: Trivia().merging(triviaOf: comma)))
      }
      argList[argList.count - 1] =
        last
        .with(\.trailingComma, nil)
    }

    // Update arguments and trailing closures
    converted =
      converted
      .with(\.arguments, LabeledExprListSyntax(argList))
      .with(\.trailingClosure, trailingClosure)
    if !additionalTrailingClosures.isEmpty {
      converted = converted.with(\.additionalTrailingClosures, MultipleTrailingClosureElementListSyntax(additionalTrailingClosures))
    }

    // The right paren either doesn't exist any more, or is before all the
    // trailing closures. Moves its trivia to the end of the converted call.
    if let rightParen = rightParen {
      converted = converted.with(\.trailingTrivia, converted.trailingTrivia.merging(triviaOf: rightParen))
    }

    return converted
  }
}
