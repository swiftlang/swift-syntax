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

@_spi(Compiler) import SwiftIDEUtils
import SwiftParser
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest
import _SwiftSyntaxTestSupport

fileprivate extension String {
  subscript(_ range: Range<AbsolutePosition>) -> String? {
    let startIndex = self.utf8.index(self.utf8.startIndex, offsetBy: range.lowerBound.utf8Offset)
    let endIndex = self.utf8.index(self.utf8.startIndex, offsetBy: range.upperBound.utf8Offset)
    return String(self.utf8[startIndex..<endIndex])
  }
}

private func assertNameMatcherResult(
  _ markedText: String,
  expected: [DeclNameLocationSpec],
  file: StaticString = #file,
  line: UInt = #line
) {
  let (markers, input) = extractMarkers(markedText)
  let tree = Parser.parse(source: input)
  let positions = markers.values.map { AbsolutePosition(utf8Offset: $0) }
  let resolvedLocations = NameMatcher.resolve(baseNamePositions: Set(positions), in: tree)
  guard resolvedLocations.count == expected.count else {
    XCTFail("Expected \(expected.count) resolved locations but got \(resolvedLocations.count)", file: file, line: line)
    return
  }
  for (actual, expected) in zip(resolvedLocations, expected) {
    guard let actualBaseName = input[actual.baseNameRange] else {
      XCTFail("Base name range returned by NameMatcher covers invalid UTF-8", file: file, line: expected.originatorLine)
      continue
    }
    XCTAssertEqual(actualBaseName, expected.baseName, file: file, line: expected.originatorLine)

    let argumentLabels: [DeclNameLocation.Argument]
    switch actual.arguments {
    case .noArguments: argumentLabels = []
    case .call(let labels, _): argumentLabels = labels
    case .parameters(let labels): argumentLabels = labels
    case .noncollapsibleParameters(let labels): argumentLabels = labels
    case .selector(let labels): argumentLabels = labels
    }

    let actualArgumentLabels = argumentLabels.map { input[$0.range] }
    XCTAssertEqual(actualArgumentLabels, expected.arguments, file: file, line: expected.originatorLine)

    XCTAssertEqual(DeclNameLocationSpec.ArgumentsType(actual.arguments), expected.type, file: file, line: expected.originatorLine)
    XCTAssertEqual(actual.isActive, expected.isActive, file: file, line: expected.originatorLine)
    XCTAssertEqual(actual.context, expected.context, file: file, line: expected.originatorLine)
  }
}

private struct DeclNameLocationSpec {
  /// Mirror of `DeclNameLocation.Arguments` without associated values.
  enum ArgumentsType {
    case noArguments
    case call
    case parameters
    case noncollapsibleParameters
    case selector

    init(_ arguments: DeclNameLocation.Arguments) {
      switch arguments {
      case .noArguments: self = .noArguments
      case .call: self = .call
      case .parameters: self = .parameters
      case .noncollapsibleParameters: self = .noncollapsibleParameters
      case .selector: self = .selector
      }
    }
  }

  let baseName: String
  let arguments: [String]
  let type: ArgumentsType
  let isActive: Bool
  let context: DeclNameLocation.Context
  let originatorLine: UInt

  init(
    baseName: String,
    argumentLabels: [String],
    type: ArgumentsType = .call,
    isActive: Bool = true,
    context: DeclNameLocation.Context = .default,
    originatorLine: UInt = #line
  ) {
    self.baseName = baseName
    self.arguments = argumentLabels
    self.type = type
    self.isActive = isActive
    self.context = context
    self.originatorLine = originatorLine
  }

  init(
    baseName: String,
    isActive: Bool = true,
    context: DeclNameLocation.Context = .default,
    originatorLine: UInt = #line
  ) {
    self.baseName = baseName
    self.arguments = []
    self.type = .noArguments
    self.isActive = isActive
    self.context = context
    self.originatorLine = originatorLine
  }
}

public class NameMatcherTests: XCTestCase {
  func testMemberCall() {
    assertNameMatcherResult(
      "Foo.1️⃣first(associated: 1)",
      expected: [
        DeclNameLocationSpec(baseName: "first", argumentLabels: ["associated: "])
      ]
    )
  }

  func testStringLiteral() {
    assertNameMatcherResult(
      """
      "hello 1️⃣world 2️⃣world"
      """,
      expected: [
        DeclNameLocationSpec(baseName: "world", context: .stringLiteral),
        DeclNameLocationSpec(baseName: "world", context: .stringLiteral),
      ]
    )
  }

  func testWildcardParameter() {
    assertNameMatcherResult(
      "func 0️⃣foo1(_ x: Int) {}",
      expected: [
        DeclNameLocationSpec(baseName: "foo1", argumentLabels: ["_ x"], type: .parameters)
      ]
    )
  }

  func testMatchInComment() {
    assertNameMatcherResult(
      """
      /// 1️⃣foo
      func foo() {}
      """,
      expected: [
        DeclNameLocationSpec(baseName: "foo", context: .comment)
      ]
    )

    assertNameMatcherResult(
      """
      /*
          /*foo:unknown*/1️⃣foo() is not /*foo:unknown*/2️⃣foo(first:)
      */
      """,
      expected: [
        DeclNameLocationSpec(baseName: "foo", argumentLabels: [], type: .call, context: .comment),
        DeclNameLocationSpec(baseName: "foo", argumentLabels: ["first"], type: .selector, context: .comment),
      ]
    )
  }

  func testResolveArgumentLabelsInComments() {
    assertNameMatcherResult(
      "// 1️⃣fn(x:)",
      expected: [
        DeclNameLocationSpec(baseName: "fn", argumentLabels: ["x"], type: .selector, context: .comment)
      ]
    )

    assertNameMatcherResult(
      "// 1️⃣fn(x:) 2️⃣foo(other:)",
      expected: [
        DeclNameLocationSpec(baseName: "fn", argumentLabels: ["x"], type: .selector, context: .comment),
        DeclNameLocationSpec(baseName: "foo", argumentLabels: ["other"], type: .selector, context: .comment),
      ]
    )

    assertNameMatcherResult(
      "// 1️⃣fn(x: 1)",
      expected: [
        DeclNameLocationSpec(baseName: "fn", argumentLabels: ["x: "], type: .call, context: .comment)
      ]
    )
  }

  func testSubscript() {
    assertNameMatcherResult(
      """
      test1️⃣[x: 10]
      """,
      expected: [
        DeclNameLocationSpec(baseName: "[", argumentLabels: ["x: "])
      ]
    )
  }

  func testSubscriptWithBacktickedLabel() {
    assertNameMatcherResult(
      """
      test1️⃣[`x`: 10]
      """,
      expected: [
        DeclNameLocationSpec(baseName: "[", argumentLabels: ["`x`: "])
      ]
    )
  }

  func testFunctionCallOnParenthesis() {
    assertNameMatcherResult(
      "foo1️⃣(1)",
      expected: [
        DeclNameLocationSpec(baseName: "(", argumentLabels: [""])
      ]
    )
  }

  func testMatchUnderscoreOrDollarInToken() {
    assertNameMatcherResult(
      "_1️⃣foo",
      expected: [
        DeclNameLocationSpec(baseName: "foo")
      ]
    )

    assertNameMatcherResult(
      "$1️⃣foo",
      expected: [
        DeclNameLocationSpec(baseName: "foo")
      ]
    )

    assertNameMatcherResult(
      "_1️⃣foo(x: 1)",
      expected: [
        DeclNameLocationSpec(baseName: "foo", argumentLabels: ["x: "])
      ]
    )
  }

  func testQualifiedAttribute() {
    assertNameMatcherResult(
      """
      @Outer.1️⃣Inner(x: 1)
      """,
      expected: [
        DeclNameLocationSpec(baseName: "Inner", argumentLabels: ["x: "])
      ]
    )
  }

  func testSelector() {
    assertNameMatcherResult(
      "#selector(foo.1️⃣bar)",
      expected: [
        DeclNameLocationSpec(baseName: "bar", context: .selector)
      ]
    )

    assertNameMatcherResult(
      "#selector(foo.1️⃣bar(a:))",
      expected: [
        DeclNameLocationSpec(baseName: "bar", argumentLabels: ["a"], type: .selector, context: .selector)
      ]
    )
  }

  func testIsActive() {
    assertNameMatcherResult(
      """
      #if true
      1️⃣foo
      #endif
      """,
      expected: [
        DeclNameLocationSpec(baseName: "foo", isActive: false)
      ]
    )
  }

  func testBaseOfMemberAccess() {
    assertNameMatcherResult(
      "1️⃣Foo.bar(a: 1, b: 2)",
      expected: [
        DeclNameLocationSpec(baseName: "Foo")
      ]
    )
  }

  func testOperatorDeclaration() {
    assertNameMatcherResult(
      "func 1️⃣+(x: Int, y: Int) {}",
      expected: [
        DeclNameLocationSpec(baseName: "+", argumentLabels: ["x", "y"], type: .parameters)
      ]
    )
  }

  func testCallQualifiedDeclName() {
    assertNameMatcherResult(
      "1️⃣fn(x:)(1)",
      expected: [
        DeclNameLocationSpec(baseName: "fn", argumentLabels: ["x"], type: .selector)
      ]
    )
  }
}
