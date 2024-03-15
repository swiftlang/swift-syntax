//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// This test file has been translated from swift/test/Parse/self_rebinding.swift

import XCTest

final class SelfRebindingTests: ParserTestCase {
  func testSelfRebinding1() {
    assertParse(
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
    assertParse(
      """
      struct T {
          var mutable: Int = 0
          func f() {
              let 1️⃣self = self
          }
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'self' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        struct T {
            var mutable: Int = 0
            func f() {
                let `self` = self
            }
        }
        """
    )
  }

  func testSelfRebinding3() {
    assertParse(
      """
      class MyCls {
          func something() {}
          func test() {
              let `self` = Writer() // Even if `self` is shadowed,
              something() // this should still refer `MyCls.something`.
          }
      }
      """
    )
  }

  func testSelfRebinding4() {
    assertParse(
      """
      // https://github.com/apple/swift/issues/47136
      // Method called 'self' can be confused with regular 'self'
      """
    )
  }

  func testSelfRebinding5() {
    assertParse(
      """
      func funcThatReturnsSomething(_ any: Any) -> Any {
          any
      }
      """
    )
  }

  func testSelfRebinding6() {
    assertParse(
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
      """
    )
  }

  func testSelfRebinding7() {
    assertParse(
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
      """
    )
  }

  func testSelfRebinding8() {
    assertParse(
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
      """
    )
  }

  func testSelfRebinding9() {
    assertParse(
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
    assertParse(
      """
      // rdar://90624344 - warning about `self` which cannot be fixed because it's located in implicitly generated code.
      struct TestImplicitSelfUse : Codable {
        let `self`: Int // Ok
      }
      """
    )
  }

}
