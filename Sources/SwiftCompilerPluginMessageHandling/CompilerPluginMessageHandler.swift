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
@_implementationOnly private import _SwiftSyntaxCShims
public import SwiftSyntaxMacros
#else
@_implementationOnly import _SwiftSyntaxCShims
import SwiftSyntaxMacros
#endif

/// Optional features.
@_spi(PluginMessage)
public enum PluginFeature: String {
  case loadPluginLibrary = "load-plugin-library"
}

/// A type that provides the actual plugin functions.
///
/// Note that it's an implementation's responsibility to cache the API results as needed.
@_spi(PluginMessage)
public protocol PluginProvider {
  /// Resolve macro type by the module name and the type name.
  func resolveMacro(moduleName: String, typeName: String) throws -> Macro.Type

  /// Load dynamic link library at `libraryPath`. Implementations can use
  /// `moduleName` to associate the loaded library with it.
  func loadPluginLibrary(libraryPath: String, moduleName: String) throws

  /// Optional plugin features. This is sent to the host so the it can decide
  /// the behavior depending on these.
  var features: [PluginFeature] { get }
}

/// Low level message connection to the plugin host.
/// This encapsulates the connection and the message serialization.
@_spi(PluginMessage)
public protocol MessageConnection {
  /// Send a message to the peer.
  func sendMessage<TX: Encodable>(_ message: TX) throws
  /// Wait until receiving a message from the peer, and return it.
  func waitForNextMessage<RX: Decodable>(_ type: RX.Type) throws -> RX?
}

/// Represent the capability of the plugin host (i.e. compiler).
struct HostCapability {
  var protocolVersion: Int

  // Create an "oldest" capability.
  init() {
    self.protocolVersion = 0
  }

  init(_ message: PluginMessage.HostCapability) {
    self.protocolVersion = message.protocolVersion
  }

  /// Compiler accept 'expandMacroResult' response message.
  var hasExpandMacroResult: Bool { protocolVersion >= 5 }
}

/// 'CompilerPluginMessageListener' is a type that listens to the message
/// connection, delegate them to the message handler, then send back
/// the response.
///
/// The low level connection and the provider is injected by the client.
@_spi(PluginMessage)
public class CompilerPluginMessageListener<Connection: MessageConnection, Handler: PluginMessageHandler> {
  /// Message channel for bidirectional communication with the plugin host.
  let connection: Connection

  let handler: Handler

  public init(connection: Connection, messageHandler: Handler) {
    self.connection = connection
    self.handler = messageHandler
  }

  public init<Provider: PluginProvider>(connection: Connection, provider: Provider)
  where Handler == PluginProviderMessageHandler<Provider> {
    self.connection = connection
    self.handler = PluginProviderMessageHandler(provider: provider)
  }

  /// Run the main message listener loop.
  /// Returns when the message connection was closed.
  ///
  /// On internal errors, such as I/O errors or JSON serialization errors, print
  /// an error message and `exit(1)`
  public func main() throws {
    #if os(WASI)
    // Rather than blocking on read(), let the host tell us when there's data.
    readabilityHandler = { _ = self.handleNextMessage() }
    #else
    while handleNextMessage() {}
    try self.handler.shutDown()
    #endif
  }

  /// Receives and handles a single message from the plugin host.
  ///
  /// - Returns: `true` if there was a message to read, `false`
  /// if the end-of-file was reached.
  private func handleNextMessage() -> Bool {
    do {
      guard let message = try connection.waitForNextMessage(HostToPluginMessage.self) else {
        return false
      }
      let result = handler.handleMessage(message)
      try connection.sendMessage(result)
      return true
    } catch {
      // Emit a diagnostic and indicate failure to the plugin host,
      // and exit with an error code.
      fputs("Internal Error: \(error)\n", _stderr)
      exit(1)
    }
  }
}

/// A type that handles a plugin message and returns a response.
///
/// - SeeAlso: ``PluginProviderMessageHandler``
@_spi(PluginMessage)
public protocol PluginMessageHandler {
  /// Handles a single message received from the plugin host.
  func handleMessage(_ message: HostToPluginMessage) -> PluginToHostMessage

  /// Deterministically and synchronously cleans up resources that cannot be dealt with in
  /// a deinitializer due to possible errors thrown during the clean up. Usually this
  /// includes closure of file handles, sockets, shutting down external processes and IPC
  /// resources set up for these processes, etc.
  func shutDown() throws
}

/// A `PluginMessageHandler` that uses a `PluginProvider`.
@_spi(PluginMessage)
public class PluginProviderMessageHandler<Provider: PluginProvider>: PluginMessageHandler {
  /// Object to provide actual plugin functions.
  let provider: Provider

  /// Syntax registry shared between multiple requests.
  let syntaxRegistry: ParsedSyntaxRegistry

  /// Plugin host capability
  var hostCapability: HostCapability

  public init(provider: Provider) {
    self.provider = provider
    self.syntaxRegistry = ParsedSyntaxRegistry(cacheCapacity: 16)
    self.hostCapability = HostCapability()
  }

  /// Handles a single message received from the plugin host.
  public func handleMessage(_ message: HostToPluginMessage) -> PluginToHostMessage {
    switch message {
    case .getCapability(let hostCapability):
      // Remember the peer capability if provided.
      if let hostCapability = hostCapability {
        self.hostCapability = .init(hostCapability)
      }

      // Return the plugin capability.
      let capability = PluginMessage.PluginCapability(
        protocolVersion: PluginMessage.PROTOCOL_VERSION_NUMBER,
        features: provider.features.map({ $0.rawValue })
      )
      return .getCapabilityResult(capability: capability)

    case .expandFreestandingMacro(
      let macro,
      let macroRole,
      let discriminator,
      let expandingSyntax,
      let lexicalContext
    ):
      return expandFreestandingMacro(
        macro: macro,
        macroRole: macroRole,
        discriminator: discriminator,
        expandingSyntax: expandingSyntax,
        lexicalContext: lexicalContext
      )

    case .expandAttachedMacro(
      let macro,
      let macroRole,
      let discriminator,
      let attributeSyntax,
      let declSyntax,
      let parentDeclSyntax,
      let extendedTypeSyntax,
      let conformanceListSyntax,
      let lexicalContext
    ):
      return expandAttachedMacro(
        macro: macro,
        macroRole: macroRole,
        discriminator: discriminator,
        attributeSyntax: attributeSyntax,
        declSyntax: declSyntax,
        parentDeclSyntax: parentDeclSyntax,
        extendedTypeSyntax: extendedTypeSyntax,
        conformanceListSyntax: conformanceListSyntax,
        lexicalContext: lexicalContext
      )

    case .loadPluginLibrary(let libraryPath, let moduleName):
      var diags: [PluginMessage.Diagnostic] = []
      do {
        try provider.loadPluginLibrary(libraryPath: libraryPath, moduleName: moduleName)
      } catch {
        diags.append(
          PluginMessage.Diagnostic(
            message: String(describing: error),
            severity: .error,
            position: .invalid,
            highlights: [],
            notes: [],
            fixIts: []
          )
        )
      }
      return .loadPluginLibraryResult(loaded: diags.isEmpty, diagnostics: diags)
    }
  }

  /// Empty implementation for the default message handler, since all resources are automatically
  /// cleaned up in the synthesized initializer.
  public func shutDown() throws {}
}

@_spi(PluginMessage)
@available(*, deprecated, renamed: "PluginProviderMessageHandler")
public typealias CompilerPluginMessageHandler<Provider: PluginProvider> = PluginProviderMessageHandler<Provider>

struct UnimplementedError: Error, CustomStringConvertible {
  var description: String { "unimplemented" }
}

/// Default implementation of 'PluginProvider' requirements.
extension PluginProvider {
  public var features: [PluginFeature] {
    // No optional features by default.
    return []
  }

  public func loadPluginLibrary(libraryPath: String, moduleName: String) throws {
    // This should be unreachable. The host should not call 'loadPluginLibrary'
    // unless the feature is not declared.
    throw UnimplementedError()
  }
}

#if compiler(>=6) && os(WASI)

/// A callback invoked by the Wasm Host when new data is available on `stdin`.
///
/// This is safe to access without serialization as Wasm plugins are single-threaded.
nonisolated(unsafe) private var readabilityHandler: () -> Void = {
  fatalError(
    """
    CompilerPlugin.main wasn't called. Did you annotate your plugin with '@main'?
    """
  )
}

@_expose(wasm, "swift_wasm_macro_v1_pump")
@_cdecl("swift_wasm_macro_v1_pump")
func wasmPump() {
  readabilityHandler()
}

// we can't nest the whole #if-#else in '#if os(WASI)' due to a bug where
// '#if compiler' directives have to be the top-level #if, otherwise
// the compiler doesn't skip unknown syntax.
#elseif os(WASI)

#error("Building swift-syntax for WebAssembly requires compiler version 6.0 or higher.")

#endif
