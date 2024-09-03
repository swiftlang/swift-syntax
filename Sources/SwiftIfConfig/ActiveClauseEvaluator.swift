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

/// Captures sufficient information to determine the active clause for an `#if`
/// either by querying existing configured regions or by evaluating the
/// clause's conditions against a build configuration.
enum ActiveClauseEvaluator {
  case configuredRegions(ConfiguredRegions)
  case configuration(any BuildConfiguration)

  /// Previously-known diagnostics.
  var priorDiagnostics: [Diagnostic] {
    switch self {
    case .configuredRegions(let configuredRegions):
      return configuredRegions.diagnostics
    case .configuration:
      return []
    }
  }

  /// Determine which clause of an `#if` declaration is active, if any.
  ///
  /// If this evaluation produced any diagnostics, they will be appended to
  /// the diagnostics parameter.
  func activeClause(
    for node: IfConfigDeclSyntax,
    diagnostics: inout [Diagnostic]
  ) -> IfConfigClauseSyntax? {
    switch self {
    case .configuredRegions(let configuredRegions):
      return configuredRegions.activeClause(for: node)
    case .configuration(let configuration):
      let (activeClause, localDiagnostics) = node.activeClause(in: configuration)
      diagnostics.append(contentsOf: localDiagnostics)
      return activeClause
    }
  }
}
