# Parsing Basics

Discover the basics of parsing the Swift grammar

## Overview

The Swift programming language follows a regular structure called a _grammar_
that is composed of rules that direct a conforming implementation on what
inputs constitute valid Swift programs. These rules also come with a set of 
conditions under which they can be executed. We refer to a rule that has syntax
as its output as a _production_. The production rule for parsing an optional
type from the Swift Book is reproduced below:

```
optional-type → type '?'
```

The `optional-type` production directs us to first parse a `type` production,
then parse a `?` token. Productions may be recursive - as in the reference to
`type` which contains `optional-type` as one of its child productions -
or conditional. This is usually denoted with a `|` as in:

```
metatype-type → type '.' 'Type' | type '.' 'Protocol'
```

This production directs us to first parse a type, then a '.' character,
and finally attempt to parse the identifier 'Type'. If 'Type' cannot be found,
we are to reset and try the right-side rule which directs us to instead parse
'Protocol'. 

- Note: The left and right conditions of the `metatype-type` production 
share the same structure up to the last identifier, it is natural to implement 
this rule as first parsing a type, then a dot, then checking to see if 'Type' or 
'Protocol' is present, rather than backing up and trying again when the first
rule fails.

A production can also account for syntactic elements that are allowed to be
absent from the input stream - denoted by `?`. Here, the `class-body` production
represents a class body that may contain zero or more `class-member` elements
surrounded by curly braces:

```
class-body → '{' class-members? '}'
```

Finally, a production can describe a sequence of syntactic elements by making
recursive reference to itself. The `class-members` production directs us to
parse a `class-member`, then to recursively parse another `class-member` if
possible:

```
class-members → class-member class-members?
```

## Productions as Syntax Nodes

The Swift Parser is built atop a framework that faithfully represents Swift
source code called SwiftSyntax. SwiftSyntax can be viewed as an encoding of the 
production rules of the Swift grammar in a tree-shaped data structure called a
syntax tree.

To take the examples above, `RawOptionalTypeSyntax` stands in for the output of the
`optional-type` production, and `RawMetatypeTypeSyntax` stands in for the output
of the `metatype-type` production. The structure of these nodes reflects the
structure of the productions that define them:

- `RawOptionalTypeSyntax` has a `wrappedType` property to retrieve its child `RawTypeSyntax`
- `RawMetatypeTypeSyntax` has a `baseType` property to retrieve its child `RawTypeSyntax`

These nodes also have accessors for associated tokens like the `?`
token or the `.`, `Type`, and `Protocol` tokens.

For sequences of syntax elements, SwiftSyntax provides corresponding
`SyntaxCollection` types.

- Note: Many sources refer to this structure as an "Abstract Syntax Tree" or 
        AST. Abstract, in these contexts, refers to the tree dropping some 
        amount of input structure that is not needed for analysis or compilation
        to proceed. Because the syntax trees in SwiftSyntax are designed to 
        faithfully represent source text, they are more accurately referred to 
        as "Concrete Syntax Trees" or just "Syntax Trees".

## Parsing Source Code into Syntax Nodes

Parsing is a fruitful sub-field of programming language research, with a wide
variety of techniques for dealing with many classes of inputs. One of the
simplest approaches to parsing languages like Swift is parsing by 
_recursive descent_. Just as SwiftSyntax encodes the results of productions,
a recursive descent parser encodes the content of production rules as a set of
mutually-recursive functions.

```swift
extension Parser {
  mutating func parseOptionalType() -> OptionalTypeSyntax {
    // First, recursively parse a type
    let base = self.parseType()
    // Then, parse a postfix question mark token
    let mark = self.eat(.postfixQuestionMark)
    // Finally, yield the optional type syntax node.
    return RawOptionalTypeSyntax(
      wrappedType: base, 
      questionMark: mark, 
      arena: self.arena
    )
  }
}
```

This simple function introduces many of the basic concepts that form the
backbone of the parser's implementation. The `Parser.eat(_:)` method
provides a function to examine the input stream and advance one step if the
provided token kind is present. To form the node, a call to the initializer
is made, which acts to wire up all of the sub-nodes into a single 
`RawOptionalTypeSyntax`.

### Unconditional Parsing

The `Parser.eat(_:)` method unconditionally consumes a token of the given
type, and an assertion is raised if the input token's kind does not match.
This function is most appropriate for encoding structural invariants during
the parse. For example, the decision to parse a `FunctionDeclSyntax` node is
made by examining the input stream for the `func` keyword. It is reasonable to
expect that the production implementing function parsing would `eat` its `func`
keyword. This ensures that callers always check for the `func` keyword before
calling the function parsing method.

### Conditional Parsing

To model conditional productions, the syntax tree uses `Optional`-typed
syntax nodes, and the parser uses the `Parser.consume(if:)` method. 
For a Swift declaration item, a trailing semicolon is optional:

```swift
extension Parser {
  mutating func parseDeclarationItem() -> RawMemberDeclListItemSyntax {
    // First, recursively parse a declaration
    let parsedDecl = self.parseDeclaration()
    // Next, consume the semicolon - if there is one.
    let semicolon = self.consume(if: .semicolon)
    return RawMemberDeclListItemSyntax(
      decl: parsedDecl, 
      semicolon: semicolon,
      arena: parser.arena)
  }
}
```

Unlike `Parser.eat(_:)`, if the parser does not encounter a token of the
given type, a `nil` token is returned and the input is left unconsumed.

### Sequence Parsing

To consume a sequence of syntax elements, a loop and a condition are needed.
Many sequences of elements in Swift are delimited by an inter-element token
like a comma or a period. A type's inheritance clause is a prime example of
a comma-delimited sequence of type syntax elements:

```swift
extension Parser {
  mutating func parseInheritance() -> RawTypeInheritanceClauseSyntax {
    // Eat the colon character.
    let colon = self.eat(.colon)
    // Start parsing a list of inherited types.
    var elements = [RawInheritedTypeSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      repeat {
        let type = self.parseType()
        keepGoing = self.consume(if: .comma)
        elements.append(RawInheritedTypeSyntax(
          typeName: type, trailingComma: keepGoing, arena: self.arena))
      } while keepGoing != nil
    }
    // Construct the syntax for the list of inherited types.
    let inheritedTypes = RawInheritedTypeListSyntax(
      elements: elements, arena: self.arena)
    return RawTypeInheritanceClauseSyntax(
      colon: colon,
      inheritedTypeCollection: inheritedTypes,
      arena: self.arena)
  }
}
```

This function populates an array of `RawInheritedTypeSyntax` elements separated
by commas. Since the commas must be present in the syntax tree, the `keepGoing`
variable plays double duty both as syntax and as the loop condition. It also
composes all of the parsing elements we have seen thus far, using both
unconditional parsing to assert an invariant, and conditional parsing to 
define the loop condition.

### Putting It All Together

Recursive descent parsing applies these three parsing techniques at scale. The
resulting parser very closely mirrors the structure of the grammar that it is
parsing, is relatively fast, and easy to tweak. When adding methods to
parse new productions, it can often be helpful to work backwards from the
call to the initializer of the returned syntax node type. Each input to the 
initializer can be obtained by recursively calling functions to parse nodes of
the appropriate type and applying the parsing techniques above to fill in 
the rest.
