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

import _SwiftSyntaxTestSupport
import XCTest
@_spi(RawSyntax) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax

func assertCompletions<S: Sequence>(
  _ markedSource: String,
  at locationMarker: String = "1️⃣",
  _ expectedCompletions: S,
  file: StaticString = #file,
  line: UInt = #line
) where S.Element == String {
  // Verify the parser can round-trip the source
  let (markerLocations, source) = extractMarkers(markedSource)

  guard let markerLoc = markerLocations[locationMarker] else {
    XCTFail("Did not find marker \(locationMarker) in the source code", file: file, line: line)
    return
  }

  var src = source
  src.withUTF8 { buf in
    var parser = Parser(buf)
    withExtendedLifetime(parser) {
      let tree = Syntax(raw: parser.parseSourceFile().raw)

      let completions = tree.completions(at: AbsolutePosition(utf8Offset: markerLoc))
      let completionStrs = Set(completions.compactMap({ $0.text }).filter({ $0 != "" }))
      if completionStrs != Set(expectedCompletions) {
        failStringsEqualWithDiff(
          completionStrs.sorted().joined(separator: "\n"),
          expectedCompletions.sorted().joined(separator: "\n"),
          file: file,
          line: line
        )
      }
    }
  }
}

public class KeywordCompletionTests: XCTestCase {
  let expressionCompletions = [
    #"""#,
    #"""""#,
    "#",
    "#else",
    "#elseif",
    "#endif",
    "#if",
    "&",
    "'",  // FIXME: "'" is for recovery only. We shouldn't be suggesting it
    "(",
    "->",
    ".",
    "/",
    "<",
    "=",
    "?",
    "@",
    "Any",
    "Self",
    "[",
    #"\"#,
    "_",
    "__owned",
    "__shared",
    "_borrow",
    "_const",
    "_move",
    "any",
    "as",
    "async",
    "await",
    "borrowing",
    "class",
    "consume",
    "consuming",
    "each",
    "false",
    "if",
    "init",
    "inout",
    "is",
    "isolated",
    "let",
    "repeat",
    "nil",
    "self",
    "some",
    "super",
    "switch",
    "throws",
    "true",
    "try",
    "var",
    "{",
  ]

  let topLevelCompletions = [
    #"""#,
    #"""""#,
    "#",
    "#assert",
    "#colorLiteral",
    "#column",
    "#dsohandle",
    "#else",
    "#elseif",
    "#endif",
    "#error",
    "#file",
    "#fileID",
    "#fileLiteral",
    "#filePath",
    "#function",
    "#if",
    "#imageLiteral",
    "#keyPath",
    "#line",
    "#selector",
    "#sourceLocation",
    "#warning",
    "&",
    "'",  // FIXME: "'" is for recovery only. We shouldn't be suggesting it
    "(",
    "->",
    ".",
    "/",
    "<",
    "=",
    "?",
    "@",
    "Any",
    "Self",
    "[",
    #"\"#,
    "_",
    "__owned",
    "__shared",
    "_borrow",
    "_const",
    "_move",
    "actor",
    "any",
    "as",
    "associatedtype",
    "async",
    "await",
    "borrowing",
    "break",
    "case",
    "class",
    "consume",
    "consuming",
    "each",
    "continue",
    "defer",
    "deinit",
    "do",
    "enum",
    "extension",
    "fallthrough",
    "false",
    "if",
    "init",
    "inout",
    "for",
    "func",
    "guard",
    "if",
    "import",
    "init",
    "is",
    "isolated",
    "let",
    "nil",
    "repeat",
    "operator",
    "precedencegroup",
    "protocol",
    "repeat",
    "return",
    "self",
    "some",
    "struct",
    "subscript",
    "super",
    "switch",
    "throw",
    "throws",
    "true",
    "try",
    "typealias",
    "var",
    "while",
    "yield",
    "{",
  ]

  func testExpressionCompletions() {
    assertCompletions("let x = 1️⃣2", expressionCompletions)
  }

  func testExpressionCompletionsAtEndOfFile() {
    assertCompletions("let x = 1️⃣", expressionCompletions)
  }

  func testAtStartOfFile() {
    assertCompletions("1️⃣ let x = 2", topLevelCompletions)
  }

  func testEmptyFile() {
    assertCompletions("1️⃣", topLevelCompletions)
  }

  func testInFunctionSignature() {
    assertCompletions(
      "func foo(x: Int 1️⃣",
      [
        ")",
        ",",
        "...",
        "<",
        "=",
      ]
    )
  }

  func testTypeMember() {
    assertCompletions(
      """
      class Foo {
        1️⃣
      }
      """,
      [
        "#",
        "#else",
        "#elseif",
        "#endif",
        "#if",
        "#sourceLocation",
        "@",
        "__consuming",
        "__setter_access",
        "_const",
        "_local",
        "_modify",
        "_read",
        "actor",
        "addressWithNativeOwner",
        "addressWithOwner",
        "associatedtype",
        "async",
        "borrowing",
        "case",
        "class",
        "consuming",
        "convenience",
        "deinit",
        "didSet",
        "distributed",
        "dynamic",
        "enum",
        "extension",
        "fileprivate",
        "final",
        "func",
        "get",
        "import",
        "indirect",
        "infix",
        "init",
        "inout",
        "internal",
        "isolated",
        "lazy",
        "let",
        "macro",
        "mutableAddressWithNativeOwner",
        "mutableAddressWithOwner",
        "mutating",
        "nonisolated",
        "nonmutating",
        "open",
        "operator",
        "optional",
        "override",
        "package",
        "postfix",
        "precedencegroup",
        "prefix",
        "private",
        "protocol",
        "public",
        "reasync",
        "required",
        "set",
        "static",
        "struct",
        "subscript",
        "typealias",
        "unowned",
        "unsafeAddress",
        "unsafeMutableAddress",
        "var",
        "weak",
        "willSet",
        "}",
      ]
    )
  }

  func testAfterVariable() {
    assertCompletions("let x1️⃣", [",", ":", "=", "{"])
  }
}
