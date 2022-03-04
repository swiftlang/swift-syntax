# Documentation

## Usage

### Declare SwiftPM dependency with nightly build

1. Download and install the latest Trunk Development [toolchain](https://swift.org/download/#snapshots).

2. Define the `TOOLCHAINS` environment variable as below to have the `swift` command point inside the toolchain:
    ```bash
    $ export TOOLCHAINS=swift
    ```

3. To make sure everything is set up correctly, check the result of `xcrun --find swift`. It should point inside the OSS toolchain.

4. Add this entry to the `Package.swift` manifest of your project:

    ```swift
    // swift-tools-version:5.3
    import PackageDescription

    let package = Package(
      name: "MyTool",
      dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", .revision("swift-DEVELOPMENT-SNAPSHOT-2019-02-26")),
      ],
      targets: [
        .target(name: "MyTool", dependencies: ["SwiftSyntax"]),
      ]
    )
    ```

Tags will be created for every nightly build in the form of `swift-DEVELOPMENT-SNAPSHOT-<DATE>`. The revision field
should be specified with the intended tag.

Different from building SwiftSyntax from source, declaring SwiftSyntax as a SwiftPM dependency doesn't require
the Swift compiler source because we always push gyb-generated files to a tag.

### Embedding SwiftSyntax in an Application

SwiftSyntax depends on the `lib_InternalSwiftSyntaxParser.dylib/.so` library which provides a C interface to the underlying Swift C++ parser. When you do `swift build` SwiftSyntax links and uses the library included in the Swift toolchain. If you are building an application make sure to embed `_InternalSwiftSyntaxParser` as part of your application's libraries.

You can either copy `lib_InternalSwiftSyntaxParser.dylib/.so` directly from the toolchain or even build it yourself from the [Swift repository](https://github.com/apple/swift), as long as you are matching the same tags or branches in both the SwiftSyntax and Swift repositories. To build it for the host os (macOS/linux) use the following steps:

```bash
git clone https://github.com/apple/swift.git
./swift/utils/update-checkout --clone
./swift/utils/build-parser-lib --release --no-assertions --build-dir /tmp/parser-lib-build
```

### Embedding in an iOS Application

You need to build `lib_InternalSwiftSyntaxParser.dylib` yourself, you cannot copy it from the toolchain. Follow the instructions above and change the invocation of `build-parser-lib` accordingly:

```bash
./swift/utils/build-parser-lib --release --no-assertions --build-dir /tmp/parser-lib-build-iossim --host iphonesimulator --architectures x86_64
./swift/utils/build-parser-lib --release --no-assertions --build-dir /tmp/parser-lib-build-ios --host iphoneos --architectures arm64
```
