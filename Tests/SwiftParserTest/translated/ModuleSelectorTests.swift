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

// This test file has been translated from swift/test/NameLookup/module_selector.swift

import XCTest
@_spi(ExperimentalLanguageFeatures) import SwiftSyntax
@_spi(ExperimentalLanguageFeatures) import SwiftParser

final class ModuleSelectorTests: ParserTestCase {
  // FIXME: This test doesn't really cover:
  //
  // * Key paths
  // * Custom type attributes (and coverage of type attrs generally is sparse)
  // * Macros

  override var experimentalFeatures: Parser.ExperimentalFeatures {
    [ .moduleSelector ]
  }

  func testModuleSelectorImports() {
    XCTExpectFailure("imports not yet implemented")

    assertParse(
      """
      import ctypes::bits   // FIXME: ban using :: with submodules?
      import struct ModuleSelectorTestingKit::A
      """
    )
  }

  func testModuleSelectorCorrectCode() {
    assertParse(
      """
      extension ModuleSelectorTestingKit::A {}

      extension A: @retroactive Swift::Equatable {
        @_implements(Swift::Equatable, ==(_:_:))
        public static func equals(_: ModuleSelectorTestingKit::A, _: ModuleSelectorTestingKit::A) -> Swift::Bool {
          Swift::fatalError()
        }

        // FIXME: Add tests with autodiff @_differentiable(jvp:vjp:) and
        // @_derivative(of:)

        @_dynamicReplacement(for: ModuleSelectorTestingKit::negate())
        mutating func myNegate() {
          let fn: (Swift::Int, Swift::Int) -> Swift::Int = (Swift::+)

          let magnitude: Int.Swift::Magnitude = main::magnitude

          _ = (fn, magnitude)

          if Swift::Bool.Swift::random() {
            self.ModuleSelectorTestingKit::negate()
          }
          else {
            self = ModuleSelectorTestingKit::A(value: .Swift::min)
            self = A.ModuleSelectorTestingKit::init(value: .min)
          }

          self.main::myNegate()

          Swift::fatalError()
        }

        // FIXME: Can we test @convention(witness_method:)?
      }
      """
    )
  }

  func testModuleSelectorIncorrectAttrNames() {
    // An attribute with a module selector *must* be a custom attribute and should be parsed as such.
    assertParse(
      """
      @2️⃣main::available(macOS 1️⃣10.15, *) var use1: String { "foo" }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code '10.15, *' in attribute"
        )
      ]
    )

    assertParse(
      """
      @1️⃣main::available var use2
      """
    )

    assertParse(
      """
      func builderUser2(@1️⃣main::MyBuilder fn: () -> Void) {}
      """
    )
  }

  func testModuleSelectorWhitespace() {
    assertParse(
      """
      _ = 1️⃣Swift::print
      """
    )
    assertParse(
      """
      _ = 1️⃣Swift:: print
      """
    )
    assertParse(
      """
      _ = 1️⃣Swift ::print
      """
    )
    assertParse(
      """
      _ = 1️⃣Swift :: print
      """
    )
    assertParse(
      """
      _ = 1️⃣Swift::
      print
      """
    )
    assertParse(
      """
      _ = 1️⃣Swift
      ::print
      """
    )
    assertParse(
      """
      _ = 1️⃣Swift ::
      print
      """
    )
    assertParse(
      """
      _ = 1️⃣Swift
      :: print
      """
    )
    assertParse(
      """
      _ = 1️⃣Swift
      ::
      print
      """
    )
  }

  func testModuleSelectorIncorrectFuncSignature() {
    XCTExpectFailure("incorrect uses not yet implemented")

    assertParse(
      """
      func 1️⃣main::decl1() {}
        // expected-error@-1 {{name in function declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{6-12=}}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'main::' in function")
      ]
    )
    assertParse(
      """
      func decl1(
        1️⃣main::p1: 2️⃣Swift::A
        // expected-error@-1 {{argument label cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{3-9=}}
      ) {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' before parameter"
        ),
      ]
    )

    // Round-tripping failures:
    assertParse(
      """
      func decl1(
        1️⃣main::p1: 2️⃣::A
      ) {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' before parameter"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected module name in module selector",
          fixIts: ["insert module name"]
        ),
      ],
      fixedSource: """
        func decl1(
          main::p1: <#identifier#>::A
        ) {}
        """
    )
    assertParse(
      """
      func decl1(
        1️⃣main::p1: 2️⃣Swift::3️⃣
      ) {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' before parameter"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code 'Swift::' before type"
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "expected type in parameter",
          fixIts: ["insert type"]
        ),
      ],
      fixedSource: """
        func decl1(
          main::p1: Swift::<#type#>
        ) {}
        """
    )

    assertParse(
      """
      func decl1(
        1️⃣main::label p2: 2️⃣Swift::inout A
        // expected-error@-1 {{argument label cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{3-9=}}
        // FIXME: expected-error@-2 {{expected identifier in dotted type}} should be something like {{type 'inout' is not imported through module 'main'}}
      ) {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' before parameter"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code 'Swift::' before type specifier"
        )
      ]
    )
    assertParse(
      """
      func decl1(
        label 1️⃣main::p3: @Swift::escaping () -> A
        // expected-error@-1 {{parameter name cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{9-15=}}
        // FIXME: expected-error@-2 {{attribute can only be applied to declarations, not types}} should be something like {{type 'escaping' is not imported through module 'main'}}
        // FIXME: expected-error@-3 {{expected parameter type following ':'}}
      ) {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' in parameter"
        ),
      ]
    )
  }

  func testModuleSelectorIncorrectBindingDecls() {
    XCTExpectFailure("incorrect uses not yet implemented")

    assertParse(
      """
      let 1️⃣main::decl1a = "a"
      // expected-error@-1 {{name in constant declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{7-13=}}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' before pattern"
        ),
      ]
    )
    assertParse(
      """
      var 1️⃣main::decl1b = "b"
      // expected-error@-1 {{name in variable declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{7-13=}}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' before pattern"
        ),
      ]
    )
    assertParse(
      """
      let (1️⃣main::decl1c, 2️⃣Swift::decl1d) = ("c", "d")
      // expected-error@-1 {{name in constant declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{8-14=}}
      // expected-error@-2 {{name in constant declaration cannot be qualified with a module selector}} expected-note@-2 {{remove module selector from this name}} {{22-28=}}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' before pattern"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code 'Swift::' before pattern"
        )
      ]
    )
    assertParse(
      """
      if let (1️⃣main::decl1e, 2️⃣Swift::decl1f) = Optional(("e", "f")) {}
      // expected-error@-1 {{name in constant declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{11-17=}}
      // expected-error@-2 {{name in constant declaration cannot be qualified with a module selector}} expected-note@-2 {{remove module selector from this name}} {{25-31=}}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' before pattern"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code 'Swift::' before pattern"
        )
      ]
    )
    assertParse(
      """
      guard let (1️⃣main::decl1g, 2️⃣Swift::decl1h) = Optional(("g", "h")) else { return }
      // expected-error@-1 {{name in constant declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{14-20=}}
      // expected-error@-2 {{name in constant declaration cannot be qualified with a module selector}} expected-note@-2 {{remove module selector from this name}} {{28-34=}}
      // From uses in the switch statements below: expected-note@-3 3 {{did you mean the local declaration?}}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' before pattern"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code 'Swift::' before pattern"
        )
      ]
    )
    assertParse(
      """
      switch Optional(2️⃣main::decl1g) {
      case Optional.some(let 1️⃣Swift::decl1i):
        // expected-error@-1 {{name in constant declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{26-32=}}
        break
      case .none:
        break
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'Swift::' before pattern"
        ),
      ]
    )
    assertParse(
      """
      switch Optional(2️⃣main::decl1g) {
      case let Optional.some(1️⃣Swift::decl1j):
        // expected-error@-1 {{name in constant declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{26-32=}}
        break
      case .none:
        break
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'Swift::' before pattern"
        ),
      ]
    )
    assertParse(
      """
      switch Optional(2️⃣main::decl1g) {
      case let 1️⃣Swift::decl1k?:
        // expected-error@-1 {{name in constant declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{11-17=}}
        break
      case .none:
        break
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'Swift::' before pattern"
        ),
      ]
    )
    assertParse(
      """
      for 1️⃣main::decl1l in "lll" {}
      // expected-error@-1 {{name in constant declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{7-13=}}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' before pattern"
        ),
      ]
    )
  }

  func testModuleSelectorIncorrectClosureDecls() {
    XCTExpectFailure("incorrect uses not yet implemented")

    assertParse(
      """
      "lll".forEach { [2️⃣Swift::magnitude]
        // expected-error@-1 {{captured variable name cannot be qualified with a module selector}}
        // expected-note@-2 {{remove module selector from this name}} {{20-26=}}
        // expected-note@-3 {{explicitly capture into a variable named 'magnitude'}} {{20-20=magnitude = }}
        1️⃣main::elem in print(elem)
        // expected-error@-1 {{parameter name cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{5-11=}}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code 'Swift::' before closure capture"
        ),
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' before closure parameter"
        ),
      ]
    )
    assertParse(
      """
      "lll".forEach { (1️⃣main::elem) in print(elem) }
      // expected-error@-1 {{parameter name cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{20-26=}}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' before parameter"
        ),
      ]
    )
    assertParse(
      """
      "lll".forEach { (1️⃣main::elem) -> Void in print(elem) }
      // expected-error@-1 {{parameter name cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{20-26=}}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' before parameter"
        ),
      ]
    )
    assertParse(
      """
      "lll".forEach { (1️⃣main::elem: Character) -> Void in print(elem) }
      // expected-error@-1 {{parameter name cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{20-26=}}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' before parameter"
        ),
      ]
    )
  }

  func testModuleSelectorIncorrectTypeDecls() {
    XCTExpectFailure("incorrect uses not yet implemented")

    assertParse(
      """
      enum 1️⃣main::decl2 {
        // expected-error@-1 {{name in enum declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{6-12=}}

        case 2️⃣Swift::decl2a
        // expected-error@-1 {{name in enum 'case' declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{8-14=}}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' in enum"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code 'Swift::' in enum case"
        ),
      ]
    )
    assertParse(
      """
      struct 1️⃣main::decl3 {}
      // expected-error@-1 {{name in struct declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{8-14=}}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'main::' in struct"),
      ]
    )
    assertParse(
      """
      class 1️⃣main::decl4<2️⃣Swift::T> {}
      // expected-error@-1 {{name in class declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{7-13=}}
      // expected-error@-2 {{generic parameter name cannot be qualified with a module selector}} expected-note@-2 {{remove module selector from this name}} {{19-25=}}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' in class"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code 'Swift::' before generic parameter"
        ),
      ]
    )
    assertParse(
      """
      typealias 1️⃣main::decl5 = 2️⃣Swift::Bool
      // expected-error@-1 {{name in typealias declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{11-17=}}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' in typealias declaration"
        ),
      ]
    )
    assertParse(
      """
      protocol 1️⃣main::decl6 {
        // expected-error@-1 {{name in protocol declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{10-16=}}

        associatedtype 2️⃣Swift::decl6a
        // expected-error@-1 {{name in associatedtype declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{18-24=}}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' in protocol"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code 'Swift::' in associatedtype declaration"
        ),
      ]
    )
  }

  func testModuleSelectorIncorrectGlobalVarDecls() {
    XCTExpectFailure("incorrect uses not yet implemented")

    assertParse(
      """
      let 1️⃣main::decl7 = 7
      // expected-error@-1 {{name in constant declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{5-11=}}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' before pattern"
        ),
      ]
    )
    assertParse(
      """
      var 1️⃣main::decl8 = 8 {
      // expected-error@-1 {{name in variable declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{5-11=}}

        willSet(2️⃣Swift::newValue) {}
        // expected-error@-1 {{parameter name cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{11-17=}}

        didSet(3️⃣Foo::oldValue) {}
        // expected-error@-1 {{parameter name cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{10-16=}}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' before pattern"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code 'Swift::' in accessor"
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "unexpected code 'Foo::' in accessor"
        ),
      ]
    )
  }

  func testModuleSelectorIncorrectNestedDecls() {
    XCTExpectFailure("incorrect uses not yet implemented")

    assertParse(
      """
      struct Parent {
        func 1️⃣main::decl1() {}
        // expected-error@-1 {{name in function declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{8-14=}}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'main::' in function"),
      ]
    )
    assertParse(
      """
      struct Parent {
        enum 1️⃣main::decl2 {
        // expected-error@-1 {{name in enum declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{8-14=}}

          case 2️⃣Swift::decl2a
          // expected-error@-1 {{name in enum 'case' declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{10-16=}}
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' in enum"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code 'Swift::' in enum case"
        ),
      ]
    )
    assertParse(
      """
      struct Parent {
        struct 1️⃣main::decl3 {}
        // expected-error@-1 {{name in struct declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{10-16=}}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'main::' in struct"),
      ]
    )
    assertParse(
      """
      struct Parent {
        class 1️⃣main::decl4 {}
        // expected-error@-1 {{name in class declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{9-15=}}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'main::' in class"),
      ]
    )
    assertParse(
      """
      struct Parent {
        typealias 1️⃣main::decl5 = 2️⃣Swift::Bool
        // expected-error@-1 {{name in typealias declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{13-19=}}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' in typealias declaration"
        ),
      ]
    )
  }

  func testModuleSelectorIncorrectRuntimeBaseAttr() {
    // Should be diagnosed in ASTGen:
    assertParse(
      """
      @_swift_native_objc_runtime_base(1️⃣main::BaseClass)
      // expected-error@-1 {{attribute parameter value cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{34-40=}}
      class C1 {}
      """
    )
  }

  func testModuleSelectorOperatorDecls() {
    XCTExpectFailure("incorrect uses not yet implemented")

    assertParse(
      """
      infix operator <<<<< : 1️⃣Swift::AdditionPrecedence
      // expected-error@-1 {{precedence group name cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{24-31=}}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' in operator declaration"),
      ]
    )
    assertParse(
      """
      precedencegroup 1️⃣main::PG1 {
      // expected-error@-1 {{precedence group name cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{17-23=}}

        higherThan: 2️⃣Swift::AdditionPrecedence
        // expected-error@-1 {{precedence group name cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{15-22=}}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'main::' in precedencegroup"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code 'Swift::' in 'relation' property of precedencegroup"
        ),
      ]
    )
  }

  func testModuleSelectorIllFormedModuleNames() {
    assertParse(
      """
      var a: 1️⃣::Int
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected module name in module selector",
          fixIts: ["insert module name"]
        )
      ],
      fixedSource: """
        var a: <#identifier#>::Int
        """
    )
    assertParse(
      """
      var b: (1️⃣::Int)
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected module name in module selector",
          fixIts: ["insert module name"]
        )
      ],
      fixedSource: """
        var b: (<#identifier#>::Int)
        """
    )
    assertParse(
      """
      var c: 1️⃣*::Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "'*' is not a valid identifier")
      ]
    )
    assertParse(
      """
      var d: 1️⃣_::Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "'_' cannot be used as an identifier here")
      ]
    )
    assertParse(
      """
      var e: 1️⃣Self::Int
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'Self' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        var e: `Self`::Int
        """
    )
    assertParse(
      """
      var f: 1️⃣self::Int
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'self' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        var f: `self`::Int
        """
    )
    assertParse(
      """
      var g: 1️⃣inout::Int
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'inout' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        var g: `inout`::Int
        """
    )
    assertParse(
      """
      var h: 1️⃣Any::Int
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'Any' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        var h: `Any`::Int
        """
    )
    assertParse(
      """
      var aArray: [1️⃣::Int]
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected module name in module selector",
          fixIts: ["insert module name"]
        )
      ],
      fixedSource: """
        var aArray: [<#identifier#>::Int]
        """
    )
    assertParse(
      """
      var bArray: [(1️⃣::Int)]
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected module name in module selector",
          fixIts: ["insert module name"]
        )
      ],
      fixedSource: """
        var bArray: [(<#identifier#>::Int)]
        """
    )
    assertParse(
      """
      var cArray: [1️⃣*::Int]
      """,
      diagnostics: [
        DiagnosticSpec(message: "'*' is not a valid identifier")
      ]
    )
    assertParse(
      """
      var dArray: [1️⃣_::Int]
      """,
      diagnostics: [
        DiagnosticSpec(message: "'_' cannot be used as an identifier here")
      ]
    )
    assertParse(
      """
      var eArray: [1️⃣Self::Int]
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'Self' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        var eArray: [`Self`::Int]
        """
    )
    assertParse(
      """
      var fArray: [1️⃣self::Int]
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'self' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        var fArray: [`self`::Int]
        """
    )
    assertParse(
      """
      var gArray: [1️⃣inout::Int]
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'inout' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        var gArray: [`inout`::Int]
        """
    )
    assertParse(
      """
      var hArray: [1️⃣Any::Int]
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'Any' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        var hArray: [`Any`::Int]
        """
    )
    assertParse(
      """
      var aIndex: String.1️⃣::Index
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected module name in module selector",
          fixIts: ["insert module name"]
        )
      ],
      fixedSource: """
        var aIndex: String.<#identifier#>::Index
        """
    )
    // FIXME: This gets interpreted as a single `.*` operator; may not be ideal.
    assertParse(
      """
      var cIndex: String1️⃣.*::Index
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '=' in variable",
          fixIts: ["insert '='"]
        ),
        DiagnosticSpec(message: "'.*' is not a valid identifier"),
      ],
      fixedSource: """
        var cIndex: String = .*::Index
        """
    )
    assertParse(
      """
      var dIndex: String.1️⃣_::Index
      """,
      diagnostics: [
        DiagnosticSpec(message: "'_' cannot be used as an identifier here")
      ]
    )
    assertParse(
      """
      var eIndex: String.1️⃣Self::Index
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'Self' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        var eIndex: String.`Self`::Index
        """
    )
    assertParse(
      """
      var fIndex: String.1️⃣self::Index
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'self' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        var fIndex: String.`self`::Index
        """
    )
    assertParse(
      """
      var gIndex: String.1️⃣inout::Index
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'inout' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        var gIndex: String.`inout`::Index
        """
    )
    assertParse(
      """
      var hIndex: String.1️⃣Any::Index
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'Any' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        var hIndex: String.`Any`::Index
        """
    )
    assertParse(
      """
      func inExpr() {
        1️⃣::print()
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected module name in module selector",
          fixIts: ["insert module name"]
        )
      ],
      fixedSource: """
        func inExpr() {
          <#identifier#>::print()
        }
        """
    )
    assertParse(
      """
      func inExpr() {
        (1️⃣::print())
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected module name in module selector",
          fixIts: ["insert module name"]
        )
      ],
      fixedSource: """
        func inExpr() {
          (<#identifier#>::print())
        }
        """
    )
    assertParse(
      """
      func inExpr() {
        1️⃣*::print()
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'*' is not a valid identifier"),
      ]
    )
    assertParse(
      """
      func inExpr() {
        1️⃣_::print()
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'_' cannot be used as an identifier here")
      ]
    )
    assertParse(
      """
      func inExpr() {
        1️⃣Self::print()
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'Self' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        func inExpr() {
          `Self`::print()
        }
        """
    )
    assertParse(
      """
      func inExpr() {
        1️⃣self::print()
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'self' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        func inExpr() {
          `self`::print()
        }
        """
    )
    assertParse(
      """
      func inExpr() {
        1️⃣inout::print()
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'inout' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        func inExpr() {
          `inout`::print()
        }
        """
    )
    assertParse(
      """
      func inExpr() {
        1️⃣Any::print()
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'Any' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        func inExpr() {
          `Any`::print()
        }
        """
    )
    assertParse(
      """
      func inExpr() {
        _ = 1.1️⃣::magnitude
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected module name in module selector",
          fixIts: ["insert module name"]
        )
      ],
      fixedSource: """
      func inExpr() {
        _ = 1.<#identifier#>::magnitude
      }
      """
    )
    assertParse(
        """
        func inExpr() {
          _ = (1.1️⃣::magnitude)
        }
        """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected module name in module selector",
          fixIts: ["insert module name"]
        )
      ],
      fixedSource: """
        func inExpr() {
          _ = (1.<#identifier#>::magnitude)
        }
        """
    )
    // FIXME: This gets interpreted as a single `.*` operator; may not be ideal.
    assertParse(
      """
      func inExpr() {
        _ = 1.*1️⃣::magnitude
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          message: "expected module name in module selector",
          fixIts: ["insert module name"]
        )
      ],
      fixedSource: """
        func inExpr() {
          _ = 1.*
          <#identifier#>::magnitude
        }
        """
    )
    assertParse(
      """
      func inExpr() {
        _ = 1.1️⃣_::magnitude
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'_' cannot be used as an identifier here")
      ]
    )
    assertParse(
      """
      func inExpr() {
        _ = 1.1️⃣Self::magnitude
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'Self' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        func inExpr() {
          _ = 1.`Self`::magnitude
        }
        """
    )
    assertParse(
      """
      func inExpr() {
        _ = 1.1️⃣self::magnitude
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'self' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        func inExpr() {
          _ = 1.`self`::magnitude
        }
        """
    )
    assertParse(
      """
      func inExpr() {
        _ = 1.1️⃣inout::magnitude
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'inout' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        func inExpr() {
          _ = 1.`inout`::magnitude
        }
        """
    )
    assertParse(
      """
      func inExpr() {
        _ = 1.1️⃣Any::magnitude
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'Any' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        func inExpr() {
          _ = 1.`Any`::magnitude
        }
        """
    )
  }

  func testModuleSelectorAttrs() {
    XCTExpectFailure("incorrect uses not yet implemented")

    assertParse(
      """
      @_spi(main::Private)
      // expected-error@-1 {{SPI group cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{7-13=}}
      public struct BadImplementsAttr: CustomStringConvertible {}
      """
    )
    assertParse(
      """
      @_implements(main::CustomStringConvertible, 1️⃣Swift::description)
      // expected-error@-1 {{name of sibling declaration cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{41-48=}}
      public var stringValue: String { fatalError() }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' in @_implements arguments"),
      ]
    )
    assertParse(
      """
      @_specialize(target: main::fn(), spi: 1️⃣Swift::Private, where T == Swift::Int)
      // expected-error@-1 {{SPI group cannot be qualified with a module selector}} expected-note@-1 {{remove module selector from this name}} {{21-27=}}
      public func fn<T>() -> T { fatalError() }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' in attribute argument")
      ]
    )
    assertParse(
      """
      func fn(_: @isolated(1️⃣Swift::any) () -> Void) {} 
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' in attribute")
      ]
    )
    assertParse(
      """
      @_documentation(metadata: 1️⃣Swift::GroupName)
      func fn() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' in @_documentation argument")
      ]
    )
    assertParse(
      """
      @derivative(of: Swift::Foo.Swift::Bar.Swift::baz(), wrt: quux)
      func fn() {}
      """
    )
  }

  func testModuleSelectorExpr() {
    assertParse(
      "let x = 1️⃣Swift::do { 1 }",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' before 'do' block")
      ],
      experimentalFeatures: [.moduleSelector, .doExpressions]
    )
    assertParse(
      "let x = 1️⃣Swift::if y { 1 } else { 0 }",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' before 'if' statement")
      ]
    )
    assertParse(
      """
      let x = 1️⃣Swift::switch y {
      case true: 1
      case false: 0
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' before 'switch' statement")
      ]
    )
    assertParse(
      "fn(1️⃣Swift::&x)",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' before inout expression")
      ]
    )
    assertParse(
      #"_ = 1️⃣Swift::\main::Foo.BarKit::bar"#,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' before key path")
      ]
    )
    assertParse(
      "_ = 1️⃣Swift::-x",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' before operator")
      ]
    )
    assertParse(
      "_ = 1️⃣Swift::1",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' before integer literal")
      ]
    )
    assertParse(
      "_ = 1️⃣Swift::1.0",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' before floating literal")
      ]
    )
    assertParse(
      #"_ = 1️⃣Swift::@"fnord""#,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::@' before string literal")
      ]
    )
    assertParse(
      #"_ = 1️⃣Swift::"fnord""#,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' before string literal")
      ]
    )
    assertParse(
      "_ = 1️⃣Swift::/fnord/",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' before regex literal")
      ]
    )
    assertParse(
      "_ = 1️⃣Swift::nil",
      diagnostics: [
        // FIXME: improve location wording
        DiagnosticSpec(message: "unexpected code 'Swift::' in source file")
      ]
    )
    assertParse(
      "_ = 1️⃣Swift::true",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' before bool literal")
      ]
    )
    assertParse(
      "_ = Swift::identifier"
    )
    assertParse(
      "_ = Swift::self"
    )
    assertParse(
      "_ = Swift::init"
    )
    assertParse(
      "@attached(extension, names: Swift::deinit) macro m()"
    )
    assertParse(
      "@attached(extension, names: Swift::subscript) macro m()",
    )
    assertParse(
      "_ = Swift::Self"
    )
    assertParse(
      "_ = Swift::Any"
    )
    assertParse(
      "_ = Swift::$0"
    )
    assertParse(
      "_ = Swift::$foo"
    )
    assertParse(
      "_ = 1️⃣Swift::_",
      diagnostics: [
        // FIXME: improve location wording
        DiagnosticSpec(message: "unexpected code 'Swift::' in source file")
      ]
    )
    assertParse(
      "1️⃣Swift::_ = 1",
      diagnostics: [
        // FIXME: improve location wording
        DiagnosticSpec(message: "unexpected code 'Swift::' in source file")
      ]
    )
    assertParse(
      "_ = 1️⃣Swift::#foo",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' before macro expansion")
      ]
    )
    assertParse(
      "_ = #Swift::foo"
    )
    assertParse(
      "_ = 1️⃣Swift::{ 1 }",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' before closure")
      ]
    )
    assertParse(
      "_ = 1️⃣Swift::.random()",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' before member access")
      ]
    )
    assertParse(
      "_ = 1️⃣Swift::.main::random()",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' before member access")
      ]
    )
    assertParse(
      "_ = .main::random()"
    )
    assertParse(
      "_ = 1️⃣Swift::super.foo()",
      diagnostics: [
        // FIXME: improve location wording
        DiagnosticSpec(message: "unexpected code 'Swift::' in member access")
      ]
    )
    assertParse(
      "_ = 1️⃣Swift::(a, b)",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' before tuple")
      ]
    )
    assertParse(
      "_ = 1️⃣Swift::[a, b]",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' before array")
      ]
    )
    assertParse(
      "_ = 1️⃣Swift::2️⃣",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'Swift::' before expression"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected expression",
          fixIts: ["insert expression"]
        )
      ],
      fixedSource: "_ = Swift::<#expression#>"
    )

    assertParse(
      "_ = x.Swift::y"
    )
    assertParse(
      "_ = x.1️⃣Swift::1",
      diagnostics: [
        // FIXME: improve location wording
        DiagnosticSpec(message: "unexpected code 'Swift::' in member access")
      ]
    )
    assertParse(
      "_ = x.1️⃣Swift::self",
      diagnostics: [
        // FIXME: improve location wording
        DiagnosticSpec(message: "unexpected code 'Swift::' in member access")
      ]
    )
    assertParse(
      "_ = x.Swift::Self.self"
      // FIXME: inconsistent with type syntax
    )
    assertParse(
      "_ = x.Swift::Type.self"
      // FIXME: inconsistent with type syntax
    )
    assertParse(
      "_ = x.Swift::Protocol.self"
      // FIXME: inconsistent with type syntax
    )
    assertParse(
      "_ = myArray.reduce(0, Swift::+)"
    )
  }

  func testModuleSelectorStmt() {
    XCTExpectFailure("incorrect uses not yet implemented")

    assertParse(
      "if 1️⃣Swift::#available(macOS 15, *) {}",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' before availability condition")
      ]
    )
  }

  func testModuleSelectorType() {
    assertParse(
      "func fn(_: Swift::Self) {}"
    )
    assertParse(
      "func fn(_: Swift::Any) {}"
    )
    assertParse(
      "func fn(_: Swift::Foo) {}"
    )
    assertParse(
      "func fn(_: 1️⃣Swift::(Int, String)) {}",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' before tuple type")
      ]
    )
    assertParse(
      "func fn(_: 1️⃣Swift::[Int]) {}",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' before array type")
      ]
    )
    assertParse(
      "func fn(_: Swift::_) {}"
    )
    assertParse(
      "func fn(_: 1️⃣Swift::2️⃣) {}",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'Swift::' before type"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected type in parameter",
          fixIts: ["insert type"]
        ),
      ],
      fixedSource: "func fn(_: Swift::<#type#>) {}"
    )
    assertParse(
      "func fn(_: Foo.1️⃣Swift::Type) {}",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' in metatype")
      ]
    )
    assertParse(
      "func fn(_: Foo.1️⃣Swift::Protocol) {}",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Swift::' in metatype")
      ]
    )
    assertParse(
      "func fn(_: Foo.Swift::Bar) {}"
    )
    assertParse(
      "func fn(_: Foo.Swift::self) {}"
    )
  }
}
