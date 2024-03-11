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

#if swift(>=6)
public import SwiftSyntaxMacros
#else
import SwiftSyntaxMacros
#endif

/// Optional features.
public enum PluginFeature: String {
  case loadPluginLibrary = "load-plugin-library"
}

/// A type that provides the actual plugin functions.
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

/// 'CompilerPluginMessageHandler' is a type that listens to the message
/// connection and dispatches them to the actual plugin provider, then send back
/// the response.
///
/// The low level connection and the provider is injected by the client.
public class CompilerPluginMessageHandler<Connection: MessageConnection, Provider: PluginProvider> {
  /// Message channel for bidirectional communication with the plugin host.
  let connection: Connection

  /// Object to provide actual plugin functions.
  let provider: Provider

  /// Plugin host capability
  var hostCapability: HostCapability

  public init(connection: Connection, provider: Provider) {
    self.connection = connection
    self.provider = provider
    self.hostCapability = HostCapability()
  }
}

extension CompilerPluginMessageHandler {
  func sendMessage(_ message: PluginToHostMessage) throws {
    try connection.sendMessage(message)
  }

  func waitForNextMessage() throws -> HostToPluginMessage? {
    try connection.waitForNextMessage(HostToPluginMessage.self)
  }

  /// Run the main message listener loop.
  /// Returns when the message connection was closed.
  /// Throws an error when it failed to send/receive the message, or failed
  /// to serialize/deserialize the message.
  public func main() throws {
    while let message = try self.waitForNextMessage() {
      try handleMessage(message)
    }
  }

  /// Handles a single message received from the plugin host.
  fileprivate func handleMessage(_ message: HostToPluginMessage) throws {
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
      try self.sendMessage(.getCapabilityResult(capability: capability))

    case .expandFreestandingMacro(
      let macro,
      let macroRole,
      let discriminator,
      let expandingSyntax,
      let lexicalContext
    ):
      try expandFreestandingMacro(
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
      try expandAttachedMacro(
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
      try self.sendMessage(.loadPluginLibraryResult(loaded: diags.isEmpty, diagnostics: diags));
    }
  }
}

struct UnimplementedError: Error, CustomStringConvertible {
  var description: String { "unimplemented" }
}

/// Default implementation of 'PluginProvider' requirements.
public extension PluginProvider {
  var features: [PluginFeature] {
    // No optional features by default.
    return []
  }

  func loadPluginLibrary(libraryPath: String, moduleName: String) throws {
    // This should be unreachable. The host should not call 'loadPluginLibrary'
    // unless the feature is not declared.
    throw UnimplementedError()
  }
}
