# ``SwiftParser``

A parser for the Swift programming language.

## Overview

The `SwiftParser` framework implements a parser that accepts Swift source text as input and produces a SwiftSyntax syntax tree. 

## Quickstart

The easiest way to parse Swift source code is to call the `Parser.parse` method, providing it with a string containing the source code:

```swift
import SwiftParser
import SwiftSyntax

let sourceText =
"""
func greeting(name: String) {
  print("Hello, \(name)!")
}
"""

// Parse the source code in sourceText into a syntax tree
let sourceFile: SourceFileSyntax = Parser.parse(source: sourceText)

// The "description" of the source tree is the source-accurate view of what was parsed.
assert(sourceFile.description == sourceText)

// Visualize the complete syntax tree.
dump(sourceFile)
```

## Design principles

There are several design principles that govern the parser:

* **Resilient**: The parser will attempt to recover from syntax errors, maintaining as much of the program structure as is feasible. It has no side effects, and in particular produces no errors regardless of how ill-formed the input source text is. Instead, all errors are described in the syntax tree itself, and can be diagnosed by a separate pass that identifies such errors. These errors come in one of two forms:

* - *Unexpected nodes*: syntax that doesn't match any part of the Swift grammar is kept in an “unexpected” child node, which are placed in the syntax tree and can be queried by clients.
  - *Missing tokens*: syntax that is required by the Swift grammar but isn't present in the source code will be recoded in the resulting tree as "missing" tokens, which the parser will introduce. For example, a missing ')' in a function declaration will be inserted by the parser as a missing token. Such tokens will be skipped when rendering back to the original source code, but can also be used by tools to provide fixes for the source code.

* **Efficient**: The parser should provide similar parsing performance to the existing C++ parser implementation that it seeks to replace.

- **Source-preserving**: SwiftSyntax is designed to maintain all “trivia” (including whitespace, comments, etc.) precisely as it occurs in the source text, so that a syntax tree can be rendered back into text that is byte-for-byte identical to the original source. The parser must maintain this property, regardless of whether the input text was well-formed Swift code.
- **Minimal context**: The parser requires minimal context to parse Swift code, which consists of only those things required to handle a suitable Swift dialect, e.g., whether [regex literals](https://github.com/apple/swift-evolution/blob/main/proposals/0354-regex-literals.md) are supported. The parser can be invoked on any input source code, starting at any major production in the grammar (e.g., full source file, an individual type, an individual expression).
- **Incremental**: A parse tree produced for a source file can be incrementally updated for a new version of that source file, reusing syntax nodes where possible to reduce computation overhead and memory.

### Development

- <doc:SwiftParser/FilingBugReports>
- <doc:SwiftParser/FixingBugs>
