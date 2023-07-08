# Parser Recovery

Recover from errors in parsing input.

## Recovery

Parser recovery is the process of identifying and resolving issues that arise
while parsing malformed Swift code. When this occurs, the Swift parser must
look forward in the input stream to a point at which parsing of valid syntax
can continue. Good parser recovery strikes the right balance between skipping
ahead in the input stream and producing as much structure from the malformed
input stream as possible.

The Swift parser tries to represent as much structure in the input stream as
possible. To that end, the parser tries to recover by looking through the 
minimum amount of tokens. This optimizes for clients like formatters and editors
that often receive malformed, partial, and unstructured inputs and must produce
sensible outputs in response.

The Swift parser differs from many other language parsers by intentionally
focusing on two broad classes of parsing errors:

- Unexpected Syntax
- Missing Syntax

Many parsers for programming languages go to great lengths to pattern match 
against their inputs to produce targeted diagnostics that identify specific 
user mistakes. By focusing the Swift parser on just missing and unexpected
syntax, the core of the parser is kept free of the clutter associated
with these diagnostics.

## Recovering from Unexpected Syntax

When the parser expects a token but can’t find it, it looks ahead to see if it 
can find the expected token by using a token precedence model. Tokens are 
divided in precedence groups (see `TokenPrecedence`), 
depending on how strongly they mark the structure of the source code. For 
example, keywords that start a declaration, like `func`, have a higher 
precedence than expression keywords, like `self`.

Consider a for-in loop like the following, where the `in` keyword has been
exchanged with the identifier `ys`:

```swift
for x ys in { }
```

To reach the `in` keyword, the parser looks past the identifier token
because it has the same token precedence. Having found the `in` keyword, the
parser yields both the unexpected identifier token `ys` and the token for the
`in` keyword for placement in the tree.

## Recovering from Missing Tokens

When looking past unexpected tokens fails, the parser declines to consume the
current token and produces a missing syntax element instead. Missing tokens have
no textual content associated with them. They exist to fulfill our goal of 
maintaining as much structure in the parse as possible, and have the added
benefit of being easily identifiable by the diagnostic post-pass.

Consider a nameless function like the following:

```swift
func () { } 
```

The parser expects to find an identifier token after the `func` keyword, but
instead finds the opening left parenthesis token for the argument list. In this
case, looking forward in the input would be fruitless since there are no 
identifiers that could be the name of this function. In practice, the
precedence of an identifier token is lower than that of a delimiter like 
parentheses, so no lookahead occurs and a missing identifier is synthesized
into the function declaration.

## Recovering from Missing Syntax

In some cases, the parse stream is so malformed that entire syntax nodes cannot
be identified. For these cases, the parser yields `MissingSyntax` nodes of the
appropriate type. The presence of these missing nodes in the parse is the
impetus for many of the parser's recovery mechanisms to kick in, since they
signal a catastrophic parsing failure and no progress being made in parsing 
the input stream.

One prominent example of this kind of failure is when parsing declarations. The
parser detects the presence of attributes and modifiers as a signal that it
should begin parsing a declaration. But if no declaration is present, the
parser will consume the attributes and modifiers and produce a 
`MissingDeclSyntax` node.

```swift
@inlinable public /*missing function*/
```

Another is when parsing labeled statements where the label is present but no
statement follows:

```swift
label:
  struct Foo {}
```

This results in a `LabeledStmtSyntax` node that has a `MissingStmtSyntax` node
as its associated statement.

Missing syntax nodes, like missing tokens, help to ensure that the parser is
able to yield the maximum amount of structure back to clients. In the case of
`MissingDeclSyntax`, it also aids in keeping the textual content of the tree
faithful to the original input text, as there would otherwise be nowhere to
stick the parsed attributes and modifiers without dropping them on the floor.
