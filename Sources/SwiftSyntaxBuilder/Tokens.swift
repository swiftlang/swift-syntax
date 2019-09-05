//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2019 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

/// Namespace for commonly used tokens with default trivia.
enum Tokens {
  // MARK: Keywords

  /// `"let "`
  static let `let` = SyntaxFactory.makeLetKeyword().withTrailingTrivia(.spaces(1))

  /// `"var "`
  static let `var` = SyntaxFactory.makeVarKeyword().withTrailingTrivia(.spaces(1))

  /// `"import "`
  static let `import` = SyntaxFactory.makeImportKeyword().withTrailingTrivia(.spaces(1))

  /// `"struct "`
  static let `struct` = SyntaxFactory.makeStructKeyword().withTrailingTrivia(.spaces(1))

  // MARK: Punctuations and Signs

  /// `":"`
  static let colon = SyntaxFactory.makeColonToken().withTrailingTrivia(.spaces(1))

  /// `" = "`
  static let equal = SyntaxFactory.makeEqualToken().withLeadingTrivia(.spaces(1))
                                                   .withTrailingTrivia(.spaces(1))

  /// `"{"`
  static let leftBrace = SyntaxFactory.makeLeftBraceToken()

  /// `"}"`
  static let rightBrace = SyntaxFactory.makeRightBraceToken()
}
