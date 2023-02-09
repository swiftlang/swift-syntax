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

import SwiftParser
import SwiftParserDiagnostics
import SwiftSyntax
import SwiftBasicFormat
import Darwin

// MARK: - Testing an input

@_cdecl("LLVMFuzzerTestOneInput")
public func LLVMFuzzerTestOneInput(_ data: UnsafePointer<UInt8>, size: Int) -> CInt {
  let source = UnsafeBufferPointer(start: data, count: size)
  let tree = Parser.parse(source: source)

  var diags = ParseDiagnosticsGenerator.diagnostics(for: tree)

  if tree.syntaxTextBytes != [UInt8](source) {
    assertionFailure("Source file did not round-trip")
  }
  return 0
}

// MARK: - Mutating the input

enum RandomTokenGenerator {
  static let allTokenKinds: [TokenKind] =
    [
      .wildcard,
      .leftParen,
      .rightParen,
      .leftBrace,
      .rightBrace,
      .leftSquareBracket,
      .rightSquareBracket,
      .leftAngle,
      .rightAngle,
      .period,
      .comma,
      .ellipsis,
      .colon,
      .semicolon,
      .equal,
      .atSign,
      .pound,
      .prefixAmpersand,
      .arrow,
      .backtick,
      .backslash,
      .exclamationMark,
      .postfixQuestionMark,
      .infixQuestionMark,
      .stringQuote,
      .singleQuote,
      .multilineStringQuote,
      .poundSourceLocationKeyword,
      .poundIfKeyword,
      .poundElseKeyword,
      .poundElseifKeyword,
      .poundEndifKeyword,
      .poundAvailableKeyword,
      .poundUnavailableKeyword,
      .integerLiteral("1"),
      .floatingLiteral("1.0"),
      .regexLiteral("/.*/"),
      .identifier("myIdent"),
      .binaryOperator("+"),
      .postfixOperator("++"),
      .prefixOperator("!"),
      .dollarIdentifier("$0"),
      .rawStringDelimiter("#"),
      .stringSegment("abc"),
    ] + Keyword.allCases.map(TokenKind.keyword)

  static func createRandomToken() -> TokenSyntax {
    let tokenKind = allTokenKinds[Int(drand48() * Double(allTokenKinds.count) - 1)]
    return TokenSyntax(tokenKind, presence: .present).formatted().cast(TokenSyntax.self)
  }
}

enum Mutation {
  case replace(old: Syntax, new: Syntax)
  case insert(before: Syntax, insert: Syntax)
  case remove(node: Syntax)
}

/// Generates a list of mutations to apply to the tree.
/// At the moment it just replaces, inserts and deletes tokens with probability 1% each.
/// Improving this would be the next starting point to improvew the fuzzer.
class MutationGenerator: SyntaxVisitor {
  static func getMutations(for tree: Syntax) -> [Mutation] {
    let generator = MutationGenerator(viewMode: .sourceAccurate)
    generator.walk(tree)
    return generator.mutations
  }

  private var mutations: [Mutation] = []

  override func visit(_ node: TokenSyntax) -> SyntaxVisitorContinueKind {
    switch drand48() {
    case 0..<0.01:
      mutations.append(.replace(old: Syntax(node), new: Syntax(RandomTokenGenerator.createRandomToken())))
    case 0..<0.02:
      mutations.append(.insert(before: Syntax(node), insert: Syntax(RandomTokenGenerator.createRandomToken())))
    case 0..<0.03:
      mutations.append(.remove(node: Syntax(node)))
    default:
      break
    }
    return .visitChildren
  }
}

class MutatedTreePrinter: SyntaxAnyVisitor {
  /// Prints `tree` as bytes, applying `mutations`.
  static func print(tree: Syntax, mutations: [Mutation]) -> [UInt8] {
    let printer = MutatedTreePrinter(mutations: mutations)
    printer.walk(tree)
    return printer.printedSource
  }

  private let mutations: [Mutation]
  private var printedSource: [UInt8] = []

  private init(mutations: [Mutation]) {
    self.mutations = mutations
    super.init(viewMode: .sourceAccurate)
  }

  override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    for mutation in mutations {
      switch mutation {
      case .replace(let old, let new) where old == node:
        printedSource.append(contentsOf: new.syntaxTextBytes)
        return .skipChildren
      case .insert(let before, let insert) where before == node:
        printedSource.append(contentsOf: insert.syntaxTextBytes)
        return .visitChildren
      case .remove(let toRemove) where toRemove == node:
        return .skipChildren
      default:
        break
      }
    }
    return .visitChildren
  }

  override func visit(_ node: TokenSyntax) -> SyntaxVisitorContinueKind {
    if visitAny(Syntax(node)) == .skipChildren {
      return .skipChildren
    }
    printedSource.append(contentsOf: node.syntaxTextBytes)
    return .skipChildren
  }
}

@_cdecl("LLVMFuzzerCustomMutator")
public func LLVMFuzzerCustomMutator(_ data: UnsafeMutablePointer<UInt8>, size: Int, maxSize: Int, seed: UInt32) -> Int {
  srand48(Int(seed))
  let source = UnsafeBufferPointer(start: data, count: size)
  let tree = Parser.parse(source: source)

  let mutationGenerator = MutationGenerator(viewMode: .sourceAccurate)
  mutationGenerator.walk(tree)

  let mutations = MutationGenerator.getMutations(for: Syntax(tree))
  var mutatedSource = MutatedTreePrinter.print(tree: Syntax(tree), mutations: mutations)

  if mutatedSource.count > maxSize {
    mutatedSource = Array(mutatedSource.prefix(maxSize))
  }

  data.update(from: &mutatedSource, count: mutatedSource.count)
  return mutatedSource.count
}
