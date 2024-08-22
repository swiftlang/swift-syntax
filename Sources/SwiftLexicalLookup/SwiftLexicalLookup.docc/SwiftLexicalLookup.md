# SwiftLexicalLookup

A library for performing lexical queries on Swift syntax trees.

## Overview

> Important: `SwiftLexicalLookup` is currently in it's experimental phase. Use `@_spi(Experimental) import SwiftLexicalLookup` to work with the library. Clients should not rely on the current implementation.

`SwiftLexicalLookup` provides APIs that traverse and extract information from the Swift syntax tree. Queries on the syntax tree can include responses to questions like: "Where is an error thrown here handled?" or "What is the source and destination of this `fallthrough` keyword?".

```swift
func foo() throws {
  try! f() // <-- Error handled by `try!`

  do {
    try f() // <-- Error handled by `do ... catch`
  } catch {
    throw f() // <-- Error handled by the throwing function
  }
}
```

There are also more complex queries, such as unqualified name lookup. In Swift, variables, declarations, and other names can be visible through scopes, and the goal of unqualified name lookup is to extract that information and produce a result that specifies what names are available at a given location in the source code. This process preserves information that is crucial for determining the visibility of variables, for instance, due to shadowing. The result of such a query is an array that associates scopes with names introduced within their bounds that matched the lookup.

```swift
struct Foo<A, B> {
  let a = A()
  let b = B()

  func bar(b: B) { // <-- `B` refers to the generic parameter `B`
    let a: A = a // <-- `a` refers to the member `a`
    let b: B = b // <-- `b` refers to the function parameter `b`
    print(self) // <-- `self` refers to the `struct` declaration
  }
}
```

`SwiftLexicalLookup` provides a lightweight and stateless unqualified lookup API that traverses the syntax tree. Every syntax node serves as an entry point for the name lookup through the `someNode.lookup(myIdentifier)` method. The behavior of the lookup can also be optionally configured through configurations that might, for example, change the behavior of top-level code. The result of the lookup method is an array of enums that associate appropriate `ScopeSyntax` nodes with names that match the lookup, ordered from the innermost to the outermost scope available at the origin of the lookup.

* Simple lookup queries return relevant syntax nodes.
* The `LookupResult` enum associates a `ScopeSyntax` node with names matching the lookup within a particular lexical scope.
* Names are represented by the `LookupName` enum, which stores the associated syntax node and might represent one of several kinds of names, including identifiers, declarations, or implicit names such as `self`.
* Some scopes share common functionality between themselves. For this reason, `SwiftLexicalLookup` includes more specialized scope protocols, such as `TypeDeclarationScope`, which contains the `implicitInstanceAndTypeNames` property representing implicit `self` and `Self` names introduced at those scopes.
