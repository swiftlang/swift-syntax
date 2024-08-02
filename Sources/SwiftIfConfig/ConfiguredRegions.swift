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
  ) -> [(IfConfigClauseSyntax, IfConfigRegionState)] {
    let visitor = ConfiguredRegionVisitor(configuration: configuration)
    visitor.walk(self)
    return visitor.regions
  }
}

/// Helper class that walks a syntax tree looking for configured regions.
fileprivate class ConfiguredRegionVisitor<Configuration: BuildConfiguration>: SyntaxVisitor {
  let configuration: Configuration

  /// The regions we've found so far.
  var regions: [(IfConfigClauseSyntax, IfConfigRegionState)] = []

  /// Whether we are currently within an active region.
  var inActiveRegion = true

  init(configuration: Configuration) {
    self.configuration = configuration
    super.init(viewMode: .sourceAccurate)
  }

  override func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind {
    // If we're in an active region, find the active clause. Otherwise,
    // there isn't one.
    let activeClause = inActiveRegion ? node.activeClause(in: configuration).clause : nil
    for clause in node.clauses {
      // If this is the active clause, record it and then recurse into the
      // elements.
      if clause == activeClause {
        assert(inActiveRegion)

        regions.append((clause, .active))

        if let elements = clause.elements {
          walk(elements)
        }

        continue
      }

      // For inactive clauses, distinguish between inactive and unparsed.
      let syntaxErrorsAllowed = clause.syntaxErrorsAllowed(
        configuration: configuration
      ).syntaxErrorsAllowed

      // If this is within an active region, or this is an unparsed region,
      // record it.
      if inActiveRegion || syntaxErrorsAllowed {
        regions.append((clause, syntaxErrorsAllowed ? .unparsed : .inactive))
      }

      // Recurse into inactive (but not unparsed) regions to find any
      // unparsed regions below.
      if !syntaxErrorsAllowed, let elements = clause.elements {
        let priorInActiveRegion = inActiveRegion
        inActiveRegion = false
        defer {
          inActiveRegion = priorInActiveRegion
        }
        walk(elements)
      }
    }

    return .skipChildren
  }
}
