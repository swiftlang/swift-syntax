//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftParser
import SwiftSyntax
import SwiftSyntaxBuilder

/// Add a plugin usage to a particular target in the manifest's source
/// code.
public struct AddPluginUsage: ManifestEditRefactoringProvider {
  public struct Context {
    public let targetName: String
    public let pluginUsage: TargetDescription.PluginUsage

    public init(targetName: String, pluginUsage: TargetDescription.PluginUsage) {
      self.targetName = targetName
      self.pluginUsage = pluginUsage
    }
  }

  /// The set of argument labels that can occur after the "plugins"
  /// argument in the Target initializers. (There aren't any right now)
  ///
  /// TODO: Could we generate this from the the PackageDescription module, so
  /// we don't have keep it up-to-date manually?
  private static let argumentLabelsAfterPluginUsages: Set<String> = []

  /// Produce the set of source edits needed to add the given package
  /// dependency to the given manifest file.
  public static func manifestRefactor(
    syntax manifest: SourceFileSyntax,
    in context: Context
  ) throws -> PackageEdit {
    let targetName = context.targetName
    let pluginUsage = context.pluginUsage

    guard let packageCall = manifest.findCall(calleeName: "Package") else {
      throw ManifestEditError.cannotFindPackage
    }

    // Find the target to be modified.
    let targetCall = try packageCall.findManifestTargetCall(targetName: targetName)

    let newTargetCall = try targetCall.appendingToArrayArgument(
      label: "plugins",
      trailingLabels: Self.argumentLabelsAfterPluginUsages,
      newElement: pluginUsage.asSyntax()
    )

    return PackageEdit(
      manifestEdits: [
        .replace(targetCall, with: newTargetCall.description)
      ]
    )
  }
}
