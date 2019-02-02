// swift-tools-version:4.2

import PackageDescription

let package = Package(
  name: "SwiftSyntax",
  targets: [
    .target(name: "_CSwiftSyntax"),
    .target(name: "SwiftSyntax", dependencies: ["_CSwiftSyntax"]),
    .testTarget(name: "SwiftSyntaxTest", dependencies: ["SwiftSyntax"], exclude: ["Inputs"]),
    .target(name: "lit-test-helper", dependencies: ["SwiftSyntax"])
  ]
)

#if os(Linux)
import Glibc
#else
import Darwin.C
#endif

if getenv("SWIFT_SYNTAX_BUILD_SCRIPT") == nil {
  package.products.append(.library(name: "SwiftSyntax", targets: ["SwiftSyntax"]))
} else {
  package.products.append(.library(name: "SwiftSyntax", type: .dynamic, targets: ["SwiftSyntax"]))
}