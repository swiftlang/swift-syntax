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

/// Add a product to the manifest's source code.
@_spi(PackageRefactor)
public struct AddProduct: EditRefactoringProvider {
  public struct Context {
    public let product: ProductDescription

    public init(product: ProductDescription) {
      self.product = product
    }
  }
  /// The set of argument labels that can occur after the "products"
  /// argument in the Package initializers.
  private static let argumentLabelsAfterProducts: Set<String> = [
    "dependencies",
    "targets",
    "swiftLanguageVersions",
    "cLanguageStandard",
    "cxxLanguageStandard",
  ]

  /// Produce the set of source edits needed to add the given package
  /// dependency to the given manifest file.
  public static func textRefactor(
    syntax manifest: SourceFileSyntax,
    in context: Context
  ) throws -> [SourceEdit] {
    let product = context.product

    guard let packageCall = manifest.findCall(calleeName: "Package") else {
      throw ManifestEditError.cannotFindPackage
    }

    let newPackageCall = try packageCall.appendingToArrayArgument(
      label: "products",
      labelsAfter: argumentLabelsAfterProducts,
      newElement: product.asSyntax()
    )

    return [
      .replace(packageCall, with: newPackageCall.description)
    ]
  }
}
