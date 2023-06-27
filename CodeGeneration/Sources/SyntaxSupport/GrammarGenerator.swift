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

import SwiftSyntax

/// Generates grammar doc comments for syntax nodes.
struct GrammarGenerator {
  private func grammar(for tokenChoice: TokenChoice) -> String {
    switch tokenChoice {
    case .keyword(text: let text):
      return "`'\(text)'`"
    case .token(tokenKind: let tokenKind):
      let token = SYNTAX_TOKEN_MAP[tokenKind]!
      if let tokenText = token.text {
        return "`'\(tokenText)'`"
      } else {
        return "`<\(token.swiftKind)>`"
      }
    }
  }

  private func grammar(for child: Child) -> String {
    let optionality = child.isOptional ? "?" : ""
    switch child.kind {
    case .node(let kind):
      return "``\(kind)Syntax``\(optionality)"
    case .nodeChoices(let choices):
      let choicesDescriptions = choices.map { grammar(for: $0) }
      return "(\(choicesDescriptions.joined(separator: " | ")))\(optionality)"
    case .collection(let kind, _):
      return "``\(kind)Syntax``"
    case .token(let choices, _, _):
      if choices.count == 1 {
        return "\(grammar(for: choices.first!))\(optionality)"
      } else {
        let choicesDescriptions = choices.map { grammar(for: $0) }
        return "(\(choicesDescriptions.joined(separator: " | ")))\(optionality)"
      }
    }
  }

  /// Generates a markdown list containing the children’s names and their
  /// grammar.
  ///
  /// - Parameter children: The children to show in the list
  static func childrenList(for children: [Child]) -> String {
    let generator = GrammarGenerator()
    return
      children
      .filter { !$0.isUnexpectedNodes }
      .map { " - `\($0.swiftName)`: \(generator.grammar(for: $0))" }
      .joined(separator: "\n")
  }
}
