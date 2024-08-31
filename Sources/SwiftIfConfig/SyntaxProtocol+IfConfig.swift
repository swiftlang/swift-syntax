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
  /// Determine whether the given syntax node is active within the given build configuration.
  ///
  /// This function evaluates the enclosing stack of `#if` conditions to determine whether the
  /// given node is active in the program when it is compiled with the given build configuration.
  ///
  /// For example, given code like the following:
  /// #if DEBUG
  ///   #if A
  ///    func f()
  ///   #elseif B
  ///     func g()
  ///   #elseif compiler(>= 12.0)
  ///     please print the number after 41
  ///   #endif
  /// #endif
  ///
  /// a call to `isActive` on the syntax node for the function `g` would return `active` when the
  /// configuration options `DEBUG` and `B` are provided, but `A` is not.
  ///
  /// If the compiler version is smaller than 12.0, then `isActive` on any of the tokens within
  /// that `#elseif` block would return "unparsed", because that syntax should not (conceptually)
  /// be parsed.
  ///
  /// Note that this function requires processing all #ifs from the root node
  /// of the syntax tree down to the current node. If performing more than a
  /// small number of `isActive(_:)` queries, please form a `ConfiguredRegions`
  /// instance and use `ConfiguredRegions.isActive(_:)` instead.
  public func isActive(
    in configuration: some BuildConfiguration
  ) -> (state: IfConfigRegionState, diagnostics: [Diagnostic]) {
    let configuredRegions = root.configuredRegions(in: configuration)
    return (configuredRegions.isActive(self), configuredRegions.diagnostics)
  }
}
