// swift-tools-version:5.7

import Foundation
import PackageDescription

let package = Package(
  name: "swift-syntax-dev-utils",
  platforms: [
    .macOS(.v13)
  ],
  products: [
    .executable(name: "swift-syntax-dev-utils", targets: ["swift-syntax-dev-utils"])
  ],
  targets: [
    .executableTarget(
      name: "swift-syntax-dev-utils",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser")
      ]
    )
  ]
)

if ProcessInfo.processInfo.environment["SWIFTCI_USE_LOCAL_DEPS"] == nil {
  // Building standalone.
  package.dependencies += [
    .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.2")
  ]
} else {
  package.dependencies += [
    .package(path: "../../swift-argument-parser")
  ]
}
