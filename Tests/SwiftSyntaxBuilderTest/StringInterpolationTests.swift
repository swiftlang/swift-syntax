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

import _SwiftSyntaxTestSupport
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftParser
import SwiftBasicFormat

import XCTest

class TwoSpacesFormat: BasicFormat {
  public init() {
    super.init(indentationIncrement: .spaces(2))
  }
}

final class StringInterpolationTests: XCTestCase {
  func testDeclInterpolation() {
    let funcSyntax: DeclSyntax =
      """
      func f(a: Int, b: Int) -> Int {
        a + b
      }
      """
    XCTAssertTrue(funcSyntax.is(FunctionDeclSyntax.self))
    XCTAssertEqual(
      funcSyntax.description,
      """
      func f(a: Int, b: Int) -> Int {
        a + b
      }
      """
    )
  }

  func testExprInterpolation() {
    let exprSyntax: ExprSyntax =
      """
      f(x + g(y), y.z)
      """
    XCTAssertTrue(exprSyntax.is(FunctionCallExprSyntax.self))

    let addIt: ExprSyntax = "w + \(exprSyntax)"
    XCTAssertTrue(addIt.is(SequenceExprSyntax.self))
  }

  func testStmtSyntax() {
    let collection: ExprSyntax = "[1, 2, 3, 4, 5]"
    let stmtSyntax: StmtSyntax = "for x in \(collection) { }"
    XCTAssertTrue(stmtSyntax.is(ForInStmtSyntax.self))
  }

  func testTypeInterpolation() {
    let tupleSyntax: TypeSyntax = "(Int, name: String)"
    XCTAssertTrue(tupleSyntax.is(TupleTypeSyntax.self))
    XCTAssertEqual(tupleSyntax.description, "(Int, name: String)")
    let fnTypeSyntax: TypeSyntax = "(String) async throws -> \(tupleSyntax)"
    XCTAssertTrue(fnTypeSyntax.is(FunctionTypeSyntax.self))
    XCTAssertEqual(
      fnTypeSyntax.description,
      "(String) async throws -> (Int, name: String)"
    )
  }

  func testPatternInterpolation() {
    let letPattern: PatternSyntax = "let x"
    XCTAssertTrue(letPattern.is(ValueBindingPatternSyntax.self))
  }

  func testAttributeInterpolation() {
    let attrSyntax: AttributeSyntax = "@discardableResult"
    XCTAssertTrue(attrSyntax.is(AttributeSyntax.self))
    XCTAssertEqual(attrSyntax.description, "@discardableResult")
  }

  func testStructGenerator() {
    let name = "Type"
    let id = 17

    let structNode: DeclSyntax =
      """
      struct \(raw: name) {
        static var id = \(raw: id)
      }
      """
    XCTAssertTrue(structNode.is(StructDeclSyntax.self))
  }

  func testSourceFile() {
    let _: SourceFileSyntax =
      """
      print("Hello, world!")
      """
  }

  func testInterpolationLiteralString() {
    let a: ExprSyntax = "print(\(literal: "Hello, world!"))"
    assertStringsEqualWithDiff(a.description, #"print("Hello, world!")"#)

    let b: ExprSyntax = "print(\(literal: "\"Hello\", world!"))"
    assertStringsEqualWithDiff(b.description, ##"print(#""Hello", world!"#)"##)

    let c: ExprSyntax = "print(\(literal: "Hello\\#\\world!"))"
    assertStringsEqualWithDiff(c.description, ###"print(##"Hello\#\world!"##)"###)

    let d: ExprSyntax = "print(\(literal: "Hello, world!\n"))"
    assertStringsEqualWithDiff(d.description, #"print("Hello, world!\n")"#)

    let e: ExprSyntax = "print(\(literal: "\"Hello\", world!\n"))"
    assertStringsEqualWithDiff(e.description, ##"print(#""Hello", world!\#n"#)"##)
  }

  func testInterpolationLiteralInt() {
    func test<T: ExpressibleByIntegerLiteral & ExpressibleByLiteralSyntax>(with ty: T.Type, unsigned: Bool = false) {
      let a: ExprSyntax = "print(\(literal: 42 as T))"
      assertStringsEqualWithDiff(a.description, #"print(42)"#, additionalInfo: String(describing: ty))

      let b: ExprSyntax = "print(\(literal: 0 as T))"
      assertStringsEqualWithDiff(b.description, #"print(0)"#, additionalInfo: String(describing: ty))

      if !unsigned {
        let c: ExprSyntax = "print(\(literal: -42 as T))"
        assertStringsEqualWithDiff(c.description, ##"print(-42)"##, additionalInfo: String(describing: ty))
      }
    }

    test(with: Int.self)
    test(with: Int8.self)
    test(with: Int16.self)
    test(with: Int32.self)
    test(with: Int64.self)
    test(with: UInt.self, unsigned: true)
    test(with: UInt8.self, unsigned: true)
    test(with: UInt16.self, unsigned: true)
    test(with: UInt32.self, unsigned: true)
    test(with: UInt64.self, unsigned: true)
  }

  func testInterpolationLiteralFloat() {
    func test<T: FloatingPoint & ExpressibleByFloatLiteral & ExpressibleByLiteralSyntax>(with ty: T.Type) {
      let a: ExprSyntax = "print(\(literal: 3.14 as T))"
      assertStringsEqualWithDiff(a.description, #"print(3.14)"#, additionalInfo: String(describing: ty))

      let b: ExprSyntax = "print(\(literal: 0 as T))"
      assertStringsEqualWithDiff(b.description, #"print(0.0)"#, additionalInfo: String(describing: ty))

      let c: ExprSyntax = "print(\(literal: -42 as T))"
      assertStringsEqualWithDiff(c.description, ##"print(-42.0)"##, additionalInfo: String(describing: ty))

      let d: ExprSyntax = "print(\(literal: T.infinity))"
      assertStringsEqualWithDiff(d.description, ##"print(.infinity)"##, additionalInfo: String(describing: ty))

      let e: ExprSyntax = "print(\(literal: -T.infinity))"
      assertStringsEqualWithDiff(e.description, ##"print(-.infinity)"##, additionalInfo: String(describing: ty))

      let f: ExprSyntax = "print(\(literal: T.nan))"
      assertStringsEqualWithDiff(f.description, ##"print(.nan)"##, additionalInfo: String(describing: ty))

      let g: ExprSyntax = "print(\(literal: T.signalingNaN))"
      assertStringsEqualWithDiff(g.description, ##"print(.signalingNaN)"##, additionalInfo: String(describing: ty))

      let h: ExprSyntax = "print(\(literal: -0.0 as T))"
      assertStringsEqualWithDiff(h.description, ##"print(-0.0)"##, additionalInfo: String(describing: ty))
    }

    test(with: Float.self)
    test(with: Double.self)
  }

  func testInterpolationLiteralBool() {
    let a: ExprSyntax = "print(\(literal: true))"
    assertStringsEqualWithDiff(a.description, #"print(true)"#)

    let b: ExprSyntax = "print(\(literal: false))"
    assertStringsEqualWithDiff(b.description, #"print(false)"#)
  }

  func testInterpolationLiteralCollections() {
    let a: ExprSyntax = "print(\(literal: [3, 2, 1]))"
    assertStringsEqualWithDiff(a.description, #"print([3, 2, 1])"#)

    let b: ExprSyntax = "print(\(literal: [3, 2, 1] as Set))"
    assertStringsEqualWithDiff(b.description, #"print([1, 2, 3])"#)

    let c: ExprSyntax = "print(\(literal: [3: "three", 2: "two", 1: "one"] as KeyValuePairs))"
    assertStringsEqualWithDiff(c.description, #"print([3: "three", 2: "two", 1: "one"])"#)

    let d: ExprSyntax = "print(\(literal: [3: "three", 2: "two", 1: "one"]))"
    assertStringsEqualWithDiff(d.description, #"print([1: "one", 2: "two", 3: "three"])"#)
  }

  func testInterpolationLiteralOptional() {
    let some: Optional<Int> = 42
    let none: Optional<Int> = nil

    let a: ExprSyntax = "print(\(literal: some))"
    assertStringsEqualWithDiff(a.description, #"print(42)"#)

    let b: ExprSyntax = "print(\(literal: Optional.some(some)))"
    assertStringsEqualWithDiff(b.description, #"print(42)"#)

    let c: ExprSyntax = "print(\(literal: none))"
    assertStringsEqualWithDiff(c.description, #"print(nil)"#)

    let d: ExprSyntax = "print(\(literal: Optional.some(none)))"
    assertStringsEqualWithDiff(d.description, #"print(.some(nil))"#)

    let e: ExprSyntax = "print(\(literal: Int??.none))"
    assertStringsEqualWithDiff(e.description, #"print(nil)"#)
  }

  func testRewriter() {
    let sourceFile = Parser.parse(
      source: """
        class Foo {
          func method() {}
        }
        """
    )
    class Rewriter: SyntaxRewriter {
      override func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
        let newFunc = DeclSyntax("func newName() {}")
          .with(\.leadingTrivia, node.leadingTrivia)
          .with(\.trailingTrivia, node.trailingTrivia)
        return DeclSyntax(newFunc)
      }
    }
    let rewrittenSourceFile = Rewriter().visit(sourceFile)
    XCTAssertEqual(
      rewrittenSourceFile.description,
      """
      class Foo {
        func newName() {}
      }
      """
    )
  }

  func testParserBuilderInStringInterpolation() {
    let cases = SwitchCaseListSyntax {
      for i in 0..<2 {
        SwitchCaseSyntax(
          """
          case \(raw: i):
            return \(raw: i + 1)
          """
        )
      }
      SwitchCaseSyntax(
        """
        default:
          return -1
        """
      )
    }
    let plusOne = DeclSyntax(
      """
      func plusOne(base: Int) -> Int {
        switch base {
        \(cases, format: TwoSpacesFormat())
        }
      }
      """
    )

    assertStringsEqualWithDiff(
      plusOne.description.trimmingTrailingWhitespace(),
      """
      func plusOne(base: Int) -> Int {
        switch base {
        case 0:
          return 1
        case 1:
          return 2
        default:
          return -1
        }
      }
      """
    )
  }

  func testParserBuilderInStringInterpolationLiteral() {
    let cases = SwitchCaseListSyntax {
      for i in 0..<2 {
        SwitchCaseSyntax(
          """
          case \(literal: i):
            return \(literal: i + 1)
          """
        )
      }
      SwitchCaseSyntax(
        """
        default:
          return -1
        """
      )
    }
    let plusOne = DeclSyntax(
      """
      func plusOne(base: Int) -> Int {
        switch base {
        \(cases, format: TwoSpacesFormat())
        }
      }
      """
    )

    assertStringsEqualWithDiff(
      plusOne.description.trimmingTrailingWhitespace(),
      """
      func plusOne(base: Int) -> Int {
        switch base {
        case 0:
          return 1
        case 1:
          return 2
        default:
          return -1
        }
      }
      """
    )
  }

  func testStringInterpolationInBuilder() {
    let ext = ExtensionDeclSyntax(extendedType: TypeSyntax("MyType")) {
      DeclSyntax(
        """
        ///
        /// Satisfies conformance to `SyntaxBuildable`.
        func buildSyntax(format: Format) -> Syntax {
          return Syntax(buildTest(format: format))
        }
        """
      )
    }
    assertStringsEqualWithDiff(
      ext.formatted(using: TwoSpacesFormat()).description,
      """
      extension MyType {
        ///
        /// Satisfies conformance to `SyntaxBuildable`.
        func buildSyntax(format: Format) -> Syntax {
          return Syntax(buildTest(format: format))
        }
      }
      """
    )
  }

  func testAccessorInterpolation() {
    let setter: AccessorDeclSyntax =
      """
      set(newValue) {
        _storage = newValue
      }
      """
    XCTAssertTrue(setter.is(AccessorDeclSyntax.self))
    assertStringsEqualWithDiff(
      setter.description,
      """
      set(newValue) {
        _storage = newValue
      }
      """
    )
  }

  func testTrivia() {
    XCTAssertEqual(
      "/// doc comment" as Trivia,
      [
        .docLineComment("/// doc comment")
      ]
    )

    XCTAssertEqual(
      """
      /// doc comment
      /// another doc comment
      """ as Trivia,
      [
        .docLineComment("/// doc comment"),
        .newlines(1),
        .docLineComment("/// another doc comment"),
      ]
    )

    XCTAssertEqual(
      """
      // 1 + 1 = \(1 + 1)
      """ as Trivia,
      [
        .lineComment("// 1 + 1 = 2")
      ]
    )
  }

  func testInvalidTrivia() {
    let invalid = Trivia("/*comment*/ invalid /*comm*/")
    XCTAssertEqual(invalid, [.blockComment("/*comment*/"), .spaces(1), .unexpectedText("invalid"), .spaces(1), .blockComment("/*comm*/")])

    XCTAssertThrowsError(try Trivia(validating: "/*comment*/ invalid /*comm*/")) { error in
      assertStringsEqualWithDiff(
        String(describing: error),
        """

        1 │ /*comment*/ invalid /*comm*/
          │             ╰─ error: unexpected trivia 'invalid'

        """
      )
    }
  }

  func testInvalidSyntax() {
    let invalid = DeclSyntax("return 1")
    XCTAssert(invalid.hasError)

    XCTAssertThrowsError(try DeclSyntax(validating: "return 1")) { error in
      assertStringsEqualWithDiff(
        String(describing: error),
        """

        1 │ return 1
          │ │       ╰─ error: expected declaration
          │ ╰─ error: unexpected code 'return 1' before declaration

        """
      )
    }
  }

  func testInvalidSyntax2() {
    let invalid = StmtSyntax("struct Foo {}")
    XCTAssert(invalid.hasError)

    XCTAssertThrowsError(try StmtSyntax(validating: "struct Foo {}")) { error in
      assertStringsEqualWithDiff(
        String(describing: error),
        """

        1 │ struct Foo {}
          │ │            ╰─ error: expected statement
          │ ╰─ error: unexpected code 'struct Foo {}' before statement

        """
      )
    }
  }
}
