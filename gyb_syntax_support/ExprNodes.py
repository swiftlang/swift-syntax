from .Child import Child
from .Node import Node  # noqa: I201

EXPR_NODES = [
    # An inout expression.
    # &x
    Node('InOutExpr', name_for_diagnostics='inout expression', kind='Expr',
         children=[
             Child('Ampersand', kind='PrefixAmpersandToken'),
             Child('Expression', kind='Expr'),
         ]),

    Node('TupleExprElementList', name_for_diagnostics=None, kind='SyntaxCollection',
         element='TupleExprElement'),

    Node('ArrayElementList', name_for_diagnostics=None, kind='SyntaxCollection',
         element='ArrayElement'),

    Node('DictionaryElementList', name_for_diagnostics=None, kind='SyntaxCollection',
         element='DictionaryElement'),

    Node('StringLiteralSegments', name_for_diagnostics=None, kind='SyntaxCollection',
         element='Syntax', element_name='Segment',
         element_choices=['StringSegment', 'ExpressionSegment']),

    # The try operator.
    # try foo()
    # try? foo()
    # try! foo()
    Node('TryExpr', name_for_diagnostics="'try' expression", kind='Expr',
         children=[
             Child('TryKeyword', kind='KeywordToken', token_choices=['KeywordToken|try']),
             Child('QuestionOrExclamationMark', kind='Token',
                   is_optional=True,
                   token_choices=[
                       'PostfixQuestionMarkToken',
                       'ExclamationMarkToken',
                   ],
                   requires_trailing_space=True),
             Child('Expression', kind='Expr'),
         ]),

    # The await operator.
    # await foo()
    Node('AwaitExpr', name_for_diagnostics="'await' expression", kind='Expr',
         children=[
             Child('AwaitKeyword', kind='KeywordToken',
                   token_choices=['KeywordToken|await']),
             Child('Expression', kind='Expr'),
         ]),

    # The move expr
    Node('MoveExpr', name_for_diagnostics="'_move' expression", kind='Expr',
         children=[
             Child('MoveKeyword', kind='KeywordToken',
                   token_choices=['KeywordToken|_move']),
             Child('Expression', kind='Expr'),
         ]),

    # The borrow expr
    Node('BorrowExpr', name_for_diagnostics="'_borrow' expression", kind='Expr',
         children=[
             Child('BorrowKeyword', kind='KeywordToken',
                   token_choices=['KeywordToken|_borrow']),
             Child('Expression', kind='Expr'),
         ]),

    # declname-arguments -> '(' declname-argument-list ')'
    # declname-argument-list -> declname-argument*
    # declname-argument -> identifier ':'
    Node('DeclNameArgument', name_for_diagnostics=None, kind='Syntax',
         children=[
             Child('Name', kind='Token'),
             Child('Colon', kind='ColonToken', requires_trailing_space=False),
         ]),
    Node('DeclNameArgumentList', name_for_diagnostics=None, kind='SyntaxCollection',
         element='DeclNameArgument'),
    Node('DeclNameArguments', name_for_diagnostics=None, kind='Syntax',
         traits=['Parenthesized'],
         children=[
             Child('LeftParen', kind='LeftParenToken'),
             Child('Arguments', kind='DeclNameArgumentList',
                   collection_element_name='Argument'),
             Child('RightParen', kind='RightParenToken'),
         ]),

    # An identifier expression.
    Node('IdentifierExpr', name_for_diagnostics=None, kind='Expr',
         children=[
             Child('Identifier', kind='Token',
                   token_choices=[
                       'IdentifierToken',
                       'KeywordToken',
                       'DollarIdentifierToken',
                       'BinaryOperatorToken',
                   ]),
             Child('DeclNameArguments', kind='DeclNameArguments',
                   is_optional=True),
         ]),

    # An 'super' expression.
    Node('SuperRefExpr', name_for_diagnostics=None, kind='Expr',
         children=[
             Child('SuperKeyword', kind='KeywordToken', token_choices=['KeywordToken|super']),
         ]),

    # A nil expression.
    Node('NilLiteralExpr', name_for_diagnostics=None, kind='Expr',
         children=[
             Child('NilKeyword', kind='KeywordToken', token_choices=['KeywordToken|nil']),
         ]),

    # A _ expression.
    Node('DiscardAssignmentExpr', name_for_diagnostics=None, kind='Expr',
         children=[
             Child('Wildcard', kind='WildcardToken'),
         ]),

    # An = expression.
    Node('AssignmentExpr', name_for_diagnostics=None, kind='Expr',
         children=[
             Child('AssignToken', kind='EqualToken'),
         ]),

    # A pack expansion expr spelled with 'repeat'.
    Node('PackExpansionExpr', name_for_diagnostics=None, kind='Expr',
         children=[
             Child('RepeatKeyword', kind='KeywordToken', token_choices=['KeywordToken|repeat']),
             Child('PatternExpr', kind='Expr'),
         ]),

    # A pack element expr spelled with 'each'.
    Node('PackElementExpr', name_for_diagnostics=None, kind='Expr',
         children=[
             Child('EachKeyword', kind='KeywordToken',
                   token_choices=['KeywordToken|each']),
             Child('PackRefExpr', kind='Expr'),
         ]),

    # A flat list of expressions before sequence folding, e.g. 1 + 2 + 3.
    Node('SequenceExpr', name_for_diagnostics=None, kind='Expr',
         children=[
             Child('Elements', kind='ExprList',
                   collection_element_name='Element'),
         ]),

    Node('ExprList', name_for_diagnostics=None, kind='SyntaxCollection',
         element='Expr',
         element_name='Expression',
         description='''
         A list of expressions connected by operators. This list is contained
         by a `SequenceExprSyntax`.
         '''),

    # A prefix operator expression.
    # -x
    # !true
    Node('PrefixOperatorExpr', name_for_diagnostics='operator',
         kind='Expr',
         children=[
             Child('OperatorToken', kind='PrefixOperatorToken',
                   is_optional=True),
             Child('PostfixExpression', kind='Expr'),
         ]),

    # An operator like + or -.
    # NOTE: This appears only in SequenceExpr.
    Node('BinaryOperatorExpr', name_for_diagnostics='operator',
         kind='Expr',
         children=[
             Child('OperatorToken', kind='BinaryOperatorToken'),
         ]),

    # arrow-expr -> 'async'? 'throws'? '->'
    # NOTE: This appears only in SequenceExpr.
    Node('ArrowExpr', name_for_diagnostics=None, kind='Expr',
         children=[
             Child('EffectSpecifiers', kind='TypeEffectSpecifiers', is_optional=True),
             Child('ArrowToken', kind='ArrowToken'),
         ]),

    # An infix binary expression like x + y.
    # NOTE: This won't come directly out of the parser. Rather, it is the
    # result of "folding" a SequenceExpr based on knowing the precedence
    # relationships amongst the different infix operators.
    Node('InfixOperatorExpr', name_for_diagnostics=None, kind='Expr',
         children=[
             Child('LeftOperand', kind='Expr'),
             Child('OperatorOperand', kind='Expr'),
             Child('RightOperand', kind='Expr'),
         ]),

    # A floating-point literal
    # 4.0
    # -3.9
    # +4e20
    Node('FloatLiteralExpr', name_for_diagnostics='floating literal', kind='Expr',
         children=[
             Child('FloatingDigits', kind='FloatingLiteralToken'),
         ]),

    Node('TupleExpr', name_for_diagnostics='tuple', kind='Expr',
         traits=['Parenthesized'],
         children=[
             Child('LeftParen', kind='LeftParenToken'),
             Child('ElementList', kind='TupleExprElementList',
                   collection_element_name='Element', is_indented=True),
             Child('RightParen', kind='RightParenToken'),
         ]),

    # Array literal, e.g. [1, 2, 3]
    Node('ArrayExpr', name_for_diagnostics='array', kind='Expr',
         children=[
             Child('LeftSquare', kind='LeftSquareBracketToken'),
             Child('Elements', kind='ArrayElementList',
                   collection_element_name='Element', is_indented=True),
             Child('RightSquare', kind='RightSquareBracketToken'),
         ]),

    # Dictionary literal, e.g. [1:1, 2:2, 3:3]
    Node('DictionaryExpr', name_for_diagnostics='dictionary', kind='Expr',
         children=[
             Child('LeftSquare', kind='LeftSquareBracketToken'),
             Child('Content', kind='Syntax',
                   node_choices=[
                       Child('Colon', kind='ColonToken', requires_trailing_space=False),
                       Child('Elements', kind='DictionaryElementList'),
                   ], is_indented=True),
             Child('RightSquare', kind='RightSquareBracketToken'),
         ]),

    # An element inside a tuple element list
    Node('TupleExprElement', name_for_diagnostics=None, kind='Syntax',
         traits=['WithTrailingComma'],
         children=[
             Child('Label', kind='Token', name_for_diagnostics='label',
                   is_optional=True,
                   token_choices=[
                       'IdentifierToken',
                       'WildcardToken'
                   ]),
             Child('Colon', kind='ColonToken',
                   is_optional=True),
             Child('Expression', kind='Expr', name_for_diagnostics='value'),
             Child('TrailingComma', kind='CommaToken',
                   is_optional=True),
         ]),

    # element inside an array expression: expression ','?
    Node('ArrayElement', name_for_diagnostics='array element', kind='Syntax',
         traits=['WithTrailingComma'],
         children=[
             Child('Expression', kind='Expr', name_for_diagnostics='value'),
             Child('TrailingComma', kind='CommaToken', is_optional=True),
         ]),

    # element inside an array expression: expression ','?
    Node('DictionaryElement', name_for_diagnostics='dictionary element', kind='Syntax',
         traits=['WithTrailingComma'],
         children=[
             Child('KeyExpression', kind='Expr', name_for_diagnostics='key'),
             Child('Colon', kind='ColonToken'),
             Child('ValueExpression', kind='Expr', name_for_diagnostics='value', is_indented=True),
             Child('TrailingComma', kind='CommaToken', is_optional=True),
         ]),

    # An integer literal.
    # 3
    # +3_400
    # +0x4f
    Node('IntegerLiteralExpr', name_for_diagnostics='integer literal', kind='Expr',
         children=[
             Child('Digits', kind='IntegerLiteralToken'),
         ]),

    # true or false
    Node('BooleanLiteralExpr', name_for_diagnostics='bool literal', kind='Expr',
         children=[
             Child("BooleanLiteral", kind='KeywordToken', token_choices=['KeywordToken|true', 'KeywordToken|false'])
         ]),

    # if-expr -> identifier? ':'? 'if' condition-list code-block
    #   else-clause ';'?
    #
    # This node represents both an 'if' expression, as well as an 'if' statement
    # when wrapped in a ExpressionStmt node.
    Node('IfExpr', name_for_diagnostics="'if' statement", kind='Expr',
         traits=['WithCodeBlock'],
         children=[
              Child('IfKeyword', kind='KeywordToken', token_choices=['KeywordToken|if']),
             Child('Conditions', kind='ConditionElementList',
                   collection_element_name='Condition'),
             Child('Body', kind='CodeBlock', name_for_diagnostics='body'),
             Child('ElseKeyword', kind='ElseToken',
                   is_optional=True),
             Child('ElseBody', kind='Syntax', name_for_diagnostics='else body',
                   node_choices=[
                       Child('IfExpr', kind='IfExpr'),
                       Child('CodeBlock', kind='CodeBlock'),
                   ],
                   is_optional=True),
         ]),

    # switch-expr -> identifier? ':'? 'switch' expr '{'
    #   switch-case-list '}' ';'?
    #
    # This node represents both a 'switch' expression, as well as a 'switch'
    # statement when wrapped in a ExpressionStmt node.
    Node('SwitchExpr', name_for_diagnostics="'switch' statement", kind='Expr',
         traits=['Braced'],
         children=[
             Child('SwitchKeyword', kind='KeywordToken', token_choices=['KeywordToken|switch']),
             Child('Expression', kind='Expr'),
             Child('LeftBrace', kind='LeftBraceToken'),
             Child('Cases', kind='SwitchCaseList',
                   collection_element_name='Case'),
             Child('RightBrace', kind='RightBraceToken',
                   requires_leading_newline=True),
         ]),

    # switch-case-list -> switch-case switch-case-list?
    Node('SwitchCaseList', name_for_diagnostics=None, kind='SyntaxCollection',
         element='Syntax', element_name='SwitchCase',
         element_choices=['SwitchCase', 'IfConfigDecl'],
         elements_separated_by_newline=True),

    # switch-case -> unknown-attr? switch-case-label stmt-list
    #              | unknown-attr? switch-default-label stmt-list
    Node('SwitchCase', name_for_diagnostics='switch case', kind='Syntax',
         traits=['WithStatements'],
         parser_function='parseSwitchCase',
         children=[
             Child('UnknownAttr', kind='Attribute', is_optional=True),
             Child('Label', kind='Syntax', name_for_diagnostics='label',
                   node_choices=[
                       Child('Default', kind='SwitchDefaultLabel'),
                       Child('Case', kind='SwitchCaseLabel'),
                   ]),
             Child('Statements', kind='CodeBlockItemList',
                   collection_element_name='Statement',
                   is_indented=True),
         ]),

    # switch-case-label -> 'case' case-item-list ':'
    Node('SwitchCaseLabel', name_for_diagnostics=None, kind='Syntax',
         children=[
             Child('CaseKeyword', kind='KeywordToken', token_choices=['KeywordToken|case']),
             Child('CaseItems', kind='CaseItemList',
                   collection_element_name='CaseItem'),
             Child('Colon', kind='ColonToken', requires_trailing_space=False),
         ]),

    # switch-default-label -> 'default' ':'
    Node('SwitchDefaultLabel', name_for_diagnostics=None, kind='Syntax',
         children=[
             Child('DefaultKeyword', kind='KeywordToken', token_choices=['KeywordToken|default']),
             Child('Colon', kind='ColonToken', requires_trailing_space=False),
         ]),

    # case-item -> pattern where-clause? ','?
    Node('CaseItem', name_for_diagnostics=None, kind='Syntax',
         traits=['WithTrailingComma'],
         children=[
             Child('Pattern', kind='Pattern'),
             Child('WhereClause', kind='WhereClause',
                   is_optional=True),
             Child('TrailingComma', kind='CommaToken',
                   is_optional=True),
         ]),

    # ? expr :
    # Ternary expression without the condition and the second choice.
    # NOTE: This appears only in SequenceExpr.
    Node('UnresolvedTernaryExpr', name_for_diagnostics='ternary operator', kind='Expr',
         children=[
             Child("QuestionMark", kind='InfixQuestionMarkToken'),
             Child("FirstChoice", kind='Expr'),
             Child("ColonMark", kind='ColonToken'),
         ]),


    # a ? 1 : 0
    # NOTE: This won't come directly out of the parser. Rather, it is the
    # result of "folding" a SequenceExpr based on knowing the precedence
    # relationships amongst the different infix operators.
    Node('TernaryExpr', name_for_diagnostics='ternay expression', kind='Expr',
         children=[
             Child("ConditionExpression", kind='Expr', name_for_diagnostics='condition'),
             Child("QuestionMark", kind='InfixQuestionMarkToken'),
             Child("FirstChoice", kind='Expr', name_for_diagnostics='first choice'),
             Child("ColonMark", kind='ColonToken'),
             Child("SecondChoice", kind='Expr', name_for_diagnostics='second choice')
         ]),

    # expr?.name
    Node('MemberAccessExpr', name_for_diagnostics='member access', kind='Expr',
         children=[
             # The base needs to be optional to parse expressions in key paths
             # like \.a
             Child("Base", kind='Expr',  name_for_diagnostics='base', is_optional=True),
             Child("Dot", kind='PeriodToken'),
             # Name could be 'self'
             Child("Name", kind='Token', name_for_diagnostics='name'),
             Child('DeclNameArguments', kind='DeclNameArguments',
                   is_optional=True),
         ]),

    # 'is'
    # "is" type casting ooperator without operands.
    # NOTE: This appears only in SequenceExpr.
    Node('UnresolvedIsExpr', name_for_diagnostics="'is'", kind='Expr',
         children=[
             Child("IsTok", kind='KeywordToken', token_choices=['KeywordToken|is']),
         ]),

    # expression is TypeName
    # NOTE: This won't come directly out of the parser. Rather, it is the
    # result of "folding" a SequenceExpr based on knowing the precedence
    # relationships amongst the different infix operators.
    Node('IsExpr', name_for_diagnostics="'is'", kind='Expr',
         children=[
             Child("Expression", kind="Expr"),
             Child("IsTok", kind='KeywordToken', token_choices=['KeywordToken|is']),
             Child("TypeName", kind='Type')
         ]),

    # 'as' ('?'|'!')
    # "as" type casting ooperator without operands.
    # NOTE: This appears only in SequenceExpr.
    Node('UnresolvedAsExpr', name_for_diagnostics="'as'", kind='Expr',
         children=[
             Child("AsTok", kind='KeywordToken', token_choices=['KeywordToken|as']),
             Child("QuestionOrExclamationMark", kind='Token',
                   is_optional=True,
                   token_choices=[
                       'PostfixQuestionMarkToken',
                       'ExclamationMarkToken',
                   ]),
         ]),

    # expression as TypeName
    # NOTE: This won't come directly out of the parser. Rather, it is the
    # result of "folding" a SequenceExpr based on knowing the precedence
    # relationships amongst the different infix operators.
    Node('AsExpr', name_for_diagnostics="'as'", kind='Expr',
         children=[
             Child("Expression", kind="Expr"),
             Child("AsTok", kind='KeywordToken', token_choices=['KeywordToken|as']),
             Child("QuestionOrExclamationMark", kind='Token',
                   is_optional=True,
                   token_choices=[
                       'PostfixQuestionMarkToken',
                       'ExclamationMarkToken',
                   ]),
             Child("TypeName", kind='Type')
         ]),

    # Type
    Node('TypeExpr', name_for_diagnostics=None, kind='Expr',
         children=[
             Child('Type', kind='Type'),
         ]),

    Node('ClosureCaptureItemSpecifier', name_for_diagnostics='closure capture specifier', kind='Syntax',
         children=[
             Child('Specifier', kind='KeywordToken', token_choices=['KeywordToken|weak', 'KeywordToken|unowned']),
             Child('LeftParen', kind='LeftParenToken', is_optional=True),
             Child('Detail', kind='KeywordToken', is_optional=True, token_choices=['KeywordToken|safe', 'KeywordToken|unsafe']),
             Child('RightParen', kind='RightParenToken', is_optional=True),
         ]),

    Node('ClosureCaptureItem', name_for_diagnostics='closure capture item',
         kind='Syntax',
         traits=['WithTrailingComma'],
         children=[
             Child('Specifier', kind='ClosureCaptureItemSpecifier', is_optional=True),
             Child("Name", kind='IdentifierToken', is_optional=True),
             Child('AssignToken', kind='EqualToken', is_optional=True),
             Child("Expression", kind='Expr'),
             Child('TrailingComma', kind='CommaToken', is_optional=True),
         ]),

    Node('ClosureCaptureItemList', name_for_diagnostics=None, kind='SyntaxCollection',
         element='ClosureCaptureItem'),

    Node('ClosureCaptureSignature', name_for_diagnostics='closure capture signature',
         kind='Syntax',
         children=[
             Child('LeftSquare', kind='LeftSquareBracketToken'),
             Child('Items', kind='ClosureCaptureItemList',
                   collection_element_name='Item', is_optional=True),
             Child('RightSquare', kind='RightSquareBracketToken'),
         ]),

    Node('ClosureParam', name_for_diagnostics='closure parameter', kind='Syntax',
         traits=['WithTrailingComma'],
         children=[
             Child('Name', kind='Token', name_for_diagnostics='name',
                   token_choices=[
                       'IdentifierToken',
                       'WildcardToken',
                   ]),
             Child('TrailingComma', kind='CommaToken', is_optional=True),
         ]),

    # a, b, c
    Node('ClosureParamList', name_for_diagnostics=None, kind='SyntaxCollection',
         element='ClosureParam'),

    Node('ClosureSignature', name_for_diagnostics='closure signature', kind='Syntax',
         traits=['Attributed'],
         children=[
             Child('Attributes', kind='AttributeList', name_for_diagnostics='attributes',
                   collection_element_name='Attribute', is_optional=True),
             Child('Capture', kind='ClosureCaptureSignature',
                   is_optional=True),
             Child('Input', kind='Syntax', is_optional=True,
                   node_choices=[
                       Child('SimpleInput', kind='ClosureParamList'),
                       Child('Input', kind='ParameterClause'),
                   ]),
             Child('EffectSpecifiers', kind='TypeEffectSpecifiers',
                   is_optional=True),
             Child('Output', kind='ReturnClause', is_optional=True),
             Child('InTok', kind='KeywordToken', token_choices=['KeywordToken|in']),
         ]),

    Node('ClosureExpr', name_for_diagnostics='closure', kind='Expr',
         traits=['Braced', 'WithStatements'],
         children=[
             Child('LeftBrace', kind='LeftBraceToken'),
             Child('Signature', kind='ClosureSignature', is_optional=True),
             Child('Statements', kind='CodeBlockItemList',
                   collection_element_name='Statement', is_indented=True),
             Child('RightBrace', kind='RightBraceToken',
                   requires_leading_newline=True),
         ]),

    # unresolved-pattern-expr -> pattern
    Node('UnresolvedPatternExpr', name_for_diagnostics=None, kind='Expr',
         children=[
             Child('Pattern', kind='Pattern'),
         ]),

    # trailing-closure-element -> identifier ':' closure-expression
    Node('MultipleTrailingClosureElement', name_for_diagnostics='trailing closure',
         kind='Syntax',
         children=[
             Child('Label', kind='Token', name_for_diagnostics='label',
                   token_choices=[
                       'IdentifierToken',
                       'WildcardToken'
                   ]),
             Child('Colon', kind='ColonToken'),
             Child('Closure', kind='ClosureExpr'),
         ]),

    Node('MultipleTrailingClosureElementList', name_for_diagnostics=None,
         kind='SyntaxCollection', element='MultipleTrailingClosureElement'),

    # call-expr -> expr '(' call-argument-list ')' closure-expr?
    #            | expr closure-expr
    Node('FunctionCallExpr', name_for_diagnostics='function call', kind='Expr',
         children=[
             Child('CalledExpression', kind='Expr', name_for_diagnostics='called expression'),
             Child('LeftParen', kind='LeftParenToken',
                   is_optional=True),
             Child('ArgumentList', kind='TupleExprElementList', name_for_diagnostics='arguments',
                   collection_element_name='Argument', is_indented=True),
             Child('RightParen', kind='RightParenToken',
                   is_optional=True),
             Child('TrailingClosure', kind='ClosureExpr', name_for_diagnostics='trailing closure',
                   is_optional=True),
             Child('AdditionalTrailingClosures', name_for_diagnostics='trailing closures',
                   kind='MultipleTrailingClosureElementList',
                   collection_element_name='AdditionalTrailingClosure',
                   is_optional=True),
         ]),

    # subscript-expr -> expr '[' call-argument-list ']' closure-expr?
    Node('SubscriptExpr', name_for_diagnostics='subscript', kind='Expr',
         children=[
             Child('CalledExpression', kind='Expr', name_for_diagnostics='called expression'),
             Child('LeftBracket', kind='LeftSquareBracketToken'),
             Child('ArgumentList', kind='TupleExprElementList', name_for_diagnostics='arguments',
                   collection_element_name='Argument'),
             Child('RightBracket', kind='RightSquareBracketToken'),
             Child('TrailingClosure', kind='ClosureExpr', name_for_diagnostics='trailing closure',
                   is_optional=True),
             Child('AdditionalTrailingClosures', name_for_diagnostics='trailing closures',
                   kind='MultipleTrailingClosureElementList',
                   collection_element_name='AdditionalTrailingClosure',
                   is_optional=True),
         ]),

    # optional-chaining-expr -> expr '?'
    Node('OptionalChainingExpr', name_for_diagnostics='optional chaining', kind='Expr',
         children=[
             Child('Expression', kind='Expr'),
             Child('QuestionMark', kind='PostfixQuestionMarkToken'),
         ]),

    # forced-value-expr -> expr '!'
    Node('ForcedValueExpr', name_for_diagnostics='force unwrap', kind='Expr',
         children=[
             Child('Expression', kind='Expr'),
             Child('ExclamationMark', kind='ExclamationMarkToken'),
         ]),

    # postfix-unary-expr -> expr postfix-operator
    Node('PostfixUnaryExpr', name_for_diagnostics='postfix expression', kind='Expr',
         children=[
             Child('Expression', kind='Expr'),
             Child('OperatorToken', kind='PostfixOperatorToken'),
         ]),

    # specialize-expr -> expr generic-argument-clause?
    Node('SpecializeExpr', name_for_diagnostics=None, kind='Expr',
         children=[
             Child('Expression', kind='Expr'),
             Child('GenericArgumentClause', kind='GenericArgumentClause'),
         ]),

    # string literal segment in a string interpolation expression.
    Node('StringSegment', name_for_diagnostics=None, kind='Syntax',
         children=[
             Child('Content', kind='StringSegmentToken'),
         ]),

    # expression segment in a string interpolation expression.
    Node('ExpressionSegment', name_for_diagnostics=None, kind='Syntax',
         traits=['Parenthesized'],
         children=[
             Child('Backslash', kind='BackslashToken'),
             Child('Delimiter', kind='RawStringDelimiterToken',
                   is_optional=True),
             Child('LeftParen', kind='LeftParenToken',
                   classification='StringInterpolationAnchor',
                   force_classification=True),
             Child('Expressions', kind='TupleExprElementList',
                   collection_element_name='Expression'),
             Child('RightParen', kind='RightParenToken',
                   classification='StringInterpolationAnchor',
                   force_classification=True),
         ]),

    # e.g. "abc \(foo()) def"
    Node('StringLiteralExpr', name_for_diagnostics='string literal', kind='Expr',
         children=[
             Child('OpenDelimiter', kind='RawStringDelimiterToken',
                   is_optional=True),
             Child('OpenQuote', kind='Token',
                   token_choices=[
                       'StringQuoteToken',
                       'MultilineStringQuoteToken',
                       'SingleQuoteToken',
                   ]),
             Child('Segments', kind='StringLiteralSegments',
                   collection_element_name='Segment'),
             Child('CloseQuote', kind='Token',
                   token_choices=[
                       'StringQuoteToken',
                       'MultilineStringQuoteToken',
                       'SingleQuoteToken',
                   ]),
             Child('CloseDelimiter', kind='RawStringDelimiterToken',
                   is_optional=True),
         ]),

    # e.g '(a|c)*', the contents of the literal is opaque to the C++ Swift
    # parser though.
    Node('RegexLiteralExpr', name_for_diagnostics='regex literal', kind='Expr',
         children=[
             Child('Regex', kind='RegexLiteralToken'),
         ]),

    # e.g. "\a.b[2].a"
    Node('KeyPathExpr', name_for_diagnostics='key path', kind='Expr',
         children=[
             Child('Backslash', kind='BackslashToken'),
             Child('Root', kind='Type', name_for_diagnostics='root', is_optional=True),
             Child('Components', kind='KeyPathComponentList',
                   collection_element_name='KeyPathComponent'),
         ]),

    # The components of a key path
    Node('KeyPathComponentList', name_for_diagnostics=None,
         kind='SyntaxCollection', element='KeyPathComponent'),

    # A single key path component.
    Node('KeyPathComponent', name_for_diagnostics='key path component',
         kind='Syntax',
         children=[
             Child('Period', kind='PeriodToken',
                   is_optional=True),

             Child('Component', kind='Syntax', node_choices=[
               Child('Property', kind='KeyPathPropertyComponent'),
               Child('Subscript', kind='KeyPathSubscriptComponent'),
               Child('Optional', kind='KeyPathOptionalComponent'),
             ])
         ]),

    # A key path component like .property or .1.
    Node('KeyPathPropertyComponent', name_for_diagnostics='key path property component', kind='Syntax',
         children=[
             Child('Identifier', kind='Token',
                   token_choices=[
                       'IdentifierToken',
                       'KeywordToken',
                       'DollarIdentifierToken',
                       'BinaryOperatorToken',
                       'IntegerLiteralToken',
                   ]),
             Child('DeclNameArguments', kind='DeclNameArguments',
                   is_optional=True),
             Child('GenericArgumentClause', kind='GenericArgumentClause',
                   is_optional=True),

         ]),

    # A key path component like .[17]
    Node('KeyPathSubscriptComponent', name_for_diagnostics='key path subscript component', kind='Syntax',
         children=[
             Child('LeftBracket', kind='LeftSquareBracketToken'),
             Child('ArgumentList', kind='TupleExprElementList', name_for_diagnostics='arguments',
                   collection_element_name='Argument'),
             Child('RightBracket', kind='RightSquareBracketToken'),
         ]),

    # A key path component like '?' or '!'.
    Node('KeyPathOptionalComponent', name_for_diagnostics='key path optional component', kind='Syntax',
         children=[
             Child("QuestionOrExclamationMark", kind='Token',
                   token_choices=[
                       'PostfixQuestionMarkToken',
                       'ExclamationMarkToken',
                   ]),
         ]),

    # e.g., "#embed("filename.txt")"
    Node('MacroExpansionExpr',
         name_for_diagnostics="macro expansion", kind='Expr',
         traits=['FreestandingMacroExpansion'],
         children=[
             Child('PoundToken', kind='PoundToken',
                   description='The `#` sign.'),
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

    # postfix '#if' expression
    Node('PostfixIfConfigExpr', name_for_diagnostics=None, kind='Expr',
         children=[
             Child('Base', kind='Expr', is_optional=True),
             Child('Config', kind='IfConfigDecl'),
         ]),

    # <#content#>
    Node('EditorPlaceholderExpr', name_for_diagnostics='editor placeholder',
         kind='Expr',
         children=[
             Child('Identifier', kind='IdentifierToken'),
         ]),

    Node('YieldExprList', name_for_diagnostics='yield list',
         kind='SyntaxCollection',
         element='YieldExprListElement',
         element_name='Yields'),
    Node('YieldExprListElement', name_for_diagnostics=None, kind='Syntax',
     children=[
         Child('Expression', kind='Expr'),
         Child('Comma', kind='CommaToken', is_optional=True),
     ]),
]
