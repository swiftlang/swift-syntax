# ``SwiftOperators``



An implementation of Swift's user-defined operator declarations and precedence 
groups, allowing a program to reason about the relative precedence of 
infix operations and transform syntax trees to describe the order of operations.



## Overview

Swift allows developers to define new operators to use in expressions. For example, the infix `+` and `*` operators are defined by the Swift standard library with [operator declarations](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#grammar_operator-declaration) that look like this:

```swift
infix operator +: AdditionPrecedence
infix operator *: MultiplicationPrecedence
```

The associativity and relative precedence of these operators is defined via a [precedence group declaration](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#grammar_precedence-group-declaration). For example, the precedence groups used for `+` and `*` are defined as follows:

```swift
precedencegroup AdditionPrecedence {
  associativity: left
}
precedencegroup MultiplicationPrecedence {
  associativity: left
  higherThan: AdditionPrecedence
}
```

The Swift parser itself does not reason about the semantics of operators or precedence groups. Instead, an expression such as `x + y * z` will be parsed into a `SequenceExprSyntax` node whose children are `x`, a `BinaryOperatorExprSyntax` node for `+`, `y`, a `BinaryOperatorExprSyntax` node for `*`, and `z`. This is all the structure that is possible to parse for a Swift program without semantic information about operators and precedence groups.

The `SwiftOperators` module interprets operator and precedence group declarations to provide those semantics. Its primary operation is to "fold" a `SequenceExprSyntax` node into an equivalent syntax tree that fully expresses the order of operations: in our example case, this means that the resulting syntax node will be an `InfixOperatorExprSyntax` whose left-hand side is `x` and operator is `+`, and whose right-hand side is another `InfixOperatorExprSyntax` node representing `y * z`. The resulting syntax tree will still accurately represent the original source input, but will be completely describe the order of evaluation and be suitable for structured editing or later semantic passes, such as type checking.



## Quickstart

The `SwiftOperators` library is typically used to take a raw parse of Swift code and apply the operator-precedence transformation to it to replace all `SequenceExprSyntax` nodes with more structured syntax nodes. For example, we can use this library's representation of the Swift standard library operators to provide a structured syntax tree for the expression `x + y * z`:

```swift
import SwiftSyntax
import SwiftParser
import SwiftOperators

var opPrecedence = OperatorTable.standardOperators // Use the Swift standard library operators
let parsed = Parser.parse(source: "x + y * z")
dump(parsed) // contains SequenceExprSyntax(x, +, y, *, z)
let folded = try opPrecedence.foldAll(parsed)
dump(folded) // contains InfixOperatorExpr(x, +, InfixOperatorExpr(y, *, z))
```

The <doc:OperatorTable> type maintains the table of known operators and precedence groups, and is the primary way in which one interacts with this library. The standard operators are provided as a static variable of this type, which will work to fold most Swift code, such as in the example above that folds `x + y * z`.

If your Swift code involves operator and precedence group declarations, they can be parsed into another source file and then added to the `OperatorTable` instance using `addSourceFile`:

```swift
let moreOperators = 
  """
  precedencegroup ExponentiationPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
  }

  infix operator **: ExponentiationPrecedence
  """
let parsedOperators = Parser.parse(source: moreOperators)

// Adds **, ExponentiationPrecedence to the set of known operators and precedence groups.
try opPrecedence.addSourceFile(parsedOperators) 

let parsed2 = Parser.parse(source: "b ** c ** d")
dump(parsed2) // contains SequenceExprSyntax(b, **, c, **, d)
let folded2 = try opPrecedence.foldAll(parsed2)
dump(folded2) // contains InfixOperatorExpr(b, **, InfixOperatorExpr(c, **, d))
```

## Error handling

By default, any of the operations that can produce an error, whether folding a sequence or parsing a source file's operators and precedence groups into a table, will throw an instance of <doc:OperatorError>. However, each entry point takes an optional error handler (of type <doc:OperatorErrorHandler>) that will be called with each error that occurs. For example, we can capture errors like this:

```swift
var errors: [OperatorError] = []
let foldedExpr2e = opPrecedence.foldSingle(sequenceExpr2) { error in 
  errors.append(error)
}
```

As indicated by the lack of `try`, the folding operation will continue even in the presence of errors, and produce a structured syntax tree. That structured syntax tree will have had some fallback behavior applied (e.g., bias toward left-associative when operators cannot be compared), but the sequence expression(s) will have been replaced in the resulting tree.

