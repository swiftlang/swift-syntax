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

/// Add a target dependency to a manifest's source code.
public struct AddTargetDependency: ManifestEditRefactoringProvider {
  public struct Context {
    /// The dependency to add.
    public var dependency: Target.Dependency

    /// The name of the target to which the dependency will be added.
    public var targetName: String

    public init(dependency: Target.Dependency, targetName: String) {
      self.dependency = dependency
      self.targetName = targetName
    }
  }

  /// The set of argument labels that can occur after the "dependencies"
  /// argument in the various target initializers.
  ///
  /// TODO: Could we generate this from the the PackageDescription module, so
  /// we don't have keep it up-to-date manually?
  private static let argumentLabelsAfterDependencies: Set<String> = [
    "path",
    "exclude",
    "sources",
    "resources",
    "publicHeadersPath",
    "packageAccess",
    "cSettings",
    "cxxSettings",
    "swiftSettings",
    "linkerSettings",
    "plugins",
  ]

  /// Produce the set of source edits needed to add the given target
  /// dependency to the given manifest file.
  public static func manifestRefactor(
    syntax manifest: SourceFileSyntax,
    in context: Context
  ) throws -> PackageEdit {
    let dependency = context.dependency
    let targetName = context.targetName

    guard let packageCall = manifest.findCall(calleeName: "Package") else {
      throw ManifestEditError.cannotFindPackage
    }

    // Find the target to be modified.
    let targetCall = try packageCall.findManifestTargetCall(targetName: targetName)

    let newTargetCall = try addTargetDependencyLocal(
      dependency,
      to: targetCall
    )

    return PackageEdit(
      manifestEdits: [
        .replace(targetCall, with: newTargetCall.description)
      ]
    )
  }

  /// Implementation of adding a target dependency to an existing call.
  static func addTargetDependencyLocal(
    _ dependency: Target.Dependency,
    to targetCall: FunctionCallExprSyntax
  ) throws -> FunctionCallExprSyntax {
    try targetCall.appendingToArrayArgument(
      label: "dependencies",
      labelsAfter: Self.argumentLabelsAfterDependencies,
      newElement: dependency.asSyntax()
    )
  }
}
