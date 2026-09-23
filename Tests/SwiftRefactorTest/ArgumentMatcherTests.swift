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

import SwiftParser
import SwiftRefactor
import SwiftSyntax
import XCTest

final class ArgumentMatcherTests: XCTestCase {

  // Labeled arguments — matched by external label name.
  // Covers proposal Deliverable 2 §2, configure(width:height:) example.

  func testAllLabeledArguments() throws {
    let call = parseCall("configure(width: 100, height: 200)")
    let params = parseParameters("func configure(width: Int, height: Int) {}")

    let matches = try ArgumentMatcher.match(call: call, parameters: params)

    XCTAssertEqual(matches.count, 2)

    let widthMatch = try XCTUnwrap(matches.first)
    XCTAssertEqual(widthMatch.internalName.text, "width")
    XCTAssertEqual(widthMatch.argument?.trimmedDescription, "100")
    XCTAssertTrue(widthMatch.isLabeled)

    let heightMatch = try XCTUnwrap(matches.last)
    XCTAssertEqual(heightMatch.internalName.text, "height")
    XCTAssertEqual(heightMatch.argument?.trimmedDescription, "200")
    XCTAssertTrue(heightMatch.isLabeled)
  }

  func testSingleLabeledArgument() throws {
    let call = parseCall("foo(bar: 42)")
    let params = parseParameters("func foo(bar: Int) {}")

    let matches = try ArgumentMatcher.match(call: call, parameters: params)

    XCTAssertEqual(matches.count, 1)
    XCTAssertEqual(matches[0].internalName.text, "bar")
    XCTAssertEqual(matches[0].argument?.trimmedDescription, "42")
    XCTAssertTrue(matches[0].isLabeled)
  }

  // Positional (unlabeled) arguments — parameter external label is `_`.
  // Covers proposal Deliverable 1 greet(_ name:) example.

  func testSinglePositionalArgument() throws {
    let call = parseCall(#"greet("World")"#)
    let params = parseParameters("func greet(_ name: String) -> String {}")

    let matches = try ArgumentMatcher.match(call: call, parameters: params)

    XCTAssertEqual(matches.count, 1)
    XCTAssertEqual(matches[0].internalName.text, "name")
    XCTAssertEqual(matches[0].argument?.trimmedDescription, #""World""#)
    XCTAssertFalse(matches[0].isLabeled)
  }

  func testMultiplePositionalArguments() throws {
    let call = parseCall("add(1, 2)")
    let params = parseParameters("func add(_ lhs: Int, _ rhs: Int) -> Int {}")

    let matches = try ArgumentMatcher.match(call: call, parameters: params)

    XCTAssertEqual(matches.count, 2)
    XCTAssertEqual(matches[0].internalName.text, "lhs")
    XCTAssertEqual(matches[0].argument?.trimmedDescription, "1")
    XCTAssertFalse(matches[0].isLabeled)
    XCTAssertEqual(matches[1].internalName.text, "rhs")
    XCTAssertEqual(matches[1].argument?.trimmedDescription, "2")
    XCTAssertFalse(matches[1].isLabeled)
  }

  // External vs. internal parameter names.
  // Covers proposal Deliverable 2 §2.1: func move(to destination: CGPoint).
  // The external label `to` is used at the call site; the internal name
  // `destination` is what gets substituted in the function body.

  func testExternalInternalNameDistinction() throws {
    let call = parseCall("move(to: target)")
    let params = parseParameters("func move(to destination: CGPoint) {}")

    let matches = try ArgumentMatcher.match(call: call, parameters: params)

    XCTAssertEqual(matches.count, 1)
    XCTAssertEqual(matches[0].parameter.firstName.text, "to")
    XCTAssertEqual(matches[0].internalName.text, "destination")
    XCTAssertEqual(matches[0].argument?.trimmedDescription, "target")
    XCTAssertTrue(matches[0].isLabeled)
  }

  func testSingleNameServesAsBothExternalAndInternal() throws {
    // When a parameter has only one name it is used at both the call site and
    // in the function body.
    let call = parseCall(#"log(message: "hello")"#)
    let params = parseParameters("func log(message: String) {}")

    let matches = try ArgumentMatcher.match(call: call, parameters: params)

    XCTAssertEqual(matches.count, 1)
    XCTAssertEqual(matches[0].parameter.firstName.text, "message")
    XCTAssertEqual(matches[0].internalName.text, "message")
  }

  // Mixed labeled and positional — e.g. func foo(_ x: Int, y: Int).
  // Covers proposal Deliverable 2 table row "Unlabeled args".

  func testMixedLabeledAndPositionalArguments() throws {
    let call = parseCall("foo(1, y: 2)")
    let params = parseParameters("func foo(_ x: Int, y: Int) {}")

    let matches = try ArgumentMatcher.match(call: call, parameters: params)

    XCTAssertEqual(matches.count, 2)
    XCTAssertEqual(matches[0].internalName.text, "x")
    XCTAssertFalse(matches[0].isLabeled)
    XCTAssertEqual(matches[1].internalName.text, "y")
    XCTAssertTrue(matches[1].isLabeled)
  }

  // Empty call / empty parameter list.

  func testNoArgumentsNoParameters() throws {
    let call = parseCall("foo()")
    let params = parseParameters("func foo() {}")

    let matches = try ArgumentMatcher.match(call: call, parameters: params)

    XCTAssertTrue(matches.isEmpty)
  }

  // Default parameter omission.
  // Covers proposal Deliverable 2 §2.3: toast(message:duration:) where
  // `duration` has a default value and can be omitted at the call site.

  func testOmittedDefaultedParameterIsAccepted() throws {
    let call = parseCall(#"toast(message: "Saved")"#)
    let params = parseParameters("func toast(message: String, duration: Double = 2.0) {}")

    let matches = try ArgumentMatcher.match(call: call, parameters: params)

    XCTAssertEqual(matches.count, 1)
    XCTAssertEqual(matches[0].internalName.text, "message")
  }

  // configure(width:height:color:) — proposal §2.3 default example.
  // Color parameter has a default (.blue) and may be omitted.

  func testConfigureWithOmittedColorDefault() throws {
    let call = parseCall("configure(width: 100, height: 200)")
    let params = parseParameters(
      "func configure(width: Int, height: Int, color: Int = 0) {}"
    )

    let matches = try ArgumentMatcher.match(call: call, parameters: params)

    XCTAssertEqual(matches.count, 2)
    XCTAssertEqual(matches[0].internalName.text, "width")
    XCTAssertEqual(matches[1].internalName.text, "height")
  }

  // Error cases.

  func testExtraArgumentsThrowsError() throws {
    let call = parseCall("foo(1, 2, 3)")
    let params = parseParameters("func foo(_ a: Int, _ b: Int) {}")

    XCTAssertThrowsError(try ArgumentMatcher.match(call: call, parameters: params)) { error in
      guard case ArgumentMatchError.extraArguments(let from) = error else {
        return XCTFail("Expected extraArguments error, got \(error)")
      }
      XCTAssertEqual(from, 2)
    }
  }

  func testUnexpectedLabelThrowsError() throws {
    let call = parseCall("foo(bar: 1)")
    let params = parseParameters("func foo(baz: Int) {}")

    XCTAssertThrowsError(try ArgumentMatcher.match(call: call, parameters: params)) { error in
      guard case ArgumentMatchError.unexpectedLabel(let label, _) = error else {
        return XCTFail("Expected unexpectedLabel error, got \(error)")
      }
      XCTAssertEqual(label.text, "bar")
    }
  }

  func testMissingRequiredArgumentThrowsError() throws {
    let call = parseCall("foo()")
    let params = parseParameters("func foo(x: Int) {}")

    XCTAssertThrowsError(try ArgumentMatcher.match(call: call, parameters: params)) { error in
      guard case ArgumentMatchError.missingArgument(let paramName) = error else {
        return XCTFail("Expected missingArgument error, got \(error)")
      }
      XCTAssertEqual(paramName, "x")
    }
  }

  func testDuplicateLabeledArgumentThrowsError() throws {
    let call = parseCall("foo(x: 1, x: 2)")
    let params = parseParameters("func foo(x: Int) {}")

    XCTAssertThrowsError(try ArgumentMatcher.match(call: call, parameters: params)) { error in
      guard case ArgumentMatchError.extraArguments = error else {
        return XCTFail("Expected extraArguments error, got \(error)")
      }
    }
  }
}

// MARK: - matchWithDefaults Tests

final class ArgumentMatcherWithDefaultsTests: XCTestCase {

  // Covers proposal Deliverable 2 §2.3: func toast(message:duration:)
  // where `duration` has a default value and is omitted at the call site.

  func testSynthesizesDefaultValueForOmittedParameter() throws {
    let call = parseCall(#"toast(message: "Saved")"#)
    let params = parseParameters("func toast(message: String, duration: Double = 2.0) {}")

    let matches = try ArgumentMatcher.matchWithDefaults(call: call, parameters: params)

    XCTAssertEqual(matches.count, 2)

    let messageMatch = matches[0]
    XCTAssertEqual(messageMatch.internalName.text, "message")
    XCTAssertEqual(messageMatch.argument?.trimmedDescription, #""Saved""#)
    XCTAssertFalse(messageMatch.isDefaulted)

    let durationMatch = matches[1]
    XCTAssertEqual(durationMatch.internalName.text, "duration")
    XCTAssertEqual(durationMatch.argument?.trimmedDescription, "2.0")
    XCTAssertTrue(durationMatch.isDefaulted)
  }

  // Covers proposal configure(width:height:color:) with color defaulted.

  func testConfigureWithDefaultedColor() throws {
    let call = parseCall("configure(width: 100, height: 200)")
    let params = parseParameters(
      "func configure(width: Int, height: Int, color: Color = .blue) {}"
    )

    let matches = try ArgumentMatcher.matchWithDefaults(call: call, parameters: params)

    XCTAssertEqual(matches.count, 3)
    XCTAssertEqual(matches[0].internalName.text, "width")
    XCTAssertFalse(matches[0].isDefaulted)
    XCTAssertEqual(matches[1].internalName.text, "height")
    XCTAssertFalse(matches[1].isDefaulted)
    XCTAssertEqual(matches[2].internalName.text, "color")
    XCTAssertTrue(matches[2].isDefaulted)
    XCTAssertEqual(matches[2].argument?.trimmedDescription, ".blue")
  }

  func testAllParametersExplicitlyProvided() throws {
    let call = parseCall("foo(a: 1, b: 2)")
    let params = parseParameters("func foo(a: Int = 0, b: Int = 0) {}")

    let matches = try ArgumentMatcher.matchWithDefaults(call: call, parameters: params)

    XCTAssertEqual(matches.count, 2)
    XCTAssertFalse(matches[0].isDefaulted)
    XCTAssertFalse(matches[1].isDefaulted)
    XCTAssertEqual(matches[0].argument?.trimmedDescription, "1")
    XCTAssertEqual(matches[1].argument?.trimmedDescription, "2")
  }

  func testAllParametersDefaulted() throws {
    let call = parseCall("foo()")
    let params = parseParameters("func foo(a: Int = 1, b: Int = 2) {}")

    let matches = try ArgumentMatcher.matchWithDefaults(call: call, parameters: params)

    XCTAssertEqual(matches.count, 2)
    XCTAssertTrue(matches[0].isDefaulted)
    XCTAssertTrue(matches[1].isDefaulted)
    XCTAssertEqual(matches[0].argument?.trimmedDescription, "1")
    XCTAssertEqual(matches[1].argument?.trimmedDescription, "2")
  }

  func testMiddleParameterDefaulted() throws {
    let call = parseCall("foo(a: 1, c: 3)")
    let params = parseParameters("func foo(a: Int, b: Int = 2, c: Int) {}")

    let matches = try ArgumentMatcher.matchWithDefaults(call: call, parameters: params)

    XCTAssertEqual(matches.count, 3)
    XCTAssertEqual(matches[0].argument?.trimmedDescription, "1")
    XCTAssertFalse(matches[0].isDefaulted)
    XCTAssertEqual(matches[1].argument?.trimmedDescription, "2")
    XCTAssertTrue(matches[1].isDefaulted)
    XCTAssertEqual(matches[2].argument?.trimmedDescription, "3")
    XCTAssertFalse(matches[2].isDefaulted)
  }

  func testComplexDefaultExpression() throws {
    let call = parseCall("foo()")
    let params = parseParameters("func foo(x: Int = 1 + 2 * 3) {}")

    let matches = try ArgumentMatcher.matchWithDefaults(call: call, parameters: params)

    XCTAssertEqual(matches.count, 1)
    XCTAssertTrue(matches[0].isDefaulted)
    XCTAssertEqual(matches[0].argument?.trimmedDescription, "1 + 2 * 3")
  }

  func testMissingRequiredArgumentThrowsError() throws {
    let call = parseCall("foo()")
    let params = parseParameters("func foo(x: Int) {}")

    XCTAssertThrowsError(try ArgumentMatcher.matchWithDefaults(call: call, parameters: params))
  }

  func testDuplicateLabeledArgumentThrowsError() throws {
    let call = parseCall("foo(x: 1, x: 2)")
    let params = parseParameters("func foo(x: Int, y: Int = 0) {}")

    XCTAssertThrowsError(try ArgumentMatcher.matchWithDefaults(call: call, parameters: params)) {
      error in
      guard case ArgumentMatchError.extraArguments = error else {
        return XCTFail("Expected extraArguments error, got \(error)")
      }
    }
  }
}

// MARK: - matchWithTrailingClosures Tests

final class ArgumentMatcherWithTrailingClosuresTests: XCTestCase {

  // Covers proposal Deliverable 2 §2.4: animate(duration:_block:)

  func testSingleTrailingClosure() throws {
    let call = parseCallWithTrailingClosure(
      "animate(duration: 0.3)",
      trailingClosure: "{ view.alpha = 0 }"
    )
    let params = parseParameters("func animate(duration: Double, _ block: () -> Void) {}")

    let matches = try ArgumentMatcher.matchWithTrailingClosures(call: call, parameters: params)

    XCTAssertEqual(matches.count, 2)

    let durationMatch = matches[0]
    XCTAssertEqual(durationMatch.internalName.text, "duration")
    XCTAssertEqual(durationMatch.argument?.trimmedDescription, "0.3")
    XCTAssertFalse(durationMatch.isTrailingClosure)

    let blockMatch = matches[1]
    XCTAssertEqual(blockMatch.internalName.text, "block")
    XCTAssertTrue(blockMatch.isTrailingClosure)
    XCTAssertTrue(blockMatch.argument?.trimmedDescription.contains("view.alpha") ?? false)
  }

  // Trailing closures match labeled parameters too, not just `_` params.
  // Swift allows: foo(x: 1) { } where foo has `completion: () -> Void`.

  func testTrailingClosureWithLabeledParameter() throws {
    let call = parseCallWithTrailingClosure(
      "request(url: url)",
      trailingClosure: "{ result in print(result) }"
    )
    let params = parseParameters(
      "func request(url: URL, completion: (Result) -> Void) {}"
    )

    let matches = try ArgumentMatcher.matchWithTrailingClosures(call: call, parameters: params)

    XCTAssertEqual(matches.count, 2)
    XCTAssertEqual(matches[0].internalName.text, "url")
    XCTAssertFalse(matches[0].isTrailingClosure)
    XCTAssertEqual(matches[1].internalName.text, "completion")
    XCTAssertTrue(matches[1].isTrailingClosure)
  }

  func testTrailingClosureWithNoInlineArguments() throws {
    let call = parseCallWithTrailingClosure("foo()", trailingClosure: "{ print(1) }")
    let params = parseParameters("func foo(_ block: () -> Void) {}")

    let matches = try ArgumentMatcher.matchWithTrailingClosures(call: call, parameters: params)

    XCTAssertEqual(matches.count, 1)
    XCTAssertTrue(matches[0].isTrailingClosure)
    XCTAssertEqual(matches[0].internalName.text, "block")
  }

  func testTrailingClosurePlusDefaultedParameter() throws {
    let call = parseCallWithTrailingClosure(
      "animate()",
      trailingClosure: "{ view.alpha = 0 }"
    )
    let params = parseParameters(
      "func animate(duration: Double = 0.25, _ block: () -> Void) {}"
    )

    let matches = try ArgumentMatcher.matchWithTrailingClosures(call: call, parameters: params)

    XCTAssertEqual(matches.count, 2)

    XCTAssertEqual(matches[0].internalName.text, "duration")
    XCTAssertTrue(matches[0].isDefaulted)
    XCTAssertEqual(matches[0].argument?.trimmedDescription, "0.25")

    XCTAssertEqual(matches[1].internalName.text, "block")
    XCTAssertTrue(matches[1].isTrailingClosure)
  }

  func testTrailingClosurePrefersClosureTypedParameter() throws {
    let call = parseCallWithTrailingClosure("foo()", trailingClosure: "{ print(1) }")
    let params = parseParameters("func foo(_ value: Int = 0, completion: () -> Void) {}")

    let matches = try ArgumentMatcher.matchWithTrailingClosures(call: call, parameters: params)

    XCTAssertEqual(matches.count, 2)
    XCTAssertEqual(matches[0].internalName.text, "value")
    XCTAssertTrue(matches[0].isDefaulted)

    XCTAssertEqual(matches[1].internalName.text, "completion")
    XCTAssertTrue(matches[1].isTrailingClosure)
  }

  func testTrailingClosurePrefersNonVariadicClosureParameterOverVariadic() throws {
    let call = parseCallWithTrailingClosure("foo()", trailingClosure: "{ print(1) }")
    let params = parseParameters(
      "func foo(_ handlers: (() -> Void)..., completion: () -> Void) {}"
    )

    let matches = try ArgumentMatcher.matchWithTrailingClosures(call: call, parameters: params)

    // No variadic arguments were passed; trailing closure binds to `completion`.
    XCTAssertEqual(matches.count, 1)
    XCTAssertEqual(matches[0].internalName.text, "completion")
    XCTAssertTrue(matches[0].isTrailingClosure)
  }

  // SE-0279 multiple trailing closures.

  func testMultipleTrailingClosures() throws {
    let call = parseCallWithMultipleTrailingClosures(
      "foo()",
      trailingClosure: "{ 1 }",
      additionalClosures: [("second", "{ 2 }")]
    )
    let params = parseParameters(
      "func foo(_ first: () -> Int, second: () -> Int) {}"
    )

    let matches = try ArgumentMatcher.matchWithTrailingClosures(call: call, parameters: params)

    XCTAssertEqual(matches.count, 2)

    XCTAssertEqual(matches[0].internalName.text, "first")
    XCTAssertTrue(matches[0].isTrailingClosure)
    XCTAssertFalse(matches[0].isLabeled)

    XCTAssertEqual(matches[1].internalName.text, "second")
    XCTAssertTrue(matches[1].isTrailingClosure)
    XCTAssertTrue(matches[1].isLabeled)
  }

  func testNoTrailingClosuresUsesInlineArguments() throws {
    let call = parseCall("foo(block: { 1 })")
    let params = parseParameters("func foo(block: () -> Int) {}")

    let matches = try ArgumentMatcher.matchWithTrailingClosures(call: call, parameters: params)

    XCTAssertEqual(matches.count, 1)
    XCTAssertFalse(matches[0].isTrailingClosure)
    XCTAssertTrue(matches[0].argument?.trimmedDescription.contains("1") ?? false)
  }

  func testExtraTrailingClosureThrowsError() throws {
    let call = parseCallWithTrailingClosure("foo()", trailingClosure: "{ 1 }")
    let params = parseParameters("func foo() {}")

    XCTAssertThrowsError(
      try ArgumentMatcher.matchWithTrailingClosures(call: call, parameters: params)
    ) { error in
      guard case ArgumentMatchError.extraArguments = error else {
        return XCTFail("Expected extraArguments error, got \(error)")
      }
    }
  }
}

// MARK: - Variadic Parameter Tests

final class ArgumentMatcherVariadicTests: XCTestCase {

  // Basic variadic parameter matching

  func testSingleVariadicArgument() throws {
    let call = parseCall(#"log("Hello")"#)
    let params = parseParameters("func log(_ items: Any...) {}")

    let matches = try ArgumentMatcher.match(call: call, parameters: params)

    XCTAssertEqual(matches.count, 1)
    XCTAssertEqual(matches[0].internalName.text, "items")
    XCTAssertEqual(matches[0].argument?.trimmedDescription, #""Hello""#)
    XCTAssertFalse(matches[0].isLabeled)
  }

  func testMultipleVariadicArguments() throws {
    let call = parseCall(#"log("Hello", 42, true)"#)
    let params = parseParameters("func log(_ items: Any...) {}")

    let matches = try ArgumentMatcher.match(call: call, parameters: params)

    // Returns one match per argument, all pointing to the same variadic param
    XCTAssertEqual(matches.count, 3)
    XCTAssertEqual(matches[0].internalName.text, "items")
    XCTAssertEqual(matches[0].argument?.trimmedDescription, #""Hello""#)
    XCTAssertEqual(matches[1].argument?.trimmedDescription, "42")
    XCTAssertEqual(matches[2].argument?.trimmedDescription, "true")
  }

  func testEmptyVariadicParameter() throws {
    let call = parseCall("foo()")
    let params = parseParameters("func foo(_ items: Int...) {}")

    let matches = try ArgumentMatcher.match(call: call, parameters: params)

    // No arguments provided, variadic is empty - no matches returned
    XCTAssertTrue(matches.isEmpty)
  }

  func testMixedFixedAndVariadicParameters() throws {
    let call = parseCall(#"print("Debug:", 1, 2, 3)"#)
    let params = parseParameters("func print(_ prefix: String, _ values: Int...) {}")

    let matches = try ArgumentMatcher.match(call: call, parameters: params)

    XCTAssertEqual(matches.count, 4)
    XCTAssertEqual(matches[0].internalName.text, "prefix")
    XCTAssertEqual(matches[0].argument?.trimmedDescription, #""Debug:""#)
    XCTAssertEqual(matches[1].internalName.text, "values")
    XCTAssertEqual(matches[2].internalName.text, "values")
    XCTAssertEqual(matches[3].internalName.text, "values")
  }

  func testVariadicWithLabeledParameterAfter() throws {
    let call = parseCall("foo(1, 2, 3, end: true)")
    let params = parseParameters("func foo(_ values: Int..., end: Bool) {}")

    let matches = try ArgumentMatcher.match(call: call, parameters: params)

    XCTAssertEqual(matches.count, 4)
    XCTAssertEqual(matches[0].internalName.text, "values")
    XCTAssertEqual(matches[1].internalName.text, "values")
    XCTAssertEqual(matches[2].internalName.text, "values")
    XCTAssertEqual(matches[3].internalName.text, "end")
    XCTAssertEqual(matches[3].argument?.trimmedDescription, "true")
    XCTAssertTrue(matches[3].isLabeled)
  }

  // matchFull for proper 1:n variadic representation

  func testMatchFullWithVariadicParameter() throws {
    let call = parseCall(#"log("Hello", 42, true)"#)
    let params = parseParameters("func log(_ items: Any...) {}")

    let matches = try ArgumentMatcher.matchFull(call: call, parameters: params)

    XCTAssertEqual(matches.count, 1)

    guard case .variadic(let variadicMatch) = matches[0] else {
      return XCTFail("Expected variadic match")
    }

    XCTAssertEqual(variadicMatch.internalName.text, "items")
    XCTAssertEqual(variadicMatch.arguments.count, 3)
    XCTAssertTrue(variadicMatch.arguments[0].isExplicit)
    XCTAssertEqual(variadicMatch.arguments[0].expression?.trimmedDescription, #""Hello""#)
    XCTAssertEqual(variadicMatch.arguments[1].expression?.trimmedDescription, "42")
    XCTAssertEqual(variadicMatch.arguments[2].expression?.trimmedDescription, "true")
  }

  func testMatchFullWithEmptyVariadic() throws {
    let call = parseCall("foo()")
    let params = parseParameters("func foo(_ items: Int...) {}")

    let matches = try ArgumentMatcher.matchFull(call: call, parameters: params)

    XCTAssertEqual(matches.count, 1)

    guard case .variadic(let variadicMatch) = matches[0] else {
      return XCTFail("Expected variadic match")
    }

    XCTAssertTrue(variadicMatch.arguments.isEmpty)
  }

  func testMatchFullMixedFixedAndVariadic() throws {
    let call = parseCall(#"print("prefix", 1, 2)"#)
    let params = parseParameters("func print(_ prefix: String, _ values: Int...) {}")

    let matches = try ArgumentMatcher.matchFull(call: call, parameters: params)

    XCTAssertEqual(matches.count, 2)

    guard case .single(let prefixMatch) = matches[0] else {
      return XCTFail("Expected single match for prefix")
    }
    XCTAssertEqual(prefixMatch.internalName.text, "prefix")
    XCTAssertTrue(prefixMatch.source.isExplicit)

    guard case .variadic(let valuesMatch) = matches[1] else {
      return XCTFail("Expected variadic match for values")
    }
    XCTAssertEqual(valuesMatch.arguments.count, 2)
  }

  func testMatchFullWithDefaultAndVariadic() throws {
    let call = parseCall("foo(1, 2)")
    let params = parseParameters("func foo(_ values: Int..., separator: String = \",\") {}")

    let matches = try ArgumentMatcher.matchFull(call: call, parameters: params)

    XCTAssertEqual(matches.count, 2)

    guard case .variadic(let variadicMatch) = matches[0] else {
      return XCTFail("Expected variadic match")
    }
    XCTAssertEqual(variadicMatch.arguments.count, 2)

    guard case .single(let defaultMatch) = matches[1] else {
      return XCTFail("Expected single match for separator")
    }
    XCTAssertTrue(defaultMatch.source.isDefaultValue)
    XCTAssertEqual(defaultMatch.argument?.trimmedDescription, "\",\"")
  }

  func testMatchFullTrailingClosurePrefersClosureTypedParameter() throws {
    let call = parseCallWithTrailingClosure("foo()", trailingClosure: "{ print(1) }")
    let params = parseParameters("func foo(_ value: Int = 0, completion: () -> Void) {}")

    let matches = try ArgumentMatcher.matchFull(call: call, parameters: params)

    XCTAssertEqual(matches.count, 2)

    guard case .single(let valueMatch) = matches[0] else {
      return XCTFail("Expected single match for value")
    }
    XCTAssertTrue(valueMatch.isDefaulted)

    guard case .single(let completionMatch) = matches[1] else {
      return XCTFail("Expected single match for completion")
    }
    XCTAssertTrue(completionMatch.isTrailingClosure)
    XCTAssertEqual(completionMatch.internalName.text, "completion")
  }

  func testMatchFullTrailingClosurePrefersNonVariadicClosureParameterOverVariadic() throws {
    let call = parseCallWithTrailingClosure("foo()", trailingClosure: "{ print(1) }")
    let params = parseParameters(
      "func foo(_ handlers: (() -> Void)..., completion: () -> Void) {}"
    )

    let matches = try ArgumentMatcher.matchFull(call: call, parameters: params)

    XCTAssertEqual(matches.count, 2)

    guard case .variadic(let handlersMatch) = matches[0] else {
      return XCTFail("Expected variadic match for handlers")
    }
    XCTAssertTrue(handlersMatch.arguments.isEmpty)

    guard case .single(let completionMatch) = matches[1] else {
      return XCTFail("Expected single match for completion")
    }
    XCTAssertEqual(completionMatch.internalName.text, "completion")
    XCTAssertTrue(completionMatch.isTrailingClosure)
  }

  func testMatchFullDuplicateLabeledArgumentThrowsError() throws {
    let call = parseCall("foo(x: 1, x: 2)")
    let params = parseParameters("func foo(x: Int, y: Int = 0) {}")

    XCTAssertThrowsError(try ArgumentMatcher.matchFull(call: call, parameters: params)) { error in
      guard case ArgumentMatchError.extraArguments = error else {
        return XCTFail("Expected extraArguments error, got \(error)")
      }
    }
  }
}

// MARK: - ArgumentSource Tests

final class ArgumentSourceTests: XCTestCase {

  func testExplicitSource() throws {
    let call = parseCall("foo(x: 1)")
    let params = parseParameters("func foo(x: Int) {}")

    let matches = try ArgumentMatcher.matchFull(call: call, parameters: params)

    guard case .single(let match) = matches[0] else {
      return XCTFail("Expected single match")
    }

    XCTAssertTrue(match.source.isExplicit)
    XCTAssertFalse(match.source.isDefaultValue)
    XCTAssertFalse(match.source.isSynthesized)
    XCTAssertNotNil(match.source.expression)
  }

  func testDefaultValueSource() throws {
    let call = parseCall("foo()")
    let params = parseParameters("func foo(x: Int = 42) {}")

    let matches = try ArgumentMatcher.matchFull(call: call, parameters: params)

    guard case .single(let match) = matches[0] else {
      return XCTFail("Expected single match")
    }

    XCTAssertFalse(match.source.isExplicit)
    XCTAssertTrue(match.source.isDefaultValue)
    XCTAssertFalse(match.source.isSynthesized)
    XCTAssertNotNil(match.source.expression)
    XCTAssertEqual(match.source.expression?.trimmedDescription, "42")
  }
}

// MARK: - Subscript Matching Tests

final class ArgumentMatcherSubscriptTests: XCTestCase {

  // Note: In Swift subscripts, `subscript(row row: Int)` syntax is required for external labels.
  // Unlike functions where `func f(x: Int)` makes `x` an external label,
  // subscripts use `subscript(x: Int)` where `x` is internal-only.

  func testLabeledSubscriptMatching() throws {
    // Subscript with explicit external labels (row row: Int syntax)
    let args = parseSubscriptArgs("matrix[row: 0, col: 1]")
    let params = parseParameters("subscript(row row: Int, col col: Int) -> Int { get {} }")

    let matches = try ArgumentMatcher.matchSubscript(arguments: args, parameters: params)

    XCTAssertEqual(matches.count, 2)

    guard case .single(let rowMatch) = matches[0] else {
      return XCTFail("Expected single match for row")
    }
    XCTAssertEqual(rowMatch.internalName.text, "row")
    XCTAssertEqual(rowMatch.argument?.trimmedDescription, "0")

    guard case .single(let colMatch) = matches[1] else {
      return XCTFail("Expected single match for col")
    }
    XCTAssertEqual(colMatch.internalName.text, "col")
    XCTAssertEqual(colMatch.argument?.trimmedDescription, "1")
  }

  func testPositionalSubscriptMatching() throws {
    let args = parseSubscriptArgs("array[0]")
    let params = parseParameters("subscript(_ index: Int) -> Element { get {} }")

    let matches = try ArgumentMatcher.matchSubscript(arguments: args, parameters: params)

    XCTAssertEqual(matches.count, 1)

    guard case .single(let match) = matches[0] else {
      return XCTFail("Expected single match")
    }
    XCTAssertEqual(match.internalName.text, "index")
    XCTAssertFalse(match.isLabeled)
  }

  func testVariadicSubscriptMatching() throws {
    let args = parseSubscriptArgs("multi[1, 2, 3]")
    let params = parseParameters("subscript(_ indices: Int...) -> [Element] { get {} }")

    let matches = try ArgumentMatcher.matchSubscript(arguments: args, parameters: params)

    XCTAssertEqual(matches.count, 1)

    guard case .variadic(let variadicMatch) = matches[0] else {
      return XCTFail("Expected variadic match")
    }
    XCTAssertEqual(variadicMatch.arguments.count, 3)
    XCTAssertEqual(variadicMatch.internalName.text, "indices")
  }
}

// MARK: - Closure Call Matching Tests

final class ArgumentMatcherClosureCallTests: XCTestCase {

  func testClosureCallDuplicateLabeledArgumentThrowsError() throws {
    let call = parseCall("closure(x: 1, x: 2)")
    let params = parseClosureParameters("(x: Int) in")

    XCTAssertThrowsError(try ArgumentMatcher.matchClosureCall(call: call, parameters: params)) {
      error in
      guard case ArgumentMatchError.extraArguments = error else {
        return XCTFail("Expected extraArguments error, got \(error)")
      }
    }
  }
}

// MARK: - Helpers

private func parseCall(_ source: String) -> FunctionCallExprSyntax {
  let src = "let _ = \(source)"
  let sf = Parser.parse(source: src)
  let varDecl = sf.statements.first!.item.cast(VariableDeclSyntax.self)
  return varDecl.bindings.first!.initializer!.value.cast(FunctionCallExprSyntax.self)
}

private func parseCallWithTrailingClosure(
  _ callSource: String,
  trailingClosure: String
) -> FunctionCallExprSyntax {
  let src = "let _ = \(callSource) \(trailingClosure)"
  let sf = Parser.parse(source: src)
  let varDecl = sf.statements.first!.item.cast(VariableDeclSyntax.self)
  return varDecl.bindings.first!.initializer!.value.cast(FunctionCallExprSyntax.self)
}

private func parseCallWithMultipleTrailingClosures(
  _ callSource: String,
  trailingClosure: String,
  additionalClosures: [(label: String, closure: String)]
) -> FunctionCallExprSyntax {
  var src = "let _ = \(callSource) \(trailingClosure)"
  for (label, closure) in additionalClosures {
    src += " \(label): \(closure)"
  }
  let sf = Parser.parse(source: src)
  let varDecl = sf.statements.first!.item.cast(VariableDeclSyntax.self)
  return varDecl.bindings.first!.initializer!.value.cast(FunctionCallExprSyntax.self)
}

private func parseParameters(_ source: String) -> FunctionParameterListSyntax {
  let sf = Parser.parse(source: source)
  // Try function first
  if let funcDecl = sf.statements.first?.item.as(FunctionDeclSyntax.self) {
    return funcDecl.signature.parameterClause.parameters
  }
  // Then try subscript
  if let subscriptDecl = sf.statements.first?.item.as(SubscriptDeclSyntax.self) {
    return subscriptDecl.parameterClause.parameters
  }
  fatalError("Could not parse parameters from: \(source)")
}

private func parseSubscriptArgs(_ source: String) -> LabeledExprListSyntax {
  let src = "let _ = \(source)"
  let sf = Parser.parse(source: src)
  let varDecl = sf.statements.first!.item.cast(VariableDeclSyntax.self)
  let subscriptExpr = varDecl.bindings.first!.initializer!.value.cast(SubscriptCallExprSyntax.self)
  return subscriptExpr.arguments
}

private func parseClosureParameters(_ closureSignature: String) -> ClosureParameterListSyntax {
  let src = "let closure = { \(closureSignature) _ = 0 }"
  let sf = Parser.parse(source: src)
  let varDecl = sf.statements.first!.item.cast(VariableDeclSyntax.self)
  let closureExpr = varDecl.bindings.first!.initializer!.value.cast(ClosureExprSyntax.self)
  guard
    let signature = closureExpr.signature,
    let parameterClause = signature.parameterClause?.as(ClosureParameterClauseSyntax.self)
  else {
    fatalError("Could not parse closure parameters from: \(closureSignature)")
  }
  return parameterClause.parameters
}

extension SyntaxProtocol {
  fileprivate var trimmedDescription: String {
    description.trimmingCharacters(in: .whitespaces)
  }
}
