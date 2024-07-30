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
public enum ConfiguredRegionState {
  /// The region is not part of the compiled program and is not even parsed,
  /// and therefore many contain syntax that is invalid.
  case unparsed
  /// The region is parsed but is not part of the compiled program.
  case inactive
  /// The region is active and is part of the compiled program.
  case active

  /// Evaluate the given `#if` condition using the given build configuration, throwing an error if there is
  /// insufficient information to make a determination.
  public init(
    condition: some ExprSyntaxProtocol,
    configuration: some BuildConfiguration,
    diagnosticHandler: ((Diagnostic) -> Void)? = nil
  ) throws {
    // Apply operator folding for !/&&/||.
    let foldedCondition = try OperatorTable.logicalOperators.foldAll(condition) { error in
      diagnosticHandler?(error.asDiagnostic)
      throw error
    }.cast(ExprSyntax.self)

    let (active, versioned) = try evaluateIfConfig(
      condition: foldedCondition,
      configuration: configuration,
      diagnosticHandler: diagnosticHandler
    )

    switch (active, versioned) {
    case (true, _): self = .active
    case (false, false): self = .inactive
    case (false, true): self = .unparsed
    }
  }
}
