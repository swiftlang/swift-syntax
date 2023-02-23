// swift-tools-version: 5.7

import PackageDescription

let package = Package(
  name: "Examples",
  platforms: [
    .macOS(.v10_15)
  ],
  products: [
    .executable(name: "AddOneToIntegerLiterals", targets: ["AddOneToIntegerLiterals"]),
    .executable(name: "CodeGenerationUsingSwiftSyntaxBuilder", targets: ["CodeGenerationUsingSwiftSyntaxBuilder"]),
    .executable(name: "ExamplePlugin", targets: ["ExamplePlugin"]),
  ],
  dependencies: [
    .package(path: "../")
  ],
  targets: [
    .executableTarget(
      name: "AddOneToIntegerLiterals",
      dependencies: [
        .product(name: "SwiftParser", package: "swift-syntax"),
        .product(name: "SwiftSyntax", package: "swift-syntax"),
      ]
    ),
    .executableTarget(
      name: "CodeGenerationUsingSwiftSyntaxBuilder",
      dependencies: [
        .product(name: "SwiftSyntaxBuilder", package: "swift-syntax")
      ]
    ),
    .executableTarget(
      name: "ExamplePlugin",
      dependencies: [
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftDiagnostics", package: "swift-syntax"),
      ]
    ),
  ]
)
