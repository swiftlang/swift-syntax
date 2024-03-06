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

#if swift(>=6)
public import SwiftSyntax
import SwiftSyntaxBuilder
#else
import SwiftSyntax
import SwiftSyntaxBuilder
#endif

/// Abstractly represents a source location in the macro.
public struct AbstractSourceLocation: Sendable {
  /// A primary expression that represents the file and is `ExpressibleByStringLiteral`.
  public let file: ExprSyntax

  /// A primary expression that represents the line and is `ExpressibleByIntegerLiteral`.
  public let line: ExprSyntax

  /// A primary expression that represents the column and is `ExpressibleByIntegerLiteral`.
  public let column: ExprSyntax

  public init(file: ExprSyntax, line: ExprSyntax, column: ExprSyntax) {
    self.file = file
    self.line = line
    self.column = column
  }

  public init(_ sourceLocation: SourceLocation) {
    self = AbstractSourceLocation(
      file: "\(literal: sourceLocation.file)",
      line: "\(literal: sourceLocation.line)",
      column: "\(literal: sourceLocation.column)"
    )
  }
}
