// swift-tools-version:5.1

import PackageDescription
import Foundation

let package = Package(
  name: "SwiftSyntax",
  targets: [
    .target(name: "_CSwiftSyntax"),
    .testTarget(name: "SwiftSyntaxTest", dependencies: ["SwiftSyntax"]),
    .target(name: "SwiftSyntaxBuilder", dependencies: ["SwiftSyntax"]),
    .testTarget(name: "SwiftSyntaxBuilderTest", dependencies: ["SwiftSyntaxBuilder"]),
    .target(name: "SwiftSyntaxParser", dependencies: ["SwiftSyntax"]),
    .testTarget(name: "SwiftSyntaxParserTest", dependencies: ["SwiftSyntaxParser"], exclude: ["Inputs"]),
    .target(name: "lit-test-helper", dependencies: ["SwiftSyntax", "SwiftSyntaxParser"]),
    .testTarget(name: "PerformanceTest", dependencies: ["SwiftSyntax", "SwiftSyntaxParser"])
    // Also see targets added below
  ]
)

let swiftSyntaxTarget: PackageDescription.Target

/// If we are in a controlled CI environment, we can use internal compiler flags
/// to speed up the build or improve it.
if ProcessInfo.processInfo.environment["SWIFT_BUILD_SCRIPT_ENVIRONMENT"] != nil {
  // Enforcing exclusivity increases compile time of release builds by 2 minutes.
  // Disable it when we're in a controlled CI environment.
  let swiftSyntaxUnsafeFlags = ["-enforce-exclusivity=unchecked"]

  swiftSyntaxTarget = .target(name: "SwiftSyntax", dependencies: ["_CSwiftSyntax"],
                              swiftSettings: [.unsafeFlags(swiftSyntaxUnsafeFlags)]
  )
} else {
  swiftSyntaxTarget = .target(name: "SwiftSyntax", dependencies: ["_CSwiftSyntax"])
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
package.products.append(.library(name: "SwiftSyntaxParser", type: libraryType, targets: ["SwiftSyntaxParser"]))
package.products.append(.library(name: "SwiftSyntaxBuilder", type: libraryType, targets: ["SwiftSyntaxBuilder"]))
