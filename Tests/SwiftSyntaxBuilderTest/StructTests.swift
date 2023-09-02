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

import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest

final class StructTests: XCTestCase {
  func testEmptyStruct() {
    let leadingTrivia = Trivia.unexpectedText("␣")
    let buildable = StructDeclSyntax(leadingTrivia: leadingTrivia, name: "TestStruct") {}

    assertBuildResult(
      buildable,
      """
      ␣struct TestStruct {
      }
      """
    )
  }

  func testNestedStruct() throws {
    let nestedStruct = try StructDeclSyntax(
      """
      /// A nested struct
      /// with multi line comment
      struct NestedStruct<A, B: C, D> where A: X, A.P == D
      """
    ) {}

    let carriateReturnsStruct = StructDeclSyntax(
      leadingTrivia: [
        .docLineComment("/// A nested struct"),
        .carriageReturns(1),
        .docLineComment("/// with multi line comment where the newline is a CR"),
        .carriageReturns(1),
      ],
      structKeyword: .keyword(.struct),
      name: "CarriateReturnsStruct",
      memberBlock: MemberBlockSyntax(members: [])
    )
    let carriageReturnFormFeedsStruct = StructDeclSyntax(
      leadingTrivia: [
        .docLineComment("/// A nested struct"),
        .carriageReturnLineFeeds(1),
        .docLineComment("/// with multi line comment where the newline is a CRLF"),
        .carriageReturnLineFeeds(1),
      ],
      structKeyword: .keyword(.struct),
      name: "CarriageReturnFormFeedsStruct",
      memberBlock: MemberBlockSyntax(members: [])
    )
    let testStruct = try StructDeclSyntax("public struct TestStruct") {
      nestedStruct
      carriateReturnsStruct
      carriageReturnFormFeedsStruct
    }

    assertBuildResult(
      testStruct,
      """
      public struct TestStruct {
          /// A nested struct
          /// with multi line comment
          struct NestedStruct<A, B: C, D> where A: X, A.P == D {
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
    let myStruct = StructDeclSyntax(name: "MyStruct") {
      for i in 0..<5 {
        if i.isMultiple(of: 2) {
          VariableDeclSyntax(bindingSpecifier: .keyword(.let)) {
            PatternBindingSyntax(
              pattern: PatternSyntax("var\(raw: i)"),
              typeAnnotation: TypeAnnotationSyntax(type: TypeSyntax("String"))
            )
          }
        }
      }
    }
    assertBuildResult(
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
