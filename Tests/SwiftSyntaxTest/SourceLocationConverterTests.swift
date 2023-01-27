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

import XCTest
@_spi(RawSyntax) import SwiftSyntax

final class SourceLocationConverterTests: XCTestCase {
  func testInvalidUtf8() {
    let eofToken = withExtendedLifetime(SyntaxArena()) { arena in
      let leadingTriviaText = [UInt8(0xfd)].withUnsafeBufferPointer { buf in
        arena.intern(SyntaxText(buffer: buf))
      }

      let nodeWithInvalidUtf8 = RawTokenSyntax(
        kind: .eof,
        text: "",
        leadingTriviaPieces: [
          .unexpectedText(leadingTriviaText)
        ],
        presence: .present,
        arena: arena
      )

      return Syntax(raw: nodeWithInvalidUtf8.raw).cast(TokenSyntax.self)
    }

    let tree = SourceFileSyntax(statements: [], eofToken: eofToken)

    // This used to violate the following assertion in the SourceLocationConverter's
    // initializer, because we were using `String` which was lossy when handling the
    // invalid UTF-8:
    // ```
    // assert(tree.byteSize == endOfFile.utf8Offset)
    // ```
    _ = SourceLocationConverter(file: "", tree: tree)
  }
}
