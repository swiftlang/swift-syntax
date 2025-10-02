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

// This test file has been translated from swift/test/Parse/module_selector.swift

@_spi(ExperimentalLanguageFeatures) import SwiftParser
@_spi(ExperimentalLanguageFeatures) import SwiftSyntax
import XCTest

final class ModuleSelectorTests: ParserTestCase {
  func testModuleSelectorImports() {
    assertParse(
      """
      import struct ModuleSelectorTestingKit::A
      """,
      substructure: ImportDeclSyntax(
        importKindSpecifier: .keyword(.struct),
        path: [
          ImportPathComponentSyntax(
            name: .identifier("ModuleSelectorTestingKit"),
            trailingPeriod: .colonColonToken()
          ),
          ImportPathComponentSyntax(
            name: .identifier("A")
          ),
        ]
      )
    )

    assertParse(
      """
      import struct 1️⃣_::A
      """,
      diagnostics: [
        DiagnosticSpec(message: "'_' cannot be used as an identifier here")
      ]
    )

    assertParse(
      """
      import struct ModuleSelectorTestingKit::1️⃣Submodule::A
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'Submodule::' in import")
      ]
    )

    assertParse(
      """
      import struct ModuleSelectorTestingKit.Submodule1️⃣::A
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "submodule cannot be imported using module selector",
          fixIts: ["replace '::' with '.'"]
        )
      ],
      fixedSource: """
        import struct ModuleSelectorTestingKit.Submodule.A
        """
    )

    assertParse(
      """
      import ctypes1️⃣::bits
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "submodule cannot be imported using module selector",
          fixIts: ["replace '::' with '.'"]
        )
      ],
      fixedSource: """
        import ctypes.bits
        """
    )
  }

  func testModuleSelectorCorrectCode() {
    assertParse(
      """
      extension ModuleSelectorTestingKit::A {}
      """,
      substructure: ExtensionDeclSyntax(
        extendedType: makeType(moduleSelector: "ModuleSelectorTestingKit", name: "A"),
        memberBlock: MemberBlockSyntax {}
      )
    )

    assertParse(
      """
      extension A: @retroactive Swift::Equatable {}
      """,
      substructure: ExtensionDeclSyntax(
        extendedType: IdentifierTypeSyntax(name: .identifier("A")),
        inheritanceClause: InheritanceClauseSyntax(
          inheritedTypes: [
            InheritedTypeSyntax(
              type: AttributedTypeSyntax(
                specifiers: [],
                attributes: [
                  .attribute(
                    AttributeSyntax(
                      attributeName: makeType(name: "retroactive"),
                      arguments: nil
                    )
                  )
                ],
                baseType: makeType(moduleSelector: "Swift", name: "Equatable")
              )
            )
          ]
        ),
        memberBlock: MemberBlockSyntax {}
      )
    )

    assertParse(
      """
      @_implements(Swift::Equatable, ==(_:_:))
      public static func equals(_: ModuleSelectorTestingKit::A, _: ModuleSelectorTestingKit::A) -> Swift::Bool {
        Swift::fatalError()
      }
      """,
      substructure: FunctionDeclSyntax(
        attributes: [
          .attribute(
            AttributeSyntax(
              attributeName: makeType(name: "_implements"),
              leftParen: .leftParenToken(),
              arguments: .implementsArguments(
                ImplementsAttributeArgumentsSyntax(
                  type: makeType(moduleSelector: "Swift", name: "Equatable"),
                  declName: makeDeclRef(
                    baseName: .binaryOperator("=="),
                    argumentLabels: [nil, nil]
                  )
                )
              ),
              rightParen: .rightParenToken()
            )
          )
        ],
        modifiers: [
          DeclModifierSyntax(name: .keyword(.public)),
          DeclModifierSyntax(name: .keyword(.static)),
        ],
        name: .identifier("equals"),
        signature: FunctionSignatureSyntax(
          parameterClause: FunctionParameterClauseSyntax {
            FunctionParameterSyntax(
              firstName: .wildcardToken(),
              type: makeType(moduleSelector: "ModuleSelectorTestingKit", name: "A")
            )
            FunctionParameterSyntax(
              firstName: .wildcardToken(),
              type: makeType(moduleSelector: "ModuleSelectorTestingKit", name: "A")
            )
          },
          returnClause: ReturnClauseSyntax(
            type: makeType(moduleSelector: "Swift", name: "Bool")
          )
        ),
        body: CodeBlockSyntax {
          makeCall(
            callee: ExprSyntax(makeDeclRef(moduleSelector: "Swift", baseName: "fatalError")),
            arguments: [:]
          )
        }
      )
    )

    // FIXME: Add tests with autodiff @_differentiable(jvp:vjp:) and
    // @_derivative(of:)

    assertParse(
      """
      @_dynamicReplacement(for: ModuleSelectorTestingKit::negate())
      mutating func myNegate() {}
      """,
      substructure: FunctionDeclSyntax(
        attributes: [
          .attribute(
            AttributeSyntax(
              attributeName: makeType(name: "_dynamicReplacement"),
              leftParen: .leftParenToken(),
              arguments: .dynamicReplacementArguments(
                DynamicReplacementAttributeArgumentsSyntax(
                  declName: makeDeclRef(
                    moduleSelector: "ModuleSelectorTestingKit",
                    baseName: "negate",
                    argumentLabels: []
                  )
                )
              ),
              rightParen: .rightParenToken()
            )
          )
        ],
        modifiers: [
          DeclModifierSyntax(name: .keyword(.mutating))
        ],
        name: .identifier("myNegate"),
        signature: FunctionSignatureSyntax(
          parameterClause: FunctionParameterClauseSyntax {}
        ),
        body: CodeBlockSyntax {
        }
      )
    )

    // FIXME: Can we test @convention(witness_method:)?

    assertParse(
      """
      let fn: (Swift::Int, Swift::Int) -> Swift::Int = (Swift::+)
      """,
      substructure: VariableDeclSyntax(bindingSpecifier: .keyword(.let)) {
        PatternBindingSyntax(
          pattern: IdentifierPatternSyntax(identifier: "fn"),
          typeAnnotation: TypeAnnotationSyntax(
            type: FunctionTypeSyntax(
              parameters: TupleTypeElementListSyntax {
                TupleTypeElementSyntax(type: makeType(moduleSelector: "Swift", name: "Int"))
                TupleTypeElementSyntax(type: makeType(moduleSelector: "Swift", name: "Int"))
              },
              returnClause: ReturnClauseSyntax(
                type: makeType(moduleSelector: "Swift", name: "Int")
              )
            )
          ),
          initializer: InitializerClauseSyntax(
            value: TupleExprSyntax {
              LabeledExprSyntax(expression: makeDeclRef(moduleSelector: "Swift", baseName: .binaryOperator("+")))
            }
          )
        )
      }
    )

    assertParse(
      """
      let magnitude: Int.Swift::Magnitude = main::magnitude
      """,
      substructure: VariableDeclSyntax(bindingSpecifier: .keyword(.let)) {
        PatternBindingSyntax(
          pattern: IdentifierPatternSyntax(identifier: "magnitude"),
          typeAnnotation: TypeAnnotationSyntax(
            type: makeMember(
              of: makeType(name: "Int"),
              moduleSelector: "Swift",
              name: "Magnitude"
            )
          ),
          initializer: InitializerClauseSyntax(
            value: makeDeclRef(moduleSelector: "main", baseName: "magnitude")
          )
        )
      }
    )

    assertParse(
      """
      if Swift::Bool.Swift::random() {
      }
      """,
      substructure: IfExprSyntax(
        conditions: ConditionElementListSyntax {
          ConditionElementSyntax(
            condition: .expression(
              ExprSyntax(
                makeCall(
                  callee: MemberAccessExprSyntax(
                    base: makeDeclRef(moduleSelector: "Swift", baseName: "Bool"),
                    declName: makeDeclRef(moduleSelector: "Swift", baseName: "random")
                  ),
                  arguments: [:]
                )
              )
            )
          )
        }
      ) {}
    )

    assertParse(
      """
      self.ModuleSelectorTestingKit::negate()
      """,
      substructure: makeCall(
        callee: MemberAccessExprSyntax(
          base: makeDeclRef(baseName: .keyword(.self)),
          declName: makeDeclRef(moduleSelector: "ModuleSelectorTestingKit", baseName: "negate")
        ),
        arguments: [:]
      )
    )

    assertParse(
      """
      self = ModuleSelectorTestingKit::A(value: .Swift::min)
      """,
      substructure: SequenceExprSyntax {
        makeDeclRef(baseName: .keyword(.self))
        AssignmentExprSyntax()
        makeCall(
          callee: makeDeclRef(moduleSelector: "ModuleSelectorTestingKit", baseName: "A"),
          arguments: [
            "value": ExprSyntax(
              MemberAccessExprSyntax(
                declName: makeDeclRef(moduleSelector: "Swift", baseName: "min")
              )
            )
          ]
        )
      }
    )

    assertParse(
      """
      self = A.ModuleSelectorTestingKit::init(value: .min)
      """,
      substructure: SequenceExprSyntax {
        makeDeclRef(baseName: .keyword(.self))
        AssignmentExprSyntax()
        makeCall(
          callee: MemberAccessExprSyntax(
            base: makeDeclRef(baseName: "A"),
            declName: makeDeclRef(moduleSelector: "ModuleSelectorTestingKit", baseName: .keyword(.`init`))
          ),
          arguments: [
            "value": ExprSyntax(
              MemberAccessExprSyntax(
                declName: makeDeclRef(baseName: "min")
              )
            )
          ]
        )
      }
    )

    assertParse(
      """
      self.main::myNegate()
      """,
      substructure: makeCall(
        callee: MemberAccessExprSyntax(
          base: makeDeclRef(baseName: .keyword(.self)),
          declName: makeDeclRef(moduleSelector: "main", baseName: "myNegate")
        ),
        arguments: [:]
      )
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
      @main::available var use2
      """,
      substructure: AttributeSyntax(
        attributeName: makeType(moduleSelector: "main", name: "available")
      )
    )

    assertParse(
      """
      @main::available(foo: bar) var use3
      """,
      substructure: AttributeSyntax(
        attributeName: makeType(moduleSelector: "main", name: "available"),
        leftParen: .leftParenToken(),
        arguments: .argumentList(
          [
            LabeledExprSyntax(
              label: "foo",
              colon: .colonToken(),
              expression: makeDeclRef(baseName: "bar")
            )
          ]
        ),
        rightParen: .rightParenToken()
      )
    )

    assertParse(
      """
      func builderUser2(@main::MyBuilder fn: () -> Void) {}
      """,
      substructure: FunctionParameterSyntax(
        attributes: [
          .attribute(
            AttributeSyntax(
              attributeName: makeType(moduleSelector: "main", name: "MyBuilder")
            )
          )
        ],
        firstName: "fn",
        type: TypeSyntax("() -> Void")
      )
    )
  }

  func testModuleSelectorWhitespace() {
    assertParse(
      """
      _ = Swift::print
      """,
      substructure: makeDeclRef(moduleSelector: "Swift", baseName: "print")
    )
    assertParse(
      """
      _ = Swift:: print
      """,
      substructure: makeDeclRef(moduleSelector: "Swift", baseName: "print")
    )
    assertParse(
      """
      _ = Swift ::print
      """,
      substructure: makeDeclRef(moduleSelector: "Swift", baseName: "print")
    )
    assertParse(
      """
      _ = Swift :: print
      """,
      substructure: makeDeclRef(moduleSelector: "Swift", baseName: "print")
    )
    assertParse(
      """
      _ = Swift::1️⃣
      print
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier", fixIts: ["insert identifier"])
      ],
      fixedSource: """
        _ = Swift::<#identifier#>
        print
        """
    )
    assertParse(
      """
      _ = Swift
      ::print
      """,
      substructure: makeDeclRef(moduleSelector: "Swift", baseName: "print")
    )
    assertParse(
      """
      _ = Swift ::1️⃣
      print
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier", fixIts: ["insert identifier"])
      ],
      fixedSource: """
        _ = Swift ::<#identifier#>
        print
        """
    )
    assertParse(
      """
      _ = Swift
      :: print
      """,
      substructure: makeDeclRef(moduleSelector: "Swift", baseName: "print")
    )
    assertParse(
      """
      _ = Swift
      ::1️⃣
      print
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier", fixIts: ["insert identifier"])
      ],
      fixedSource: """
        _ = Swift
        ::<#identifier#>
        print
        """
    )
  }

  func testModuleSelectorIncorrectFuncSignature() {
    assertParse(
      """
      func main1️⃣::decl1() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '::decl1' before parameter clause")
      ]
    )
    assertParse(
      """
      func decl1(
        main1️⃣::p1: Swift::A
      ) {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code '::p1' in parameter"
        )
      ]
    )

    // Round-tripping failures:
    assertParse(
      """
      func decl1(
        main1️⃣::p1: 2️⃣::A
      ) {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code '::p1' in parameter"
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
        main1️⃣::p1: Swift::2️⃣
      ) {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code '::p1' in parameter"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected identifier in type",
          fixIts: ["insert identifier"]
        ),
      ],
      fixedSource: """
        func decl1(
          main::p1: Swift::<#identifier#>
        ) {}
        """
    )

    assertParse(
      """
      func decl1(
        main1️⃣::label p2: Swift::inout2️⃣ 3️⃣A
      ) {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code '::label p2' in parameter"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected ',' in parameter",
          fixIts: ["insert ','"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "expected identifier and ':' in parameter",
          fixIts: ["insert identifier and ':'"]
        ),
      ],
      fixedSource: """
        func decl1(
          main::label p2: Swift::inout, <#identifier#>: A
        ) {}
        """
    )
    assertParse(
      """
      func decl1(
        label main1️⃣::p3: @Swift::escaping () -> A
      ) {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code '::p3' in parameter"
        )
      ]
    )
  }

  func testModuleSelectorIncorrectBindingDecls() {
    assertParse(
      """
      let main1️⃣::decl1a = "a"
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '=' in variable",
          fixIts: ["insert '='"]
        ),
        DiagnosticSpec(
          message: "expected module name in module selector",
          fixIts: ["insert module name"]
        ),
      ],
      fixedSource: """
        let main = <#identifier#>::decl1a = "a"
        """
    )

    // Found by mutation testing:
    assertParse(
      """
      let let1️⃣::decl1a = "a"
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected pattern in value binding pattern",
          fixIts: ["insert pattern"]
        ),
        DiagnosticSpec(
          message: "expected '=' in variable",
          fixIts: ["insert '='"]
        ),
        DiagnosticSpec(
          message: "expected module name in module selector",
          fixIts: ["insert module name"]
        ),
      ],
      fixedSource: """
        let let<#pattern#> = <#identifier#>::decl1a = "a"
        """
    )

    assertParse(
      """
      var main1️⃣::decl1b = "b"
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '=' in variable",
          fixIts: ["insert '='"]
        ),
        DiagnosticSpec(
          message: "expected module name in module selector",
          fixIts: ["insert module name"]
        ),
      ],
      fixedSource: """
        var main = <#identifier#>::decl1b = "b"
        """
    )
    assertParse(
      """
      let (main1️⃣::decl1c, Swift::decl1d) = ("c", "d")
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected code '::decl1c, Swift::decl1d' in tuple pattern"
        )
      ]
    )
    assertParse(
      """
      if let (main1️⃣::decl1e, Swift::decl1f) = Optional(("e", "f")) {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected code '::decl1e, Swift::decl1f' in tuple"
        )
      ]
    )
    assertParse(
      """
      guard let (main1️⃣::decl1g, Swift::decl1h) = Optional(("g", "h")) else { return }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected code '::decl1g, Swift::decl1h' in tuple"
        )
      ]
    )
    assertParse(
      """
      switch Optional(main::decl1g) {
      case Optional.some(let Swift1️⃣::decl1i):
        break
      case .none:
        break
      }
      """,
      diagnostics: [
        // FIXME: Function call???
        DiagnosticSpec(
          message: "unexpected code '::decl1i' in function call"
        )
      ]
    )
    assertParse(
      """
      switch Optional(main::decl1g) {
      case let Optional.some(Swift1️⃣::decl1j):
        break
      case .none:
        break
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected code '::decl1j' in function call"
        )
      ]
    )
    assertParse(
      """
      switch Optional(main::decl1g) {
      case let Swift1️⃣::decl1k?:
        break
      case .none:
        break
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected code '::decl1k?' in switch case"
        )
      ]
    )
    assertParse(
      """
      for main1️⃣::decl1l in "lll" {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected code '::decl1l' in 'for' statement"
        )
      ]
    )
  }

  func testModuleSelectorIncorrectClosureDecls() {
    assertParse(
      // This gets radically misinterpreted as two statements followed by some invalid code.
      """
      "lll".forEach { [2️⃣Swift::magnitude]
        main::elem 1️⃣in print(elem)
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code 'in print(elem)' in closure"
        )
      ]
    )
    assertParse(
      """
      "lll".forEach { (main1️⃣::elem) in print(elem) }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected code '::elem' in parameter clause"
        )
      ]
    )
    assertParse(
      """
      "lll".forEach { (main1️⃣::elem) -> Void in print(elem) }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected code '::elem' in parameter clause"
        )
      ]
    )
    assertParse(
      """
      "lll".forEach { (main1️⃣::elem: Character) -> Void in print(elem) }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code '::elem: Character' in parameter clause"
        )
      ]
    )
  }

  func testModuleSelectorIncorrectTypeDecls() {
    assertParse(
      """
      enum main1️⃣::decl2 {
        case Swift2️⃣::decl2a
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code '::decl2' in enum"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code '::decl2a' in enum"
        ),
      ]
    )
    assertParse(
      """
      struct main1️⃣::decl3 {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '::decl3' in struct")
      ]
    )
    assertParse(
      """
      class main1️⃣::decl4<Swift::T> {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code '::decl4<Swift::T>' in class"
        )
      ]
    )
    assertParse(
      """
      typealias main1️⃣::decl5 = Swift::Bool
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code '::decl5' in typealias declaration"
        )
      ]
    )
    assertParse(
      """
      protocol main1️⃣::decl6 {
        associatedtype Swift2️⃣::decl6a
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code '::decl6' in protocol"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code '::decl6a' in protocol"
        ),
      ]
    )
  }

  func testModuleSelectorIncorrectGlobalVarDecls() {
    assertParse(
      """
      let main1️⃣::decl7 = 7
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '=' in variable",
          fixIts: ["insert '='"]
        ),
        DiagnosticSpec(
          message: "expected module name in module selector",
          fixIts: ["insert module name"]
        ),
      ],
      fixedSource: """
        let main = <#identifier#>::decl7 = 7
        """
    )
    assertParse(
      """
      var main1️⃣::decl8 = 8 {
        willSet(Swift2️⃣::newValue) {}
        didSet(Foo3️⃣::oldValue) {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '=' in variable",
          fixIts: ["insert '='"]
        ),
        DiagnosticSpec(
          message: "expected module name in module selector",
          fixIts: ["insert module name"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code '::newValue' in accessor"
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "unexpected code '::oldValue' in accessor"
        ),
      ],
      fixedSource: """
        var main = <#identifier#>::decl8 = 8 {
          willSet(Swift::newValue) {}
          didSet(Foo::oldValue) {}
        }
        """
    )
  }

  func testModuleSelectorIncorrectNestedDecls() {
    assertParse(
      """
      struct Parent {
        func main1️⃣::decl1() {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '::decl1' before parameter clause")
      ]
    )
    assertParse(
      """
      struct Parent {
        enum main1️⃣::decl2 {
          case Swift2️⃣::decl2a
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code '::decl2' in enum"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code '::decl2a' in enum"
        ),
      ]
    )
    assertParse(
      """
      struct Parent {
        struct main1️⃣::decl3 {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '::decl3' in struct")
      ]
    )
    assertParse(
      """
      struct Parent {
        class main1️⃣::decl4 {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '::decl4' in class")
      ]
    )
    assertParse(
      """
      struct Parent {
        typealias main1️⃣::decl5 = Swift::Bool
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected code '::decl5' in typealias declaration"
        )
      ]
    )
  }

  func testModuleSelectorMacroDecls() {
    assertParse(
      """
      struct CreatesDeclExpectation {
        #main::myMacro()
      }
      """,
      substructure: MacroExpansionDeclSyntax(
        moduleSelector: ModuleSelectorSyntax(moduleName: "main"),
        macroName: "myMacro",
        leftParen: .leftParenToken(),
        arguments: [],
        rightParen: .rightParenToken()
      )
    )
  }

  func testModuleSelectorIncorrectRuntimeBaseAttr() {
    // Should be diagnosed in ASTGen:
    assertParse(
      """
      @_swift_native_objc_runtime_base(1️⃣main::BaseClass)
      class C1 {}
      """,
      substructure: AttributeSyntax(
        attributeName: makeType(name: "_swift_native_objc_runtime_base"),
        leftParen: .leftParenToken(),
        arguments: .argumentList(
          [
            LabeledExprSyntax(expression: makeDeclRef(moduleSelector: "main", baseName: "BaseClass"))
          ]
        ),
        rightParen: .rightParenToken()
      )
    )
  }

  func testModuleSelectorOperatorDecls() {
    assertParse(
      """
      infix operator <<<<< : Swift1️⃣::AdditionPrecedence
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          message: "expected module name in module selector",
          fixIts: ["insert module name"]
        ),
      ],
      fixedSource: """
        infix operator <<<<< : Swift
        <#identifier#>::AdditionPrecedence
        """
    )
    assertParse(
      """
      precedencegroup main1️⃣::PG1 {
        higherThan: Swift2️⃣::AdditionPrecedence
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected code '::PG1' in precedencegroup"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code '::AdditionPrecedence' in precedencegroup"
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
        DiagnosticSpec(message: "expected type in type annotation", fixIts: ["insert type"]),
        DiagnosticSpec(message: "unexpected code '*::Int' in source file"),
      ],
      fixedSource: """
        var c: <#type#>*::Int
        """
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
      var g: 1️⃣inout2️⃣::Int
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected type in type annotation",
          fixIts: ["insert type"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected pattern in variable",
          fixIts: ["insert pattern"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected '=' in variable",
          fixIts: ["insert '='"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected module name in module selector",
          fixIts: ["insert module name"]
        ),
      ],
      fixedSource: """
        var g: <#type#>inout<#pattern#> = <#identifier#>::Int
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
        DiagnosticSpec(message: "expected type in array type", fixIts: ["insert type"]),
        DiagnosticSpec(message: "unexpected code '*::Int' in array type"),
      ],
      fixedSource: """
        var cArray: [<#type#>*::Int]
        """
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
      var gArray: [1️⃣inout2️⃣::Int3️⃣]
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected type and ']' to end array type",
          fixIts: ["insert type and ']'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected pattern in variable",
          fixIts: ["insert pattern"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected '=' in variable",
          fixIts: ["insert '='"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected module name in module selector",
          fixIts: ["insert module name"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "unexpected code ']' in source file"
        ),
      ],
      fixedSource: """
        var gArray: [<#type#>]inout<#pattern#> = <#identifier#>::Int]
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
        DiagnosticSpec(message: "unexpected code '.*::Index' in source file")
      ]
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
      var gIndex: String.inout1️⃣::Index
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '=' in variable",
          fixIts: ["insert '='"]
        ),
        DiagnosticSpec(
          message: "expected module name in module selector",
          fixIts: ["insert module name"]
        ),
      ],
      fixedSource: """
        var gIndex: String.inout = <#identifier#>::Index
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
        DiagnosticSpec(message: "unexpected code '*::print()' in function")
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
        inout1️⃣::print()
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected pattern in variable", fixIts: ["insert pattern"]),
        DiagnosticSpec(message: "expected '=' in variable", fixIts: ["insert '='"]),
        DiagnosticSpec(message: "expected module name in module selector", fixIts: ["insert module name"]),
      ],
      fixedSource: """
        func inExpr() {
          inout<#pattern#> = <#identifier#>::print()
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
        ),
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
        _ = 1.inout1️⃣::magnitude
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
        ),
      ],
      fixedSource: """
        func inExpr() {
          _ = 1.inout
          <#identifier#>::magnitude
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
    // 'main::Private' should be diagnosed in ASTGen
    assertParse(
      """
      @_spi(main::Private)
      public struct BadImplementsAttr: CustomStringConvertible {}
      """,
      substructure: AttributeSyntax(
        attributeName: makeType(name: "_spi"),
        leftParen: .leftParenToken(),
        arguments: .argumentList(
          [
            LabeledExprSyntax(expression: makeDeclRef(moduleSelector: "main", baseName: "Private"))
          ]
        ),
        rightParen: .rightParenToken()
      )
    )
    // 'Swift::description' should be diagnosed in ASTGen
    assertParse(
      """
      @_implements(main::CustomStringConvertible, Swift::description)
      public var stringValue: String { fatalError() }
      """,
      substructure: AttributeSyntax(
        attributeName: makeType(name: "_implements"),
        leftParen: .leftParenToken(),
        arguments: .implementsArguments(
          ImplementsAttributeArgumentsSyntax(
            type: makeType(moduleSelector: "main", name: "CustomStringConvertible"),
            declName: makeDeclRef(moduleSelector: "Swift", baseName: "description")
          )
        ),
        rightParen: .rightParenToken()
      )
    )
    assertParse(
      """
      @_specialize(target: main::fn(), spi: Swift1️⃣::Private, where T == Swift::Int)
      public func fn<T>() -> T { fatalError() }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '::Private, where T == Swift::Int' in attribute")
      ]
    )
    assertParse(
      """
      func fn(_: @isolated(Swift1️⃣::any) () -> Void) {} 
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '::any' in attribute")
      ]
    )
    assertParse(
      """
      @_documentation(metadata: Swift1️⃣::GroupName)
      func fn() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '::GroupName' in attribute")
      ]
    )
    assertParse(
      """
      @derivative(of: Swift::Foo.Swift::Bar.Swift::baz(), wrt: quux)
      func fn() {}
      """,
      substructure: AttributeSyntax(
        attributeName: makeType(name: "derivative"),
        leftParen: .leftParenToken(),
        arguments: .derivativeRegistrationArguments(
          DerivativeAttributeArgumentsSyntax(
            originalDeclName: MemberAccessExprSyntax(
              base: TypeExprSyntax(
                type: makeMember(
                  of: makeType(moduleSelector: "Swift", name: "Foo"),
                  moduleSelector: "Swift",
                  name: "Bar"
                )
              ),
              declName: makeDeclRef(moduleSelector: "Swift", baseName: "baz", argumentLabels: [])
            ),
            comma: .commaToken(),
            arguments: DifferentiabilityWithRespectToArgumentSyntax(
              arguments: .argument(
                DifferentiabilityArgumentSyntax(argument: "quux")
              )
            )
          )
        ),
        rightParen: .rightParenToken()
      )
    )
  }

  func testModuleSelectorExpr() {
    assertParse(
      "let x = Swift::1️⃣do { 1 }",
      substructure: FunctionCallExprSyntax(
        calledExpression: makeDeclRef(moduleSelector: "Swift", baseName: "do"),
        leftParen: nil,
        arguments: [],
        rightParen: nil,
        trailingClosure: ClosureExprSyntax {
          CodeBlockItemSyntax(item: .expr(ExprSyntax(IntegerLiteralExprSyntax(integerLiteral: 1))))
        }
      ),
      experimentalFeatures: [.doExpressions]
    )
    assertParse(
      """
      let x = Swift::1️⃣
      do { 1 }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in variable", fixIts: ["insert identifier"])
      ],
      fixedSource: """
        let x = Swift::<#identifier#>
        do { 1 }
        """,
      experimentalFeatures: [.doExpressions]
    )
    assertParse(
      "let x = Swift::if1️⃣ y { 1 } 2️⃣else { 0 }",
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code 'else { 0 }' in source file"
        ),
      ],
      fixedSource: """
        let x = Swift::if
        y { 1 } else { 0 }
        """
    )
    assertParse(
      """
      let x = Swift::1️⃣
      if y { 1 } else { 0 }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in variable", fixIts: ["insert identifier"])
      ],
      fixedSource: """
        let x = Swift::<#identifier#>
        if y { 1 } else { 0 }
        """
    )
    assertParse(
      """
      let x = Swift::switch1️⃣ y2️⃣ {
      3️⃣case true: 1
      4️⃣case false: 0
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "'case' can only appear inside a 'switch' statement or 'enum' declaration"
        ),
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: "'case' can only appear inside a 'switch' statement or 'enum' declaration"
        ),
      ],
      fixedSource: """
        let x = Swift::switch
        y
        {
        case true: 1
        case false: 0
        }
        """
    )
    assertParse(
      """
      let x = Swift::1️⃣
      switch y {
      case true: 1
      case false: 0
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in variable", fixIts: ["insert identifier"])
      ],
      fixedSource: """
        let x = Swift::<#identifier#>
        switch y {
        case true: 1
        case false: 0
        }
        """
    )
    assertParse(
      "fn(Swift::1️⃣&x)",
      diagnostics: [
        DiagnosticSpec(
          message: "expected identifier in function call",
          fixIts: ["insert identifier"]
        ),
        DiagnosticSpec(message: "unexpected code '&x' in function call"),
      ],
      fixedSource: "fn(Swift::<#identifier#>&x)"
    )
    assertParse(
      #"_ = Swift::1️⃣\main::Foo.BarKit::bar"#,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier", fixIts: ["insert identifier"])
      ],
      fixedSource: #"_ = Swift::<#identifier#>\main::Foo.BarKit::bar"#
    )
    assertParse(
      #"_ = \main::Foo.BarKit::bar"#,
      substructure: KeyPathExprSyntax(
        root: makeType(moduleSelector: "main", name: "Foo"),
        components: [
          KeyPathComponentSyntax(
            period: .periodToken(),
            component: .property(
              KeyPathPropertyComponentSyntax(
                declName: makeDeclRef(moduleSelector: "BarKit", baseName: "bar")
              )
            )
          )
        ]
      )
    )
    assertParse(
      "_ = Swift::1️⃣-x",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier", fixIts: ["insert identifier"])
      ],
      fixedSource: "_ = Swift::<#identifier#>-x"
    )
    assertParse(
      "_ = Swift::1️⃣1",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier", fixIts: ["insert identifier"])
      ],
      fixedSource: "_ = Swift::<#identifier#>1"
    )
    assertParse(
      "_ = Swift::1️⃣1.0",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier", fixIts: ["insert identifier"])
      ],
      fixedSource: "_ = Swift::<#identifier#>1.0"
    )
    assertParse(
      #"_ = Swift::1️⃣@"fnord""#,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier", fixIts: ["insert identifier"]),
        DiagnosticSpec(message: "string literals in Swift are not preceded by an '@' sign", fixIts: ["remove '@'"]),
      ],
      fixedSource: #"_ = Swift::<#identifier#>"fnord""#
    )
    assertParse(
      #"_ = Swift::1️⃣"fnord""#,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier", fixIts: ["insert identifier"])
      ],
      fixedSource: #"_ = Swift::<#identifier#>"fnord""#
    )
    assertParse(
      "_ = Swift::1️⃣/fnord/",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier", fixIts: ["insert identifier"])
      ],
      fixedSource: "_ = Swift::<#identifier#>/fnord/"
    )
    assertParse(
      "_ = Swift::nil",
      substructure: makeDeclRef(moduleSelector: "Swift", baseName: "nil")
    )
    assertParse(
      "_ = Swift::1️⃣true",
      substructure: makeDeclRef(moduleSelector: "Swift", baseName: "true")
    )
    assertParse(
      "_ = Swift::identifier",
      substructure: makeDeclRef(moduleSelector: "Swift", baseName: "identifier")
    )
    assertParse(
      "_ = Swift::self",
      substructure: makeDeclRef(moduleSelector: "Swift", baseName: "self")
    )
    assertParse(
      "_ = Swift::init",
      substructure: makeDeclRef(moduleSelector: "Swift", baseName: .keyword(.`init`))
    )
    assertParse(
      "@attached(extension, names: 1️⃣Swift::deinit) macro m()",
      substructure: makeDeclRef(moduleSelector: "Swift", baseName: .keyword(.`deinit`)),
      substructureAfterMarker: "1️⃣"
    )
    assertParse(
      "@attached(extension, names: 1️⃣Swift::subscript) macro m()",
      substructure: makeDeclRef(moduleSelector: "Swift", baseName: .keyword(.subscript)),
      substructureAfterMarker: "1️⃣"
    )
    assertParse(
      "_ = Swift::Self",
      substructure: makeDeclRef(moduleSelector: "Swift", baseName: "Self")
    )
    assertParse(
      "_ = Swift::Any",
      substructure: makeDeclRef(moduleSelector: "Swift", baseName: "Any")
    )
    assertParse(
      "_ = Swift::1️⃣$0",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier", fixIts: ["insert identifier"])
      ],
      fixedSource: "_ = Swift::<#identifier#>$0"
    )
    assertParse(
      "_ = Swift::$foo",
      substructure: makeDeclRef(moduleSelector: "Swift", baseName: .identifier("$foo"))
    )
    assertParse(
      "_ = Swift::1️⃣_",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier", fixIts: ["insert identifier"])
      ],
      fixedSource: "_ = Swift::<#identifier#>_"
    )
    assertParse(
      "Swift::1️⃣_ = 1",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier", fixIts: ["insert identifier"])
      ],
      fixedSource: "Swift::<#identifier#>_ = 1"
    )
    assertParse(
      "_ = Swift::1️⃣#foo",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier", fixIts: ["insert identifier"])
      ],
      fixedSource: "_ = Swift::<#identifier#>#foo"
    )
    assertParse(
      "_ = #Swift::foo",
      substructure: MacroExpansionExprSyntax(
        moduleSelector: ModuleSelectorSyntax(moduleName: "Swift"),
        macroName: "foo",
        arguments: []
      )
    )
    assertParse(
      "_ = Swift::1️⃣{ 1 }",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in function call", fixIts: ["insert identifier"])
      ],
      fixedSource: "_ = Swift::<#identifier#> { 1 }"
    )
    assertParse(
      "_ = Swift::1️⃣.random()",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in member access", fixIts: ["insert identifier"])
      ],
      fixedSource: "_ = Swift::<#identifier#>.random()"
    )
    assertParse(
      "_ = Swift::1️⃣.main::random()",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in member access", fixIts: ["insert identifier"])
      ],
      fixedSource: "_ = Swift::<#identifier#>.main::random()"
    )
    assertParse(
      "_ = .main::random()",
      substructure: MemberAccessExprSyntax(
        declName: makeDeclRef(moduleSelector: "main", baseName: "random")
      )
    )
    assertParse(
      "_ = Swift::super.foo()",
      substructure: makeDeclRef(moduleSelector: "Swift", baseName: "super")
    )
    assertParse(
      "_ = Swift::1️⃣(a, b)",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in function call", fixIts: ["insert identifier"])
      ],
      fixedSource: "_ = Swift::<#identifier#>(a, b)"
    )
    assertParse(
      "_ = Swift::1️⃣[a, b]",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in subscript", fixIts: ["insert identifier"])
      ],
      fixedSource: "_ = Swift::<#identifier#>[a, b]"
    )
    assertParse(
      "_ = Swift::1️⃣",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier", fixIts: ["insert identifier"])
      ],
      fixedSource: "_ = Swift::<#identifier#>"
    )

    assertParse(
      "_ = x.Swift::y",
      substructure: MemberAccessExprSyntax(
        base: makeDeclRef(baseName: "x"),
        declName: makeDeclRef(moduleSelector: "Swift", baseName: "y")
      )
    )
    assertParse(
      "_ = x.Swift::1️⃣1",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in member access", fixIts: ["insert identifier"])
      ],
      fixedSource: "_ = x.Swift::<#identifier#>1"
    )
    assertParse(
      "_ = x.Swift::self",
      substructure: MemberAccessExprSyntax(
        base: makeDeclRef(baseName: "x"),
        declName: makeDeclRef(
          moduleSelector: "Swift",
          baseName: "self"
        )
      )
    )
    assertParse(
      "_ = x.Swift::Self.self",
      substructure: MemberAccessExprSyntax(
        base: MemberAccessExprSyntax(
          base: makeDeclRef(baseName: "x"),
          declName: makeDeclRef(moduleSelector: "Swift", baseName: "Self")
        ),
        declName: makeDeclRef(baseName: .keyword(.`self`))
      )
    )
    assertParse(
      "_ = x.Swift::Type.self",
      substructure: MemberAccessExprSyntax(
        base: MemberAccessExprSyntax(
          base: makeDeclRef(baseName: "x"),
          declName: makeDeclRef(moduleSelector: "Swift", baseName: "Type")
        ),
        declName: makeDeclRef(baseName: .keyword(.`self`))
      )
    )
    assertParse(
      "_ = x.Swift::Protocol.self",
      substructure: MemberAccessExprSyntax(
        base: MemberAccessExprSyntax(
          base: makeDeclRef(baseName: "x"),
          declName: makeDeclRef(moduleSelector: "Swift", baseName: "Protocol")
        ),
        declName: makeDeclRef(baseName: .keyword(.`self`))
      )
    )
    assertParse(
      "_ = myArray.reduce(0, 1️⃣Swift::+)",
      substructure: makeDeclRef(moduleSelector: "Swift", baseName: .binaryOperator("+")),
      substructureAfterMarker: "1️⃣"
    )
  }

  func testModuleSelectorStmt() {
    assertParse(
      "if Swift::1️⃣#available(macOS 15, *) {}",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in 'if' statement", fixIts: ["insert identifier"]),
        DiagnosticSpec(message: "unexpected code '#available(macOS 15, *)' in 'if' statement"),
      ],
      fixedSource: "if Swift::<#identifier#> #available(macOS 15, *) {}"
    )
  }

  func testModuleSelectorType() {
    assertParse(
      "func fn(_: Swift::Self) {}",
      substructure: makeType(moduleSelector: "Swift", name: "Self")
    )
    assertParse(
      "func fn(_: Swift::Any) {}",
      substructure: makeType(moduleSelector: "Swift", name: "Any")
    )
    assertParse(
      "func fn(_: Swift::Foo) {}",
      substructure: makeType(moduleSelector: "Swift", name: "Foo")
    )
    assertParse(
      "func fn(_: Swift::1️⃣(Int, String)) {}",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in type", fixIts: ["insert identifier"]),
        DiagnosticSpec(message: "unexpected code '(Int, String)' in parameter clause"),
      ],
      fixedSource: "func fn(_: Swift::<#identifier#>(Int, String)) {}"
    )
    assertParse(
      "func fn(_: Swift::1️⃣[Int]) {}",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in type", fixIts: ["insert identifier"]),
        DiagnosticSpec(message: "unexpected code '[Int]' in parameter clause"),
      ],
      fixedSource: "func fn(_: Swift::<#identifier#>[Int]) {}"
    )
    assertParse(
      "func fn(_: Swift::1️⃣_) {}",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in type", fixIts: ["insert identifier"]),
        DiagnosticSpec(message: "unexpected code '_' in parameter clause"),
      ],
      fixedSource: "func fn(_: Swift::<#identifier#>_) {}"
    )
    assertParse(
      "func fn(_: Swift::1️⃣) {}",
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in type", fixIts: ["insert identifier"])
      ],
      fixedSource: "func fn(_: Swift::<#identifier#>) {}"
    )
    // TODO: Add equivalent test case for legacy parser
    assertParse(
      "func fn(_: Foo.1️⃣Swift::Type) {}",
      substructure: makeMember(
        of: makeType(name: "Foo"),
        moduleSelector: "Swift",
        name: "Type"
      )
    )
    // TODO: Add equivalent test case for legacy parser
    assertParse(
      "func fn(_: Foo.1️⃣Swift::Protocol) {}",
      substructure: makeMember(
        of: makeType(name: "Foo"),
        moduleSelector: "Swift",
        name: "Protocol"
      )
    )
    assertParse(
      "func fn(_: Foo.Swift::Bar) {}",
      substructure: makeMember(
        of: makeType(name: "Foo"),
        moduleSelector: "Swift",
        name: "Bar"
      )
    )
    assertParse(
      "func fn(_: Foo.Swift::self) {}",
      substructure: makeMember(
        of: makeType(name: "Foo"),
        moduleSelector: "Swift",
        name: "self"
      )
    )
  }

  func testModuleSelectorSubmodule() {
    assertParse(
      "_ = Foundation::1️⃣NSData::NSData()",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'NSData::' in module selector")
      ]
    )

    assertParse(
      "_ = Foundation::1️⃣NSData::Fnord::NSData()",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'NSData::Fnord::' in module selector")
      ]
    )

    assertParse(
      """
      _ = Foundation::1️⃣NSData::2️⃣
      Fnord::NSData()
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'NSData::' in module selector"),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected identifier",
          fixIts: ["insert identifier"]
        ),
      ],
      fixedSource: """
        _ = Foundation::NSData::<#identifier#>
        Fnord::NSData()
        """
    )
  }
}

// MARK: - Syntax tree construction helpers

private func makeType(moduleSelector: TokenSyntax? = nil, name: TokenSyntax) -> IdentifierTypeSyntax {
  return IdentifierTypeSyntax(
    moduleSelector: moduleSelector.map { ModuleSelectorSyntax(moduleName: $0) },
    name: name
  )
}

private func makeDeclRef(
  moduleSelector: TokenSyntax? = nil,
  baseName: TokenSyntax,
  argumentLabels: [TokenSyntax?]? = nil
) -> DeclReferenceExprSyntax {
  return DeclReferenceExprSyntax(
    moduleSelector: moduleSelector.map { ModuleSelectorSyntax(moduleName: $0) },
    baseName: baseName,
    argumentNames: argumentLabels.map { argumentLabels in
      DeclNameArgumentsSyntax(
        arguments: DeclNameArgumentListSyntax(
          argumentLabels.map { DeclNameArgumentSyntax(name: $0 ?? .wildcardToken()) }
        )
      )
    }
  )
}

private func makeMember(
  of base: some TypeSyntaxProtocol,
  moduleSelector: TokenSyntax? = nil,
  name: TokenSyntax
) -> MemberTypeSyntax {
  return MemberTypeSyntax(
    baseType: base,
    moduleSelector: moduleSelector.map { ModuleSelectorSyntax(moduleName: $0) },
    name: name
  )
}

private func makeCall(
  callee: some ExprSyntaxProtocol,
  arguments: KeyValuePairs<TokenSyntax?, ExprSyntax>
) -> FunctionCallExprSyntax {
  return FunctionCallExprSyntax(
    calledExpression: callee,
    leftParen: .leftParenToken(),
    arguments: LabeledExprListSyntax(
      arguments.map { labelAndExpr in
        LabeledExprSyntax(
          label: labelAndExpr.0,
          colon: labelAndExpr.0 == nil ? nil : .colonToken(),
          expression: labelAndExpr.1
        )
      }
    ),
    rightParen: .rightParenToken()
  )
}
