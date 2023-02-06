from .Child import Child
from .Node import Node  # noqa: I201

ATTRIBUTE_NODES = [
    # attribute -> '@' identifier '('?
    #              ( identifier
    #                | string-literal
    #                | integer-literal
    #                | availability-spec-list
    #                | specialize-attr-spec-list
    #                | implements-attr-arguments
    #                | named-attribute-string-argument
    #                | back-deploy-attr-spec-list
    #              )? ')'?
    Node('Attribute', name_for_diagnostics='attribute', kind='Syntax',
         description='''
         An `@` attribute.
         ''',
         parser_function='parseAttribute',
         children=[
             Child('AtSignToken', kind='AtSignToken',
                   description='The `@` sign.'),
             Child('AttributeName', kind='Type', name_for_diagnostics='name',
                   classification='Attribute',
                   description='The name of the attribute.'),
             Child('LeftParen', kind='LeftParenToken', is_optional=True,
                   description='''
                   If the attribute takes arguments, the opening parenthesis.
                   '''),
             Child('Argument', kind='Syntax', is_optional=True,
                   node_choices=[
                       Child('ArgumentList', kind='TupleExprElementList'),
                       Child('Token', kind='Token'),
                       Child('String', kind='StringLiteralExpr'),
                       Child('Availability', kind='AvailabilitySpecList'),
                       Child('SpecializeArguments',
                             kind='SpecializeAttributeSpecList'),
                       Child('ObjCName', kind='ObjCSelector'),
                       Child('ImplementsArguments',
                             kind='ImplementsAttributeArguments'),
                       Child('DifferentiableArguments',
                             kind='DifferentiableAttributeArguments'),
                       Child('DerivativeRegistrationArguments',
                             kind='DerivativeRegistrationAttributeArguments'),
                       Child('BackDeployedArguments',
                             kind='BackDeployedAttributeSpecList'),
                       Child('ConventionArguments',
                             kind='ConventionAttributeArguments'),
                       Child('ConventionWitnessMethodArguments',
                             kind='ConventionWitnessMethodAttributeArguments'), 
                       Child('OpaqueReturnTypeOfAttributeArguments',
                             kind='OpaqueReturnTypeOfAttributeArguments'),
                       Child('ExposeAttributeArguments',
                             kind='ExposeAttributeArguments'),
                       Child('OriginallyDefinedInArguments',
                             kind='OriginallyDefinedInArguments'),
                       Child('UnderscorePrivateAttributeArguments',
                             kind='UnderscorePrivateAttributeArguments'),
                       Child('DynamicReplacementArguments',
                             kind='DynamicReplacementArguments'),
                       Child('UnavailableFromAsyncArguments',
                             kind='UnavailableFromAsyncArguments'),
                       Child('EffectsArguments',
                             kind='EffectsArguments'),
                       Child('DocumentationArguments',
                             kind='DocumentationAttributeArguments')
                   ], description='''
                   The arguments of the attribute. In case the attribute
                   takes multiple arguments, they are gather in the
                   appropriate takes first.
                   '''),
             Child('RightParen', kind='RightParenToken', is_optional=True,
                   description='''
                   If the attribute takes arguments, the closing parenthesis.
                   ''')
         ]),

    # attribute-list -> attribute attribute-list?
    Node('AttributeList', name_for_diagnostics='attributes', kind='SyntaxCollection',
         omit_when_empty=True,
         element='Syntax', element_name='Attribute',
         element_choices=[
             'Attribute',
             'IfConfigDecl',
         ]),

    # The argument of '@_specialize(...)'
    # specialize-attr-spec-list -> labeled-specialize-entry
    #                                  specialize-spec-attr-list?
    #                            | generic-where-clause
    #                                  specialize-spec-attr-list?
    Node('SpecializeAttributeSpecList',
         name_for_diagnostics="argument to '@_specialize", kind='SyntaxCollection',
         description='''
         A collection of arguments for the `@_specialize` attribute
         ''',
         element='Syntax', element_name='SpecializeAttribute',
         element_choices=[
             'LabeledSpecializeEntry',
             'AvailabilityEntry',
             'TargetFunctionEntry',
             'GenericWhereClause',
         ]),

    Node('AvailabilityEntry', name_for_diagnostics='availability entry', kind='Syntax',
         description='''
         The availability argument for the _specialize attribute
         ''',
         children=[
             Child('Label', kind='KeywordToken', token_choices=['KeywordToken|availability'], name_for_diagnostics='label',
                   description='The label of the argument'),
             Child('Colon', kind='ColonToken',
                   description='The colon separating the label and the value'),
             Child('AvailabilityList', kind='AvailabilitySpecList',
                   collection_element_name='Availability'),
             Child('Semicolon', kind='SemicolonToken'),
         ]),

    # Representation of e.g. 'exported: true,'
    # labeled-specialize-entry -> identifier ':' token ','?
    Node('LabeledSpecializeEntry', kind='Syntax',
         name_for_diagnostics='attribute argument',
         description='''
         A labeled argument for the `@_specialize` attribute like
         `exported: true`
         ''',
         traits=['WithTrailingComma'],
         children=[
             Child('Label', kind='Token', name_for_diagnostics='label',
                   token_choices=['KeywordToken|available', 'KeywordToken|exported', 'KeywordToken|kind', 'KeywordToken|spi', 'KeywordToken|spiModule', 'IdentifierToken'],
                   description='The label of the argument'),
             Child('Colon', kind='ColonToken',
                   description='The colon separating the label and the value'),
             Child('Value', kind='Token', name_for_diagnostics='value',
                   description='The value for this argument'),
             Child('TrailingComma', kind='CommaToken',
                   is_optional=True, description='''
                   A trailing comma if this argument is followed by another one
                   '''),
         ]),
    # Representation of e.g. 'exported: true,'
    # labeled-specialize-entry -> identifier ':' token ','?
    Node('TargetFunctionEntry', kind='Syntax',
         name_for_diagnostics='attribute argument',
         description='''
         A labeled argument for the `@_specialize` attribute with a function
         decl value like
         `target: myFunc(_:)`
         ''',
         traits=['WithTrailingComma'],
         children=[
             Child('Label', kind='KeywordToken', token_choices=['KeywordToken|target'], name_for_diagnostics='label',
                   description='The label of the argument'),
             Child('Colon', kind='ColonToken',
                   description='The colon separating the label and the value'),
             Child('Declname', kind='DeclName', name_for_diagnostics='declaration name',
                   description='The value for this argument'),
             Child('TrailingComma', kind='CommaToken',
                   is_optional=True, description='''
                   A trailing comma if this argument is followed by another one
                   '''),
         ]),

    Node('DeclName', name_for_diagnostics='declaration name', kind='Syntax', children=[
         Child('DeclBaseName', kind='Token', name_for_diagnostics='base name', 
               token_choices=['IdentifierToken', 'PrefixOperatorToken', 'KeywordToken|init'],
               description='''
               The base name of the protocol\'s requirement.
               '''),
         Child('DeclNameArguments', kind='DeclNameArguments', name_for_diagnostics='arguments',
               is_optional=True, description='''
               The argument labels of the protocol\'s requirement if it
               is a function requirement.
               '''),
         ]),
    # The argument of '@_implements(...)'
    # implements-attr-arguments -> simple-type-identifier ','
    #                              (identifier | operator) decl-name-arguments
    Node('ImplementsAttributeArguments', name_for_diagnostics='@_implements arguemnts',
         kind='Syntax',
         description='''
         The arguments for the `@_implements` attribute of the form
         `Type, methodName(arg1Label:arg2Label:)`
         ''',
         children=[
             Child('Type', kind='Type', name_for_diagnostics='type', description='''
                   The type for which the method with this attribute
                   implements a requirement.
                   '''),
             Child('Comma', kind='CommaToken',
                   description='''
                   The comma separating the type and method name
                   '''),
             Child('DeclBaseName', kind='Token', name_for_diagnostics='declaration base name', description='''
                   The base name of the protocol\'s requirement.
                   '''),
             Child('DeclNameArguments', name_for_diagnostics='declaration name arguments', kind='DeclNameArguments',
                   is_optional=True, description='''
                   The argument labels of the protocol\'s requirement if it
                   is a function requirement.
                   '''),
         ]),

    # objc-selector-piece -> identifier? ':'?
    Node('ObjCSelectorPiece', name_for_diagnostics='Objective-C selector piece',
         kind='Syntax',
         description='''
         A piece of an Objective-C selector. Either consisting of just an
         identifier for a nullary selector, an identifier and a colon for a
         labeled argument or just a colon for an unlabeled argument
         ''',
         children=[
             Child('Name', kind='IdentifierToken', name_for_diagnostics='name', is_optional=True),
             Child('Colon', kind='ColonToken', is_optional=True),
         ]),

    # objc-selector -> objc-selector-piece objc-selector?
    Node('ObjCSelector', name_for_diagnostics='Objective-C selector',
         kind='SyntaxCollection', element='ObjCSelectorPiece'),

    # The argument of '@differentiable(...)'.
    # differentiable-attr-arguments ->
    #     differentiability-kind? '.'? differentiability-params-clause? ','?
    #     generic-where-clause?
    Node('DifferentiableAttributeArguments',
         name_for_diagnostics="'@differentiable' arguments", kind='Syntax',
         description='''
         The arguments for the `@differentiable` attribute: an optional
         differentiability kind, an optional differentiability parameter clause,
         and an optional 'where' clause.
         ''',
         children=[
             Child('DiffKind', kind='KeywordToken',
                   token_choices=['KeywordToken|forward', 'KeywordToken|reverse', 'KeywordToken|linear'],
                   is_optional=True),
             Child('DiffKindComma', kind='CommaToken', description='''
                   The comma following the differentiability kind, if it exists.
                   ''', is_optional=True),
             Child('DiffParams', kind='DifferentiabilityParamsClause',
                   is_optional=True),
             Child('DiffParamsComma', kind='CommaToken', description='''
                   The comma following the differentiability parameters clause,
                   if it exists.
                   ''', is_optional=True),
             Child('WhereClause', kind='GenericWhereClause', is_optional=True),
         ]),

    # differentiability-params-clause ->
    #     'wrt' ':' (differentiability-param | differentiability-params)
    Node('DifferentiabilityParamsClause',
         name_for_diagnostics="'@differentiable' argument", kind='Syntax',
         description='A clause containing differentiability parameters.',
         children=[
             Child('WrtLabel', kind='KeywordToken',
                   token_choices=['KeywordToken|wrt'], description='The "wrt" label.'),
             Child('Colon', kind='ColonToken', description='''
                   The colon separating "wrt" and the parameter list.
                   '''),
             Child('Parameters', kind='Syntax', name_for_diagnostics='parameters',
                   node_choices=[
                       Child('Parameter', kind='DifferentiabilityParam'),
                       Child('ParameterList', kind='DifferentiabilityParams'),
                   ]),
         ]),

    # differentiability-params -> '(' differentiability-param-list ')'
    Node('DifferentiabilityParams', name_for_diagnostics='differentiability parameters',
         kind='Syntax',
         description='The differentiability parameters.',
         children=[
             Child('LeftParen', kind='LeftParenToken'),
             Child('DiffParams', kind='DifferentiabilityParamList',
                   collection_element_name='DifferentiabilityParam',
                   description='The parameters for differentiation.'),
             Child('RightParen', kind='RightParenToken'),
         ]),

    # differentiability-param-list ->
    #     differentiability-param differentiability-param-list?
    Node('DifferentiabilityParamList',
         name_for_diagnostics='differentiability parameters', kind='SyntaxCollection',
         element='DifferentiabilityParam'),

    # differentiability-param -> ('self' | identifier | integer-literal) ','?
    Node('DifferentiabilityParam', name_for_diagnostics='differentiability parameter',
         kind='Syntax',
         description='''
         A differentiability parameter: either the "self" identifier, a function
         parameter name, or a function parameter index.
         ''',
         traits=['WithTrailingComma'],
         children=[
             Child('Parameter', kind='Token', token_choices=['IdentifierToken', 'IntegerLiteralToken', 'KeywordToken']),
             Child('TrailingComma', kind='CommaToken', is_optional=True),
         ]),

    # The argument of the derivative registration attribute
    # '@derivative(of: ...)' and the transpose registration attribute
    # '@transpose(of: ...)'.
    #
    # derivative-registration-attr-arguments ->
    #     'of' ':' func-decl-name ','? differentiability-params-clause?
    Node('DerivativeRegistrationAttributeArguments',
         name_for_diagnostics='attribute arguments',
         kind='Syntax',
         description='''
         The arguments for the '@derivative(of:)' and '@transpose(of:)'
         attributes: the 'of:' label, the original declaration name, and an
         optional differentiability parameter list.
         ''',
         children=[
             Child('OfLabel', kind='KeywordToken', token_choices=['KeywordToken|of'],
                   description='The "of" label.'),
             Child('Colon', kind='ColonToken', description='''
                   The colon separating the "of" label and the original
                   declaration name.
                   '''),
             Child('OriginalDeclName', kind='QualifiedDeclName',
                   description='The referenced original declaration name.'),
             Child('Period', kind='PeriodToken',
                   description='''
                   The period separating the original declaration name and the
                   accessor name.
                   ''', is_optional=True),
             Child('AccessorKind', kind='KeywordToken',
                   description='The accessor name.',
                   token_choices=['KeywordToken|get', 'KeywordToken|set'],
                   is_optional=True),
             Child('Comma', kind='CommaToken', is_optional=True),
             Child('DiffParams', kind='DifferentiabilityParamsClause',
                   is_optional=True),
         ]),

    # An optionally qualified declaration name.
    # Currently used only for `@derivative` and `@transpose` attribute.
    # TODO(TF-1066): Use module qualified name syntax/parsing instead of custom
    # qualified name syntax/parsing.
    #
    # qualified-decl-name ->
    #     base-type? '.'? (identifier | operator) decl-name-arguments?
    # base-type ->
    #     member-type-identifier | base-type-identifier
    Node('QualifiedDeclName', kind='Syntax',
         name_for_diagnostics='declaration name',
         description='''
         An optionally qualified function declaration name (e.g. `+(_:_:)`,
         `A.B.C.foo(_:_:)`).
         ''',
         children=[
             Child('BaseType', kind='Type', name_for_diagnostics='base type', description='''
                   The base type of the qualified name, optionally specified.
                   ''', is_optional=True),
             Child('Dot', kind='PeriodToken', is_optional=True),
             Child('Name', kind='Token', name_for_diagnostics='base name', description='''
                   The base name of the referenced function.
                   ''',
                   token_choices=[
                       'IdentifierToken',
                       'BinaryOperatorToken',
                       'PrefixOperatorToken',
                       'PostfixOperatorToken',
                   ]),
             Child('Arguments', name_for_diagnostics='arguments', kind='DeclNameArguments',
                   is_optional=True, description='''
                   The argument labels of the referenced function, optionally
                   specified.
                   '''),
         ]),

    # The arguments of '@backDeployed(...)'
    # back-deployed-attr-spec-list -> 'before' ':' back-deployed-version-list
    Node('BackDeployedAttributeSpecList', kind='Syntax',
         name_for_diagnostics="'@backDeployed' arguments",
         description='''
         A collection of arguments for the `@backDeployed` attribute
         ''',
         children=[
             Child('BeforeLabel', kind='KeywordToken',
                   token_choices=['KeywordToken|before'], description='The "before" label.'),
             Child('Colon', kind='ColonToken', description='''
                   The colon separating "before" and the parameter list.
                   '''),
             Child('VersionList', kind='AvailabilityVersionRestrictionList',
                   collection_element_name='Availability', description='''
                   The list of OS versions in which the declaration became ABI
                   stable.
                   '''),
         ]),

    # back-deploy-version-list ->
    #   back-deploy-version-entry back-deploy-version-list?
    Node('AvailabilityVersionRestrictionList', name_for_diagnostics='version list',
         kind='SyntaxCollection', element='AvailabilityVersionRestrictionListEntry'),

    # back-deploy-version-entry -> availability-version-restriction ','?
    Node('AvailabilityVersionRestrictionListEntry', name_for_diagnostics='version', kind='Syntax',
         description='''
         A single platform/version pair in an attribute, e.g. `iOS 10.1`.
         ''',
         children=[
             Child('AvailabilityVersionRestriction',
                   kind='AvailabilityVersionRestriction',
                   classification='Keyword'),
             Child('TrailingComma', kind='CommaToken', is_optional=True,
                   description='''
                   A trailing comma if the argument is followed by another
                   argument
                   '''),
         ]),
    # opaque-return-type-of-arguments -> string-literal ',' integer-literal
    Node('OpaqueReturnTypeOfAttributeArguments',
         name_for_diagnostics='opaque return type arguments',
         kind='Syntax',
         description='''
         The arguments for the '@_opaqueReturnTypeOf()'.
         ''',
         children=[
             Child('MangledName', kind='StringLiteralExpr',
                   description='The mangled name of a declaration.'),
             Child('Comma', kind='CommaToken'),
             Child('Ordinal', kind='IntegerLiteralToken',
                   description="The ordinal corresponding to the 'some' keyword that introduced this opaque type."),
        ]),

    # convention-attribute-arguments -> token ',' 'cType'? ':' string-literal
    Node('ConventionAttributeArguments',
         name_for_diagnostics='@convention(...) arguments',
         kind='Syntax',
         description='''
         The arguments for the '@convention(...)'.
         ''',
         children=[
             Child('ConventionLabel', kind='IdentifierToken',
                   description='The convention label.'),
             Child('Comma', kind='CommaToken', is_optional=True),
             Child('CTypeLabel', kind='KeywordToken',
                   token_choices=['KeywordToken|cType'], is_optional=True),
             Child('Colon', kind='ColonToken', is_optional=True),
             Child('CTypeString', kind='StringLiteralExpr', is_optional=True),
        ]),

    # convention-attribute-arguments -> 'witness_method' ':' identifier
    Node('ConventionWitnessMethodAttributeArguments',
         name_for_diagnostics='@convention(...) arguments for witness methods',
         kind='Syntax',
         description='''
         The arguments for the '@convention(witness_method: ...)'.
         ''',
         children=[
             Child('WitnessMethodLabel', kind='KeywordToken', token_choices=['KeywordToken|witness_method']),
             Child('Colon', kind='ColonToken'),
             Child('ProtocolName', kind='IdentifierToken'),
        ]),

    Node('ExposeAttributeArguments', name_for_diagnostics='@_expose arguments',
         kind='Syntax',
         description='''
         The arguments for the '@_expose' attribute
         ''',
         children=[
           Child('Language', kind='Token'),
           Child('Comma', kind='CommaToken', is_optional=True),
           Child('CxxName', kind='StringLiteralExpr', is_optional=True)
         ]),

    Node('OriginallyDefinedInArguments', name_for_diagnostics='@_originallyDefinedIn arguments',
         kind='Syntax',
         description='''
         The arguments for the '@_originallyDefinedIn' attribute
         ''',
         children=[
           Child('ModuleLabel', kind='KeywordToken', token_choices=['KeywordToken|module']),
           Child('Colon', kind='ColonToken'),
           Child('ModuleName', kind='StringLiteralExpr'),
           Child('Comma', kind='CommaToken'),
           Child('Platforms', kind='AvailabilityVersionRestrictionList', collection_element_name='Platform')
         ]),

    Node('UnderscorePrivateAttributeArguments', name_for_diagnostics='@_private argument',
         kind='Syntax',
         description='''
         The arguments for the '@_private' attribute
         ''',
         children=[
           Child('SourceFileLabel', kind='KeywordToken', token_choices=['KeywordToken|sourceFile']),
           Child('Colon', kind='ColonToken'),
           Child('Filename', kind='StringLiteralExpr'),
         ]),

    Node('DynamicReplacementArguments', name_for_diagnostics='@_dynamicReplacement argument',
         kind='Syntax',
         description='''
         The arguments for the '@_dynamicReplacement' attribute
         ''',
         children=[
           Child('ForLabel', kind='KeywordToken', token_choices=['KeywordToken|for'],
                 requires_trailing_space=False),
           Child('Colon', kind='ColonToken'),
           Child('Declname', kind='DeclName'),
         ]),

    Node('UnavailableFromAsyncArguments', name_for_diagnostics='@_unavailableFromAsync argument',
         kind='Syntax',
         description='''
         The arguments for the '@_unavailableFromAsync' attribute
         ''',
         children=[
           Child('MessageLabel', kind='KeywordToken', token_choices=['KeywordToken|message']),
           Child('Colon', kind='ColonToken'),
           Child('Message', kind='StringLiteralExpr'),
         ]),

    Node('EffectsArguments', name_for_diagnostics='@_effects arguments', kind='SyntaxCollection',
         description='''
         The arguments of the '@_effect' attribute. These will be parsed during the SIL stage.
         ''',
         element='Token'),

    Node('DocumentationAttributeArgument', name_for_diagnostics='@_documentation argument', kind='Syntax',
         traits=['WithTrailingComma'],
         children=[
            Child('Label', kind='KeywordToken', token_choices=['KeywordToken|visibility', 'KeywordToken|metadata'], name_for_diagnostics='label'),
            Child('Colon', kind='ColonToken'),
            Child('Value', kind='Syntax', node_choices=[
                  Child('Token', kind='Token', token_choices=['IdentifierToken', 'KeywordToken']), # Keywords can be: public, internal, private, fileprivate, open
                  Child('String', kind='StringLiteralExpr')
                  ]),
            Child('TrailingComma', kind='CommaToken',
                   is_optional=True, description='''
                   A trailing comma if this argument is followed by another one
                   '''),
         ]),

    Node('DocumentationAttributeArguments', name_for_diagnostics='@_documentation arguments', kind='SyntaxCollection',
        description='''
         The arguments of the '@_documentation' attribute
         ''',
         element='DocumentationAttributeArgument'),
]
