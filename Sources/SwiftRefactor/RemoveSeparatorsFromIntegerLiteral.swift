import SwiftSyntax

/// Format an integer literal by removing any existing separators.
///
/// ## Before
///
/// ```swift
/// 123_456_789
/// 0xF_FFFF_FFFF
/// ```
/// ## After
///
/// ```swift
/// 123456789
/// 0xFFFFFFFFF
/// ```
public struct RemoveSeparatorsFromIntegerLiteral: RefactoringProvider {
  public static func refactor(syntax lit: IntegerLiteralExprSyntax, in context: Void) -> IntegerLiteralExprSyntax? {
    guard lit.digits.text.contains("_") else {
      return lit
    }
    let formattedText = lit.digits.text.filter({ $0 != "_" })
    return lit
      .withDigits(lit.digits.withKind(.integerLiteral(formattedText)))
  }
}
