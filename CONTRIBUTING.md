# Contributing

## Building SwiftSyntax from `main`

Since SwiftSyntax relies on definitions in the main Swift repository to generate the layout of the syntax tree using `gyb`, a checkout of [apple/swift](https://github.com/apple/swift) is still required to build the latest development snapshot of SwiftSyntax.

To build the `main` branch of SwiftSyntax, follow the following instructions:

1. Check `swift-syntax` and  `swift` out side by side:
    ```
    - (enclosing directory)
      - swift
      - swift-syntax
    ```

2. Make sure you have a recent [Trunk Swift Toolchain](https://swift.org/download/#snapshots) installed.
3. Define the `TOOLCHAINS` environment variable as below to have the `swift` command point inside the toolchain:

    ```bash
    $ export TOOLCHAINS=swift
    ```

4. To make sure everything is set up correctly, check the return statement of `xcrun --find swift`. It should point inside the latest installed trunk development toolchain. If it points inside an Xcode toolchain, check that you exported the `TOOLCHAINS` environment variable correctly. If it points inside a version-specific toolchain (like Swift 5.0-dev), you'll need to remove that toolchain.
5. Run `swift-syntax/build-script.py`.
    If despite following those instructions, you get compiler errors, the Swift toolchain might be too old to contain recent changes in Swift's SwiftSyntaxParser C library. In that case, you'll have to build the compiler and SwiftSyntax together with the following command:

    ```bash
    $ swift/utils/build-script --swiftsyntax --swiftpm --llbuild
    ```

Swift-CI will automatically run the code generation step whenever a new toolchain (development snapshot or release) is published. It should thus almost never be necessary to perform the above build yourself.

Afterward, SwiftPM can also generate an Xcode project to develop SwiftSyntax by running `swift package generate-xcodeproj`.

If you also want to run tests locally, read the section below as testing has additional requirements.

## Local Testing

SwiftSyntax uses some test utilities that need to be built as part of the Swift compiler project. To build the most recent version of SwiftSyntax and test it, follow the steps in [swift/README.md](https://github.com/apple/swift/blob/main/README.md) and pass `--llbuild --swiftpm --swiftsyntax` to the build script invocation to build SwiftSyntax and all its dependencies using the current trunk (`main`) compiler.

SwiftSyntax can then be tested using the build script in `apple/swift` by running

```bash
swift/utils/build-script --swiftsyntax --swiftpm --llbuild -t --skip-test-cmark --skip-test-swift --skip-test-llbuild --skip-test-swiftpm
```

This command will build SwiftSyntax and all its dependencies, tell the build script to run tests, but skip all tests but the SwiftSyntax tests.

Note that it is not currently supported by SwiftSyntax while building the Swift compiler using Xcode.

## CI Testing

Running `@swift-ci Please test` on the main Swift repository will also test the most recent version of SwiftSyntax.

Testing SwiftSyntax from its own repository is now available by commenting `@swift-ci Please test macOS platform`.
