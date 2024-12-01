//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2014-2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftParser
import SwiftSyntax
import SwiftSyntaxBuilder

/// Describes a package dependency for refactoring purposes. This is a syntactic
/// subset of the full package manifest's description of a package dependency.
public enum PackageDependency: Sendable {
  case fileSystem(FileSystem)
  case sourceControl(SourceControl)
  case registry(Registry)

  public struct FileSystem: Sendable {
    public let identity: PackageIdentity
    public let nameForTargetDependencyResolutionOnly: String?
    public let path: AbsolutePath
  }

  public struct SourceControl: Sendable {
    public let identity: PackageIdentity
    public let location: Location
    public let requirement: Requirement

    public init(identity: PackageIdentity, location: Location, requirement: Requirement) {
      self.identity = identity
      self.location = location
      self.requirement = requirement
    }

    public enum Requirement: Sendable {
      case exact(SemanticVersion)
      case rangeFrom(SemanticVersion)
      case range(lowerBound: SemanticVersion, upperBound: SemanticVersion)
      case revision(String)
      case branch(String)
    }

    public enum Location: Sendable {
      case local(AbsolutePath)
      case remote(SourceControlURL)
    }
  }

  public struct Registry: Sendable {
    public let identity: PackageIdentity
    public let requirement: Requirement

    /// The dependency requirement.
    public enum Requirement: Sendable {
      case exact(SemanticVersion)
      case rangeFrom(SemanticVersion)
      case range(lowerBound: SemanticVersion, upperBound: SemanticVersion)
    }
  }
}

extension PackageDependency: ManifestSyntaxRepresentable {
  func asSyntax() -> ExprSyntax {
    switch self {
    case .fileSystem(let filesystem): filesystem.asSyntax()
    case .sourceControl(let sourceControl): sourceControl.asSyntax()
    case .registry(let registry): registry.asSyntax()
    }
  }
}

extension PackageDependency.FileSystem: ManifestSyntaxRepresentable {
  func asSyntax() -> ExprSyntax {
    ".package(path: \(literal: path.description))"
  }
}

extension PackageDependency.SourceControl: ManifestSyntaxRepresentable {
  func asSyntax() -> ExprSyntax {
    // TODO: Not handling identity, nameForTargetDependencyResolutionOnly,
    // or productFilter yet.
    switch location {
    case .local:
      fatalError()
    case .remote(let url):
      ".package(url: \(literal: url.description), \(requirement.asSyntax()))"
    }
  }
}

extension PackageDependency.Registry: ManifestSyntaxRepresentable {
  func asSyntax() -> ExprSyntax {
    ".package(id: \(literal: identity.description), \(requirement.asSyntax()))"
  }
}

extension PackageDependency.SourceControl.Requirement: ManifestSyntaxRepresentable {
  func asSyntax() -> LabeledExprSyntax {
    switch self {
    case .exact(let version):
      LabeledExprSyntax(
        label: "exact",
        expression: version.asSyntax()
      )

    case .rangeFrom(let range):
      LabeledExprSyntax(
        label: "from",
        expression: range.asSyntax()
      )

    case .range(let lowerBound, let upperBound):
      LabeledExprSyntax(
        expression: "\(lowerBound.asSyntax())..<\(upperBound.asSyntax())" as ExprSyntax
      )

    case .revision(let revision):
      LabeledExprSyntax(
        label: "revision",
        expression: "\(literal: revision)" as ExprSyntax
      )

    case .branch(let branch):
      LabeledExprSyntax(
        label: "branch",
        expression: "\(literal: branch)" as ExprSyntax
      )
    }
  }
}

extension PackageDependency.Registry.Requirement: ManifestSyntaxRepresentable {
  func asSyntax() -> LabeledExprSyntax {
    switch self {
    case .exact(let version):
      LabeledExprSyntax(
        label: "exact",
        expression: version.asSyntax()
      )

    case .rangeFrom(let range):
      LabeledExprSyntax(
        label: "from",
        expression: range.asSyntax()
      )

    case .range(let lowerBound, let upperBound):
      LabeledExprSyntax(
        expression: "\(lowerBound.asSyntax())..<\(upperBound.asSyntax())" as ExprSyntax
      )
    }
  }
}
