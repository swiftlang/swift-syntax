# RFC Process

We gather community feedback for all changes to swift-syntax’s public API to keep it clean and usable. Everybody is encouraged to share their thoughts on the RFC posts.

Public API changes are:
- New APIs
- Changes to API behavior that are not considered bugfixes
- Deprecations of public API
- API-incompatible changes, like changing the type of a public variable
- Declarations marked with `@_spi` are not considered part of the public API and don’t require an RFC.

## The RFC post

The RFC process should contain the following.
- **Summary**: A short summary of the changes. If it is not obvious, what motivated this change?
- **Link to PR**: Link to the pull request that implements the API change.
- **Swift Interface**: The changed API in a Swift Interface style notation.
  - For new API this should contain the new API’s signature and its doc comment.
  - If the change affects existing API, the old API’s signature should also be included in the RFC post for reference.
- **For new API**: If this is new API, justify why this is this a worthwhile addition to swift-syntax. A good guideline is to answer the following questions.
  - **Commonality**: Do you expect this API to be widely used? Is it applicable in a variety of contexts?
  - **Discoverability**: Will users of swift-syntax easily find this new API for the operations they want to achieve?
  - **Not trivially composable**: Can the desired behavior be achieved using existing public API? If yes, is this new API superior because one of the following reasons?
    - **Readability**: Is the proposed new API easier to understand than the composed alternative?
    - **Correctness and performance issues**: Does the naive implementation using existing API have any correctness or performance issues that would be covered correctly by the new API.
- **For existing API**: If this is modifying existing API, do you expect many clients to be affected by the change?
  - **Migration**: What are the migration steps needed to migrate to the new API?

Make sure to also include the change in `Release Notes/<version>.md`.

## The RFC process

After posting the RFC in the [swift-syntax category on the Swift forums](https://forums.swift.org/c/development/swift-syntax/112), you can merge the PR. You are expected to incorporate any feedback from the RFC in a timely manner.
