# Changing Syntax Nodes

Discover the steps necessary to add, remove, and update syntax nodes

## Overview

The surface area of the entire Swift programming language is represented in the
Swift Syntax API and its associated data structures. In order to keep these
structures in sync, this project generates code using the Swift package 
`CodeGeneration`, located in the root of this repository. 

## Regenerating Files

To re-generate the files after changing `CodeGeneration` run the `generate-swiftsyntax` 
target of `CodeGeneration` and pass `path/to/swift-syntax/Sources` as the argument.

On the command line, this would be
```bash
swift run --package-path CodeGeneration generate-swiftsyntax Sources
```

Or if you open the `CodeGeneration` package in Xcode, you can add the 
`generate-swift syntax ../Sources` arguments using Product -> Scheme -> Edit Scheme…

## Adding and Removing Syntax Nodes

The files containing the definition of all of the syntax nodes are available
under the [SyntaxSupport][SyntaxSupport] directory. These files
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

```swift
  Node(
    name: "SourceFile",
    nameForDiagnostics: "source file",
    kind: "Syntax",
    traits: [
      "WithStatements"
    ],
    parserFunction: "parseSourceFile",
    children: [
      Child(
        name: "Statements",
        kind: .collection(kind: "CodeBlockItemList", collectionElementName: "Statement")
      ),
      Child(
        name: "EOFToken",
        kind: .node(kind: "EOFToken")
      ),
    ]
  ),

```

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

[LiterateProgramming]: https://en.wikipedia.org/wiki/Literate_programming
[SwiftToolchains]: https://www.swift.org/download/
[SyntaxSupport]: https://github.com/apple/swift-syntax/tree/main/CodeGeneration/Sources/SyntaxSupport
[swift-stress-tester]: https://github.com/apple/swift-stress-tester
[Swiftc]: https://github.com/apple/swift
[ParserBasics]: https://github.com/apple/swift-syntax/tree/main/Sources/SwiftParser/SwiftParser.docc/ParsingBasics.md
[CompilerDev]: https://forums.swift.org/c/development/compiler/
