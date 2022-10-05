import SwiftSyntaxBuilder
import _SwiftSyntaxTestSupport

import XCTest

func AssertBuildResult<T: SyntaxBuildable>(_ buildable: T, _ expectedResult: String, file: StaticString = #file, line: UInt = #line) {
  AssertStringsEqualWithDiff(buildable.build().description, expectedResult, file: file, line: line)
}
