// RUN: %empty-directory(%t)
// RUN: %lit-test-helper -print-tree -source-file %s > %t.result
// RUN: diff -u %t.result %S/output/print_verify_tree.swift.withkind

func foo() {
#if swift(>=3.2)
    components.append("-b \"\(string[..<string.index(before: string.endIndex)])\"")
#else
    components.append("-b \"\(string.substring(to: string.characters.index(before: string.endIndex)))\"")
#endif
}