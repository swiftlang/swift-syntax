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

/// Describes all of the #if/#elseif/#else clauses within the given syntax node,
/// indicating their active state. This operation will recurse into all
/// clauses to indicate regions of active / inactive / unparsed code.
///
/// For example, given code like the following:
/// #if DEBUG
///   #if A
///     func f()
///   #elseif B
///     func g()
///   #elseif compiler(>= 12.0)
///   please print the number after 41
///   #endif
/// #else
/// #endif
///
/// If the configuration options `DEBUG` and `B` are provided, but `A` is not,
/// and the compiler version is less than 12.0, the results will be contain:
///   - Active region for the `#if DEBUG`.
///   - Inactive region for the `#if A`.
///   - Active region for the `#elseif B`.
///   - Unparsed region for the `#elseif compiler(>= 12.0)`.
///   - Inactive region for the final `#else`.
public struct ConfiguredRegions {
  let regions: [Element]

  /// The set of diagnostics produced when evaluating the configured regions.
  public let diagnostics: [Diagnostic]

  /// Determine whether the given syntax node is active within the configured
  /// regions.
  public func isActive(_ node: some SyntaxProtocol) -> IfConfigRegionState {
    var currentState: IfConfigRegionState = .active
    for (ifClause, state) in regions {
      if node.position < ifClause.position {
        return currentState
      }

      if node.position <= ifClause.endPosition {
        currentState = state
      }
    }

    return currentState
  }
}

extension ConfiguredRegions: RandomAccessCollection {
  public typealias Element = (IfConfigClauseSyntax, IfConfigRegionState)
  public var startIndex: Int { regions.startIndex }
  public var endIndex: Int { regions.endIndex }

  public subscript(index: Int) -> Element {
    regions[index]
  }
}

extension SyntaxProtocol {
  /// Find all of the #if/#elseif/#else clauses within the given syntax node,
  /// indicating their active state. This operation will recurse into all
  /// clauses to indicate regions of active / inactive / unparsed code.
  ///
  /// For example, given code like the following:
  /// #if DEBUG
  ///   #if A
  ///     func f()
  ///   #elseif B
  ///     func g()
  ///   #elseif compiler(>= 12.0)
  ///   please print the number after 41
  ///   #endif
  /// #else
  /// #endif
  ///
  /// If the configuration options `DEBUG` and `B` are provided, but `A` is not,
  /// and the compiler version is less than 12.0, the results will be contain:
  ///   - Active region for the `#if DEBUG`.
  ///   - Inactive region for the `#if A`.
  ///   - Active region for the `#elseif B`.
  ///   - Unparsed region for the `#elseif compiler(>= 12.0)`.
  ///   - Inactive region for the final `#else`.
  public func configuredRegions(
    in configuration: some BuildConfiguration
  ) -> ConfiguredRegions {
    let visitor = ConfiguredRegionVisitor(configuration: configuration)
    visitor.walk(self)
    return ConfiguredRegions(
      regions: visitor.regions,
      diagnostics: visitor.diagnostics
    )
  }
}

/// Helper class that walks a syntax tree looking for configured regions.
fileprivate class ConfiguredRegionVisitor<Configuration: BuildConfiguration>: SyntaxVisitor {
  let configuration: Configuration

  /// The regions we've found so far.
  var regions: [(IfConfigClauseSyntax, IfConfigRegionState)] = []

  /// Whether we are currently within an active region.
  var inActiveRegion = true

  // All diagnostics encountered along the way.
  var diagnostics: [Diagnostic] = []

  init(configuration: Configuration) {
    self.configuration = configuration
    super.init(viewMode: .sourceAccurate)
  }

  override func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind {
    // Walk through the clauses to find the active one.
    var foundActive = false
    var syntaxErrorsAllowed = false
    for clause in node.clauses {
      let isActive: Bool
      if let condition = clause.condition {
        if !foundActive {
          // Fold operators so we can evaluate this #if condition.
          let (foldedCondition, foldDiagnostics) = IfConfigClauseSyntax.foldOperators(condition)
          diagnostics.append(contentsOf: foldDiagnostics)

          // In an active region, evaluate the condition to determine whether
          // this clause is active. Otherwise, this clause is inactive.
          // inactive.
          if inActiveRegion {
            let (thisIsActive, _, evalDiagnostics) = evaluateIfConfig(
              condition: foldedCondition,
              configuration: configuration
            )
            diagnostics.append(contentsOf: evalDiagnostics)

            // Determine if there was an error that prevented us from
            // evaluating the condition. If so, we'll allow syntax errors
            // from here on out.
            let hadError =
              foldDiagnostics.contains { diag in
                diag.diagMessage.severity == .error
              }
              || evalDiagnostics.contains { diag in
                diag.diagMessage.severity == .error
              }

            if hadError {
              isActive = false
              syntaxErrorsAllowed = true
            } else {
              isActive = thisIsActive

              // Determine whether syntax errors are allowed.
              syntaxErrorsAllowed = foldedCondition.allowsSyntaxErrorsFolded
            }
          } else {
            isActive = false

            // Determine whether syntax errors are allowed, even though we
            // skipped evaluation of the actual condition.
            syntaxErrorsAllowed = foldedCondition.allowsSyntaxErrorsFolded
          }
        } else {
          // We already found an active condition, so this is inactive.
          isActive = false
        }
      } else {
        // This is an #else. It's active if we haven't found an active clause
        // yet and are in an active region.
        isActive = !foundActive && inActiveRegion
      }

      // Determine and record the current state.
      let currentState: IfConfigRegionState
      switch (isActive, syntaxErrorsAllowed) {
      case (true, _): currentState = .active
      case (false, false): currentState = .inactive
      case (false, true): currentState = .unparsed
      }
      regions.append((clause, currentState))

      // If this is a parsed region, recurse into it.
      if currentState != .unparsed, let elements = clause.elements {
        let priorInActiveRegion = inActiveRegion
        inActiveRegion = isActive
        defer {
          inActiveRegion = priorInActiveRegion
        }
        walk(elements)
      }

      // Note when we found an active clause.
      if isActive {
        foundActive = true
      }
    }

    return .skipChildren
  }
}
