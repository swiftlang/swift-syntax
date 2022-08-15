// RUN: %lit-test-helper -source-file %s -dump-diags 2>&1 | %FileCheck %s

// CHECK: [[@LINE+2]]:11 error: consecutive statements on a line must be separated by ';'
// CHECK-NEXT: Fixit: ([[@LINE+1]]:11,[[@LINE+1]]:11) Text: ";"
let number⁚ Int
// CHECK-NEXT: [[@LINE-1]]:11 error: operator with postfix spacing cannot start a subexpression

// CHECK-NEXT: [[@LINE+2]]:3 error: invalid character in source file
// CHECK-NEXT: Fixit: ([[@LINE+1]]:3,[[@LINE+1]]:6) Text: " "
5 ‒ 5
// CHECK-NEXT: [[@LINE-1]]:3 [[@LINE-1]]:3 note: unicode character '‒' (Figure Dash) looks similar to '-' (Hyphen Minus); did you mean to use '-' (Hyphen Minus)?
// CHECK-NEXT: Fixit: ([[@LINE-2]]:3,[[@LINE-2]]:6) Text: "-"
// CHECK-NEXT: [[@LINE-3]]:2 error: consecutive statements on a line must be separated by ';'
// CHECK-NEXT: Fixit: ([[@LINE-4]]:2,[[@LINE-4]]:2) Text: ";"

// CHECK-NEXT: [[@LINE+2]]:10 error: expected ',' separator
// CHECK-NEXT: Fixit: ([[@LINE+1]]:9,[[@LINE+1]]:9) Text: ","
if (true ꝸꝸꝸ false) {}

if (5 ‒ 5) == 0 {}
// CHECK-NEXT: [[@LINE-1]]:7 error: invalid character in source file
// CHECK-NEXT: Fixit: ([[@LINE-2]]:7,[[@LINE-2]]:10) Text: " "
// CHECK-NEXT: [[@LINE-3]]:7 [[@LINE-3]]:7 note: unicode character '‒' (Figure Dash) looks similar to '-' (Hyphen Minus); did you mean to use '-' (Hyphen Minus)?
// CHECK-NEXT: Fixit: ([[@LINE-4]]:7,[[@LINE-4]]:10) Text: "-"
// CHECK-NEXT: [[@LINE-5]]:11 error: expected ',' separator
// CHECK-NEXT: Fixit: ([[@LINE-6]]:6,[[@LINE-6]]:6) Text: ","
// CHECK-NEXT: 7 error(s) 0 warnings(s) 2 note(s)
