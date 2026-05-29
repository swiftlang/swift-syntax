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

/// Upgrade all package dependencies that have a `from` or `exact` version restriction to their latest released version,
/// including new major versions.
///
/// The intention of this refactoring is to update leaf package (like executables) to the latest version of their
/// dependencies, allowing them to also pick up potentially API-breaking new major or prerelease versions that can
/// easily go unnoticed using `swift package update`.
@_spi(PackageRefactor)
public struct UpgradePackageDependencies: EditRefactoringProvider {
  public typealias Input = SourceFileSyntax

  public struct Context {
    let latestVersions: [String: String]

    public init(
      resolvingLatestVersionIn manifest: SourceFileSyntax,
      using resolveLatestPackageVersion: @Sendable @escaping (_ url: String, _ currentVersion: String) async -> String?
    ) async throws {
      let dependencies = try findDependencies(in: manifest)
      self.latestVersions = await withTaskGroup(of: (url: String, latestVersion: String)?.self) { taskGroup in
        for dependency in dependencies {
          taskGroup.addTask {
            guard let url = dependency.url.representedLiteralValue,
              let currentVersion = dependency.currentVersion.representedLiteralValue
            else {
              return nil
            }
            guard let latestVersion = await resolveLatestPackageVersion(url, currentVersion) else {
              return nil
            }
            return (url, latestVersion)
          }
        }
        var latestVersions: [String: String] = [:]
        for await case .some(let result) in taskGroup {
          latestVersions[result.url] = result.latestVersion
        }
        return latestVersions
      }
    }
  }

  private struct VersionedDependency {
    let url: StringLiteralExprSyntax
    let currentVersion: StringLiteralExprSyntax
  }

  private static func findDependencies(in manifest: SourceFileSyntax) throws -> [VersionedDependency] {
    guard let packageCall = manifest.findCall(calleeName: "Package") else {
      throw ManifestEditError.cannotFindPackage
    }
    guard let dependencies = packageCall.findArgument(labeled: "dependencies")?.expression.as(ArrayExprSyntax.self)
    else {
      throw ManifestEditError.cannotFindDependencies
    }
    return dependencies.elements.compactMap { (dependency) -> VersionedDependency? in
      guard let functionCall = dependency.expression.as(FunctionCallExprSyntax.self),
        functionCall.calledExpression.as(MemberAccessExprSyntax.self)?.declName.baseName.tokenKind
          == .identifier("package"),
        let url = functionCall.findArgument(labeled: "url")?.expression.as(StringLiteralExprSyntax.self)
      else {
        return nil
      }

      // TODO: Support version initialized using `Version` initializer
      if let version = functionCall.findArgument(labeled: "from")?.expression.as(StringLiteralExprSyntax.self) {
        return VersionedDependency(url: url, currentVersion: version)
      } else if let version = functionCall.findArgument(labeled: "exact")?.expression.as(StringLiteralExprSyntax.self) {
        return VersionedDependency(url: url, currentVersion: version)
      } else {
        return nil
      }
    }
  }

  public static func textRefactor(syntax manifest: SourceFileSyntax, in context: Context) throws -> [SourceEdit] {
    return try findDependencies(in: manifest).compactMap { dependency in
      guard let urlValue = dependency.url.representedLiteralValue, let latestVersion = context.latestVersions[urlValue]
      else {
        return nil
      }
      guard dependency.currentVersion.representedLiteralValue != latestVersion else {
        return nil
      }
      return SourceEdit(
        range: dependency.currentVersion.trimmedRange,
        replacement: StringLiteralExprSyntax(content: latestVersion).description
      )
    }
  }
}
