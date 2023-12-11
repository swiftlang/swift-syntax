# Working with SwiftSyntax

Learn the basics of working with Swift source code with the SwiftSyntax library.

## Overview

The SwiftSyntax library provides data structures and algorithms for inspecting,
processing, and manipulating Swift source code with a high-level, safe, and 
efficient API. The SwiftSyntax library is the foundation upon which tools like
the Swift parser, swift-format, and Swift macros are built.

## Syntax Trees

SwiftSyntax is a library for representing Swift source code with a data structure
called a *syntax tree*. The structure of a syntax tree reflects not just the
relative order and position of text and whitespace in a file 
\- its "lexical structure" - but also the relationship between nested syntactic
elements and their neighbors - its "syntactic structure".

The syntax tree was designed with three tenets in mind:

### Immutability

The syntax tree is a fully immutable [persistent data structure][PersistentDataStructure]. 
Once created, the syntax tree never changes, and may only be modified by
creating a new syntax tree. The SwiftSyntax library provides a number of APIs 
for modifying an existing syntax tree efficiently and safely. It does so by
copying only the minimal amount of structure that has changed into the new
tree. Any unchanged structure from the original tree becomes part of a shared 
core that is transparently wrapped by the new syntax tree. In this way, the
SwiftSyntax library reuses and shares as much data as possible during syntactic 
transformations. This reduces the overall memory footprint and the overhead
normally associated with copying large and complex data structures like 
syntax trees.

Immutability also comes with the benefits of fearless concurrency. It is always
safe to manipulate a syntax tree across threads. Two threads mutating the same
tree will receive two independent copies of their respective modified syntax
trees that will never interfere with each other. Moreover, modifications to 
the syntax tree do not involve locks or mutexes.

### Source Fidelity

The SwiftSyntax library is designed to represent not just text, but 
whitespace, comments, compiler directives, and otherwise invisible data like 
the [Unicode byte order mark][BOM]. Collectively, these non-syntax entities are
referred to as "trivia". The syntax tree holds on to every byte of
information in the source text, and can render the original document
with full accuracy and precision. This property is referred to as 
"source fidelity", because the syntax tree is always a faithful recreation of 
the source code it was given as input.

### Resilience

To achieve source fidelity, both well-formed and ill-formed source code must
be equally representable in the syntax tree. The syntax tree can represent two
broad classes of errors: missing syntax and unexpected syntax. Missing syntax
provides a spot for a syntax element that was expected by a parser or lexical
analyzer but was not present in source.

```
func (uhoh: Void) {}
     ^ Missing identifier
```

Missing syntactic elements are represented in the tree as tokens with a 
``SourcePresence/missing`` source presence. These missing tokens are just as
much a part of the syntax tree as ``SourcePresence/present`` nodes, and
can be inspected and manipulated as normal syntax. One important use-case is
a "healing linter" which can examine missing nodes and fill in keywords, 
identifiers, and placeholders as appropriate in addition to warning about 
syntactic nits.

Unexpected syntax is any superfluous text encountered by a parser or lexical
analyzer.

```
func four score and seven years ago(uhoh: Void) {}
          ^~~~~~~~~~~~~~~~~~~~~~~~~ Unexpected text
```

Unexpected nodes allow parsers to gracefully recover during parsing by scanning
forward in the input stream until they reach a known recovery point. The
Swift parser included with the swift-syntax package uses this implementation
strategy to great effect. This makes the parser resilient to a broad 
class of input errors that users of editors and IDEs would make during the 
course of an editing session.

## Syntax Nodes

A syntax tree is made up of elements called syntax nodes. To help categorize
and organize syntax nodes, SwiftSyntax defines a hierarchy of protocols for
syntax nodes. At the top of this hierarchy is the ``SyntaxProtocol`` protocol.
To represent related categories of syntax, ``SyntaxProtocol`` is further 
refined:

- ``DeclSyntaxProtocol`` for declarations like `struct`s, `class`es, `enum`s and `protocol`s.
- ``StmtSyntaxProtocol`` for statements like `if`, `switch`, and `do`.
- ``ExprSyntaxProtocol`` for expressions like function calls, literals, and closures
- ``TypeSyntaxProtocol`` for types like `Array<String>`, `[String: String]`, and `some Protocol`
- ``PatternSyntaxProtocol`` for patterns like `case (_, let x)`

Syntax nodes form the "branches" of the syntax tree, as they are generally 
high-level collections of one or more syntax nodes. Taken together, these
branches form the syntactic structure of the source code. This structure is
used by compilers and static analyzers to process source code at a high level.

A special kind of syntax node is a ``SyntaxCollection``, which represents syntax
with a variable number of children. For example, a code block value can contain
zero or more statements in between a pair of braces. To represent these 
children, a ``CodeBlockSyntax`` value has a ``CodeBlockSyntax/statements`` 
accessor that returns a ``CodeBlockItemListSyntax`` value. The elements of this
syntax collection are ``CodeBlockItemSyntax`` values.

## Syntax Tokens

At the leaves of the syntax tree are ``TokenSyntax`` values. A token syntax 
value represents an atomic unit of syntax and any associated trivia, like an 
identifier and the whitespace around it. Taken together, the tokens of a syntax 
tree represent the lexical structure of the source code. This structure is used
by linters and formatters to analyze the textual content of source code. 

## Syntax Trivia

Trivia includes whitespace, comments, compiler directives, and erroneous source
code. Trivia contributes most meaningfully to the lexical structure of a 
document, but often has little bearing on its syntactic structure. For this
reason, tools like compilers often discard trivia during source code processing.
However, maintaining trivia is important for tools like editors, IDEs, 
formatters, and refactoring engines. SwiftSyntax represents trivia explicitly
with the ``Trivia`` type. Trivia associated with token syntax can be inspected 
with  the ``TokenSyntax/leadingTrivia-9512z`` and 
``TokenSyntax/trailingTrivia-5jclz`` accessors.

## Navigating the Syntax Tree

The SwiftSyntax library provides a number of ways of traversing the syntactic
structure of a syntax tree. Every syntax node includes a reference to its
parent node via the ``SyntaxProtocol/parent`` accessor, and a reference to its
child nodes via the ``SyntaxProtocol/children(viewMode:)`` method. The children 
of a syntax tree always appear in order and the associated `viewMode` allows
the client to express their intent to process missing and unexpected syntax. 

Syntax nodes also contain strongly-typed APIs to access those same child nodes
individually. For example, ``ClassDeclSyntax`` provides an 
``ClassDeclSyntax/identifier`` to get the name of the class, as well as
``ClassDeclSyntax/members`` to get the syntax node representing the braced block 
with its members.

Most syntax analyzers want to work with more than one kind of syntax at a time,
and traverse this syntax in a regular order starting from the root and working
towards the leaves. SwiftSyntax provides a standard suite of classes and 
protocols for working with syntax traversals with a visitor-style API. 

A ``SyntaxVisitor`` can be used to walk source code from the root to its leaves.
To inspect a particular kind of syntax node, a client needs to override the 
corresponding `visit` method accepting that kind of syntax. The visit methods 
are invoked as part of an in-order traversal of the syntax tree. To provide a 
post-order traversal, the corresponding `visitPost` methods can be overridden.

Visitors that rewrite particular syntax nodes can be implemented as a subclass
of ``SyntaxRewriter``. Like a ``SyntaxVisitor``, a client needs to override
the corresponding `visit` method accepting the syntax node of interest, and
return a rewritten syntax node as a result.

## Modifying the Syntax Tree

The syntax trees provided by the SwiftSyntax library are immutable. All
modifications of the syntax tree are expressed as in-place updates to an 
existing syntax tree, and return new syntax trees. SwiftSyntax provides a set
of high-level APIs for expressing these modifications. In general, data in
syntax nodes can be accessed via a getter and updated with a corresponding
`with*` method. For example, the name of a class can be retrieved with the
``ClassDeclSyntax/identifier`` accessor, and replaced with the 
``ClassDeclSyntax/with(_:_:)-3exln`` update function. This method returns
a new ``ClassDeclSyntax`` value.

## Building Syntax Trees

The swift-syntax package provides the `SwiftParser` module to parse arbitrary
source text into syntax trees. The Swift parser is appropriate for situations
where code is provided by a user, or cannot otherwise by predicted ahead of
time. However, there are often times when the structure of source code is known
at build time. For these cases, the SwiftSyntax library provides a method
for transparently interpreting string literals containing source code as syntax
trees when the `SwiftSyntaxBuilder` module is also imported:

```swift
import SwiftSyntax
import SwiftParser
import SwiftSyntaxBuilder

// `file` is a source file syntax node containing the parsed value of the
// provided text.
let file: SourceFileSyntax =
  """
  print("Hello, world!")
  """
```

String processing is not limited to string literals. Further interior string 
interpolations can be used to parameterize the code in syntax generating 
functions.

```swift
import SwiftSyntax
import SwiftParser

func createClass(named name: String) -> ClassDeclSyntax {
  return """
         class \(raw: name) {}
         """
}
```

Using string literals and interpolation to build up syntax provides a fluid
and natural API for building up complex syntax trees. This is generally 
preferred to transforming syntax trees via a chain of `with*` calls.

[BOM]: https://unicode.org/faq/utf_bom.html
[PersistentDataStructure]: https://en.wikipedia.org/wiki/Persistent_data_structure
