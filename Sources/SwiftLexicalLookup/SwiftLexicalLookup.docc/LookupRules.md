# Unqualified Lookup Rules

## Overview
Unqualified lookup can be initiated from any source position, optionally targeting a specific identifier for name comparison. Unqualified lookup traverses the syntax tree from bottom-up, collecting names that match the lookup criteria. A name matches the lookup if the specified identifier (if present) refers to the introduced name and the position from which the unqualified lookup was triggered is preceded by the position where the name was introduced, provided the name enforces position based availability by itself (such exceptions are for example type declarations).

## Default Scope Behavior
Names are introduced and their availabilities are set by special syntax nodes referred to as syntax scopes or simply scopes. By default, each scope for lookup produces a result object that associates the scope of origin with the matched names. Lookup is then invoked on the parent scope, i.e., the closest syntax scope ancestor of the original scope in the syntax tree.

## Name Kinds
There are three distinct kinds of names identified by unqualified lookup:
- **Identifier**: Represents `IdentifiableSyntax` syntax nodes introducing names such as `IdentifierPatternSyntax`, `ClosureParameterSyntax`, or `FunctionParameterSyntax`.
- **Declaration**: Represents `NamedDeclSyntax` syntax nodes introducing names such as `ClassDeclSyntax`, `FunctionDeclSyntax`, or `ProtocolDeclSyntax`.
- **Implicit**: Represents names introduced by some scopes implicitly, without an associated token representation. Such names include `self`, `newValue`, or `error`.

## Specialized Scopes
Some scopes share common behavior and can be further generalized as follows:
- **Type Scope** (`TypeScopeSyntax`): Implicitly introduces `self` and `Self` names.
- **Sequential Scope** (`SequentialScopeSyntax`): Interleaves its own results with results produced by *Introducing to Sequential Parent Scopes* when encountered during name extraction. Results are ordered from closest to furthest from the unqualified lookup position.
- **Introducing to Sequential Parent Scope** (`IntroducingToSequentialParentScopeSyntax`): Produces a result that is later interleaved with the results produced by its sequential parent.

> Example:
> Sequential Scope behavior (code block):
> ```swift
> func foo(x: Int?) {
>   // Guard scope
>   guard let a = x else { return }
> 
>   // In code block scope
>   let a: Int? = a
> 
>   // Guard scope
>   guard let b = x, let a else { return }
> 
>   // In code block scope
>   let a = b
> 
>   a // <-- lookup here
>   b // <-- lookup here
> }
> ```
> When looking up the reference `a`, we get 4 results in total, going from the bottom to the top of the source code: the `a` declaration associated with the function's code block body scope, the `a` variable associated with the bottom-most `guard`, another `a` declaration associated with the code block, and finally the `a` introduced in the top-most `guard`.
> When looking up `b`, on the other hand, we get just one result: the `b` declaration inside the bottom-most `guard`.

- **With Generic Parameters Scope** (`WithGenericParametersScopeSyntax`): Instead of invoking lookup on its parent scope, it first tries to pass it to the *Generic Parameter Scope* if available.
- **Generic Parameter Scope** (`GenericParameterScopeSyntax`): Instead of invoking lookup on its parent scope, it first tries to invoke it on the *With Generic Parameters Scope's* parent.

> Example:
> Generic Parameter Scope Behavior:
> ```swift
> class Foo<A, B: A> { // <-- lookup here
>   func bar<A, C>() {
>     X // <-- lookup here
>   }
> }
> ```
> When starting the lookup from the location marked `X` without identifier matching, we get two results. The first is associated with the generic parameter scope of the `bar` function, containing the names `A` and `C` in that exact order. The second is associated with the class `Foo`, containing the names `A` and `B` in that exact order. 
> When performing lookup at the `A` reference in the `Foo` class generic parameter clause, the generic parameter `A` introduced inside the clause is returned as in the result.

## Particular Scope Implementations
- **File Scope** (`SourceFileSyntax`): Conditional sequential scope syntax. Depending on user-defined configuration, the file scope can behave in two ways: either as a member block scope or as a sequential lookup for all declarations up to the first non-declaration statement.
- **Code Block Scope** (`CodeBlockSyntax`): Sequential scope. Introduces names from its statements with position-based availability.
- **For Statement Scope** (`ForStmtSyntax`): Introduces names from inside its pattern.
- **Closure Expression Scope** (`ClosureExprSyntax`): Introduces names from closure captures and parameters.
- **While Statement Scope** (`WhileStmtSyntax`): Introduces names from its conditions.
- **If Expression Scope** (`IfExprSyntax`): Introduces names from its conditions and specifies custom parent behavior. For nested `else if` statements, the parent scope is set to the enclosing scope for the entire `if` expression. Additionally, lookup from inside the `else` clause is routed directly to the parent scope.
- **Member Block Scope** (`MemberBlockSyntax`): Introduces names from its members.
- **Guard Statement Scope** (`GuardStmtSyntax`): Introduces names from its conditions to its sequential parent. For lookup from inside its `else` clause, no results are introduced.
- **Actor Declaration Scope** (`ActorDeclSyntax`): Type scope with generic parameters.
- **Class Declaration Scope** (`ClassDeclSyntax`): Type scope with generic parameters.
- **Struct Declaration Scope** (`StructDeclSyntax`): Type scope with generic parameters.
- **Enum Declaration Scope** (`EnumDeclSyntax`): Type scope with generic parameters.
- **Extension Declaration Scope** (`ExtensionDeclSyntax`): Type scope.
- **Accessor Declaration Syntax** (`AccessorDeclSyntax`): Introduces names from its parameters. If not present, and if the accessor is of `set` or `willSet` kind, it introduces the implicit `newValue` name. If of `didSet` kind, it introduces the implicit `oldValue` name.
- **Catch Clause Scope** (`CatchClauseSyntax`): Introduces the implicit `error` name if catch items are not specified.
- **Switch Case Scope** (`SwitchCaseSyntax`): Introduces names from its case items.
- **Protocol Declaration Scope** (`ProtocolDeclSyntax`): Does not introduce any names. For lookup initiated in its primary associated type clause, it performs lookup on its member scope exclusively for associated type declarations.
- **Generic Parameter Clause Scope** (`GenericParameterClauseSyntax`): Generic parameter scope syntax. Introduces names from its generic parameters with position-based availability.
- **Function Declaration Scope** (`FunctionDeclSyntax`): With generic parameters scope. Introduces names from its parameters.
- **Subscript Declaration Syntax** (`SubscriptDeclSyntax`): With generic parameters scope. Introduces names from its parameters.
- **Type Alias Declaration Scope** (`TypeAliasDeclSyntax`): With generic parameters scope. Does not introduce any names.
