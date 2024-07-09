//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//
import SwiftDiagnostics
import SwiftIfConfig
import SwiftParser
import SwiftSyntax
import SwiftSyntaxMacrosGenericTestSupport
import XCTest

/// Visitor that ensures that all of the nodes we visit are active.
///
/// This cross-checks the visitor itself with the `SyntaxProtocol.isActive(in:)`
/// API.
class AllActiveVisitor: ActiveSyntaxAnyVisitor<TestingBuildConfiguration> {
  init(configuration: TestingBuildConfiguration) {
    super.init(viewMode: .sourceAccurate, configuration: configuration)
  }
  open override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    var active: ConfiguredRegionState = .inactive
    XCTAssertNoThrow(try active = node.isActive(in: configuration))
    XCTAssertEqual(active, .active)
    return .visitChildren
  }
}

class NameCheckingVisitor: ActiveSyntaxAnyVisitor<TestingBuildConfiguration> {
  /// The set of names we are expected to visit. Any syntax nodes with
  /// names that aren't here will be rejected, and each of the names listed
  /// here must occur exactly once.
  var expectedNames: Set<String>

  init(configuration: TestingBuildConfiguration, expectedNames: Set<String>) {
    self.expectedNames = expectedNames

    super.init(viewMode: .sourceAccurate, configuration: configuration)
  }

  deinit {
    if !expectedNames.isEmpty {
      XCTFail("No nodes with expected names visited: \(expectedNames)")
    }
  }

  func checkName(name: String, node: Syntax) {
    if !expectedNames.contains(name) {
      XCTFail("syntax node with unexpected name \(name) found: \(node.debugDescription)")
    }

    expectedNames.remove(name)
  }

  open override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    if let identified = node.asProtocol(NamedDeclSyntax.self) {
      checkName(name: identified.name.text, node: node)
    } else if let identPattern = node.as(IdentifierPatternSyntax.self) {
      // FIXME: Should the above be an IdentifiedDeclSyntax?
      checkName(name: identPattern.identifier.text, node: node)
    }

    return .visitChildren
  }
}

public class VisitorTests: XCTestCase {
  let linuxBuildConfig = TestingBuildConfiguration(
    customConditions: ["DEBUG", "ASSERTS"],
    features: ["ParameterPacks"],
    attributes: ["available"]
  )

  let iosBuildConfig = TestingBuildConfiguration(
    platformName: "iOS",
    customConditions: ["DEBUG", "ASSERTS"],
    features: ["ParameterPacks"],
    attributes: ["available"]
  )

  let inputSource: SourceFileSyntax = """
    #if DEBUG
    #if os(Linux)
    #if hasAttribute(available)
    @available(*, deprecated, message: "use something else")
    #else
    @MainActor
    #endif
    func f() {
    }
    #elseif os(iOS)
    func g() {
      let a = foo
        #if hasFeature(ParameterPacks)
        .b
        #endif
        .c
    }
    #endif

    struct S {
      #if DEBUG
      var generationCount = 0
      #endif
    }

    func h() {
      switch result {
        case .success(let value):
          break
        #if os(iOS)
        case .failure(let error):
          break
        #endif
      }
    }

    func i() {
      a.b
      #if DEBUG
        .c
      #endif
      #if hasAttribute(available)
        .d()
      #endif
      #if os(iOS)
        .e[]
      #endif
    }
    #endif

    #if hasAttribute(available)
    func withAvail() { }
    #else
    func notAvail() { }
    #endif
    """

  func testAnyVisitorVisitsOnlyActive() throws {
    // Make sure that all visited nodes are active nodes.
    AllActiveVisitor(configuration: linuxBuildConfig).walk(inputSource)
    AllActiveVisitor(configuration: iosBuildConfig).walk(inputSource)
  }

  func testVisitsExpectedNodes() throws {
    // Check that the right set of names is visited.
    NameCheckingVisitor(
      configuration: linuxBuildConfig,
      expectedNames: ["f", "h", "i", "S", "generationCount", "value", "withAvail"]
    ).walk(inputSource)

    NameCheckingVisitor(
      configuration: iosBuildConfig,
      expectedNames: ["g", "h", "i", "a", "S", "generationCount", "value", "error", "withAvail"]
    ).walk(inputSource)
  }

  func testVisitorWithErrors() throws {
    var configuration = linuxBuildConfig
    configuration.badAttributes.insert("available")
    let visitor = NameCheckingVisitor(
      configuration: configuration,
      expectedNames: ["f", "h", "i", "S", "generationCount", "value", "notAvail"]
    )
    visitor.walk(inputSource)
    XCTAssertEqual(visitor.diagnostics.count, 3)
  }

  func testRemoveInactive() {
    assertRemoveInactive(
      inputSource.description,
      configuration: linuxBuildConfig,
      expectedSource: """

        @available(*, deprecated, message: "use something else")
        func f() {
        }

        struct S {
          var generationCount = 0
        }

        func h() {
          switch result {
            case .success(let value):
              break
          }
        }

        func i() {
          a.b
            .c
            .d()
        }
        func withAvail() { }
        """
    )
  }

  func testRemoveInactiveWithErrors() {
    var configuration = linuxBuildConfig
    configuration.badAttributes.insert("available")

    assertRemoveInactive(
      inputSource.description,
      configuration: configuration,
      diagnostics: [
        DiagnosticSpec(
          message: "unacceptable attribute 'available'",
          line: 3,
          column: 18
        ),
        DiagnosticSpec(
          message: "unacceptable attribute 'available'",
          line: 42,
          column: 20
        ),
        DiagnosticSpec(
          message: "unacceptable attribute 'available'",
          line: 51,
          column: 18
        ),
      ],
      expectedSource: """

        @MainActor
        func f() {
        }

        struct S {
          var generationCount = 0
        }

        func h() {
          switch result {
            case .success(let value):
              break
          }
        }

        func i() {
          a.b
            .c
        }
        func notAvail() { }
        """
    )
  }
}
