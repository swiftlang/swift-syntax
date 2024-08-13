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
import SwiftSyntax

extension IfConfigDeclSyntax {
  /// Given a particular build configuration, determine which clause (if any) is the "active" clause.
  ///
  /// For example, for code like the following:
  /// ```
  /// #if A
  ///  func f()
  /// #elseif B
  ///  func g()
  /// #endif
  /// ```
  ///
  /// If the `A` configuration option was passed on the command line (e.g. via `-DA`), the first clause
  /// (containing `func f()`) would be returned. If not, and if the `B` configuration was passed on the
  /// command line, the second clause (containing `func g()`) would be returned. If neither was
  /// passed, this function will return `nil` to indicate that none of the regions are active.
  ///
  /// If an error occurs while processing any of the `#if` clauses,
  /// that clause will be considered inactive and this operation will
  /// continue to evaluate later clauses.
  public func activeClause(
    in configuration: some BuildConfiguration
  ) -> (clause: IfConfigClauseSyntax?, diagnostics: [Diagnostic]) {
    var diagnostics: [Diagnostic] = []
    for clause in clauses {
      // If there is no condition, we have reached an unconditional clause. Return it.
      guard let condition = clause.condition else {
        return (clause, diagnostics: diagnostics)
      }

      // Apply operator folding for !/&&/||.
      let (foldedCondition, foldingDiagnostics) = IfConfigClauseSyntax.foldOperators(condition)
      diagnostics.append(contentsOf: foldingDiagnostics)

      // If this condition evaluates true, return this clause.
      let (isActive, _, localDiagnostics) = evaluateIfConfig(
        condition: foldedCondition,
        configuration: configuration
      )
      diagnostics.append(contentsOf: localDiagnostics)

      if isActive {
        return (clause, diagnostics: diagnostics)
      }
    }

    return (nil, diagnostics: diagnostics)
  }
}
