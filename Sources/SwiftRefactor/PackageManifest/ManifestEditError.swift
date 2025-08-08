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

import SwiftSyntax

/// An error describing problems that can occur when attempting to edit a
/// package manifest programattically.
@_spi(PackageRefactor)
public enum ManifestEditError: Error, Equatable {
  case cannotFindPackage
  case cannotFindTargets
  case cannotFindTarget(targetName: String)
  case cannotFindArrayLiteralArgument(argumentName: String)
  case cannotAddSettingsToPluginTarget
  case existingDependency(dependencyName: String)
  case malformedManifest(error: String)
}

extension ManifestEditError: CustomStringConvertible {
  public var description: String {
    switch self {
    case .cannotFindPackage:
      return "invalid manifest: unable to find 'Package' declaration"
    case .cannotFindTargets:
      return "unable to find package targets in manifest"
    case .cannotFindTarget(targetName: let name):
      return "unable to find target named '\(name)' in package"
    case .cannotFindArrayLiteralArgument(argumentName: let name):
      return "unable to find array literal for '\(name)' argument"
    case .cannotAddSettingsToPluginTarget:
      return "plugin targets do not support settings"
    case .existingDependency(let name):
      return "unable to add dependency '\(name)' because it already exists in the list of dependencies"
    case .malformedManifest(let error):
      return "invalid manifest: \(error)"
    }
  }
}
