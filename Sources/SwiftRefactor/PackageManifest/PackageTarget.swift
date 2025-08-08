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

/// Syntactic wrapper type that describes a target for refactoring
/// purposes but does not interpret its contents.
@_spi(PackageRefactor)
public struct PackageTarget {
  public let name: String

  /// The type of target.
  public let type: TargetKind

  public internal(set) var dependencies: [Dependency]

  public let path: String?

  public let url: String?

  public let checksum: String?

  /// The usages of package plugins by the target.
  public let pluginUsages: [PluginUsage]?

  /// Represents a target's usage of a plugin target or product.
  public enum PluginUsage {
    case plugin(name: String, package: String?)
  }

  public enum TargetKind: String {
    case binary
    case executable
    case library
    case macro
    case plugin
    case system
    case test
  }

  public enum Dependency: Sendable {
    case byName(name: String)
    case target(name: String)
    case product(name: String, package: String?)
  }

  public init(
    name: String,
    type: TargetKind = .library,
    dependencies: [Dependency] = [],
    path: String? = nil,
    url: String? = nil,
    checksum: String? = nil,
    pluginUsages: [PluginUsage]? = nil
  ) {
    self.name = name
    self.type = type
    self.dependencies = dependencies
    self.path = path
    self.url = url
    self.checksum = checksum
    self.pluginUsages = pluginUsages
  }
}

extension PackageTarget: ManifestSyntaxRepresentable {
  /// The function name in the package manifest.
  private var functionName: String {
    switch type {
    case .binary: return "binaryTarget"
    case .executable: return "executableTarget"
    case .library: return "target"
    case .macro: return "macro"
    case .plugin: return "plugin"
    case .system: return "systemLibrary"
    case .test: return "testTarget"
    }
  }

  func asSyntax() -> ExprSyntax {
    var arguments: [LabeledExprSyntax] = []
    arguments.append(label: "name", stringLiteral: name)
    // FIXME: pluginCapability

    arguments.appendIfNonEmpty(
      label: "dependencies",
      arrayLiteral: dependencies
    )

    arguments.appendIf(label: "path", stringLiteral: path)
    arguments.appendIf(label: "url", stringLiteral: url)

    // Only for plugins
    arguments.appendIf(label: "checksum", stringLiteral: checksum)

    if let pluginUsages {
      arguments.appendIfNonEmpty(label: "plugins", arrayLiteral: pluginUsages)
    }

    let separateParen: String = arguments.count > 1 ? "\n" : ""
    let argumentsSyntax = LabeledExprListSyntax(arguments)
    return ".\(raw: functionName)(\(argumentsSyntax)\(raw: separateParen))"
  }
}

extension PackageTarget.Dependency: ManifestSyntaxRepresentable {
  func asSyntax() -> ExprSyntax {
    switch self {
    case .byName(let name):
      return "\(literal: name)"

    case .target(let name):
      return ".target(name: \(literal: name))"

    case .product(let name, package: nil):
      return ".product(name: \(literal: name))"

    case .product(let name, let package):
      return ".product(name: \(literal: name), package: \(literal: package))"
    }
  }
}

extension PackageTarget.PluginUsage: ManifestSyntaxRepresentable {
  func asSyntax() -> ExprSyntax {
    switch self {
    case .plugin(let name, package: nil):
      return ".plugin(name: \(literal: name))"

    case .plugin(let name, let package):
      return ".plugin(name: \(literal: name), package: \(literal: package))"
    }
  }
}
