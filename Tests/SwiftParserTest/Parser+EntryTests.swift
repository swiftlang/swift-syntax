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

import SwiftSyntax
import SwiftParser
import XCTest

public class EntryTests: XCTestCase {
  func testTopLevelStringParse() throws {
    AssertParse("func test() {}", { Parser.parse(source: $0) })
  }

  func testTopLevelBufferParse() throws {
    AssertParse(
      "func test() {}",
      { (source: String) -> SourceFileSyntax in
        var source = source
        source.makeContiguousUTF8()
        return source.withUTF8 { Parser.parse(source: $0) }
      }
    )
  }

  func testSyntaxParse() throws {
    AssertParse(
      "func test() {}",
      { DeclSyntax.parse(from: &$0) }
    )
  }

  func testRemainderUnexpected() throws {
    AssertParse(
      "func test() {} 1️⃣other tokens",
      { DeclSyntax.parse(from: &$0) },
      diagnostics: [DiagnosticSpec(message: "unexpected code 'other tokens' in function")]
    )
  }
}
