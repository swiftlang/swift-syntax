# Create SwiftSyntax snapshot release with parser library

## Create release tag
1. Check out the tag you want to release in the SwiftSyntax repository
## Smoke test on macOS

1. Change the binary target in `Package.swift` to point to your personal GitHub repo
2. Update to Latest Package Versions in Xcode
3. Run tests

## Smoke test on Linux

1. Pull the latest development snapshot docker image for the release, e.g. `docker pull swiftlang/swift:nightly-5.6-focal`
2. Start a development docker image `docker run -it --rm swiftlang/swift:nightly-5.6-focal`
3. `git clone https://github.com/<your github account>/swift-syntax`
4. `cd swift-syntax`
5. `git checkout <release tag>`
6. `swift test`

## Publish Release

1. Push tag to apple/swift-syntax
2. On apple/swift-syntax create a new release using the just-pushed tag
3. If this is a snapshot release, check “This is a pre-release”
4. Publish 🎉
5. Add the new release to README.md

## Integration test

1. Create a new Swift package on macOS that depends on SwiftSyntax and verify that it can parser Swift source into a syntax tree
2. Do the same on Linux
