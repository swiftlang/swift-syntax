# Code-Generation for SwiftSyntax

This directory contains file to generate source code that is part of the SwiftSyntax package. If you are looking to generate Swift code yourself, you might be interested in [SwiftSyntaxBuilder](../Sources/SwiftSyntaxBuilder).

Some source code inside SwiftSyntax is generated using [SwiftSyntaxBuilder](../Sources/SwiftSyntaxBuilder), a Swift library whose purpose is to generate Swift code using Swift itself. This kind of code generation is performed by the Swift package defined in this directory.

This directory is a standalone package that uses a pinned version of SwiftSyntaxBuilder. It is thus NOT using SwiftSyntaxBuilder of the parent directory. This guarantees that when `generate-swiftsyntax` is run, it can't break its own build.

To re-generate the files after changing `CodeGeneration` run the `generate-swiftsyntax` 
target of `CodeGeneration` and pass `path/to/swift-syntax/Sources` as the argument.

On the command line, this would be
```bash
swift run --package-path CodeGeneration generate-swiftsyntax Sources
```

Or if you open the `CodeGeneration` package in Xcode, you can add the 
`generate-swift syntax ../Sources` arguments using Product -> Scheme -> Edit Scheme…

