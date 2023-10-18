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

import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Provides default `fatalError` implementations for protocol methods.
///
/// This macro generates extensions that add default `fatalError` implementations
/// for each method in the protocol it is attached to.
public enum DefaultFatalErrorImplementationMacro: ExtensionMacro {

  /// Unique identifier for messages related to this macro.
  private static let messageID = MessageID(domain: "MacroExamples", id: "ProtocolDefaultImplementation")

  /// Generates extension for the protocol to which this macro is attached.
  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [ExtensionDeclSyntax] {

    // Validate that the macro is being applied to a protocol declaration
    guard let protocolDecl = declaration.as(ProtocolDeclSyntax.self) else {
      throw SimpleDiagnosticMessage(
        message: "Macro `defaultFatalErrorImplementation` can only be applied to a protocol",
        diagnosticID: messageID,
        severity: .error
      )
    }

    // Extract all the methods from the protocol and assign default implementations
    let methods = protocolDecl.memberBlock.members
      .map(\.decl)
      .compactMap { declaration -> FunctionDeclSyntax? in
        guard var function = declaration.as(FunctionDeclSyntax.self) else {
          return nil
        }
        function.body = CodeBlockSyntax {
          ExprSyntax(#"fatalError("whoops 😅")"#)
        }
        return function
      }

    // Don't generate an extension if there are no methods
    if methods.isEmpty {
      return []
    }

    // Generate the extension containing the default implementations
    let extensionDecl = ExtensionDeclSyntax(extendedType: type) {
      for method in methods {
        MemberBlockItemSyntax(decl: method)
      }
    }

    return [extensionDecl]
  }
}
