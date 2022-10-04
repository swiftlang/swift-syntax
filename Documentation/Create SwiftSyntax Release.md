# Create SwiftSyntax snapshot release with parser library

## Create release tag
1. Check out the tag you want to release in the SwiftSyntax repository
2. Download the matching Swift release from <https://swift.org> and install it
3. Create an `.xcframework` by running 
```bash
xcodebuild -create-xcframework -library /Library/Developer/Toolchains/<toolchain-name>.xctoolchain/usr/lib/swift/macosx/lib_InternalSwiftSyntaxParser.dylib -output _InternalSwiftSyntaxParser.xcframework
```
4. Zip up the framework
```bash
zip -r _InternalSwiftSyntaxParser.xcframework.zip _InternalSwiftSyntaxParser.xcframework
```
5. Compute the checksum for the generated `.xcframework.zip`
```bash
/Library/Developer/Toolchains/<toolchain-name>.xctoolchain/usr/bin/swift package --package-path /path/to/swift-syntax/ compute-checksum _InternalSwiftSyntaxParser.xcframework.zip
```
6. Apply the following diff to `Package.swift`, adjusting `<release tag>` and `<checksum>`
```diff
diff --git a/Package.swift b/Package.swift
index 4c6db83a..7a953fc6 100644
--- a/Package.swift
+++ b/Package.swift
@@ -23,6 +23,21 @@ if ProcessInfo.processInfo.environment["SWIFT_BUILD_SCRIPT_ENVIRONMENT"] != nil
   swiftSyntaxSwiftSettings = []
 }
 
+// Include the parser library as a binary dependency if both the host and the target are macOS.
+//  - We need to require that the host is macOS (checked by `#if os(macOS)`) because package resolve will download and unzip the referenced framework, which requires `unzip` to be installed. Only macOS guarantees that `unzip` is installed, the Swift Docker images don’t have unzip installed, so package resolve would fail.
+//  - We need to require that the target is macOS (checked by `.when`) because binary dependencies are only supported by SwiftPM on macOS.
+#if os(macOS)
+let parserLibraryTarget: [Target] = [.binaryTarget(
+  name: "_InternalSwiftSyntaxParser",
+  url: "https://github.com/apple/swift-syntax/releases/download/<release tag>/_InternalSwiftSyntaxParser.xcframework.zip",
+  checksum: "<checksum>"
+)]
+let parserLibraryDependency: [Target.Dependency] = [.target(name: "_InternalSwiftSyntaxParser", condition: .when(platforms: [.macOS]))]
+#else
+let parserLibraryTarget: [Target] = []
+let parserLibraryDependency: [Target.Dependency] = []
+#endif
+
 let package = Package(
   name: "SwiftSyntax",
   products: [
@@ -65,7 +80,7 @@ let package = Package(
         "Tokens.swift.gyb",
       ]
     ),
-    .target(name: "SwiftSyntaxParser", dependencies: ["SwiftSyntax"], exclude: [
+    .target(name: "SwiftSyntaxParser", dependencies: ["SwiftSyntax"] + parserLibraryDependency, exclude: [
       "NodeDeclarationHash.swift.gyb"
     ]),
     .target(
@@ -90,5 +105,5 @@ let package = Package(
       dependencies: ["SwiftSyntax", "SwiftSyntaxParser"],
       exclude: ["Inputs"]
     ),
-  ]
+  ] + parserLibraryTarget
 )
```
7. Commit the changes
8. Create a tag and push it to your personal GitHub repository
9. On your personal GitHub repo create new release, select the tag, name it and upload `_InternalSwiftSyntaxParser.xcframework.zip`

## Smoke test on macOS

1. Change the binary target in `Package.swift` to point to your personal GitHub repo
2. Open the SwiftSyntax package with an Xcode version that contains no or an incompatible parser library
3. Update to Latest Package Versions in Xcode
4. Run tests

## Smoke test on Linux

1. Pull the latest development snapshot docker image for the release, e.g. `docker pull swiftlang/swift:nightly-5.6-focal`
2. Start a development docker image `docker run -it --rm swiftlang/swift:nightly-5.6-focal`
3. `git clone https://github.com/<your github account>/swift-syntax`
4. `cd swift-syntax`
5. `git checkout <release tag>`
6. `swift test`

## Publish Release

1. Push tag to apple/swift-syntax
2. On apple/swift-syntax create a new release using the just-pushed tag and upload the parser library as `_InternalSwiftSyntaxParser.xcframework.zip`
3. If this is a snapshot release, check “This is a pre-release”
4. Publish 🎉
5. Add the new release to README.md

## Integration test

1. Create a new Swift package on macOS that depends on SwiftSyntax and verify that it can parser Swift source into a syntax tree
2. Do the same on Linux
