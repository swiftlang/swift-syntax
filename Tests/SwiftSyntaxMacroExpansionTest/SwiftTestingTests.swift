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
        indentationWidth: .spaces(4),
        fileID: "ExampleModule/ExampleTest.swift",
        file: "path/to/ExampleTest.swift",
        line: 9999,
        column: 8888
      )
    } matching: { issue in
      guard issue.description.contains("Macro expansion did not produce the expected expanded source") else {
        return false
      }

      #expect(issue.sourceLocation == .init(
        fileID: "ExampleModule/ExampleTest.swift",
        filePath: "path/to/ExampleTest.swift",
        line: 9999,
        column: 8888
      ))

      return true
    }
  }
}
#endif
