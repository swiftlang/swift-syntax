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

// This test file has been translated from swift/test/Parse/hashbang_library.swift

import SwiftSyntax
import XCTest

final class HashbangLibraryTests: ParserTestCase {
  func testHashbangLibrary1() {
    // Check that we diagnose and skip the hashbang at the beginning of the file
    // when compiling in library mode.
    assertParse(
      """
      #!/usr/bin/swift
      class Foo {}
      """,
      substructure: SourceFileSyntax(
        shebang: .shebang("#!/usr/bin/swift"),
        statements: CodeBlockItemListSyntax([
          CodeBlockItemSyntax(
            item: .decl(
              DeclSyntax(
                ClassDeclSyntax(
                  classHeader: ClassDeclHeaderSyntax(
                    classKeyword: .keyword(
                      .class,
                      leadingTrivia: [
                        .newlines(1)
                      ],
                      trailingTrivia: .space
                    ),
                    name: .identifier("Foo", trailingTrivia: .space)
                  ),
                  memberBlock: MemberBlockSyntax(
                    members: MemberBlockItemListSyntax([])
                  )
                )
              )
            )
          )
        ]),
        endOfFileToken: .endOfFileToken()
      ),
      options: [.substructureCheckTrivia]
    )
  }
}
