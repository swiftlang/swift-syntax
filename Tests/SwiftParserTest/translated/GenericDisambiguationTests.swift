//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// This test file has been translated from swift/test/Parse/generic_disambiguation.swift

import SwiftSyntax

import XCTest

final class GenericDisambiguationTests: XCTestCase {
  func testGenericDisambiguation1() {
    AssertParse(
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
    AssertParse(
      """
      protocol Runcible {}
      protocol Fungible {}
      """
    )
  }

  func testGenericDisambiguation3() {
    AssertParse(
      """
      func meta<T>(_ m: T.Type) {}
      func meta2<T>(_ m: T.Type, _ x: Int) {}
      """
    )
  }

  func testGenericDisambiguation4() {
    AssertParse(
      """
      func generic<T>(_ x: T) {}
      """
    )
  }

  func testGenericDisambiguation5() {
    AssertParse(
      """
      var a, b, c, d : Int
      """
    )
  }

  func testGenericDisambiguation6a() {
    AssertParse(
      """
      _ = a < b
      """
    )
  }

  func testGenericDisambiguation6b() {
    AssertParse(
      """
      _ = (a < b, c > d)
      """
    )
  }

  func testGenericDisambiguation6c() {
    // Parses as generic because of lparen after '>'
    AssertParse(
      """
      (a < b, c > (d))
      """,
      substructure: Syntax(
        GenericArgumentListSyntax([
          GenericArgumentSyntax(
            argumentType: SimpleTypeIdentifierSyntax(name: .identifier("b")),
            trailingComma: .commaToken()
          ),
          GenericArgumentSyntax(
            argumentType: SimpleTypeIdentifierSyntax(name: .identifier("c"))
          ),
        ])
      )
    )
  }

  func testGenericDisambiguation6d() {
    // Parses as generic because of lparen after '>'
    AssertParse(
      """
      (a<b, c>(d))
      """,
      substructure: Syntax(
        GenericArgumentListSyntax([
          GenericArgumentSyntax(
            argumentType: SimpleTypeIdentifierSyntax(name: .identifier("b")),
            trailingComma: .commaToken()
          ),
          GenericArgumentSyntax(
            argumentType: SimpleTypeIdentifierSyntax(name: .identifier("c"))
          ),
        ])
      )
    )
  }

  func testGenericDisambiguation6e() {
    AssertParse(
      """
      _ = a>(b)
      """
    )
  }

  func testGenericDisambiguation6f() {
    AssertParse(
      """
      _ = a > (b)
      """
    )
  }

  func testGenericDisambiguation7() {
    AssertParse(
      """
      generic<Int>(0)
      """
    )
  }

  func testGenericDisambiguation8() {
    AssertParse(
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
    AssertParse(
      """
      A<B>(x: 0)
      """
    )
  }

  func testGenericDisambiguation10() {
    AssertParse(
      """
      meta(A<B>.self)
      """
    )
  }

  func testGenericDisambiguation11() {
    AssertParse(
      """
      meta2(A<B>.self, 0)
      """
    )
  }

  func testGenericDisambiguation12() {
    AssertParse(
      """
      // FIXME: Nested generic types. Need to be able to express $T0<A, B, C> in the
      // typechecker.
      /*
      A<B>.C<D>.e()
      """
    )
  }

  func testGenericDisambiguation13() {
    AssertParse(
      """
      A<B>.C<D>(0)
      """
    )
  }

  func testGenericDisambiguation14() {
    AssertParse(
      """
      meta(A<B>.C<D>.self)
      meta2(A<B>.C<D>.self, 0)
       1️⃣*/
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous code '*/' at top level")
      ]
    )
  }

  func testGenericDisambiguation15() {
    AssertParse(
      """
      // TODO: parse empty <> list
      //A<>.c() // e/xpected-error{{xxx}}
      """
    )
  }

  func testGenericDisambiguation16() {
    AssertParse(
      """
      A<B, D>.c()
      """
    )
  }

  func testGenericDisambiguation17() {
    AssertParse(
      """
      A<B?>(x: 0) // parses as type 
      _ = a < b ? c : d
      """
    )
  }

  func testGenericDisambiguation18() {
    AssertParse(
      """
      A<(B) throws -> D>(x: 0)
      """
    )
  }

}
