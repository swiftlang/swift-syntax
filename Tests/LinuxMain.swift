import XCTest
import SwiftSyntaxTest

XCTMain({ () -> [XCTestCaseEntry] in
  var testCases: [XCTestCaseEntry] = [
    testCase(AbsolutePositionTestCase.allTests),
    testCase(DiagnosticTestCase.allTests),
    testCase(IncrementalParsingTestCase.allTests),
    testCase(MultithreadingTestCase.allTests),
    testCase(ParseFileTestCase.allTests),
    testCase(SyntaxChildrenAPITestCase.allTests),
    testCase(SyntaxCollectionsAPITestCase.allTests),
    testCase(SyntaxFactoryAPITestCase.allTests),
    testCase(SyntaxAPITestCase.allTests),
    testCase(SyntaxVisitorTestCase.allTests),
    testCase(TokenSyntaxTestCase.allTests),
    testCase(SyntaxTreeModifierTests.allTests),
  ]
  return testCases
}())
