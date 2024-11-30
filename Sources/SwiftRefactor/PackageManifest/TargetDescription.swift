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

/// Syntactic wrapper type that describes a target for refactoring
/// purposes but does not interpret its contents.
public struct TargetDescription {
  public let name: String

  public enum Dependency {
    case target(name: String)
    case product(name: String, package: String?)
  }
}

extension TargetDescription.Dependency: ManifestSyntaxRepresentable {
  func asSyntax() -> ExprSyntax {
    switch self {
    case .target(name: let name):
      ".target(name: \(literal: name))"

    case .product(name: let name, package: nil):
      ".product(name: \(literal: name))"

    case .product(name: let name, package: let package):
      ".product(name: \(literal: name), package: \(literal: package))"
    }
  }
}
