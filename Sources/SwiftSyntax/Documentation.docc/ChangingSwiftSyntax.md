# Changing Syntax Nodes

Discover the steps necessary to add, remove, and update syntax nodes

## Overview

The surface area of the entire Swift programming language is represented in the
Swift Syntax API and its associated data structures. In order to keep these
structures in sync, this project makes use of a code generation utility called
[gyb][GYB] - short for "Generate Your Boilerplate". 

## Introduction to GYB

The gyb utility allows for [literate metaprogramming][LiterateProgramming] of 
files in any human-editable format. The standard convention is to attach the
`.gyb` suffix to a file. For example, this repository uses `.swift.gyb` files
that generate `.swift` code. The metaprogramming language that gyb uses is
python. Templating code is delimited by `%` and can be used inline with `${...}`
blocks. 

Here is the gyb definition for all of the cases of the <doc:TokenKind> enum.

```swift
public enum TokenKind: Hashable {
  case eof
% for token in SYNTAX_TOKENS:
%   kind = token.swift_kind()
%
%   # Tokens that don't have a set text have an associated value that
%   # contains their text.
%   if not token.text:
%     kind += '(String)'
%   end
  case ${kind}
% end
}
```

- Note: gyb files act as the source of truth in this repository. Always edit
        gyb files instead of the corresponding Swift files, or your changes will
        be overwritten the next time those files are regenerated.

## Regenerating Files

While working on gyb files, it can be helpful to regenerate the files in this
repository to see the effects of local changes. SwiftSyntax comes with a script
called `build-script.py` that automates the process of regenerating, validating,
and building all of the files in this repository. 

To invoke `build-script.py` to regenerate source code, run

```
$ ./build-script.py generate-source-code --toolchain /Path/To/Toolchain
```

where `/Path/To/Toolchain` can point either to the `XcodeDefault.xctoolchain`
installed with Xcode, or to a [toolchain downloaded from swift.org][SwiftToolchains].

- Note: To see the raw commands that `build-script.py` is running, use the `-v`
        flag. This can be used to dump the command(s) necessary to regenerate
        one file at a time.

This script also comes with a verification command that is run by Swift's
CI/CD systems to ensure that you regenerate files before they are checked into
the version control system. 

To invoke `build-script.py` in verification mode, run

```
$ ./build-script.py verify-source-code --toolchain /Path/To/Toolchain
```

## Adding and Removing Syntax Nodes

The files containing the definition of all of the syntax nodes are available
under the [gyb_syntax_support][gyb_syntax_support] directory. These files
are roughly divided according to broad syntactic categories in the Swift
programming language. That is, the syntax nodes for classes, structs, and actors
are defined in `DeclNodes.py`, while the syntax nodes for string literals, 
arrays, and tuples is defined in `ExprNodes.py`.

To add a node to these files, it can be helpful to copy an existing node and 
alter its definition to suit the needs of the new syntax being defined. A syntax
node consists of a name, a kind, and a list of child nodes. The name of a node
not only identifies it uniquely to Swift Syntax, it also provides a handle that
other nodes can use to refer to it. The kind of a syntax node defines the
class of syntax the node belongs to. All nodes are at least of the `Syntax`
kind, though some nodes may have a more specific kind like `Stmt` for
statements or `Expr` for expressions. The SwiftSyntax library expands these
kinds into protocol conformances and allows for casting strongly typed syntax
nodes among these categories for easier processing.

The node for a source file is reproduced below:

```python
Node('SourceFile', name_for_diagnostics='source file', kind='Syntax',
     traits=['WithStatements'],
     children=[
         Child('Statements', kind='CodeBlockItemList',
               collection_element_name='Statement'),
         Child('EOFToken', kind='EOFToken')
     ]),
```

Notice that the `Statements` child node contains a `collection_element_name`
field. This is because it is defining a syntax collection with the type
`CodeBlockItemList` with elements that are `Statement` nodes.

- Warning: Always remember to run `build-script.py` to regenerate files after
           you make changes to the syntax nodes.


## Adding and Removing Attributes

The file that defines all of the attributes respected by the Swift compiler 
is available under the [gyb_syntax_support][gyb_syntax_support] directory
in AttributedKinds.py. 

### Type Attributes

To define a new attribute that applies to types, add a new `TypeAttribute` to
the `TYPE_ATTR_KINDS` list with the name of the attribute spelled without the
leading '@' sign.

```python
TypeAttribute('_myAttribute'), # Becomes @_myAttribute in the compiler
```

### Declaration Attributes

To define a new attribute that applies to declarations, add a new 
`DeclAttribute` to the `DECL_ATTR_KINDS` list. Declaration attributes are
richer than type attributes, and require a bit more metadata to define them.
A `DeclAttribute` consists of the attribute's name, the name of the 
corresponding C++ class, a series of metadata tags, and a stable serialization
code.

To add an attribute, identify an unused serialization code and place the
attribute in the correct position in the `DECL_ATTR_KINDS` list. Then,
fill out the corresponding metadata and tags. At a minimum, every attribute
should come with ABI and API stability tags. But there are also tags that
alter the behavior of the AST printer and the parser that may be desirable.

The definition of the `_silgen_name` declaration attribute is reproduced below
as it provides a good example of many of these tags:

```python
DeclAttribute('_silgen_name', 'SILGenName', # Spelled @_silgen_name, becomes SILGenNameAttr in C++
              OnAbstractFunction, # Only applies to functions - parser will diagnose other usages automatically
              LongAttribute,  UserInaccessible, # Attribute should be printed on its own line since it's long.
              ABIStableToAdd,  ABIStableToRemove, APIStableToAdd,  APIStableToRemove, # Stability tags
              code=0), # Serialization code
```

Once a new attribute has been added, you will need to regenerate SwiftSyntax to
account for it. If the attribute includes a non-trivial set of arguments, 
consider adding a dedicated syntax node for it as well. To use the new attribute
with the Swift compiler, ensure that swift-syntax and swift are checked out
alongside each other and invoke the appropriate build tool to rebuild the Swift
compiler. The compiler's build system automatically detects changes to the 
Attr.def.gyb gyb file and the python defined here. 

## Committing Changes

When it is time to commit changes to the Swift Syntax repository, most cases
of adding syntax will require a single PR to swift-syntax. Added
syntactic elements will require corresponding changes to the included 
SwiftParser library. For an introduction on parsing Swift nodes, see 
[the article on Parsing Basics][ParserBasics].

@Comment {
  When docc resolves https://github.com/apple/swift-docc/issues/255, this should
  be an inter-target link.
}

When updating nodes, certain clients of SwiftSyntax that are relying upon those
nodes will need to be changed in tandem. For example, the 
[swift-stress-tester][swift-stress-tester] uses SwiftSyntax, and the CI/CD
system will not allow changes to SwiftSyntax that break `swift-stress-tester`
wihtout a paired change to that repository.

When adding nodes or removing existing nodes, it is often the case that you 
will need a paired PR to the [Swift Compiler repository][Swiftc] as well. This
step currently involves some amount of duplication with the SwiftParser library
and is a much more involved process. [The Swift Forums][CompilerDev] are a 
great source for guidance on how to extend the C++ compiler to accomodate new 
syntax and semantics for the Swift programming language.

[GYB]: https://github.com/apple/swift/blob/main/utils/gyb.py
[LiterateProgramming]: https://en.wikipedia.org/wiki/Literate_programming
[SwiftToolchains]: https://www.swift.org/download/
[gyb_syntax_support]: https://github.com/apple/swift-syntax/tree/main/Sources/generate-swift-syntax-builder/gyb_syntax_support
[swift-stress-tester]: https://github.com/apple/swift-stress-tester
[Swiftc]: https://github.com/apple/swift
[ParserBasics]: https://github.com/apple/swift-syntax/tree/main/Sources/SwiftParser/SwiftParser.docc/ParsingBasics.md
[CompilerDev]: https://forums.swift.org/c/development/compiler/
