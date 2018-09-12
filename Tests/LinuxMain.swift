import XCTest
import SwiftSyntaxTest

XCTMain([
  testCase(AbsolutePositionTestCase.allTests),
  testCase(DecodeSyntaxTestCase.allTests),
  testCase(DiagnosticTestCase.allTests),
  testCase(LazyCachingTestCase.allTests),
  testCase(ParseFileTestCase.allTests),
  testCase(SyntaxChildrenAPITestCase.allTests),
  testCase(SyntaxCollectionsAPITestCase.allTests),
  testCase(SyntaxFactoryAPITestCase.allTests),
  testCase(SyntaxVisitorTestCase.allTests),
])
