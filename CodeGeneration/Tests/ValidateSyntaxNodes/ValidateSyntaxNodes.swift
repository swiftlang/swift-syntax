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

import SyntaxSupport

import XCTest

fileprivate func assertNoFailures(
  _ failures: [ValidationFailure],
  message: String,
  file: StaticString = #file,
  line: UInt = #line
) {
  if failures.isEmpty {
    return
  }
  var message = "\(message): \n"
  let failuresByNode = [SyntaxNodeKind: [ValidationFailure]](failures.map({ ($0.node, [$0]) })) { $0 + $1 }

  for (nodeKind, failures) in failuresByNode.sorted(by: { $0.key.rawValue < $1.key.rawValue }) {
    message += "\(nodeKind.syntaxType):\n"
    for failure in failures {
      message += "  - \(failure.message)\n"
    }
  }
  XCTFail(message, file: file, line: line)
}

fileprivate func assertFailuresMatchXFails(
  _ failures: [ValidationFailure],
  expectedFailures: [ValidationFailure],
  file: StaticString = #file,
  line: UInt = #line
) {
  let matchedXFails = expectedFailures.filter { failures.contains($0) }
  let failures = failures.filter { !matchedXFails.contains($0) }
  let unmatchedXFails = expectedFailures.filter { !matchedXFails.contains($0) }

  assertNoFailures(failures, message: "Unexpected valiation failures found", file: file, line: line)
  assertNoFailures(unmatchedXFails, message: "Unmatched expected failures", file: file, line: line)
}

fileprivate extension ChildKind {
  func hasSameType(as other: ChildKind) -> Bool {
    switch (self, other) {
    case (.node(let kind), .node(kind: let otherKind)):
      return kind == otherKind
    case (.nodeChoices(let choices), .nodeChoices(let otherChoices)):
      return choices.count == otherChoices.count && zip(choices, otherChoices).allSatisfy { $0.hasSameType(as: $1) }
    case (.collection(let kind, _, _), .collection(let otherKind, _, _)):
      return kind == otherKind
    case (.token(let choices, _, _), .token(let otherChoices, _, _)):
      return choices == otherChoices
    case (.node(let kind), .collection(let otherKind, _, _)):
      return kind == otherKind
    case (.collection(let kind, _, _), .node(let otherKind)):
      return kind == otherKind
    default:
      return false
    }
  }
}

fileprivate extension Child {
  func hasSameType(as other: Child) -> Bool {
    return name == other.name && kind.hasSameType(as: other.kind) && isOptional == other.isOptional
  }

  func isFollowedByColonToken(in node: LayoutNode) -> Bool {
    guard let childIndex = node.children.firstIndex(where: { $0.name == self.name }) else {
      preconditionFailure("\(self.name) is not a child of \(node.kind.syntaxType)")
    }
    guard childIndex + 2 < node.children.count else {
      return false
    }
    if case .token(choices: [.token(tokenKind: "ColonToken")], _, _) = node.children[childIndex + 2].kind {
      return true
    } else {
      return false
    }
  }
}

fileprivate extension Array where Element: Hashable, Element: Comparable {
  /// Returns the element that occurs most frequently in the array.
  ///
  /// If there is a tie, returns the lexicographically first element.
  ///
  /// Returns `nil` if the array is empty.
  var mostCommon: Element? {
    var elementCounts: [Element: Int] = [:]
    for element in self {
      elementCounts[element, default: 0] += 1
    }
    let maxCount = elementCounts.values.max()
    return elementCounts.filter({ $0.value == maxCount }).map(\.key).sorted().first
  }
}

class ValidateSyntaxNodes: XCTestCase {
  /// All nodes with base kind e.g. `ExprSyntax` should end with `ExprSyntax`.
  func testBaseKindSuffix() {
    var failures: [ValidationFailure] = []
    for node in SYNTAX_NODES where node.base != .syntaxCollection {
      if !node.kind.syntaxType.description.hasSuffix(node.base.syntaxType.description) {
        failures.append(
          ValidationFailure(node: node.kind, message: "has base kind '\(node.base.syntaxType)' but type name doesn’t have '\(node.base.syntaxType)' suffix")
        )
      }
    }

    assertFailuresMatchXFails(
      failures,
      expectedFailures: [
        ValidationFailure(node: .canImportVersionInfo, message: "has base kind 'ExprSyntax' but type name doesn’t have 'ExprSyntax' suffix"),
        ValidationFailure(node: .memberTypeIdentifier, message: "has base kind 'TypeSyntax' but type name doesn’t have 'TypeSyntax' suffix"),
        ValidationFailure(node: .poundSourceLocation, message: "has base kind 'DeclSyntax' but type name doesn’t have 'DeclSyntax' suffix"),
        ValidationFailure(node: .simpleTypeIdentifier, message: "has base kind 'TypeSyntax' but type name doesn’t have 'TypeSyntax' suffix"),
      ]
    )
  }

  /// Implementation detail of `testSingleTokenChoiceChildNaming`, validating a single child.
  ///
  /// - Returns: A failure message if validation failed, otherwise `nil`
  private func validateSingleTokenChoiceChild(child: Child, in node: LayoutNode) -> String? {
    guard case .token(choices: let tokenChoices, _, _) = child.kind, let choice = tokenChoices.only else {
      return nil
    }
    switch choice {
    case .keyword(text: let keyword):
      if child.isFollowedByColonToken(in: node) {
        if child.name != "\(keyword.withFirstCharacterUppercased)Label" {
          return
            "child '\(child.name)' has a single keyword as its only token choice and is followed by a colon. It should thus be named '\(keyword.withFirstCharacterUppercased)Label'"
        }
      } else {
        if child.name != "\(keyword.withFirstCharacterUppercased)Keyword" {
          return "child '\(child.name)' has a single keyword as its only token choice and should thus be named '\(keyword.withFirstCharacterUppercased)Keyword'"
        }
      }

    case .token(tokenKind: "IdentifierToken"), .token(tokenKind: "IntegerLiteralToken"), .token(tokenKind: "FloatingLiteralToken"):
      // We allow arbitrary naming of identifiers and literals
      break
    case .token(tokenKind: "CommaToken"):
      if child.name != "TrailingComma" && child.name != "Comma" {
        return "child '\(child.name)' has a comma keyword as its only token choice and should thus be named 'Comma' or 'TrailingComma'"
      }
    case .token(tokenKind: let tokenKind):
      let expectedChildName =
        tokenKind
        .dropSuffix("Token")
        .dropPrefix("Prefix")
        .dropPrefix("Infix")
        .dropPrefix("Postfix")
        .dropPrefix("Binary")
      if child.name != expectedChildName {
        return "child '\(child.name)' has a token as its only token choice and should thus be named '\(expectedChildName)'"
      }
    }
    return nil
  }

  /// Checks standardized naming of children with a single token choice
  ///
  /// - If a child has a single keyword as its choice, it should be named `*Keyword` (e.g. `ImportKeyword`)
  /// - If it’s another token kind, name it the same as the token choice (e.g. `LeftParen`)
  func testSingleTokenChoiceChildNaming() {
    var failures: [ValidationFailure] = []
    for node in SYNTAX_NODES.compactMap(\.layoutNode) {
      for child in node.children {
        if let failureMessage = validateSingleTokenChoiceChild(child: child, in: node) {
          failures.append(ValidationFailure(node: node.kind, message: failureMessage))
        }
      }
    }
    assertFailuresMatchXFails(
      failures,
      expectedFailures: [
        // MARK: Naming of 'AsyncSpecifier' and 'ThrowsSpecifier'
        // Even though these nodes only accept e.g. 'async' name them consistently with properties that accept 'async' and 'reasync'
        ValidationFailure(
          node: .accessorEffectSpecifiers,
          message: "child 'AsyncSpecifier' has a single keyword as its only token choice and should thus be named 'AsyncKeyword'"
            // To be consistent with AsyncSpecifier properties that can be both 'async' and 'reasync'
        ),
        ValidationFailure(
          node: .accessorEffectSpecifiers,
          message: "child 'ThrowsSpecifier' has a single keyword as its only token choice and should thus be named 'ThrowsKeyword'"
            // To be consistent with AsyncSpecifier properties that can be both 'async' and 'reasync'
        ),
        ValidationFailure(
          node: .deinitEffectSpecifiers,
          message: "child 'AsyncSpecifier' has a single keyword as its only token choice and should thus be named 'AsyncKeyword'"
            // To be consistent with AsyncSpecifier properties that can be both 'async' and 'reasync'
        ),
        ValidationFailure(
          node: .typeEffectSpecifiers,
          message: "child 'AsyncSpecifier' has a single keyword as its only token choice and should thus be named 'AsyncKeyword'"
            // To be consistent with AsyncSpecifier properties that can be both 'async' and 'reasync'
        ),
        ValidationFailure(
          node: .typeEffectSpecifiers,
          message: "child 'ThrowsSpecifier' has a single keyword as its only token choice and should thus be named 'ThrowsKeyword'"
            // To be consistent with AsyncSpecifier properties that can be both 'async' and 'reasync'
        ),

        // MARK: Two tokens with same kind in a node
        // If there are two tokens of the same kind in a node, we can't follow the naming rule without conflict
        ValidationFailure(
          node: .differentiableAttributeArguments,
          message: "child 'KindSpecifierComma' has a comma keyword as its only token choice and should thus be named 'Comma' or 'TrailingComma'"
        ),
        ValidationFailure(
          node: .differentiableAttributeArguments,
          message: "child 'ParametersComma' has a comma keyword as its only token choice and should thus be named 'Comma' or 'TrailingComma'"
        ),
        ValidationFailure(
          node: .poundSourceLocationArgs,
          message: "child 'FileColon' has a token as its only token choice and should thus be named 'Colon'"
            // There are two colons in the node
        ),
        ValidationFailure(
          node: .poundSourceLocationArgs,
          message: "child 'LineColon' has a token as its only token choice and should thus be named 'Colon'"
        ),
        ValidationFailure(
          node: .regexLiteralExpr,
          message: "child 'OpeningPounds' has a token as its only token choice and should thus be named 'ExtendedRegexDelimiter'"
        ),
        ValidationFailure(
          node: .regexLiteralExpr,
          message: "child 'OpenSlash' has a token as its only token choice and should thus be named 'RegexSlash'"
        ),
        ValidationFailure(
          node: .regexLiteralExpr,
          message: "child 'CloseSlash' has a token as its only token choice and should thus be named 'RegexSlash'"
            // There are the opening and closing slashes in the node
        ),
        ValidationFailure(
          node: .regexLiteralExpr,
          message: "child 'ClosingPounds' has a token as its only token choice and should thus be named 'ExtendedRegexDelimiter'"
            // There are the opening and closing ExtendedRegexDelimiter in the node
        ),
        // We should explicitly mention token here because it’s not obvious that the end of a file is represented by a token
        ValidationFailure(node: .sourceFile, message: "child 'EndOfFileToken' has a token as its only token choice and should thus be named 'EndOfFile'"),
        ValidationFailure(
          node: .stringLiteralExpr,
          message: "child 'OpenDelimiter' has a token as its only token choice and should thus be named 'RawStringDelimiter'"
        ),
        ValidationFailure(
          node: .stringLiteralExpr,
          message: "child 'CloseDelimiter' has a token as its only token choice and should thus be named 'RawStringDelimiter'"
        ),

        // MARK: Tokens that contain underscores
        ValidationFailure(
          node: .borrowExpr,
          message: "child 'BorrowKeyword' has a single keyword as its only token choice and should thus be named '_borrowKeyword'"
            // _borrow is underscored and thus BorrowKeyword is the correct spelling
        ),
        ValidationFailure(
          node: .conventionWitnessMethodAttributeArguments,
          message:
            "child 'WitnessMethodLabel' has a single keyword as its only token choice and is followed by a colon. It should thus be named 'Witness_methodLabel'"
            // Witness_method has an underscore and thus WitnessMethod is the correct spelling
        ),

        // MARK: Repeat node type name
        // If the node is named the same as the token, we don't need to repeat the entire token name
        ValidationFailure(
          node: .regexLiteralExpr,
          message: "child 'RegexPattern' has a token as its only token choice and should thus be named 'RegexLiteralPattern'"
            // No point repeating the `Literal` because the node name alredy contains it
        ),
        ValidationFailure(
          node: .stringSegment,
          message: "child 'Content' has a token as its only token choice and should thus be named 'StringSegment'"
            // The node is already named `StringSegment`
        ),

        // MARK: Miscellaneous
        // This is the only place where we use LeadingComma, similar to 'TrailingComma'
        ValidationFailure(
          node: .designatedTypeElement,
          message: "child 'LeadingComma' has a comma keyword as its only token choice and should thus be named 'Comma' or 'TrailingComma'"
        ),
        // This is similar to `TrailingComma`
        ValidationFailure(
          node: .importPathComponent,
          message: "child 'TrailingPeriod' has a token as its only token choice and should thus be named 'Period'"
        ),
        // `~` is the only operator that’s allowed here
        ValidationFailure(
          node: .suppressedType,
          message: "child 'WithoutTilde' has a token as its only token choice and should thus be named 'Operator'"
        ),
        // default is not a function argument label here but a proper keyword
        ValidationFailure(
          node: .switchDefaultLabel,
          message: "child 'DefaultKeyword' has a single keyword as its only token choice and is followed by a colon. It should thus be named 'DefaultLabel'"
        ),
      ]
    )
  }

  /// If a token only has keyword token choices, its name should end with `Keyword`.
  func testMultipleKeywordChoicesNaming() {
    var failures: [ValidationFailure] = []
    for node in SYNTAX_NODES.compactMap(\.layoutNode) {
      for child in node.children {
        guard case .token(choices: let tokenChoices, _, _) = child.kind,
          tokenChoices.count > 1,
          tokenChoices.allSatisfy({ $0.isKeyword })
        else {
          // Not a child with only keyword choices
          // Single token choices are handled by `validateSingleTokenChoiceChildNaming`
          continue
        }
        var failureMessage: String?
        if child.isFollowedByColonToken(in: node) {
          if !child.name.hasSuffix("Label") {
            failureMessage = "child '\(child.name)' only has keywords as its token choices, is followed by a colon and should thus end with 'Label'"
          }
        } else {
          if !child.name.hasSuffix("Specifier") {
            failureMessage = "child '\(child.name)' only has keywords as its token choices and should thus end with 'Specifier'"
          }
        }
        if let failureMessage {
          failures.append(ValidationFailure(node: node.kind, message: failureMessage))
        }
      }
    }

    assertFailuresMatchXFails(
      failures,
      expectedFailures: [
        // MARK: Only one non-deprecated keyword
        ValidationFailure(
          node: .discardStmt,
          message: "child 'DiscardKeyword' only has keywords as its token choices and should thus end with 'Specifier'"
            // DiscardKeyword can be 'discard' or '_forget' and '_forget' is deprecated
        ),
        ValidationFailure(
          node: .moveExpr,
          message: "child 'ConsumeKeyword' only has keywords as its token choices and should thus end with 'Specifier'"
            // ConsumeKeyword can be 'consume' or '_move' and '_move' is deprecated
        ),

        // MARK: Conceptually a value, not a specifier
        ValidationFailure(
          node: .booleanLiteralExpr,
          message: "child 'Literal' only has keywords as its token choices and should thus end with 'Specifier'"
            // TrueOrFalseKeyword would be a stupid name here
        ),
        ValidationFailure(
          node: .precedenceGroupAssignment,
          message: "child 'Value' only has keywords as its token choices and should thus end with 'Specifier'"
        ),
        ValidationFailure(
          node: .precedenceGroupAssociativity,
          message: "child 'Value' only has keywords as its token choices and should thus end with 'Specifier'"
        ),

        // MARK: Miscellaneous
        // 'weak' or 'unowned' are already the specifier, this is the detail in parens
        ValidationFailure(
          node: .closureCaptureItemSpecifier,
          message: "child 'Detail' only has keywords as its token choices and should thus end with 'Specifier'"
        ),
        // This really is the modifier name and not a specifier
        ValidationFailure(
          node: .declModifier,
          message: "child 'Name' only has keywords as its token choices and should thus end with 'Specifier'"
        ),
        // Conceptually, this isn't a specifier, it's more like a type inheritance
        ValidationFailure(
          node: .layoutRequirement,
          message: "child 'LayoutConstraint' only has keywords as its token choices and should thus end with 'Specifier'"
        ),
      ]
    )
  }

  /// Check that children that have the same type also have the same child name.
  func testConsistentNamingOfChildren() {
    var failures: [ValidationFailure] = []

    var childrenByNodeKind: [SyntaxNodeKind: [(node: LayoutNode, child: Child)]] = [:]

    for node in SYNTAX_NODES.compactMap(\.layoutNode) {
      for child in node.children {
        guard case .node(kind: let childKind) = child.kind else {
          continue
        }
        childrenByNodeKind[childKind, default: []].append((node, child))
      }
    }

    for (kind, children) in childrenByNodeKind where !kind.isBase && kind != .token && kind != .stringLiteralExpr {
      let childNames = children.map(\.child.name)
      let mostCommonChildName = childNames.mostCommon!
      let mostCommonChild = children.first(where: { $0.child.name == mostCommonChildName })!

      for (node, child) in children {
        if child.name != mostCommonChildName {
          failures.append(
            ValidationFailure(
              node: node.kind,
              message:
                "child '\(child.name)' is named inconsistently with '\(mostCommonChild.node.kind.syntaxType).\(mostCommonChildName)', which has the same type ('\(kind.syntaxType)')"
            )
          )
        }
      }
    }

    assertFailuresMatchXFails(
      failures,
      expectedFailures: [
        // MARK: DeclNameArguments
        // FIXME: IdentifierExprSyntax etc. should probably use DeclName as child instead of Name and Arguments
        ValidationFailure(
          node: .qualifiedDeclName,
          message:
            "child 'Arguments' is named inconsistently with 'IdentifierExprSyntax.DeclNameArguments', which has the same type ('DeclNameArgumentsSyntax')"
        ),
        ValidationFailure(
          node: .declName,
          message:
            "child 'Arguments' is named inconsistently with 'IdentifierExprSyntax.DeclNameArguments', which has the same type ('DeclNameArgumentsSyntax')"
        ),
        // MARK: Alternate names for InitializerClauseSyntax
        // The cases below don’t have intializers but just a syntactic element that happens to be spelled the same
        ValidationFailure(
          node: .enumCaseElement,
          message:
            "child 'RawValue' is named inconsistently with 'MatchingPatternConditionSyntax.Initializer', which has the same type ('InitializerClauseSyntax')"
        ),
        ValidationFailure(
          node: .enumCaseParameter,
          message:
            "child 'DefaultArgument' is named inconsistently with 'MatchingPatternConditionSyntax.Initializer', which has the same type ('InitializerClauseSyntax')"
        ),
        ValidationFailure(
          node: .functionParameter,
          message:
            "child 'DefaultArgument' is named inconsistently with 'MatchingPatternConditionSyntax.Initializer', which has the same type ('InitializerClauseSyntax')"
        ),
        ValidationFailure(
          node: .macroDecl,
          message:
            "child 'Definition' is named inconsistently with 'MatchingPatternConditionSyntax.Initializer', which has the same type ('InitializerClauseSyntax')"
        ),
        // MARK: Miscellaneous
        ValidationFailure(
          node: .multipleTrailingClosureElement,
          message: "child 'Closure' is named inconsistently with 'FunctionCallExprSyntax.TrailingClosure', which has the same type ('ClosureExprSyntax')"
        ),
      ]
    )
  }

  func testAllNodesThatCanConformToATraitDo() {
    var failures: [ValidationFailure] = []

    for node in SYNTAX_NODES.compactMap(\.layoutNode) {
      for trait in TRAITS {
        let canConformToTrait = trait.children.allSatisfy { traitChild in
          node.children.contains { nodeChild in
            traitChild.hasSameType(as: nodeChild)
          }
        }
        if canConformToTrait && !node.traits.contains(trait.traitName) {
          failures.append(
            ValidationFailure(
              node: node.kind,
              message: "could conform to trait '\(trait.traitName)' but does not"
            )
          )
        }
      }
    }

    assertFailuresMatchXFails(
      failures,
      expectedFailures: [
        ValidationFailure(node: .accessesEffect, message: "could conform to trait 'Parenthesized' but does not"),
        ValidationFailure(node: .availabilityCondition, message: "could conform to trait 'Parenthesized' but does not"),
        ValidationFailure(node: .canImportExpr, message: "could conform to trait 'Parenthesized' but does not"),
        ValidationFailure(node: .differentiabilityParams, message: "could conform to trait 'Parenthesized' but does not"),
        ValidationFailure(node: .editorPlaceholderDecl, message: "could conform to trait 'MissingNode' but does not"),
        ValidationFailure(node: .editorPlaceholderExpr, message: "could conform to trait 'IdentifiedDecl' but does not"),
        ValidationFailure(node: .enumCaseElement, message: "could conform to trait 'IdentifiedDecl' but does not"),
        ValidationFailure(node: .initializesEffect, message: "could conform to trait 'Parenthesized' but does not"),
        ValidationFailure(node: .precedenceGroupDecl, message: "could conform to trait 'Braced' but does not"),
        ValidationFailure(node: .yieldList, message: "could conform to trait 'Parenthesized' but does not"),
      ]
    )
  }
}
