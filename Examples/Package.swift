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
  ],
  dependencies: [
    .package(name: "swift-syntax", path: "../")
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

#if !os(Windows)
// We can't write a test target for macros on Windows because that results in duplicate definitoions of `main`: Once
// from the macro (which is effectively an executable), and once from the test bundle.
package.targets.append(
  .testTarget(
    name: "MacroExamplesImplementationTests",
    dependencies: [
      "MacroExamplesImplementation",
      .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
      .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
    ],
    path: "Tests/MacroExamples/Implementation"
  )
)
#else
// Add a dummy test target on Windows so that `swift test` invocations from `swift-syntax-dev-utils` don't fail.
package.targets.append(.testTarget(name: "Dummy", dependencies: []))
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
