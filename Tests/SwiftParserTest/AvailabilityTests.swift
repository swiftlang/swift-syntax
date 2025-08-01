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

@_spi(RawSyntax) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax
import XCTest

final class AvailabilityTests: ParserTestCase {
  func testAvailableMember() {
    assertParse(
      """
      @available(OSX 10.0, introduced: 10.12)
      // expected-error@-1 {{'introduced' can't be combined with shorthand specification 'OSX 10.0'}}
      // expected-error@-2 {{expected declaration}}
      func shorthandFollowedByIntroduced() {}
      """
    )

    assertParse(
      """
      @available(iOS 6.0, OSX 10.8, *)
      func availableOnMultiplePlatforms() {}
      """
    )

    assertParse(
      """
      class IncrementalParseTransition {
        @available(*, deprecated, message: "Use the initializer taking 'ConcurrentEdits' instead")
        public convenience init() {}
      }
      """
    )

    assertParse(
      """
      extension String {
        @available(macOS 10.15.4, iOS 13.4, watchOS 6.2, tvOS 13.4, *)
        public func fiddle() { }

        @available(SwiftStdlib 5.2, *)
        public func fiddle() { }
      }
      """
    )

    assertParse(
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

  func testAvailabilityMacros() {
    assertParse(
      """
      @available(_iOS9, _macOS10_11, tvOS 11.0, *)
      public func composed() {}
      """
    )

    assertParse(
      """
      @_specialize(exported: true, availability: SwiftStdlib 5.1, *; where T == Int)
      public func testSemanticsAvailability<T>(_ t: T) {}
      """
    )
  }

  func testSPIAvailabilityAttribute() {
    assertParse(
      """
      @_spi_available(*, deprecated, renamed: "another")
      public class SPIClass1 {}

      @_spi_available(*, unavailable)
      public class SPIClass2 {}

      @_spi_available(AlienPlatform 5.2, *)
      public class SPIClass3 {}

      @_spi_available(macOS 10.4, *)
      public class SPIClass4 {}
      """
    )
  }

  func testVersionParsing() {
    assertParse(
      """
      @available(OSX 10)
      func test() {}
      """,
      substructure: VersionTupleSyntax(
        major: .integerLiteral("10"),
        components: []
      )
    )

    assertParse(
      """
      @available(OSX 10.0)
      func test() {}
      """,
      substructure: VersionTupleSyntax(
        major: .integerLiteral("10"),
        components: VersionComponentListSyntax([VersionComponentSyntax(number: .integerLiteral("0"))])
      )
    )

    assertParse(
      """
      @available(OSX 10.0.1)
      func test() {}
      """,
      substructure: VersionTupleSyntax(
        major: .integerLiteral("10"),
        components: VersionComponentListSyntax([
          VersionComponentSyntax(number: .integerLiteral("0")),
          VersionComponentSyntax(number: .integerLiteral("1")),
        ])
      )
    )

    assertParse(
      """
      @available(OSX 10.0.1, *)
      func test() {}
      """
    )

    assertParse(
      """
      @available(OSX 1️⃣10e10)
      func test() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "cannot parse version component code '10e10'")
      ]
    )

    assertParse(
      """
      @available(OSX 10.1️⃣0e10)
      func test() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "cannot parse version component code '0e10'")
      ]
    )

    assertParse(
      """
      @available(OSX 1️⃣0xff)
      func test() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "cannot parse version component code '0xff'")
      ]
    )

    assertParse(
      """
      @available(OSX 1.0.1️⃣0xff)
      func test() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "cannot parse version component code '0xff'")
      ]
    )

    assertParse(
      """
      @available(OSX 1.0.1️⃣0xff, *)
      func test() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "cannot parse version component code '0xff'")
      ]
    )

    assertParse(
      """
      @available(OSX 1.0.1️⃣asdf)
      func test() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "cannot parse version component code 'asdf'")
      ]
    )
  }

  func testAvailableNewlineParen() {
    assertParse(
      """
      @available1️⃣
      2️⃣(*, unavailable) func foo() {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected '()' in attribute",
          fixIts: ["insert '()'"]
        ),
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected argument for '@available' attribute",
          fixIts: ["insert attribute argument"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code '(*, unavailable)' in function"
        ),
      ],
      fixedSource: """
        @available()
        (*, unavailable) func foo() {}
        """
    )
  }
}
