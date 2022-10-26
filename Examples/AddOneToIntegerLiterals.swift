import SwiftSyntax
import SwiftParser
import Foundation

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
    let newIntegerLiteralToken = token.withKind(.integerLiteral("\(int + 1)"))

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
