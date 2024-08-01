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
import SwiftSyntaxBuilder
import XCTest

public class SyntaxTrackingTests: XCTestCase {
  func testReuseSubtreeWithoutNodeShiftInSameArena() {
    let originalAccessorBlock = AccessorBlockSyntax("{ return 1 }").tracked

    let newAccessorBlock = AccessorBlockSyntax(
      leadingTrivia: .spaces(10),
      accessors: originalAccessorBlock.accessors
    )

    XCTAssertNotEqual(newAccessorBlock.accessors.id, originalAccessorBlock.accessors.id)
    XCTAssertEqual(
      newAccessorBlock.accessors.originalNode(in: originalAccessorBlock)?.id,
      originalAccessorBlock.accessors.id
    )
  }

  func testReuseSubtreeWithoutNodeShiftInNewArena() {
    let originalAccessorBlock = AccessorBlockSyntax("{ return 1 }").tracked

    let newAccessorBlock = AccessorBlockSyntax(
      leadingTrivia: .spaces(10),
      accessors: originalAccessorBlock.accessors
    )

    XCTAssertEqual(
      newAccessorBlock.accessors.originalNode(in: originalAccessorBlock)?.id,
      originalAccessorBlock.accessors.id
    )
  }

  func testReuseSubtreeWithNodeShift() {
    let originalAccessorBlock = AccessorBlockSyntax("{ return 1 }").tracked

    let newAccessorBlock = AccessorBlockSyntax(
      leadingTrivia: .spaces(10),
      [Syntax(TokenSyntax.identifier("unexpected"))],
      accessors: originalAccessorBlock.accessors
    )

    XCTAssertEqual(
      newAccessorBlock.accessors.originalNode(in: originalAccessorBlock)?.id,
      originalAccessorBlock.accessors.id
    )
  }

  func testReplaceOtherNodeWithoutNodeShift() {
    let originalAccessorBlock = AccessorBlockSyntax("{ return 1 }").tracked

    let newAccessor = originalAccessorBlock.with(\.leftBrace, .leftBraceToken())

    XCTAssertEqual(
      newAccessor.accessors.originalNode(in: originalAccessorBlock)?.id,
      originalAccessorBlock.accessors.id
    )
  }

  func testReplaceNonNilByNil() throws {
    let originalFunction = try FunctionDeclSyntax("func foo() async {}").tracked
    var modifiedFunction = originalFunction
    modifiedFunction.signature.effectSpecifiers = nil

    XCTAssertEqual(modifiedFunction.body?.originalNode(in: originalFunction)?.id, originalFunction.body?.id)
  }

  func testReplaceNilByNonNil() throws {
    let originalFunction = try FunctionDeclSyntax("func foo() {}").tracked
    var modifiedFunction = originalFunction
    modifiedFunction.signature.effectSpecifiers = FunctionEffectSpecifiersSyntax(asyncSpecifier: .keyword(.async))

    XCTAssertEqual(modifiedFunction.body?.originalNode(in: originalFunction)?.id, originalFunction.body?.id)
  }

  func testReplaceNilByNil() throws {
    let originalFunction = try FunctionDeclSyntax("func foo() {}").tracked
    var modifiedFunction = originalFunction
    modifiedFunction.signature.effectSpecifiers = nil

    XCTAssertEqual(modifiedFunction.body?.originalNode(in: originalFunction)?.id, originalFunction.body?.id)
  }

  func testDetach() throws {
    let originalFunction = try FunctionDeclSyntax("func foo() {}").tracked
    let modifiedFunction = originalFunction.body?.detached

    XCTAssertEqual(modifiedFunction?.originalNode(in: originalFunction)?.id, originalFunction.body?.id)
  }

  func testSyntaxCollection() throws {
    let originalFunction = DeclSyntax("func foo() {}").tracked

    let codeBlockItemList = CodeBlockItemListSyntax([CodeBlockItemSyntax(item: .decl(originalFunction))])

    XCTAssertEqual(codeBlockItemList.first?.item.originalNode(in: originalFunction)?.id, originalFunction.id)
  }

  func testSyntaxCollectionModification() throws {
    let originalFunction = DeclSyntax("func foo() {}").tracked

    var codeBlockItemList = CodeBlockItemListSyntax([CodeBlockItemSyntax(item: .decl(originalFunction))])
    codeBlockItemList.insert(CodeBlockItemSyntax("func bar() {}"), at: codeBlockItemList.startIndex)

    XCTAssertEqual(codeBlockItemList.last?.item.originalNode(in: originalFunction)?.id, originalFunction.id)
  }
}
