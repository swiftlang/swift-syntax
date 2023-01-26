from .Child import Child
from .Node import Node  # noqa: I201

STMT_NODES = [
    # labeled-stmt -> label ':' stmt
    Node('LabeledStmt', name_for_diagnostics='labeled statement', kind='Stmt',
         children=[
             Child('LabelName', kind='IdentifierToken', name_for_diagnostics='label name'),
             Child('LabelColon', kind='ColonToken'),
             Child('Statement', kind='Stmt'),
         ]),

    # continue-stmt -> 'continue' label? ';'?
    Node('ContinueStmt', name_for_diagnostics="'continue' statement", kind='Stmt',
         children=[
             Child('ContinueKeyword', kind='KeywordToken', text_choices=['continue']),
             Child('Label', kind='IdentifierToken', name_for_diagnostics='label',
                   is_optional=True),
         ]),

    # while-stmt -> label? ':'? 'while' condition-list code-block ';'?
    Node('WhileStmt', name_for_diagnostics="'while' statement", kind='Stmt',
         traits=['WithCodeBlock'],
         children=[
             Child('WhileKeyword', kind='KeywordToken', text_choices=['while']),
             Child('Conditions', kind='ConditionElementList',
                   collection_element_name='Condition'),
             Child('Body', kind='CodeBlock'),
         ]),

    # defer-stmt -> 'defer' code-block ';'?
    Node('DeferStmt', name_for_diagnostics="'defer' statement", kind='Stmt',
         traits=['WithCodeBlock'],
         children=[
             Child('DeferKeyword', kind='KeywordToken', text_choices=['defer']),
             Child('Body', kind='CodeBlock'),
         ]),

    # switch-case-list -> switch-case switch-case-list?
    Node('SwitchCaseList', name_for_diagnostics=None, kind='SyntaxCollection',
         element='Syntax', element_name='SwitchCase',
         element_choices=['SwitchCase', 'IfConfigDecl'],
         elements_separated_by_newline=True),

    # repeat-while-stmt -> label? ':'? 'repeat' code-block 'while' expr ';'?
    Node('RepeatWhileStmt', name_for_diagnostics="'repeat' statement", kind='Stmt',
         traits=['WithCodeBlock'],
         children=[
             Child('RepeatKeyword', kind='KeywordToken', text_choices=['repeat']),
             Child('Body', kind='CodeBlock', name_for_diagnostics='body'),
             Child('WhileKeyword', kind='KeywordToken', text_choices=['while']),
             Child('Condition', kind='Expr', name_for_diagnostics='condition'),
         ]),

    # guard-stmt -> 'guard' condition-list 'else' code-block ';'?
    Node('GuardStmt', name_for_diagnostics="'guard' statement", kind='Stmt',
         traits=['WithCodeBlock'],
         children=[
             Child('GuardKeyword', kind='KeywordToken', text_choices=['guard']),
             Child('Conditions', kind='ConditionElementList', name_for_diagnostics='condition',
                   collection_element_name='Condition'),
             Child('ElseKeyword', kind='KeywordToken', text_choices=['else']),
             Child('Body', kind='CodeBlock', name_for_diagnostics='body'),
         ]),

    Node('WhereClause', name_for_diagnostics="'where' clause", kind='Syntax',
         children=[
             Child('WhereKeyword', kind='KeywordToken', text_choices=['where']),
             Child('GuardResult', kind='Expr'),
         ]),

    # for-in-stmt -> label? ':'?
    #   'for' 'try'? 'await'? 'case'? pattern 'in' expr 'where'?
    #   expr code-block ';'?
    Node('ForInStmt', name_for_diagnostics="'for' statement", kind='Stmt',
         traits=['WithCodeBlock'],
         children=[
             Child('ForKeyword', kind='KeywordToken', text_choices=['for']),
             Child('TryKeyword', kind='TryToken',
                   is_optional=True),
             Child('AwaitKeyword', kind='IdentifierToken',
                   classification='Keyword',
                   text_choices=['await'], is_optional=True),
             Child('CaseKeyword', kind='CaseToken',
                   is_optional=True),
             Child('Pattern', kind='Pattern'),
             Child('TypeAnnotation', kind='TypeAnnotation',
                   is_optional=True),
             Child('InKeyword', kind='KeywordToken', text_choices=['in']),
             Child('SequenceExpr', kind='Expr'),
             Child('WhereClause', kind='WhereClause',
                   is_optional=True),
             Child('Body', kind='CodeBlock', name_for_diagnostics='body'),
         ]),

    # switch-stmt -> identifier? ':'? 'switch' expr '{'
    #   switch-case-list '}' ';'?
    Node('SwitchStmt', name_for_diagnostics="'switch' statement", kind='Stmt',
         traits=['Braced'],
         children=[
             Child('SwitchKeyword', kind='KeywordToken', text_choices=['switch']),
             Child('Expression', kind='Expr'),
             Child('LeftBrace', kind='LeftBraceToken'),
             Child('Cases', kind='SwitchCaseList',
                   collection_element_name='Case'),
             Child('RightBrace', kind='RightBraceToken',
                   requires_leading_newline=True),
         ]),

    # catch-clause-list -> catch-clause catch-clause-list?
    Node('CatchClauseList', name_for_diagnostics="'catch' clause",
         kind='SyntaxCollection', element='CatchClause'),

    # do-stmt -> identifier? ':'? 'do' code-block catch-clause-list ';'?
    Node('DoStmt', name_for_diagnostics="'do' statement", kind='Stmt',
         traits=['WithCodeBlock'],
         children=[
             Child('DoKeyword', kind='KeywordToken', text_choices=['do']),
             Child('Body', kind='CodeBlock', name_for_diagnostics='body',),
             Child('CatchClauses', kind='CatchClauseList',
                   collection_element_name='CatchClause', is_optional=True),
         ]),

    # return-stmt -> 'return' expr? ';'?
    Node('ReturnStmt', name_for_diagnostics="'return' statement", kind='Stmt',
         children=[
             Child('ReturnKeyword', kind='KeywordToken', text_choices=['return']),
             Child('Expression', kind='Expr',
                   is_optional=True),
         ]),

    # yield-stmt -> 'yield' '('? expr-list? ')'?
    Node('YieldStmt', name_for_diagnostics="'yield' statement", kind='Stmt',
         children=[
             Child('YieldKeyword', kind='KeywordToken', text_choices=['yield']),
             Child('Yields', kind='Syntax',
                   node_choices=[
                       Child('YieldList', kind='YieldList'),
                       Child('SimpleYield', kind='Expr'),
                   ]),
         ]),

    Node('YieldList', name_for_diagnostics=None, kind='Syntax',
         children=[
             Child('LeftParen', kind='LeftParenToken'),
             Child('ElementList', kind='YieldExprList',
                   collection_element_name='Element'),
             Child('RightParen', kind='RightParenToken'),
         ]),

    # fallthrough-stmt -> 'fallthrough' ';'?
    Node('FallthroughStmt', name_for_diagnostics="'fallthrough' statement", kind='Stmt',
         children=[
             Child('FallthroughKeyword', kind='KeywordToken', text_choices=['fallthrough']),
         ]),

    # break-stmt -> 'break' identifier? ';'?
    Node('BreakStmt', name_for_diagnostics="'break' statement", kind='Stmt',
         children=[
             Child('BreakKeyword', kind='KeywordToken', text_choices=['break']),
             Child('Label', kind='IdentifierToken', name_for_diagnostics='label',
                   is_optional=True),
         ]),

    # case-item-list -> case-item case-item-list?
    Node('CaseItemList', name_for_diagnostics=None, kind='SyntaxCollection',
         element='CaseItem'),

    # catch-item-list -> catch-item catch-item-list?
    Node('CatchItemList', name_for_diagnostics=None, kind='SyntaxCollection',
         element='CatchItem'),

    # condition -> expression
    #            | availability-condition
    #            | case-condition
    #            | optional-binding-condition
    Node('ConditionElement', name_for_diagnostics=None, kind='Syntax',
         traits=['WithTrailingComma'],
         children=[
             Child('Condition', kind='Syntax',
                   node_choices=[
                       Child('Expression', kind='Expr'),
                       Child('Availability', kind='AvailabilityCondition'),
                       Child('MatchingPattern',
                             kind='MatchingPatternCondition'),
                       Child('OptionalBinding',
                             kind='OptionalBindingCondition'),
                   ]),
             Child('TrailingComma', kind='CommaToken',
                   is_optional=True),
         ]),

    # availability-condition -> '#available' '(' availability-spec ')'
    Node('AvailabilityCondition', name_for_diagnostics="availability condition",
         kind='Syntax',
         children=[
             Child('AvailabilityKeyword', kind='Token', token_choices=['PoundAvailableToken', 'PoundUnavailableToken']),
             Child('LeftParen', kind='LeftParenToken'),
             Child('AvailabilitySpec', kind='AvailabilitySpecList',
                   collection_element_name='AvailabilityArgument'),
             Child('RightParen', kind='RightParenToken'),
         ]),
    Node('MatchingPatternCondition', kind='Syntax',
         name_for_diagnostics='pattern matching',
         children=[
             Child('CaseKeyword', kind='KeywordToken', text_choices=['case']),
             Child('Pattern', kind='Pattern'),
             Child('TypeAnnotation', kind='TypeAnnotation',
                   is_optional=True),
             Child('Initializer', kind='InitializerClause'),
         ]),
    Node('OptionalBindingCondition', name_for_diagnostics="optional binding",
         kind='Syntax',
         children=[
             Child('LetOrVarKeyword', kind='KeywordToken',
                   text_choices=['let', 'var']),
             Child('Pattern', kind='Pattern'),
             Child('TypeAnnotation', kind='TypeAnnotation',
                   is_optional=True),
             Child('Initializer', kind='InitializerClause',
                   is_optional=True),
         ]),

    # condition-list -> condition
    #                 | condition ','? condition-list
    Node('ConditionElementList', name_for_diagnostics=None, kind='SyntaxCollection',
         element='ConditionElement'),

    # throw-stmt -> 'throw' expr ';'?
    Node('ThrowStmt', name_for_diagnostics="'throw' statement", kind='Stmt',
         children=[
             Child('ThrowKeyword', kind='KeywordToken', text_choices=['throw']),
             Child('Expression', kind='Expr'),
         ]),

    # if-stmt -> identifier? ':'? 'if' condition-list code-block
    #   else-clause ';'?
    Node('IfStmt', name_for_diagnostics="'if' statement", kind='Stmt',
         traits=['WithCodeBlock'],
         children=[
             Child('IfKeyword', kind='KeywordToken', text_choices=['if']),
             Child('Conditions', kind='ConditionElementList',
                   collection_element_name='Condition'),
             Child('Body', kind='CodeBlock', name_for_diagnostics='body'),
             Child('ElseKeyword', kind='ElseToken',
                   is_optional=True),
             Child('ElseBody', kind='Syntax', name_for_diagnostics='else body',
                   node_choices=[
                       Child('IfStmt', kind='IfStmt'),
                       Child('CodeBlock', kind='CodeBlock'),
                   ],
                   is_optional=True),
         ]),

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

    # switch-default-label -> 'default' ':'
    Node('SwitchDefaultLabel', name_for_diagnostics=None, kind='Syntax',
         children=[
             Child('DefaultKeyword', kind='KeywordToken', text_choices=['default']),
             Child('Colon', kind='ColonToken'),
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

    # catch-item -> pattern? where-clause? ','?
    Node('CatchItem', name_for_diagnostics=None, kind='Syntax',
         traits=['WithTrailingComma'],
         children=[
             Child('Pattern', kind='Pattern', is_optional=True),
             Child('WhereClause', kind='WhereClause',
                   is_optional=True),
             Child('TrailingComma', kind='CommaToken',
                   is_optional=True),
         ]),

    # switch-case-label -> 'case' case-item-list ':'
    Node('SwitchCaseLabel', name_for_diagnostics=None, kind='Syntax',
         children=[
             Child('CaseKeyword', kind='KeywordToken', text_choices=['case']),
             Child('CaseItems', kind='CaseItemList',
                   collection_element_name='CaseItem'),
             Child('Colon', kind='ColonToken'),
         ]),

    # catch-clause 'catch' case-item-list? code-block
    Node('CatchClause', name_for_diagnostics="'catch' clause", kind='Syntax',
         traits=['WithCodeBlock'],
         parser_function='parseCatchClause',
         children=[
             Child('CatchKeyword', kind='KeywordToken', text_choices=['catch']),
             Child('CatchItems', kind='CatchItemList',
                   collection_element_name='CatchItem', is_optional=True),
             Child('Body', kind='CodeBlock'),
         ]),
]
