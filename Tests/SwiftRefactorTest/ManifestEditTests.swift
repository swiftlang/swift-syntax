//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(FixItApplier) import SwiftIDEUtils
import SwiftParser
@_spi(PackageRefactor) import SwiftRefactor
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest
import _SwiftSyntaxTestSupport

final class ManifestEditTests: XCTestCase {
  static let swiftSystemURL: String = "https://github.com/apple/swift-system.git"

  static let swiftSystemPackageDependency: PackageDependency = .sourceControl(
    .init(
      location: swiftSystemURL,
      requirement: .branch("main")
    )
  )

  func testAddPackageDependencyExistingComma() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages",
          dependencies: [
            .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1"),
          ]
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            dependencies: [
              .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1"),
              .package(url: "https://github.com/apple/swift-system.git", branch: "main"),
            ]
        )
        """,
      provider: AddPackageDependency.self,
      context: .init(
        dependency: .sourceControl(
          .init(
            location: Self.swiftSystemURL,
            requirement: .branch("main")
          )
        )
      )
    )
  }

  func testAddPackageDependencyExistingNoComma() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages",
          dependencies: [
            .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1")
          ]
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            dependencies: [
              .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1"),
              .package(url: "https://github.com/apple/swift-system.git", exact: "510.0.0"),
            ]
        )
        """,
      provider: AddPackageDependency.self,
      context: .init(
        dependency: .sourceControl(
          .init(
            location: Self.swiftSystemURL,
            requirement: .exact("510.0.0")
          )
        )
      )
    )

    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages",
          dependencies: [
            /* test */ .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1")
          ]
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            dependencies: [
              /* test */ .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1"),
              .package(url: "https://github.com/apple/swift-system.git", exact: "510.0.0"),
            ]
        )
        """,
      provider: AddPackageDependency.self,
      context: .init(
        dependency: .sourceControl(
          .init(
            location: Self.swiftSystemURL,
            requirement: .exact("510.0.0")
          )
        )
      )
    )

    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages",
          dependencies: [
            /* test */
            .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1")
          ]
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            dependencies: [
              /* test */
              .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1"),
              .package(url: "https://github.com/apple/swift-system.git", exact: "510.0.0"),
            ]
        )
        """,
      provider: AddPackageDependency.self,
      context: .init(
        dependency: .sourceControl(
          .init(
            location: Self.swiftSystemURL,
            requirement: .exact("510.0.0")
          )
        )
      )
    )
  }

  func testAddPackageDependencyDuplicates() throws {
    XCTAssertThrowsError(
      try AddPackageDependency.manifestRefactor(
        syntax: """
          // swift-tools-version: 5.5
          let package = Package(
              name: "packages",
              dependencies: [
                .package(url: "https://github.com/apple/swift-system.git", from: "510.0.1")
              ]
          )
          """,
        in: .init(dependency: Self.swiftSystemPackageDependency)
      )
    ) { (error: any Error) in
      guard let error = error as? ManifestEditError,
        case .existingDependency("https://github.com/apple/swift-system.git") = error
      else {
        XCTFail("unexpected error thrown: \(error)")
        return
      }
    }
  }

  func testAddPackageDependencyExistingAppended() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages",
          dependencies: [
            .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1")
          ] + []
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            dependencies: [
              .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1"),
              .package(url: "https://github.com/apple/swift-system.git", from: "510.0.0"),
            ] + []
        )
        """,
      provider: AddPackageDependency.self,
      context: .init(
        dependency: .sourceControl(
          .init(
            location: Self.swiftSystemURL,
            requirement: .rangeFrom("510.0.0")
          )
        )
      )
    )
  }

  func testAddPackageDependencyExistingOneLine() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages",
          dependencies: [ .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1") ]
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            dependencies: [ .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1"), .package(url: "https://github.com/apple/swift-system.git", from: "510.0.0"),]
        )
        """,
      provider: AddPackageDependency.self,
      context: .init(
        dependency: .sourceControl(
          .init(
            location: Self.swiftSystemURL,
            requirement: .rangeFrom("510.0.0")
          )
        )
      )
    )

    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages",
          dependencies: [ /*test*/ .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1") ]
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            dependencies: [ /*test*/ .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "510.0.1"), .package(url: "https://github.com/apple/swift-system.git", from: "510.0.0"),]
        )
        """,
      provider: AddPackageDependency.self,
      context: .init(
        dependency: .sourceControl(
          .init(
            location: Self.swiftSystemURL,
            requirement: .rangeFrom("510.0.0")
          )
        )
      )
    )
  }

  func testAddPackageDependencyExistingEmpty() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages",
          dependencies: [ ]
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            dependencies: [
                .package(url: "https://github.com/apple/swift-system.git", "508.0.0" ..< "510.0.0"),
            ]
        )
        """,
      provider: AddPackageDependency.self,
      context: .init(
        dependency: .sourceControl(
          .init(
            location: Self.swiftSystemURL,
            requirement: .range(lowerBound: "508.0.0", upperBound: "510.0.0")
          )
        )
      )
    )
  }

  func testAddPackageDependencyNoExistingAtEnd() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages"
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            dependencies: [
                .package(url: "https://github.com/apple/swift-system.git", branch: "main"),
            ]
        )
        """,
      provider: AddPackageDependency.self,
      context: .init(
        dependency: Self.swiftSystemPackageDependency
      )
    )
  }

  func testAddPackageDependencyNoExistingMiddle() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages",
          targets: []
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            dependencies: [
                .package(url: "https://github.com/apple/swift-system.git", branch: "main"),
            ],
            targets: []
        )
        """,
      provider: AddPackageDependency.self,
      context: .init(
        dependency: Self.swiftSystemPackageDependency
      )
    )
  }

  func testAddPackageDependencyErrors() {
    XCTAssertThrowsError(
      try AddPackageDependency.manifestRefactor(
        syntax: """
          // swift-tools-version: 5.5
          let package: Package = .init(
              name: "packages"
          )
          """,
        in: .init(dependency: Self.swiftSystemPackageDependency)
      )
    ) { error in
      XCTAssertEqual(
        error as? ManifestEditError,
        .cannotFindPackage
      )
    }

    XCTAssertThrowsError(
      try AddPackageDependency.manifestRefactor(
        syntax: """
          // swift-tools-version: 5.5
          let package = Package(
              name: "packages",
              dependencies: blah
          )
          """,
        in: .init(dependency: Self.swiftSystemPackageDependency)
      )
    ) { (error: any Error) in
      XCTAssertEqual(
        error as? ManifestEditError,
        .cannotFindArrayLiteralArgument(argumentName: "dependencies")
      )
    }
  }

  func testAddLibraryProduct() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages",
          targets: [
              .target(name: "MyLib"),
          ],
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            products: [
                .library(
                    name: "MyLib",
                    type: .dynamic,
                    targets: [ "MyLib" ]
                ),
            ],
            targets: [
                .target(name: "MyLib"),
            ],
        )
        """,
      provider: AddProduct.self,
      context: .init(
        product:
          ProductDescription(
            name: "MyLib",
            type: .library(.dynamic),
            targets: ["MyLib"]
          )
      )
    )
  }

  func testAddLibraryTarget() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages"
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            targets: [
                .target(name: "MyLib"),
            ]
        )
        """,
      expectedAuxiliarySources: [
        "Sources/MyLib/MyLib.swift": """

        """
      ],
      provider: AddPackageTarget.self,
      context: .init(
        target: PackageTarget(name: "MyLib")
      )
    )
  }

  func testAddLibraryTargetWithDependencies() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages"
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            targets: [
                .target(
                    name: "MyLib",
                    dependencies: [
                        "OtherLib",
                        .product(name: "SwiftSyntax", package: "swift-syntax"),
                        .target(name: "TargetLib")
                    ]
                ),
            ]
        )
        """,
      expectedAuxiliarySources: [
        "Sources/MyLib/MyLib.swift": """
        import OtherLib
        import SwiftSyntax
        import TargetLib

        """
      ],
      provider: AddPackageTarget.self,
      context: .init(
        target: PackageTarget(
          name: "MyLib",
          dependencies: [
            .byName(name: "OtherLib"),
            .product(name: "SwiftSyntax", package: "swift-syntax"),
            .target(name: "TargetLib"),
          ]
        )
      )
    )
  }

  func testAddExecutableTargetWithDependencies() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages",
          targets: [
              // These are the targets
              .target(name: "MyLib")
          ]
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            targets: [
                // These are the targets
                .target(name: "MyLib"),
                .executableTarget(
                    name: "MyProgram target-name",
                    dependencies: [
                        .product(name: "SwiftSyntax", package: "swift-syntax"),
                        .target(name: "TargetLib"),
                        "MyLib"
                    ]
                ),
            ]
        )
        """,
      expectedAuxiliarySources: [
        "Sources/MyProgram target-name/MyProgram target-name.swift": """
        import MyLib
        import SwiftSyntax
        import TargetLib

        @main
        struct MyProgram_target_nameMain {
            static func main() {
                print("Hello, world")
            }
        }
        """
      ],
      provider: AddPackageTarget.self,
      context: .init(
        target: PackageTarget(
          name: "MyProgram target-name",
          type: .executable,
          dependencies: [
            .product(name: "SwiftSyntax", package: "swift-syntax"),
            .target(name: "TargetLib"),
            .byName(name: "MyLib"),
          ]
        )
      )
    )
  }

  func testAddMacroTarget() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      import PackageDescription

      let package = Package(
          name: "packages"
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        import CompilerPluginSupport
        import PackageDescription

        let package = Package(
            name: "packages",
            dependencies: [
                .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "<#version#>"),
            ],
            targets: [
                .macro(
                    name: "MyMacro target-name",
                    dependencies: [
                        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                        .product(name: "SwiftSyntaxMacros", package: "swift-syntax")
                    ]
                ),
            ]
        )
        """,
      expectedAuxiliarySources: [
        "Sources/MyMacro target-name/MyMacro target-name.swift": """
        import SwiftCompilerPlugin
        import SwiftSyntaxMacros

        struct MyMacro_target_name: Macro {
            /// TODO: Implement one or more of the protocols that inherit
            /// from Macro. The appropriate macro protocol is determined
            /// by the "macro" declaration that MyMacro_target_name implements.
            /// Examples include:
            ///     @freestanding(expression) macro --> ExpressionMacro
            ///     @attached(member) macro         --> MemberMacro
        }
        """,
        "Sources/MyMacro target-name/ProvidedMacros.swift": """
        import SwiftCompilerPlugin

        @main
        struct MyMacro_target_nameMacros: CompilerPlugin {
            let providingMacros: [Macro.Type] = [
                MyMacro_target_name.self,
            ]
        }
        """,
      ],
      provider: AddPackageTarget.self,
      context: .init(
        target: PackageTarget(
          name: "MyMacro target-name",
          type: .macro
        )
      )
    )
  }

  func testAddSwiftTestingTestTarget() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages"
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            targets: [
                .testTarget(name: "MyTest target-name"),
            ]
        )
        """,
      expectedAuxiliarySources: [
        "Tests/MyTest target-name/MyTest target-name.swift": """
        import Testing

        @Suite
        struct MyTest_target_nameTests {
            @Test("MyTest_target_name tests")
            func example() {
                #expect(42 == 17 + 25)
            }
        }
        """
      ],
      provider: AddPackageTarget.self,
      context: .init(
        target: PackageTarget(
          name: "MyTest target-name",
          type: .test
        ),
        testHarness: .swiftTesting
      )
    )
  }

  func testAddTargetDependency() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.5
      let package = Package(
          name: "packages",
          dependencies: [
              .package(url: "https://github.com/swiftlang/swift-example.git", from: "1.2.3"),
          ],
          targets: [
              .testTarget(
                  name: "MyTest"
              ),
          ]
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.5
        let package = Package(
            name: "packages",
            dependencies: [
                .package(url: "https://github.com/swiftlang/swift-example.git", from: "1.2.3"),
            ],
            targets: [
                .testTarget(
                    name: "MyTest",
                    dependencies: [
                        .product(name: "SomethingOrOther", package: "swift-example"),
                    ]
                ),
            ]
        )
        """,
      provider: AddTargetDependency.self,
      context: .init(
        dependency: .product(name: "SomethingOrOther", package: "swift-example"),
        targetName: "MyTest"
      )
    )
  }

  func testAddJava2SwiftPlugin() throws {
    try assertManifestRefactor(
      """
      // swift-tools-version: 5.7
      let package = Package(
          name: "packages",
          targets: [
              .target(
                  name: "MyLib"
              )
          ]
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.7
        let package = Package(
            name: "packages",
            targets: [
                .target(
                    name: "MyLib",
                    plugins: [
                        .plugin(name: "Java2SwiftPlugin", package: "swift-java"),
                    ]
                )
            ]
        )
        """,
      provider: AddPluginUsage.self,
      context: .init(
        targetName: "MyLib",
        pluginUsage: .plugin(name: "Java2SwiftPlugin", package: "swift-java")
      )
    )
  }

  func testAddSwiftSettings() throws {
    XCTAssertThrowsError(
      try AddSwiftSetting.upcomingFeature(
        to: "OtherTest",
        name: "ExistentialAny",
        manifest: """
          // swift-tools-version: 5.8
          let package = Package(
              name: "packages",
              targets: [
                  .executableTarget(
                      name: "MyTest"
                  )
              ]
          )
          """
      )
    ) { error in
      XCTAssertEqual(
        error as? ManifestEditError,
        .cannotFindTarget(targetName: "OtherTest")
      )
    }

    XCTAssertThrowsError(
      try AddSwiftSetting.upcomingFeature(
        to: "MyPlugin",
        name: "ExistentialAny",
        manifest: """
          // swift-tools-version: 5.8
          let package = Package(
              name: "packages",
              targets: [
                  .plugin(
                      name: "MyPlugin",
                      capability: .buildTool
                  )
              ]
          )
          """
      )
    ) { error in
      XCTAssertEqual(
        error as? ManifestEditError,
        .cannotAddSettingsToPluginTarget
      )
    }

    try assertManifestRefactor(
      """
      // swift-tools-version: 5.8
      let package = Package(
          name: "packages",
          targets: [
              .testTarget(
                  name: "MyTest",
                  dependencies: [
                  ]
              ),
          ]
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.8
        let package = Package(
            name: "packages",
            targets: [
                .testTarget(
                    name: "MyTest",
                    dependencies: [
                    ],
                    swiftSettings: [
                        .enableUpcomingFeature("ExistentialAny:migratable"),
                    ]
                ),
            ]
        )
        """
    ) { manifest in
      try AddSwiftSetting.upcomingFeature(
        to: "MyTest",
        name: "ExistentialAny:migratable",
        manifest: manifest
      )
    }

    try assertManifestRefactor(
      """
      // swift-tools-version: 5.8
      let package = Package(
          name: "packages",
          targets: [
              .testTarget(
                  name: "MyTest",
                  dependencies: [
                  ],
                  swiftSettings: [
                      .enableExperimentalFeature("Extern")
                  ]
              ),
          ]
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.8
        let package = Package(
            name: "packages",
            targets: [
                .testTarget(
                    name: "MyTest",
                    dependencies: [
                    ],
                    swiftSettings: [
                        .enableExperimentalFeature("Extern"),
                        .enableExperimentalFeature("TrailingComma"),
                    ]
                ),
            ]
        )
        """
    ) { manifest in
      try AddSwiftSetting.experimentalFeature(
        to: "MyTest",
        name: "TrailingComma",
        manifest: manifest
      )
    }

    try assertManifestRefactor(
      """
      // swift-tools-version: 6.2
      let package = Package(
          name: "packages",
          targets: [
              .testTarget(
                  name: "MyTest",
                  dependencies: [
                  ]
              ),
          ]
      )
      """,
      expectedManifest: """
        // swift-tools-version: 6.2
        let package = Package(
            name: "packages",
            targets: [
                .testTarget(
                    name: "MyTest",
                    dependencies: [
                    ],
                    swiftSettings: [
                        .strictMemorySafety(),
                    ]
                ),
            ]
        )
        """
    ) { manifest in
      try AddSwiftSetting.strictMemorySafety(
        to: "MyTest",
        manifest: manifest
      )
    }

    try assertManifestRefactor(
      """
      // swift-tools-version: 6.0
      let package = Package(
          name: "packages",
          targets: [
              .testTarget(
                  name: "MyTest",
                  dependencies: [
                  ]
              ),
          ]
      )
      """,
      expectedManifest: """
        // swift-tools-version: 6.0
        let package = Package(
            name: "packages",
            targets: [
                .testTarget(
                    name: "MyTest",
                    dependencies: [
                    ],
                    swiftSettings: [
                        .swiftLanguageMode(.v5),
                    ]
                ),
            ]
        )
        """
    ) { manifest in
      try AddSwiftSetting.languageMode(
        to: "MyTest",
        mode: "5",
        manifest: manifest
      )
    }

    // Custom language mode
    try assertManifestRefactor(
      """
      // swift-tools-version: 6.0
      let package = Package(
          name: "packages",
          targets: [
              .testTarget(
                  name: "MyTest",
                  dependencies: [
                  ]
              ),
          ]
      )
      """,
      expectedManifest: """
        // swift-tools-version: 6.0
        let package = Package(
            name: "packages",
            targets: [
                .testTarget(
                    name: "MyTest",
                    dependencies: [
                    ],
                    swiftSettings: [
                        .swiftLanguageMode(.version("6.2")),
                    ]
                ),
            ]
        )
        """
    ) { manifest in
      try AddSwiftSetting.languageMode(
        to: "MyTest",
        mode: "6.2",
        manifest: manifest
      )
    }

    try assertManifestRefactor(
      """
      // swift-tools-version: 5.8
      let package = Package(
          name: "packages",
          targets: [
              .target(
                  name: "MyTest",
                  dependencies: [
                      .byName(name: "Dependency")
                  ]
              ),
              .target(
                  name: "Dependency"
              )
          ]
      )
      """,
      expectedManifest: """
        // swift-tools-version: 5.8
        let package = Package(
            name: "packages",
            targets: [
                .target(
                    name: "MyTest",
                    dependencies: [
                        .byName(name: "Dependency")
                    ]
                ),
                .target(
                    name: "Dependency",
                    swiftSettings: [
                        .enableUpcomingFeature("ExistentialAny"),
                    ]
                )
            ]
        )
        """
    ) { manifest in
      try AddSwiftSetting.upcomingFeature(
        to: "Dependency",
        name: "ExistentialAny",
        manifest: manifest
      )
    }
  }
}

/// Assert that applying the given edit/refactor operation to the manifest
/// produces the expected manifest source file and the expected auxiliary
/// files.
func assertManifestRefactor<Provider: ManifestEditRefactoringProvider>(
  _ originalManifest: SourceFileSyntax,
  expectedManifest: SourceFileSyntax,
  expectedAuxiliarySources: [String: SourceFileSyntax] = [:],
  provider: Provider.Type,
  context: Provider.Context,
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  return try assertManifestRefactor(
    originalManifest,
    expectedManifest: expectedManifest,
    expectedAuxiliarySources: expectedAuxiliarySources,
    file: file,
    line: line
  ) { (manifest) in
    try provider.manifestRefactor(syntax: manifest, in: context)
  }
}

/// Assert that applying the given edit/refactor operation to the manifest
/// produces the expected manifest source file and the expected auxiliary
/// files.
func assertManifestRefactor(
  _ originalManifest: SourceFileSyntax,
  expectedManifest: SourceFileSyntax,
  expectedAuxiliarySources: [String: SourceFileSyntax] = [:],
  file: StaticString = #filePath,
  line: UInt = #line,
  operation: (SourceFileSyntax) throws -> PackageEdit
) rethrows {
  let edits = try operation(originalManifest)
  let editedManifestSource = FixItApplier.apply(
    edits: edits.manifestEdits,
    to: originalManifest
  )

  let editedManifest = Parser.parse(source: editedManifestSource)
  assertStringsEqualWithDiff(
    editedManifest.description,
    expectedManifest.description,
    file: file,
    line: line
  )

  // Check all of the auxiliary sources.
  for (auxSourcePath, auxSourceSyntax) in edits.auxiliaryFiles {
    guard let expectedSyntax = expectedAuxiliarySources[auxSourcePath] else {
      XCTFail("unexpected auxiliary source file '\(auxSourcePath)' in \(expectedAuxiliarySources)")
      return
    }

    assertStringsEqualWithDiff(
      auxSourceSyntax.description,
      expectedSyntax.description,
      file: file,
      line: line
    )
  }

  XCTAssertEqual(
    edits.auxiliaryFiles.count,
    expectedAuxiliarySources.count,
    "didn't get all of the auxiliary files we expected"
  )
}
