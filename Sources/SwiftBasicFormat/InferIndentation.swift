//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if swift(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

extension BasicFormat {
  /// Uses heuristics to infer the indentation width used in the given syntax tree.
  ///
  /// Returns `nil` if the indentation could not be inferred, eg. because it is inconsistent or there are not enough
  /// indented lines to infer the indentation with sufficient accuracy.
  public static func inferIndentation(of tree: some SyntaxProtocol) -> Trivia? {
    return IndentationInferrer.inferIndentation(of: tree)
  }
}

private class IndentationInferrer: SyntaxVisitor {
  /// The trivia of the previous visited token.
  ///
  /// The previous token's trailing trivia will be concatenated with the current token's leading trivia to infer
  /// indentation.
  ///
  /// We start with .newline to indicate that the first token starts on a newline, even if it technically doesn't have
  /// a leading newline character.
  private var previousTokenTrailingTrivia: Trivia = .newline

  /// Counts how many lines had how many spaces of indentation.
  ///
  /// For example, spaceIndentedLines[2] = 4 means that for lines had exactly 2 spaces of indentation.
  private var spaceIndentedLines: [Int: Int] = [:]

  /// See `spaceIndentedLines`
  private var tabIndentedLines: [Int: Int] = [:]

  /// The number of lines that were processed for indentation inference.
  ///
  /// This will be lower than the actual number of lines in the syntax node because
  ///  - It does not count lines without indentation
  //// - It does not count newlines in block doc comments (because we don't process the comment's contents)
  private var linesProcessed = 0

  override func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
    defer { previousTokenTrailingTrivia = token.trailingTrivia }
    let triviaAtStartOfLine =
      (previousTokenTrailingTrivia + token.leadingTrivia)
      .drop(while: { !$0.isNewline })  // Ignore any trivia that's on the previous line
      .split(omittingEmptySubsequences: false, whereSeparator: \.isNewline)  // Split trivia into the lines it occurs on
      .dropFirst()  // Drop the first empty array; exists because we dropped non-newline prefix and newline is separator

    LINE_TRIVIA_LOOP: for lineTrivia in triviaAtStartOfLine {
      switch lineTrivia.first {
      case .spaces(var spaces):
        linesProcessed += 1
        for triviaPiece in lineTrivia.dropFirst() {
          switch triviaPiece {
          case .spaces(let followupSpaces): spaces += followupSpaces
          case .tabs: break LINE_TRIVIA_LOOP  // Count as processed line but don't add to any indentation count
          default: break
          }
        }
        spaceIndentedLines[spaces, default: 0] += 1
      case .tabs(var tabs):
        linesProcessed += 1
        for triviaPiece in lineTrivia.dropFirst() {
          switch triviaPiece {
          case .tabs(let followupTabs): tabs += followupTabs
          case .spaces: break LINE_TRIVIA_LOOP  // Count as processed line but don't add to any indentation count
          default: break
          }
        }
        tabIndentedLines[tabs, default: 0] += 1
      default:
        break
      }
    }
    return .skipChildren
  }

  static func inferIndentation(of tree: some SyntaxProtocol) -> Trivia? {
    let visitor = IndentationInferrer(viewMode: .sourceAccurate)
    visitor.walk(tree)
    if visitor.linesProcessed < 3 {
      // We don't have enough lines to infer indentation reliably
      return nil
    }

    // Pick biggest indentation that encompasses at least 90% of the source lines.
    let threshold = Int(Double(visitor.linesProcessed) * 0.9)

    for spaceIndentation in [8, 4, 2] {
      let linesMatchingIndentation = visitor
        .spaceIndentedLines
        .filter { $0.key.isMultiple(of: spaceIndentation) }
        .map { $0.value }
        .sum
      if linesMatchingIndentation > threshold {
        return .spaces(spaceIndentation)
      }
    }

    for tabIndentation in [2, 1] {
      let linesMatchingIndentation = visitor
        .tabIndentedLines
        .filter { $0.key.isMultiple(of: tabIndentation) }
        .map { $0.value }
        .sum
      if linesMatchingIndentation > threshold {
        return .tabs(tabIndentation)
      }
    }
    return nil
  }
}

fileprivate extension Array<Int> {
  var sum: Int {
    return self.reduce(0) { return $0 + $1 }
  }
}
