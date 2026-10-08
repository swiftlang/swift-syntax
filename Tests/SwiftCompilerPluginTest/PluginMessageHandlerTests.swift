//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(PluginMessage) import SwiftCompilerPluginMessageHandling
import SwiftIfConfig
import SwiftSyntax
import SwiftSyntaxMacros
import XCTest

/// Expands to whether the custom condition `FOO` is set in the build
/// configuration of the expansion context.
struct IsFooSetMacro: ExpressionMacro {
  static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> ExprSyntax {
    guard let configuration = context.buildConfiguration else {
      return "nil"
    }
    return try configuration.isCustomConditionSet(name: "FOO") ? "true" : "false"
  }
}

struct IsFooSetPluginProvider: PluginProvider {
  func resolveMacro(moduleName: String, typeName: String) throws -> Macro.Type {
    IsFooSetMacro.self
  }

  func loadPluginLibrary(libraryPath: String, moduleName: String) throws {}
}

final class PluginMessageHandlerTests: XCTestCase {
  private func staticBuildConfigurationJSON(customConditions: Set<String>) throws -> String {
    let configuration = StaticBuildConfiguration(
      customConditions: customConditions,
      languageVersion: VersionTuple(6),
      compilerVersion: VersionTuple(6)
    )
    return String(decoding: try JSON.encode(configuration), as: UTF8.self)
  }

  private func expandIsFooSet(
    with handler: PluginProviderMessageHandler<IsFooSetPluginProvider>,
    staticBuildConfiguration: String?
  ) -> String? {
    let response = handler.handleMessage(
      .expandFreestandingMacro(
        macro: .init(moduleName: "TestMacros", typeName: "IsFooSetMacro", name: "isFooSet"),
        macroRole: .expression,
        discriminator: "$s1",
        syntax: .init(
          kind: .expression,
          source: "#isFooSet",
          location: .init(fileID: "Test/test.swift", fileName: "test.swift", offset: 0, line: 1, column: 1)
        ),
        staticBuildConfiguration: staticBuildConfiguration
      )
    )
    switch response {
    case .expandMacroResult(let expandedSource, _), .expandFreestandingMacroResult(let expandedSource, _):
      return expandedSource
    default:
      XCTFail("unexpected response: \(response)")
      return nil
    }
  }

  /// Each expansion sees the build configuration sent with its own message,
  /// even when one handler receives several different configurations in turn.
  func testExpansionUsesBuildConfigurationOfEachMessage() throws {
    let handler = PluginProviderMessageHandler(provider: IsFooSetPluginProvider())
    let withFoo = try staticBuildConfigurationJSON(customConditions: ["FOO"])
    let withoutFoo = try staticBuildConfigurationJSON(customConditions: ["BAR"])

    XCTAssertEqual(expandIsFooSet(with: handler, staticBuildConfiguration: withFoo), "true")
    XCTAssertEqual(expandIsFooSet(with: handler, staticBuildConfiguration: withFoo), "true")
    XCTAssertEqual(expandIsFooSet(with: handler, staticBuildConfiguration: withoutFoo), "false")
    XCTAssertEqual(expandIsFooSet(with: handler, staticBuildConfiguration: withFoo), "true")
    XCTAssertEqual(expandIsFooSet(with: handler, staticBuildConfiguration: nil), "nil")
    XCTAssertEqual(expandIsFooSet(with: handler, staticBuildConfiguration: withoutFoo), "false")
  }

  /// A build configuration that fails to decode leaves the expansion without
  /// a build configuration, and does not affect later valid configurations.
  func testInvalidBuildConfigurationIsIgnored() throws {
    let handler = PluginProviderMessageHandler(provider: IsFooSetPluginProvider())
    let withFoo = try staticBuildConfigurationJSON(customConditions: ["FOO"])

    XCTAssertEqual(expandIsFooSet(with: handler, staticBuildConfiguration: "not json"), "nil")
    XCTAssertEqual(expandIsFooSet(with: handler, staticBuildConfiguration: withFoo), "true")
    XCTAssertEqual(expandIsFooSet(with: handler, staticBuildConfiguration: "not json"), "nil")
  }
}
