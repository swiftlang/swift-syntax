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
