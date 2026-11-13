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

#if compiler(>=6.2) && canImport(Testing)
import SwiftIfConfig
import SwiftSyntax
import Testing

/// Tests for the deployment-version query on `BuildConfiguration` /
/// `StaticBuildConfiguration`.
struct `Minimum OS deployment version tests` {
  /// A configuration for a macOS build that also targets an iOS variant (as with
  /// a Mac Catalyst variant).
  let variantConfig = StaticBuildConfiguration(
    languageVersion: VersionTuple(6),
    compilerVersion: VersionTuple(6),
    deploymentTargetVersions: ["macOS": VersionTuple(14), "OSX": VersionTuple(14), "iOS": VersionTuple(17, 4)]
  )

  /// A configuration produced by a toolchain that predates this information: the
  /// version map is `nil` (unknown), distinct from an empty map.
  let unknownConfig = StaticBuildConfiguration(
    languageVersion: VersionTuple(6),
    compilerVersion: VersionTuple(6)
  )

  @Test(arguments: ["macOS", "OSX"])
  func `Deployment version resolves for the active OS and its aliases`(name: String) {
    // The compiler populates the map under every `os(...)` spelling it emits, so
    // an alias such as `OSX` resolves to the same version as `macOS`.
    #expect(variantConfig.minimumDeploymentVersion(forTargetOS: name) == VersionTuple(14))
  }

  @Test
  func `Deployment version resolves for a target-variant OS`() {
    #expect(variantConfig.minimumDeploymentVersion(forTargetOS: "iOS") == VersionTuple(17, 4))
  }

  @Test
  func `Deployment version is nil for an inactive OS`() {
    #expect(variantConfig.minimumDeploymentVersion(forTargetOS: "Linux") == nil)
  }

  @Test
  func `Deployment version is nil when the mapping is unknown`() {
    #expect(unknownConfig.deploymentTargetVersions == nil)
    #expect(unknownConfig.minimumDeploymentVersion(forTargetOS: "macOS") == nil)
  }

  @Test
  func `anyAppleOS carries a version only under unified numbering`() {
    let unified = StaticBuildConfiguration(
      languageVersion: VersionTuple(6),
      compilerVersion: VersionTuple(6),
      deploymentTargetVersions: ["macOS": VersionTuple(26), "anyAppleOS": VersionTuple(26)]
    )
    #expect(unified.minimumDeploymentVersion(forTargetOS: "anyAppleOS") == VersionTuple(26))

    // The pre-unification configuration has no `anyAppleOS` entry.
    #expect(variantConfig.minimumDeploymentVersion(forTargetOS: "anyAppleOS") == nil)
  }
}
#endif
