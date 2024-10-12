# Environment variables

The following environment variables can be used to control some behavior in swift-syntax.

## Build time

- `SWIFT_BUILD_SCRIPT_ENVIRONMENT`: Enable assertions in release builds and remove the dependency of swift-syntax on os_log.
- `SWIFTCI_USE_LOCAL_DEPS`: Assume that all of SourceKit-LSP’s dependencies are checked out next to it and use those instead of cloning the repositories. Primarily intended for CI environments that check out related branches.
- `SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION`: Mutate the input of `assertParse` test cases. See [CONTRIBUTING](../CONTRIBUTING.md) for more information.
- `SWIFTSYNTAX_BUILD_DYNAMIC_LIBRARY`: Instead of building object files for all modules to be statically linked, build a single dynamic library. This allows us to build swift-syntax as dynamic libraries, which in turn allows us to build SourceKit-LSP using SwiftPM on Windows. Linking swift-syntax statically into sourcekit-lsp exceeds the maximum number of exported symbols on Windows.
- `SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION`: Check that the layout of the syntax tree is correct when creating or modifying nodes. See [CONTRIBUTING](../CONTRIBUTING.md) for more information.

## Testing

- `SKIP_LONG_TESTS`: Skip tests that typically take more than 1s to execute.
