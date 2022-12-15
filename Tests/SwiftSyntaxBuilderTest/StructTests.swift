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

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class StructTests: XCTestCase {
  func testEmptyStruct() {
    let leadingTrivia = Trivia.unexpectedText("␣")
    let buildable = StructDecl(leadingTrivia: leadingTrivia, identifier: "TestStruct") {}

    AssertBuildResult(
      buildable,
      """
      ␣struct TestStruct {
      }
      """
    )
  }

  func testNestedStruct() {
    let nestedStruct = StructDecl(
      """
      /// A nested struct
      /// with multi line comment
      struct NestedStruct<A, B: C, D> where A: X, A.P == D
      """
    ) {}

    let carriateReturnsStruct = StructDecl(
      leadingTrivia: [
        .docLineComment("/// A nested struct"),
        .carriageReturns(1),
        .docLineComment("/// with multi line comment where the newline is a CR"),
        .carriageReturns(1),
      ],
      structKeyword: .struct,
      identifier: "CarriateReturnsStruct"
    )
    let carriageReturnFormFeedsStruct = StructDecl(
      leadingTrivia: [
        .docLineComment("/// A nested struct"),
        .carriageReturnLineFeeds(1),
        .docLineComment("/// with multi line comment where the newline is a CRLF"),
        .carriageReturnLineFeeds(1),
      ],
      structKeyword: .struct,
      identifier: "CarriageReturnFormFeedsStruct"
    )
    let testStruct = StructDecl("public struct TestStruct") {
      nestedStruct
      carriateReturnsStruct
      carriageReturnFormFeedsStruct
    }

    AssertBuildResult(
      testStruct,
      """
      public struct TestStruct {
          /// A nested struct
          /// with multi line comment
          struct NestedStruct < A, B: C, D > where A: X, A.P == D {
          }
          /// A nested struct\r\
          /// with multi line comment where the newline is a CR\r\
          struct CarriateReturnsStruct {
          }
          /// A nested struct\r\n\
          /// with multi line comment where the newline is a CRLF\r\n\
          struct CarriageReturnFormFeedsStruct {
          }
      }
      """
    )
  }

  func testControlWithLoopAndIf() {
    let myStruct = StructDecl(identifier: "MyStruct") {
      for i in 0..<5 {
        if i.isMultiple(of: 2) {
          VariableDecl(letOrVarKeyword: .let) {
            PatternBinding(
              pattern: IdentifierPattern("var\(raw: i)"),
              typeAnnotation: TypeAnnotation(type: Type("String"))
            )
          }
        }
      }
    }
    AssertBuildResult(
      myStruct,
      """
      struct MyStruct {
          let var0: String
          let var2: String
          let var4: String
      }
      """
    )
  }
}
