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
    XCTAssertEqual(widthMatch.argument.trimmedDescription, "100")
    XCTAssertTrue(widthMatch.isLabeled)

    let heightMatch = try XCTUnwrap(matches.last)
    XCTAssertEqual(heightMatch.internalName.text, "height")
    XCTAssertEqual(heightMatch.argument.trimmedDescription, "200")
    XCTAssertTrue(heightMatch.isLabeled)
  }

  func testSingleLabeledArgument() throws {
    let call = parseCall("foo(bar: 42)")
    let params = parseParameters("func foo(bar: Int) {}")

    let matches = try ArgumentMatcher.match(call: call, parameters: params)

    XCTAssertEqual(matches.count, 1)
    XCTAssertEqual(matches[0].internalName.text, "bar")
    XCTAssertEqual(matches[0].argument.trimmedDescription, "42")
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
    XCTAssertEqual(matches[0].argument.trimmedDescription, #""World""#)
    XCTAssertFalse(matches[0].isLabeled)
  }

  func testMultiplePositionalArguments() throws {
    let call = parseCall("add(1, 2)")
    let params = parseParameters("func add(_ lhs: Int, _ rhs: Int) -> Int {}")

    let matches = try ArgumentMatcher.match(call: call, parameters: params)

    XCTAssertEqual(matches.count, 2)
    XCTAssertEqual(matches[0].internalName.text, "lhs")
    XCTAssertEqual(matches[0].argument.trimmedDescription, "1")
    XCTAssertFalse(matches[0].isLabeled)
    XCTAssertEqual(matches[1].internalName.text, "rhs")
    XCTAssertEqual(matches[1].argument.trimmedDescription, "2")
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
    XCTAssertEqual(matches[0].argument.trimmedDescription, "target")
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
      guard case ArgumentMatchError.missingArgument(let param) = error else {
        return XCTFail("Expected missingArgument error, got \(error)")
      }
      XCTAssertEqual(param.firstName.text, "x")
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

private func parseParameters(_ source: String) -> FunctionParameterListSyntax {
  let sf = Parser.parse(source: source)
  return sf.statements.first!.item.cast(FunctionDeclSyntax.self).signature.parameterClause.parameters
}

extension SyntaxProtocol {
  fileprivate var trimmedDescription: String {
    description.trimmingCharacters(in: .whitespaces)
  }
}
