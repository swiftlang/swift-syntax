# Parser Design

Learn the details of the techniques and decisions guiding the parser project.

## Overview

The design of the Swift parser and its supporting infrastructure is influenced 
heavily by the [Roslyn][roslyn] project and its family of parsers. We 
adopted a number of core design tenets:

- Source Fidelity
- Resilience
- Parsing with Minimal Context

## Source Fidelity

The overriding principle of the SwiftParser and SwiftSyntax libraries is the
efficient representation of the entirety of the text of source code. This
includes whitespace, comments, and `#!` directives, but also includes broken
UTF-8 bytes, the [Unicode byte order mark][BOM], and other textual oddities. 
The output of the parser should remain faithful to the textual content of its
input. This implies a number of important technical points:

### Faithful Parsing

In order to faithfully represent input text, the parser's methods must be 
implemented with a mindset that can be summarized as: never drop things on the
floor. Every byte of the input buffer must find its way into some part of the
resulting syntax tree. 

The most common kind of source fidelity bugs occur when early-exiting from a 
parsing function without considering the state that has been built up during 
the parse. For example, a loop that early-exits in response to an unexpected 
token must either construct a syntax node with missing elements
or drain its tokens into a token list syntax node as appropriate.

When porting productions from C++ to Swift, be mindful of whether the conditions
in the legacy code involve diagnostics and recovery, and how those conditions
have to change to maintain source fidelity.

### Source Fidelity Goes Hand-in-Glove With Tooling

Source fidelity as a goal optimizes for source-aware tools like formatters, 
linters, and editors. These tools accept user-provided text
in a variety of malformed or partial states and, in the case of formatters,
often need to reproduce that text with some modifications. Even when these
tools don't need to produce output, they still need to take advantage of the
maximum amount of structure they can get.

By contrast, parsers for programming languages are usually lossy. Most
compilers do not process whitespace and comments in a meaningful sense, so their
ASTs drop this information after lexical analysis completes. This leaves 
tooling authors left to pick up the pieces by reimplementing whitespace-aware
ASTs.

### `String` is Rarely Appropriate in the Syntax Tree

Swift's `String` type provides a vocabulary type for safe, unicode-correct 
handling of text. Unfortunately, unicode correctness implies that instances of 
`String` do not maintain fidelity with respect to all inputs. In order to 
guarantee its internal invariants around UTF-8 correctness, invalid inputs are 
healed with a special replacement character. This makes `String` unsuitable not
just as a backing data structure, but also as a vocabulary type for operations 
in this library that interact with source code. SwiftSyntax instead provides the
`SyntaxText` type that behaves as a safe buffer of raw bytes that does no
interpolation or healing. 

The parser should not be made to convert `SyntaxText` instances to `String` 
instances without verifying that this will have no impact on the textual
content of the syntax node. For example, Swift's keywords are all ASCII 
identifiers that will round-trip between `SyntaxText` and `String`.

### Complete Insulation from Raw APIs

In order to efficiently represent source text, SwiftSyntax provides a set of 
"raw" APIs for syntax nodes. These raw nodes provide extremely low-level access
to the content of the syntax tree. However, the lifetimes of raw syntax nodes
are tightly scoped to an enclosing `SyntaxArena`, which makes escaping these 
nodes an unsafe operation. In order to prevent this, the parser consumes the 
raw node creation interface as SPI and does not provide external clients a way 
to view the raw syntax it constructs directly. Instead, clients are provided 
with a high-level, safe view of raw syntax that avoids the ownership 
problem cited above while also providing a much nicer view of common operations
on the syntax tree.

The rule of thumb is that any operation that traffics in or stores `Raw`
data should not be escaped via a public API to clients of this library. If
access to raw data is needed, the operation should be tagged `@_spi(RawSyntax)`.

## Resilience

Resilience refers to the extent to which the SwiftParser API can accept 
ill-formed inputs and still produce a well-formed output. Our metric for
"well-formedness" is structure. The more syntactic structure the parser is able
to output, the better chance a client will have of being able to interpret
that structure and accomplish its task. As part of that resilience story, the
parser includes a number of facilities for recovering from invalid, unexpected,
and missing tokens in its input stream. The syntax tree also affords us the
ability to insert these "missing" syntax elements as explicit nodes in the tree.
To complement this, SwiftSyntax provides multiple different "views" of the
syntax tree that can include these missing or unexpected nodes on demand.

For more information on parser recovery and resilience, see <doc:ParserRecovery>.

## Parsing with Minimal Context

The parser takes another unusual stance in its construction: it is mostly
stateless. It is not a hard and fast rule that the parse be stateless, but 
engineering it with that mindset has enabled a relatively clean, testable 
parser design to emerge. Swift is not a context-free language, so there will
inevitably need to be some state involved during the parse. The parser is
designed to sequester those stateful decisions (e.g. `Parser.Lookahead`) 
away from the main parse productions.

What ambient state is present occurs as arguments to certain productions that
are required to enable or disable their child productions in response to some 
condition. One common case is a "mode bit" where one parsing API can be 
configured by its callers to accept or reject many kinds of productions. It is 
preferable to keep as few parameters on productions as possible to minimize
the surface area of the parser's APIs and prevent context from creeping in.

Minimizing ambient state isn't just about hygiene, it also helps keep 
incremental parsing practical. The more state that accumulates in the parser and
its productions, the more state must be tracked and restored across incremental
compilation sessions. The addition of state in the parse also affects the
parser's ability to reuse nodes during an incremental parse.

### Diagnostics

The parser library separates identifying invalid syntax from reporting invalid 
syntax to users in the form of diagnostics. By restricting the parser to just 
the identification of missing and unexpected syntax, the implementation becomes 
far easier to reason about.

Not emitting diagnostics is also a key component of the incremental parse. One
way to think of a diagnostic is as the outcome of a set of parsing decisions
that led to its emission. An arbitrary edit to the input can lead to a different
set of decisions being made, which means the parser would have to keep track
of the exact set of conditions that led to a particular diagnostic so it could
be invalidated. Alternatively, the parser could be made to compromise the 
incremental parse by invalidating far more state than it needs to in order to 
clear a set of stale diagnostics.

## Performance Goals

The SwiftParser library aims to replace the C++ parser that currently resides
in the [Swift compiler][Swiftc]. As such, minimizing the latency involved in
parsing is an extremely important goal. We aim to be competitive with the
performance of the C++ implementation of the Swift parser _without compromising
safety_.

## Additional Design Considerations

The remaining sections discuss loose design principles to bear in mind while
exploring or hacking on this codebase.

### Types are Cheap

The Swift programming language provides a rich feature set in its types
including enums with associated values, robust generics, and language facilities
for lifting raw bits and bytes into proper APIs. Prefer to make domain-specific
types rather than using e.g. `Bool` and `String`. Domain-specific types can
help an author maintain a safety contract with the rest of the parser and its
clients that is far stronger than the underlying value type would otherwise
provide. Importantly, custom types also provide an excellent opportunity to 
shape the way that a particular idea or concept is conveyed to users and 
developers of this library.

### Prefer The Least Visibility Possible

To keep types well-encapsulated, prefer to minimize the visibility of types and
methods unless there is a compelling reason to promote them to SPI or API. For
testability, prefer `@_spi` annotations to `@testable import`s of libraries.

### Make Liberal Use of Extensions

Extensions can help to break up the structure of a long stretch of related
functionality. Consider which methods and nested types are related and organize
them under a common extension. One common pattern is to define a type and the
methods that return that type under the same extension block.

### Design Testable APIs

There is no one-size-fits-all solution to designing a testable library or 
testable APIs. A helpful mindset to adopt is that of an API designer, even
for internal methods and state. Consider the API you'd want to adopt as an
end user.

[roslyn]: https://github.com/dotnet/roslyn/
[BOM]: https://unicode.org/faq/utf_bom.html
[Swiftc]: https://github.com/apple/swift
