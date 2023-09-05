// swift-tools-version: 5.9

import CompilerPluginSupport
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
    .macro(
      name: "MacroExamplesImplementation",
      dependencies: [
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftDiagnostics", package: "swift-syntax"),
      ],
      path: "Sources/MacroExamples/Implementation"
    ),
    .testTarget(
      name: "MacroExamplesImplementationTests",
      dependencies: [
        "MacroExamplesImplementation"
      ],
      path: "Tests/MacroExamples/Implementation"
    ),
  ]
)

// The following targets are added only if the OS is macOS. This is because Swift macros are currently
// not available on other platforms. As a result, we're guarding these targets with `#if os(macOS)`
// to ensure that they are only included in the package when building on a macOS system.
#if os(macOS)
package.targets.append(
  contentsOf: [
    .target(
      name: "MacroExamplesInterface",
      dependencies: [
        "MacroExamplesImplementation"
      ],
      path: "Sources/MacroExamples/Interface"
    ),
    .executableTarget(
      name: "MacroExamplesPlayground",
      dependencies: [
        "MacroExamplesInterface"
      ],
      path: "Sources/MacroExamples/Playground"
    ),
  ]
)
#endif

// This is a fake target that depends on all targets in the package.
// We need to define it manually because the `Examples-Package` target doesn't exist for `swift build`.

package.targets.append(
  .target(
    name: "Examples-all",
    dependencies: package.targets.compactMap {
      if $0.type == .test {
        return nil
      } else {
        return .byName(name: $0.name)
      }
    }
  )
)
