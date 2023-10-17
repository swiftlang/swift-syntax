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

@_spi(Testing) import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxMacros
import XCTest

/// Dummy macro
struct DummyMacro: ExpressionMacro {
  static func expansion<
    Node: FreestandingMacroExpansionSyntax,
    Context: MacroExpansionContext
  >(
    of node: Node,
    in context: Context
  ) throws -> ExprSyntax {
    fatalError()
  }
}

struct RegisteredMacro: ExpressionMacro {
  static func expansion<
    Node: FreestandingMacroExpansionSyntax,
    Context: MacroExpansionContext
  >(
    of node: Node,
    in context: Context
  ) throws -> ExprSyntax {
    fatalError()
  }
}

struct MyPlugin: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    RegisteredMacro.self
  ]
}

public class CompilerPluginTests: XCTestCase {

  func testResolveMacro() {
    let plugin = MyPlugin()

    let registeredMacro = try? plugin.resolveMacro(
      moduleName: "SwiftCompilerPluginTest",
      typeName: "RegisteredMacro"
    )
    XCTAssertNotNil(registeredMacro)
    XCTAssertTrue(registeredMacro == RegisteredMacro.self)

    /// Test the plugin doesn't provide unregistered macros.
    XCTAssertThrowsError(
      try plugin.resolveMacro(
        moduleName: "SwiftCompilerPluginTest",
        typeName: "DummyMacro"
      )
    )

  }
}
