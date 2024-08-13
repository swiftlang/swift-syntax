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
import SwiftOperators
import SwiftSyntax

/// Describes the state of a particular region guarded by `#if` or similar.
public enum IfConfigRegionState {
  /// The region is not part of the compiled program and is not even parsed,
  /// and therefore many contain syntax that is invalid.
  case unparsed
  /// The region is parsed but is not part of the compiled program.
  case inactive
  /// The region is active and is part of the compiled program.
  case active

  /// Evaluate the given `#if` condition using the given build configuration
  /// to determine its state, whether syntax errors in inactive conditions are
  /// permitted, and to identify any problems encountered along the way.
  public static func evaluating(
    _ condition: some ExprSyntaxProtocol,
    in configuration: some BuildConfiguration
  ) -> (state: IfConfigRegionState, syntaxErrorsAllowed: Bool, diagnostics: [Diagnostic]) {
    // Apply operator folding for !/&&/||.
    let (foldedCondition, foldingDiagnostics) = IfConfigClauseSyntax.foldOperators(condition)

    let (active, syntaxErrorsAllowed, evalDiagnostics) = evaluateIfConfig(
      condition: foldedCondition,
      configuration: configuration
    )

    let diagnostics = foldingDiagnostics + evalDiagnostics
    switch (active, syntaxErrorsAllowed) {
    case (true, _): return (.active, syntaxErrorsAllowed, diagnostics)
    case (false, false): return (.inactive, syntaxErrorsAllowed, diagnostics)
    case (false, true): return (.unparsed, syntaxErrorsAllowed, diagnostics)
    }
  }
}
