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
public struct AddPackageTarget: ManifestEditRefactoringProvider {
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
  public static func manifestRefactor(
    syntax manifest: SourceFileSyntax,
    in context: Context
  ) throws -> PackageEdit {
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

    let outerDirectory: String?
    switch target.type {
    case .binary, .plugin, .system: outerDirectory = nil
    case .executable, .library, .macro: outerDirectory = "Sources"
    case .test: outerDirectory = "Tests"
    }

    guard let outerDirectory else {
      return PackageEdit(
        manifestEdits: [
          .replace(packageCall, with: newPackageCall.description)
        ]
      )
    }

    let outerPath = outerDirectory

    /// The set of auxiliary files this refactoring will create.
    var auxiliaryFiles: AuxiliaryFiles = []

    // Add the primary source file. Every target type has this.
    addPrimarySourceFile(
      outerPath: outerPath,
      target: target,
      in: context,
      to: &auxiliaryFiles
    )

    // Perform any other actions that are needed for this target type.
    var extraManifestEdits: [SourceEdit] = []
    switch target.type {
    case .macro:
      addProvidedMacrosSourceFile(
        outerPath: outerPath,
        target: target,
        to: &auxiliaryFiles
      )

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

    return PackageEdit(
      manifestEdits: [
        .replace(packageCall, with: newPackageCall.description)
      ] + extraManifestEdits,
      auxiliaryFiles: auxiliaryFiles
    )
  }

  /// Add the primary source file for a target to the list of auxiliary
  /// source files.
  fileprivate static func addPrimarySourceFile(
    outerPath: String,
    target: PackageTarget,
    in context: Context,
    to auxiliaryFiles: inout AuxiliaryFiles
  ) {
    let sourceFilePath = "\(outerPath)/\(target.name)/\(target.name).swift"

    // Introduce imports for each of the dependencies that were specified.
    var importModuleNames = target.dependencies.map {
      $0.name
    }

    // Add appropriate test module dependencies.
    if target.type == .test {
      switch context.testHarness {
      case .none:
        break

      case .xctest:
        importModuleNames.append("XCTest")

      case .swiftTesting:
        importModuleNames.append("Testing")
      }
    }

    let importDecls = importModuleNames.lazy.sorted().map { name in
      DeclSyntax("import \(raw: name)\n")
    }

    let imports = CodeBlockItemListSyntax {
      for importDecl in importDecls {
        importDecl
      }
    }

    let sourceFileText: SourceFileSyntax
    switch target.type {
    case .binary, .plugin, .system:
      fatalError("should have exited above")

    case .macro:
      sourceFileText = """
        \(imports)
        struct \(raw: target.sanitizedName): Macro {
            /// TODO: Implement one or more of the protocols that inherit
            /// from Macro. The appropriate macro protocol is determined
            /// by the "macro" declaration that \(raw: target.sanitizedName) implements.
            /// Examples include:
            ///     @freestanding(expression) macro --> ExpressionMacro
            ///     @attached(member) macro         --> MemberMacro
        }
        """

    case .test:
      switch context.testHarness {
      case .none:
        sourceFileText = """
          \(imports)
          // Test code here
          """

      case .xctest:
        sourceFileText = """
          \(imports)
          class \(raw: target.sanitizedName)Tests: XCTestCase {
              func test\(raw: target.sanitizedName)() {
                  XCTAssertEqual(42, 17 + 25)
              }
          }
          """

      case .swiftTesting:
        sourceFileText = """
          \(imports)
          @Suite
          struct \(raw: target.sanitizedName)Tests {
              @Test("\(raw: target.sanitizedName) tests")
              func example() {
                  #expect(42 == 17 + 25)
              }
          }
          """
      }

    case .library:
      sourceFileText = """
        \(imports)
        """

    case .executable:
      sourceFileText = """
        \(imports)
        @main
        struct \(raw: target.sanitizedName)Main {
            static func main() {
                print("Hello, world")
            }
        }
        """
    }

    auxiliaryFiles.addSourceFile(
      path: sourceFilePath,
      sourceCode: sourceFileText
    )
  }

  /// Add a file that introduces the main entrypoint and provided macros
  /// for a macro target.
  fileprivate static func addProvidedMacrosSourceFile(
    outerPath: String,
    target: PackageTarget,
    to auxiliaryFiles: inout AuxiliaryFiles
  ) {
    auxiliaryFiles.addSourceFile(
      path: "\(outerPath)/\(target.name)/ProvidedMacros.swift",
      sourceCode: """
        import SwiftCompilerPlugin

        @main
        struct \(raw: target.sanitizedName)Macros: CompilerPlugin {
            let providingMacros: [Macro.Type] = [
                \(raw: target.sanitizedName).self,
            ]
        }
        """
    )
  }
}

/// The array of auxiliary files that can be added by a package editing
/// operation.
private typealias AuxiliaryFiles = [(String, SourceFileSyntax)]

fileprivate extension AuxiliaryFiles {
  /// Add a source file to the list of auxiliary files.
  mutating func addSourceFile(
    path: String,
    sourceCode: SourceFileSyntax
  ) {
    self.append((path, sourceCode))
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
