//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2014-2020 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

/// Syntactic wrapper type that describes a product for refactoring
/// purposes but does not interpret its contents.
public struct ProductDescription {
  /// The name of the product.
  public let name: String

  /// The targets in the product.
  public let targets: [String]

  /// The type of product.
  public let type: ProductType

  public init(
    name: String,
    type: ProductType,
    targets: [String]
  ) {
    self.name = name
    self.type = type
    self.targets = targets
  }
}

extension ProductDescription: ManifestSyntaxRepresentable {
  /// The function name in the package manifest.
  ///
  /// Some of these are actually invalid, but it's up to the caller
  /// to check the precondition.
  private var functionName: String {
    switch type {
    case .executable: return "executable"
    case .library(_): return "library"
    case .macro: return "macro"
    case .plugin: return "plugin"
    case .snippet: return "snippet"
    case .test: return "test"
    }
  }

  func asSyntax() -> ExprSyntax {
    var arguments: [LabeledExprSyntax] = []
    arguments.append(label: "name", stringLiteral: name)

    // Libraries have a type.
    if case .library(let libraryType) = type {
      switch libraryType {
      case .automatic:
        break

      case .dynamic, .static:
        arguments.append(
          label: "type",
          expression: ".\(raw: libraryType.rawValue)"
        )
      }
    }

    arguments.appendIfNonEmpty(
      label: "targets",
      arrayLiteral: targets
    )

    let separateParen: String = arguments.count > 1 ? "\n" : ""
    let argumentsSyntax = LabeledExprListSyntax(arguments)
    return ".\(raw: functionName)(\(argumentsSyntax)\(raw: separateParen))"
  }
}
