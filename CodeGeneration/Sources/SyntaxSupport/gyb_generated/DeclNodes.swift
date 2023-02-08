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
               kind: .token(choices: [.token(tokenKind: "EqualToken")])),
         Child(name: "Value",
               kind: .node(kind: "Type"),
               nameForDiagnostics: "type")
       ]),

  Node(name: "TypealiasDecl",
       nameForDiagnostics: "typealias declaration",
       kind: "Decl",
       traits: [
         "IdentifiedDecl",
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               nameForDiagnostics: "attributes",
               isOptional: true),
         Child(name: "Modifiers",
               kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
               nameForDiagnostics: "modifiers",
               isOptional: true),
         Child(name: "TypealiasKeyword",
               kind: .token(choices: [.keyword(text: "typealias")])),
         Child(name: "Identifier",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")])),
         Child(name: "GenericParameterClause",
               kind: .node(kind: "GenericParameterClause"),
               nameForDiagnostics: "generic parameter clause",
               isOptional: true),
         Child(name: "Initializer",
               kind: .node(kind: "TypeInitializerClause")),
         Child(name: "GenericWhereClause",
               kind: .node(kind: "GenericWhereClause"),
               nameForDiagnostics: "generic where clause",
               isOptional: true)
       ]),

  Node(name: "AssociatedtypeDecl",
       nameForDiagnostics: "associatedtype declaration",
       kind: "Decl",
       traits: [
         "IdentifiedDecl",
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               nameForDiagnostics: "attributes",
               isOptional: true),
         Child(name: "Modifiers",
               kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
               nameForDiagnostics: "modifiers",
               isOptional: true),
         Child(name: "AssociatedtypeKeyword",
               kind: .token(choices: [.keyword(text: "associatedtype")])),
         Child(name: "Identifier",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")])),
         Child(name: "InheritanceClause",
               kind: .node(kind: "TypeInheritanceClause"),
               nameForDiagnostics: "inheritance clause",
               isOptional: true),
         Child(name: "Initializer",
               kind: .node(kind: "TypeInitializerClause"),
               isOptional: true),
         Child(name: "GenericWhereClause",
               kind: .node(kind: "GenericWhereClause"),
               nameForDiagnostics: "generic where clause",
               isOptional: true)
       ]),

  Node(name: "FunctionParameterList",
       nameForDiagnostics: "parameter list",
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
               kind: .token(choices: [.token(tokenKind: "LeftParenToken")])),
         Child(name: "ParameterList",
               kind: .collection(kind: "FunctionParameterList", collectionElementName: "Parameter"),
               nameForDiagnostics: "parameters",
               isIndented: true),
         Child(name: "RightParen",
               kind: .token(choices: [.token(tokenKind: "RightParenToken")]))
       ]),

  Node(name: "ReturnClause",
       nameForDiagnostics: nil,
       kind: "Syntax",
       children: [
         Child(name: "Arrow",
               kind: .token(choices: [.token(tokenKind: "ArrowToken")])),
         Child(name: "ReturnType",
               kind: .node(kind: "Type"),
               nameForDiagnostics: "return type")
       ]),

  Node(name: "FunctionSignature",
       nameForDiagnostics: "function signature",
       kind: "Syntax",
       children: [
         Child(name: "Input",
               kind: .node(kind: "ParameterClause")),
         Child(name: "EffectSpecifiers",
               kind: .node(kind: "DeclEffectSpecifiers"),
               isOptional: true),
         Child(name: "Output",
               kind: .node(kind: "ReturnClause"),
               isOptional: true)
       ]),

  Node(name: "IfConfigClause",
       nameForDiagnostics: "conditional compilation clause",
       kind: "Syntax",
       children: [
         Child(name: "PoundKeyword",
               kind: .token(choices: [.token(tokenKind: "PoundIfToken"), .token(tokenKind: "PoundElseifToken"), .token(tokenKind: "PoundElseToken")]),
               classification: "BuildConfigId"),
         Child(name: "Condition",
               kind: .node(kind: "Expr"),
               nameForDiagnostics: "condition",
               isOptional: true,
               classification: "BuildConfigId"),
         Child(name: "Elements",
               kind: .nodeChoices(choices: [
                 Child(name: "Statements",
                       kind: .node(kind: "CodeBlockItemList")),
                 Child(name: "SwitchCases",
                       kind: .node(kind: "SwitchCaseList")),
                 Child(name: "Decls",
                       kind: .node(kind: "MemberDeclList")),
                 Child(name: "PostfixExpression",
                       kind: .node(kind: "Expr")),
                 Child(name: "Attributes",
                       kind: .node(kind: "AttributeList"))
               ]),
               isOptional: true)
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
               kind: .collection(kind: "IfConfigClauseList", collectionElementName: "Clause")),
         Child(name: "PoundEndif",
               kind: .token(choices: [.token(tokenKind: "PoundEndifToken")]),
               classification: "BuildConfigId")
       ]),

  Node(name: "PoundSourceLocation",
       nameForDiagnostics: "'#sourceLocation' directive",
       kind: "Decl",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "PoundSourceLocation",
               kind: .token(choices: [.token(tokenKind: "PoundSourceLocationToken")])),
         Child(name: "LeftParen",
               kind: .token(choices: [.token(tokenKind: "LeftParenToken")])),
         Child(name: "Args",
               kind: .node(kind: "PoundSourceLocationArgs"),
               nameForDiagnostics: "arguments",
               isOptional: true),
         Child(name: "RightParen",
               kind: .token(choices: [.token(tokenKind: "RightParenToken")]))
       ]),

  Node(name: "PoundSourceLocationArgs",
       nameForDiagnostics: "'#sourceLocation' arguments",
       kind: "Syntax",
       children: [
         Child(name: "FileArgLabel",
               kind: .token(choices: [.keyword(text: "file")])),
         Child(name: "FileArgColon",
               kind: .token(choices: [.token(tokenKind: "ColonToken")])),
         Child(name: "FileName",
               kind: .node(kind: "StringLiteralExpr"),
               nameForDiagnostics: "file name"),
         Child(name: "Comma",
               kind: .token(choices: [.token(tokenKind: "CommaToken")])),
         Child(name: "LineArgLabel",
               kind: .token(choices: [.keyword(text: "line")])),
         Child(name: "LineArgColon",
               kind: .token(choices: [.token(tokenKind: "ColonToken")])),
         Child(name: "LineNumber",
               kind: .token(choices: [.token(tokenKind: "IntegerLiteralToken")]),
               nameForDiagnostics: "line number")
       ]),

  Node(name: "DeclModifierDetail",
       nameForDiagnostics: nil,
       kind: "Syntax",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "LeftParen",
               kind: .token(choices: [.token(tokenKind: "LeftParenToken")])),
         Child(name: "Detail",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .keyword(text: "set")])),
         Child(name: "RightParen",
               kind: .token(choices: [.token(tokenKind: "RightParenToken")]))
       ]),

  Node(name: "DeclModifier",
       nameForDiagnostics: "modifier",
       kind: "Syntax",
       children: [
         Child(name: "Name",
               kind: .token(choices: [.keyword(text: "class"), .keyword(text: "convenience"), .keyword(text: "dynamic"), .keyword(text: "final"), .keyword(text: "infix"), .keyword(text: "lazy"), .keyword(text: "optional"), .keyword(text: "override"), .keyword(text: "postfix"), .keyword(text: "prefix"), .keyword(text: "required"), .keyword(text: "static"), .keyword(text: "unowned"), .keyword(text: "weak"), .keyword(text: "private"), .keyword(text: "fileprivate"), .keyword(text: "internal"), .keyword(text: "public"), .keyword(text: "open"), .keyword(text: "mutating"), .keyword(text: "nonmutating"), .keyword(text: "indirect"), .keyword(text: "__consuming"), .keyword(text: "actor"), .keyword(text: "async"), .keyword(text: "distributed"), .keyword(text: "isolated"), .keyword(text: "nonisolated"), .keyword(text: "_const"), .keyword(text: "_local"), .keyword(text: "package")]),
               classification: "Attribute"),
         Child(name: "Detail",
               kind: .node(kind: "DeclModifierDetail"),
               isOptional: true)
       ]),

  Node(name: "InheritedType",
       nameForDiagnostics: "inherited type",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "TypeName",
               kind: .node(kind: "Type")),
         Child(name: "TrailingComma",
               kind: .token(choices: [.token(tokenKind: "CommaToken")]),
               isOptional: true)
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
               kind: .token(choices: [.token(tokenKind: "ColonToken")])),
         Child(name: "InheritedTypeCollection",
               kind: .collection(kind: "InheritedTypeList", collectionElementName: "InheritedType"))
       ]),

  Node(name: "ClassDecl",
       nameForDiagnostics: "class",
       kind: "Decl",
       traits: [
         "DeclGroup",
         "IdentifiedDecl",
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               nameForDiagnostics: "attributes",
               isOptional: true),
         Child(name: "Modifiers",
               kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
               nameForDiagnostics: "modifiers",
               isOptional: true),
         Child(name: "ClassKeyword",
               kind: .token(choices: [.keyword(text: "class")])),
         Child(name: "Identifier",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")])),
         Child(name: "GenericParameterClause",
               kind: .node(kind: "GenericParameterClause"),
               nameForDiagnostics: "generic parameter clause",
               isOptional: true),
         Child(name: "InheritanceClause",
               kind: .node(kind: "TypeInheritanceClause"),
               nameForDiagnostics: "inheritance clause",
               isOptional: true),
         Child(name: "GenericWhereClause",
               kind: .node(kind: "GenericWhereClause"),
               nameForDiagnostics: "generic where clause",
               isOptional: true),
         Child(name: "Members",
               kind: .node(kind: "MemberDeclBlock"))
       ]),

  Node(name: "ActorDecl",
       nameForDiagnostics: "actor",
       kind: "Decl",
       traits: [
         "DeclGroup",
         "IdentifiedDecl",
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               nameForDiagnostics: "attributes",
               isOptional: true),
         Child(name: "Modifiers",
               kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
               nameForDiagnostics: "modifiers",
               isOptional: true),
         Child(name: "ActorKeyword",
               kind: .token(choices: [.keyword(text: "actor")])),
         Child(name: "Identifier",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")])),
         Child(name: "GenericParameterClause",
               kind: .node(kind: "GenericParameterClause"),
               nameForDiagnostics: "generic parameter clause",
               isOptional: true),
         Child(name: "InheritanceClause",
               kind: .node(kind: "TypeInheritanceClause"),
               nameForDiagnostics: "type inheritance clause",
               isOptional: true),
         Child(name: "GenericWhereClause",
               kind: .node(kind: "GenericWhereClause"),
               nameForDiagnostics: "generic where clause",
               isOptional: true),
         Child(name: "Members",
               kind: .node(kind: "MemberDeclBlock"))
       ]),

  Node(name: "StructDecl",
       nameForDiagnostics: "struct",
       kind: "Decl",
       traits: [
         "DeclGroup",
         "IdentifiedDecl",
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               nameForDiagnostics: "attributes",
               isOptional: true),
         Child(name: "Modifiers",
               kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
               nameForDiagnostics: "modifiers",
               isOptional: true),
         Child(name: "StructKeyword",
               kind: .token(choices: [.keyword(text: "struct")])),
         Child(name: "Identifier",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")])),
         Child(name: "GenericParameterClause",
               kind: .node(kind: "GenericParameterClause"),
               nameForDiagnostics: "generic parameter clause",
               isOptional: true),
         Child(name: "InheritanceClause",
               kind: .node(kind: "TypeInheritanceClause"),
               nameForDiagnostics: "type inheritance clause",
               isOptional: true),
         Child(name: "GenericWhereClause",
               kind: .node(kind: "GenericWhereClause"),
               nameForDiagnostics: "generic where clause",
               isOptional: true),
         Child(name: "Members",
               kind: .node(kind: "MemberDeclBlock"))
       ]),

  Node(name: "ProtocolDecl",
       nameForDiagnostics: "protocol",
       kind: "Decl",
       traits: [
         "DeclGroup",
         "IdentifiedDecl",
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               nameForDiagnostics: "attributes",
               isOptional: true),
         Child(name: "Modifiers",
               kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
               nameForDiagnostics: "modifiers",
               isOptional: true),
         Child(name: "ProtocolKeyword",
               kind: .token(choices: [.keyword(text: "protocol")])),
         Child(name: "Identifier",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")])),
         Child(name: "PrimaryAssociatedTypeClause",
               kind: .node(kind: "PrimaryAssociatedTypeClause"),
               nameForDiagnostics: "primary associated type clause",
               isOptional: true),
         Child(name: "InheritanceClause",
               kind: .node(kind: "TypeInheritanceClause"),
               nameForDiagnostics: "inheritance clause",
               isOptional: true),
         Child(name: "GenericWhereClause",
               kind: .node(kind: "GenericWhereClause"),
               nameForDiagnostics: "generic where clause",
               isOptional: true),
         Child(name: "Members",
               kind: .node(kind: "MemberDeclBlock"))
       ]),

  Node(name: "ExtensionDecl",
       nameForDiagnostics: "extension",
       kind: "Decl",
       traits: [
         "DeclGroup",
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               nameForDiagnostics: "attributes",
               isOptional: true),
         Child(name: "Modifiers",
               kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
               nameForDiagnostics: "modifiers",
               isOptional: true),
         Child(name: "ExtensionKeyword",
               kind: .token(choices: [.keyword(text: "extension")])),
         Child(name: "ExtendedType",
               kind: .node(kind: "Type")),
         Child(name: "InheritanceClause",
               kind: .node(kind: "TypeInheritanceClause"),
               nameForDiagnostics: "inheritance clause",
               isOptional: true),
         Child(name: "GenericWhereClause",
               kind: .node(kind: "GenericWhereClause"),
               nameForDiagnostics: "generic where clause",
               isOptional: true),
         Child(name: "Members",
               kind: .node(kind: "MemberDeclBlock"))
       ]),

  Node(name: "MemberDeclBlock",
       nameForDiagnostics: "member block",
       kind: "Syntax",
       traits: [
         "Braced"
       ],
       parserFunction: "parseMemberDeclList",
       children: [
         Child(name: "LeftBrace",
               kind: .token(choices: [.token(tokenKind: "LeftBraceToken")])),
         Child(name: "Members",
               kind: .collection(kind: "MemberDeclList", collectionElementName: "Member"),
               isIndented: true),
         Child(name: "RightBrace",
               kind: .token(choices: [.token(tokenKind: "RightBraceToken")]),
               requiresLeadingNewline: true)
       ]),

  Node(name: "MemberDeclList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "MemberDeclListItem",
       elementsSeparatedByNewline: true),

  Node(name: "MemberDeclListItem",
       nameForDiagnostics: nil,
       description: "A member declaration of a type consisting of a declaration and an optional semicolon;",
       kind: "Syntax",
       children: [
         Child(name: "Decl",
               kind: .node(kind: "Decl"),
               description: "The declaration of the type member."),
         Child(name: "Semicolon",
               kind: .token(choices: [.token(tokenKind: "SemicolonToken")]),
               description: "An optional trailing semicolon.",
               isOptional: true)
       ],
       omitWhenEmpty: true),

  Node(name: "SourceFile",
       nameForDiagnostics: "source file",
       kind: "Syntax",
       traits: [
         "WithStatements"
       ],
       parserFunction: "parseSourceFile",
       children: [
         Child(name: "Statements",
               kind: .collection(kind: "CodeBlockItemList", collectionElementName: "Statement")),
         Child(name: "EOFToken",
               kind: .node(kind: "EOFToken"))
       ]),

  Node(name: "InitializerClause",
       nameForDiagnostics: nil,
       kind: "Syntax",
       children: [
         Child(name: "Equal",
               kind: .token(choices: [.token(tokenKind: "EqualToken")])),
         Child(name: "Value",
               kind: .node(kind: "Expr"))
       ]),

  Node(name: "FunctionParameter",
       nameForDiagnostics: "parameter",
       kind: "Syntax",
       traits: [
         "WithTrailingComma",
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               nameForDiagnostics: "attributes",
               isOptional: true),
         Child(name: "Modifiers",
               kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
               nameForDiagnostics: "modifiers",
               isOptional: true),
         Child(name: "FirstName",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "WildcardToken")]),
               isOptional: true),
         Child(name: "SecondName",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "WildcardToken")]),
               nameForDiagnostics: "internal name",
               isOptional: true),
         Child(name: "Colon",
               kind: .token(choices: [.token(tokenKind: "ColonToken")]),
               isOptional: true),
         Child(name: "Type",
               kind: .node(kind: "Type"),
               nameForDiagnostics: "type",
               isOptional: true),
         Child(name: "Ellipsis",
               kind: .token(choices: [.token(tokenKind: "EllipsisToken")]),
               isOptional: true),
         Child(name: "DefaultArgument",
               kind: .node(kind: "InitializerClause"),
               nameForDiagnostics: "default argument",
               isOptional: true),
         Child(name: "TrailingComma",
               kind: .token(choices: [.token(tokenKind: "CommaToken")]),
               isOptional: true)
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
         "IdentifiedDecl",
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               nameForDiagnostics: "attributes",
               isOptional: true),
         Child(name: "Modifiers",
               kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
               nameForDiagnostics: "modifiers",
               isOptional: true),
         Child(name: "FuncKeyword",
               kind: .token(choices: [.keyword(text: "func")])),
         Child(name: "Identifier",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "BinaryOperatorToken"), .token(tokenKind: "PrefixOperatorToken"), .token(tokenKind: "PostfixOperatorToken")])),
         Child(name: "GenericParameterClause",
               kind: .node(kind: "GenericParameterClause"),
               nameForDiagnostics: "generic parameter clause",
               isOptional: true),
         Child(name: "Signature",
               kind: .node(kind: "FunctionSignature"),
               nameForDiagnostics: "function signature"),
         Child(name: "GenericWhereClause",
               kind: .node(kind: "GenericWhereClause"),
               nameForDiagnostics: "generic where clause",
               isOptional: true),
         Child(name: "Body",
               kind: .node(kind: "CodeBlock"),
               isOptional: true)
       ]),

  Node(name: "InitializerDecl",
       nameForDiagnostics: "initializer",
       kind: "Decl",
       traits: [
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               nameForDiagnostics: "attributes",
               isOptional: true),
         Child(name: "Modifiers",
               kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
               nameForDiagnostics: "modifiers",
               isOptional: true),
         Child(name: "InitKeyword",
               kind: .token(choices: [.keyword(text: "init")])),
         Child(name: "OptionalMark",
               kind: .token(choices: [.token(tokenKind: "PostfixQuestionMarkToken"), .token(tokenKind: "InfixQuestionMarkToken"), .token(tokenKind: "ExclamationMarkToken")]),
               isOptional: true),
         Child(name: "GenericParameterClause",
               kind: .node(kind: "GenericParameterClause"),
               nameForDiagnostics: "generic parameter clause",
               isOptional: true),
         Child(name: "Signature",
               kind: .node(kind: "FunctionSignature"),
               nameForDiagnostics: "function signature"),
         Child(name: "GenericWhereClause",
               kind: .node(kind: "GenericWhereClause"),
               nameForDiagnostics: "generic where clause",
               isOptional: true),
         Child(name: "Body",
               kind: .node(kind: "CodeBlock"),
               isOptional: true)
       ]),

  Node(name: "DeinitializerDecl",
       nameForDiagnostics: "deinitializer",
       kind: "Decl",
       traits: [
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               nameForDiagnostics: "attributes",
               isOptional: true),
         Child(name: "Modifiers",
               kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
               nameForDiagnostics: "modifiers",
               isOptional: true),
         Child(name: "DeinitKeyword",
               kind: .token(choices: [.keyword(text: "deinit")])),
         Child(name: "Body",
               kind: .node(kind: "CodeBlock"),
               isOptional: true)
       ]),

  Node(name: "SubscriptDecl",
       nameForDiagnostics: "subscript",
       kind: "Decl",
       traits: [
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               nameForDiagnostics: "attributes",
               isOptional: true),
         Child(name: "Modifiers",
               kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
               nameForDiagnostics: "modifiers",
               isOptional: true),
         Child(name: "SubscriptKeyword",
               kind: .token(choices: [.keyword(text: "subscript")])),
         Child(name: "GenericParameterClause",
               kind: .node(kind: "GenericParameterClause"),
               nameForDiagnostics: "generic parameter clause",
               isOptional: true),
         Child(name: "Indices",
               kind: .node(kind: "ParameterClause")),
         Child(name: "Result",
               kind: .node(kind: "ReturnClause")),
         Child(name: "GenericWhereClause",
               kind: .node(kind: "GenericWhereClause"),
               nameForDiagnostics: "generic where clause",
               isOptional: true),
         Child(name: "Accessor",
               kind: .nodeChoices(choices: [
                 Child(name: "Accessors",
                       kind: .node(kind: "AccessorBlock")),
                 Child(name: "Getter",
                       kind: .node(kind: "CodeBlock"))
               ]),
               isOptional: true)
       ]),

  Node(name: "AccessPathComponent",
       nameForDiagnostics: nil,
       kind: "Syntax",
       children: [
         Child(name: "Name",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
               nameForDiagnostics: "name"),
         Child(name: "TrailingDot",
               kind: .token(choices: [.token(tokenKind: "PeriodToken")]),
               isOptional: true)
       ]),

  Node(name: "AccessPath",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "AccessPathComponent"),

  Node(name: "ImportDecl",
       nameForDiagnostics: "import",
       kind: "Decl",
       traits: [
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               nameForDiagnostics: "attributes",
               isOptional: true),
         Child(name: "Modifiers",
               kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
               nameForDiagnostics: "modifiers",
               isOptional: true),
         Child(name: "ImportTok",
               kind: .token(choices: [.keyword(text: "import")])),
         Child(name: "ImportKind",
               kind: .token(choices: [.keyword(text: "typealias"), .keyword(text: "struct"), .keyword(text: "class"), .keyword(text: "enum"), .keyword(text: "protocol"), .keyword(text: "var"), .keyword(text: "let"), .keyword(text: "func")]),
               isOptional: true),
         Child(name: "Path",
               kind: .collection(kind: "AccessPath", collectionElementName: "PathComponent"))
       ]),

  Node(name: "AccessorParameter",
       nameForDiagnostics: nil,
       kind: "Syntax",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "LeftParen",
               kind: .token(choices: [.token(tokenKind: "LeftParenToken")])),
         Child(name: "Name",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
               nameForDiagnostics: "name"),
         Child(name: "RightParen",
               kind: .token(choices: [.token(tokenKind: "RightParenToken")]))
       ]),

  Node(name: "AccessorDecl",
       nameForDiagnostics: "accessor",
       kind: "Decl",
       traits: [
         "Attributed"
       ],
       parserFunction: "parseAccessorDecl",
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               nameForDiagnostics: "attributes",
               isOptional: true),
         Child(name: "Modifier",
               kind: .node(kind: "DeclModifier"),
               nameForDiagnostics: "modifiers",
               isOptional: true),
         Child(name: "AccessorKind",
               kind: .token(choices: [.keyword(text: "get"), .keyword(text: "set"), .keyword(text: "didSet"), .keyword(text: "willSet"), .keyword(text: "unsafeAddress"), .keyword(text: "addressWithOwner"), .keyword(text: "addressWithNativeOwner"), .keyword(text: "unsafeMutableAddress"), .keyword(text: "mutableAddressWithOwner"), .keyword(text: "mutableAddressWithNativeOwner"), .keyword(text: "_read"), .keyword(text: "_modify")])),
         Child(name: "Parameter",
               kind: .node(kind: "AccessorParameter"),
               nameForDiagnostics: "parameter",
               isOptional: true),
         Child(name: "EffectSpecifiers",
               kind: .node(kind: "DeclEffectSpecifiers"),
               isOptional: true),
         Child(name: "Body",
               kind: .node(kind: "CodeBlock"),
               isOptional: true)
       ]),

  Node(name: "AccessorList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "AccessorDecl",
       elementsSeparatedByNewline: true),

  Node(name: "AccessorBlock",
       nameForDiagnostics: nil,
       kind: "Syntax",
       traits: [
         "Braced"
       ],
       children: [
         Child(name: "LeftBrace",
               kind: .token(choices: [.token(tokenKind: "LeftBraceToken")])),
         Child(name: "Accessors",
               kind: .collection(kind: "AccessorList", collectionElementName: "Accessor"),
               isIndented: true),
         Child(name: "RightBrace",
               kind: .token(choices: [.token(tokenKind: "RightBraceToken")]),
               requiresLeadingNewline: true)
       ]),

  Node(name: "PatternBinding",
       nameForDiagnostics: nil,
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Pattern",
               kind: .node(kind: "Pattern")),
         Child(name: "TypeAnnotation",
               kind: .node(kind: "TypeAnnotation"),
               nameForDiagnostics: "type annotation",
               isOptional: true),
         Child(name: "Initializer",
               kind: .node(kind: "InitializerClause"),
               isOptional: true),
         Child(name: "Accessor",
               kind: .nodeChoices(choices: [
                 Child(name: "Accessors",
                       kind: .node(kind: "AccessorBlock")),
                 Child(name: "Getter",
                       kind: .node(kind: "CodeBlock"))
               ]),
               isOptional: true),
         Child(name: "TrailingComma",
               kind: .token(choices: [.token(tokenKind: "CommaToken")]),
               isOptional: true)
       ]),

  Node(name: "PatternBindingList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "PatternBinding"),

  Node(name: "VariableDecl",
       nameForDiagnostics: "variable",
       kind: "Decl",
       traits: [
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               nameForDiagnostics: "attributes",
               isOptional: true),
         Child(name: "Modifiers",
               kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
               nameForDiagnostics: "modifiers",
               isOptional: true),
         Child(name: "LetOrVarKeyword",
               kind: .token(choices: [.keyword(text: "let"), .keyword(text: "var")])),
         Child(name: "Bindings",
               kind: .collection(kind: "PatternBindingList", collectionElementName: "Binding"))
       ]),

  Node(name: "EnumCaseElement",
       nameForDiagnostics: nil,
       description: "An element of an enum case, containing the name of the case and, optionally, either associated values or an assignment to a raw value.",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Identifier",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
               description: "The name of this case."),
         Child(name: "AssociatedValue",
               kind: .node(kind: "ParameterClause"),
               nameForDiagnostics: "associated values",
               description: "The set of associated values of the case.",
               isOptional: true),
         Child(name: "RawValue",
               kind: .node(kind: "InitializerClause"),
               description: "The raw value of this enum element, if present.",
               isOptional: true),
         Child(name: "TrailingComma",
               kind: .token(choices: [.token(tokenKind: "CommaToken")]),
               description: "The trailing comma of this element, if the case has multiple elements.",
               isOptional: true)
       ]),

  Node(name: "EnumCaseElementList",
       nameForDiagnostics: nil,
       description: "A collection of 0 or more `EnumCaseElement`s.",
       kind: "SyntaxCollection",
       element: "EnumCaseElement"),

  Node(name: "EnumCaseDecl",
       nameForDiagnostics: "enum case",
       description: "A `case` declaration of a Swift `enum`. It can have 1 or more `EnumCaseElement`s inside, each declaring a different case of the enum.",
       kind: "Decl",
       traits: [
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               nameForDiagnostics: "attributes",
               description: "The attributes applied to the case declaration.",
               isOptional: true),
         Child(name: "Modifiers",
               kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
               nameForDiagnostics: "modifiers",
               description: "The declaration modifiers applied to the case declaration.",
               isOptional: true),
         Child(name: "CaseKeyword",
               kind: .token(choices: [.keyword(text: "case")]),
               description: "The `case` keyword for this case."),
         Child(name: "Elements",
               kind: .collection(kind: "EnumCaseElementList", collectionElementName: "Element"),
               nameForDiagnostics: "elements",
               description: "The elements this case declares.")
       ]),

  Node(name: "EnumDecl",
       nameForDiagnostics: "enum",
       description: "A Swift `enum` declaration.",
       kind: "Decl",
       traits: [
         "DeclGroup",
         "IdentifiedDecl",
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               nameForDiagnostics: "attributes",
               description: "The attributes applied to the enum declaration.",
               isOptional: true),
         Child(name: "Modifiers",
               kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
               nameForDiagnostics: "modifiers",
               description: "The declaration modifiers applied to the enum declaration.",
               isOptional: true),
         Child(name: "EnumKeyword",
               kind: .token(choices: [.keyword(text: "enum")]),
               description: "The `enum` keyword for this declaration."),
         Child(name: "Identifier",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
               description: "The name of this enum."),
         Child(name: "GenericParameters",
               kind: .node(kind: "GenericParameterClause"),
               nameForDiagnostics: "generic parameter clause",
               description: "The generic parameters, if any, for this enum.",
               isOptional: true),
         Child(name: "InheritanceClause",
               kind: .node(kind: "TypeInheritanceClause"),
               nameForDiagnostics: "inheritance clause",
               description: "The inheritance clause describing conformances or raw values for this enum.",
               isOptional: true),
         Child(name: "GenericWhereClause",
               kind: .node(kind: "GenericWhereClause"),
               nameForDiagnostics: "generic where clause",
               description: "The `where` clause that applies to the generic parameters of this enum.",
               isOptional: true),
         Child(name: "Members",
               kind: .node(kind: "MemberDeclBlock"),
               description: "The cases and other members of this enum.")
       ]),

  Node(name: "OperatorDecl",
       nameForDiagnostics: "operator declaration",
       description: "A Swift `operator` declaration.",
       kind: "Decl",
       traits: [
         "IdentifiedDecl",
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               nameForDiagnostics: "attributes",
               description: "The attributes applied to the 'operator' declaration.",
               isOptional: true),
         Child(name: "Modifiers",
               kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
               nameForDiagnostics: "modifiers",
               description: "The declaration modifiers applied to the 'operator' declaration.",
               isOptional: true,
               classification: "Attribute"),
         Child(name: "OperatorKeyword",
               kind: .token(choices: [.keyword(text: "operator")])),
         Child(name: "Identifier",
               kind: .token(choices: [.token(tokenKind: "BinaryOperatorToken"), .token(tokenKind: "PrefixOperatorToken"), .token(tokenKind: "PostfixOperatorToken")]),
               classification: "OperatorIdentifier"),
         Child(name: "OperatorPrecedenceAndTypes",
               kind: .node(kind: "OperatorPrecedenceAndTypes"),
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
               kind: .token(choices: [.token(tokenKind: "CommaToken")])),
         Child(name: "Name",
               kind: .node(kind: "Token"))
       ]),

  Node(name: "OperatorPrecedenceAndTypes",
       nameForDiagnostics: nil,
       description: "A clause to specify precedence group in infix operator declarations, and designated types in any operator declaration.",
       kind: "Syntax",
       children: [
         Child(name: "Colon",
               kind: .token(choices: [.token(tokenKind: "ColonToken")])),
         Child(name: "PrecedenceGroup",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
               nameForDiagnostics: "precedence group",
               description: "The precedence group for this operator"),
         Child(name: "DesignatedTypes",
               kind: .collection(kind: "DesignatedTypeList", collectionElementName: "DesignatedTypeElement"),
               description: "The designated types associated with this operator.")
       ]),

  Node(name: "PrecedenceGroupDecl",
       nameForDiagnostics: "precedencegroup",
       description: "A Swift `precedencegroup` declaration.",
       kind: "Decl",
       traits: [
         "IdentifiedDecl",
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               nameForDiagnostics: "attributes",
               description: "The attributes applied to the 'precedencegroup' declaration.",
               isOptional: true),
         Child(name: "Modifiers",
               kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
               nameForDiagnostics: "modifiers",
               description: "The declaration modifiers applied to the 'precedencegroup' declaration.",
               isOptional: true),
         Child(name: "PrecedencegroupKeyword",
               kind: .token(choices: [.keyword(text: "precedencegroup")])),
         Child(name: "Identifier",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
               description: "The name of this precedence group."),
         Child(name: "LeftBrace",
               kind: .token(choices: [.token(tokenKind: "LeftBraceToken")])),
         Child(name: "GroupAttributes",
               kind: .collection(kind: "PrecedenceGroupAttributeList", collectionElementName: "GroupAttribute"),
               description: "The characteristics of this precedence group."),
         Child(name: "RightBrace",
               kind: .token(choices: [.token(tokenKind: "RightBraceToken")]))
       ]),

  Node(name: "PrecedenceGroupAttributeList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "Syntax",
       elementName: "PrecedenceGroupAttribute",
       elementChoices: ["PrecedenceGroupRelation", "PrecedenceGroupAssignment", "PrecedenceGroupAssociativity"]),

  Node(name: "PrecedenceGroupRelation",
       nameForDiagnostics: "'relation' property of precedencegroup",
       description: "Specify the new precedence group's relation to existing precedence groups.",
       kind: "Syntax",
       children: [
         Child(name: "HigherThanOrLowerThan",
               kind: .token(choices: [.keyword(text: "higherThan"), .keyword(text: "lowerThan")]),
               description: "The relation to specified other precedence groups.",
               classification: "Keyword"),
         Child(name: "Colon",
               kind: .token(choices: [.token(tokenKind: "ColonToken")])),
         Child(name: "OtherNames",
               kind: .collection(kind: "PrecedenceGroupNameList", collectionElementName: "OtherName"),
               description: "The name of other precedence group to which this precedence group relates.")
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
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
               nameForDiagnostics: "name"),
         Child(name: "TrailingComma",
               kind: .token(choices: [.token(tokenKind: "CommaToken")]),
               isOptional: true)
       ]),

  Node(name: "PrecedenceGroupAssignment",
       nameForDiagnostics: "'assignment' property of precedencegroup",
       description: "Specifies the precedence of an operator when used in an operation that includes optional chaining.",
       kind: "Syntax",
       children: [
         Child(name: "AssignmentKeyword",
               kind: .token(choices: [.keyword(text: "assignment")])),
         Child(name: "Colon",
               kind: .token(choices: [.token(tokenKind: "ColonToken")])),
         Child(name: "Flag",
               kind: .token(choices: [.keyword(text: "true"), .keyword(text: "false")]),
               description: "When true, an operator in the corresponding precedence group uses the same grouping rules during optional chaining as the assignment operators from the standard library. Otherwise, operators in the precedence group follows the same optional chaining rules as operators that don't perform assignment.")
       ]),

  Node(name: "PrecedenceGroupAssociativity",
       nameForDiagnostics: "'associativity' property of precedencegroup",
       description: "Specifies how a sequence of operators with the same precedence level are grouped together in the absence of grouping parentheses.",
       kind: "Syntax",
       children: [
         Child(name: "AssociativityKeyword",
               kind: .token(choices: [.keyword(text: "associativity")]),
               classification: "Keyword"),
         Child(name: "Colon",
               kind: .token(choices: [.token(tokenKind: "ColonToken")])),
         Child(name: "Value",
               kind: .token(choices: [.keyword(text: "left"), .keyword(text: "right"), .keyword(text: "none")]),
               description: "Operators that are `left`-associative group left-to-right. Operators that are `right`-associative group right-to-left. Operators that are specified with an associativity of `none` don't associate at all")
       ]),

  Node(name: "MacroDecl",
       nameForDiagnostics: "macro",
       kind: "Decl",
       traits: [
         "IdentifiedDecl",
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               nameForDiagnostics: "attributes",
               isOptional: true),
         Child(name: "Modifiers",
               kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
               nameForDiagnostics: "modifiers",
               isOptional: true),
         Child(name: "MacroKeyword",
               kind: .token(choices: [.keyword(text: "macro")])),
         Child(name: "Identifier",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")])),
         Child(name: "GenericParameterClause",
               kind: .node(kind: "GenericParameterClause"),
               nameForDiagnostics: "generic parameter clause",
               isOptional: true),
         Child(name: "Signature",
               kind: .nodeChoices(choices: [
                 Child(name: "FunctionLike",
                       kind: .node(kind: "FunctionSignature"),
                       nameForDiagnostics: "macro signature"),
                 Child(name: "ValueLike",
                       kind: .node(kind: "TypeAnnotation"),
                       nameForDiagnostics: "macro signature")
               ]),
               nameForDiagnostics: "macro signature"),
         Child(name: "Definition",
               kind: .node(kind: "InitializerClause"),
               nameForDiagnostics: "macro definition",
               isOptional: true),
         Child(name: "GenericWhereClause",
               kind: .node(kind: "GenericWhereClause"),
               nameForDiagnostics: "generic where clause",
               isOptional: true)
       ]),

  Node(name: "MacroExpansionDecl",
       nameForDiagnostics: "macro expansion",
       kind: "Decl",
       traits: [
         "FreestandingMacroExpansion"
       ],
       children: [
         Child(name: "PoundToken",
               kind: .token(choices: [.token(tokenKind: "PoundToken")]),
               description: "The `#` sign."),
         Child(name: "Macro",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")])),
         Child(name: "GenericArguments",
               kind: .node(kind: "GenericArgumentClause"),
               isOptional: true),
         Child(name: "LeftParen",
               kind: .token(choices: [.token(tokenKind: "LeftParenToken")]),
               isOptional: true),
         Child(name: "ArgumentList",
               kind: .collection(kind: "TupleExprElementList", collectionElementName: "Argument")),
         Child(name: "RightParen",
               kind: .token(choices: [.token(tokenKind: "RightParenToken")]),
               isOptional: true),
         Child(name: "TrailingClosure",
               kind: .node(kind: "ClosureExpr"),
               isOptional: true),
         Child(name: "AdditionalTrailingClosures",
               kind: .collection(kind: "MultipleTrailingClosureElementList", collectionElementName: "AdditionalTrailingClosure"),
               isOptional: true)
       ]),

  Node(name: "EditorPlaceholderDecl",
       nameForDiagnostics: "editor placeholder",
       kind: "Decl",
       children: [
         Child(name: "Identifier",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")]))
       ]),

]
