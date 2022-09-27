// This test file has been translated from swift/test/Parse/trailing_closures.swift

import XCTest

final class TrailingClosuresTests: XCTestCase {
  func testTrailingClosures1() {
    AssertParse(
      """
      func foo<T, U>(a: () -> T, b: () -> U) {}
      """
    )
  }

  func testTrailingClosures2() {
    AssertParse(
      #"""
      foo { 42 }
      b: { "" }
      """#
    )
  }

  func testTrailingClosures3() {
    AssertParse(
      #"""
      foo { 42 } b: { "" }
      """#
    )
  }

  func testTrailingClosures4() {
    AssertParse(
      """
      func when<T>(_ condition: @autoclosure () -> Bool,
                   `then` trueBranch: () -> T,
                   `else` falseBranch: () -> T) -> T {
        return condition() ? trueBranch() : falseBranch()
      }
      """
    )
  }

  func testTrailingClosures5() {
    AssertParse(
      """
      let _ = when (2 < 3) { 3 } else: { 4 }
      """
    )
  }

  func testTrailingClosures6() {
    AssertParse(
      """
      struct S {
        static func foo(a: Int = 42, b: (inout Int) -> Void) -> S {
          return S()
        }
        static func foo(a: Int = 42, ab: () -> Void, b: (inout Int) -> Void) -> S {
          return S()
        }
        subscript(v v: () -> Int) -> Int {
          get { return v() }
        }
        subscript(u u: () -> Int, v v: () -> Int) -> Int {
          get { return u() + v() }
        }
        subscript(cond: Bool, v v: () -> Int) -> Int {
          get { return cond ? 0 : v() }
        }
        subscript(cond: Bool, u u: () -> Int, v v: () -> Int) -> Int {
          get { return cond ? u() : v() }
        }
      }
      """
    )
  }

  func testTrailingClosures7() {
    AssertParse(
      """
      let _: S = .foo {
        $0 = $0 + 1
      }
      """
    )
  }

  func testTrailingClosures8() {
    AssertParse(
      """
      let _: S = .foo {} b: { $0 = $0 + 1 }
      """
    )
  }

  func testTrailingClosures9() {
    AssertParse(
      """
      func bar(_ s: S) {
        _ = s[] {
          42
        }
        _ = s[] {
          21
        } v: {
          42
        }
        _ = s[true] {
          42
        }
        _ = s[true] {
          21
        } v: {
          42
        }
      }
      """
    )
  }

  func testTrailingClosures10() {
    AssertParse(
      """
      func multiple_trailing_with_defaults( 
        duration: Int,
        animations: (() -> Void)? = nil,
        completion: (() -> Void)? = nil) {}
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 1: declared here
      ]
    )
  }

  func testTrailingClosures11() {
    AssertParse(
      """
      multiple_trailing_with_defaults(duration: 42) {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: backward matching of the unlabeled trailing closure is deprecated; label the argument with 'completion' to suppress this warning
      ]
    )
  }

  func testTrailingClosures12() {
    AssertParse(
      """
      multiple_trailing_with_defaults(duration: 42) {} completion: {}
      """
    )
  }

  func testTrailingClosures13() {
    AssertParse(
      """
      func test_multiple_trailing_syntax_without_labels() {
        func fn(f: () -> Void, g: () -> Void) {}
        fn {} g: {} // Ok
        fn {} _: {} //  {{none}}
        fn {} g#^DIAG^#: <#T##() -> Void#> 
        func multiple(_: () -> Void, _: () -> Void) {}
        multiple {} _: { }
        func mixed_args_1(a: () -> Void, _: () -> Void) {}
        func mixed_args_2(_: () -> Void, a: () -> Void, _: () -> Void) {} 
        mixed_args_1 {} _: {}
        mixed_args_1 {} a: {}  //  {{none}}
        mixed_args_2 {} a: {} _: {}
        mixed_args_2 {} _: {} //  {{none}}
        mixed_args_2 {} _: {} _: {} //  {{none}}
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: missing argument label 'g:' in call, Fix-It replacements: 9 - 10 = 'g'
        // TODO: Old parser expected error on line 5: editor placeholder in source file
        DiagnosticSpec(message: "unexpected text ': <#T##() -> Void#>' before function"),
        // TODO: Old parser expected note on line 9: 'mixed_args_2(_:a:_:)' declared here
        // TODO: Old parser expected error on line 11: extraneous argument label 'a:' in call, Fix-It replacements: 19 - 20 = '_'
        // TODO: Old parser expected error on line 13: missing argument for parameter 'a' in call, Fix-It replacements: 18 - 18 = ' a: <#() -> Void#>'
        // TODO: Old parser expected error on line 14: missing argument label 'a:' in call, Fix-It replacements: 19 - 20 = 'a'
      ]
    )
  }

  func testTrailingClosures14() {
    AssertParse(
      """
      func produce(fn: () -> Int?, default d: () -> Int) -> Int { 
        return fn() ?? d()
      }
      // TODO: The diagnostics here are perhaps a little overboard.
      _ = produce { 0 } #^DIAG^#default: { 1 } 
      _ = produce { 2 } `default`: { 3 }
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 1: declared here
        // TODO: Old parser expected error on line 5: missing argument for parameter 'default' in call
        // TODO: Old parser expected error on line 5: consecutive statements
        // TODO: Old parser expected error on line 5: 'default' label can only appear inside a 'switch' statement
        DiagnosticSpec(message: "extraneous code at top level"),
        // TODO: Old parser expected error on line 6: labeled block needs 'do'
        // TODO: Old parser expected warning on line 6: integer literal is unused
      ]
    )
  }

  func testTrailingClosures15() {
    AssertParse(
      """
      func f() -> Int { 42 }
      """
    )
  }

  func testTrailingClosures16() {
    AssertParse(
      """
      // This should be interpreted as a trailing closure, instead of being 
      // interpreted as a computed property with undesired initial value.
      struct TrickyTest {
          var x : Int = f () { 
              3
          }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: extra trailing closure passed in call
      ]
    )
  }

}
