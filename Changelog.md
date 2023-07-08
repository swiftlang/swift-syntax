# Changelog

Note: This is in reverse chronological order, so newer entries are added to the top.

## `main`

* With the introduction of the new `SwiftParser`, the existing `SwiftSyntaxParser` is deprecated and will be removed. The module and it's API surface still exists as a thin wrapper over `SwiftParser`, which no longer requires a matching toolchain or `_InternalSwiftSyntaxParser` shared library to work.

## Swift 5.6

* To clarify that the edits passed to `IncrementalParseTransition` are applied concurrently, introduce a new `ConcurrentEdit` type that provides the guarantee and allows translation of sequentially applied edits to the expected concurrent form.
* The `SwiftSyntaxParser` type and a few related types now live in their own module (also named `SwiftSyntaxParser`). This allows using `SwiftSyntax` for code generation purposes without having a compatible `_InternalSwiftSyntaxParser.dylib` around. 

  `import SwiftSyntaxParser` where necessary.
* `DiagnosticEngine` has been removed. Instead, `SyntaxParser` takes a closure through which it emits parser diagnostics. Depending on your needs, use the closure to handle the diagnostics or write + hook up your own diagnostics engine.

## Swift 5.3

* Introduced `FunctionCallExprSyntax.additionalTrailingClosures` property with type `MultipleTrailingClosureElementListSyntax?` for supporting [SE-0279 Multiple Trailing Closures](https://github.com/apple/swift-evolution/blob/main/proposals/0279-multiple-trailing-closures.md).

* Introduced `syntaxNodeType` property for all types conforming to `SyntaxProtocol`, which returns the underlying syntax node type. It is primarily intended as a debugging aid during development.

* Provided a clearer error message for the "parser compatibility" error.

## Swift 5.2

- `ReversedSyntaxChildren` has been removed
  
  Use the `reversed()` property on `SyntaxCollection`, which now conforms to `BidirectionalCollection` instead.

- `SyntaxCollection`s now conform to `BidirectionalCollection`

  The previous conformance to `Sequence` has been upgraded to a conformance to `BidirectionalCollection`

- Properties `isExpr`, `isDecl`, `isStmt`, `isType` and `isPattern` removed from `SyntaxNode`

  Use `is(ExprSyntaxProtocol.self)` etc. instead.

- Property `uniqueIdentifier` removed from syntax nodes and `SyntaxNode`
  
  Use the newly added property `id` or the conformance to `Identifiable` instead.

- Syntax nodes and `SyntaxNode` conform to `Identifiable`
  
  `Identifiable` conformance has been added to all syntax nodes and the `SyntaxNode` type using `SyntaxIdentifier` as the identifier.

- The `walk` method on syntax nodes has been removed.

  Instead, use the `walk` method on the `SyntaxVisitor`.
  
  ```swift
  // Before 
  tree.walk(&visitor)
  
  // Now
  visitor.walk(tree)
  ```

- `SyntaxVisitor` and `SyntaxAnyVisitor` are a `class` and no longer a `protocol`.

  For performance reasons the `SyntaxVisitor` and `SyntaxAnyVisitor` were migrated from being a protocol to being a class.
  
  Any structs conforming to the above protocols need to become classes. Implementing methods need to be marked `override` and, if necessary, any `mutating` keywords need to be removed.
  
  ```swift
  // Before
  struct Visitor: SyntaxVisitor {
    mutating func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
      /* ... */
    }
  }
  
  // Now
  class Visitor: SyntaxVisitor {
    override func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
      /* ... */
    }
  }
  ```
  
- A new type `SyntaxEnum` has been introduced
  
  The new type `SyntaxEnum` allow exhaustive switching over all syntax types. It can be constructed by calling `asSyntaxEnum` on `Syntax`.
  
  ```swift
  let node: Syntax
  
  switch node.as(SyntaxEnum.self) {
    case .identifierExpr(let identifierExprSyntax):
    /* ... */
  }
  ```


### Modelling syntax nodes as structs

For increased performance, the modelling of the syntax node hierarchy has been switched from being `protocol`-based to being `struct`-based. This includes the following changes:

- The protocols `ExprSyntax`, `DeclSyntax`, `Syntax` etc. have been removed

  For passing values of these types around, use the new type erasers `ExprSyntax`, `DeclSyntax`, `Syntax` etc. instead. To add computed properties or functions to all expression nodes, write an extension on `ExprSyntaxProtocol`. To add methods to all syntax nodes, extend `SyntaxProtcol`.

  **Pass type eraser**
  
  ```swift
  func foo(_ expr: ExprSyntax) {}
  ```
  
  stays the same. `ExprSyntax` is now a struct and not a protocol. See below on how to create an `ExprSyntax`.

  **Extending a type**
  
  ```swift
  // Before
  extension ExprSyntax {
    func evaluateAsIntegerExpr() -> Int { /* ... */ }
  }
  
  // Now
  extension ExprSyntaxProtocol {
    func evaluateAsIntegerExpr() -> Int { /* ... */ }
  }
  ```


- Checking a node's type can no longer be performed using the `is` operator. Use the `is(_: SyntaxProtocol)` method on any type eraser instead. 

  ```swift
  // Before 
  exprSyntax is IdentifierExprSyntax

  // Now
  exprSyntax.is(IdentifierExprSyntax.self)
  ```

- To retrieve the non-type erased version of a type, use the `as(_: SyntaxProtocol.self)` method

  ```swift
  let identifierExprSyntax: IdentifierExprSyntax = /* ... */
  let node = Syntax(identifierExprSyntax)
  node.asProtocol(SyntaxProtocol.self) // returns an IdentifierExprSyntax with static type SyntaxProtocol
  node.asProtocol(ExprSyntaxProtocol.self) // returns an IdentifierExprSyntax with static type ExprSyntaxProtocol?
  ```


- Downcasting can no longer be performed using the `as` operator. For downcasting use the `as(_: SyntaxProtocol)` method on any type eraser. 

  ```swift
  // Before
  exprSyntax as? IdentifierExprSyntax

  // Now
  exprSyntax.as(IdentifierExprSyntax.self)
  ```

- Upcasting needs to be performed explicitly. Use the designated initializers for this.

  ```swift
  // Before
  func foo() -> ExprSyntax {
    /* ... */
    return identiferExprSyntax
  }
  
  // Now
  func foo() -> ExprSyntax {
    /* ... */
    return ExprSyntax(identiferExprSyntax)
  }
  ```
