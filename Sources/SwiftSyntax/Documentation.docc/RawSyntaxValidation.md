# Raw Syntax Validation for Macro Testing

A guide to using `SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION` in third-party Swift macro packages.

## Introduction

SwiftSyntax is designed with fault tolerance in mind. When developing macros, it's generally robust enough to handle 
incorrect syntax trees without major issues. However, for developers who want to ensure they're using the SwiftSyntax 
API as intended, there's an additional validation tool available: the `SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION` 
environment variable.

## What SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION does?

This environment variable enables extra validation in SwiftSyntax during runtime. When activated, it checks:

1. The correctness of each syntax node's child kind.
2. That tokens only use kinds specified in the CodeGeneration package's syntax tree layout.


## How to Use It

If you decide to use this feature for testing, you can enable it by setting the environment variable when running your 
tests:

```sh
SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION=true swift test
```

## Example

Consider these two syntax examples:

Incorrect syntax:
```swift
let asyncSpecifier: TokenSyntax = "async"
```

Correct syntax:
```swift
let asyncSpecifier: TokenSyntax = .keyword(.async)
```

With raw syntax validation enabled, the incorrect syntax might produce an error like:

```
Fatal error: Error validating child at index 1 of typeEffectSpecifiers:
Expected token with one of [keyword('async')] but received identifier with text 'async'
```

This error helps identify that you're using an identifier where a keyword is expected. The correct syntax uses 
`.keyword(.async)`, which properly specifies that 'async' should be treated as a keyword rather than an identifier.


## Conclusion

While `SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION` isn't necessary for third-party macro packages, it can be a useful tool 
during development and testing. It helps ensure you're using the SwiftSyntax API as intended and can catch subtle issues
that might affect formatting. However, remember that it comes with a performance cost and isn't recommended for use in 
production environments.
