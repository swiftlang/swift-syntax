# Swift Macros

Learn how to write Swift Macros.

Swift Macros allow you to extend the Swift language by generating code at compile time based on annotations in the source code itself. Conceptually, Macros are compiler extensions. The macro’s generation happens at build time and communicates directly with the compiler, which will incorporate the generated code into the compilation process.

With their tight integration into the compiler and the Swift language, macros use some compiler concepts like syntax trees that are able to represent the entire Swift language. Due to their complexity, macros are an advanced concept and are intended for library authors, who can use them to provide extensions to Swift that would be impossible without macros. Wherever possible, language features like generics, protocols and extensions should be preferred over macros. 

> Note: The core concepts of this article are also available as a video at <https://developer.apple.com/wwdc23/10166>

## Table of Contents

- [Macro Overview](#Macro-Overview)
  - [Macro Declaration](#Macro-Declaration)
  - [Macro Implementation](#Macro-Implementation)
- [Testing Macros](#Testing-Macros)
- [Macro Roles](#Macro-Roles)
- [Implement an `EnumSubset` macro](#Implement-an-EnumSubset-macro)
  - [Motivation](#Motivation)
  - [Declare EnumSubset](#Declare-EnumSubset)
  - [Implement EnumSubset](#Implement-EnumSubset)
- [Inspect the SwiftSyntax Tree](#Inspect-the-SwiftSyntax-Tree)
- [Building Syntax Nodes](#Building-Syntax-Nodes)
- [Emitting Errors](#Emitting-Errors)


## Macro Overview

A new Swift Macro template can be created from Xcode or the command line. 

- In Xcode, click File -> New -> Package… and select the *Swift Macro* template
- On the command line, run `swift package init --type macro`

Within the template, the `main.swift` file contains the following code.

```swift
let (result, code) = #stringify(a + b)
```

It uses an *expression macro*, indicated by the `#` character. At compile time, the compiler expands `#stringify(a + b)` to a tuple that contains the value of the macro’s argument as well as a string with the argument’s: `(a + b, "a + b")`. If `a = 17` and `b = 25` this evaluates to `(42, "a + b")` at runtime. In Xcode, the expanded code can be viewed by right-clicking on `stringify` and selecting *Expand Macro*.

To expand the `stringify` macro, the compiler requires two ingredients: The macro declaration and the macro implementation.

### Macro Declaration

The macro’s declaration declares the macro’s signature, including its input and output type. The declaration of `stringify` looks as follows

```swift
@freestanding(expression)
public macro stringify<T>(_ value: T) -> (T, String) = #externalMacro(module: "MyMacroMacros", type: "StringifyMacro")
```

`@freestanding(expression)` declares the macro with the freestanding expression macro role. This means that the macro can be used wherever an expression can be used and that its use is indicated by the hash character, like `#stringify`. More macro roles are discussed below in [Macro Roles](#Macro-Roles).

The next part of the macro declaration looks like a function signature. It takes a generic argument of type `T` and outputs a tuple containing the result, again of type `T`, as well as a string containing the source code of the macro’s argument. All arguments need to type check and the macro’s result type is inferred from the return type. If the arguments don’t type check or the result type doesn’t match its surrounding context, the compiler will emit an error without applying the macro expansion. This is different to, for example, C macros, which are evaluated at the pre-processor stage before type-checking.

The last part of the macro links the macro declaration to the macro implementation. `#externalMacro` tells the compiler that to expand the macro, it needs to use the `StringifyMacro` type in the `MyMacroMacros` module.

### Macro Implementation

The `StringifyMacro` type is declared in a separate target, which is a compiler plug-in. The compiler will send the macro expression to that plug-in. The plugin processes the macro expression as a SwiftSyntax tree, which is a source-accurate, structural representation of the macro, and it will be the basis on which the macro operates. 

For example, our `#stringify(a + b)` is represented by a `MacroExpansionExprSyntax` node in the following tree:

```
MacroExpansionExprSyntax
├─pound: pound
├─macroName: identifier("stringify")
├─leftParen: leftParen
├─arguments: LabeledExprListSyntax
│ ╰─[0]: LabeledExprSyntax
│   ╰─expression: InfixOperatorExprSyntax
│     ├─leftOperand: DeclReferenceExprSyntax
│     │ ╰─baseName: identifier("a")
│     ├─operator: BinaryOperatorExprSyntax
│     │ ╰─operator: binaryOperator("+")
│     ╰─rightOperand: DeclReferenceExprSyntax
│       ╰─baseName: identifier("b")
├─rightParen: rightParen
╰─additionalTrailingClosures: MultipleTrailingClosureElementListSyntax
```

That expression has the macro name `stringify` and takes a single argument, which is the infix operator `+` applied to `a` and `b`.

After the compiler plugin has parsed the macro expression into a syntax tree, it passes the syntax tree to the macro’s `expansion` function, which will return the expanded syntax tree. For the `#stringify` macro this looks as follows:

```swift
public struct StringifyMacro: ExpressionMacro {
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) -> ExprSyntax {
    guard let argument = node.argumentList.first?.expression else {
      fatalError("compiler bug: the macro does not have any arguments")
    }

    return "(\(argument), \(literal: argument.description))"
  }
}
```

The inheritance from the ``ExpressionMacro`` protocol indicates that the `StringifyMacro` type is an implementation of a macro with the expression macro role.

Inside the `expansion` function, the macro retrieves the single argument to the macro expression. It knows that this argument exists because `stringify` is declared as taking a single parameter and all arguments need to type-check before the macro expansion can be applied. It then uses string interpolation to create the syntax tree of a tuple. The first element is the argument itself and the second is a string literal containing the source code of the argument.

Note that the `expansion` function is not returning a string. It returns an `ExprSyntax`. The macro will automatically invoke the Swift parser to transform this literal into a syntax tree. It uses the `literal` interpolation style for the second argument, which will create a string literal containing the argument’s description, ensuring that the contents are properly escaped.

> Experiment: Create the macro template yourself and explore its contents.

## Testing Macros

Because macros don't have side effects and the source code of syntax trees is easy to compare, they are easily testable with unit tests. For example, a test case for the `stringify` may look as follows:

```swift
func testStringifyMacro() {
  assertMacroExpansion(
    """
    #stringify(a + b)
    """,
    expandedSource: """
    (a + b, "a + b")
    """,
    macros: ["stringify": StringifyMacro.self]
  )
}
```

This test case uses the `assertMacroExpansion` function from the `SwiftSyntaxMacrosTestSupport` module in the swift-syntax package to check that expanding `#stringify(a + b)` produces the expected result `(a + b, "a + b")`. 

Because the test target links against the macro implementation target directly, it doesn’t have access to the macro declaration. The `macros` parameter links the `stringify` macro name to the `StringifyMacro` implementation type.

Since the macro is expanded inside the test’s process, breakpoints can be set inside the macro’s expansion function during test execution. Writing a test case and setting a breakpoint inside the macro is usually the best way to understand how a macro functions at runtime. 

> Experiment: Run the test case of the macro template and set a breakpoint in the `expansion` function. 
> 
> Print the syntax nodes passed into the `expansion` function by running `po node` in the LLDB debug console. 
> - Note: In Swift 5.9 the debugger has a bug that disallows printing parameters declared with `some`. To work around it, change the function signature to 
> ```
> public static func expansion<NodeType: FreestandingMacroExpansionSyntax>(of node: NodeType, ...)
> ```

## Macro Roles

Below is an overview of the macro roles. To read more about each role, click on the type to read its documentation.

- `@freestanding(expression)` | ``ExpressionMacro``
  - Creates a piece of code that returns a value
- `@freestanding(declaration)` | ``DeclarationMacro``
  - Creates one or more declarations
- `@attached(peer)` | ``PeerMacro``
  - Adds new declarations alongside the declaration it's applied to
- `@attached(accessor)` | ``AccessorMacro``
  - Adds accessors to a property
- `@attached(memberAttribute)` | ``MemberAttributeMacro``
  - Adds attributes to the declarations in the type/extension it's applied to
- `@attached(member)` | ``MemberMacro``
  - Adds new declarations inside the type/extension it's applied to
- `@attached(extension)` | ``ExtensionMacro``
  - Creates an extension of the type it is attached to

## Implement an EnumSubset macro

### Motivation

SwiftSyntax contains a `Keyword` enum with all the keywords that can be used in the Swift language. Suppose we need an enum that only contains those keywords that can start type declarations, like `class`, `struct` and `actor` and we need to be able to convert between this type and the `Keyword` type. 

A hand-written implementation could look as follows, which is very repetitive. The goal is to define an `EnumSubset` macro that generates the initializer and the computed property.

```swift
enum TypeDeclarationKeyword {
  case `actor`
  case `class`
  ...

  init?(_ keyword: Keyword) {
    switch keyword {
    case .actor: self = .actor
    case .class: self = .class
    ...
    default: return nil
    }
  }

  var keyword: Keyword {
    switch self {
    case .actor: return .actor
    case .class: return .class
    ...
    }
  }
}
```

### Declare EnumSubset

Since both the initializer and the computed property are members of `TypeDeclarationKeyword`, the `EnumSubset` macro needs to be an attached member macro. In the following, we will only generate the initializer. Generating the computed property is analogous.

The macro declaration looks as follows.

```swift
@attached(member, names: named(init))
public macro EnumSubset<Superset>() = #externalMacro(module: "MyMacroMacros", type: "EnumSubsetMacro")
```

Compared to the `stringify` macro, `EnumSubset` differs in two ways:
1. It is declared as an attached member macro and defines the names of the members it introduces. Declaring the introduced names improves the compiler’s performance: When accessing a member that is not declared in the macro’s names, the compiler doesn’t need to try expanding the macro to find it.
2. `EnumSubset` doesn’t take any argument. Instead, it defines a generic parameter that is used to customize the superset – in the example this is `Keyword`. Using a generic parameter ensures that the superset type exists.

### Implement EnumSubset

A possible implementation of `EnumSubsetMacro` can look as follows. 

```swift
enum EnumSubsetError: CustomStringConvertible, Error {
  case onlyApplicableToEnum
  case noGenericParameterName
  
  var description: String {
    switch self {
    case .onlyApplicableToEnum: return "@EnumSubset can only be applied to an enum"
    case .noGenericParameterName: return "Missing generic parameter specifying the enum's superset"
    }
  }
}

public enum EnumSubsetMacro: MemberMacro {
  public static func expansion(
    of attribute: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    guard let enumDecl = declaration.as(EnumDeclSyntax.self) else {
      throw EnumSubsetError.onlyApplicableToEnum
    }

    // Extract the name of the generic parameter. 
    // See section *Inspect the SwiftSyntax Tree* for more details on building this expression.
    guard let supersetType = attribute,
      .attributeName.as(SimpleTypeIdentifierSyntax.self)?
      .genericArgumentClause?
      .arguments.first?
      .argumentType else {
      throw EnumSubsetError.noGenericParameterName
    }
    
    // Extract all the enum elements
    let members = enumDecl.memberBlock.members
    let caseDecls = members.compactMap { $0.decl.as(EnumCaseDeclSyntax.self) }
    let elements = caseDecls.flatMap { $0.elements }
    
    // Build the initializer using a result builder
    let initializer = try InitializerDeclSyntax("init?(_ superset: \(supersetType))") {
      try SwitchExprSyntax("switch superset") {
        for element in elements {
          SwitchCaseSyntax(
            """
            case .\(element.identifier):
              self = .\(element.identifier)
            """
          )
        }
        SwitchCaseSyntax("default: return nil")
      }
    }
    
    return [DeclSyntax(initializer)]
  }
}
```

## Inspect the SwiftSyntax Tree

One of the best way to explore the syntax trees is by example. <https://swift-ast-explorer.com> is a great webpage that allows the shows the syntax tree of entered Swift code.  

> Experiment: Try pasting the following code into <https://swift-ast-explorer.com> and compare the inspect syntax tree to understand the above code that extracts the name of the generic parameter in `EnumSubsetMacro.expansion`.
> ```
> @EnumSubset<Keyword>
> ```

Alternatively, the syntax tree can be printed in the debugger. When the debugger is stopped and `node` is a syntax node, the syntax tree can be printed using `po node`. This produces a syntax tree as shown in the [Macro Implementation](#Macro-Implementation) section.

## Building Syntax Nodes

There are three core approaches to build syntax nodes: Parsing from string literals, result builder initializers and memberwise initializers. 

The `stringify` macro created its result type, an `ExprSyntax`, from a string literal. As described in that section, this invokes the Swift parser to parse the contents of the string literal into a syntax tree. This technique works well for statically known trees, or trees with a fixed number of parameters.

The `EnumSubset` macro uses a result builder initializer to generate the `InitializerDeclSyntax` and `SwitchExprSyntax`. The initializer takes a header – the `switch` keyword and subject – and a trailing closure, which is a result builder that adds a `SwitchCaseSyntax` for every `case` item in the `switch` statement. Result builder initializers are a great tool for repetitive syntax constructs, like the `switch` in `EnumSubset`. Also note how `EnumSubsetMacro` combines result builders and string literals. It uses the result builder to generate the `SwitchExprSyntax` but the cases are constructed using string interpolation.

Finally, every syntax type has a memberwise initializer with which a syntax node can be created by specifying all its children. This initializer offers full control when creating a syntax node, but is also the most verbose.

## Emitting Errors

Macros are not always applicable. For example, it doesn’t make sense to apply the `EnumSubset` macro on a type that is not an enum. If a macro is used in ways that it doesn’t support, it is always better to emit custom error messages that tells the adopter about what’s going wrong, instead of having them read the generated code to debug the macro.

There are two ways to emit this error:

1. Throw an error from the `expansion` function. This generates a compilation error on the line of the attribute. This is the technique that the above example uses. 
2. Add it as a diagnostic with  ``MacroExpansionContext/diagnose(_:)``. This allows further customization, like changing the location, emitting a warning instead of an error, or even providing Fix-Its.
