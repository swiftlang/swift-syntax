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

public class MultithreadingTests: XCTestCase {

  public func testPathological() {
    let tuple = TupleTypeSyntax(
      leftParen: .leftParenToken(),
      elements: TupleTypeElementListSyntax([]),
      rightParen: .rightParenToken()
    )

    DispatchQueue.concurrentPerform(iterations: 100) { _ in
      XCTAssertEqual(tuple.leftParen, tuple.leftParen)
    }
  }

  public func testConcurrentMutation() {
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

    DispatchQueue.concurrentPerform(iterations: 100) { i in
      var copied = methodCall
      copied
        .calledExpression[as: MemberAccessExprSyntax.self]
        .base![as: DeclReferenceExprSyntax.self]
        .baseName = .identifier("ident\(i)")
      copied = copied.with(\.leadingTrivia, [.newlines(1)])

      XCTAssertEqual(copied.description, "\nident\(i).member()")
    }
  }

  public func testTwoAccesses() {
    let tuple = TupleTypeSyntax(
      leftParen: .leftParenToken(),
      elements: TupleTypeElementListSyntax([]),
      rightParen: .rightParenToken()
    )

    let queue1 = DispatchQueue(label: "queue1")
    let queue2 = DispatchQueue(label: "queue2")

    var node1: TokenSyntax?
    var node2: TokenSyntax?

    let group = DispatchGroup()
    queue1.async(group: group) {
      node1 = tuple.leftParen
    }
    queue2.async(group: group) {
      node2 = tuple.leftParen
    }
    group.wait()

    let final = tuple.leftParen

    XCTAssertNotNil(node1)
    XCTAssertNotNil(node2)
    XCTAssertEqual(node1, node2)
    XCTAssertEqual(node1, final)
    XCTAssertEqual(node2, final)
  }

}
