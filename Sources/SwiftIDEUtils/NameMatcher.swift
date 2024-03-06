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
import SwiftParser
public import SwiftSyntax
#else
import SwiftParser
import SwiftSyntax
#endif

/// Given a set of positions in a source file, resolve the names of the
/// declarations that are referenced at these locations and, if they refer to
/// functions, their argument labels.
@_spi(Compiler)
public class NameMatcher: SyntaxAnyVisitor {
  /// The positions that still need to be resolved.
  ///
  /// Elements are removed from this set when they are resoled.
  private var positionsToResolve: [AbsolutePosition]

  /// The locations that we have already resolved.
  ///
  /// - Note: These are not guaranteed to be in source order since we might eg. generate an entry for a subscript call
  ///   at `[` when visiting the `SubscriptCallExprSyntax` before resolving the base name at `foo[1]`.
  private var resolvedLocs: [DeclNameLocation] = []

  /// The topmost element of this stack always represents the context of newly resolved locations.
  ///
  /// As we walk into syntax nodes that contribute context to any locations resolved within them, an entry is pushed to
  /// this stack. Elements are popped of the stack when the syntax node with the context is left.
  private var contextStack: [DeclNameLocation.Context] = [.default] {
    didSet {
      precondition(!contextStack.isEmpty)
    }
  }
  /// The topmost element of this stack always represents whether newly resolved locations are active or inactive.
  ///
  /// As we walk into `#if` regions, an element is pushed to this stack depending on whether the region is active. As
  /// the region is left, values are popped.
  private var isActiveStack: [Bool] = [true] {
    didSet {
      precondition(!isActiveStack.isEmpty)
    }
  }

  private init(baseNamePositions: some Sequence<AbsolutePosition>) {
    self.positionsToResolve = baseNamePositions.sorted()
    super.init(viewMode: .sourceAccurate)
  }

  // MARK: - Public entry

  public static func resolve(baseNamePositions: some Sequence<AbsolutePosition>, in tree: some SyntaxProtocol) -> [DeclNameLocation] {
    let matcher = NameMatcher(baseNamePositions: baseNamePositions)
    matcher.walk(tree)
    return matcher.resolvedLocs
  }

  // MARK: - Utilities

  /// Checks if the `position` is in `positionsToResolve`. If so, remove it from `positionsToResolve` and return `true`.
  /// Otherwise, return `false`.
  private func removePositionToResolveIfExists(at position: AbsolutePosition) -> Bool {
    for (index, positionToResolve) in positionsToResolve.enumerated() {
      if positionToResolve > position {
        // positionToResolve is sorted. If we're already past the position we are looking for, we won't find anything
        // later.
        return false
      }
      if positionToResolve == position {
        positionsToResolve.remove(at: index)
        return true
      }
    }
    return false
  }

  /// If there is a position to resolve inside `range` return it, otherwise return `nil`.
  private func firstPositionToResolve(in range: Range<AbsolutePosition>) -> AbsolutePosition? {
    for positionToResolve in positionsToResolve {
      if positionToResolve > range.upperBound {
        // positionToResolve is sorted. If we're already past the range we are looking for, we won't find anything later
        return nil
      }
      if range.contains(positionToResolve) {
        return positionToResolve
      }
    }
    return nil
  }

  // MARK: - addResolvedLocIfRequested overloads

  /// If a position should be resolved at at the start of `baseNameRange`, create a new `DeclNameLocation` to
  /// `resolvedLocs`, otherwise a no-op.
  private func addResolvedLocIfRequested(
    baseNameRange: Range<AbsolutePosition>,
    argumentLabels: DeclNameLocation.Arguments,
    context: DeclNameLocation.Context? = nil
  ) {
    guard removePositionToResolveIfExists(at: baseNameRange.lowerBound) else {
      return
    }
    resolvedLocs.append(
      DeclNameLocation(
        baseNameRange: baseNameRange,
        arguments: argumentLabels,
        context: context ?? contextStack.last!,
        isActive: isActiveStack.last!
      )
    )
  }

  /// Try resolving `baseName` with the given argument labels.
  ///
  /// This adds a resolved location if the start of `baseName` is in `positionsToResolve` and if the base name starts
  /// with `$` or `_` and `positionsToResolve` contains the position after the `$` or `_`. This ensures that we can
  /// rename the underlying properties referenced by property wrappers.
  private func addResolvedLocIfRequested(
    baseName: TokenSyntax,
    argumentLabels: DeclNameLocation.Arguments
  ) {
    addResolvedLocIfRequested(
      baseNameRange: baseName.rangeWithoutTrivia,
      argumentLabels: argumentLabels
    )
    if baseName.text.first == "$" || baseName.text.first == "_" {
      let range = baseName.positionAfterSkippingLeadingTrivia.advanced(by: 1)..<baseName.endPositionBeforeTrailingTrivia
      addResolvedLocIfRequested(
        baseNameRange: range,
        argumentLabels: argumentLabels
      )
    }
  }

  /// Try resolving a function-style call at `baseName`.
  ///
  /// This computes the argument labels from the passed arguments and trailing closures.
  private func addResolvedLocIfRequested(
    baseName: TokenSyntax,
    arguments: LabeledExprListSyntax,
    trailingClosure: ClosureExprSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementListSyntax? = nil
  ) {
    var firstTrailingClosureIndex: Int? = nil
    var argumentLabels = arguments.map { (argument) -> DeclNameLocation.Argument in
      if let label = argument.label, let colon = argument.colon {
        return .labeledCall(label: label, colon: colon)
      } else {
        return .unlabeled(argument: Syntax(argument.colon) ?? Syntax(argument.expression))
      }
    }
    if let trailingClosure {
      firstTrailingClosureIndex = argumentLabels.count
      argumentLabels.append(.unlabeled(argument: trailingClosure))
    }
    if let additionalTrailingClosures {
      argumentLabels += additionalTrailingClosures.map { (additionalTrailingClosure) -> DeclNameLocation.Argument in
        // We need to report additional trailing closure labels in the same way that we report function parameters
        // because changing the argument label to `_` should result in an additional trailing closure label `_:` instead
        // of removing the label, which is what `labeledCall` does
        return .labeled(firstName: additionalTrailingClosure.label, secondName: nil)
      }
    }
    addResolvedLocIfRequested(baseName: baseName, argumentLabels: .call(argumentLabels, firstTrailingClosureIndex: firstTrailingClosureIndex))
  }

  /// Try resolving a function-style declaration at `baseName`.
  ///
  /// This computes the argument labels from the passed function signature.
  private func addResolvedLocIfRequested(
    baseName: TokenSyntax,
    signature: FunctionSignatureSyntax
  ) {
    let argumentLabels = signature.parameterClause.parameters.map { (argument) -> DeclNameLocation.Argument in
      return .labeled(firstName: argument.firstName, secondName: argument.secondName)
    }
    addResolvedLocIfRequested(baseName: baseName, argumentLabels: .parameters(argumentLabels))
  }

  // MARK: - Visit functions

  public override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    if firstPositionToResolve(in: node.position..<node.endPosition) == nil {
      return .skipChildren
    } else {
      return .visitChildren
    }
  }

  public override func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
    while let baseNamePosition = firstPositionToResolve(in: token.leadingTriviaRange) ?? firstPositionToResolve(in: token.trailingTriviaRange) {
      // Parse the comment from the position that we want to resolve. This should parse any function calls or compound decl names, the rest of
      // the comment will probably be parsed as garbage but that's OK because we don't actually care about it.
      let positionOffsetInToken = baseNamePosition.utf8Offset - token.position.utf8Offset
      let commentTree = token.syntaxTextBytes[positionOffsetInToken...].withUnsafeBufferPointer { (buffer) -> ExprSyntax in
        var parser = Parser(buffer)
        return ExprSyntax.parse(from: &parser)
      }
      // Run a new `NameMatcher`. Since the input of that name matcher is the text after the position to resolve, we
      // want to resolve the position at offset 0.
      let resolvedInComment = NameMatcher.resolve(baseNamePositions: [AbsolutePosition(utf8Offset: 0)], in: commentTree)

      let positionRemoved = removePositionToResolveIfExists(at: baseNamePosition)
      precondition(positionRemoved, "Found a position with `firstPositionToResolve but didn't find it again to remove it?")

      // Adjust the positions to point back to the original tree, set the context as `comment` and record them.
      resolvedLocs += resolvedInComment.map { locationInComment in
        DeclNameLocation(
          baseNameRange: locationInComment.baseNameRange.advanced(by: baseNamePosition.utf8Offset),
          arguments: locationInComment.arguments.advanced(by: baseNamePosition.utf8Offset),
          context: .comment,
          isActive: isActiveStack.last!
        )
      }
    }

    if case .stringSegment = token.tokenKind {
      while let baseNamePosition = positionsToResolve.first(where: { token.rangeWithoutTrivia.contains($0) }) {
        let positionOffsetInStringSegment = baseNamePosition.utf8Offset - token.position.utf8Offset
        guard let tokenLength = getFirstTokenLength(in: token.syntaxTextBytes[positionOffsetInStringSegment...]) else {
          continue
        }
        addResolvedLocIfRequested(
          baseNameRange: baseNamePosition..<baseNamePosition.advanced(by: tokenLength.utf8Length),
          argumentLabels: .noArguments,
          context: .stringLiteral
        )
      }
    }
    addResolvedLocIfRequested(baseName: token, argumentLabels: .noArguments)
    return .skipChildren
  }

  public override func visit(_ node: AttributeSyntax) -> SyntaxVisitorContinueKind {
    let attributeName: TokenSyntax
    if let name = node.attributeName.as(IdentifierTypeSyntax.self) {
      attributeName = name.name
    } else if let name = node.attributeName.as(MemberTypeSyntax.self) {
      attributeName = name.name
    } else {
      return .visitChildren
    }

    if node.arguments == nil {
      addResolvedLocIfRequested(baseName: attributeName, argumentLabels: .noArguments)
    } else if case .argumentList(let argumentList) = node.arguments {
      addResolvedLocIfRequested(baseName: attributeName, arguments: argumentList)
    }
    return .visitChildren
  }

  public override func visit(_ node: DeclReferenceExprSyntax) -> SyntaxVisitorContinueKind {
    if let argumentNames = node.argumentNames {
      addResolvedLocIfRequested(
        baseName: node.baseName,
        argumentLabels: .selector(argumentNames.arguments.map { .labeled(firstName: $0.name, secondName: nil) })
      )
    } else if let functionCall = node.parentFunctionCall {
      addResolvedLocIfRequested(
        baseName: node.baseName,
        arguments: functionCall.arguments,
        trailingClosure: functionCall.trailingClosure,
        additionalTrailingClosures: functionCall.additionalTrailingClosures
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: EnumCaseElementSyntax) -> SyntaxVisitorContinueKind {
    if let parameterClause = node.parameterClause {
      let argumentLabels = parameterClause.parameters.map { (argument) -> DeclNameLocation.Argument in
        if let firstName = argument.firstName {
          return .labeled(firstName: firstName, secondName: argument.secondName)
        } else {
          return .unlabeled(argument: Syntax(argument.secondName) ?? Syntax(argument.colon) ?? Syntax(argument.type))
        }
      }
      addResolvedLocIfRequested(baseName: node.name, argumentLabels: .parameters(argumentLabels))
    }
    return .visitChildren
  }

  public override func visit(_ node: FunctionCallExprSyntax) -> SyntaxVisitorContinueKind {
    // Calls to closures are represented by a location to resolve at the opening `(`. We need to match that.
    // Renames of the function name are handled by `visit(_:DeclReferenceExprSyntax)`.
    if let leftParen = node.leftParen {
      addResolvedLocIfRequested(
        baseName: leftParen,
        arguments: node.arguments,
        trailingClosure: node.trailingClosure,
        additionalTrailingClosures: node.additionalTrailingClosures
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
    addResolvedLocIfRequested(baseName: node.name, signature: node.signature)
    return .visitChildren
  }

  public override func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind {
    isActiveStack.append(false)
    return .visitChildren
  }

  public override func visitPost(_ node: IfConfigDeclSyntax) {
    isActiveStack.removeLast()
  }

  public override func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    addResolvedLocIfRequested(baseName: node.initKeyword, signature: node.signature)
    return .visitChildren
  }

  public override func visit(_ node: MacroDeclSyntax) -> SyntaxVisitorContinueKind {
    addResolvedLocIfRequested(baseName: node.name, signature: node.signature)
    return .visitChildren
  }

  public override func visit(_ node: MacroExpansionDeclSyntax) -> SyntaxVisitorContinueKind {
    if node.macroName.text == "selector" {
      contextStack.append(.selector)
    }
    addResolvedLocIfRequested(
      baseName: node.macroName,
      arguments: node.arguments,
      trailingClosure: node.trailingClosure,
      additionalTrailingClosures: node.additionalTrailingClosures
    )
    return .visitChildren
  }

  public override func visitPost(_ node: MacroExpansionDeclSyntax) {
    if node.macroName.text == "selector" {
      contextStack.removeLast()
    }
  }

  public override func visit(_ node: MacroExpansionExprSyntax) -> SyntaxVisitorContinueKind {
    if node.macroName.text == "selector" {
      contextStack.append(.selector)
    }
    addResolvedLocIfRequested(
      baseName: node.macroName,
      arguments: node.arguments,
      trailingClosure: node.trailingClosure,
      additionalTrailingClosures: node.additionalTrailingClosures
    )
    return .visitChildren
  }

  public override func visitPost(_ node: MacroExpansionExprSyntax) {
    if node.macroName.text == "selector" {
      contextStack.removeLast()
    }
  }

  public override func visit(_ node: SubscriptCallExprSyntax) -> SyntaxVisitorContinueKind {
    addResolvedLocIfRequested(
      baseName: node.leftSquare,
      arguments: node.arguments,
      trailingClosure: node.trailingClosure,
      additionalTrailingClosures: node.additionalTrailingClosures
    )
    return .visitChildren
  }

  public override func visit(_ node: SubscriptDeclSyntax) -> SyntaxVisitorContinueKind {
    let argumentLabels = node.parameterClause.parameters.map { (argument) -> DeclNameLocation.Argument in
      return .labeled(firstName: argument.firstName, secondName: argument.secondName)
    }
    addResolvedLocIfRequested(baseName: node.subscriptKeyword, argumentLabels: .noncollapsibleParameters(argumentLabels))
    return .visitChildren
  }
}

extension TokenSyntax {
  var rangeWithoutTrivia: Range<AbsolutePosition> {
    return positionAfterSkippingLeadingTrivia..<endPositionBeforeTrailingTrivia
  }
  var leadingTriviaRange: Range<AbsolutePosition> {
    return position..<positionAfterSkippingLeadingTrivia
  }
  var trailingTriviaRange: Range<AbsolutePosition> {
    return endPositionBeforeTrailingTrivia..<endPosition
  }
}

extension DeclReferenceExprSyntax {
  var parentFunctionCall: FunctionCallExprSyntax? {
    if let functionCall = self.parent?.as(FunctionCallExprSyntax.self) {
      // E.g `foo(a: 1)`
      return functionCall
    } else if let memberAccess = self.parent?.as(MemberAccessExprSyntax.self),
      memberAccess.declName == self,
      let functionCall = memberAccess.parent?.as(FunctionCallExprSyntax.self)
    {
      // E.g. `foo.bar(a: 1)``
      return functionCall
    } else {
      return nil
    }
  }
}

private func getFirstTokenLength(in text: ArraySlice<UInt8>) -> SourceLength? {
  return text.withUnsafeBufferPointer { (buffer) -> SourceLength? in
    // We can force-unwrap the first token because there must be at least the EOF token in the source file.
    let firstToken = Parser.parse(source: buffer).firstToken(viewMode: .sourceAccurate)!
    guard firstToken.leadingTriviaLength == .zero else {
      return nil
    }
    return firstToken.trimmedLength
  }
}
