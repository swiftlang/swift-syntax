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

/// Describes a package dependency for refactoring purposes. This is a syntactic
/// subset of the full package manifest's description of a package dependency.
@_spi(PackageRefactor)
public enum PackageDependency: Sendable {
  case fileSystem(FileSystem)
  case sourceControl(SourceControl)
  case registry(Registry)

  public struct FileSystem: Sendable {
    public let path: String

    public init(path: String) {
      self.path = path
    }
  }

  public struct SourceControl: Sendable {
    public let location: String
    public let requirement: Requirement

    public init(location: String, requirement: Requirement) {
      self.location = location
      self.requirement = requirement
    }

    public enum Requirement: Sendable {
      case exact(String)
      case rangeFrom(String)
      case range(lowerBound: String, upperBound: String)
      case revision(String)
      case branch(String)
    }
  }

  public struct Registry: Sendable {
    public let identity: String
    public let requirement: Requirement

    public init(identity: String, requirement: Requirement) {
      self.identity = identity
      self.requirement = requirement
    }

    /// The dependency requirement.
    public enum Requirement: Sendable {
      case exact(String)
      case rangeFrom(String)
      case range(lowerBound: String, upperBound: String)
    }
  }
}

extension PackageDependency: ManifestSyntaxRepresentable {
  func asSyntax() -> ExprSyntax {
    switch self {
    case .fileSystem(let filesystem): return filesystem.asSyntax()
    case .sourceControl(let sourceControl): return sourceControl.asSyntax()
    case .registry(let registry): return registry.asSyntax()
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
    ".package(url: \(literal: location.description), \(requirement.asSyntax()))"
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
      return LabeledExprSyntax(
        label: "exact",
        expression: version.asSyntax()
      )

    case .rangeFrom(let range):
      return LabeledExprSyntax(
        label: "from",
        expression: range.asSyntax()
      )

    case .range(let lowerBound, let upperBound):
      return LabeledExprSyntax(
        expression: "\(literal: lowerBound)..<\(literal: upperBound)" as ExprSyntax
      )

    case .revision(let revision):
      return LabeledExprSyntax(
        label: "revision",
        expression: "\(literal: revision)" as ExprSyntax
      )

    case .branch(let branch):
      return LabeledExprSyntax(
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
      return LabeledExprSyntax(
        label: "exact",
        expression: version.asSyntax()
      )

    case .rangeFrom(let range):
      return LabeledExprSyntax(
        label: "from",
        expression: range.asSyntax()
      )

    case .range(let lowerBound, let upperBound):
      return LabeledExprSyntax(
        expression: "\(lowerBound.asSyntax())..<\(upperBound.asSyntax())" as ExprSyntax
      )
    }
  }
}
