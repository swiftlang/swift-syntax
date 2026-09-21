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
  @_spi(PackageRefactor)
  public enum Dependency: Sendable, Hashable {
    /// A source-control dependency declared with `.package(url:)`.
    case sourceControl(url: String)

    /// A registry dependency declared with `.package(id:)`.
    case registry(identity: String)

    fileprivate init?(_ syntax: VersionedDependencySyntaxNodes) {
      switch syntax.kind {
      case .sourceControl(let url):
        guard let url = url.representedLiteralValue else {
          return nil
        }
        self = .sourceControl(url: url)
      case .registry(let identity):
        guard let identity = identity.representedLiteralValue else {
          return nil
        }
        self = .registry(identity: identity)
      }
    }
  }

  public typealias Input = SourceFileSyntax

  public struct Context {
    let latestVersions: [Dependency: String]

    public init(
      resolvingLatestVersionIn manifest: SourceFileSyntax,
      using resolveLatestPackageVersion:
        @Sendable @escaping (_ dependency: Dependency, _ currentVersion: String) async -> String?
    ) async throws {
      let dependencies = try findDependencies(in: manifest)
      self.latestVersions = await withTaskGroup(
        of: (dependency: Dependency, latestVersion: String)?.self
      ) { taskGroup in
        for dependencySyntax in dependencies {
          taskGroup.addTask {
            guard let dependency = Dependency(dependencySyntax),
              let currentVersion = dependencySyntax.currentVersion.representedLiteralValue
            else {
              return nil
            }
            guard let latestVersion = await resolveLatestPackageVersion(dependency, currentVersion) else {
              return nil
            }
            return (dependency, latestVersion)
          }
        }
        var latestVersions: [Dependency: String] = [:]
        for await case .some(let result) in taskGroup {
          latestVersions[result.dependency] = result.latestVersion
        }
        return latestVersions
      }
    }
  }

  fileprivate struct VersionedDependencySyntaxNodes {
    enum Kind {
      case sourceControl(url: StringLiteralExprSyntax)
      case registry(identity: StringLiteralExprSyntax)
    }
    let kind: Kind
    let currentVersion: StringLiteralExprSyntax
  }

  private static func findDependencies(in manifest: SourceFileSyntax) throws -> [VersionedDependencySyntaxNodes] {
    guard let packageCall = manifest.findCall(calleeName: "Package") else {
      throw ManifestEditError.cannotFindPackage
    }
    guard let dependencies = packageCall.findArgument(labeled: "dependencies")?.expression.as(ArrayExprSyntax.self)
    else {
      throw ManifestEditError.cannotFindDependencies
    }
    return dependencies.elements.compactMap { (dependency) -> VersionedDependencySyntaxNodes? in
      guard let functionCall = dependency.expression.as(FunctionCallExprSyntax.self),
        functionCall.calledExpression.as(MemberAccessExprSyntax.self)?.declName.baseName.tokenKind
          == .identifier("package")
      else {
        return nil
      }

      let kind: VersionedDependencySyntaxNodes.Kind
      if let url = functionCall.findArgument(labeled: "url")?.expression.as(StringLiteralExprSyntax.self) {
        kind = .sourceControl(url: url)
      } else if let identity = functionCall.findArgument(labeled: "id")?.expression.as(StringLiteralExprSyntax.self) {
        kind = .registry(identity: identity)
      } else {
        return nil
      }

      // TODO: Support version initialized using `Version` initializer
      if let version = functionCall.findArgument(labeled: "from")?.expression.as(StringLiteralExprSyntax.self) {
        return VersionedDependencySyntaxNodes(kind: kind, currentVersion: version)
      } else if let version = functionCall.findArgument(labeled: "exact")?.expression.as(StringLiteralExprSyntax.self) {
        return VersionedDependencySyntaxNodes(kind: kind, currentVersion: version)
      } else {
        return nil
      }
    }
  }

  public static func textRefactor(syntax manifest: SourceFileSyntax, in context: Context) throws -> [SourceEdit] {
    return try findDependencies(in: manifest).compactMap { dependencySyntax in
      guard let dependency = Dependency(dependencySyntax),
        let latestVersion = context.latestVersions[dependency]
      else {
        return nil
      }
      guard dependencySyntax.currentVersion.representedLiteralValue != latestVersion else {
        return nil
      }
      return SourceEdit(
        range: dependencySyntax.currentVersion.trimmedRange,
        replacement: StringLiteralExprSyntax(content: latestVersion).description
      )
    }
  }
}
