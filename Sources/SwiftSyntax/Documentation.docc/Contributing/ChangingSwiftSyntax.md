# Changing Syntax Nodes

Discover the steps necessary to add, remove, and update syntax nodes

## Overview

The surface area of the entire Swift programming language is represented in the
Swift Syntax API and its associated data structures. In order to keep these
structures in sync, this project generates code using the Swift package 
`CodeGeneration`, located in the root of this repository. 

## Regenerating Files

To re-generate the files after changing `CodeGeneration` run the `generate-swift-syntax` 
target of `CodeGeneration`.

On the command line, this would be
```bash
swift run --package-path CodeGeneration generate-swift-syntax
```

## Adding and Removing Syntax Nodes

The files containing the definition of all of the syntax nodes are available
under the [SyntaxSupport][SyntaxSupport] directory. These files
are roughly divided according to broad syntactic categories in the Swift
programming language. That is, the syntax nodes for classes, structs, and actors
are defined in `DeclNodes.swift`, while the syntax nodes for string literals, 
arrays, and tuples is defined in `ExprNodes.swift`.

To add a node to these files, it can be helpful to copy an existing node and 
alter its definition to suit the needs of the new syntax being defined. A syntax
node consists of a kind (which also defines the node’s name), a base kind, and a list of 
child nodes. The base kind of a syntax node defines the class of syntax the node belongs to. 
All nodes are at least of the `Syntax`
kind, though some nodes may have a more specific kind like `Stmt` for
statements or `Expr` for expressions. The SwiftSyntax library expands these
kinds into protocol conformances and allows for casting strongly typed syntax
nodes among these categories for easier processing.

The node for a source file is reproduced below:

```swift
Node(
  kind: .sourceFile,
  base: .syntax,
  nameForDiagnostics: "source file",
  parserFunction: "parseSourceFile",
  traits: ["WithStatements"],
  children: [
    Child(
      name: "Statements",
      kind: .collection(kind: .codeBlockItemList, collectionElementName: "Statement")
    ),
    Child(
      name: "EndOfFileToken",
      deprecatedName: "EOFToken",
      kind: .token(choices: [.token(tokenKind: "EndOfFileToken")])
    ),
  ]
)
```

## Committing Changes

Added syntactic elements will require corresponding changes to the included 
SwiftParser library. For an introduction on parsing Swift nodes, see 
[the article on Parsing Basics][ParserBasics].

When updating nodes, certain clients of SwiftSyntax that are relying upon those
nodes will need to be changed in tandem. For example, the 
[swift-stress-tester][swift-stress-tester] uses SwiftSyntax, and the CI
system will not allow changes to SwiftSyntax that break `swift-stress-tester`
without a paired change to that repository.

[SyntaxSupport]: https://github.com/apple/swift-syntax/tree/main/CodeGeneration/Sources/SyntaxSupport
[swift-stress-tester]: https://github.com/apple/swift-stress-tester
[ParserBasics]: https://github.com/apple/swift-syntax/tree/main/Sources/SwiftParser/SwiftParser.docc/ParsingBasics.md

@Comment {
  When docc resolves https://github.com/apple/swift-docc/issues/255, `ParserBasic` should be an inter-target link.
}

