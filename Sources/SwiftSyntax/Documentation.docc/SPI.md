# `@_spi` attribute

swift-syntax extensively makes extensive use of the `@_spi` attribute. 

Functions marked as `@_spi(RawSyntax)` (where `RawSyntax` can be any name) are considered *SPI* (System Programming Interface) and are only accessible if the module that declares them is imported as `@_spi(RawSyntax)`.

Since functions marked as SPI are not part of the public API, swift-syntax makes no guarantee to their source stability. swift-syntax makes no effort to keep its SPI stable.

Declarations are typically marked as SPI because they have some kind of caveat that makes them unsafe to use in general. For example, when accessing ``RawSyntax`` nodes, you need to manually guarantee that the ``SyntaxArena`` they live in doesn’t get de-allocated. Other declarations have an `@_spi` to share them between different modudules within the swift-syntax package but those APIs shouldn’t be accessed publicly.
