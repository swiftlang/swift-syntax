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

import SwiftParser
import SwiftRefactor
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest
import _SwiftSyntaxTestSupport

final class FormatRawStringLiteralTest: XCTestCase {
  func testDelimiterPlacement() throws {
    let tests = [
      (#line, literal: #" "Hello World" "#, expectation: #" "Hello World" "#),
      (#line, literal: ##" #"Hello World" "##, expectation: #" "Hello World" "#),
      (#line, literal: ##" #"Hello World"# "##, expectation: #" "Hello World" "#),
      (#line, literal: #####" "####" "#####, expectation: #####" "####" "#####),
      (#line, literal: #####" #"####"# "#####, expectation: #####" "####" "#####),
      (#line, literal: #####" #"\####(hello)"# "#####, expectation: ######" #####"\####(hello)"##### "######),
      (
        #line, literal: #######" #"###### \####(hello) ##"# "#######,
        expectation: ########" #######"###### \####(hello) ##"####### "########
      ),
      (#line, literal: ########" #######"hello \(world) "####### "########, expectation: ##" #"hello \(world) "# "##),
      // Content containing a `"` would terminate the literal early or fuse
      // with the surrounding quote token if pounds were removed.
      (#line, literal: ##" #"""# "##, expectation: ##" #"""# "##),
      (#line, literal: ##" #"He says "Hi""# "##, expectation: ##" #"He says "Hi""# "##),
      // `\` escape semantics differ between raw and non-raw literals; the
      // stripped form would either be an invalid escape (`\U`) or change
      // meaning silently (`\n`).
      (#line, literal: ##" #"C:\Users"# "##, expectation: ##" #"C:\Users"# "##),
      // `\#n` is a 1-hash raw escape for newline; in non-raw, `\#` is an
      // invalid escape sequence, so the pound delimiter has to stay.
      (#line, literal: ##" #"line1\#nline2"# "##, expectation: ##" #"line1\#nline2"# "##),
    ]

    for (line, literal, expectation) in tests {
      let literal = try XCTUnwrap(StringLiteralExprSyntax.parseWithoutDiagnostics(from: literal))
      let expectation = try XCTUnwrap(StringLiteralExprSyntax.parseWithoutDiagnostics(from: expectation))
      try assertRefactor(
        literal,
        context: (),
        provider: FormatRawStringLiteral.self,
        expected: expectation,
        line: UInt(line)
      )
    }
  }
}

extension StringLiteralExprSyntax {
  static func parseWithoutDiagnostics(from source: String) -> StringLiteralExprSyntax? {
    var parser = Parser(source)
    return ExprSyntax.parse(from: &parser).as(StringLiteralExprSyntax.self)
  }
}
