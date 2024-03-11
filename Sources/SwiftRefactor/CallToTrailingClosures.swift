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

  // TODO: Rather than returning nil, we should consider throwing errors with
  // appropriate messages instead.
  public static func refactor(syntax call: FunctionCallExprSyntax, in context: Context = Context()) -> FunctionCallExprSyntax? {
    let converted = call.convertToTrailingClosures(from: context.startAtArgument)
    return converted?.formatted().as(FunctionCallExprSyntax.self)
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
        closure.trailingTrivia = closure.trailingTrivia.merging(triviaOf: comma)
      }
      closures.append((arg, closure))
    }

    guard !closures.isEmpty else {
      return nil
    }

    // First trailing closure won't have label/colon. Transfer their trivia.
    var trailingClosure = closures.first!.closure
    trailingClosure.leadingTrivia =
      Trivia()
      .merging(triviaOf: closures.first!.original.label)
      .merging(triviaOf: closures.first!.original.colon)
      .merging(closures.first!.closure.leadingTrivia)
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
      if let leftParen = leftParen {
        trailingClosure.leadingTrivia = Trivia()
          .merging(triviaOf: leftParen)
          .merging(trailingClosure.leadingTrivia)
      }
      // No right paren anymore. Attach its trivia to the end of the call.
      if let rightParen = rightParen {
        additionalTriviaAtEndOfCall = Trivia().merging(triviaOf: rightParen)
      }
    } else {
      let last = argList.last!
      // Move the trailing trivia of the closing parenthesis to the end of the call after the last trailing, instead of
      // keeping it in the middle of the call where the new closing parenthesis lives.
      // Also ensure that we don't drop trivia from any comma we remove.
      converted.rightParen?.trailingTrivia = Trivia().merging(triviaOf: last.trailingComma)
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
      converted.trailingTrivia = converted.trailingTrivia.merging(additionalTriviaAtEndOfCall.droppingLeadingWhitespace)
    }

    return converted
  }
}

fileprivate extension Trivia {
  var droppingLeadingWhitespace: Trivia {
    return Trivia(pieces: self.drop(while: \.isWhitespace))
  }
}

fileprivate extension Sequence {
  func dropSuffix(while predicate: (Element) -> Bool) -> [Element] {
    self.reversed().drop(while: predicate).reversed()
  }
}
