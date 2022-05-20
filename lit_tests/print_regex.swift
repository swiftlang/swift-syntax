// RUN: %empty-directory(%t)
 // RUN: %lit-test-helper -print-tree -source-file %s | %FileCheck %s --check-prefix REGEX

 _ = /abc/
 // REGEX: _ </TokenSyntax></DiscardAssignmentExprSyntax><AssignmentExprSyntax><TokenSyntax>= </TokenSyntax></AssignmentExprSyntax><RegexLiteralExprSyntax><TokenSyntax>/abc/</TokenSyntax></RegexLiteralExprSyntax></ExprListSyntax></SequenceExprSyntax></CodeBlockItemSyntax></CodeBlockItemListSyntax><TokenSyntax>
 // REGEX: </TokenSyntax></SourceFileSyntax>
