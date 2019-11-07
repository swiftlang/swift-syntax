# Changelog

Note: This is in reverse chronological order, so newer entries are added to the top.

## Swift 5.2

- Property `uniqueIdentifier` removed from syntax nodes and `SyntaxNode` ([#164](https://github.com/apple/swift-syntax/pull/164))
  
  Use the newly added property `id` or the conformance to `Identifiable` instead.

- Syntax nodes and `SyntaxNode` conform to `Identifiable` ([#164](https://github.com/apple/swift-syntax/pull/164))
  
  `Identifiable` conformance has been added to all syntax nodes and the `SyntaxNode` type using `SyntaxIdentifier` as the identifier.

- The `walk` method on syntax nodes has been removed. ([#158](https://github.com/apple/swift-syntax/pull/158))

  Instead, use the `walk` method on the `SyntaxVisitor`.
  
  ```swift
  // Before 
  tree.walk(&visitor)
  
  // Now
  visitor.walk(tree)
  ```

- `SyntaxVisitor` and `SyntaxAnyVisitor` are a `class` and no longer a `protocol`. ([#158](https://github.com/apple/swift-syntax/pull/158))

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
  
- A new type `SyntaxEnum` has been introduced ([#155](https://github.com/apple/swift-syntax/pull/155))
  
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

- The protocols `ExprSyntax`, `DeclSyntax`, `Syntax` etc. have been removed. ([#155](https://github.com/apple/swift-syntax/pull/155))

  For passing values of these types around, use the new type erasers `ExprSyntax`, `DeclSyntax`, `Syntax` etc. instead. To add computed properties or functions to all expression nodes, write an extension on `ExprSyntaxProtocol`. To add methods to all syntax nodes, extend `SyntaxProtcol`.

  **Pass type eraser**
  
  ```swift
  func foo(_ expr: ExprSyntax) {}
  ```
  
  stays the same. `ExprSyntax` is now a struct and not a protocol. See below on how to create an `ExprSyntax`.

  **Extening a type**
  
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


- Checking a node's type can no longer be performed using the `is` operator. Use the `is(_: SyntaxProtocol)` method on any type eraser instead. ([#155](https://github.com/apple/swift-syntax/pull/155))

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
  node.as(SyntaxProtocol.self) // returns a IdentifierExprSyntax with static type SyntaxProtocol
  node.as(ExprSyntaxProtocol.self) // returns a IdentifierExprSyntax with static type ExprSyntaxProtocol?
  ```


- Downcasting can no longer be performed using the `as` operator. For downcasting use the `as(_: SyntaxProtocol)` method on any type eraser. ([#155](https://github.com/apple/swift-syntax/pull/155))

  ```swift
  // Before
  exprSyntax as? IdentifierExprSyntax

  // Now
  exprSyntax.as(IdentifierExprSyntax.self)
  ```

- Upcasting needs to be performed explicitly. Use the designated initializers for this. ([#155](https://github.com/apple/swift-syntax/pull/155))

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
