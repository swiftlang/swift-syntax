//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if compiler(>=6)
public import SwiftSyntaxMacros
@_spi(PluginMessage) private import SwiftCompilerPluginMessageHandling
#else
import SwiftSyntaxMacros
@_spi(PluginMessage) import SwiftCompilerPluginMessageHandling
#endif

//
// This source file contains the main entry point for compiler plugins.
// A plugin receives messages from the "plugin host" (typically
// 'swift-frontend'), and sends back messages in return based on its actions.
//
// Depending on the platform, plugins are invoked in a sandbox that blocks
// network access and prevents any file system changes.
//
// The host process and the plugin communicate using messages in the form of
// length-prefixed JSON-encoded Swift enums. The host sends messages to the
// plugin through its standard-input pipe, and receives messages through the
// plugin's standard-output pipe. The plugin's standard-error is considered
// to be free-form textual console output.
//
// Within the plugin process, `stdout` is redirected to `stderr` so that print
// statements from the plugin are treated as plain-text output, and `stdin` is
// closed so that any attempts by the plugin logic to read from console result
// in errors instead of blocking the process. The original `stdin` and `stdout`
// are duplicated for use as messaging pipes, and are not directly used by the
// plugin logic.
//
// The exit code of the plugin process indicates whether the plugin invocation
// is considered successful. A failure result should also be accompanied by an
// emitted error diagnostic, so that errors are understandable by the user.
//
// Using standard input and output streams for messaging avoids having to make
// allowances in the sandbox for other channels of communication, and seems a
// more portable approach than many of the alternatives. This is all somewhat
// temporary in any case — in the long term, something like distributed actors
// or something similar can hopefully replace the custom messaging.
//
// Usage:
//   struct MyPlugin: CompilerPlugin {
//   var providingMacros: [Macros.Type] = [
//     StringifyMacro.self
//   ]
public protocol CompilerPlugin {
  init()

  var providingMacros: [Macro.Type] { get }
}

extension CompilerPlugin {
  @_spi(Testing)
  public func resolveMacro(moduleName: String, typeName: String) throws -> Macro.Type {
    let qualifedName = "\(moduleName).\(typeName)"

    for type in providingMacros {
      // FIXME: Is `String(reflecting:)` stable?
      // Getting the module name and type name should be more robust.
      let name = String(reflecting: type)
      if name == qualifedName {
        return type
      }
    }

    let pluginPath: String
    if CommandLine.argc > 0, let cPluginPath = CommandLine.unsafeArgv[0] {
      pluginPath = String(cString: cPluginPath)
    } else {
      pluginPath = "<unknown>"
    }
    throw CompilerPluginError(
      message:
        "macro implementation type '\(moduleName).\(typeName)' could not be found in executable plugin '\(pluginPath)'"
    )
  }
}

struct CompilerPluginError: Error, CustomStringConvertible {
  var description: String
  init(message: String) {
    self.description = message
  }
}

struct MacroProviderAdapter<Plugin: CompilerPlugin>: PluginProvider {
  let plugin: Plugin
  init(plugin: Plugin) {
    self.plugin = plugin
  }
  func resolveMacro(moduleName: String, typeName: String) throws -> Macro.Type {
    try plugin.resolveMacro(moduleName: moduleName, typeName: typeName)
  }
}

extension CompilerPlugin {

  /// Main entry point of the plugin — sets up a standard I/O communication
  /// channel with the plugin host and runs the main message loop.
  public static func main() throws {
    let connection = try StandardIOMessageConnection()
    let provider = MacroProviderAdapter(plugin: Self())
    let impl = CompilerPluginMessageListener(connection: connection, provider: provider)
    try impl.main()
  }
}
