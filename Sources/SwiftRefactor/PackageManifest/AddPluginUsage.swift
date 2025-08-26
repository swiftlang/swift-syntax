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

import SwiftParser
import SwiftSyntax
import SwiftSyntaxBuilder

/// Add a plugin usage to a particular target in the manifest's source
/// code.
@_spi(PackageRefactor)
public struct AddPluginUsage: EditRefactoringProvider {
  public struct Context {
    public let targetName: String
    public let pluginUsage: PackageTarget.PluginUsage

    public init(targetName: String, pluginUsage: PackageTarget.PluginUsage) {
      self.targetName = targetName
      self.pluginUsage = pluginUsage
    }
  }

  /// Produce the set of source edits needed to add the given package
  /// dependency to the given manifest file.
  public static func textRefactor(
    syntax manifest: SourceFileSyntax,
    in context: Context
  ) throws -> [SourceEdit] {
    let targetName = context.targetName
    let pluginUsage = context.pluginUsage

    guard let packageCall = manifest.findCall(calleeName: "Package") else {
      throw ManifestEditError.cannotFindPackage
    }

    // Find the target to be modified.
    let targetCall = try packageCall.findManifestTargetCall(targetName: targetName)

    let newTargetCall = try targetCall.appendingToArrayArgument(
      label: "plugins",
      labelsAfter: [],
      newElement: pluginUsage.asSyntax()
    )

    return [
      .replace(targetCall, with: newTargetCall.description)
    ]
  }
}
