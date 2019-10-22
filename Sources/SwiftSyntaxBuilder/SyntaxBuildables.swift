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

// MARK: - Protocols

public protocol SyntaxListBuildable {
  func buildSyntaxList(format: Format, leadingTrivia: Trivia) -> [Syntax]
}

public protocol SyntaxBuildable: SyntaxListBuildable {
  func buildSyntax(format: Format, leadingTrivia: Trivia) -> Syntax
}

extension SyntaxBuildable {
  public func buildSyntaxList(format: Format, leadingTrivia: Trivia) -> [Syntax] {
    [buildSyntax(format: format, leadingTrivia: leadingTrivia)]
  }
}

// MARK: - Function Builder

@_functionBuilder
public struct SyntaxListBuilder {
  public static func buildBlock(_ builders: SyntaxListBuildable...) -> SyntaxListBuildable {
    SyntaxList(builders: builders)
  }
}

// MARK: - List

public struct SyntaxList: SyntaxListBuildable {
  let builders: [SyntaxListBuildable]

  public func buildSyntaxList(format: Format, leadingTrivia: Trivia) -> [Syntax] {
    builders.flatMap {
      $0.buildSyntaxList(format: format, leadingTrivia: leadingTrivia)
    }
  }
}

extension SyntaxList {
  public static let empty = SyntaxList(builders: [])
}

// MARK: - Buildables

// MARK: Source File

public struct SourceFile: SyntaxBuildable {
  let builder: SyntaxListBuildable

  public init(@SyntaxListBuilder makeBuilder: () -> SyntaxListBuildable) {
    self.builder = makeBuilder()
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia) -> Syntax {
    let syntaxList = builder.buildSyntaxList(format: format, leadingTrivia: leadingTrivia)

    let sourceFile = SourceFileSyntax {
      for (index, syntax) in syntaxList.enumerated() {
        let trivia: Trivia =
          index == syntaxList.startIndex
            ? format._makeIndent()
            : .newlines(1) + format._makeIndent()

        $0.addStatement(CodeBlockItemSyntax {
          $0.useItem(syntax)
        }.withLeadingTrivia(trivia))
      }
    }.withLeadingTrivia(leadingTrivia)

    return Syntax(sourceFile)
  }
}
