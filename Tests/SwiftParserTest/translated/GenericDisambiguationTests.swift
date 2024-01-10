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

// This test file has been translated from swift/test/Parse/generic_disambiguation.swift

import SwiftSyntax
import XCTest

final class GenericDisambiguationTests: ParserTestCase {
  func testGenericDisambiguation1() {
    assertParse(
      """
      struct A<B> {
        init(x:Int) {}
        static func c() {}
        struct C<D> {
          static func e() {}
        }
        struct F {}
      }
      struct B {}
      struct D {}
      """
    )
  }

  func testGenericDisambiguation2() {
    assertParse(
      """
      protocol Runcible {}
      protocol Fungible {}
      """
    )
  }

  func testGenericDisambiguation3() {
    assertParse(
      """
      func meta<T>(_ m: T.Type) {}
      func meta2<T>(_ m: T.Type, _ x: Int) {}
      """
    )
  }

  func testGenericDisambiguation4() {
    assertParse(
      """
      func generic<T>(_ x: T) {}
      """
    )
  }

  func testGenericDisambiguation5() {
    assertParse(
      """
      var a, b, c, d : Int
      """
    )
  }

  func testGenericDisambiguation6a() {
    assertParse(
      """
      _ = a < b
      """
    )
  }

  func testGenericDisambiguation6b() {
    assertParse(
      """
      _ = (a < b, c > d)
      """
    )
  }

  func testGenericDisambiguation6c() {
    // Parses as generic because of lparen after '>'
    assertParse(
      """
      (a < b, c > (d))
      """,
      substructure: GenericArgumentListSyntax([
        GenericArgumentSyntax(
          argument: IdentifierTypeSyntax(name: .identifier("b")),
          trailingComma: .commaToken()
        ),
        GenericArgumentSyntax(
          argument: IdentifierTypeSyntax(name: .identifier("c"))
        ),
      ])
    )
  }

  func testGenericDisambiguation6d() {
    // Parses as generic because of lparen after '>'
    assertParse(
      """
      (a<b, c>(d))
      """,
      substructure: GenericArgumentListSyntax([
        GenericArgumentSyntax(
          argument: IdentifierTypeSyntax(name: .identifier("b")),
          trailingComma: .commaToken()
        ),
        GenericArgumentSyntax(
          argument: IdentifierTypeSyntax(name: .identifier("c"))
        ),
      ])
    )
  }

  func testGenericDisambiguation6e() {
    assertParse(
      """
      _ = a>(b)
      """
    )
  }

  func testGenericDisambiguation6f() {
    assertParse(
      """
      _ = a > (b)
      """
    )
  }

  func testGenericDisambiguation7() {
    assertParse(
      """
      generic<Int>(0)
      """
    )
  }

  func testGenericDisambiguation8() {
    assertParse(
      """
      A<B>.c()
      A<A<B>>.c()
      A<A<B>.F>.c()
      A<(A<B>) -> B>.c()
      A<[[Int]]>.c()
      A<[[A<B>]]>.c()
      A<(Int, UnicodeScalar)>.c()
      A<(a:Int, b:UnicodeScalar)>.c()
      A<Runcible & Fungible>.c()
      A<@convention(c) () -> Int32>.c()
      A<(@autoclosure @escaping () -> Int, Int) -> Void>.c()
      _ = [@convention(block) ()  -> Int]().count
      _ = [String: (@escaping (A<B>) -> Int) -> Void]().keys
      """
    )
  }

  func testGenericDisambiguation9() {
    assertParse(
      """
      A<B>(x: 0)
      """
    )
  }

  func testGenericDisambiguation10() {
    assertParse(
      """
      meta(A<B>.self)
      """
    )
  }

  func testGenericDisambiguation11() {
    assertParse(
      """
      meta2(A<B>.self, 0)
      """
    )
  }

  func testGenericDisambiguation12() {
    assertParse(
      """
      A<B>.C<D>.e()
      """
    )
  }

  func testGenericDisambiguation13() {
    assertParse(
      """
      A<B>.C<D>(0)
      """
    )
  }

  func testGenericDisambiguation14() {
    assertParse(
      """
      meta(A<B>.C<D>.self)
      meta2(A<B>.C<D>.self, 0)
      """
    )
  }

  func testGenericDisambiguation15() {
    assertParse(
      """
      A<>.c()
      """,
      substructure: PostfixOperatorExprSyntax(
        expression: ExprSyntax(DeclReferenceExprSyntax(baseName: .identifier("A"))),
        operator: .postfixOperator("<>")
      )
    )
  }

  func testGenericDisambiguation16() {
    assertParse(
      """
      A<B, D>.c()
      """
    )
  }

  func testGenericDisambiguation17() {
    assertParse(
      """
      A<B?>(x: 0) // parses as type
      _ = a < b ? c : d
      """
    )
  }

  func testGenericDisambiguation18() {
    assertParse(
      """
      A<(B) throws -> D>(x: 0)
      """
    )
  }

}
