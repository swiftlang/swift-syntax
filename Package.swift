// swift-tools-version:4.2

import PackageDescription

let package = Package(
  name: "SwiftSyntax",
  products: [
    .library(name: "SwiftSyntax", type: .dynamic, targets: ["SwiftSyntax"]),
  ],
  dependencies: [
  	.package(url: "https://github.com/apple/swift-package-manager.git", .branch("master"))
  ],
  targets: [
    .target(name: "SwiftSyntax", dependencies: ["Utility"]),
    .testTarget(name: "SwiftSyntaxTest", dependencies: ["SwiftSyntax"], exclude: ["Inputs"]),
    .target(name: "lit-test-helper", dependencies: ["SwiftSyntax"])
  ]
)
