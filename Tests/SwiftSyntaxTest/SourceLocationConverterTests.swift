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
import _SwiftSyntaxTestSupport

fileprivate func assertPresumedSourceLocation(
  _ source: SourceFileSyntax,
  inspectionItemFilter: (CodeBlockItemSyntax.Item) -> (some SyntaxProtocol)? = { $0.as(VariableDeclSyntax.self) },
  presumedFile: String,
  presumedLine: Int,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  let converter = SourceLocationConverter(fileName: "input.swift", tree: source)

  guard let variableDecl = source.statements.compactMap({ inspectionItemFilter($0.item) }).first else {
    XCTFail("Could not find a node that matches the `inspectionItemFilter` in `source`", file: file, line: line)
    return
  }
  let location = converter.location(for: variableDecl.positionAfterSkippingLeadingTrivia)
  XCTAssertEqual(presumedFile, location.presumedFile, "presumed file did not match", file: file, line: line)
  XCTAssertEqual(presumedLine, location.presumedLine, "presumed line did not match", file: file, line: line)
}

final class SourceLocationConverterTests: XCTestCase {
  func testInvalidUtf8() {
    let eofToken = withExtendedLifetime(ParsingSyntaxArena(parseTriviaFunction: dummyParseToken)) { arena in
      let leadingTriviaText = [UInt8(0xfd)].withUnsafeBufferPointer { buf in
        arena.intern(SyntaxText(buffer: SyntaxArenaAllocatedBufferPointer(buf)))
      }

      let nodeWithInvalidUtf8 = RawTokenSyntax(
        kind: .endOfFile,
        text: "",
        leadingTriviaPieces: [
          .unexpectedText(leadingTriviaText)
        ],
        presence: .present,
        arena: arena
      )

      return Syntax(raw: nodeWithInvalidUtf8.raw, rawNodeArena: arena).cast(TokenSyntax.self)
    }

    let tree = SourceFileSyntax(statements: [], endOfFileToken: eofToken)

    // This used to violate the following assertion in the SourceLocationConverter's
    // initializer, because we were using `String` which was lossy when handling the
    // invalid UTF-8:
    // ```
    // assert(tree.byteSize == endOfFile.utf8Offset)
    // ```
    _ = SourceLocationConverter(fileName: "", tree: tree)
  }

  func testSingleSourceLocationDirective() {
    assertPresumedSourceLocation(
      """
      #sourceLocation(file: "other.swift", line: 1)
      let a = 2
      """,
      presumedFile: "other.swift",
      presumedLine: 1
    )

    assertPresumedSourceLocation(
      """
      #sourceLocation(file: "other.swift", line: 3)
      let a = 2
      """,
      presumedFile: "other.swift",
      presumedLine: 3
    )

    assertPresumedSourceLocation(
      """
      #sourceLocation(file: "other.swift", line: 4)
      func foo() {
      }
      let a = 2
      """,
      presumedFile: "other.swift",
      presumedLine: 6
    )

    assertPresumedSourceLocation(
      """
      func foo() {
        print(1)
      }
      #sourceLocation(file: "other.swift", line: 1)
      let a = 2
      """,
      presumedFile: "other.swift",
      presumedLine: 1
    )
  }

  func testMultipleSourceLocationDirectives() {
    assertPresumedSourceLocation(
      """
      #sourceLocation(file: "other.swift", line: 10)

      let a = 2

      #sourceLocation(file: "andAnother.swift", line: 20)
      """,
      presumedFile: "other.swift",
      presumedLine: 11
    )

    assertPresumedSourceLocation(
      """
      #sourceLocation(file: "other.swift", line: 10)

      #sourceLocation(file: "andAnother.swift", line: 20)

      let a = 2
      """,
      presumedFile: "andAnother.swift",
      presumedLine: 21
    )
  }

  func testResetSourceLocationDirective() {
    assertPresumedSourceLocation(
      """
      #sourceLocation(file: "other.swift", line: 10)

      #sourceLocation()

      let a = 2
      """,
      presumedFile: "input.swift",
      presumedLine: 5
    )
  }

  func testHexLineNumber() {
    // We ignore `#sourceLocation` directives with a non-decimal line number
    assertPresumedSourceLocation(
      """
      #sourceLocation(file: "other.swift", line: 0x10)

      let a = 2
      """,
      presumedFile: "input.swift",
      presumedLine: 3
    )
  }

  func testStringInterpolationInFilename() {
    // We ignore `#sourceLocation` directives that have string interpolation in their file names
    assertPresumedSourceLocation(
      #"""
      #sourceLocation(file: "other\(1).swift", line: 10)

      let a = 2
      """#,
      presumedFile: "input.swift",
      presumedLine: 3
    )
  }

  func testMultiLineDirective() {
    assertPresumedSourceLocation(
      #"""
      #sourceLocation(
        file: "input.swift",
        line: 10
      )

      let a = 2
      """#,
      presumedFile: "input.swift",
      presumedLine: 11
    )
  }

  func testDirectiveWithTrailingBlockComment() {
    assertPresumedSourceLocation(
      #"""
      #sourceLocation(file: "input.swift", line: 10) /*
        comment
      */

      let a = 2
      """#,
      presumedFile: "input.swift",
      presumedLine: 13
    )
  }
  func testMultiLineStringLiteralAsFilename() {
    // FIXME: The current parser handles this fine but it’s a really bogus filename.
    // We ignore the directive because the multi-line string literal contains multiple segments.
    // We should probably justs disallow multi-line string literals for the `file` argument.
    // cf https://github.com/apple/swift-syntax/issues/1831
    assertPresumedSourceLocation(
      #"""
      #sourceLocation(file: """
      test.swift
      other.swift
      """, line: 10)

      let a = 2
      """#,
      presumedFile: "input.swift",
      presumedLine: 6
    )
  }

}
