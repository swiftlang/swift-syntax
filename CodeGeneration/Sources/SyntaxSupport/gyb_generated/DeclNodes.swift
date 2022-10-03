//// Automatically Generated From DeclNodes.swift.gyb.
//// Do Not Edit Directly!
//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

public let DECL_NODES: [Node] = [
  Node(name: "TypeInitializerClause",
       nameForDiagnostics: nil,
       kind: "Syntax",
       children: [
         Child(name: "Equal",
               kind: "EqualToken",
               tokenChoices: [
                 "Equal"
               ]),
         Child(name: "Value",
               kind: "Type")
       ]),

  Node(name: "TypealiasDecl",
       nameForDiagnostics: "typealias declaration",
       kind: "Decl",
       traits: [
         "IdentifiedDecl"
       ],
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifiers",
               kind: "ModifierList",
               isOptional: true,
               collectionElementName: "Modifier"),
         Child(name: "TypealiasKeyword",
               kind: "TypealiasToken",
               tokenChoices: [
                 "Typealias"
               ]),
         Child(name: "Identifier",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "GenericParameterClause",
               kind: "GenericParameterClause",
               isOptional: true),
         Child(name: "Initializer",
               kind: "TypeInitializerClause"),
         Child(name: "GenericWhereClause",
               kind: "GenericWhereClause",
               isOptional: true)
       ]),

  Node(name: "AssociatedtypeDecl",
       nameForDiagnostics: "associatedtype declaration",
       kind: "Decl",
       traits: [
         "IdentifiedDecl"
       ],
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifiers",
               kind: "ModifierList",
               isOptional: true,
               collectionElementName: "Modifier"),
         Child(name: "AssociatedtypeKeyword",
               kind: "AssociatedtypeToken",
               tokenChoices: [
                 "Associatedtype"
               ]),
         Child(name: "Identifier",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "InheritanceClause",
               kind: "TypeInheritanceClause",
               isOptional: true),
         Child(name: "Initializer",
               kind: "TypeInitializerClause",
               isOptional: true),
         Child(name: "GenericWhereClause",
               kind: "GenericWhereClause",
               isOptional: true)
       ]),

  Node(name: "FunctionParameterList",
       nameForDiagnostics: "function parameter list",
       kind: "SyntaxCollection",
       element: "FunctionParameter"),

  Node(name: "ParameterClause",
       nameForDiagnostics: "parameter clause",
       kind: "Syntax",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "ParameterList",
               kind: "FunctionParameterList",
               collectionElementName: "Parameter"),
         Child(name: "RightParen",
               kind: "RightParenToken",
               tokenChoices: [
                 "RightParen"
               ])
       ]),

  Node(name: "ReturnClause",
       nameForDiagnostics: nil,
       kind: "Syntax",
       children: [
         Child(name: "Arrow",
               kind: "ArrowToken",
               tokenChoices: [
                 "Arrow"
               ]),
         Child(name: "ReturnType",
               kind: "Type")
       ]),

  Node(name: "FunctionSignature",
       nameForDiagnostics: "function signature",
       kind: "Syntax",
       children: [
         Child(name: "Input",
               kind: "ParameterClause"),
         Child(name: "AsyncOrReasyncKeyword",
               kind: "ContextualKeywordToken",
               isOptional: true,
               tokenChoices: [
                 "ContextualKeyword"
               ],
               textChoices: [
                 "async",
                 "reasync"
               ]),
         Child(name: "ThrowsOrRethrowsKeyword",
               kind: "Token",
               isOptional: true,
               tokenChoices: [
                 "Throws",
                 "Rethrows"
               ]),
         Child(name: "Output",
               kind: "ReturnClause",
               isOptional: true)
       ]),

  Node(name: "IfConfigClause",
       nameForDiagnostics: "conditional compilation clause",
       kind: "Syntax",
       children: [
         Child(name: "PoundKeyword",
               kind: "Token",
               tokenChoices: [
                 "PoundIf",
                 "PoundElseif",
                 "PoundElse"
               ],
               classification: "BuildConfigId"),
         Child(name: "Condition",
               kind: "Expr",
               isOptional: true,
               classification: "BuildConfigId"),
         Child(name: "Elements",
               kind: "Syntax",
               nodeChoices: [
                 Child(name: "Statements",
                       kind: "CodeBlockItemList"),
                 Child(name: "SwitchCases",
                       kind: "SwitchCaseList"),
                 Child(name: "Decls",
                       kind: "MemberDeclList"),
                 Child(name: "PostfixExpression",
                       kind: "Expr")
               ])
       ]),

  Node(name: "IfConfigClauseList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "IfConfigClause"),

  Node(name: "IfConfigDecl",
       nameForDiagnostics: "conditional compilation block",
       kind: "Decl",
       children: [
         Child(name: "Clauses",
               kind: "IfConfigClauseList",
               collectionElementName: "Clause"),
         Child(name: "PoundEndif",
               kind: "PoundEndifToken",
               tokenChoices: [
                 "PoundEndif"
               ],
               classification: "BuildConfigId")
       ]),

  Node(name: "PoundErrorDecl",
       nameForDiagnostics: "'#error' directive",
       kind: "Decl",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "PoundError",
               kind: "PoundErrorToken",
               tokenChoices: [
                 "PoundError"
               ]),
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "Message",
               kind: "StringLiteralExpr"),
         Child(name: "RightParen",
               kind: "RightParenToken",
               tokenChoices: [
                 "RightParen"
               ])
       ]),

  Node(name: "PoundWarningDecl",
       nameForDiagnostics: "'#warning' directive",
       kind: "Decl",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "PoundWarning",
               kind: "PoundWarningToken",
               tokenChoices: [
                 "PoundWarning"
               ]),
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "Message",
               kind: "StringLiteralExpr"),
         Child(name: "RightParen",
               kind: "RightParenToken",
               tokenChoices: [
                 "RightParen"
               ])
       ]),

  Node(name: "PoundSourceLocation",
       nameForDiagnostics: "'#sourceLocation' directive",
       kind: "Decl",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "PoundSourceLocation",
               kind: "PoundSourceLocationToken",
               tokenChoices: [
                 "PoundSourceLocation"
               ]),
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "Args",
               kind: "PoundSourceLocationArgs",
               isOptional: true),
         Child(name: "RightParen",
               kind: "RightParenToken",
               tokenChoices: [
                 "RightParen"
               ])
       ]),

  Node(name: "PoundSourceLocationArgs",
       nameForDiagnostics: "'#sourceLocation' arguments",
       kind: "Syntax",
       children: [
         Child(name: "FileArgLabel",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ],
               textChoices: [
                 "file"
               ]),
         Child(name: "FileArgColon",
               kind: "ColonToken",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "FileName",
               kind: "StringLiteralToken",
               tokenChoices: [
                 "StringLiteral"
               ]),
         Child(name: "Comma",
               kind: "CommaToken",
               tokenChoices: [
                 "Comma"
               ]),
         Child(name: "LineArgLabel",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ],
               textChoices: [
                 "line"
               ]),
         Child(name: "LineArgColon",
               kind: "ColonToken",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "LineNumber",
               kind: "IntegerLiteralToken",
               tokenChoices: [
                 "IntegerLiteral"
               ])
       ]),

  Node(name: "DeclModifierDetail",
       nameForDiagnostics: nil,
       kind: "Syntax",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "Detail",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "RightParen",
               kind: "RightParenToken",
               tokenChoices: [
                 "RightParen"
               ])
       ]),

  Node(name: "DeclModifier",
       nameForDiagnostics: "modifier",
       kind: "Syntax",
       children: [
         Child(name: "Name",
               kind: "Token",
               textChoices: [
                 "class",
                 "convenience",
                 "dynamic",
                 "final",
                 "infix",
                 "lazy",
                 "optional",
                 "override",
                 "postfix",
                 "prefix",
                 "required",
                 "static",
                 "unowned",
                 "weak",
                 "private",
                 "fileprivate",
                 "internal",
                 "public",
                 "open",
                 "mutating",
                 "nonmutating",
                 "indirect",
                 "__consuming",
                 "actor",
                 "async",
                 "distributed",
                 "isolated",
                 "nonisolated",
                 "_const",
                 "_local"
               ],
               classification: "Attribute"),
         Child(name: "Detail",
               kind: "DeclModifierDetail",
               isOptional: true)
       ]),

  Node(name: "InheritedType",
       nameForDiagnostics: "type",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "TypeName",
               kind: "Type"),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "InheritedTypeList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "InheritedType"),

  Node(name: "TypeInheritanceClause",
       nameForDiagnostics: "inheritance clause",
       kind: "Syntax",
       children: [
         Child(name: "Colon",
               kind: "ColonToken",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "InheritedTypeCollection",
               kind: "InheritedTypeList",
               collectionElementName: "InheritedType")
       ]),

  Node(name: "ClassDecl",
       nameForDiagnostics: "class",
       kind: "Decl",
       traits: [
         "DeclGroup",
         "IdentifiedDecl"
       ],
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifiers",
               kind: "ModifierList",
               isOptional: true,
               collectionElementName: "Modifier"),
         Child(name: "ClassKeyword",
               kind: "ClassToken",
               tokenChoices: [
                 "Class"
               ]),
         Child(name: "Identifier",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "GenericParameterClause",
               kind: "GenericParameterClause",
               isOptional: true),
         Child(name: "InheritanceClause",
               kind: "TypeInheritanceClause",
               isOptional: true),
         Child(name: "GenericWhereClause",
               kind: "GenericWhereClause",
               isOptional: true),
         Child(name: "Members",
               kind: "MemberDeclBlock")
       ]),

  Node(name: "ActorDecl",
       nameForDiagnostics: "actor",
       kind: "Decl",
       traits: [
         "DeclGroup",
         "IdentifiedDecl"
       ],
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifiers",
               kind: "ModifierList",
               isOptional: true,
               collectionElementName: "Modifier"),
         Child(name: "ActorKeyword",
               kind: "ContextualKeywordToken",
               tokenChoices: [
                 "ContextualKeyword"
               ],
               textChoices: [
                 "actor"
               ]),
         Child(name: "Identifier",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "GenericParameterClause",
               kind: "GenericParameterClause",
               isOptional: true),
         Child(name: "InheritanceClause",
               kind: "TypeInheritanceClause",
               isOptional: true),
         Child(name: "GenericWhereClause",
               kind: "GenericWhereClause",
               isOptional: true),
         Child(name: "Members",
               kind: "MemberDeclBlock")
       ]),

  Node(name: "StructDecl",
       nameForDiagnostics: "struct",
       kind: "Decl",
       traits: [
         "DeclGroup",
         "IdentifiedDecl"
       ],
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifiers",
               kind: "ModifierList",
               isOptional: true,
               collectionElementName: "Modifier"),
         Child(name: "StructKeyword",
               kind: "StructToken",
               tokenChoices: [
                 "Struct"
               ]),
         Child(name: "Identifier",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "GenericParameterClause",
               kind: "GenericParameterClause",
               isOptional: true),
         Child(name: "InheritanceClause",
               kind: "TypeInheritanceClause",
               isOptional: true),
         Child(name: "GenericWhereClause",
               kind: "GenericWhereClause",
               isOptional: true),
         Child(name: "Members",
               kind: "MemberDeclBlock")
       ]),

  Node(name: "ProtocolDecl",
       nameForDiagnostics: "protocol",
       kind: "Decl",
       traits: [
         "DeclGroup",
         "IdentifiedDecl"
       ],
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifiers",
               kind: "ModifierList",
               isOptional: true,
               collectionElementName: "Modifier"),
         Child(name: "ProtocolKeyword",
               kind: "ProtocolToken",
               tokenChoices: [
                 "Protocol"
               ]),
         Child(name: "Identifier",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "PrimaryAssociatedTypeClause",
               kind: "PrimaryAssociatedTypeClause",
               isOptional: true),
         Child(name: "InheritanceClause",
               kind: "TypeInheritanceClause",
               isOptional: true),
         Child(name: "GenericWhereClause",
               kind: "GenericWhereClause",
               isOptional: true),
         Child(name: "Members",
               kind: "MemberDeclBlock")
       ]),

  Node(name: "ExtensionDecl",
       nameForDiagnostics: "extension",
       kind: "Decl",
       traits: [
         "DeclGroup"
       ],
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifiers",
               kind: "ModifierList",
               isOptional: true,
               collectionElementName: "Modifier"),
         Child(name: "ExtensionKeyword",
               kind: "ExtensionToken",
               tokenChoices: [
                 "Extension"
               ]),
         Child(name: "ExtendedType",
               kind: "Type"),
         Child(name: "InheritanceClause",
               kind: "TypeInheritanceClause",
               isOptional: true),
         Child(name: "GenericWhereClause",
               kind: "GenericWhereClause",
               isOptional: true),
         Child(name: "Members",
               kind: "MemberDeclBlock")
       ]),

  Node(name: "MemberDeclBlock",
       nameForDiagnostics: nil,
       kind: "Syntax",
       traits: [
         "Braced"
       ],
       children: [
         Child(name: "LeftBrace",
               kind: "LeftBraceToken",
               tokenChoices: [
                 "LeftBrace"
               ]),
         Child(name: "Members",
               kind: "MemberDeclList",
               collectionElementName: "Member",
               isIndented: true),
         Child(name: "RightBrace",
               kind: "RightBraceToken",
               tokenChoices: [
                 "RightBrace"
               ],
               requiresLeadingNewline: true)
       ]),

  Node(name: "MemberDeclList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "MemberDeclListItem",
       elementsSeparatedByNewline: true),

  Node(name: "MemberDeclListItem",
       nameForDiagnostics: nil,
       description: "A member declaration of a type consisting of a declaration and anoptional semicolon;",
       kind: "Syntax",
       children: [
         Child(name: "Decl",
               kind: "Decl",
               description: "The declaration of the type member."),
         Child(name: "Semicolon",
               kind: "SemicolonToken",
               description: "An optional trailing semicolon.",
               isOptional: true,
               tokenChoices: [
                 "Semicolon"
               ])
       ],
       omitWhenEmpty: true),

  Node(name: "SourceFile",
       nameForDiagnostics: "source file",
       kind: "Syntax",
       traits: [
         "WithStatements"
       ],
       children: [
         Child(name: "Statements",
               kind: "CodeBlockItemList",
               collectionElementName: "Statement"),
         Child(name: "EOFToken",
               kind: "EOFToken")
       ]),

  Node(name: "InitializerClause",
       nameForDiagnostics: nil,
       kind: "Syntax",
       children: [
         Child(name: "Equal",
               kind: "EqualToken",
               tokenChoices: [
                 "Equal"
               ]),
         Child(name: "Value",
               kind: "Expr")
       ]),

  Node(name: "FunctionParameter",
       nameForDiagnostics: "function parameter",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifiers",
               kind: "ModifierList",
               isOptional: true,
               collectionElementName: "Modifier"),
         Child(name: "FirstName",
               kind: "Token",
               isOptional: true,
               tokenChoices: [
                 "Identifier",
                 "Wildcard"
               ]),
         Child(name: "SecondName",
               kind: "Token",
               isOptional: true,
               tokenChoices: [
                 "Identifier",
                 "Wildcard"
               ]),
         Child(name: "Colon",
               kind: "ColonToken",
               isOptional: true,
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "Type",
               kind: "Type",
               isOptional: true),
         Child(name: "Ellipsis",
               kind: "EllipsisToken",
               isOptional: true,
               tokenChoices: [
                 "Ellipsis"
               ]),
         Child(name: "DefaultArgument",
               kind: "InitializerClause",
               isOptional: true),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "ModifierList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "DeclModifier",
       elementName: "Modifier",
       omitWhenEmpty: true),

  Node(name: "FunctionDecl",
       nameForDiagnostics: "function",
       kind: "Decl",
       traits: [
         "IdentifiedDecl"
       ],
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifiers",
               kind: "ModifierList",
               isOptional: true,
               collectionElementName: "Modifier"),
         Child(name: "FuncKeyword",
               kind: "FuncToken",
               tokenChoices: [
                 "Func"
               ]),
         Child(name: "Identifier",
               kind: "Token",
               tokenChoices: [
                 "Identifier",
                 "UnspacedBinaryOperator",
                 "SpacedBinaryOperator",
                 "PrefixOperator",
                 "PostfixOperator"
               ]),
         Child(name: "GenericParameterClause",
               kind: "GenericParameterClause",
               isOptional: true),
         Child(name: "Signature",
               kind: "FunctionSignature"),
         Child(name: "GenericWhereClause",
               kind: "GenericWhereClause",
               isOptional: true),
         Child(name: "Body",
               kind: "CodeBlock",
               isOptional: true)
       ]),

  Node(name: "InitializerDecl",
       nameForDiagnostics: "initializer",
       kind: "Decl",
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifiers",
               kind: "ModifierList",
               isOptional: true,
               collectionElementName: "Modifier"),
         Child(name: "InitKeyword",
               kind: "InitToken",
               tokenChoices: [
                 "Init"
               ]),
         Child(name: "OptionalMark",
               kind: "Token",
               isOptional: true,
               tokenChoices: [
                 "PostfixQuestionMark",
                 "InfixQuestionMark",
                 "ExclamationMark"
               ]),
         Child(name: "GenericParameterClause",
               kind: "GenericParameterClause",
               isOptional: true),
         Child(name: "Signature",
               kind: "FunctionSignature"),
         Child(name: "GenericWhereClause",
               kind: "GenericWhereClause",
               isOptional: true),
         Child(name: "Body",
               kind: "CodeBlock",
               isOptional: true)
       ]),

  Node(name: "DeinitializerDecl",
       nameForDiagnostics: "deinitializer",
       kind: "Decl",
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifiers",
               kind: "ModifierList",
               isOptional: true,
               collectionElementName: "Modifier"),
         Child(name: "DeinitKeyword",
               kind: "DeinitToken",
               tokenChoices: [
                 "Deinit"
               ]),
         Child(name: "Body",
               kind: "CodeBlock",
               isOptional: true)
       ]),

  Node(name: "SubscriptDecl",
       nameForDiagnostics: "subscript",
       kind: "Decl",
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifiers",
               kind: "ModifierList",
               isOptional: true,
               collectionElementName: "Modifier"),
         Child(name: "SubscriptKeyword",
               kind: "SubscriptToken",
               tokenChoices: [
                 "Subscript"
               ]),
         Child(name: "GenericParameterClause",
               kind: "GenericParameterClause",
               isOptional: true),
         Child(name: "Indices",
               kind: "ParameterClause"),
         Child(name: "Result",
               kind: "ReturnClause"),
         Child(name: "GenericWhereClause",
               kind: "GenericWhereClause",
               isOptional: true),
         Child(name: "Accessor",
               kind: "Syntax",
               isOptional: true,
               nodeChoices: [
                 Child(name: "Accessors",
                       kind: "AccessorBlock"),
                 Child(name: "Getter",
                       kind: "CodeBlock")
               ])
       ]),

  Node(name: "AccessLevelModifier",
       nameForDiagnostics: "access level modifier",
       kind: "Syntax",
       children: [
         Child(name: "Name",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "Modifier",
               kind: "DeclModifierDetail",
               isOptional: true)
       ]),

  Node(name: "AccessPathComponent",
       nameForDiagnostics: nil,
       kind: "Syntax",
       children: [
         Child(name: "Name",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "TrailingDot",
               kind: "PeriodToken",
               isOptional: true,
               tokenChoices: [
                 "Period"
               ])
       ]),

  Node(name: "AccessPath",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "AccessPathComponent"),

  Node(name: "ImportDecl",
       nameForDiagnostics: "import",
       kind: "Decl",
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifiers",
               kind: "ModifierList",
               isOptional: true,
               collectionElementName: "Modifier"),
         Child(name: "ImportTok",
               kind: "ImportToken",
               tokenChoices: [
                 "Import"
               ]),
         Child(name: "ImportKind",
               kind: "Token",
               isOptional: true,
               tokenChoices: [
                 "Typealias",
                 "Struct",
                 "Class",
                 "Enum",
                 "Protocol",
                 "Var",
                 "Let",
                 "Func"
               ]),
         Child(name: "Path",
               kind: "AccessPath",
               collectionElementName: "PathComponent")
       ]),

  Node(name: "AccessorParameter",
       nameForDiagnostics: nil,
       kind: "Syntax",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "Name",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "RightParen",
               kind: "RightParenToken",
               tokenChoices: [
                 "RightParen"
               ])
       ]),

  Node(name: "AccessorDecl",
       nameForDiagnostics: "accessor",
       kind: "Decl",
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifier",
               kind: "DeclModifier",
               isOptional: true),
         Child(name: "AccessorKind",
               kind: "Token",
               textChoices: [
                 "get",
                 "set",
                 "didSet",
                 "willSet",
                 "unsafeAddress",
                 "addressWithOwner",
                 "addressWithNativeOwner",
                 "unsafeMutableAddress",
                 "mutableAddressWithOwner",
                 "mutableAddressWithNativeOwner",
                 "_read",
                 "_modify"
               ]),
         Child(name: "Parameter",
               kind: "AccessorParameter",
               isOptional: true),
         Child(name: "AsyncKeyword",
               kind: "ContextualKeywordToken",
               isOptional: true,
               tokenChoices: [
                 "ContextualKeyword"
               ],
               textChoices: [
                 "async"
               ]),
         Child(name: "ThrowsKeyword",
               kind: "Token",
               isOptional: true,
               tokenChoices: [
                 "Throws",
                 "Rethrows"
               ]),
         Child(name: "Body",
               kind: "CodeBlock",
               isOptional: true)
       ]),

  Node(name: "AccessorList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "AccessorDecl"),

  Node(name: "AccessorBlock",
       nameForDiagnostics: nil,
       kind: "Syntax",
       traits: [
         "Braced"
       ],
       children: [
         Child(name: "LeftBrace",
               kind: "LeftBraceToken",
               tokenChoices: [
                 "LeftBrace"
               ]),
         Child(name: "Accessors",
               kind: "AccessorList",
               collectionElementName: "Accessor"),
         Child(name: "RightBrace",
               kind: "RightBraceToken",
               tokenChoices: [
                 "RightBrace"
               ])
       ]),

  Node(name: "PatternBinding",
       nameForDiagnostics: nil,
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Pattern",
               kind: "Pattern"),
         Child(name: "TypeAnnotation",
               kind: "TypeAnnotation",
               isOptional: true),
         Child(name: "Initializer",
               kind: "InitializerClause",
               isOptional: true),
         Child(name: "Accessor",
               kind: "Syntax",
               isOptional: true,
               nodeChoices: [
                 Child(name: "Accessors",
                       kind: "AccessorBlock"),
                 Child(name: "Getter",
                       kind: "CodeBlock")
               ]),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "PatternBindingList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "PatternBinding"),

  Node(name: "VariableDecl",
       nameForDiagnostics: "variable",
       kind: "Decl",
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifiers",
               kind: "ModifierList",
               isOptional: true,
               collectionElementName: "Modifier"),
         Child(name: "LetOrVarKeyword",
               kind: "Token",
               tokenChoices: [
                 "Let",
                 "Var"
               ]),
         Child(name: "Bindings",
               kind: "PatternBindingList",
               collectionElementName: "Binding")
       ]),

  Node(name: "EnumCaseElement",
       nameForDiagnostics: nil,
       description: "An element of an enum case, containing the name of the case and,optionally, either associated values or an assignment to a raw value.",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Identifier",
               kind: "IdentifierToken",
               description: "The name of this case.",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "AssociatedValue",
               kind: "ParameterClause",
               description: "The set of associated values of the case.",
               isOptional: true),
         Child(name: "RawValue",
               kind: "InitializerClause",
               description: "The raw value of this enum element, if present.",
               isOptional: true),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               description: "The trailing comma of this element, if the case hasmultiple elements.",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "EnumCaseElementList",
       nameForDiagnostics: nil,
       description: "A collection of 0 or more `EnumCaseElement`s.",
       kind: "SyntaxCollection",
       element: "EnumCaseElement"),

  Node(name: "EnumCaseDecl",
       nameForDiagnostics: "enum case",
       description: "A `case` declaration of a Swift `enum`. It can have 1 or more`EnumCaseElement`s inside, each declaring a different case of theenum.",
       kind: "Decl",
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               description: "The attributes applied to the case declaration.",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifiers",
               kind: "ModifierList",
               description: "The declaration modifiers applied to the case declaration.",
               isOptional: true,
               collectionElementName: "Modifier"),
         Child(name: "CaseKeyword",
               kind: "CaseToken",
               description: "The `case` keyword for this case.",
               tokenChoices: [
                 "Case"
               ]),
         Child(name: "Elements",
               kind: "EnumCaseElementList",
               description: "The elements this case declares.",
               collectionElementName: "Element")
       ]),

  Node(name: "EnumDecl",
       nameForDiagnostics: "enum",
       description: "A Swift `enum` declaration.",
       kind: "Decl",
       traits: [
         "IdentifiedDecl"
       ],
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               description: "The attributes applied to the enum declaration.",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifiers",
               kind: "ModifierList",
               description: "The declaration modifiers applied to the enum declaration.",
               isOptional: true,
               collectionElementName: "Modifier"),
         Child(name: "EnumKeyword",
               kind: "EnumToken",
               description: "The `enum` keyword for this declaration.",
               tokenChoices: [
                 "Enum"
               ]),
         Child(name: "Identifier",
               kind: "IdentifierToken",
               description: "The name of this enum.",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "GenericParameters",
               kind: "GenericParameterClause",
               description: "The generic parameters, if any, for this enum.",
               isOptional: true),
         Child(name: "InheritanceClause",
               kind: "TypeInheritanceClause",
               description: "The inheritance clause describing conformances or rawvalues for this enum.",
               isOptional: true),
         Child(name: "GenericWhereClause",
               kind: "GenericWhereClause",
               description: "The `where` clause that applies to the generic parameters ofthis enum.",
               isOptional: true),
         Child(name: "Members",
               kind: "MemberDeclBlock",
               description: "The cases and other members of this enum.")
       ]),

  Node(name: "OperatorDecl",
       nameForDiagnostics: "operator",
       description: "A Swift `operator` declaration.",
       kind: "Decl",
       traits: [
         "IdentifiedDecl"
       ],
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               description: "The attributes applied to the 'operator' declaration.",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifiers",
               kind: "ModifierList",
               description: "The declaration modifiers applied to the 'operator'declaration.",
               isOptional: true,
               collectionElementName: "Modifier",
               classification: "Attribute"),
         Child(name: "OperatorKeyword",
               kind: "OperatorToken",
               tokenChoices: [
                 "Operator"
               ]),
         Child(name: "Identifier",
               kind: "Token",
               tokenChoices: [
                 "UnspacedBinaryOperator",
                 "SpacedBinaryOperator",
                 "PrefixOperator",
                 "PostfixOperator"
               ]),
         Child(name: "OperatorPrecedenceAndTypes",
               kind: "OperatorPrecedenceAndTypes",
               description: "Optionally specify a precedence group and designated types.",
               isOptional: true)
       ]),

  Node(name: "DesignatedTypeList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "DesignatedTypeElement"),

  Node(name: "DesignatedTypeElement",
       nameForDiagnostics: nil,
       kind: "Syntax",
       children: [
         Child(name: "LeadingComma",
               kind: "CommaToken",
               tokenChoices: [
                 "Comma"
               ]),
         Child(name: "Name",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ])
       ]),

  Node(name: "OperatorPrecedenceAndTypes",
       nameForDiagnostics: nil,
       description: "A clause to specify precedence group in infix operator declarations, and designated types in any operator declaration.",
       kind: "Syntax",
       children: [
         Child(name: "Colon",
               kind: "ColonToken",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "PrecedenceGroup",
               kind: "IdentifierToken",
               description: "The precedence group for this operator",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "DesignatedTypes",
               kind: "DesignatedTypeList",
               description: "The designated types associated with this operator.",
               collectionElementName: "DesignatedTypeElement")
       ]),

  Node(name: "PrecedenceGroupDecl",
       nameForDiagnostics: "precedencegroup",
       description: "A Swift `precedencegroup` declaration.",
       kind: "Decl",
       traits: [
         "IdentifiedDecl"
       ],
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               description: "The attributes applied to the 'precedencegroup' declaration.",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifiers",
               kind: "ModifierList",
               description: "The declaration modifiers applied to the 'precedencegroup'declaration.",
               isOptional: true,
               collectionElementName: "Modifier"),
         Child(name: "PrecedencegroupKeyword",
               kind: "PrecedencegroupToken",
               tokenChoices: [
                 "Precedencegroup"
               ]),
         Child(name: "Identifier",
               kind: "IdentifierToken",
               description: "The name of this precedence group.",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "LeftBrace",
               kind: "LeftBraceToken",
               tokenChoices: [
                 "LeftBrace"
               ]),
         Child(name: "GroupAttributes",
               kind: "PrecedenceGroupAttributeList",
               description: "The characteristics of this precedence group.",
               collectionElementName: "GroupAttribute"),
         Child(name: "RightBrace",
               kind: "RightBraceToken",
               tokenChoices: [
                 "RightBrace"
               ])
       ]),

  Node(name: "PrecedenceGroupAttributeList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "Syntax",
       elementName: "PrecedenceGroupAttribute",
       elementChoices: ["PrecedenceGroupRelation", "PrecedenceGroupAssignment", "PrecedenceGroupAssociativity"]),

  Node(name: "PrecedenceGroupRelation",
       nameForDiagnostics: "'relation' property of precedencegroup",
       description: "Specify the new precedence group's relation to existing precedencegroups.",
       kind: "Syntax",
       children: [
         Child(name: "HigherThanOrLowerThan",
               kind: "IdentifierToken",
               description: "The relation to specified other precedence groups.",
               tokenChoices: [
                 "Identifier"
               ],
               textChoices: [
                 "higherThan",
                 "lowerThan"
               ],
               classification: "Keyword"),
         Child(name: "Colon",
               kind: "ColonToken",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "OtherNames",
               kind: "PrecedenceGroupNameList",
               description: "The name of other precedence group to which this precedencegroup relates.",
               collectionElementName: "OtherName")
       ]),

  Node(name: "PrecedenceGroupNameList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "PrecedenceGroupNameElement"),

  Node(name: "PrecedenceGroupNameElement",
       nameForDiagnostics: nil,
       kind: "Syntax",
       children: [
         Child(name: "Name",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "PrecedenceGroupAssignment",
       nameForDiagnostics: "'assignment' property of precedencegroup",
       description: "Specifies the precedence of an operator when used in an operationthat includes optional chaining.",
       kind: "Syntax",
       children: [
         Child(name: "AssignmentKeyword",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ],
               textChoices: [
                 "assignment"
               ]),
         Child(name: "Colon",
               kind: "ColonToken",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "Flag",
               kind: "Token",
               description: "When true, an operator in the corresponding precedence groupuses the same grouping rules during optional chaining as theassignment operators from the standard library. Otherwise,operators in the precedence group follows the same optionalchaining rules as operators that don't perform assignment.",
               tokenChoices: [
                 "True",
                 "False"
               ])
       ]),

  Node(name: "PrecedenceGroupAssociativity",
       nameForDiagnostics: "'associativity' property of precedencegroup",
       description: "Specifies how a sequence of operators with the same precedence levelare grouped together in the absence of grouping parentheses.",
       kind: "Syntax",
       children: [
         Child(name: "AssociativityKeyword",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ],
               textChoices: [
                 "associativity"
               ],
               classification: "Keyword"),
         Child(name: "Colon",
               kind: "ColonToken",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "Value",
               kind: "IdentifierToken",
               description: "Operators that are `left`-associative group left-to-right.Operators that are `right`-associative group right-to-left.Operators that are specified with an associativity of `none`don't associate at all",
               tokenChoices: [
                 "Identifier"
               ],
               textChoices: [
                 "left",
                 "right",
                 "none"
               ])
       ]),

]
