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
/// `node.isActive(in: configuration)` will evaluate to `.active` or will
/// throw. When errors occur, they will be recorded in the set of
/// diagnostics.
open class ActiveSyntaxVisitor<Configuration: BuildConfiguration>: SyntaxVisitor {
  /// The build configuration, which will be queried for each relevant `#if`.
  public let configuration: Configuration

  /// The set of diagnostics accumulated during this walk of active syntax.
  public var diagnostics: [Diagnostic] = []

  /// The number of "#if" clauses that were visited.
  var numIfClausesVisited: Int = 0

  public init(viewMode: SyntaxTreeViewMode, configuration: Configuration) {
    self.configuration = configuration
    super.init(viewMode: viewMode)
  }

  open override func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind {
    let activeClause = node.activeClause(in: configuration) { diag in
      self.diagnostics.append(diag)
    }

    numIfClausesVisited += 1

    // If there is an active clause, visit it's children.
    if let activeClause, let elements = activeClause.elements {
      walk(Syntax(elements))
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
/// `node.isActive(in: configuration)` will evaluate to `.active` or will
/// throw.
///
/// All notes visited by this visitor will have the "active" state, i.e.,
/// `node.isActive(in: configuration)` will evaluate to `.active` or will
/// throw. When errors occur, they will be recorded in the set of
/// diagnostivs.
open class ActiveSyntaxAnyVisitor<Configuration: BuildConfiguration>: SyntaxAnyVisitor {
  /// The build configuration, which will be queried for each relevant `#if`.
  public let configuration: Configuration

  /// The set of diagnostics accumulated during this walk of active syntax.
  public var diagnostics: [Diagnostic] = []

  public init(viewMode: SyntaxTreeViewMode, configuration: Configuration) {
    self.configuration = configuration
    super.init(viewMode: viewMode)
  }

  open override func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind {
    // If there is an active clause, visit it's children.
    let activeClause = node.activeClause(in: configuration) { diag in
      self.diagnostics.append(diag)
    }
    if let activeClause, let elements = activeClause.elements {
      walk(Syntax(elements))
    }

    // Skip everything else in the #if.
    return .skipChildren
  }
}
