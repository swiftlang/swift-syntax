//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftDiagnostics
import SwiftSyntax

extension SyntaxProtocol {
  /// Get the warning emission behavior control for the specified diagnostic group
  /// by determining its containing `WarningControlRegion`, if one is present.
  /// Returns the syntactic control for the given diagnostic group, or `nil` if
  /// there is not one.
  /// - Parameters:
  ///   - for diagnosticGroupIdentifier: The identifier of the diagnostic group.
  ///   - globalControls: The global controls to consider, specified by the client (compiler)
  ///     representing module-wide diagnostic group emission configuration, for example
  ///     with `-Wwarning` and `-Werror` flags. These controls can be overriden at
  ///     finer-grained scopes with the `@warn` attribute.
  @_spi(ExperimentalLanguageFeatures)
  public func warningGroupControl(
    for diagnosticGroupIdentifier: DiagnosticGroupIdentifier,
    globalControls: [(DiagnosticGroupIdentifier, WarningGroupControl)] = [],
    groupInheritanceTree: DiagnosticGroupInheritanceTree? = nil
  ) -> WarningGroupControl? {
    let warningControlRegions = root.warningGroupControlRegionTreeImpl(
      globalControls: globalControls,
      groupInheritanceTree: groupInheritanceTree,
      containing: self.position
    )
    return warningControlRegions.warningGroupControl(at: self.position, for: diagnosticGroupIdentifier)
  }
}
