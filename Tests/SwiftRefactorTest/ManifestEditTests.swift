//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(FixItApplier) import SwiftIDEUtils
import SwiftParser
import SwiftRefactor
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest
import _SwiftSyntaxTestSupport

final class ManifestEditTests: XCTestCase {
  static let swiftSystemURL: SourceControlURL = SourceControlURL(
    "https://github.com/apple/swift-system.git"
  )

  static let swiftSystemPackageDependency: PackageDependency = .sourceControl(
    .init(
      identity: PackageIdentity("swift-system"),
      location: .remote(swiftSystemURL),
      requirement: .branch("main")
    )
  )

  func testAddPackageDependencyExistingComma() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages",
          dependencies: [
            .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1"),
          ]
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            dependencies: [
              .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1"),
              .package(url: "https://github.com/apple/swift-system.git", branch: "main"),
            ]
        )
        """,
      provider: AddPackageDependency.self,
      context: .init(
        dependency: .sourceControl(
          .init(
            identity: PackageIdentity("swift-system"),
            location: .remote(Self.swiftSystemURL),
            requirement: .branch("main")
          )
        )
      )
    )
  }

  func testAddPackageDependencyExistingNoComma() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages",
          dependencies: [
            .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1")
          ]
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            dependencies: [
              .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1"),
              .package(url: "https://github.com/apple/swift-system.git", exact: "510.0.0"),
            ]
        )
        """,
      provider: AddPackageDependency.self,
      context: .init(
        dependency: .sourceControl(
          .init(
            identity: PackageIdentity("swift-system"),
            location: .remote(Self.swiftSystemURL),
            requirement: .exact(SemanticVersion("510.0.0"))
          )
        )
      )
    )
  }

  func testAddPackageDependencyExistingAppended() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages",
          dependencies: [
            .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1")
          ] + []
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            dependencies: [
              .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1"),
              .package(url: "https://github.com/apple/swift-system.git", from: "510.0.0"),
            ] + []
        )
        """,
      provider: AddPackageDependency.self,
      context: .init(
        dependency: .sourceControl(
          .init(
            identity: PackageIdentity("swift-system"),
            location: .remote(Self.swiftSystemURL),
            requirement: .rangeFrom(SemanticVersion("510.0.0"))
          )
        )
      )
    )
  }

  func testAddPackageDependencyExistingOneLine() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages",
          dependencies: [ .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1") ]
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            dependencies: [ .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1"), .package(url: "https://github.com/apple/swift-system.git", from: "510.0.0"),]
        )
        """,
      provider: AddPackageDependency.self,
      context: .init(
        dependency: .sourceControl(
          .init(
            identity: PackageIdentity("swift-system"),
            location: .remote(Self.swiftSystemURL),
            requirement: .rangeFrom(SemanticVersion("510.0.0"))
          )
        )
      )
    )
  }

  func testAddPackageDependencyExistingEmpty() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages",
          dependencies: [ ]
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            dependencies: [
                .package(url: "https://github.com/apple/swift-system.git", "508.0.0" ..< "510.0.0"),
            ]
        )
        """,
      provider: AddPackageDependency.self,
      context: .init(
        dependency: .sourceControl(
          .init(
            identity: PackageIdentity("swift-system"),
            location: .remote(Self.swiftSystemURL),
            requirement: .range(lowerBound: SemanticVersion("508.0.0"), upperBound: SemanticVersion("510.0.0"))
          )
        )
      )
    )
  }

  func testAddPackageDependencyNoExistingAtEnd() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages"
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            dependencies: [
                .package(url: "https://github.com/apple/swift-system.git", branch: "main"),
            ]
        )
        """,
      provider: AddPackageDependency.self,
      context: .init(
        dependency: Self.swiftSystemPackageDependency
      )
    )
  }

  func testAddPackageDependencyNoExistingMiddle() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages",
          targets: []
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            dependencies: [
                .package(url: "https://github.com/apple/swift-system.git", branch: "main"),
            ],
            targets: []
        )
        """,
      provider: AddPackageDependency.self,
      context: .init(
        dependency: Self.swiftSystemPackageDependency
      )
    )
  }

  func testAddPackageDependencyErrors() {
    XCTAssertThrows(
      try AddPackageDependency.manifestRefactor(
        syntax: """
          // swift-tools-version: 5.5
          let package: Package = .init(
              name: "packages"
          )
          """,
        in: .init(dependency: Self.swiftSystemPackageDependency)
      )
    ) { (error: ManifestEditError) in
      if case .cannotFindPackage = error {
        return true
      } else {
        return false
      }
    }

    XCTAssertThrows(
      try AddPackageDependency.manifestRefactor(
        syntax: """
          // swift-tools-version: 5.5
          let package = Package(
              name: "packages",
              dependencies: blah
          )
          """,
        in: .init(dependency: Self.swiftSystemPackageDependency)
      )
    ) { (error: ManifestEditError) in
      if case .cannotFindArrayLiteralArgument(argumentName: "dependencies", node: _) = error {
        return true
      } else {
        return false
      }
    }
  }
}

/// Assert that applying the given edit/refactor operation to the manifest
/// produces the expected manifest source file and the expected auxiliary
/// files.
func assertManifestRefactor<Provider: ManifestEditRefactoringProvider>(
  _ originalManifest: SourceFileSyntax,
  expectedManifest: SourceFileSyntax,
  expectedAuxiliarySources: [RelativePath: SourceFileSyntax] = [:],
  provider: Provider.Type,
  context: Provider.Context,
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  return try assertManifestRefactor(
    originalManifest,
    expectedManifest: expectedManifest,
    expectedAuxiliarySources: expectedAuxiliarySources,
    file: file,
    line: line
  ) { (manifest) in
    try provider.manifestRefactor(syntax: manifest, in: context)
  }
}

/// Assert that applying the given edit/refactor operation to the manifest
/// produces the expected manifest source file and the expected auxiliary
/// files.
func assertManifestRefactor(
  _ originalManifest: SourceFileSyntax,
  expectedManifest: SourceFileSyntax,
  expectedAuxiliarySources: [RelativePath: SourceFileSyntax] = [:],
  file: StaticString = #filePath,
  line: UInt = #line,
  operation: (SourceFileSyntax) throws -> PackageEditResult
) rethrows {
  let edits = try operation(originalManifest)
  let editedManifestSource = FixItApplier.apply(
    edits: edits.manifestEdits,
    to: originalManifest
  )

  let editedManifest = Parser.parse(source: editedManifestSource)
  assertStringsEqualWithDiff(
    editedManifest.description,
    expectedManifest.description,
    file: file,
    line: line
  )

  // Check all of the auxiliary sources.
  for (auxSourcePath, auxSourceSyntax) in edits.auxiliaryFiles {
    guard let expectedSyntax = expectedAuxiliarySources[auxSourcePath] else {
      XCTFail("unexpected auxiliary source file \(auxSourcePath)")
      return
    }

    assertStringsEqualWithDiff(
      auxSourceSyntax.description,
      expectedSyntax.description,
      file: file,
      line: line
    )
  }

  XCTAssertEqual(
    edits.auxiliaryFiles.count,
    expectedAuxiliarySources.count,
    "didn't get all of the auxiliary files we expected"
  )
}

func XCTAssertThrows<T: Swift.Error, Ignore>(
  _ expression: @autoclosure () throws -> Ignore,
  file: StaticString = #filePath,
  line: UInt = #line,
  _ errorHandler: (T) -> Bool
) {
  do {
    let result = try expression()
    XCTFail("body completed successfully: \(result)", file: file, line: line)
  } catch let error as T {
    XCTAssertTrue(errorHandler(error), "Error handler returned false", file: file, line: line)
  } catch {
    XCTFail("unexpected error thrown: \(error)", file: file, line: line)
  }
}
