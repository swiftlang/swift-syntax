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

/// Add a target to a manifest's source code.
@_spi(PackageRefactor)
public struct AddPackageTarget: EditRefactoringProvider {
  public struct Context {
    public let target: PackageTarget
    public var testHarness: TestHarness

    public init(
      target: PackageTarget,
      testHarness: TestHarness = .default
    ) {
      self.target = target
      self.testHarness = testHarness
    }
  }

  /// The set of argument labels that can occur after the "targets"
  /// argument in the Package initializers.
  private static let argumentLabelsAfterTargets: Set<String> = [
    "swiftLanguageVersions",
    "swiftLanguageModes",
    "cLanguageStandard",
    "cxxLanguageStandard",
  ]

  /// The kind of test harness to use. This isn't part of the manifest
  /// itself, but is used to guide the generation process.
  public enum TestHarness: String, Codable, Sendable {
    /// Don't use any library
    case none

    /// Create a test using the XCTest library.
    case xctest

    /// Create a test using the swift-testing package.
    case swiftTesting = "swift-testing"

    /// The default testing library to use.
    public static let `default`: TestHarness = .swiftTesting
  }

  /// Add the given target to the manifest, producing a set of edit results
  /// that updates the manifest and adds some source files to stub out the
  /// new target.
  public static func textRefactor(
    syntax manifest: SourceFileSyntax,
    in context: Context
  ) throws -> [SourceEdit] {
    guard let packageCall = manifest.findCall(calleeName: "Package") else {
      throw ManifestEditError.cannotFindPackage
    }

    // Create a mutable version of target to which we can add more
    // content when needed.
    var target = context.target

    // Add dependencies needed for various targets.
    switch target.type {
    case .macro:
      // Macro targets need to depend on a couple of libraries from
      // SwiftSyntax.
      target.dependencies.append(contentsOf: macroTargetDependencies)

    default:
      break
    }

    var newPackageCall = try packageCall.appendingToArrayArgument(
      label: "targets",
      labelsAfter: Self.argumentLabelsAfterTargets,
      newElement: target.asSyntax()
    )

    // Perform any other actions that are needed for this target type.
    var extraManifestEdits: [SourceEdit] = []
    switch target.type {
    case .macro:
      if !manifest.containsStringLiteral("swift-syntax") {
        newPackageCall =
          try AddPackageDependency
          .addPackageDependencyLocal(
            .swiftSyntax(from: "<#version#>"),
            to: newPackageCall
          )

        // Look for the first import declaration and insert an
        // import of `CompilerPluginSupport` there.
        let newImport = "import CompilerPluginSupport\n"
        for node in manifest.statements {
          if let importDecl = node.item.as(ImportDeclSyntax.self) {
            let insertPos = importDecl
              .positionAfterSkippingLeadingTrivia
            extraManifestEdits.append(
              SourceEdit(
                range: insertPos..<insertPos,
                replacement: newImport
              )
            )
            break
          }
        }
      }

    default: break
    }

    return [
      .replace(packageCall, with: newPackageCall.description)
    ] + extraManifestEdits
  }
}

/// The set of dependencies we need to introduce to a newly-created macro
/// target.
private let macroTargetDependencies: [PackageTarget.Dependency] = [
  .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
  .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
]

/// The package dependency for swift-syntax, for use in macros.
fileprivate extension PackageDependency {
  /// Source control URL for the swift-syntax package.
  static var swiftSyntaxURL: String {
    "https://github.com/swiftlang/swift-syntax.git"
  }

  /// Package dependency on the swift-syntax package starting from a partial version.
  static func swiftSyntax(from version: String) -> PackageDependency {
    return .sourceControl(
      .init(
        location: swiftSyntaxURL,
        requirement: .rangeFrom(version)
      )
    )
  }
}

extension SourceFileSyntax {
  private class ContainsLiteralVisitor: SyntaxVisitor {
    let string: String
    var found: Bool = false

    init(string: String) {
      self.string = string
      super.init(viewMode: .sourceAccurate)
    }

    override func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
      if let representedLiteralValue = node.representedLiteralValue,
        representedLiteralValue == string
      {
        found = true
      }

      return .skipChildren
    }
  }

  /// Determine whether this source file contains a string literal
  /// matching the given contents.
  fileprivate func containsStringLiteral(_ contents: String) -> Bool {
    let visitor = ContainsLiteralVisitor(string: contents)
    visitor.walk(self)
    return visitor.found
  }
}
