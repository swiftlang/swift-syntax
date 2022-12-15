//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax
import SwiftDiagnostics

/// System-supplied structure that provides information about the context in
/// which a given macro is being expanded.
public struct MacroExpansionContext {
  /// The name of the module in which the macro is being evaluated.
  public let moduleName: String

  /// The name of the source file in which the macro is being evaluated,
  /// without any path information.
  ///
  /// Swift prevents two files within the same module from having the same
  /// name, so the combination of file and module name is unique.
  public let fileName: String

  /// Counter used to generate names local to the macro.
  var localNameCounter = 0

  /// The set of diagnostics that were emitted as part of expanding the
  /// macro.
  public private(set) var diagnostics: [Diagnostic] = []

  /// Create a new macro evaluation context.
  public init(moduleName: String, fileName: String) {
    self.moduleName = moduleName
    self.fileName = fileName
  }

  /// Generate a unique local name for use in the macro.
  public mutating func createUniqueLocalName() -> TokenSyntax {
    let name = "__macro_local_\(localNameCounter)"
    let token = TokenSyntax(.identifier(name), presence: .present)
    localNameCounter += 1
    return token
  }

  /// Create a new macro evaluation context.
  @available(*, deprecated, message: "Use init(moduleName:fileName:)")
  public init(
    moduleName: String,
    sourceLocationConverter: SourceLocationConverter
  ) {
    let fileName =
      sourceLocationConverter.location(
        for: AbsolutePosition(utf8Offset: -1)
      ).file ?? "unknown.swift"

    self.init(moduleName: moduleName, fileName: fileName)
  }

  /// Produce a diagnostic while expanding the macro.
  public mutating func diagnose(_ diagnostic: Diagnostic) {
    diagnostics.append(diagnostic)
  }
}
