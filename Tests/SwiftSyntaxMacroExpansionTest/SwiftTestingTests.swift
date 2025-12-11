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

#if canImport(Testing)
import Testing
import SwiftSyntaxMacrosTestSupport

@Suite("Swift Testing Macro Expansion Tests")
struct SwiftTestingMacroExpansionTests {
  @Test("Test Happy Path")
  func testHappyPathWorks() {
    assertMacroExpansion(
      """
      @constantOne
      var x: Int /*1*/ // hello
      """,
      expandedSource: """
        var x: Int { /*1*/ // hello
          get {
            return 1
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: .spaces(2)
    )
  }

  @Test("Test Failure")
  func failureReportedCorrectly() {
    withKnownIssue {
      assertMacroExpansion(
        """
        @constantOne
        var x: Int /*1*/ // hello
        """,
        expandedSource: """
          var x: Int { /*1*/ // hello
            get {
              return 1
            }
          }
          """,
        macros: ["constantOne": ConstantOneGetter.self],
        indentationWidth: .spaces(4)
      )
    } matching: { issue in
      issue.description.contains("Macro expansion did not produce the expected expanded source")
    }
  }
}
#endif
