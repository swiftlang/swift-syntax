import XCTest
import SwiftSyntaxTest

XCTMain({ () -> [XCTestCaseEntry] in
  var testCases: [XCTestCaseEntry] = [
    testCase(AbsolutePositionTestCase.allTests),
    testCase(DiagnosticTestCase.allTests),
    testCase(IncrementalParsingTestCase.allTests),
    // We need to make syntax node thread safe to enable these tests
    // testCase(LazyCachingTestCase.allTests),
    testCase(ParseFileTestCase.allTests),
    testCase(SyntaxChildrenAPITestCase.allTests),
    testCase(SyntaxCollectionsAPITestCase.allTests),
    testCase(SyntaxFactoryAPITestCase.allTests),
    testCase(SyntaxAPITestCase.allTests),
    testCase(SyntaxVisitorTestCase.allTests),
  ]
  return testCases
}())
