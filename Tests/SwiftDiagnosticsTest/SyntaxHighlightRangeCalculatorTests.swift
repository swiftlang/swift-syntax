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

@_spi(Testing) import SwiftDiagnostics
import SwiftSyntax
import XCTest
import _SwiftSyntaxTestSupport

/// Asserts that the computed syntax highlight ranges in a given syntax tree match the expected ranges.
///
/// This function performs two main assertions:
/// 1. It computes highlight ranges for a given line number within a syntax tree, using provided highlight nodes, and asserts that these match the expected ranges.
/// 2. It asserts that the description of each provided syntax highlight node matches its expected description. This is to ensure that the correct property node has been highlighted.
///
/// - Parameters:
///   - inSyntaxTree: The root syntax tree containing the code.
///   - withHighlights: An array of tuples, each containing a syntax node and its expected description (`expectedNodeDescription`).
///   - atLineNumber: The line number within the syntax tree for which to compute highlight ranges.
///   - usingLineSource: An optional string representing the source code of the line being tested. If nil, the function uses the entire source string from `inSyntaxTree`.
///   - matchExpectedRanges: An array of expected highlight ranges.
///   - file: The file in which failure occurred.
///   - line: The line number on which failure occurred.
fileprivate func assertSyntaxHighlightRanges(
  inSyntaxTree tree: some SyntaxProtocol,
  withHighlights highlights: [(node: any SyntaxProtocol, expectedNodeDescription: String)],
  atLineNumber lineNumber: Int = 1,
  usingLineSource lineSource: String? = nil,
  matchExpectedRanges expectedRanges: [Range<Int>],
  file: StaticString = #file,
  line: UInt = #line
) {
  let sourceLocationConverter = SourceLocationConverter(
    fileName: "<SyntaxHighlightRangeCalculatorTests>",
    tree: tree
  )

  let computedRanges = SyntaxHighlightRangeCalculator.computeHighlightRanges(
    forLine: (highlights: highlights.map { Syntax(fromProtocol: $0.node) }, sourceString: lineSource ?? tree.description),
    at: lineNumber,
    fromTree: tree,
    usingSourceLocationConverter: sourceLocationConverter
  )

  XCTAssertEqual(computedRanges, expectedRanges, file: file, line: line)
  for highlight in highlights {
    assertStringsEqualWithDiff(
      highlight.node.description,
      highlight.expectedNodeDescription,
      """
      The description of the passed highlight node of type \(highlight.node.syntaxNodeType) does not \
      align with the expected description.
      """,
      additionalInfo: """
        Expected:
        \(highlight.expectedNodeDescription)

        Actual:
        \(highlight.node.description)
        """,
      file: file,
      line: line
    )
  }
}

final class SyntaxHighlightRangeCalculatorTests: XCTestCase {
  func testComputeHighlightRangesFirstHighlightExcludesLeadingTrivia() {
    let decl: DeclSyntax =
      "@PropertyWrapper private(set) var variable: Decimal = 123 * 456"
    // 123456789012345678901234567890
    let variableDecl = decl.cast(VariableDeclSyntax.self)

    assertSyntaxHighlightRanges(
      inSyntaxTree: variableDecl,
      withHighlights: [
        (node: variableDecl.attributes, expectedNodeDescription: "@PropertyWrapper "),
        (node: variableDecl.modifiers, expectedNodeDescription: "private(set) "),
      ],
      matchExpectedRanges: [1..<18, 18..<30]
    )
  }

  func testComputeHighlightRangesAdjacentHighlightsShareTrivia() {
    let decl: DeclSyntax =
      "@PropertyWrapper     private(set) var variable: Decimal = 123 * 456"
    // 1234567890123456789012345678901234
    let variableDecl = decl.cast(VariableDeclSyntax.self)

    assertSyntaxHighlightRanges(
      inSyntaxTree: variableDecl,
      withHighlights: [
        (node: variableDecl.attributes, expectedNodeDescription: "@PropertyWrapper     "),
        (node: variableDecl.modifiers, expectedNodeDescription: "private(set) "),
      ],
      matchExpectedRanges: [1..<22, 22..<34]
    )
  }

  func testComputeHighlightRangesAdjacentHighlightsShareTriviaWithModifiersAndTypeAnnotation() {
    let decl: DeclSyntax =
      "@PropertyWrapper   private(set)    var    variable: Decimal = 123 * 456"
    //                    0123456789012                  1234567890
    let variableDecl = decl.cast(VariableDeclSyntax.self)

    assertSyntaxHighlightRanges(
      inSyntaxTree: variableDecl,
      withHighlights: [
        (node: variableDecl.modifiers, expectedNodeDescription: "private(set)    "),
        (node: variableDecl.bindings.first!.typeAnnotation!, expectedNodeDescription: ": Decimal "),
      ],
      matchExpectedRanges: [20..<32, 51..<60]
    )
  }

  func testComputeHighlightRangesOverlappingHighlightsMerge() {
    let decl: DeclSyntax =
      "@PropertyWrapper   private(set)    var    variable: Decimal = 123 * 456"
    // 1234567890123456                   678            1234567890123456789012
    let variableDecl = decl.cast(VariableDeclSyntax.self)

    assertSyntaxHighlightRanges(
      inSyntaxTree: variableDecl,
      withHighlights: [
        (node: variableDecl.attributes, expectedNodeDescription: "@PropertyWrapper   "),
        (node: variableDecl.bindingSpecifier, expectedNodeDescription: "var    "),
        (node: variableDecl.bindings.first!.typeAnnotation!, expectedNodeDescription: ": Decimal "),
        (node: variableDecl.bindings.first!.initializer!, expectedNodeDescription: "= 123 * 456"),
      ],
      matchExpectedRanges: [1..<17, 36..<39, 51..<61, 61..<72]
    )
  }

  func testComputeHighlightRangesFirstHighlightExcludesLeadingTriviaWithSpaces() {
    let decl: DeclSyntax =
      "       @PropertyWrapper   private(set)    var    variable: Decimal = 123 * 456"
    //        89012345678901234
    let variableDecl = decl.cast(VariableDeclSyntax.self)

    assertSyntaxHighlightRanges(
      inSyntaxTree: variableDecl,
      withHighlights: [
        (node: variableDecl.attributes, expectedNodeDescription: "       @PropertyWrapper   ")
      ],
      matchExpectedRanges: [8..<24]
    )
  }

  func testComputeHighlightRangesOverlappingHighlightsMergeWithAttributesAndInitializers() {
    let decl: DeclSyntax =
      "@PropertyWrapper   private(set)    var    variable: Decimal = 123 * 456"
    //                                                   1234567890123456789012
    let variableDecl = decl.cast(VariableDeclSyntax.self)

    assertSyntaxHighlightRanges(
      inSyntaxTree: variableDecl,
      withHighlights: [
        (node: variableDecl.bindings.first!.typeAnnotation!, expectedNodeDescription: ": Decimal "),
        (node: variableDecl.bindings.first!.initializer!, expectedNodeDescription: "= 123 * 456"),
        (node: variableDecl.bindings.first!.initializer!.value.cast(SequenceExprSyntax.self).elements.first!, expectedNodeDescription: "123 "),
        (node: variableDecl.bindings.first!.typeAnnotation!, expectedNodeDescription: ": Decimal "),
        (node: variableDecl.bindings.first!.initializer!.value.cast(SequenceExprSyntax.self).elements.last!, expectedNodeDescription: "456"),
        (node: variableDecl.bindings.first!.typeAnnotation!, expectedNodeDescription: ": Decimal "),
      ],
      matchExpectedRanges: [51..<61, 61..<72]
    )
  }

  func testComputeHighlightRangesLastHighlightExcludesTrailingTrivia() {
    let decl: DeclSyntax =
      "@PropertyWrapper private(set) var variable: Decimal = 123 * 456"
    // 1234567890123456789012345678901234567890123456789012345678901234
    let variableDecl = decl.cast(VariableDeclSyntax.self)

    assertSyntaxHighlightRanges(
      inSyntaxTree: variableDecl,
      withHighlights: [
        (node: variableDecl, expectedNodeDescription: "@PropertyWrapper private(set) var variable: Decimal = 123 * 456")
      ],
      matchExpectedRanges: [1..<64]
    )
  }

  func testComputeHighlightRangesFirstHighlightExcludesLeadingTriviaForSimpleVariable() {
    let decl: DeclSyntax =
      "let x=1"
    //     56
    let variableDecl = decl.cast(VariableDeclSyntax.self)

    assertSyntaxHighlightRanges(
      inSyntaxTree: variableDecl,
      withHighlights: [
        (node: variableDecl.bindings.first!.pattern, expectedNodeDescription: "x")
      ],
      matchExpectedRanges: [5..<6]
    )
  }

  func testComputeHighlightRangesEmptyHighlightsEmptyResult() {
    let decl: DeclSyntax = "@PropertyWrapper private(set) var variable: Decimal = 123 * 456"

    assertSyntaxHighlightRanges(
      inSyntaxTree: decl,
      withHighlights: [],
      matchExpectedRanges: []
    )
  }

  func testComputeHighlightRangesInvalidSyntaxTreeEmptyResult() {
    let decl: DeclSyntax = "@PropertyWrapper private(set) var variable: Decimal = 123 * 456"

    assertSyntaxHighlightRanges(
      inSyntaxTree: decl,
      withHighlights: [
        (node: DeclSyntax("var variable: Decimal = 123 * 456"), expectedNodeDescription: "var variable: Decimal = 123 * 456")
      ],
      matchExpectedRanges: []
    )
  }

  func testNoHighlightsOnFirstLineWithVariableDeclaration() {
    let decl: DeclSyntax =
      """
      class MyClass {
        var abc = 132
      }
      """

    let variableDecl = decl.cast(ClassDeclSyntax.self).memberBlock.members.first!.decl.cast(VariableDeclSyntax.self)

    assertSyntaxHighlightRanges(
      inSyntaxTree: decl,
      withHighlights: [
        (node: variableDecl, expectedNodeDescription: "\n  var abc = 132")
      ],
      atLineNumber: 1,
      usingLineSource: "class MyClass {\n",
      matchExpectedRanges: []
    )
  }

  func testFullLineHighlightForSingleLineVariableDeclaration() {
    let decl: DeclSyntax =
      """
      class MyClass {
        var abc = 132
      }
      """

    assertSyntaxHighlightRanges(
      inSyntaxTree: decl,
      withHighlights: [
        (
          node: decl,
          expectedNodeDescription: """
          class MyClass {
            var abc = 132
          }
          """
        )
      ],
      atLineNumber: 2,
      usingLineSource: "  var abc = 132\n",
      matchExpectedRanges: [1..<16]
    )
  }

  func testPartialHighlightForMultiLineVariableDeclarationStart() {
    let decl: DeclSyntax =
      """
      class MyClass {
        var abc =
          132
      }
      """

    let variableDecl = decl.cast(ClassDeclSyntax.self).memberBlock.members.first!.decl.cast(VariableDeclSyntax.self)

    assertSyntaxHighlightRanges(
      inSyntaxTree: decl,
      withHighlights: [
        (node: variableDecl, expectedNodeDescription: "\n  var abc =\n    132")
      ],
      atLineNumber: 2,
      usingLineSource: "  var abc =\n",
      matchExpectedRanges: [3..<12]
    )
  }
}
