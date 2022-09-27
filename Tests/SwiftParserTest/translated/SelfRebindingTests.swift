// This test file has been translated from swift/test/Parse/self_rebinding.swift

import XCTest

final class SelfRebindingTests: XCTestCase {
  func testSelfRebinding1() {
    AssertParse(
      #"""
      class Writer {
          private var articleWritten = 47
          func stop() {
              let rest: () -> Void = { [weak self] in
                  let articleWritten = self?.articleWritten ?? 0
                  guard let `self` = self else {
                      return
                  }
                  self.articleWritten = articleWritten
              }
              fatalError("I'm running out of time")
              rest()
          }
          func nonStop() {
              let write: () -> Void = { [weak self] in
                  self?.articleWritten += 1
                  if let self = self {
                      self.articleWritten += 1
                  }
                  if let `self` = self {
                      self.articleWritten += 1
                  }
                  guard let self = self else {
                      return
                  }
                  self.articleWritten += 1
              }
              write()
          }
      }
      """#
    )
  }

  func testSelfRebinding2() {
    AssertParse(
      """
      struct T {
          var mutable: Int = 0
          func f() {
              let #^DIAG^#self = self
          }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: keyword 'self' cannot be used as an identifier here
        // TODO: Old parser expected note on line 4: if this name is unavoidable, use backticks to escape it
        DiagnosticSpec(message: "expected pattern in variable"),
      ]
    )
  }

  func testSelfRebinding3() {
    AssertParse(
      """
      class MyCls {
          func something() {}
          func test() {
              let `self` = Writer() // Even if `self` is shadowed,
              something() // this should still refer `MyCls.something`.
          }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 4: initialization of immutable value 'self' was never used
      ]
    )
  }

  func testSelfRebinding4() {
    AssertParse(
      """
      // https://github.com/apple/swift/issues/47136
      // Method called 'self' can be confused with regular 'self'
      """
    )
  }

  func testSelfRebinding5() {
    AssertParse(
      """
      func funcThatReturnsSomething(_ any: Any) -> Any {
          any
      }
      """
    )
  }

  func testSelfRebinding6() {
    AssertParse(
      """
      struct TypeWithSelfMethod {
          let property = self 
          // Existing warning expected, not confusable
          let property2 = self() 
          let propertyFromClosure: () = {
              print(self) 
          }()
          let propertyFromFunc = funcThatReturnsSomething(self) 
          let propertyFromFunc2 = funcThatReturnsSomething(TypeWithSelfMethod.self) // OK
          func `self`() {
          }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 2: 'self' refers to the method 'TypeWithSelfMethod.self', which may be unexpected
        // TODO: Old parser expected note on line 2: use 'TypeWithSelfMethod.self' to silence this warning, Fix-It replacements: 20 - 20 = 'TypeWithSelfMethod.'
        // TODO: Old parser expected error on line 4: cannot use instance member 'self' within property initializer; property initializers run before 'self' is available
        // TODO: Old parser expected warning on line 6: 'self' refers to the method 'TypeWithSelfMethod.self', which may be unexpected
        // TODO: Old parser expected note on line 6: use 'TypeWithSelfMethod.self' to silence this warning, Fix-It replacements: 15 - 15 = 'TypeWithSelfMethod.'
        // TODO: Old parser expected warning on line 8: 'self' refers to the method 'TypeWithSelfMethod.self', which may be unexpected
        // TODO: Old parser expected note on line 8: use 'TypeWithSelfMethod.self' to silence this warning, Fix-It replacements: 53 - 53 = 'TypeWithSelfMethod.'
      ]
    )
  }

  func testSelfRebinding7() {
    AssertParse(
      """
      /// Test fix_unqualified_access_member_named_self doesn't appear for computed var called `self`
      /// it can't currently be referenced as a static member -- unlike a method with the same name
      struct TypeWithSelfComputedVar {
          let property = self 
          let propertyFromClosure: () = {
              print(self) 
          }()
          let propertyFromFunc = funcThatReturnsSomething(self) 
          var `self`: () {
              ()
          }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: cannot use instance member 'self' within property initializer; property initializers run before 'self' is available
        // TODO: Old parser expected error on line 6: cannot use instance member 'self' within property initializer; property initializers run before 'self' is available
        // TODO: Old parser expected error on line 8: cannot use instance member 'self' within property initializer; property initializers run before 'self' is available
      ]
    )
  }

  func testSelfRebinding8() {
    AssertParse(
      """
      /// Test fix_unqualified_access_member_named_self doesn't appear for property called `self`
      /// it can't currently be referenced as a static member -- unlike a method with the same name
      struct TypeWithSelfProperty {
          let property = self 
          let propertyFromClosure: () = {
              print(self) 
          }()
          let propertyFromFunc = funcThatReturnsSomething(self) 
          let `self`: () = ()
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: cannot use instance member 'self' within property initializer; property initializers run before 'self' is available
        // TODO: Old parser expected error on line 6: cannot use instance member 'self' within property initializer; property initializers run before 'self' is available
        // TODO: Old parser expected error on line 8: cannot use instance member 'self' within property initializer; property initializers run before 'self' is available
      ]
    )
  }

  func testSelfRebinding9() {
    AssertParse(
      """
      enum EnumCaseNamedSelf {
          case `self`
          init() {
              self = .self // OK
              self = .`self` // OK
              self = EnumCaseNamedSelf.`self` // OK
          }
      }
      """
    )
  }

  func testSelfRebinding10() {
    AssertParse(
      """
      // rdar://90624344 - warning about `self` which cannot be fixed because it's located in implicitly generated code.
      struct TestImplicitSelfUse : Codable {
        let `self`: Int // Ok
      }
      """
    )
  }

}
