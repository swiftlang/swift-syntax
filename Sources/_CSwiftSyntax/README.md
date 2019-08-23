This module is an implementation detail of SwiftSyntax and does not export
any public API. As such, any uses of it inside SwiftSyntax should import it
with the `@_implementationOnly` attribute (available since Swift 5.1).

This preserves the property that SwiftSyntax is a self-contained Swift
module, meaning that when distributing it, we do not also have to bundle
these private headers or use any dynamic symbol loading tricks that require
additional linker flags to be passed on some platforms (see
[SR-11293](https://bugs.swift.org/browse/SR-11293), for example).
