// RUN: %empty-directory(%t)
// RUN: %lit-test-helper -print-tree -source-file %s | %FileCheck %s --check-prefix REGEX_DISABLED
// RUN: %lit-test-helper -print-tree -source-file %s -enable-bare-slash-regex 1 -swift-version 5 | %FileCheck %s --check-prefix REGEX_ENABLED

_ = /abc/
// REGEX_DISABLED: _ </TokenSyntax></DiscardAssignmentExprSyntax><AssignmentExprSyntax><TokenSyntax>= </TokenSyntax></AssignmentExprSyntax><PrefixOperatorExprSyntax><TokenSyntax>/</TokenSyntax><PostfixUnaryExprSyntax><IdentifierExprSyntax><TokenSyntax>abc</TokenSyntax></IdentifierExprSyntax><TokenSyntax>/</TokenSyntax></PostfixUnaryExprSyntax></PrefixOperatorExprSyntax></ExprListSyntax></SequenceExprSyntax></CodeBlockItemSyntax></CodeBlockItemListSyntax><TokenSyntax>
// REGEX_DISABLED: </TokenSyntax></SourceFileSyntax>

// REGEX_ENABLED: _ </TokenSyntax></DiscardAssignmentExprSyntax><AssignmentExprSyntax><TokenSyntax>= </TokenSyntax></AssignmentExprSyntax><RegexLiteralExprSyntax><TokenSyntax>/abc/</TokenSyntax></RegexLiteralExprSyntax></ExprListSyntax></SequenceExprSyntax></CodeBlockItemSyntax></CodeBlockItemListSyntax><TokenSyntax>
// REGEX_ENABLED: </TokenSyntax></SourceFileSyntax>
