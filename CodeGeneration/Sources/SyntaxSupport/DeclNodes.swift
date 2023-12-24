//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

public let DECL_NODES: [Node] = [
  Node(
    kind: .importPathComponent,
    base: .syntax,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "name",
        kind: .token(choices: [
          .token(.identifier),
          .token(.binaryOperator),
          .token(.prefixOperator),
          .token(.postfixOperator),
        ]),
        nameForDiagnostics: "name"
      ),
      Child(
        name: "trailingPeriod",
        deprecatedName: "trailingDot",
        kind: .token(choices: [.token(.period)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .importPathComponentList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.importPathComponent]
  ),

  Node(
    kind: .accessorBlock,
    base: .syntax,
    nameForDiagnostics: nil,
    parserFunction: "parseAccessorBlock",
    traits: [
      "Braced"
    ],
    children: [
      Child(
        name: "leftBrace",
        kind: .token(choices: [.token(.leftBrace)]),
        documentation: "The brace introducing the accessor block."
      ),
      Child(
        name: "accessors",
        kind: .nodeChoices(choices: [
          Child(
            name: "accessors",
            kind: .collection(kind: .accessorDeclList, collectionElementName: "Accessor")
          ),
          Child(
            name: "getter",
            kind: .node(kind: .codeBlockItemList)
          ),
        ])
      ),
      Child(
        name: "rightBrace",
        kind: .token(choices: [.token(.rightBrace)]),
        documentation: "The brace closing the accessor block."
      ),
    ]
  ),

  Node(
    kind: .accessorDecl,
    base: .decl,
    nameForDiagnostics: "accessor",
    parserFunction: "parseAccessorDecl",
    traits: [
      "WithOptionalCodeBlock",
      "WithAttributes",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes"
      ),
      Child(
        name: "modifier",
        kind: .node(kind: .declModifier),
        nameForDiagnostics: "modifiers",
        isOptional: true
      ),
      Child(
        name: "accessorSpecifier",
        deprecatedName: "accessorKind",
        kind: .token(choices: [
          .keyword(.get),
          .keyword(.set),
          .keyword(.didSet),
          .keyword(.willSet),
          .keyword(.unsafeAddress),
          .keyword(.addressWithOwner),
          .keyword(.addressWithNativeOwner),
          .keyword(.unsafeMutableAddress),
          .keyword(.mutableAddressWithOwner),
          .keyword(.mutableAddressWithNativeOwner),
          .keyword(._read),
          .keyword(._modify),
          .keyword(.`init`),
        ])
      ),
      Child(
        name: "parameters",
        deprecatedName: "parameter",
        kind: .node(kind: .accessorParameters),
        nameForDiagnostics: "parameter",
        isOptional: true
      ),
      Child(
        name: "effectSpecifiers",
        kind: .node(kind: .accessorEffectSpecifiers),
        isOptional: true
      ),
      Child(
        name: "body",
        kind: .node(kind: .codeBlock),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .accessorDeclList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.accessorDecl]
  ),

  Node(
    kind: .accessorParameters,
    base: .syntax,
    nameForDiagnostics: nil,
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)])
      ),
      Child(
        name: "name",
        kind: .token(choices: [.token(.identifier)]),
        nameForDiagnostics: "name"
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)])
      ),
    ]
  ),

  Node(
    kind: .actorDecl,
    base: .decl,
    nameForDiagnostics: "actor",
    traits: [
      "DeclGroup",
      "NamedDecl",
      "WithAttributes",
      "WithGenericParameters",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes"
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers",
        documentation: "Modifiers like `public` that are attached to the actor declaration."
      ),
      Child(
        name: "actorKeyword",
        kind: .token(choices: [.keyword(.actor)]),
        documentation: "The `actor` keyword."
      ),
      Child(
        name: "name",
        deprecatedName: "identifier",
        kind: .token(choices: [.token(.identifier)]),
        documentation: "The name of the actor. If the name matches a reserved keyword use backticks to escape it."
      ),
      Child(
        name: "genericParameterClause",
        kind: .node(kind: .genericParameterClause),
        nameForDiagnostics: "generic parameter clause",
        documentation: "The parameter clause that defines the generic parameters.",
        isOptional: true
      ),
      Child(
        name: "inheritanceClause",
        kind: .node(kind: .inheritanceClause),
        nameForDiagnostics: "inheritance clause",
        isOptional: true
      ),
      Child(
        name: "genericWhereClause",
        kind: .node(kind: .genericWhereClause),
        nameForDiagnostics: "generic where clause",
        documentation: "A `where` clause that places additional constraints on generic parameters like `where Element: Hashable`.",
        isOptional: true
      ),
      Child(
        name: "memberBlock",
        kind: .node(kind: .memberBlock)
      ),
    ]
  ),

  Node(
    kind: .associatedTypeDecl,
    base: .decl,
    nameForDiagnostics: "associatedtype declaration",
    documentation: """
      An `associatedtype` declaration

      An example of an associatedtype declaration is

      ```swift
      associatedtype Item
      ```

      An associated type declaration may contain a type initializer clause which represents a default type assignment for the associated type.

      ```swift
      associatedtype Item = Int
      ```

      An associated type declaration may be declared with an inheritance clause which specifies the required conformances.

      ```swift
      associatedtype Iterator: IteratorProtocol
      ```

      A generic where clause may be present, here is an example which shows an associated type containing an inheritance clauses and a generic where clause.

      ```swift
      associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
      ```
      """,
    traits: [
      "NamedDecl",
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes",
        documentation: "Attributes attached to the associated type declaration."
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers",
        documentation: "Modifiers like `public` that are attached to the associated type declaration."
      ),
      Child(
        name: "associatedtypeKeyword",
        kind: .token(choices: [.keyword(.associatedtype)]),
        documentation: "The `associatedtype` keyword for this declaration."
      ),
      Child(
        name: "name",
        deprecatedName: "identifier",
        kind: .token(choices: [.token(.identifier)]),
        documentation: "The name of this associated type."
      ),
      Child(
        name: "inheritanceClause",
        kind: .node(kind: .inheritanceClause),
        nameForDiagnostics: "inheritance clause",
        documentation: "The inheritance clause describing conformances for this associated type declaration.",
        isOptional: true
      ),
      Child(
        name: "initializer",
        kind: .node(kind: .typeInitializerClause),
        documentation: "The type initializer clause for this associated type declaration which represents a default type assignment for the associated type.",
        isOptional: true
      ),
      Child(
        name: "genericWhereClause",
        kind: .node(kind: .genericWhereClause),
        nameForDiagnostics: "generic where clause",
        documentation: "The `where` clause that applies to the generic parameters of this associated type declaration.",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .classDecl,
    base: .decl,
    nameForDiagnostics: "class",
    documentation: """
      A `class` declaration

      An example of a class declaration is

      ```swift
      class SomeClass {
        let someMember: String

        init(someMember: String) {
          self.someMember = someMember
        }

        func foo() {
          print(someMember)
        }

        static func bar() -> Int {
          return 1
        }
      }
      ```

      A class declaration may be declared without any members.
      """,
    traits: [
      "DeclGroup",
      "NamedDecl",
      "WithAttributes",
      "WithGenericParameters",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes",
        documentation: "Attributes attached to the class declaration, such as an `@available` attribute."
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers",
        documentation: "Modifiers like `public` that are attached to the class declaration."
      ),
      Child(
        name: "classKeyword",
        kind: .token(choices: [.keyword(.class)]),
        documentation: "The `class` keyword for this declaration."
      ),
      Child(
        name: "name",
        deprecatedName: "identifier",
        kind: .token(choices: [.token(.identifier)]),
        documentation: "The name of the class."
      ),
      Child(
        name: "genericParameterClause",
        kind: .node(kind: .genericParameterClause),
        nameForDiagnostics: "generic parameter clause",
        documentation: "The generic parameters, if any, of the class declaration.",
        isOptional: true
      ),
      Child(
        name: "inheritanceClause",
        kind: .node(kind: .inheritanceClause),
        nameForDiagnostics: "inheritance clause",
        documentation: "The inheritance clause describing one or more conformances for this class declaration.",
        isOptional: true
      ),
      Child(
        name: "genericWhereClause",
        kind: .node(kind: .genericWhereClause),
        nameForDiagnostics: "generic where clause",
        documentation: "The `where` clause that applies to the generic parameters of this class declaration.",
        isOptional: true
      ),
      Child(
        name: "memberBlock",
        kind: .node(kind: .memberBlock),
        documentation:
          "The members of the class declaration. As class extension declarations may declare additional members, the contents of this member block isn't guaranteed to be a complete list of members for this type."
      ),
    ]
  ),

  Node(
    kind: .declModifierDetail,
    base: .syntax,
    nameForDiagnostics: nil,
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)])
      ),
      Child(
        name: "detail",
        kind: .token(choices: [.token(.identifier)])
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)])
      ),
    ]
  ),

  Node(
    kind: .declModifier,
    base: .syntax,
    nameForDiagnostics: "modifier",
    children: [
      Child(
        name: "name",
        kind: .token(choices: [
          .keyword(.__consuming),
          .keyword(.__setter_access),
          .keyword(._const),
          .keyword(._local),
          .keyword(.actor),
          .keyword(.async),
          .keyword(.borrowing),
          .keyword(.class),
          .keyword(.consuming),
          .keyword(.convenience),
          .keyword(.distributed),
          .keyword(.dynamic),
          .keyword(.fileprivate),
          .keyword(.final),
          .keyword(.indirect),
          .keyword(.infix),
          .keyword(.internal),
          .keyword(.isolated),
          .keyword(.lazy),
          .keyword(.mutating),
          .keyword(.nonisolated),
          .keyword(.nonmutating),
          .keyword(.open),
          .keyword(.optional),
          .keyword(.override),
          .keyword(.package),
          .keyword(.postfix),
          .keyword(.prefix),
          .keyword(.private),
          .keyword(.public),
          .keyword(.reasync),
          .keyword(._resultDependsOnSelf),
          .keyword(.required),
          .keyword(.static),
          .keyword(.transferring),
          .keyword(.unowned),
          .keyword(.weak),
        ])
      ),
      Child(
        name: "detail",
        kind: .node(kind: .declModifierDetail),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .deinitializerDecl,
    base: .decl,
    nameForDiagnostics: "deinitializer",
    documentation: """
      A `deint` declaration

      An example of a deinitializer is

      ```swift
      deinit {
      }
      ```
      """,
    traits: [
      "WithAttributes",
      "WithModifiers",
      "WithOptionalCodeBlock",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes",
        documentation: "Attributes that are attached to the deinitializer."
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers",
        documentation: "Modifiers like `public` that are attached to the deinitializer."
      ),
      Child(
        name: "deinitKeyword",
        kind: .token(choices: [.keyword(.deinit)]),
        documentation: "The `deinit` keyword."
      ),
      Child(
        name: "effectSpecifiers",
        kind: .node(kind: .deinitializerEffectSpecifiers),
        isOptional: true
      ),
      Child(
        name: "body",
        kind: .node(kind: .codeBlock),
        documentation: "The deinitializer's body.",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .designatedType,
    base: .syntax,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "leadingComma",
        kind: .token(choices: [.token(.comma)])
      ),
      Child(
        name: "name",
        kind: .node(kind: .token)
      ),
    ]
  ),

  Node(
    kind: .designatedTypeList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.designatedType]
  ),

  Node(
    kind: .editorPlaceholderDecl,
    base: .decl,
    nameForDiagnostics: "editor placeholder",
    documentation: """
      An editor placeholder, e.g. `<#declaration#>` that is used in a position that expects a declaration.

      - Warning: This ``EditorPlaceholderDeclSyntax`` node is not generated by the parser anymore. Placeholders are represented by a ``MissingDeclSyntax``.
      """,
    traits: [
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        documentation: "If there were attributes before the editor placeholder, the ``EditorPlaceholderDeclSyntax`` will contain these."
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        documentation: "If there were modifiers before the editor placeholder, the `EditorPlaceholderDecl` will contain these."
      ),
      Child(
        name: "placeholder",
        deprecatedName: "identifier",
        kind: .token(choices: [.token(.identifier)]),
        documentation: """
          The actual editor placeholder that starts with `<#` and ends with `#>`.
          """
      ),
    ]
  ),

  Node(
    kind: .enumCaseParameterClause,
    base: .syntax,
    nameForDiagnostics: "parameter clause",
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)]),
        documentation: "The '(' to open the parameter clause."
      ),
      Child(
        name: "parameters",
        deprecatedName: "parameterList",
        kind: .collection(kind: .enumCaseParameterList, collectionElementName: "Parameter"),
        nameForDiagnostics: "parameters",
        documentation: "The actual parameters."
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)]),
        documentation: "The ')' to close the parameter clause."
      ),
    ]
  ),

  Node(
    kind: .enumCaseParameterList,
    base: .syntaxCollection,
    nameForDiagnostics: "parameter list",
    elementChoices: [.enumCaseParameter]
  ),

  Node(
    kind: .enumCaseParameter,
    base: .syntax,
    nameForDiagnostics: "parameter",
    parserFunction: "parseEnumCaseParameter",
    traits: ["WithTrailingComma", "WithModifiers"],
    children: [
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers"
      ),
      Child(
        name: "firstName",
        kind: .token(choices: [.token(.identifier), .token(.wildcard)]),
        isOptional: true
      ),
      Child(
        name: "secondName",
        kind: .token(choices: [.token(.identifier), .token(.wildcard)]),
        isOptional: true
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)]),
        documentation: "If the parameter has a label, the colon separating the label from the type.",
        isOptional: true
      ),
      Child(
        name: "type",
        kind: .node(kind: .type),
        nameForDiagnostics: "type",
        documentation: "The parameter's type."
      ),
      Child(
        name: "defaultValue",
        deprecatedName: "defaultArgument",
        kind: .node(kind: .initializerClause),
        nameForDiagnostics: "default value",
        documentation: "If the parameter has a default value, the initializer clause describing the default value.",
        isOptional: true
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        documentation: "If the parameter is followed by another parameter, the comma separating them.",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .enumCaseDecl,
    base: .decl,
    nameForDiagnostics: "enum case",
    documentation: "A `case` declaration of a Swift `enum`. It can have 1 or more `EnumCaseElement`s inside, each declaring a different case of the enum.",
    traits: [
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes",
        documentation: "The attributes applied to the case declaration."
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers",
        documentation: "The declaration modifiers applied to the case declaration."
      ),
      Child(
        name: "caseKeyword",
        kind: .token(choices: [.keyword(.case)]),
        documentation: "The `case` keyword for this case."
      ),
      Child(
        name: "elements",
        kind: .collection(kind: .enumCaseElementList, collectionElementName: "Element"),
        nameForDiagnostics: "elements",
        documentation: "The elements this case declares."
      ),
    ]
  ),

  Node(
    kind: .enumCaseElementList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    documentation: "A collection of 0 or more ``EnumCaseElementSyntax``s.",
    elementChoices: [.enumCaseElement]
  ),

  Node(
    kind: .enumCaseElement,
    base: .syntax,
    nameForDiagnostics: nil,
    documentation: "An element of an enum case, containing the name of the case and, optionally, either associated values or an assignment to a raw value.",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "name",
        deprecatedName: "identifier",
        kind: .token(choices: [.token(.identifier)]),
        documentation: "The name of this case."
      ),
      Child(
        name: "parameterClause",
        deprecatedName: "associatedValue",
        kind: .node(kind: .enumCaseParameterClause),
        nameForDiagnostics: "associated values",
        documentation: "The set of associated values of the case.",
        isOptional: true
      ),
      Child(
        name: "rawValue",
        kind: .node(kind: .initializerClause),
        documentation: "The raw value of this enum element, if present.",
        isOptional: true
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        documentation: "The trailing comma of this element, if the case has multiple elements.",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .enumDecl,
    base: .decl,
    nameForDiagnostics: "enum",
    documentation: "A Swift `enum` declaration.",
    traits: [
      "DeclGroup",
      "NamedDecl",
      "WithAttributes",
      "WithGenericParameters",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes",
        documentation: "The attributes applied to the enum declaration."
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers",
        documentation: "The declaration modifiers applied to the enum declaration."
      ),
      Child(
        name: "enumKeyword",
        kind: .token(choices: [.keyword(.enum)]),
        documentation: "The `enum` keyword for this declaration."
      ),
      Child(
        name: "name",
        deprecatedName: "identifier",
        kind: .token(choices: [.token(.identifier)]),
        documentation: "Declares the name of this enum. If the name matches a reserved keyword use backticks to escape it."
      ),
      Child(
        name: "genericParameterClause",
        deprecatedName: "genericParameters",
        kind: .node(kind: .genericParameterClause),
        nameForDiagnostics: "generic parameter clause",
        documentation: "The generic parameters, if any, for this enum declaration.",
        isOptional: true
      ),
      Child(
        name: "inheritanceClause",
        kind: .node(kind: .inheritanceClause),
        nameForDiagnostics: "inheritance clause",
        documentation: "The inheritance clause describing conformances or raw values for this enum declaration.",
        isOptional: true
      ),
      Child(
        name: "genericWhereClause",
        kind: .node(kind: .genericWhereClause),
        nameForDiagnostics: "generic where clause",
        documentation: "The `where` clause that applies to the generic parameters of this enum declaration.",
        isOptional: true
      ),
      Child(
        name: "memberBlock",
        kind: .node(kind: .memberBlock),
        documentation:
          "The cases and other members associated with this enum declaration. Because enum extension declarations may declare additional members the contents of this member block isn't guaranteed to be a complete list of members for this type."
      ),
    ]
  ),

  Node(
    kind: .extensionDecl,
    base: .decl,
    nameForDiagnostics: "extension",
    traits: [
      "DeclGroup",
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes"
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers",
        documentation: "Modifiers like `public` that are attached to the extension declaration."
      ),
      Child(
        name: "extensionKeyword",
        kind: .token(choices: [.keyword(.extension)])
      ),
      Child(
        name: "extendedType",
        kind: .node(kind: .type)
      ),
      Child(
        name: "inheritanceClause",
        kind: .node(kind: .inheritanceClause),
        nameForDiagnostics: "inheritance clause",
        isOptional: true
      ),
      Child(
        name: "genericWhereClause",
        kind: .node(kind: .genericWhereClause),
        nameForDiagnostics: "generic where clause",
        documentation: "A `where` clause that places additional constraints on generic parameters like `where Element: Hashable`.",
        isOptional: true
      ),
      Child(
        name: "memberBlock",
        kind: .node(kind: .memberBlock),
        documentation:
          "The members of the extension declaration. As this is an extension, the contents of this member block isn't guaranteed to be a complete list of members for this type."
      ),
    ]
  ),

  Node(
    kind: .functionDecl,
    base: .decl,
    nameForDiagnostics: "function",
    traits: [
      "NamedDecl",
      "WithAttributes",
      "WithGenericParameters",
      "WithModifiers",
      "WithOptionalCodeBlock",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes"
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers",
        documentation: "Modifiers like `public` that are attached to the function declaration."
      ),
      Child(
        name: "funcKeyword",
        kind: .token(choices: [.keyword(.func)])
      ),
      Child(
        name: "name",
        deprecatedName: "identifier",
        kind: .token(choices: [
          .token(.identifier),
          .token(.binaryOperator),
          .token(.prefixOperator),
          .token(.postfixOperator),
        ]),
        documentation: "The name of the function. If the name matches a reserved keyword use backticks to escape it."
      ),
      Child(
        name: "genericParameterClause",
        kind: .node(kind: .genericParameterClause),
        nameForDiagnostics: "generic parameter clause",
        documentation: "The parameter clause that defines the generic parameters.",
        isOptional: true
      ),
      Child(
        name: "signature",
        kind: .node(kind: .functionSignature),
        nameForDiagnostics: "function signature"
      ),
      Child(
        name: "genericWhereClause",
        kind: .node(kind: .genericWhereClause),
        nameForDiagnostics: "generic where clause",
        documentation: "A `where` clause that places additional constraints on generic parameters like `where Element: Hashable`.",
        isOptional: true
      ),
      Child(
        name: "body",
        kind: .node(kind: .codeBlock),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .functionParameterList,
    base: .syntaxCollection,
    nameForDiagnostics: "parameter list",
    elementChoices: [.functionParameter]
  ),

  Node(
    kind: .functionParameter,
    base: .syntax,
    nameForDiagnostics: "parameter",
    parserFunction: "parseFunctionParameter",
    traits: ["WithTrailingComma", "WithAttributes", "WithModifiers"],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes"
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers"
      ),
      Child(
        name: "firstName",
        kind: .token(choices: [.token(.identifier), .token(.wildcard)])
      ),
      Child(
        name: "secondName",
        kind: .token(choices: [.token(.identifier), .token(.wildcard)], requiresLeadingSpace: true),
        nameForDiagnostics: "internal name",
        isOptional: true
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "type",
        kind: .node(kind: .type),
        nameForDiagnostics: "type"
      ),
      Child(
        name: "ellipsis",
        kind: .token(choices: [.token(.ellipsis)]),
        isOptional: true
      ),
      Child(
        name: "defaultValue",
        deprecatedName: "defaultArgument",
        kind: .node(kind: .initializerClause),
        nameForDiagnostics: "default value",
        isOptional: true
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .functionSignature,
    base: .syntax,
    nameForDiagnostics: "function signature",
    children: [
      Child(
        name: "parameterClause",
        deprecatedName: "input",
        kind: .node(kind: .functionParameterClause)
      ),
      Child(
        name: "effectSpecifiers",
        kind: .node(kind: .functionEffectSpecifiers),
        isOptional: true
      ),
      Child(
        name: "returnClause",
        deprecatedName: "output",
        kind: .node(kind: .returnClause),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .ifConfigClauseList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.ifConfigClause]
  ),

  Node(
    kind: .ifConfigClause,
    base: .syntax,
    nameForDiagnostics: "conditional compilation clause",
    children: [
      Child(
        name: "poundKeyword",
        kind: .token(choices: [.token(.poundIf), .token(.poundElseif), .token(.poundElse)])
      ),
      Child(
        name: "condition",
        kind: .node(kind: .expr),
        nameForDiagnostics: "condition",
        isOptional: true
      ),
      Child(
        name: "elements",
        kind: .nodeChoices(choices: [
          Child(
            name: "statements",
            kind: .node(kind: .codeBlockItemList)
          ),
          Child(
            name: "switchCases",
            kind: .node(kind: .switchCaseList)
          ),
          Child(
            name: "decls",
            kind: .node(kind: .memberBlockItemList)
          ),
          Child(
            name: "postfixExpression",
            kind: .node(kind: .expr)
          ),
          Child(
            name: "attributes",
            kind: .node(kind: .attributeList)
          ),
        ]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .ifConfigDecl,
    base: .decl,
    nameForDiagnostics: "conditional compilation block",
    children: [
      Child(
        name: "clauses",
        kind: .collection(kind: .ifConfigClauseList, collectionElementName: "Clause")
      ),
      Child(
        name: "poundEndif",
        kind: .token(choices: [.token(.poundEndif)])
      ),
    ]
  ),

  Node(
    kind: .importDecl,
    base: .decl,
    nameForDiagnostics: "import",
    documentation: """
      An `import` declaration

      An example of an import declaration is

      ```swift
      import Foundation
      ```
      """,
    traits: [
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes",
        documentation: "Attributes attached to the import declaration, for example `@testable`."
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers",
        documentation: "Modifiers that are attached to the import declaration. Currently, no modifiers are supported by Swift."
      ),
      Child(
        name: "importKeyword",
        deprecatedName: "importTok",
        kind: .token(choices: [.keyword(.import)]),
        documentation: "The `import` keyword for this declaration."
      ),
      Child(
        name: "importKindSpecifier",
        deprecatedName: "importKind",
        kind: .token(choices: [
          .keyword(.typealias),
          .keyword(.struct),
          .keyword(.class),
          .keyword(.enum),
          .keyword(.protocol),
          .keyword(.var),
          .keyword(.let),
          .keyword(.func),
          .keyword(.inout),
        ]),
        documentation: """
          The kind of declaration being imported. 

          A struct can be imported from a specific module.
          """,
        isOptional: true
      ),
      Child(
        name: "path",
        kind: .collection(kind: .importPathComponentList, collectionElementName: "PathComponent"),
        documentation: "The path to the module, submodule or symbol being imported."
      ),
    ]
  ),

  Node(
    kind: .inheritedTypeList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.inheritedType]
  ),

  Node(
    kind: .inheritedType,
    base: .syntax,
    nameForDiagnostics: "inherited type",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "type",
        deprecatedName: "typeName",
        kind: .node(kind: .type)
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .initializerClause,
    base: .syntax,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "equal",
        kind: .token(choices: [.token(.equal)])
      ),
      Child(
        name: "value",
        kind: .node(kind: .expr)
      ),
    ]
  ),

  Node(
    kind: .initializerDecl,
    base: .decl,
    nameForDiagnostics: "initializer",
    documentation: """
      An `init` declaration

      An example of an initializer is

      ```swift
      init(someParameter: Int) {
      }
      ```

      The body is optional because this node also represents initializer requirements inside protocols.
      """,
    traits: [
      "WithAttributes",
      "WithGenericParameters",
      "WithModifiers",
      "WithOptionalCodeBlock",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes",
        documentation: "Attributes that are attached to the initializer."
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers",
        documentation: "Modifiers that are attached to the initializer declaration."
      ),
      Child(
        name: "initKeyword",
        kind: .token(choices: [.keyword(.`init`)]),
        documentation: "The init keyword"
      ),
      Child(
        name: "optionalMark",
        kind: .token(choices: [
          .token(.postfixQuestionMark),
          .token(.exclamationMark),
        ]),
        documentation: "If the initializer is failable, a question mark to indicate that.",
        isOptional: true
      ),
      Child(
        name: "genericParameterClause",
        kind: .node(kind: .genericParameterClause),
        nameForDiagnostics: "generic parameter clause",
        documentation: "Generic parameters of the initializer.",
        isOptional: true
      ),
      Child(
        name: "signature",
        kind: .node(kind: .functionSignature),
        nameForDiagnostics: "function signature",
        documentation: "The arguments of the initializer. While the function signature allows specifying a return clause, doing so is not semantically valid."
      ),
      Child(
        name: "genericWhereClause",
        kind: .node(kind: .genericWhereClause),
        nameForDiagnostics: "generic where clause",
        documentation: "If the initializer had generic parameters, a where clause that can restrict those.",
        isOptional: true
      ),
      Child(
        name: "body",
        kind: .node(kind: .codeBlock),
        documentation: "The initializer’s body. Missing if the initializer is a requirement of a protocol declaration.",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .macroDecl,
    base: .decl,
    nameForDiagnostics: "macro",
    traits: [
      "NamedDecl",
      "WithAttributes",
      "WithGenericParameters",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes"
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers"
      ),
      Child(
        name: "macroKeyword",
        kind: .token(choices: [.keyword(.macro)])
      ),
      Child(
        name: "name",
        deprecatedName: "identifier",
        kind: .token(choices: [.token(.identifier)])
      ),
      Child(
        name: "genericParameterClause",
        kind: .node(kind: .genericParameterClause),
        nameForDiagnostics: "generic parameter clause",
        documentation: "The parameter clause that defines the generic parameters.",
        isOptional: true
      ),
      Child(
        name: "signature",
        kind: .node(kind: .functionSignature),
        nameForDiagnostics: "macro signature"
      ),
      Child(
        name: "definition",
        kind: .node(kind: .initializerClause),
        nameForDiagnostics: "macro definition",
        isOptional: true
      ),
      Child(
        name: "genericWhereClause",
        kind: .node(kind: .genericWhereClause),
        nameForDiagnostics: "generic where clause",
        documentation: "A `where` clause that places additional constraints on generic parameters like `where Element: Hashable`.",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .macroExpansionDecl,
    base: .decl,
    nameForDiagnostics: "macro expansion",
    documentation: "The expansion of a freestanding macro in a position that expects a declaration.",
    traits: [
      "FreestandingMacroExpansion",
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes"
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers"
      ),
      Child(
        name: "pound",
        deprecatedName: "poundToken",
        kind: .token(choices: [.token(.pound)]),
        documentation: "The `#` sign."
      ),
      Child(
        name: "macroName",
        deprecatedName: "macro",
        kind: .token(choices: [.token(.identifier)])
      ),
      Child(
        name: "genericArgumentClause",
        deprecatedName: "genericArguments",
        kind: .node(kind: .genericArgumentClause),
        isOptional: true
      ),
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)]),
        isOptional: true
      ),
      Child(
        name: "arguments",
        deprecatedName: "argumentList",
        kind: .collection(kind: .labeledExprList, collectionElementName: "Argument")
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)]),
        isOptional: true
      ),
      Child(
        name: "trailingClosure",
        kind: .node(kind: .closureExpr),
        isOptional: true
      ),
      Child(
        name: "additionalTrailingClosures",
        kind: .collection(kind: .multipleTrailingClosureElementList, collectionElementName: "AdditionalTrailingClosure", defaultsToEmpty: true)
      ),
    ]
  ),

  Node(
    kind: .memberBlock,
    base: .syntax,
    nameForDiagnostics: "member block",
    parserFunction: "parseMemberBlock",
    traits: ["Braced"],
    children: [
      Child(
        name: "leftBrace",
        kind: .token(choices: [.token(.leftBrace)])
      ),
      Child(
        name: "members",
        kind: .collection(kind: .memberBlockItemList, collectionElementName: "Member")
      ),
      Child(
        name: "rightBrace",
        kind: .token(choices: [.token(.rightBrace)])
      ),
    ]
  ),

  Node(
    kind: .memberBlockItem,
    base: .syntax,
    nameForDiagnostics: nil,
    documentation: "A member declaration of a type consisting of a declaration and an optional semicolon;",
    children: [
      Child(
        name: "decl",
        kind: .node(kind: .decl),
        documentation: "The declaration of the type member."
      ),
      Child(
        name: "semicolon",
        kind: .token(choices: [.token(.semicolon)]),
        documentation: "An optional trailing semicolon.",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .memberBlockItemList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.memberBlockItem]
  ),

  Node(
    kind: .declModifierList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.declModifier]
  ),

  Node(
    kind: .operatorDecl,
    base: .decl,
    nameForDiagnostics: "operator declaration",
    documentation: "A Swift `operator` declaration.",
    traits: [
      "NamedDecl"
    ],
    children: [
      Child(
        name: "fixitySpecifier",
        deprecatedName: "fixity",
        kind: .token(choices: [.keyword(.prefix), .keyword(.postfix), .keyword(.infix)]),
        nameForDiagnostics: "fixity",
        documentation: "The fixity applied to the 'operator' declaration."
      ),
      Child(
        name: "operatorKeyword",
        kind: .token(choices: [.keyword(.operator)])
      ),
      Child(
        name: "name",
        deprecatedName: "identifier",
        kind: .token(choices: [.token(.binaryOperator), .token(.prefixOperator), .token(.postfixOperator)])
      ),
      Child(
        name: "operatorPrecedenceAndTypes",
        kind: .node(kind: .operatorPrecedenceAndTypes),
        documentation: "Optionally specify a precedence group and designated types.",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .operatorPrecedenceAndTypes,
    base: .syntax,
    nameForDiagnostics: nil,
    documentation: "A clause to specify precedence group in infix operator declarations, and designated types in any operator declaration.",
    children: [
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "precedenceGroup",
        kind: .token(choices: [.token(.identifier)]),
        nameForDiagnostics: "precedence group",
        documentation: "The precedence group for this operator"
      ),
      Child(
        name: "designatedTypes",
        kind: .collection(kind: .designatedTypeList, collectionElementName: "DesignatedTypeElement"),
        documentation: "The designated types associated with this operator."
      ),
    ]
  ),

  Node(
    kind: .functionParameterClause,
    base: .syntax,
    nameForDiagnostics: "parameter clause",
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)])
      ),
      Child(
        name: "parameters",
        deprecatedName: "parameterList",
        kind: .collection(kind: .functionParameterList, collectionElementName: "Parameter"),
        nameForDiagnostics: "parameters"
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)])
      ),
    ]
  ),

  Node(
    kind: .patternBindingList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.patternBinding]
  ),

  Node(
    kind: .patternBinding,
    base: .syntax,
    nameForDiagnostics: nil,
    documentation: """
      Defines variables inside a variable declaration.
      """,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "pattern",
        kind: .node(kind: .pattern),
        documentation: """
          The pattern that defines the variables.

          In simple variable declarations this is an ``IdentifierPatternSyntax``, which defines
          the name of a single variable.

          In more complex variable declaration, this can, for example, be a ``TuplePatternSyntax``
          that destructures a tuple.

          ```swift
          let (x, y) = (1, 2)
          ```
          """
      ),
      Child(
        name: "typeAnnotation",
        kind: .node(kind: .typeAnnotation),
        nameForDiagnostics: "type annotation",
        documentation: """
          The type of the variables defined by the pattern.

          Can be omitted, in which case the variables’ types are inferred from the initializer.
          """,
        isOptional: true
      ),
      Child(
        name: "initializer",
        kind: .node(kind: .initializerClause),
        documentation: """
          If the variables have a default value, the clause that initializes them.
          """,
        isOptional: true
      ),
      Child(
        name: "accessorBlock",
        deprecatedName: "accessor",
        kind: .node(kind: .accessorBlock),
        documentation: """
          If the variable is computed, the accessors that get (and optionally set) the value.
          """,
        isOptional: true
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .poundSourceLocationArguments,
    base: .syntax,
    nameForDiagnostics: "'#sourceLocation' arguments",
    children: [
      Child(
        name: "fileLabel",
        deprecatedName: "fileArgLabel",
        kind: .token(choices: [.keyword(.file)])
      ),
      Child(
        name: "fileColon",
        deprecatedName: "fileArgColon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "fileName",
        kind: .node(kind: .simpleStringLiteralExpr),
        nameForDiagnostics: "file name"
      ),
      Child(
        name: "comma",
        kind: .token(choices: [.token(.comma)])
      ),
      Child(
        name: "lineLabel",
        deprecatedName: "lineArgLabel",
        kind: .token(choices: [.keyword(.line)])
      ),
      Child(
        name: "lineColon",
        deprecatedName: "lineArgColon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "lineNumber",
        kind: .token(choices: [.token(.integerLiteral)]),
        nameForDiagnostics: "line number"
      ),
    ]
  ),

  Node(
    kind: .poundSourceLocation,
    base: .decl,
    nameForDiagnostics: "'#sourceLocation' directive",
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "poundSourceLocation",
        kind: .token(choices: [.token(.poundSourceLocation)])
      ),
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)])
      ),
      Child(
        name: "arguments",
        deprecatedName: "args",
        kind: .node(kind: .poundSourceLocationArguments),
        nameForDiagnostics: "arguments",
        isOptional: true
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)])
      ),
    ]
  ),

  Node(
    kind: .precedenceGroupAssignment,
    base: .syntax,
    nameForDiagnostics: "'assignment' property of precedencegroup",
    documentation: "Specifies the precedence of an operator when used in an operation that includes optional chaining.",
    children: [
      Child(
        name: "assignmentLabel",
        deprecatedName: "assignmentKeyword",
        kind: .token(choices: [.keyword(.assignment)])
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "value",
        deprecatedName: "flag",
        kind: .token(choices: [.keyword(.true), .keyword(.false)]),
        documentation:
          "When true, an operator in the corresponding precedence group uses the same grouping rules during optional chaining as the assignment operators from the standard library. Otherwise, operators in the precedence group follows the same optional chaining rules as operators that don't perform assignment."
      ),
    ]
  ),

  Node(
    kind: .precedenceGroupAssociativity,
    base: .syntax,
    nameForDiagnostics: "'associativity' property of precedencegroup",
    documentation: "Specifies how a sequence of operators with the same precedence level are grouped together in the absence of grouping parentheses.",
    children: [
      Child(
        name: "associativityLabel",
        deprecatedName: "associativityKeyword",
        kind: .token(choices: [.keyword(.associativity)])
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "value",
        kind: .token(choices: [.keyword(.left), .keyword(.right), .keyword(.none)]),
        documentation:
          "Operators that are `left`-associative group left-to-right. Operators that are `right`-associative group right-to-left. Operators that are specified with an associativity of `none` don't associate at all"
      ),
    ]
  ),
  Node(
    kind: .precedenceGroupAttributeList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.precedenceGroupRelation, .precedenceGroupAssignment, .precedenceGroupAssociativity]
  ),

  Node(
    kind: .precedenceGroupDecl,
    base: .decl,
    nameForDiagnostics: "precedencegroup",
    documentation: "A Swift `precedencegroup` declaration.",
    traits: [
      "Braced",
      "NamedDecl",
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes",
        documentation: "The attributes applied to the 'precedencegroup' declaration."
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers",
        documentation: "The declaration modifiers applied to the 'precedencegroup' declaration."
      ),
      Child(
        name: "precedencegroupKeyword",
        kind: .token(choices: [.keyword(.precedencegroup)])
      ),
      Child(
        name: "name",
        deprecatedName: "identifier",
        kind: .token(choices: [.token(.identifier)]),
        documentation: "The name of this precedence group."
      ),
      Child(
        name: "leftBrace",
        kind: .token(choices: [.token(.leftBrace)])
      ),
      Child(
        name: "groupAttributes",
        kind: .collection(kind: .precedenceGroupAttributeList, collectionElementName: "GroupAttribute"),
        documentation: "The characteristics of this precedence group."
      ),
      Child(
        name: "rightBrace",
        kind: .token(choices: [.token(.rightBrace)])
      ),
    ]
  ),

  Node(
    kind: .precedenceGroupName,
    base: .syntax,
    nameForDiagnostics: nil,
    traits: ["WithTrailingComma"],
    children: [
      Child(
        name: "name",
        kind: .token(choices: [.token(.identifier)]),
        nameForDiagnostics: "name"
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .precedenceGroupNameList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.precedenceGroupName]
  ),

  Node(
    kind: .precedenceGroupRelation,
    base: .syntax,
    nameForDiagnostics: "'relation' property of precedencegroup",
    documentation: "Specify the new precedence group's relation to existing precedence groups.",
    children: [
      Child(
        name: "higherThanOrLowerThanLabel",
        deprecatedName: "higherThanOrLowerThan",
        kind: .token(choices: [.keyword(.higherThan), .keyword(.lowerThan)]),
        documentation: "The relation to specified other precedence groups."
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "precedenceGroups",
        deprecatedName: "otherNames",
        kind: .collection(kind: .precedenceGroupNameList, collectionElementName: "OtherName"),
        documentation: "The name of other precedence group to which this precedence group relates."
      ),
    ]
  ),

  Node(
    kind: .protocolDecl,
    base: .decl,
    nameForDiagnostics: "protocol",
    documentation: """
      A `protocol` declaration

      An example of a protocol declaration is

      ```swift
      protocol Example {
        var isValid: Bool { get }
      }
      ```
      """,
    traits: [
      "DeclGroup",
      "NamedDecl",
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes",
        documentation: "Attributes attached to the protocol declaration, such as an `@available` attribute."
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers",
        documentation: "Modifiers attached to the protocol declaration, such as `public`."
      ),
      Child(
        name: "protocolKeyword",
        kind: .token(choices: [.keyword(.protocol)]),
        documentation: "The `protocol` keyword for this declaration."
      ),
      Child(
        name: "name",
        deprecatedName: "identifier",
        kind: .token(choices: [.token(.identifier)]),
        documentation: "The name of the protocol."
      ),
      Child(
        name: "primaryAssociatedTypeClause",
        kind: .node(kind: .primaryAssociatedTypeClause),
        nameForDiagnostics: "primary associated type clause",
        documentation: "The primary associated type for the protocol.",
        isOptional: true
      ),
      Child(
        name: "inheritanceClause",
        kind: .node(kind: .inheritanceClause),
        nameForDiagnostics: "inheritance clause",
        documentation: "The inheritance clause describing one or more conformances for this protocol declaration.",
        isOptional: true
      ),
      Child(
        name: "genericWhereClause",
        kind: .node(kind: .genericWhereClause),
        nameForDiagnostics: "generic where clause",
        documentation: "The `where` clause that applies to the generic parameters of this protocol declaration.",
        isOptional: true
      ),
      Child(
        name: "memberBlock",
        kind: .node(kind: .memberBlock),
        documentation: "The members of the protocol declaration."
      ),
    ]
  ),

  Node(
    kind: .returnClause,
    base: .syntax,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "arrow",
        kind: .token(choices: [.token(.arrow)])
      ),
      Child(
        name: "type",
        deprecatedName: "returnType",
        kind: .node(kind: .type),
        nameForDiagnostics: "return type"
      ),
    ]
  ),

  Node(
    kind: .sourceFile,
    base: .syntax,
    nameForDiagnostics: "source file",
    parserFunction: "parseSourceFile",
    traits: ["WithStatements"],
    children: [
      Child(
        name: "shebang",
        kind: .token(choices: [.token(.shebang)]),
        documentation: "A shebang can specify the path of the compiler when using Swift source file as a script.",
        isOptional: true
      ),
      Child(
        name: "statements",
        kind: .collection(kind: .codeBlockItemList, collectionElementName: "Statement")
      ),
      Child(
        name: "endOfFileToken",
        deprecatedName: "eofToken",
        kind: .token(choices: [.token(.endOfFile)])
      ),
    ]
  ),

  Node(
    kind: .structDecl,
    base: .decl,
    nameForDiagnostics: "struct",
    documentation: """
      A `struct` declaration

      An example of a struct declaration is

      ```swift
      struct SomeStruct {
        let someMember: String
        var anotherMember: Int

        func foo() {
          print(someMember)
        }

        mutating func bar() {
          anotherMember = 42
        }
      }
      ```

      A struct declaration may be declared without any members.

      ```swift
      struct EmptyStruct {

      }
      ```

      A struct declaration may include a type inheritance clause listing
      one or more protocols the struct conforms to.

      The example below uses Hashable and Equatable protocols whose members
      are automatically synthesized by the compiler if the struct contains
      stored members that are themselves `Hashable` and `Equatable`.

      ```swift
      struct AdvancedStruct: Hashable, Equatable {
        let someMember: String
        var anotherMember: Int
      }
      ```

      A struct declaration may include a generic parameter clause as well
      as a generic where clause.

      ```swift
      struct Stack<Element> {
        var items: [Element] = []

        mutating func push(_ item: Element) {
          items.append(item)
        }

        mutating func pop() -> Element {
          return items.removeLast()
        }
      }
      ```
      """,
    traits: [
      "DeclGroup",
      "NamedDecl",
      "WithAttributes",
      "WithGenericParameters",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes",
        documentation: "Attributes that are attached to the struct declaration."
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers",
        documentation: "Modifiers like `public` that are attached to the struct declaration."
      ),
      Child(
        name: "structKeyword",
        kind: .token(choices: [.keyword(.struct)]),
        documentation: "The `struct` keyword for this declaration."
      ),
      Child(
        name: "name",
        deprecatedName: "identifier",
        kind: .token(choices: [.token(.identifier)]),
        documentation: "Declares the name of this struct. If the name matches a reserved keyword use backticks to escape it."
      ),
      Child(
        name: "genericParameterClause",
        kind: .node(kind: .genericParameterClause),
        nameForDiagnostics: "generic parameter clause",
        documentation: "The generic parameters, if any, of the struct declaration.",
        isOptional: true
      ),
      Child(
        name: "inheritanceClause",
        kind: .node(kind: .inheritanceClause),
        nameForDiagnostics: "inheritance clause",
        documentation: "The struct declaration inheritance clause describing one or more conformances for this struct declaration.",
        isOptional: true
      ),
      Child(
        name: "genericWhereClause",
        kind: .node(kind: .genericWhereClause),
        nameForDiagnostics: "generic where clause",
        documentation: "The `where` clause that applies to the generic parameters of this struct declaration.",
        isOptional: true
      ),
      Child(
        name: "memberBlock",
        kind: .node(kind: .memberBlock),
        documentation:
          "The members of the struct declaration. Because struct extension declarations may declare additional members the contents of this member block isn't guaranteed to be a complete list of members for this type."
      ),
    ]
  ),

  Node(
    kind: .subscriptDecl,
    base: .decl,
    nameForDiagnostics: "subscript",
    traits: [
      "WithAttributes",
      "WithGenericParameters",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes"
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers"
      ),
      Child(
        name: "subscriptKeyword",
        kind: .token(choices: [.keyword(.subscript)])
      ),
      Child(
        name: "genericParameterClause",
        kind: .node(kind: .genericParameterClause),
        nameForDiagnostics: "generic parameter clause",
        documentation: "The parameter clause that defines the generic parameters.",
        isOptional: true
      ),
      Child(
        name: "parameterClause",
        deprecatedName: "indices",
        kind: .node(kind: .functionParameterClause)
      ),
      Child(
        name: "returnClause",
        deprecatedName: "result",
        kind: .node(kind: .returnClause)
      ),
      Child(
        name: "genericWhereClause",
        kind: .node(kind: .genericWhereClause),
        nameForDiagnostics: "generic where clause",
        documentation: "A `where` clause that places additional constraints on generic parameters like `where Element: Hashable`.",
        isOptional: true
      ),
      Child(
        name: "accessorBlock",
        deprecatedName: "accessor",
        kind: .node(kind: .accessorBlock),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .inheritanceClause,
    base: .syntax,
    nameForDiagnostics: "inheritance clause",
    children: [
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "inheritedTypes",
        deprecatedName: "inheritedTypeCollection",
        kind: .collection(kind: .inheritedTypeList, collectionElementName: "InheritedType")
      ),
    ]
  ),

  Node(
    kind: .typeInitializerClause,
    base: .syntax,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "equal",
        kind: .token(choices: [.token(.equal)])
      ),
      Child(
        name: "value",
        kind: .node(kind: .type),
        nameForDiagnostics: "type"
      ),
    ]
  ),

  Node(
    kind: .typeAliasDecl,
    base: .decl,
    nameForDiagnostics: "typealias declaration",
    traits: [
      "NamedDecl",
      "WithAttributes",
      "WithGenericParameters",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes"
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers"
      ),
      Child(
        name: "typealiasKeyword",
        kind: .token(choices: [.keyword(.typealias)])
      ),
      Child(
        name: "name",
        deprecatedName: "identifier",
        kind: .token(choices: [.token(.identifier)])
      ),
      Child(
        name: "genericParameterClause",
        kind: .node(kind: .genericParameterClause),
        nameForDiagnostics: "generic parameter clause",
        documentation: "The parameter clause that defines the generic parameters.",
        isOptional: true
      ),
      Child(
        name: "initializer",
        kind: .node(kind: .typeInitializerClause)
      ),
      Child(
        name: "genericWhereClause",
        kind: .node(kind: .genericWhereClause),
        nameForDiagnostics: "generic where clause",
        documentation: "A `where` clause that places additional constraints on generic parameters like `where Element: Hashable`.",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .variableDecl,
    base: .decl,
    nameForDiagnostics: "variable",
    documentation: """
      Declaration of one or more variables

      The core of a variable declaration consists of a binding specifier (`let` or `var`),
      followed by any number of pattern bindings, which define the variables.
      """,
    traits: [
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes"
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers",
        documentation: "Modifiers modifiers applied to the variable declaration."
      ),
      Child(
        name: "bindingSpecifier",
        deprecatedName: "bindingKeyword",
        kind: .token(choices: [
          .keyword(.let), .keyword(.var), .keyword(.inout),
          .keyword(._mutating), .keyword(._borrowing), .keyword(._consuming),
        ]),
        documentation: """
          The specifier that defines the type of the variables declared (`let` or `var`).
          """
      ),
      Child(
        name: "bindings",
        kind: .collection(kind: .patternBindingList, collectionElementName: "Binding"),
        documentation: """
          The pattern bindings that define the actual variables.

          The pattern bindings contain the declared variables’ names, their types,
          initializers and accessors.

          A variable declaration can contain multiple pattern bindings, because it’s possible
          to define multiple variables after a single `let` keyword, for example

          ```swift
          let x: Int = 1, y: Int = 2
          ```
          """
      ),
    ]
  ),
]
