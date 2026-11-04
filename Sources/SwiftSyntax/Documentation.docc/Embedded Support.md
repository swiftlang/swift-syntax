# Embedded Support

[Embedded Swift](https://docs.swift.org/latest/documentation/embeddedswift/) is an experimental subset of the languages that restricts certain language features to guarantee small binary size and runtime performance. These restrictions are outlined in the Swift documentation, but are mostly related to not emitting type metadata (limited type casts, constrained existential use, no reflection APIs like `String(describing:)` or Mirror).

`SwiftSyntax` aims to support this language subset for two main reasons. First, restricting high-overhead features, such as existentials (`any` types), encourages contributors to write more performant code. Second, clients can benefit from the smaller binary size to create more lightweight tooling.

## Testing

The package manifest tells the compiler to emit `EmbeddedRestrictions` errors on the compilers >=6.5, which helps contributors identify unsupported features. However, it doesn't currently catch all Embedded errors. To actually compile in `Embedded` mode, run:

```bash
# Build the `SwiftSyntax` target with the `Embedded` experimental feature
swift build --target SwiftSyntax \
  -Xswiftc -enable-experimental-feature -Xswiftc Embedded
```
