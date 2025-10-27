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
  /// Get the warning emission behavior for the specified diagnostic group
  /// by determining its containing `WarningControlRegion`, if one is present.
  @_spi(ExperimentalLanguageFeatures)
  public func warningGroupBehavior(
    for diagnosticGroupIdentifier: DiagnosticGroupIdentifier
  ) -> WarningGroupBehavior? {
    let warningControlRegions = root.warningGroupControlRegionTreeImpl(containing: self.position)
    return warningControlRegions.warningGroupBehavior(at: self.position, for: diagnosticGroupIdentifier)
  }
}
