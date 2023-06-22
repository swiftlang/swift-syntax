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

  /// Checks standardized naming of children with a single token choice
  ///
  /// - If a child has a single keyword as its choice, it should be named `*Keyword` (e.g. `ImportKeyword`)
  /// - If it’s another token kind, name it the same as the the token choice (e.g. `LeftParen`)
  func testSingleTokenChoiceChildNaming() {
    var failures: [ValidationFailure] = []
    for node in SYNTAX_NODES.compactMap(\.layoutNode) {
      for child in node.children {
        if case .token(choices: let tokenChoices, _, _) = child.kind,
          let choice = tokenChoices.only
        {
          switch choice {
          case .keyword(text: let keyword):
            if child.name != "\(keyword.withFirstCharacterUppercased)Keyword" {
              failures.append(
                ValidationFailure(
                  node: node.kind,
                  message:
                    "child '\(child.name)' has a single keyword as its only token choice and should thus be named '\(keyword.withFirstCharacterUppercased)Keyword'"
                )
              )
            }
          case .token(tokenKind: let tokenKind):
            switch tokenKind {
            case "IdentifierToken":
              // We allow arbitrary naming of identifiers
              break
            case "CommaToken":
              if child.name != "TrailingComma" && child.name != "Comma" {
                failures.append(
                  ValidationFailure(
                    node: node.kind,
                    message: "child '\(child.name)' has a comma keyword as its only token choice and should thus be named 'Comma' or 'TrailingComma'"
                  )
                )
              }
            default:
              if child.name != tokenKind.dropSuffix("Token") {
                failures.append(
                  ValidationFailure(
                    node: node.kind,
                    message: "child '\(child.name)' has a token as its only token choice and should thus be named '\(tokenKind.dropSuffix("Token"))'"
                  )
                )
              }
            }
          }
        }
      }
    }
    assertFailuresMatchXFails(
      failures,
      expectedFailures: [
        // MARK: Naming failures of children with a single keyword choice
        ValidationFailure(
          node: .accessorEffectSpecifiers,
          message: "child 'AsyncSpecifier' has a single keyword as its only token choice and should thus be named 'AsyncKeyword'"
        ),
        ValidationFailure(
          node: .accessorEffectSpecifiers,
          message: "child 'ThrowsSpecifier' has a single keyword as its only token choice and should thus be named 'ThrowsKeyword'"
        ),
        ValidationFailure(node: .asExpr, message: "child 'AsTok' has a single keyword as its only token choice and should thus be named 'AsKeyword'"),
        ValidationFailure(
          node: .availabilityEntry,
          message: "child 'Label' has a single keyword as its only token choice and should thus be named 'AvailabilityKeyword'"
        ),
        ValidationFailure(
          node: .backDeployedAttributeSpecList,
          message: "child 'BeforeLabel' has a single keyword as its only token choice and should thus be named 'BeforeKeyword'"
        ),
        ValidationFailure(
          node: .borrowExpr,
          message: "child 'BorrowKeyword' has a single keyword as its only token choice and should thus be named '_borrowKeyword'"
        ),
        ValidationFailure(node: .closureSignature, message: "child 'InTok' has a single keyword as its only token choice and should thus be named 'InKeyword'"),
        ValidationFailure(
          node: .conventionAttributeArguments,
          message: "child 'CTypeLabel' has a single keyword as its only token choice and should thus be named 'CTypeKeyword'"
        ),
        ValidationFailure(
          node: .conventionWitnessMethodAttributeArguments,
          message: "child 'WitnessMethodLabel' has a single keyword as its only token choice and should thus be named 'Witness_methodKeyword'"
        ),
        ValidationFailure(
          node: .derivativeRegistrationAttributeArguments,
          message: "child 'OfLabel' has a single keyword as its only token choice and should thus be named 'OfKeyword'"
        ),
        ValidationFailure(
          node: .differentiabilityParamsClause,
          message: "child 'WrtLabel' has a single keyword as its only token choice and should thus be named 'WrtKeyword'"
        ),
        ValidationFailure(
          node: .dynamicReplacementArguments,
          message: "child 'ForLabel' has a single keyword as its only token choice and should thus be named 'ForKeyword'"
        ),
        ValidationFailure(
          node: .genericParameter,
          message: "child 'Each' has a single keyword as its only token choice and should thus be named 'EachKeyword'"
        ),
        ValidationFailure(
          node: .importDecl,
          message: "child 'ImportTok' has a single keyword as its only token choice and should thus be named 'ImportKeyword'"
        ),
        ValidationFailure(node: .isExpr, message: "child 'IsTok' has a single keyword as its only token choice and should thus be named 'IsKeyword'"),
        ValidationFailure(
          node: .originallyDefinedInArguments,
          message: "child 'ModuleLabel' has a single keyword as its only token choice and should thus be named 'ModuleKeyword'"
        ),
        ValidationFailure(
          node: .poundSourceLocationArgs,
          message: "child 'FileArgLabel' has a single keyword as its only token choice and should thus be named 'FileKeyword'"
        ),
        ValidationFailure(
          node: .poundSourceLocationArgs,
          message: "child 'LineArgLabel' has a single keyword as its only token choice and should thus be named 'LineKeyword'"
        ),
        ValidationFailure(
          node: .targetFunctionEntry,
          message: "child 'Label' has a single keyword as its only token choice and should thus be named 'TargetKeyword'"
        ),
        ValidationFailure(
          node: .tupleTypeElement,
          message: "child 'InOut' has a single keyword as its only token choice and should thus be named 'InoutKeyword'"
        ),
        ValidationFailure(
          node: .typeEffectSpecifiers,
          message: "child 'AsyncSpecifier' has a single keyword as its only token choice and should thus be named 'AsyncKeyword'"
        ),
        ValidationFailure(
          node: .typeEffectSpecifiers,
          message: "child 'ThrowsSpecifier' has a single keyword as its only token choice and should thus be named 'ThrowsKeyword'"
        ),
        ValidationFailure(
          node: .unavailableFromAsyncArguments,
          message: "child 'MessageLabel' has a single keyword as its only token choice and should thus be named 'MessageKeyword'"
        ),
        ValidationFailure(
          node: .underscorePrivateAttributeArguments,
          message: "child 'SourceFileLabel' has a single keyword as its only token choice and should thus be named 'SourceFileKeyword'"
        ),
        ValidationFailure(node: .unresolvedAsExpr, message: "child 'AsTok' has a single keyword as its only token choice and should thus be named 'AsKeyword'"),
        ValidationFailure(node: .unresolvedIsExpr, message: "child 'IsTok' has a single keyword as its only token choice and should thus be named 'IsKeyword'"),

        // MARK:
        ValidationFailure(node: .arrayExpr, message: "child 'LeftSquare' has a token as its only token choice and should thus be named 'LeftSquareBracket'"),
        ValidationFailure(node: .arrayExpr, message: "child 'RightSquare' has a token as its only token choice and should thus be named 'RightSquareBracket'"),
        ValidationFailure(node: .arrowExpr, message: "child 'ArrowToken' has a token as its only token choice and should thus be named 'Arrow'"),
        ValidationFailure(node: .assignmentExpr, message: "child 'AssignToken' has a token as its only token choice and should thus be named 'Equal'"),
        ValidationFailure(node: .attribute, message: "child 'AtSignToken' has a token as its only token choice and should thus be named 'AtSign'"),

        // MARK: Naming failures of children with a single token choice
        ValidationFailure(
          node: .binaryOperatorExpr,
          message: "child 'OperatorToken' has a token as its only token choice and should thus be named 'BinaryOperator'"
        ),
        ValidationFailure(node: .closureCaptureItem, message: "child 'AssignToken' has a token as its only token choice and should thus be named 'Equal'"),
        ValidationFailure(
          node: .closureCaptureSignature,
          message: "child 'LeftSquare' has a token as its only token choice and should thus be named 'LeftSquareBracket'"
        ),
        ValidationFailure(
          node: .closureCaptureSignature,
          message: "child 'RightSquare' has a token as its only token choice and should thus be named 'RightSquareBracket'"
        ),
        ValidationFailure(
          node: .designatedTypeElement,
          message: "child 'LeadingComma' has a comma keyword as its only token choice and should thus be named 'Comma' or 'TrailingComma'"
        ),
        ValidationFailure(
          node: .dictionaryExpr,
          message: "child 'LeftSquare' has a token as its only token choice and should thus be named 'LeftSquareBracket'"
        ),
        ValidationFailure(
          node: .dictionaryExpr,
          message: "child 'RightSquare' has a token as its only token choice and should thus be named 'RightSquareBracket'"
        ),
        ValidationFailure(
          node: .differentiableAttributeArguments,
          message: "child 'DiffKindComma' has a comma keyword as its only token choice and should thus be named 'Comma' or 'TrailingComma'"
        ),
        ValidationFailure(
          node: .differentiableAttributeArguments,
          message: "child 'DiffParamsComma' has a comma keyword as its only token choice and should thus be named 'Comma' or 'TrailingComma'"
        ),
        ValidationFailure(
          node: .expressionSegment,
          message: "child 'Delimiter' has a token as its only token choice and should thus be named 'RawStringDelimiter'"
        ),
        ValidationFailure(
          node: .floatLiteralExpr,
          message: "child 'FloatingDigits' has a token as its only token choice and should thus be named 'FloatingLiteral'"
        ),
        ValidationFailure(
          node: .genericArgumentClause,
          message: "child 'LeftAngleBracket' has a token as its only token choice and should thus be named 'LeftAngle'"
        ),
        ValidationFailure(
          node: .genericArgumentClause,
          message: "child 'RightAngleBracket' has a token as its only token choice and should thus be named 'RightAngle'"
        ),
        ValidationFailure(
          node: .genericParameterClause,
          message: "child 'LeftAngleBracket' has a token as its only token choice and should thus be named 'LeftAngle'"
        ),
        ValidationFailure(
          node: .genericParameterClause,
          message: "child 'RightAngleBracket' has a token as its only token choice and should thus be named 'RightAngle'"
        ),
        ValidationFailure(node: .importPathComponent, message: "child 'TrailingDot' has a token as its only token choice and should thus be named 'Period'"),
        ValidationFailure(node: .inOutExpr, message: "child 'Ampersand' has a token as its only token choice and should thus be named 'PrefixAmpersand'"),
        ValidationFailure(node: .integerLiteralExpr, message: "child 'Digits' has a token as its only token choice and should thus be named 'IntegerLiteral'"),
        ValidationFailure(
          node: .keyPathSubscriptComponent,
          message: "child 'LeftBracket' has a token as its only token choice and should thus be named 'LeftSquareBracket'"
        ),
        ValidationFailure(
          node: .keyPathSubscriptComponent,
          message: "child 'RightBracket' has a token as its only token choice and should thus be named 'RightSquareBracket'"
        ),
        ValidationFailure(node: .labeledStmt, message: "child 'LabelColon' has a token as its only token choice and should thus be named 'Colon'"),
        ValidationFailure(node: .layoutRequirement, message: "child 'Size' has a token as its only token choice and should thus be named 'IntegerLiteral'"),
        ValidationFailure(
          node: .layoutRequirement,
          message: "child 'Alignment' has a token as its only token choice and should thus be named 'IntegerLiteral'"
        ),
        ValidationFailure(node: .macroExpansionDecl, message: "child 'PoundToken' has a token as its only token choice and should thus be named 'Pound'"),
        ValidationFailure(node: .macroExpansionExpr, message: "child 'PoundToken' has a token as its only token choice and should thus be named 'Pound'"),
        ValidationFailure(node: .memberAccessExpr, message: "child 'Dot' has a token as its only token choice and should thus be named 'Period'"),
        ValidationFailure(
          node: .opaqueReturnTypeOfAttributeArguments,
          message: "child 'Ordinal' has a token as its only token choice and should thus be named 'IntegerLiteral'"
        ),
        ValidationFailure(
          node: .optionalChainingExpr,
          message: "child 'QuestionMark' has a token as its only token choice and should thus be named 'PostfixQuestionMark'"
        ),
        ValidationFailure(
          node: .optionalType,
          message: "child 'QuestionMark' has a token as its only token choice and should thus be named 'PostfixQuestionMark'"
        ),
        ValidationFailure(
          node: .postfixUnaryExpr,
          message: "child 'OperatorToken' has a token as its only token choice and should thus be named 'PostfixOperator'"
        ),
        ValidationFailure(
          node: .poundSourceLocationArgs,
          message: "child 'FileArgColon' has a token as its only token choice and should thus be named 'Colon'"
        ),
        ValidationFailure(
          node: .poundSourceLocationArgs,
          message: "child 'LineArgColon' has a token as its only token choice and should thus be named 'Colon'"
        ),
        ValidationFailure(
          node: .poundSourceLocationArgs,
          message: "child 'LineNumber' has a token as its only token choice and should thus be named 'IntegerLiteral'"
        ),
        ValidationFailure(
          node: .prefixOperatorExpr,
          message: "child 'OperatorToken' has a token as its only token choice and should thus be named 'PrefixOperator'"
        ),
        ValidationFailure(
          node: .primaryAssociatedTypeClause,
          message: "child 'LeftAngleBracket' has a token as its only token choice and should thus be named 'LeftAngle'"
        ),
        ValidationFailure(
          node: .primaryAssociatedTypeClause,
          message: "child 'RightAngleBracket' has a token as its only token choice and should thus be named 'RightAngle'"
        ),
        ValidationFailure(node: .qualifiedDeclName, message: "child 'Dot' has a token as its only token choice and should thus be named 'Period'"),
        ValidationFailure(
          node: .regexLiteralExpr,
          message: "child 'OpeningPounds' has a token as its only token choice and should thus be named 'ExtendedRegexDelimiter'"
        ),
        ValidationFailure(node: .regexLiteralExpr, message: "child 'OpenSlash' has a token as its only token choice and should thus be named 'RegexSlash'"),
        ValidationFailure(
          node: .regexLiteralExpr,
          message: "child 'RegexPattern' has a token as its only token choice and should thus be named 'RegexLiteralPattern'"
        ),
        ValidationFailure(node: .regexLiteralExpr, message: "child 'CloseSlash' has a token as its only token choice and should thus be named 'RegexSlash'"),
        ValidationFailure(
          node: .regexLiteralExpr,
          message: "child 'ClosingPounds' has a token as its only token choice and should thus be named 'ExtendedRegexDelimiter'"
        ),
        ValidationFailure(node: .sourceFile, message: "child 'EOFToken' has a token as its only token choice and should thus be named 'EOF'"),
        ValidationFailure(
          node: .stringLiteralExpr,
          message: "child 'OpenDelimiter' has a token as its only token choice and should thus be named 'RawStringDelimiter'"
        ),
        ValidationFailure(
          node: .stringLiteralExpr,
          message: "child 'CloseDelimiter' has a token as its only token choice and should thus be named 'RawStringDelimiter'"
        ),
        ValidationFailure(node: .stringSegment, message: "child 'Content' has a token as its only token choice and should thus be named 'StringSegment'"),
        ValidationFailure(
          node: .subscriptExpr,
          message: "child 'LeftBracket' has a token as its only token choice and should thus be named 'LeftSquareBracket'"
        ),
        ValidationFailure(
          node: .subscriptExpr,
          message: "child 'RightBracket' has a token as its only token choice and should thus be named 'RightSquareBracket'"
        ),
        ValidationFailure(
          node: .suppressedType,
          message: "child 'WithoutTilde' has a token as its only token choice and should thus be named 'PrefixOperator'"
        ),
        ValidationFailure(
          node: .ternaryExpr,
          message: "child 'QuestionMark' has a token as its only token choice and should thus be named 'InfixQuestionMark'"
        ),
        ValidationFailure(node: .ternaryExpr, message: "child 'ColonMark' has a token as its only token choice and should thus be named 'Colon'"),
        ValidationFailure(node: .tuplePatternElement, message: "child 'LabelColon' has a token as its only token choice and should thus be named 'Colon'"),
        ValidationFailure(
          node: .unresolvedTernaryExpr,
          message: "child 'QuestionMark' has a token as its only token choice and should thus be named 'InfixQuestionMark'"
        ),
        ValidationFailure(node: .unresolvedTernaryExpr, message: "child 'ColonMark' has a token as its only token choice and should thus be named 'Colon'"),
        ValidationFailure(node: .versionComponent, message: "child 'Number' has a token as its only token choice and should thus be named 'IntegerLiteral'"),
        ValidationFailure(node: .versionTuple, message: "child 'Major' has a token as its only token choice and should thus be named 'IntegerLiteral'"),
      ]
    )
  }

  /// If a token only has keyword token choices, its name should end with `Keyword`.
  func testMultipleKeywordChoicesNaming() {
    var failures: [ValidationFailure] = []
    for node in SYNTAX_NODES.compactMap(\.layoutNode) {
      for child in node.children {
        if case .token(choices: let tokenChoices, _, _) = child.kind,
          tokenChoices.count > 1,  // single token choices are handled by `validateSingleTokenChoiceChildNaming`
          tokenChoices.allSatisfy({ $0.isKeyword }),
          !child.name.hasSuffix("Keyword")
        {
          failures.append(
            ValidationFailure(
              node: node.kind,
              message: "child '\(child.name)' only has keywords as its token choices and should thus and with 'Keyword'"
            )
          )
        }
      }
    }

    assertFailuresMatchXFails(
      failures,
      expectedFailures: [
        ValidationFailure(node: .accessorDecl, message: "child 'AccessorKind' only has keywords as its token choices and should thus and with 'Keyword'"),
        ValidationFailure(node: .attributedType, message: "child 'Specifier' only has keywords as its token choices and should thus and with 'Keyword'"),
        ValidationFailure(
          node: .availabilityLabeledArgument,
          message: "child 'Label' only has keywords as its token choices and should thus and with 'Keyword'"
        ),
        ValidationFailure(
          node: .booleanLiteralExpr,
          message: "child 'BooleanLiteral' only has keywords as its token choices and should thus and with 'Keyword'"
        ),
        ValidationFailure(node: .canImportVersionInfo, message: "child 'Label' only has keywords as its token choices and should thus and with 'Keyword'"),
        ValidationFailure(
          node: .closureCaptureItemSpecifier,
          message: "child 'Specifier' only has keywords as its token choices and should thus and with 'Keyword'"
        ),
        ValidationFailure(
          node: .closureCaptureItemSpecifier,
          message: "child 'Detail' only has keywords as its token choices and should thus and with 'Keyword'"
        ),
        ValidationFailure(
          node: .constrainedSugarType,
          message: "child 'SomeOrAnySpecifier' only has keywords as its token choices and should thus and with 'Keyword'"
        ),
        ValidationFailure(node: .declModifier, message: "child 'Name' only has keywords as its token choices and should thus and with 'Keyword'"),
        ValidationFailure(
          node: .derivativeRegistrationAttributeArguments,
          message: "child 'AccessorKind' only has keywords as its token choices and should thus and with 'Keyword'"
        ),
        ValidationFailure(
          node: .differentiableAttributeArguments,
          message: "child 'DiffKind' only has keywords as its token choices and should thus and with 'Keyword'"
        ),
        ValidationFailure(
          node: .documentationAttributeArgument,
          message: "child 'Label' only has keywords as its token choices and should thus and with 'Keyword'"
        ),
        ValidationFailure(
          node: .functionEffectSpecifiers,
          message: "child 'AsyncSpecifier' only has keywords as its token choices and should thus and with 'Keyword'"
        ),
        ValidationFailure(
          node: .functionEffectSpecifiers,
          message: "child 'ThrowsSpecifier' only has keywords as its token choices and should thus and with 'Keyword'"
        ),
        ValidationFailure(node: .importDecl, message: "child 'ImportKind' only has keywords as its token choices and should thus and with 'Keyword'"),
        ValidationFailure(
          node: .layoutRequirement,
          message: "child 'LayoutConstraint' only has keywords as its token choices and should thus and with 'Keyword'"
        ),
        ValidationFailure(node: .metatypeType, message: "child 'TypeOrProtocol' only has keywords as its token choices and should thus and with 'Keyword'"),
        ValidationFailure(node: .operatorDecl, message: "child 'Fixity' only has keywords as its token choices and should thus and with 'Keyword'"),
        ValidationFailure(node: .precedenceGroupAssignment, message: "child 'Flag' only has keywords as its token choices and should thus and with 'Keyword'"),
        ValidationFailure(
          node: .precedenceGroupAssociativity,
          message: "child 'Value' only has keywords as its token choices and should thus and with 'Keyword'"
        ),
        ValidationFailure(
          node: .precedenceGroupRelation,
          message: "child 'HigherThanOrLowerThan' only has keywords as its token choices and should thus and with 'Keyword'"
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

    for (kind, children) in childrenByNodeKind where !kind.isBase && kind != .token {
      let childNames = children.map(\.child.name)
      let firstChildName = childNames.first!

      for (node, child) in children.dropFirst() {
        if child.name != firstChildName {
          failures.append(
            ValidationFailure(
              node: node.kind,
              message:
                "child '\(child.name)' is named inconsistently with '\(children.first!.node.kind.syntaxType).\(children.first!.child.name)', which has the same type ('\(kind.syntaxType)')"
            )
          )
        }
      }
    }

    assertFailuresMatchXFails(
      failures,
      expectedFailures: [
        ValidationFailure(
          node: .differentiableAttributeArguments,
          message: "child 'WhereClause' is named inconsistently with 'ActorDeclSyntax.GenericWhereClause', which has the same type ('GenericWhereClauseSyntax')"
        ),
        ValidationFailure(
          node: .subscriptDecl,
          message: "child 'Indices' is named inconsistently with 'FunctionSignatureSyntax.Input', which has the same type ('ParameterClauseSyntax')"
        ),
        ValidationFailure(
          node: .qualifiedDeclName,
          message: "child 'Arguments' is named inconsistently with 'DeclNameSyntax.DeclNameArguments', which has the same type ('DeclNameArgumentsSyntax')"
        ),
        ValidationFailure(
          node: .macroExpansionDecl,
          message:
            "child 'GenericArguments' is named inconsistently with 'KeyPathPropertyComponentSyntax.GenericArgumentClause', which has the same type ('GenericArgumentClauseSyntax')"
        ),
        ValidationFailure(
          node: .macroExpansionExpr,
          message:
            "child 'GenericArguments' is named inconsistently with 'KeyPathPropertyComponentSyntax.GenericArgumentClause', which has the same type ('GenericArgumentClauseSyntax')"
        ),
        ValidationFailure(
          node: .enumCaseParameter,
          message: "child 'DefaultArgument' is named inconsistently with 'EnumCaseElementSyntax.RawValue', which has the same type ('InitializerClauseSyntax')"
        ),
        ValidationFailure(
          node: .functionParameter,
          message: "child 'DefaultArgument' is named inconsistently with 'EnumCaseElementSyntax.RawValue', which has the same type ('InitializerClauseSyntax')"
        ),
        ValidationFailure(
          node: .macroDecl,
          message: "child 'Definition' is named inconsistently with 'EnumCaseElementSyntax.RawValue', which has the same type ('InitializerClauseSyntax')"
        ),
        ValidationFailure(
          node: .matchingPatternCondition,
          message: "child 'Initializer' is named inconsistently with 'EnumCaseElementSyntax.RawValue', which has the same type ('InitializerClauseSyntax')"
        ),
        ValidationFailure(
          node: .optionalBindingCondition,
          message: "child 'Initializer' is named inconsistently with 'EnumCaseElementSyntax.RawValue', which has the same type ('InitializerClauseSyntax')"
        ),
        ValidationFailure(
          node: .patternBinding,
          message: "child 'Initializer' is named inconsistently with 'EnumCaseElementSyntax.RawValue', which has the same type ('InitializerClauseSyntax')"
        ),
        ValidationFailure(
          node: .tupleTypeElement,
          message: "child 'Initializer' is named inconsistently with 'EnumCaseElementSyntax.RawValue', which has the same type ('InitializerClauseSyntax')"
        ),
        ValidationFailure(
          node: .multipleTrailingClosureElement,
          message: "child 'Closure' is named inconsistently with 'FunctionCallExprSyntax.TrailingClosure', which has the same type ('ClosureExprSyntax')"
        ),
        ValidationFailure(
          node: .subscriptDecl,
          message: "child 'Result' is named inconsistently with 'ClosureSignatureSyntax.Output', which has the same type ('ReturnClauseSyntax')"
        ),
        ValidationFailure(
          node: .canImportVersionInfo,
          message:
            "child 'VersionTuple' is named inconsistently with 'AvailabilityVersionRestrictionSyntax.Version', which has the same type ('VersionTupleSyntax')"
        ),
        ValidationFailure(
          node: .exposeAttributeArguments,
          message:
            "child 'CxxName' is named inconsistently with 'ConventionAttributeArgumentsSyntax.CTypeString', which has the same type ('StringLiteralExprSyntax')"
        ),
        ValidationFailure(
          node: .opaqueReturnTypeOfAttributeArguments,
          message:
            "child 'MangledName' is named inconsistently with 'ConventionAttributeArgumentsSyntax.CTypeString', which has the same type ('StringLiteralExprSyntax')"
        ),
        ValidationFailure(
          node: .originallyDefinedInArguments,
          message:
            "child 'ModuleName' is named inconsistently with 'ConventionAttributeArgumentsSyntax.CTypeString', which has the same type ('StringLiteralExprSyntax')"
        ),
        ValidationFailure(
          node: .poundSourceLocationArgs,
          message:
            "child 'FileName' is named inconsistently with 'ConventionAttributeArgumentsSyntax.CTypeString', which has the same type ('StringLiteralExprSyntax')"
        ),
        ValidationFailure(
          node: .unavailableFromAsyncArguments,
          message:
            "child 'Message' is named inconsistently with 'ConventionAttributeArgumentsSyntax.CTypeString', which has the same type ('StringLiteralExprSyntax')"
        ),
        ValidationFailure(
          node: .underscorePrivateAttributeArguments,
          message:
            "child 'Filename' is named inconsistently with 'ConventionAttributeArgumentsSyntax.CTypeString', which has the same type ('StringLiteralExprSyntax')"
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
        ValidationFailure(node: .editorPlaceholderExpr, message: "could conform to trait 'IdentifiedDecl' but does not"),
        ValidationFailure(node: .enumCaseElement, message: "could conform to trait 'IdentifiedDecl' but does not"),
        ValidationFailure(node: .initializesEffect, message: "could conform to trait 'Parenthesized' but does not"),
        ValidationFailure(node: .precedenceGroupDecl, message: "could conform to trait 'Braced' but does not"),
        ValidationFailure(node: .yieldList, message: "could conform to trait 'Parenthesized' but does not"),
      ]
    )
  }
}
