// swift-tools-version:5.3

import PackageDescription
import Foundation

var swiftSyntaxUnsafeSwiftFlags: [String] = []

/// If we are in a controlled CI environment, we can use internal compiler flags
/// to speed up the build or improve it.
if ProcessInfo.processInfo.environment["SWIFT_BUILD_SCRIPT_ENVIRONMENT"] != nil {
  let groupFile = URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .appendingPathComponent("utils")
    .appendingPathComponent("group.json")

  swiftSyntaxUnsafeSwiftFlags += ["-Xfrontend", "-group-info-path",
                                "-Xfrontend", groupFile.path]
  // Enforcing exclusivity increases compile time of release builds by 2 minutes.
  // Disable it when we're in a controlled CI environment.
  swiftSyntaxUnsafeSwiftFlags += ["-enforce-exclusivity=unchecked"]
}

// Include the parser library as a binary dependency if both the host and the target are macOS.
//  - We need to require that the host is macOS (checked by `#if os(macOS)`) because package resolve will download and unzip the referenced framework, which requires `unzip` to be installed. Only macOS guarantees that `unzip` is installed, the Swift Docker images don’t have unzip installed, so package resolve would fail.
//  - We need to require that the target is macOS (checked by `.when`) because binary dependencies are only supported by SwiftPM on macOS.
#if os(macOS)
let parserLibraryTarget: [Target] = [.binaryTarget(
  name: "_InternalSwiftSyntaxParser",
  url: "https://github.com/apple/swift-syntax/releases/download/0.50600.0-SNAPSHOT-2022-01-24/_InternalSwiftSyntaxParser.xcframework.zip",
  checksum: "6d0a1b471cd5179f2669b46040d9e8aa92de31f7f82a9b096a2ee3e5d0c7afc1"
)]
let parserLibraryDependency: [Target.Dependency] = [.target(name: "_InternalSwiftSyntaxParser", condition: .when(platforms: [.macOS]))]
#else
let parserLibraryTarget: [Target] = []
let parserLibraryDependency: [Target.Dependency] = []
#endif

let package = Package(
  name: "SwiftSyntax",
  products: [
    .library(name: "SwiftSyntax", type: .static, targets: ["SwiftSyntax"]),
    .library(name: "SwiftSyntaxParser", type: .static, targets: ["SwiftSyntaxParser"]),
    .library(name: "SwiftSyntaxBuilder", type: .static, targets: ["SwiftSyntaxBuilder"])
  ],
  targets: [
    .target(name: "_CSwiftSyntax"),
    .target(
      name: "SwiftSyntax",
      dependencies: ["_CSwiftSyntax"] + parserLibraryDependency,
      exclude: [
        "SyntaxFactory.swift.gyb",
        "SyntaxTraits.swift.gyb",
        "Trivia.swift.gyb",
        "Misc.swift.gyb",
        "SyntaxRewriter.swift.gyb",
        "SyntaxEnum.swift.gyb",
        "SyntaxClassification.swift.gyb",
        "SyntaxBuilders.swift.gyb",
        "TokenKind.swift.gyb",
        "SyntaxVisitor.swift.gyb",
        "SyntaxCollections.swift.gyb",
        "SyntaxBaseNodes.swift.gyb",
        "SyntaxAnyVisitor.swift.gyb",
        "SyntaxNodes.swift.gyb.template",
        "SyntaxKind.swift.gyb",
      ],
      swiftSettings: [.unsafeFlags(swiftSyntaxUnsafeSwiftFlags)]
    ),
    .target(
      name: "SwiftSyntaxBuilder",
      dependencies: ["SwiftSyntax"],
      exclude: [
        "README.md",
        "gyb_helpers",
        "ExpressibleAsProtocols.swift.gyb",
        "BuildableBaseProtocols.swift.gyb",
        "BuildableCollectionNodes.swift.gyb",
        "BuildableNodes.swift.gyb",
        "ResultBuilders.swift.gyb",
        "Tokens.swift.gyb",
        "TokenSyntax.swift.gyb",
      ]
    ),
    .target(name: "SwiftSyntaxParser", dependencies: ["SwiftSyntax"], exclude: [
      "NodeDeclarationHash.swift.gyb"
    ]),
    .target(
      name: "lit-test-helper",
      dependencies: ["SwiftSyntax", "SwiftSyntaxParser"]
    ),
    .testTarget(
      name: "SwiftSyntaxTest",
      dependencies: ["SwiftSyntax"]
    ),
    .testTarget(
      name: "SwiftSyntaxBuilderTest",
      dependencies: ["SwiftSyntaxBuilder"]
    ),
    .testTarget(
      name: "SwiftSyntaxParserTest",
      dependencies: ["SwiftSyntaxParser"],
      exclude: ["Inputs"]
    ),
    .testTarget(
      name: "PerformanceTest",
      dependencies: ["SwiftSyntax", "SwiftSyntaxParser"],
      exclude: ["Inputs"]
    ),
  ] + parserLibraryTarget
)
