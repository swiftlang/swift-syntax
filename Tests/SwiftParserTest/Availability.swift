@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import XCTest

final class AvailabilityTests: XCTestCase {
  func testAvailableMember() throws {
    try AssertParse({ $0.parseSourceFile() }) {
      """
      @available(OSX 10.0, introduced: 10.12)
      // expected-error@-1 {{'introduced' can't be combined with shorthand specification 'OSX 10.0'}}
      // expected-error@-2 {{expected declaration}}
      func shorthandFollowedByIntroduced() {}
      
      @available(iOS 6.0, OSX 10.8, *)
      func availableOnMultiplePlatforms() {}
      """
    }

    try AssertParse({ $0.parseClassDeclaration(.empty) }) {
      """
      class IncrementalParseTransition {
        @available(*, deprecated, message: "Use the initializer taking 'ConcurrentEdits' instead")
        public convenience init() {}
      }
      """
    }

    try AssertParse({ $0.parseSourceFile() }) {
       """
       extension String {
         @available(macOS 10.15.4, iOS 13.4, watchOS 6.2, tvOS 13.4, *)
         public func fiddle() { }

         @available(SwiftStdlib 5.2, *)
         public func fiddle() { }
       }
       """
    }

    try AssertParse({ $0.parseSourceFile() }) {
      """
      @available(
        iOSApplicationExtension,
        introduced: 10.0,
        deprecated: 11.0,
        message:
          "Use something else because this is definitely deprecated.")
      func f2() {}
      """
    }
  }
}
