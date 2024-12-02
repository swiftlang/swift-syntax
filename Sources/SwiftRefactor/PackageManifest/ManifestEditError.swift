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

import SwiftSyntax

/// An error describing problems that can occur when attempting to edit a
/// package manifest programattically.
public enum ManifestEditError: Error {
  case cannotFindPackage
  case cannotFindTargets
  case cannotFindTarget(targetName: String)
  case cannotFindArrayLiteralArgument(argumentName: String, node: Syntax)
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
    case .cannotFindArrayLiteralArgument(argumentName: let name, node: _):
      return "unable to find array literal for '\(name)' argument"
    }
  }
}
