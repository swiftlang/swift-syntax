# Glossary

Glossary of terms and abbreviations used in SwiftSyntax

## Abbreviations and Terms

To avoid ongoing repetition of common long terms, SwiftSyntax uses a couple of abbreviations that are common in compiler projects.


**Arena** See ``SyntaxArena``

**Decl** Abbreviation for *Declaration*

**Expr** Abbreviation for *Expression*

**IfConfig** Abbrevation for *If Configuration*. Refers to `#if` clauses in the source code.

**Layout Node** A layout node can have an arbitrary number of children and provides structure to the syntax tree. All ``Syntax`` nodes that aren’t ``TokenSyntax`` are layout nodes. For example a ``StructDeclSyntax`` consists of, among others, of the `struct` keyword, the name and the `memberBlock`. The latter is again a layout node that contains multiple children. Layout nodes never represent any source code in the syntax tree by themselves. All source code within the syntax tree is represented by *tokens*.

**Node** A *layout node* or *token*

**RawSyntax** The underlying storage of syntax nodes. These are manually memory managed inside an *arena*. You should not need to interact with them unless contributing to swift-syntax.

**Stmt** Abbreviation for *Statement*

**Token** See ``TokenSyntax``

**Trivia** See ``Trivia``

<!-- IMPORTANT: Please keep the list above alphabetically ordered instead of adding new entries at the bottom -->
