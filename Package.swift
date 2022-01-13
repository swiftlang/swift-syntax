// swift-tools-version:5.3

import PackageDescription
import Foundation

let package = Package(
  name: "SwiftSyntax",
  targets: [
    .target(name: "_CSwiftSyntax", exclude: ["README.md"]),
    .testTarget(name: "SwiftSyntaxTest", dependencies: ["SwiftSyntax"], exclude: ["Inputs"]),
    .target(name: "SwiftSyntaxBuilder", dependencies: ["SwiftSyntax"], exclude: ["README.md", "Tokens.swift.gyb"]),
    .testTarget(name: "SwiftSyntaxBuilderTest", dependencies: ["SwiftSyntaxBuilder"]),
    .target(name: "lit-test-helper", dependencies: ["SwiftSyntax"]),
    .testTarget(name: "PerformanceTest", dependencies: ["SwiftSyntax"], exclude: ["Inputs"]),
    .binaryTarget(name: "_InternalSwiftSyntaxParser", url: "https://github.com/ahoppen/swift-syntax/releases/download/ahoppen-0.50500.2/_InternalSwiftSyntaxParser.xcframework.zip", checksum: "f1326cfbaee9924ba925c33a3c85fd326cdc2771f68c23653b7cd8d520d0afd4"),
    // Also see targets added below
  ]
)

let swiftSyntaxTarget: PackageDescription.Target

let swiftSyntaxGybSources = [
  "SyntaxCollections.swift.gyb",
  "TokenKind.swift.gyb",
  "SyntaxBuilders.swift.gyb",
  "Trivia.swift.gyb",
  "SyntaxKind.swift.gyb",
  "SyntaxBaseNodes.swift.gyb",
  "SyntaxFactory.swift.gyb",
  "SyntaxEnum.swift.gyb",
  "SyntaxRewriter.swift.gyb",
  "SyntaxTraits.swift.gyb",
  "Misc.swift.gyb",
  "SyntaxClassification.swift.gyb",
  "SyntaxNodes.swift.gyb.template",
  "SyntaxAnyVisitor.swift.gyb",
  "SyntaxVisitor.swift.gyb",
]

/// If we are in a controlled CI environment, we can use internal compiler flags
/// to speed up the build or improve it.
if ProcessInfo.processInfo.environment["SWIFT_BUILD_SCRIPT_ENVIRONMENT"] != nil {
  let groupFile = URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .appendingPathComponent("utils")
    .appendingPathComponent("group.json")

  var swiftSyntaxUnsafeFlags = ["-Xfrontend", "-group-info-path",
                                "-Xfrontend", groupFile.path]
  // Enforcing exclusivity increases compile time of release builds by 2 minutes.
  // Disable it when we're in a controlled CI environment.
  swiftSyntaxUnsafeFlags += ["-enforce-exclusivity=unchecked"]

  swiftSyntaxTarget = .target(name: "SwiftSyntax", dependencies: ["_CSwiftSyntax", "_InternalSwiftSyntaxParser"], exclude: swiftSyntaxGybSources,
                              swiftSettings: [.unsafeFlags(swiftSyntaxUnsafeFlags)]
  )
} else {
  swiftSyntaxTarget = .target(name: "SwiftSyntax", dependencies: ["_CSwiftSyntax", "_InternalSwiftSyntaxParser"], exclude: swiftSyntaxGybSources)
}

package.targets.append(swiftSyntaxTarget)

let libraryType: Product.Library.LibraryType

/// When we're in a build-script environment, we want to build a dylib instead
/// of a static library since we install the dylib into the toolchain.
if ProcessInfo.processInfo.environment["SWIFT_BUILD_SCRIPT_ENVIRONMENT"] != nil {
  libraryType = .dynamic
} else {
  libraryType = .static
}

package.products.append(.library(name: "SwiftSyntax", type: libraryType, targets: ["SwiftSyntax"]))
package.products.append(.library(name: "SwiftSyntaxBuilder", type: libraryType, targets: ["SwiftSyntaxBuilder"]))
