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

/// A syntax visitor that only visits the syntax nodes that are active
/// according to a particular build configuration.
///
/// This subclass of `SyntaxVisitor` walks all of the syntax nodes in a given
/// tree that are "active" according to a particular build configuration,
/// meaning that the syntax would contribute to the resulting program when
/// when compiled with that configuration. For example, given:
///
/// ```
/// #if DEBUG
///   #if os(Linux)
///    func f()
///   #elseif os(iOS)
///    func g()
///   #endif
/// #endif
/// ```
///
/// And a build targeting Linux with the custom condition `DEBUG` set, a
/// complete walk via this visitor would visit `func f` but not `func g`. If
/// the build configuration instead targted macOS (but still had `DEBUG` set),
/// it would not visit either `f` or `g`.
///
/// All notes visited by this visitor will have the "active" state, i.e.,
/// `node.isActive(in: configuration)` will have evaluated to `.active`.
/// When errors occur, they will be recorded in the array of diagnostics.
open class ActiveSyntaxVisitor: SyntaxVisitor {
  /// The abstracted build configuration, which will be queried for each
  /// relevant `#if`.
  let activeClauses: ActiveClauseEvaluator

  /// The diagnostics accumulated during this walk of active syntax.
  public private(set) var diagnostics: [Diagnostic] = []

  public init(viewMode: SyntaxTreeViewMode, configuration: some BuildConfiguration) {
    self.activeClauses = .configuration(configuration)
    self.diagnostics = activeClauses.priorDiagnostics
    super.init(viewMode: viewMode)
  }

  public init(viewMode: SyntaxTreeViewMode, configuredRegions: ConfiguredRegions) {
    self.activeClauses = .configuredRegions(configuredRegions)
    self.diagnostics = activeClauses.priorDiagnostics
    super.init(viewMode: viewMode)
  }

  open override func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind {
    // Note: there is a clone of this code in ActiveSyntaxAnyVisitor. If you
    // change one, please also change the other.
    let activeClause = activeClauses.activeClause(for: node, diagnostics: &diagnostics)

    // If there is an active clause, visit it's children.
    if let activeClause, let elements = activeClause.elements {
      walk(elements)
    }

    // Skip everything else in the #if.
    return .skipChildren
  }
}

/// A syntax visitor that only visits the syntax nodes that are active
/// according to a particular build configuration.
///
/// This subclass of `SyntaxVisitor` walks all of the syntax nodes in a given
/// tree that are "active" according to a particular build configuration,
/// meaning that the syntax would contribute to the resulting program when
/// when compiled with that configuration. For example, given:
///
/// ```
/// #if DEBUG
///   #if os(Linux)
///    func f()
///   #elseif os(iOS)
///    func g()
///   #endif
/// #endif
/// ```
///
/// And a build targeting Linux with the custom condition `DEBUG` set, a
/// complete walk via this visitor would visit `func f` but not `func g`. If
/// the build configuration instead targted macOS (but still had `DEBUG` set),
/// it would not visit either `f` or `g`.
///
/// All notes visited by this visitor will have the "active" state, i.e.,
/// `node.isActive(in: configuration)` will have evaluated to `.active`.
/// When errors occur, they will be recorded in the array of diagnostics.
open class ActiveSyntaxAnyVisitor: SyntaxAnyVisitor {
  /// The abstracted build configuration, which will be queried for each
  /// relevant `#if`.
  let activeClauses: ActiveClauseEvaluator

  /// The diagnostics accumulated during this walk of active syntax.
  public private(set) var diagnostics: [Diagnostic] = []

  public init(viewMode: SyntaxTreeViewMode, configuration: some BuildConfiguration) {
    self.activeClauses = .configuration(configuration)
    self.diagnostics = activeClauses.priorDiagnostics
    super.init(viewMode: viewMode)
  }

  public init(viewMode: SyntaxTreeViewMode, configuredRegions: ConfiguredRegions) {
    self.activeClauses = .configuredRegions(configuredRegions)
    self.diagnostics = activeClauses.priorDiagnostics
    super.init(viewMode: viewMode)
  }

  open override func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind {
    // Note: there is a clone of this code in ActiveSyntaxVisitor. If you
    // change one, please also change the other.

    // If there is an active clause, visit it's children.
    let activeClause = activeClauses.activeClause(for: node, diagnostics: &diagnostics)

    if let activeClause, let elements = activeClause.elements {
      walk(elements)
    }

    // Skip everything else in the #if.
    return .skipChildren
  }
}
