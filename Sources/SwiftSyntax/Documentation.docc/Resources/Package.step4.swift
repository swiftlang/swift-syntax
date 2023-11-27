// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "importformatter",
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .executable(
      name: "importformatter",
      targets: ["importformatter"]
    )
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(url: "https://github.com/apple/swift-syntax.git", branch: "main")
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .executableTarget(
      name: "importformatter",
      dependencies: [
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftParser", package: "swift-syntax"),
      ]
    ),
    .testTarget(
      name: "importformatterTests",
      dependencies: ["importformatter"]
    ),
  ]
)
