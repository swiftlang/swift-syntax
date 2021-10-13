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
  let groupFile = URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .appendingPathComponent("utils")
    .appendingPathComponent("group.json")

  var swiftSyntaxUnsafeFlags = ["-Xfrontend", "-group-info-path",
                                "-Xfrontend", groupFile.path]
  // Enforcing exclusivity increases compile time of release builds by 2 minutes.
  // Disable it when we're in a controlled CI environment.
  swiftSyntaxUnsafeFlags += ["-enforce-exclusivity=unchecked"]

  swiftSyntaxTarget = .target(name: "SwiftSyntax", dependencies: ["_CSwiftSyntax"],
                              swiftSettings: [.unsafeFlags(swiftSyntaxUnsafeFlags)]
  )
} else {
  swiftSyntaxTarget = .target(name: "SwiftSyntax", dependencies: ["_CSwiftSyntax"])
}

package.targets.append(swiftSyntaxTarget)

package.products.append(.library(name: "SwiftSyntax", type: .static, targets: ["SwiftSyntax"]))
package.products.append(.library(name: "SwiftSyntaxParser", type: .static, targets: ["SwiftSyntaxParser"]))
package.products.append(.library(name: "SwiftSyntaxBuilder", type: .static, targets: ["SwiftSyntaxBuilder"]))
