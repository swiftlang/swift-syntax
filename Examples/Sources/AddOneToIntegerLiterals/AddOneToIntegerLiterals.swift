//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation
import SwiftParser
import SwiftSyntax

/// AddOneToIntegerLiterals will visit each token in the Syntax tree, and
/// (if it is an integer literal token) add 1 to the integer and return the
/// new integer literal token.
///
/// For example, it will turn
/// ```
/// let x = 2
/// let y = 3_000
/// ```
/// into
/// ```
/// let x = 3
/// let y = 3001
/// ```
///
private class AddOneToIntegerLiterals: SyntaxRewriter {
  override func visit(_ token: TokenSyntax) -> TokenSyntax {
    // Only transform integer literals.
    guard case .integerLiteral(let text) = token.tokenKind else {
      return token
    }

    // Remove underscores from the original text.
    let integerText = String(text.filter { ("0"..."9").contains($0) })

    // Parse out the integer.
    let int = Int(integerText)!

    // Create a new integer literal token with `int + 1` as its text.
    var newIntegerLiteralToken = token
    newIntegerLiteralToken.tokenKind = .integerLiteral("\(int + 1)")

    // Return the new integer literal.
    return newIntegerLiteralToken
  }
}

@main
struct Main {
  static func main() throws {
    let file = CommandLine.arguments[1]
    let url = URL(fileURLWithPath: file)
    let source = try String(contentsOf: url, encoding: .utf8)
    let sourceFile = Parser.parse(source: source)
    let incremented = AddOneToIntegerLiterals().visit(sourceFile)
    print(incremented)
  }
}
