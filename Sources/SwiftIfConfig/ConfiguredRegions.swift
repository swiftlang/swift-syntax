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
  let regions: [(ifClause: IfConfigClauseSyntax, state: IfConfigRegionState)]

  // A mapping from each of the #if declarations that have been evaluated to
  // the active clause. Absence from this map means that there is no active
  // clause, either because every clause failed or because the entire #if
  // itself is inactive.
  var activeClauses: [IfConfigDeclSyntax: IfConfigClauseSyntax]

  /// The set of diagnostics produced when evaluating the configured regions.
  public let diagnostics: [Diagnostic]

  /// Determine whether the given syntax node is active within the configured
  /// regions.
  ///
  /// Any given node within the range of configured regions can either be
  /// "active" (it is part of the program), "inactive" (it is not part of the
  /// program), or "unparsed" (it is not part of the program and shouldn't
  /// produce any syntax errors).
  ///
  /// This operation takes time that is logarthmic in the number of regions
  /// in the syntax tree.
  public func isActive(_ node: some SyntaxProtocol) -> IfConfigRegionState {
    // Find the slice of the regions in which this node lands.
    var currentSlice = regions[...]
    while !currentSlice.isEmpty {
      let middle = currentSlice.startIndex + currentSlice.count / 2

      // If the node is prior to the start of the middle, take the left-hand side.
      if node.position < currentSlice[middle].ifClause.regionStart {
        currentSlice = currentSlice[..<middle]
        continue
      }

      // If the node is after the end of the middle, take the right-hand side.
      if node.position > currentSlice[middle].ifClause.endPosition {
        currentSlice = currentSlice[(middle + 1)...]
        continue
      }

      // We cannot narrow the range any further.
      break
    }

    // Find the last region in which this node lands. If there is no such
    // region, this is active.
    return currentSlice.last { region in
      (region.ifClause.regionStart...region.ifClause.endPosition).contains(node.position)
    }?.state ?? .active
  }

  /// Determine which clause of an `#if` declaration was active within this
  /// set of configured regions.
  ///
  /// A particular `#if` declaration might have no active clause (e.g., this
  /// operation will return a `nil`) if either none of the clauses had
  /// conditions that succeeded, or the `#if` declaration itself is within an
  /// inactive (or unparsed) region and therefore cannot have an active clause.
  public func activeClause(for node: IfConfigDeclSyntax) -> IfConfigClauseSyntax? {
    return activeClauses[node]
  }
}

extension ConfiguredRegions: RandomAccessCollection {
  public typealias Element = (ifClause: IfConfigClauseSyntax, state: IfConfigRegionState)
  public var startIndex: Int { regions.startIndex }
  public var endIndex: Int { regions.endIndex }

  public subscript(index: Int) -> Element {
    regions[index]
  }
}

extension ConfiguredRegions: CustomDebugStringConvertible {
  /// Provides source ranges for each of the configured regions.
  public var debugDescription: String {
    guard let firstRegion = first else {
      return "[]"
    }

    let root = firstRegion.ifClause.root
    let converter = SourceLocationConverter(fileName: "", tree: root)
    let regionDescriptions = regions.map { (ifClause, state) in
      let startPosition = converter.location(for: ifClause.position)
      let endPosition = converter.location(for: ifClause.endPosition)
      return "[\(startPosition.line):\(startPosition.column) - \(endPosition.line):\(endPosition.column)] = \(state)"
    }

    return "[\(regionDescriptions.joined(separator: ", ")))]"
  }
}

extension IfConfigClauseSyntax {
  /// The effective start of the region after which code is subject to its
  /// condition.
  fileprivate var regionStart: AbsolutePosition {
    condition?.endPosition ?? elements?._syntaxNode.position ?? poundKeyword.endPosition
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
      activeClauses: visitor.activeClauses,
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

  /// Whether we are currently within an #if at all.
  var inAnyIfConfig = false

  // All diagnostics encountered along the way.
  var diagnostics: [Diagnostic] = []

  // A mapping from each of the #if declarations that have been evaluated to
  // the active clause. Absence from this map means that there is no active
  // clause, either because every clause failed or because the entire #if
  // itself is inactive.
  var activeClauses: [IfConfigDeclSyntax: IfConfigClauseSyntax] = [:]

  init(configuration: Configuration) {
    self.configuration = configuration
    super.init(viewMode: .sourceAccurate)
  }

  override func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind {
    // We are in an #if.
    let priorInAnyIfConfig = inAnyIfConfig
    inAnyIfConfig = true
    defer {
      inAnyIfConfig = priorInAnyIfConfig
    }

    // Walk through the clauses to find the active one.
    var foundActive = false
    var syntaxErrorsAllowed = false
    let outerState: IfConfigRegionState = inActiveRegion ? .active : .inactive
    for clause in node.clauses {
      let isActive: Bool
      if let condition = clause.condition {
        if !foundActive {
          // Fold operators so we can evaluate this #if condition.
          let (foldedCondition, foldDiagnostics) = IfConfigClauseSyntax.foldOperators(condition)
          diagnostics.append(contentsOf: foldDiagnostics)

          // In an active region, evaluate the condition to determine whether
          // this clause is active. Otherwise, this clause is inactive.
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

      // If this is the active clause, record it as such.
      if isActive {
        activeClauses[node] = clause
      }

      // Determine and record the current state.
      let currentState: IfConfigRegionState
      switch (isActive, syntaxErrorsAllowed) {
      case (true, _): currentState = .active
      case (false, false): currentState = .inactive
      case (false, true): currentState = .unparsed
      }

      // If there is a state change, record it.
      if !priorInAnyIfConfig || currentState != .inactive || currentState != outerState {
        regions.append((clause, currentState))
      }

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
