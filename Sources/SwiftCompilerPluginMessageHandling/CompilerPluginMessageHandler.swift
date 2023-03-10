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

import SwiftSyntaxMacros

/// A type that provides the actual plugin functions.
public protocol PluginProvider {
  func resolveMacro(moduleName: String, typeName: String) -> Macro.Type?
}

/// Low level message connection to the plugin host.
/// This encapsulates the connection and the message serialization.
public protocol MessageConnection {
  /// Send a message to the peer.
  func sendMessage<TX: Encodable>(_ message: TX) throws
  /// Wait until receiving a message from the peer, and return it.
  func waitForNextMessage<RX: Decodable>(_ type: RX.Type) throws -> RX?
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

  public init(connection: Connection, provider: Provider) {
    self.connection = connection
    self.provider = provider
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
    case .getCapability:
      try self.sendMessage(
        .getCapabilityResult(capability: PluginMessage.capability)
      )

    case .expandFreestandingMacro(let macro, let discriminator, let expandingSyntax):
      try expandFreestandingMacro(
        macro: macro,
        discriminator: discriminator,
        expandingSyntax: expandingSyntax
      )

    case .expandAttachedMacro(let macro, let macroRole, let discriminator, let attributeSyntax, let declSyntax, let parentDeclSyntax):
      try expandAttachedMacro(
        macro: macro,
        macroRole: macroRole,
        discriminator: discriminator,
        attributeSyntax: attributeSyntax,
        declSyntax: declSyntax,
        parentDeclSyntax: parentDeclSyntax
      )
    }
  }
}
