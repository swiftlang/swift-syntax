//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftIfConfig
@_spi(_QualifiedLookup) @_spi(_QualifiedLookupTests) import SwiftLexicalLookup
import SwiftSyntax
import XCTest

final class UnqualifiedTypeLookupTests: XCTestCase {
  func testTopScopeDecls() {
    assertUnqualifiedTypeLookup(
      """
      struct A {}
      typealias A

      let _: \(results: [
        .decls(["struct A {}", "typealias A"], inScope: nil),
      ])A

      func f() \("🟩"){
        struct B {}
        typealias B

        // A is still accessible from function scope
        let _: \(results: [
          .decls(["struct A {}", "typealias A"], inScope: nil),
        ])A

        let _: \(results: [
          .decls(["struct B {}", "typealias B"], inScope: "🟩"),
        ])B

        while \("🟪"){
          // Shadowing
          struct A {}

          let a: \(results: [
            .decls(["struct A {}"], inScope: "🟪"),
            .decls(["struct A {}", "typealias A"], inScope: nil),
          ])A
        }
      }
      """
    )
  }

  func testTypeMembers() {
    // Nominals at top and local scope; doubly nested nominals; in extensions;
    // in doubly nested within extensions

    assertUnqualifiedTypeLookup(
      """
      // Test simple member type at top level
      struct A {
        let _: \(results: [
          .lookForMember(declGroupParent: "struct A {}", lookForSelf: false),
        ])B

        struct B {
          let _: \(results: [
            .lookForMember(declGroupParent: "struct B {}", lookForSelf: false),
            .lookForMember(declGroupParent: "struct A {}", lookForSelf: false),
          ])B
        }
      }

      // Test nested member types in local scopes
      func f() \("🟩"){
        struct C {
          let _: \(results: [
            .lookForMember(declGroupParent: "struct C {}", lookForSelf: false),
            .decls(["struct C {}"], inScope: "🟩"),
          ])C

          func g() {
            struct D {
              struct C {
                let _: \(results: [
                  .lookForMember(declGroupParent: "struct C {}", lookForSelf: false),
                  .lookForMember(declGroupParent: "struct D {}", lookForSelf: false),
                  .lookForMember(declGroupParent: "struct C {}", lookForSelf: false),
                  .decls(["struct C {}"], inScope: "🟩"),
                ])C
              }
            }
          }
        }
      }

      // Test nested member types in an extension
      extension T {
        struct C {
          let _: \(results: [
            .lookForMember(declGroupParent: "struct C {}", lookForSelf: false),
            .lookForGenericParameters(extensionDecl: "extension T {}"),
            .lookForMember(declGroupParent: "extension T {}", lookForSelf: false),
          ])D

          struct D {
            let _: \(results: [
              .lookForMember(declGroupParent: "struct D {}", lookForSelf: false),
              .lookForMember(declGroupParent: "struct C {}", lookForSelf: false),
              .lookForGenericParameters(extensionDecl: "extension T {}"),
              .lookForMember(declGroupParent: "extension T {}", lookForSelf: false),
            ])D
          }
        }
      }
      """
    )
  }

  func testGenericParameters() {
    assertUnqualifiedTypeLookup(
      """
      extension MyType {
        let _: \(results: [
          .lookForGenericParameters(extensionDecl: "extension MyType {}"),
          .lookForMember(declGroupParent: "extension MyType {}", lookForSelf: false),
        ])A

        struct Nested<A, Random1> {
          let _: \(results: [
            .genericParameters(["A"], inClause: "<A, Random1>"),
            .lookForMember(declGroupParent: "struct Nested<A, Random1> {}", lookForSelf: false),
            .lookForGenericParameters(extensionDecl: "extension MyType {}"),
            .lookForMember(declGroupParent: "extension MyType {}", lookForSelf: false),
          ])A

          func f<A, B, Random2>() {
            let _: \(results: [
              .genericParameters(["A"], inClause: "<A, B, Random2>"),
              .genericParameters(["A"], inClause: "<A, Random1>"),
              .lookForMember(declGroupParent: "struct Nested<A, Random1> {}", lookForSelf: false),
              .lookForGenericParameters(extensionDecl: "extension MyType {}"),
              .lookForMember(declGroupParent: "extension MyType {}", lookForSelf: false),
            ])A

            do { // nested sequential scope
              let _: \(results: [
                .genericParameters(["B"], inClause: "<A, B, Random2>"),
                .lookForMember(declGroupParent: "struct Nested<A, Random1> {}", lookForSelf: false),
                .lookForGenericParameters(extensionDecl: "extension MyType {}"),
                .lookForMember(declGroupParent: "extension MyType {}", lookForSelf: false),
              ])B
            }
          }
        }
      }
      """
    )
  }
  func testNestedProtocol() {
    assertUnqualifiedTypeLookup(
      """
      // Simple case
      protocol ProtoA {
        associatedtype A
        associatedtype B

        func f() -> \(results: [
          .lookForMember(declGroupParent: "protocol ProtoA {}", lookForSelf: false),
        ])A
      }

      // Protocol inside a struct
      struct B<B> {
        typealias B
        associatedtype B

        // Protocols can only be declared in non generic structs, but
        // we don't diagnose here
        protocol B {
          associatedtype B

          func f() -> \(results: [
            .lookForMember(declGroupParent: "protocol B {}", lookForSelf: false),
            .genericParameters(["B"], inClause: "<B>"),
            .lookForMember(declGroupParent: "struct B<B> {}", lookForSelf: false),
            .decls(["struct B<B> {}"], inScope: nil),
          ])B

        }
      }
      """
    )
  }

  func testImplicitSelf() {
    // Protocols, extensions; note limitation (link to issue?)

    // Implicit `Self` only appears in extensions and protocols
    // https://github.com/swiftlang/swift-syntax/pull/2852#discussion_r1775049671
    //
    // Note: In the protocol case, implicit `Self` trumps other `Self` declarations, e.g.:
    // ```swift
    // protocol P {
    //     typealias `Self` = Int
    //     func f() -> Self
    // }
    //
    // func g(x: some P) -> some P { x.f() } // ✅
    // ```
    //
    // However, extension exhibit a different behavior:
    // ```swift
    // struct A {
    //     typealias `Self` = Int
    // }
    // extension A {
    //     func f() -> `Self` { Int() }
    // }
    // ```
    // The difference with extensions might be explained by the aforementioned
    // GitHub issue.
    assertUnqualifiedTypeLookup(
      """
      // Protocol
      protocol P {
        func f() -> \(results: [
          // Implicit `Self`
          .lookForMember(declGroupParent: "protocol P {}", lookForSelf: true),
          .lookForMember(declGroupParent: "protocol P {}", lookForSelf: false),
        ])Self
      }

      // Extension
      extension A {
        func f() {
          let _: \(results: [
            .lookForMember(declGroupParent: "extension A {}", lookForSelf: true),
            .lookForGenericParameters(extensionDecl: "extension A {}"),
            .lookForMember(declGroupParent: "extension A {}", lookForSelf: false),
          ])Self

          func g() {
            let _: \(results: [
              .lookForMember(declGroupParent: "extension A {}", lookForSelf: true),
              .lookForGenericParameters(extensionDecl: "extension A {}"),
              .lookForMember(declGroupParent: "extension A {}", lookForSelf: false),
            ])Self
          }
        }
      }
      """
    )
  }
}
