# SwiftSyntaxBuilder

Declarative and type-safe wrapper around SwiftSyntax.

## Example Usage

```swift
let sourceFile = SourceFile {
  Import("SwiftSyntax")

  Struct("ExampleStruct") {
    Let("syntax", of: "Syntax")
  }
}

let syntax = sourceFile.buildSyntax(format: format, leadingTrivia: .zero)

var text = ""
syntax.write(to: &text)
print(text)
```

prints:

```swift
import SwiftSyntax
struct ExampleStruct {
  let syntax: Syntax
}
```
