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

/// Add a target dependency to a manifest's source code.
@_spi(PackageRefactor)
public struct AddTargetDependency: EditRefactoringProvider {
  public struct Context {
    /// The dependency to add.
    public var dependency: PackageTarget.Dependency

    /// The name of the target to which the dependency will be added.
    public var targetName: String

    public init(dependency: PackageTarget.Dependency, targetName: String) {
      self.dependency = dependency
      self.targetName = targetName
    }
  }

  /// The set of argument labels that can occur after the "dependencies"
  /// argument in the various target initializers.
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
  public static func textRefactor(
    syntax manifest: SourceFileSyntax,
    in context: Context
  ) throws -> [SourceEdit] {
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

    return [
      .replace(targetCall, with: newTargetCall.description)
    ]
  }

  /// Implementation of adding a target dependency to an existing call.
  static func addTargetDependencyLocal(
    _ dependency: PackageTarget.Dependency,
    to targetCall: FunctionCallExprSyntax
  ) throws -> FunctionCallExprSyntax {
    try targetCall.appendingToArrayArgument(
      label: "dependencies",
      labelsAfter: Self.argumentLabelsAfterDependencies,
      newElement: dependency.asSyntax()
    )
  }
}
