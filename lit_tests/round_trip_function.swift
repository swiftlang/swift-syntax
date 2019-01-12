// RUN: %empty-directory(%t)

// RUN: %lit-test-helper -roundtrip -source-file %s -out %t/afterRoundtrip.swift
// RUN: diff -u %t/afterRoundtrip.swift %s

func noArgs() {}
func oneArg(x: Int) {}
func oneUnlabeledArg(_ x: Int) {}

typealias FunctionAlias = (_ x: inout Int) -> Bool
typealias FunctionAliasNoLabel = (Int) -> Bool

func manyArgs(x: Int, y: Int, _ z: Bool, _ a: String) throws -> [Int] {
  return []
}

func rethrowing(_ f: (Bool) throws -> Int) rethrows -> Int {
  return try f(false)
}
