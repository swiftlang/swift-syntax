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

@_spi(RawSyntax) import SwiftParser
import SwiftParserDiagnostics
@_spi(RawSyntax) import SwiftSyntax
import SwiftBasicFormat
import Darwin

public struct SeededRandomNumberGenerators: RandomNumberGenerator {
  public mutating func seed(_ seed: Int) { srand48(seed) }

  public mutating func next() -> UInt64 {
    return UInt64(self.nextDouble() * Double(UInt64.max))
  }

  public mutating func nextDouble() -> Double {
    return drand48()
  }

  public mutating func next(in range: Range<Int>) -> Int {
    return Int(Double(range.count) * nextDouble()) + range.lowerBound
  }

  public static var shared = SeededRandomNumberGenerators()

  private init() {}
}

// MARK: - Testing an input

@_cdecl("LLVMFuzzerTestOneInput")
public func LLVMFuzzerTestOneInput(_ data: UnsafePointer<UInt8>, size: Int) -> CInt {
  let source = UnsafeBufferPointer(start: data, count: size)
  let tree = Parser.parse(source: source)

  _ = ParseDiagnosticsGenerator.diagnostics(for: tree)

  if tree.syntaxTextBytes != [UInt8](source) {
    assertionFailure("Source file did not round-trip")
  }
  return 0
}

// MARK: - Mutating the input

extension RawTokenKind {
  var synthesizedText: TokenKind {
    switch self {
    case .integerLiteral: return .integerLiteral("1")
    case .floatingLiteral: return .floatingLiteral("1.0")
    case .regexLiteral: return .regexLiteral("/.*/")
    case .identifier: return .identifier("myIdent")
    case .binaryOperator: return .binaryOperator("+")
    case .postfixOperator: return .postfixOperator("++")
    case .prefixOperator: return .prefixOperator("!")
    case .dollarIdentifier: return .dollarIdentifier("$0")
    case .rawStringDelimiter: return .rawStringDelimiter("#")
    case .stringSegment: return .stringSegment("abc")
    default: return TokenKind.fromRaw(kind: self, text: "")
    }
  }
}

class MutatedTreePrinter: SyntaxVisitor {
  /// Prints `tree` as bytes, applying `mutations`.
  /// Mutations map the `SyntaxText` of tokens that should be replaced to their
  /// replacement kind.
  ///
  /// Tokens that should be replaced are identified by the base address of their
  /// SyntaxText.
  static func print(tree: Syntax, modifications: [SyntaxText: RawTokenKind]) -> [UInt8] {
    let printer = MutatedTreePrinter(modifications: modifications)
    printer.walk(tree)
    return printer.printedSource
  }

  private var modifications: [UnsafePointer<UInt8>: RawTokenKind] = [:]
  private var printedSource: [UInt8] = []

  private init(modifications: [SyntaxText: RawTokenKind]) {
    for (key, value) in modifications {
      self.modifications[key.baseAddress!] = value
    }
    super.init(viewMode: .sourceAccurate)
  }

  override func visit(_ node: TokenSyntax) -> SyntaxVisitorContinueKind {
    if let replacement = modifications[node.tokenView.rawText.baseAddress!] {
      switch SeededRandomNumberGenerators.shared.nextDouble() {
      case 0..<0.5:
        // Replace the token
        let newToken = TokenSyntax(replacement.synthesizedText, presence: .present).formatted()
        printedSource.append(contentsOf: newToken.syntaxTextBytes)
        return .skipChildren
      case 0..<0.75:
        // Insert the replacement token, keeping the current token
        let newToken = TokenSyntax(replacement.synthesizedText, presence: .present).formatted()
        printedSource.append(contentsOf: newToken.syntaxTextBytes)
      default:
        // Delete the token
        return .skipChildren
      }

    }
    printedSource.append(contentsOf: node.syntaxTextBytes)
    return .skipChildren
  }
}

@_cdecl("LLVMFuzzerCustomMutator")
public func LLVMFuzzerCustomMutator(_ data: UnsafeMutablePointer<UInt8>, size: Int, maxSize: Int, seed: UInt32) -> Int {
  SeededRandomNumberGenerators.shared.seed(Int(seed))
  let source = UnsafeBufferPointer(start: data, count: size)
  var parser = Parser(source)
  let tree = SourceFileSyntax.parse(from: &parser)
  let tokensInTree = Array(tree.tokens(viewMode: .sourceAccurate)).count
  let percentageOfTokensToReplace = 0.01
  let tokensToModify = min(Int(Double(tokensInTree) * percentageOfTokensToReplace), 1)

  var modifications: [SyntaxText: RawTokenKind] = [:]

  for _ in 0..<tokensToModify {
    let keyToReplace = parser.alternativeTokenChoices.keys.randomElement(using: &SeededRandomNumberGenerators.shared)!
    let valueToReplace = parser.alternativeTokenChoices[keyToReplace]?.randomElement(using: &SeededRandomNumberGenerators.shared)!
    modifications[keyToReplace] = valueToReplace
  }

  var mutatedSource = MutatedTreePrinter.print(tree: Syntax(tree), modifications: modifications)

  if mutatedSource.count > maxSize {
    mutatedSource = Array(mutatedSource.prefix(maxSize))
  }

  data.update(from: &mutatedSource, count: mutatedSource.count)
  return mutatedSource.count
}
