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

let DECL_NODES: [Node] = [
  Node(name: "TypeInitializerClause",
       kind: "Syntax",
       children: [
         Child(name: "Equal",
               kind: "EqualToken"),
         Child(name: "Value",
               kind: "Type")
       ]),

  Node(name: "TypealiasDecl",
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
               kind: "TypealiasToken"),
         Child(name: "Identifier",
               kind: "IdentifierToken"),
         Child(name: "GenericParameterClause",
               kind: "GenericParameterClause",
               isOptional: true),
         Child(name: "Initializer",
               kind: "TypeInitializerClause",
               isOptional: true),
         Child(name: "GenericWhereClause",
               kind: "GenericWhereClause",
               isOptional: true)
       ]),

  Node(name: "AssociatedtypeDecl",
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
               kind: "AssociatedtypeToken"),
         Child(name: "Identifier",
               kind: "IdentifierToken"),
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
       kind: "SyntaxCollection",
       element: "FunctionParameter"),

  Node(name: "ParameterClause",
       kind: "Syntax",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "LeftParen",
               kind: "LeftParenToken"),
         Child(name: "ParameterList",
               kind: "FunctionParameterList",
               collectionElementName: "Parameter"),
         Child(name: "RightParen",
               kind: "RightParenToken")
       ]),

  Node(name: "ReturnClause",
       kind: "Syntax",
       children: [
         Child(name: "Arrow",
               kind: "ArrowToken"),
         Child(name: "ReturnType",
               kind: "Type")
       ]),

  Node(name: "FunctionSignature",
       kind: "Syntax",
       children: [
         Child(name: "Input",
               kind: "ParameterClause"),
         Child(name: "AsyncOrReasyncKeyword",
               kind: "ContextualKeywordToken",
               isOptional: true,
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
       kind: "SyntaxCollection",
       element: "IfConfigClause"),

  Node(name: "IfConfigDecl",
       kind: "Decl",
       children: [
         Child(name: "Clauses",
               kind: "IfConfigClauseList",
               collectionElementName: "Clause"),
         Child(name: "PoundEndif",
               kind: "PoundEndifToken",
               classification: "BuildConfigId")
       ]),

  Node(name: "PoundErrorDecl",
       kind: "Decl",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "PoundError",
               kind: "PoundErrorToken"),
         Child(name: "LeftParen",
               kind: "LeftParenToken"),
         Child(name: "Message",
               kind: "StringLiteralExpr"),
         Child(name: "RightParen",
               kind: "RightParenToken")
       ]),

  Node(name: "PoundWarningDecl",
       kind: "Decl",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "PoundWarning",
               kind: "PoundWarningToken"),
         Child(name: "LeftParen",
               kind: "LeftParenToken"),
         Child(name: "Message",
               kind: "StringLiteralExpr"),
         Child(name: "RightParen",
               kind: "RightParenToken")
       ]),

  Node(name: "PoundSourceLocation",
       kind: "Decl",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "PoundSourceLocation",
               kind: "PoundSourceLocationToken"),
         Child(name: "LeftParen",
               kind: "LeftParenToken"),
         Child(name: "Args",
               kind: "PoundSourceLocationArgs",
               isOptional: true),
         Child(name: "RightParen",
               kind: "RightParenToken")
       ]),

  Node(name: "PoundSourceLocationArgs",
       kind: "Syntax",
       children: [
         Child(name: "FileArgLabel",
               kind: "IdentifierToken",
               textChoices: [
                 "file"
               ]),
         Child(name: "FileArgColon",
               kind: "ColonToken"),
         Child(name: "FileName",
               kind: "StringLiteralToken"),
         Child(name: "Comma",
               kind: "CommaToken"),
         Child(name: "LineArgLabel",
               kind: "IdentifierToken",
               textChoices: [
                 "line"
               ]),
         Child(name: "LineArgColon",
               kind: "ColonToken"),
         Child(name: "LineNumber",
               kind: "IntegerLiteralToken")
       ]),

  Node(name: "DeclModifier",
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
                 "distributed"
               ],
               classification: "Attribute"),
         Child(name: "DetailLeftParen",
               kind: "LeftParenToken",
               isOptional: true),
         Child(name: "Detail",
               kind: "IdentifierToken",
               isOptional: true),
         Child(name: "DetailRightParen",
               kind: "RightParenToken",
               isOptional: true)
       ]),

  Node(name: "InheritedType",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "TypeName",
               kind: "Type"),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true)
       ]),

  Node(name: "InheritedTypeList",
       kind: "SyntaxCollection",
       element: "InheritedType"),

  Node(name: "TypeInheritanceClause",
       kind: "Syntax",
       children: [
         Child(name: "Colon",
               kind: "ColonToken"),
         Child(name: "InheritedTypeCollection",
               kind: "InheritedTypeList",
               collectionElementName: "InheritedType")
       ]),

  Node(name: "ClassDecl",
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
         Child(name: "ClassOrActorKeyword",
               kind: "Token",
               tokenChoices: [
                 "Class",
                 "ContextualKeyword"
               ]),
         Child(name: "Identifier",
               kind: "IdentifierToken"),
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
               kind: "StructToken"),
         Child(name: "Identifier",
               kind: "IdentifierToken"),
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
               kind: "ProtocolToken"),
         Child(name: "Identifier",
               kind: "IdentifierToken"),
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
               kind: "ExtensionToken"),
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
       kind: "Syntax",
       traits: [
         "Braced"
       ],
       children: [
         Child(name: "LeftBrace",
               kind: "LeftBraceToken"),
         Child(name: "Members",
               kind: "MemberDeclList",
               collectionElementName: "Member",
               isIndented: true),
         Child(name: "RightBrace",
               kind: "RightBraceToken",
               requiresLeadingNewline: true)
       ]),

  Node(name: "MemberDeclList",
       kind: "SyntaxCollection",
       element: "MemberDeclListItem",
       elementsSeparatedByNewline: true),

  Node(name: "MemberDeclListItem",
       description: "A member declaration of a type consisting of a declaration and anoptional semicolon;",
       kind: "Syntax",
       children: [
         Child(name: "Decl",
               kind: "Decl",
               description: "The declaration of the type member."),
         Child(name: "Semicolon",
               kind: "SemicolonToken",
               description: "An optional trailing semicolon.",
               isOptional: true)
       ],
       omitWhenEmpty: true),

  Node(name: "SourceFile",
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
       kind: "Syntax",
       children: [
         Child(name: "Equal",
               kind: "EqualToken"),
         Child(name: "Value",
               kind: "Expr")
       ]),

  Node(name: "FunctionParameter",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
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
               isOptional: true),
         Child(name: "Type",
               kind: "Type",
               isOptional: true),
         Child(name: "Ellipsis",
               kind: "EllipsisToken",
               isOptional: true),
         Child(name: "DefaultArgument",
               kind: "InitializerClause",
               isOptional: true),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true)
       ]),

  Node(name: "ModifierList",
       kind: "SyntaxCollection",
       element: "DeclModifier",
       elementName: "Modifier",
       omitWhenEmpty: true),

  Node(name: "FunctionDecl",
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
               kind: "FuncToken"),
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
               kind: "InitToken"),
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
         Child(name: "Parameters",
               kind: "ParameterClause"),
         Child(name: "ThrowsOrRethrowsKeyword",
               kind: "Token",
               isOptional: true,
               tokenChoices: [
                 "Throws",
                 "Rethrows"
               ]),
         Child(name: "GenericWhereClause",
               kind: "GenericWhereClause",
               isOptional: true),
         Child(name: "Body",
               kind: "CodeBlock",
               isOptional: true)
       ]),

  Node(name: "DeinitializerDecl",
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
               kind: "DeinitToken"),
         Child(name: "Body",
               kind: "CodeBlock")
       ]),

  Node(name: "SubscriptDecl",
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
               kind: "SubscriptToken"),
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
       kind: "Syntax",
       children: [
         Child(name: "Name",
               kind: "IdentifierToken"),
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               isOptional: true),
         Child(name: "Modifier",
               kind: "IdentifierToken",
               isOptional: true),
         Child(name: "RightParen",
               kind: "RightParenToken",
               isOptional: true)
       ]),

  Node(name: "AccessPathComponent",
       kind: "Syntax",
       children: [
         Child(name: "Name",
               kind: "IdentifierToken"),
         Child(name: "TrailingDot",
               kind: "PeriodToken",
               isOptional: true)
       ]),

  Node(name: "AccessPath",
       kind: "SyntaxCollection",
       element: "AccessPathComponent"),

  Node(name: "ImportDecl",
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
               kind: "ImportToken"),
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
       kind: "Syntax",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "LeftParen",
               kind: "LeftParenToken"),
         Child(name: "Name",
               kind: "IdentifierToken"),
         Child(name: "RightParen",
               kind: "RightParenToken")
       ]),

  Node(name: "AccessorDecl",
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
       kind: "SyntaxCollection",
       element: "AccessorDecl"),

  Node(name: "AccessorBlock",
       kind: "Syntax",
       traits: [
         "Braced"
       ],
       children: [
         Child(name: "LeftBrace",
               kind: "LeftBraceToken"),
         Child(name: "Accessors",
               kind: "AccessorList",
               collectionElementName: "Accessor"),
         Child(name: "RightBrace",
               kind: "RightBraceToken")
       ]),

  Node(name: "PatternBinding",
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
               isOptional: true)
       ]),

  Node(name: "PatternBindingList",
       kind: "SyntaxCollection",
       element: "PatternBinding"),

  Node(name: "VariableDecl",
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
       description: "An element of an enum case, containing the name of the case and,optionally, either associated values or an assignment to a raw value.",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Identifier",
               kind: "IdentifierToken",
               description: "The name of this case."),
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
               isOptional: true)
       ]),

  Node(name: "EnumCaseElementList",
       description: "A collection of 0 or more `EnumCaseElement`s.",
       kind: "SyntaxCollection",
       element: "EnumCaseElement"),

  Node(name: "EnumCaseDecl",
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
               description: "The `case` keyword for this case."),
         Child(name: "Elements",
               kind: "EnumCaseElementList",
               description: "The elements this case declares.",
               collectionElementName: "Element")
       ]),

  Node(name: "EnumDecl",
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
               description: "The `enum` keyword for this declaration."),
         Child(name: "Identifier",
               kind: "IdentifierToken",
               description: "The name of this enum."),
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
               kind: "OperatorToken"),
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

  Node(name: "IdentifierList",
       kind: "SyntaxCollection",
       element: "IdentifierToken"),

  Node(name: "OperatorPrecedenceAndTypes",
       description: "A clause to specify precedence group in infix operator declarations, and designated types in any operator declaration.",
       kind: "Syntax",
       children: [
         Child(name: "Colon",
               kind: "ColonToken"),
         Child(name: "PrecedenceGroupAndDesignatedTypes",
               kind: "IdentifierList",
               description: "The precedence group and designated types for this operator",
               collectionElementName: "PrecedenceGroupAndDesignatedType")
       ]),

  Node(name: "PrecedenceGroupDecl",
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
               kind: "PrecedencegroupToken"),
         Child(name: "Identifier",
               kind: "IdentifierToken",
               description: "The name of this precedence group."),
         Child(name: "LeftBrace",
               kind: "LeftBraceToken"),
         Child(name: "GroupAttributes",
               kind: "PrecedenceGroupAttributeList",
               description: "The characteristics of this precedence group.",
               collectionElementName: "GroupAttribute"),
         Child(name: "RightBrace",
               kind: "RightBraceToken")
       ]),

  Node(name: "PrecedenceGroupAttributeList",
       kind: "SyntaxCollection",
       element: "Syntax",
       elementName: "PrecedenceGroupAttribute",
       elementChoices: ["PrecedenceGroupRelation", "PrecedenceGroupAssignment", "PrecedenceGroupAssociativity"]),

  Node(name: "PrecedenceGroupRelation",
       description: "Specify the new precedence group's relation to existing precedencegroups.",
       kind: "Syntax",
       children: [
         Child(name: "HigherThanOrLowerThan",
               kind: "IdentifierToken",
               description: "The relation to specified other precedence groups.",
               textChoices: [
                 "higherThan",
                 "lowerThan"
               ],
               classification: "Keyword"),
         Child(name: "Colon",
               kind: "ColonToken"),
         Child(name: "OtherNames",
               kind: "PrecedenceGroupNameList",
               description: "The name of other precedence group to which this precedencegroup relates.",
               collectionElementName: "OtherName")
       ]),

  Node(name: "PrecedenceGroupNameList",
       kind: "SyntaxCollection",
       element: "PrecedenceGroupNameElement"),

  Node(name: "PrecedenceGroupNameElement",
       kind: "Syntax",
       children: [
         Child(name: "Name",
               kind: "IdentifierToken"),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true)
       ]),

  Node(name: "PrecedenceGroupAssignment",
       description: "Specifies the precedence of an operator when used in an operationthat includes optional chaining.",
       kind: "Syntax",
       children: [
         Child(name: "AssignmentKeyword",
               kind: "IdentifierToken",
               textChoices: [
                 "assignment"
               ]),
         Child(name: "Colon",
               kind: "ColonToken"),
         Child(name: "Flag",
               kind: "Token",
               description: "When true, an operator in the corresponding precedence groupuses the same grouping rules during optional chaining as theassignment operators from the standard library. Otherwise,operators in the precedence group follows the same optionalchaining rules as operators that don't perform assignment.",
               tokenChoices: [
                 "True",
                 "False"
               ])
       ]),

  Node(name: "PrecedenceGroupAssociativity",
       description: "Specifies how a sequence of operators with the same precedence levelare grouped together in the absence of grouping parentheses.",
       kind: "Syntax",
       children: [
         Child(name: "AssociativityKeyword",
               kind: "IdentifierToken",
               textChoices: [
                 "associativity"
               ],
               classification: "Keyword"),
         Child(name: "Colon",
               kind: "ColonToken"),
         Child(name: "Value",
               kind: "IdentifierToken",
               description: "Operators that are `left`-associative group left-to-right.Operators that are `right`-associative group right-to-left.Operators that are specified with an associativity of `none`don't associate at all",
               textChoices: [
                 "left",
                 "right",
                 "none"
               ])
       ]),

]
