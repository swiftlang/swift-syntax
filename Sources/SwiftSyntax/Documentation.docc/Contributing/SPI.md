# @_spi attribute

Learn when SwiftSyntax exposes declaration annotated as `@_spi`.

Functions marked as `@_spi(RawSyntax)` (where `RawSyntax` can be any name) are considered *SPI* (System Programming Interface) and are only accessible if the module that declares them is imported as `@_spi(RawSyntax)`.

Since functions marked as SPI are not part of the public API, swift-syntax makes no guarantee to their source stability. swift-syntax makes no effort to keep its SPI stable.

Declarations are typically marked as SPI because they have some kind of caveat that makes them unsafe to use in general. For example, when accessing `RawSyntax` nodes, you need to manually guarantee that the ``SyntaxArena`` they’re allocated in will not be de-allocated. Other declarations have an `@_spi` to share them between different modules within the swift-syntax package. These would use the [`package` modifier](https://github.com/apple/swift-evolution/blob/main/proposals/0386-package-access-modifier.md) if not for the fact that swift-syntax needed to compile with the last two Swift releases (see <doc:Swift-Version>).
