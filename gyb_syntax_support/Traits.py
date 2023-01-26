from .Child import Child


class Trait(object):
    def __init__(self, trait_name, description=None, children=None):
        self.trait_name = trait_name
        self.children = children
        self.description = description


TRAITS = [
    Trait('Attributed',
          children=[
              Child('Attributes', kind='AttributeList', is_optional=True),
          ]),

    Trait('DeclGroup',
          children=[
              Child('Attributes', kind='AttributeList', is_optional=True),
              Child('Modifiers', kind='ModifierList', is_optional=True),
              Child('Members', kind='MemberDeclBlock'),
          ]),

    Trait('Braced',
          children=[
              Child('LeftBrace', kind='LeftBraceToken'),
              Child('RightBrace', kind='RightBraceToken'),
          ]),

    Trait('IdentifiedDecl',
          children=[
              Child('Identifier', kind='IdentifierToken'),
          ]),

    Trait('WithCodeBlock',
          children=[
              Child('Body', kind='CodeBlock'),
          ]),

    Trait('Parenthesized',
          children=[
              Child('LeftParen', kind='LeftParenToken'),
              Child('RightParen', kind='RightParenToken'),
          ]),

    Trait('FreestandingMacroExpansion',
          children=[
             Child('PoundToken', kind='PoundToken'),
             Child('Macro', kind='IdentifierToken'),
             Child('GenericArguments', kind='GenericArgumentClause',
                   is_optional=True),
             Child('LeftParen', kind='LeftParenToken',
                   is_optional=True),
             Child('ArgumentList', kind='TupleExprElementList',
                   collection_element_name='Argument'),
             Child('RightParen', kind='RightParenToken',
                   is_optional=True),
             Child('TrailingClosure', kind='ClosureExpr',
                   is_optional=True),
             Child('AdditionalTrailingClosures',
                   kind='MultipleTrailingClosureElementList',
                   collection_element_name='AdditionalTrailingClosure',
                   is_optional=True),
          ]),

    Trait('WithTrailingComma',
          children=[
              Child('TrailingComma', kind='CommaToken', is_optional=True),
          ]),

    Trait('WithStatements',
          children=[
              Child('Statements', kind='CodeBlockItemList'),
          ]),
    Trait('EffectSpecifiers',
          children=[
             Child('UnexpectedBeforeAsyncSpecifier', kind='UnexpectedNodes', is_optional=True),
             Child('AsyncSpecifier', kind='KeywordToken', is_optional=True),
             Child('UnexpectedBetweenAsyncSpecifierAndThrowsSpecifier', kind='UnexpectedNodes', is_optional=True),
             Child('ThrowsSpecifier', kind='KeywordToken', is_optional=True),
             Child('UnexpectedAfterThrowsSpecifier', kind='UnexpectedNodes', is_optional=True),
          ]),
]
