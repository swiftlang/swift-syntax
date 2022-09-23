# Code-Generation for SwiftSyntax

This directory contains file to generate source code that is part of the SwiftSyntax package. If you are looking to generate Swift code yourself, you might be interested in [SwiftSyntaxBuilder](../Sources/SwiftSyntaxBuilder).

SwiftSyntax currently uses two mechanisms to generate source code: gyb and SwiftSyntaxBuilder. Both can be run using 

```bash
./build-script.py generate-source-code --toolchain /path/to/toolchain.xctoolchain/usr
```

## `gyb`

Files generated using `gyb` have a `.gyb` suffix. [ChangingSwiftSyntax.md](../Sources/SwiftSyntax/Documentation.docc/ChangingSwiftSyntax.md) contains documentation how `gyb` works. This directory contains the definitions that back most of gyb-generation in `gyb_syntax_support`.

## `SwiftSyntaxBuilder`

Some source code inside SwiftSyntax is generated using [SwiftSyntaxBuilder](../Sources/SwiftSyntaxBuilder), a Swift library whose purpose is to generate Swift code using Swift itself. This kind of code generation is performed by the Swift package defined in this directory.

This directory is a standalone package that uses a pinned version of SwiftSyntaxBuilder. It is thus NOT using SwiftSyntaxBuilder of the parent directory. This guarantees that when `generate-swiftsyntaxbuilder` is run, it can't break its own build.