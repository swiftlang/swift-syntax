@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import XCTest

final class AvailabilityTests: XCTestCase {
  func testAvailableMember() throws {
    AssertParse(
      """
      @available(OSX 10.0, introduced: 10.12)
      // expected-error@-1 {{'introduced' can't be combined with shorthand specification 'OSX 10.0'}}
      // expected-error@-2 {{expected declaration}}
      func shorthandFollowedByIntroduced() {}
      
      @available(iOS 6.0, OSX 10.8, *)
      func availableOnMultiplePlatforms() {}
      """
    )

    AssertParse(
      """
      class IncrementalParseTransition {
        @available(*, deprecated, message: "Use the initializer taking 'ConcurrentEdits' instead")
        public convenience init() {}
      }
      """,
      { $0.parseClassDeclaration(.empty, .constant(.classKeyword)) }
    )

    AssertParse(
       """
       extension String {
         @available(macOS 10.15.4, iOS 13.4, watchOS 6.2, tvOS 13.4, *)
         public func fiddle() { }

         @available(SwiftStdlib 5.2, *)
         public func fiddle() { }
       }
       """
    )

    AssertParse(
      """
      @available(
        iOSApplicationExtension,
        introduced: 10.0,
        deprecated: 11.0,
        message:
          "Use something else because this is definitely deprecated.")
      func f2() {}
      """
    )
  }

  func testAvailabilityMacros() throws {
    AssertParse(
      """
      @available(_iOS9, _macOS10_11, tvOS 11.0, *)
      public func composed() {}
      """)

    AssertParse(
      """
      @_specialize(exported: true, availability: SwiftStdlib 5.1, *; where T == Int)
      public func testSemanticsAvailability<T>(_ t: T) {}
      """)
  }

  func testSPIAvailabilityAttribute() throws {
    AssertParse(
      """
      @_spi_available(*, deprecated, renamed: "another")
      public class SPIClass1 {}

      @_spi_available(*, unavailable)
      public class SPIClass2 {}

      @_spi_available(AlienPlatform 5.2, *)
      public class SPIClass3 {}

      @_spi_available(macOS 10.4, *)
      public class SPIClass4 {}
      """)
  }
}
