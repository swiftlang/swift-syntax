// swift-tools-version:4.2

import PackageDescription

let package = Package(
  name: "SwiftSyntax",
  products: [
    .library(name: "SwiftSyntax", targets: ["SwiftSyntax"]),
    .library(name: "SwiftSyntax-dynamic", type: .dynamic, targets: ["SwiftSyntax"]),
  ],
  targets: [
    .target(name: "SwiftSyntax"),
    .testTarget(name: "SwiftSyntaxTest", dependencies: ["SwiftSyntax"], exclude: ["Inputs"]),
    .target(name: "lit-test-helper", dependencies: ["SwiftSyntax"])
  ]
)
