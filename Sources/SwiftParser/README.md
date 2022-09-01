## Overview

The `SwiftParser` framework implements a parser that accepts Swift source text
as input and produces a SwiftSyntax syntax tree. This module is under active development and is not yet ready to completely replace `SwiftSyntaxParser`. For more information about the design of this module, please see [the module documentation](SwiftParser.docc/SwiftParser.md).

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

## Implementation Status

There are a number of implementation tasks involved in realizing the parser, which include:

* [ ] Parsing
  * [x] Rough parse of full grammar
  * [x] Recovery from unexpected syntax
  * [x] Insert missing syntax where needed
  * [ ] SIL syntax
  * [ ] [Regular expression literals](https://github.com/apple/swift-experimental-string-processing)
  * [x] Parse into raw syntax nodes
* [ ] Diagnostics
  * [ ] Render diagnostics to a terminal with color, highlights, etc.
  * [ ] Fix-Its to add/remove/replace syntax
  * [ ] Emit diagnostics in the same binary format that the Swift compiler/driver do
  * [x] Syntax visitor to emit diagnostics for all missing and unexpected syntax
* [ ] Tooling and automation
  * [ ] Improve test harness to easily check the expected parse trees + diagnostics
  * [ ] Migrate [attribute definitions](https://github.com/apple/swift/blob/main/include/swift/AST/Attr.def) from C++ to Swift
  * [x] Migrate [grammar definition](https://github.com/apple/swift/tree/main/utils/gyb_syntax_support) to the swift-syntax repository
  * [ ] Migrate grammar definition from Python to Swift
  * [ ] Replace uses of gyb with SwiftSyntax-based generation
* [ ] Auditing the grammar to ensure that it accurately represents the Swift grammar
  * [ ] Attributes
  * [ ] Declarations
  * [ ] Statements
  * [ ] Expressions
* [ ] AST generation within the Swift compiler itself

### Testing methodology

We'll employ a number of different techniques to help test the new parser at each phase, including:

* [x] Unit tests for specific parser behaviors, added as we implement pieces and uncover bugs.

* [ ] Self-parse test to ensure that all Swift files in the package can be parsed, that the syntax tree is well-formed, and that it always reproduces the input source.

* [ ] Parsing tests from the Swift compiler repository to check that the parsers accept the same code.

* [ ] Fuzzing tests that ensure that the parser does not crash, and always reproduces the input source.
