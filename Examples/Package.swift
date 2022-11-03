// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Examples",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .executable(name: "AddOneToIntegerLiterals", targets: ["AddOneToIntegerLiterals"]),
        .executable(name: "CodeGenerationUsingSwiftSyntaxBuilder", targets: ["CodeGenerationUsingSwiftSyntaxBuilder"]),
    ],
    dependencies: [
        .package(path: "../"),
    ],
    targets: [
        .executableTarget(
            name: "AddOneToIntegerLiterals",
            dependencies: [
                .product(name: "SwiftParser", package: "swift-syntax"),
                .product(name: "SwiftSyntax", package: "swift-syntax"),
            ],
            path: ".",
            exclude: ["README.md", "CodeGenerationUsingSwiftSyntaxBuilder.swift"]
        ),
        .executableTarget(
            name: "CodeGenerationUsingSwiftSyntaxBuilder",
            dependencies: [
                .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
            ],
            path: ".",
            exclude: ["README.md", "AddOneToIntegerLiterals.swift"]
        ),
    ]
)
