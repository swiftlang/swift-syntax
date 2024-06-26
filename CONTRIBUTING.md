# Contributing

## Building & Testing

swift-syntax is a SwiftPM package, so you can build and test it using anything that supports packages - opening in Xcode, Visual Studio Code with [Swift for Visual Studio Code](https://github.com/swift-server/vscode-swift) installed, or through the command line using `swift build` and `swift test`.

> [!NOTE]
> Running swift-syntax’s self-parse tests takes the majority of testing time. If you want to iterate quickly, you can skip these tests:
> - In Xcode
>   1. Product -> Scheme -> Edit Scheme…
>   2. Select the Arguments tab in the Run section
>   3. Add a `SKIP_LONG_TESTS` environment variable with value `1`
> - On the command line: Set the `SKIP_LONG_TESTS` environment variable to `1` when running tests, e.g by running `SKIP_LONG_TESTS=1 swift test`

> [!NOTE]
> If you are only modifying the `SwiftParser` module, you can run only the parser tests by selecting the `SwiftParserTest` target. 
> - In Xcode: Select the `SwiftParserTest` scheme. If you can’t find it in your Schemes, you need to manually add it using Product -> Scheme -> New Scheme…
> - On the command line: Run `swift test --test-product SwiftParserTests`

## Formatting

swift-syntax is formatted using [swift-format](http://github.com/swiftlang/swift-format) to ensure a consistent style.

To format your changes run the formatter using the following command
```bash
./swift-syntax-dev-utils format
```
It will build a local copy of swift-format from the `main` branch and format the repository. Since it is building a release version of `swift-format`, the first run will take few minutes. Subsequent runs take less than 2 seconds.

Generated source code is not formatted to make it easier to spot changes when re-running code generation.

> [!NOTE]
> You can add a git hook to ensure all commits to the swift-syntax repository are correctly formatted. 
> 1. Save the following contents to `swift-syntax/.git/hooks/pre-commit`
> ```bash
> #!/usr/bin/env bash
> set -e
> SOURCE_DIR=$(realpath "$(dirname $0)/../..")
> swift "$SOURCE_DIR/swift-syntax-dev-utils" format --lint
> ```
> 2. Mark the file as executable: `chmod a+x swift-syntax/.git/hooks/pre-commit`
> 3. If you have global git hooks installed, be sure to call them at the end of the script with `path/to/global/hooks/pre-commit "$@"` 


## Generating Source Code

If you want to modify the generated files, open the [CodeGeneration](CodeGeneration) package and run the `generate-swift-syntax` executable.

Alternatively, you can generate the files from the command line by running the following command from the swift-syntax directory

```bash
swift run --package-path CodeGeneration
```

## Running Pre-PR Checks Script

To ensure that your changes to the project are implemented correctly and do not introduce issues across the repository, a script has been provided to automate the necessary pre-PR checks. 

```bash
./swift-syntax-dev-utils local-pr-precheck
```

> [!NOTE]
> Running the pre-PR checks script may take some time, so it's recommended to perform this final check before submitting a PR rather than after every change.

## Authoring commits

Prefer to squash the commits of your PR (*pull request*) and avoid adding commits like “Address review comments”. This creates a clearer git history, which doesn’t need to record the history of how the PR evolved.

We prefer to not squash commits when merging a PR because, especially for larger PRs, it sometimes makes sense to split the PR into multiple self-contained chunks of changes. For example, a PR might do a refactoring first before adding a new feature or fixing a bug. This separation is useful for two reasons:
- During review, the commits can be reviewed individually, making each review chunk smaller
- In case this PR introduced a bug that is identified later, it is possible to check if it resulted from the refactoring or the actual change, thereby making it easier find the lines that introduce the issue. 

## Review and CI Testing

After you opened your PR, a maintainer will review it and test your changes in CI (*Continuous Integration*) by adding a `@swift-ci Please test` comment on the pull request. Once your PR is approved and CI has passed, the maintainer will merge your pull request.

Only contributors with [commit access](https://www.swift.org/contributing/#commit-access) are able to approve pull requests and trigger CI. 

## Additional Verification

swift-syntax has additional verification methods (see the sections below) that provide more extensive validation. They have a significant runtime impact on swift-syntax and are thus not enabled by default when building swift-syntax, but are enabled in CI. If CI fails and you are unable to reproduce the failure locally, make sure that `SKIP_LONG_TESTS` is not set and try enabling these validations.

### RawSyntax Validation

When the `SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION` environment variable is set while building swift-syntax, SwiftSyntax will perform additional validation that the layout of the syntax tree is correct. It validates that 
1. every child of a syntax node has the correct kind, which should be guaranteed by the Swift type system in most cases
2. each token only has one of the token kinds that is specified in the syntax tree layout of the `CodeGeneration` package. 

If this validation hits an assertion failure that a token is not accepted at a certain position in the syntax tree, double-check if the token kind that is being stored in the syntax tree actually makes sense here. If it does not, check if there is a parser bug or whether you need to remap the token kind. If it does make sense, add the token kind to `.token(choices:)` of the syntax node in CodeGeneration, re-generate that source code and run tests again.

> [!NOTE]
> If you want to run tests in Xcode with RawSyntax validation enabled, you can also modify Package.swift and replace the check for `SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION` with `true`.

### Test Case Mutation

When the `SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION` environment variable is set while building swift-syntax, SwiftParser records alternative tokens that the parser was looking for at specific offsets in the source file, e.g. whether it also checked for a `struct` keyword when the source code contained a `class` keyword. It will then use that information to mutate the test case by e.g. substituting `class` with `struct`.

When testing finds one of these failures, it will show you the syntax tree that produced the failure. Create a new test case with the source code the failure gives you and fix the failure.

## Swift Version

We require that swift-syntax builds with the latest released compiler and the previous major version (e.g. with Swift 5.8 and Swift 5.7).
