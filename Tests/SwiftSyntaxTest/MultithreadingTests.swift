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

@_spi(RawSyntax) import SwiftSyntax
import XCTest

extension SyntaxProtocol {
  subscript<S: SyntaxProtocol>(as type: S.Type) -> S {
    get { self.as(S.self)! }
    set { self = newValue.as(Self.self)! }
  }
}

// Marked as `@unchecked Sendable` to work around rdar://130094927, which complains about `MultithreadingTests` not conforming to
// `Sendable`.
class MultithreadingTests: XCTestCase, @unchecked Sendable {
  public func testPathological() async {
    let tuple = TupleTypeSyntax(
      leftParen: .leftParenToken(),
      elements: TupleTypeElementListSyntax([]),
      rightParen: .rightParenToken()
    )

    await withTaskGroup(of: Void.self) { group in
      for _ in 0..<100 {
        group.addTask {
          XCTAssertEqual(tuple.leftParen, tuple.leftParen)
        }
      }
    }
  }

  public func testConcurrentMutation() async {
    // 'base.member()'
    let methodCall = FunctionCallExprSyntax(
      calledExpression: MemberAccessExprSyntax(
        base: DeclReferenceExprSyntax(
          baseName: .identifier("base")
        ),
        period: .periodToken(),
        name: .identifier("member")
      ),
      leftParen: .leftParenToken(),
      arguments: LabeledExprListSyntax([]),
      rightParen: .rightParenToken()
    )

    await withTaskGroup(of: Void.self) { group in
      for i in 0..<100 {
        group.addTask {
          var copied = methodCall
          copied
            .calledExpression[as: MemberAccessExprSyntax.self]
            .base![as: DeclReferenceExprSyntax.self]
            .baseName = .identifier("ident\(i)")
          copied = copied.with(\.leadingTrivia, [.newlines(1)])

          XCTAssertEqual(copied.description, "\nident\(i).member()")
        }
      }
    }
  }

  public func testTwoAccesses() async {
    let tuple = TupleTypeSyntax(
      leftParen: .leftParenToken(),
      elements: TupleTypeElementListSyntax([]),
      rightParen: .rightParenToken()
    )

    let concurrentParens = await withTaskGroup(of: TokenSyntax.self) { taskGroup in
      taskGroup.addTask { tuple.leftParen }
      taskGroup.addTask { tuple.leftParen }

      var parens: [TokenSyntax?] = []
      for await paren in taskGroup {
        parens.append(paren)
      }
      return parens
    }

    let final = tuple.leftParen

    XCTAssertEqual(concurrentParens, [final, final])
  }
}
