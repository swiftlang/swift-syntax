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

/// Add a package dependency to a package manifest's source code.
public struct AddPackageDependency: ManifestEditRefactoringProvider {
  public struct Context {
    public var dependency: PackageDependency

    public init(dependency: PackageDependency) {
      self.dependency = dependency
    }
  }

  /// The set of argument labels that can occur after the "dependencies"
  /// argument in the Package initializers.
  ///
  /// TODO: Could we generate this from the the PackageDescription module, so
  /// we don't have keep it up-to-date manually?
  private static let argumentLabelsAfterDependencies: Set<String> = [
    "targets",
    "swiftLanguageVersions",
    "cLanguageStandard",
    "cxxLanguageStandard",
  ]

  /// Produce the set of source edits needed to add the given package
  /// dependency to the given manifest file.
  public static func manifestRefactor(
    syntax manifest: SourceFileSyntax,
    in context: Context
  ) throws -> PackageEditResult {
    let dependency = context.dependency
    guard let packageCall = manifest.findCall(calleeName: "Package") else {
      throw ManifestEditError.cannotFindPackage
    }

    let newPackageCall = try addPackageDependencyLocal(
      dependency,
      to: packageCall
    )

    return PackageEditResult(
      manifestEdits: [
        .replace(packageCall, with: newPackageCall.description)
      ]
    )
  }

  /// Implementation of adding a package dependency to an existing call.
  static func addPackageDependencyLocal(
    _ dependency: PackageDependency,
    to packageCall: FunctionCallExprSyntax
  ) throws -> FunctionCallExprSyntax {
    try packageCall.appendingToArrayArgument(
      label: "dependencies",
      trailingLabels: Self.argumentLabelsAfterDependencies,
      newElement: dependency.asSyntax()
    )
  }
}
