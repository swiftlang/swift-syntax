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

#if compiler(>=6)
import SwiftBasicFormat
public import SwiftSyntax
#else
import SwiftBasicFormat
import SwiftSyntax
#endif

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

  public typealias Input = Syntax
  public typealias Output = Syntax

  /// Apply the refactoring to a given syntax node. If either a
  /// non-function-like syntax node is passed, or the refactoring fails,
  /// an error is thrown.
  public static func refactor(
    syntax: Syntax,
    in context: Context = Context()
  ) throws -> Syntax {
    guard let call = syntax.asProtocol(CallLikeSyntax.self) else {
      throw RefactoringNotApplicableError("not a call")
    }
    return try Syntax(fromProtocol: _refactor(syntax: call, in: context))
  }

  @available(*, deprecated, message: "Pass a Syntax argument instead of FunctionCallExprSyntax")
  public static func refactor(
    syntax call: FunctionCallExprSyntax,
    in context: Context = Context()
  ) throws -> FunctionCallExprSyntax {
    try _refactor(syntax: call, in: context)
  }

  internal static func _refactor<C: CallLikeSyntax>(
    syntax call: C,
    in context: Context = Context()
  ) throws -> C {
    let converted = try call.convertToTrailingClosures(from: context.startAtArgument)

    guard let formatted = converted.formatted().as(C.self) else {
      throw RefactoringNotApplicableError("format error")
    }

    return formatted
  }
}

extension CallLikeSyntax {
  fileprivate func convertToTrailingClosures(from startAtArgument: Int) throws -> Self {
    guard trailingClosure == nil, additionalTrailingClosures.isEmpty, leftParen != nil, rightParen != nil else {
      throw RefactoringNotApplicableError("call already uses trailing closures")
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
        closure.trailingTrivia = closure.trailingTrivia.mergingCommonSuffix(triviaOf: comma)
      }
      closures.append((arg, closure))
    }

    guard !closures.isEmpty else {
      throw RefactoringNotApplicableError("no arguments to convert to closures")
    }

    // First trailing closure won't have label/colon. Transfer their trivia.
    let (firstOriginal, firstClosure) = closures.first!
    var trailingClosure = firstClosure
    trailingClosure.leadingTrivia =
      (firstOriginal.label?.triviaByMergingCommonSuffix ?? [])
      .mergingCommonSuffix(triviaOf: firstOriginal.colon)
      .mergingCommonSuffix(firstClosure.leadingTrivia)
      .droppingLeadingWhitespace
    let additionalTrailingClosures = closures.dropFirst().map {
      MultipleTrailingClosureElementSyntax(
        label: $0.original.label ?? .wildcardToken(),
        colon: $0.original.colon ?? .colonToken(),
        closure: $0.closure
      )
    }

    var converted = self.detached

    // Trivia that should be attached to the end of the converted call.
    var additionalTriviaAtEndOfCall: Trivia? = nil

    // Remove parens if there's no non-closure arguments left and remove the
    // last comma otherwise. Makes sure to keep the trivia of any removed node.
    var argList = Array(arguments.dropLast(closures.count))
    if argList.isEmpty {
      converted.leftParen = nil
      converted.rightParen = nil

      // No left paren any more, right paren is handled below since it makes
      // sense to keep its trivia of the end of the call, regardless of whether
      // it was removed or not.
      if let leftParen {
        trailingClosure.leadingTrivia = leftParen.triviaByMergingCommonSuffix
          .mergingCommonSuffix(trailingClosure.leadingTrivia)
      }
      // No right paren anymore. Attach its trivia to the end of the call.
      if let rightParen {
        additionalTriviaAtEndOfCall = rightParen.triviaByMergingCommonSuffix
      }
    } else {
      let last = argList.last!
      // Move the trailing trivia of the closing parenthesis to the end of the call after the last trailing, instead of
      // keeping it in the middle of the call where the new closing parenthesis lives.
      // Also ensure that we don't drop trivia from any comma we remove.
      converted.rightParen?.trailingTrivia = last.trailingComma?.triviaByMergingCommonSuffix ?? []
      additionalTriviaAtEndOfCall = rightParen?.trailingTrivia
      argList[argList.count - 1] = last.with(\.trailingComma, nil)
    }

    // Update arguments and trailing closures
    converted.arguments = LabeledExprListSyntax(argList)
    converted.trailingClosure = trailingClosure
    if !additionalTrailingClosures.isEmpty {
      converted.additionalTrailingClosures = MultipleTrailingClosureElementListSyntax(additionalTrailingClosures)
    }

    if let additionalTriviaAtEndOfCall {
      converted.trailingTrivia = converted.trailingTrivia.mergingCommonSuffix(
        additionalTriviaAtEndOfCall.droppingLeadingWhitespace
      )
    }

    return converted
  }
}

fileprivate extension Sequence {
  func dropSuffix(while predicate: (Element) -> Bool) -> [Element] {
    self.reversed().drop(while: predicate).reversed()
  }
}
