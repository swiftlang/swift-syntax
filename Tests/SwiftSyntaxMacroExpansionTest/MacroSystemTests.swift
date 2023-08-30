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

//==========================================================================//
// IMPORTANT: The macros defined in this file are intended to test the      //
// behavior of MacroSystem. Many of them do not serve as good examples of   //
// how macros should be written. In particular, they often lack error       //
// handling because it is not needed in the few test cases in which these   //
// macros are invoked.                                                      //
//==========================================================================//

import _SwiftSyntaxTestSupport
import SwiftDiagnostics
import SwiftParser
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacrosTestSupport
import XCTest

// MARK: Macros shared between multiple test cases

fileprivate struct ConstantOneGetter: AccessorMacro {
  static func expansion(
    of node: AttributeSyntax,
    providingAccessorsOf declaration: some DeclSyntaxProtocol,
    in context: some MacroExpansionContext
  ) throws -> [AccessorDeclSyntax] {
    return [
      """
      get {
        return 1
      }
      """
    ]
  }
}

fileprivate struct DeclsFromStringsMacro: DeclarationMacro, MemberMacro {
  private static func decls(from arguments: LabeledExprListSyntax) -> [DeclSyntax] {
    var strings: [String] = []
    for arg in arguments {
      guard let value = arg.expression.as(StringLiteralExprSyntax.self)?.representedLiteralValue else {
        continue
      }
      strings.append(value)
    }

    return strings.map { "\(raw: $0)" }
  }

  static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    return decls(from: node.argumentList)
  }

  static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    guard case .argumentList(let arguments) = node.arguments else {
      return []
    }
    return decls(from: arguments)
  }
}

fileprivate struct StringifyMacro: ExpressionMacro {
  static func expansion(
    of macro: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> ExprSyntax {
    guard let argument = macro.argumentList.first?.expression else {
      throw MacroExpansionErrorMessage("missing argument")
    }

    return "(\(argument), \(StringLiteralExprSyntax(content: argument.description)))"
  }
}

fileprivate struct WrapAllProperties: MemberAttributeMacro {
  static func expansion(
    of node: AttributeSyntax,
    attachedTo decl: some DeclGroupSyntax,
    providingAttributesFor member: some DeclSyntaxProtocol,
    in context: some MacroExpansionContext
  ) throws -> [AttributeSyntax] {
    guard member.is(VariableDeclSyntax.self) else {
      return []
    }

    return ["@Wrapper"]
  }
}

// MARK: Tests

final class MacroSystemTests: XCTestCase {
  private let indentationWidth: Trivia = .spaces(2)

  func testExpressionExpansion() {
    struct ColorLiteralMacro: ExpressionMacro {
      static func expansion(
        of macro: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
      ) -> ExprSyntax {
        var argList = macro.argumentList
        argList[argList.startIndex].label = .identifier("_colorLiteralRed")
        let initSyntax: ExprSyntax = ".init(\(argList))"
        return initSyntax
      }
    }

    assertMacroExpansion(
      """
      let b = #stringify(x + y)
      """,
      expandedSource: """
        let b = (x + y, "x + y")
        """,
      macros: ["stringify": StringifyMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      #colorLiteral(red: 0.5, green: 0.5, blue: 0.25, alpha: 1.0)
      """,
      expandedSource: """
        .init(_colorLiteralRed: 0.5, green: 0.5, blue: 0.25, alpha: 1.0)
        """,
      macros: ["colorLiteral": ColorLiteralMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testTriviaTransferOnExpressionMacro() {
    assertMacroExpansion(
      """
      // Ignore me
      \t
      // Capture me
      #stringify(x)
      """,
      expandedSource: """
        // Ignore me
        \t
        // Capture me
        (x, "x")
        """,
      macros: ["stringify": StringifyMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testCommentsOnExpressionMacro() {
    assertMacroExpansion(
      """
      let b = 
      /*leading */ #stringify(x + y) /*trailing*/
      """,
      expandedSource: """
        let b = 
        /*leading */ (x + y, "x + y") /*trailing*/
        """,
      macros: ["stringify": StringifyMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testStringifyExpression() {
    assertMacroExpansion(
      """
      _ = #stringify({ () -> Bool in
        print("hello")
        return true
      })
      """,
      expandedSource: """
        _ = ({ () -> Bool in
          print("hello")
          return true
          }, #"{ () -> Bool in\\#n  print("hello")\\#n  return true\\#n}"#)
        """,
      macros: ["stringify": StringifyMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testLocationExpansions() {
    struct ColumnMacro: ExpressionMacro {
      static func expansion(
        of macro: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
      ) throws -> ExprSyntax {
        guard let sourceLoc: AbstractSourceLocation = context.location(of: macro) else {
          throw MacroExpansionErrorMessage("can't find location for macro")
        }
        return sourceLoc.column
      }
    }

    struct FileIDMacro: ExpressionMacro {
      static func expansion(
        of macro: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
      ) throws -> ExprSyntax {
        guard let sourceLoc: AbstractSourceLocation = context.location(of: macro) else {
          throw MacroExpansionErrorMessage("can't find location for macro")
        }
        return sourceLoc.file
      }
    }

    assertMacroExpansion(
      """
      let b = #fileID
      let c = #column
      """,
      expandedSource: """
        let b = "MyModule/taylor.swift"
        let c = 9
        """,
      macros: ["fileID": FileIDMacro.self, "column": ColumnMacro.self],
      testModuleName: "MyModule",
      testFileName: "taylor.swift",
      indentationWidth: indentationWidth
    )
  }

  func testContextUniqueLocalNames() {
    let context = BasicMacroExpansionContext()

    let t1 = context.makeUniqueName("mine")
    let t2 = context.makeUniqueName("mine")
    XCTAssertNotEqual(t1.description, t2.description)
    XCTAssertEqual(t1.description, "__macro_local_4minefMu_")
    XCTAssertEqual(t2.description, "__macro_local_4minefMu0_")
  }

  func testContextIndependence() {
    /// Macro whose only purpose is to ensure that we cannot see "out" of the
    /// macro expansion syntax node we were given.
    struct CheckContextIndependenceMacro: ExpressionMacro {
      static func expansion(
        of macro: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
      ) -> ExprSyntax {

        // Should not have a parent.
        XCTAssertNil(macro.parent)

        // Absolute starting position should be zero.
        XCTAssertEqual(macro.position.utf8Offset, 0)

        return "()"
      }
    }

    assertMacroExpansion(
      """
      let b = #checkContext
      """,
      expandedSource: """
        let b = ()
        """,
      macros: ["checkContext": CheckContextIndependenceMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testErrorExpansion() {
    struct ErrorMacro: DeclarationMacro {
      static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        guard let firstElement = node.argumentList.first,
          let stringLiteral = firstElement.expression
            .as(StringLiteralExprSyntax.self),
          stringLiteral.segments.count == 1,
          case let .stringSegment(messageString) = stringLiteral.segments.first
        else {
          throw MacroExpansionErrorMessage("#error macro requires a string literal")
        }

        context.diagnose(
          Diagnostic(
            node: Syntax(node),
            message: MacroExpansionErrorMessage(messageString.content.description)
          )
        )

        return []
      }
    }

    assertMacroExpansion(
      """
      #myError("please don't do that")
      struct X {
        func f() { }
        #myError(bad)
        func g() {
          #myError("worse")
        }
      }
      """,
      expandedSource: """
        struct X {
          func f() { }
          #myError(bad)
          func g() {
          }
        }
        """,
      diagnostics: [
        DiagnosticSpec(message: "please don't do that", line: 1, column: 1, highlight: #"#myError("please don't do that")"#),
        DiagnosticSpec(message: "#error macro requires a string literal", line: 4, column: 3, highlight: #"#myError(bad)"#),
        DiagnosticSpec(message: "worse", line: 6, column: 5, highlight: #"#myError("worse")"#),
      ],
      macros: ["myError": ErrorMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testBitwidthNumberedStructsExpansion() {
    struct DefineBitwidthNumberedStructsMacro: DeclarationMacro {
      static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        guard let stringLiteral = node.argumentList.first?.expression.as(StringLiteralExprSyntax.self),
          stringLiteral.segments.count == 1,
          case let .stringSegment(prefix) = stringLiteral.segments.first
        else {
          throw MacroExpansionErrorMessage(
            "#bitwidthNumberedStructs macro requires a string literal"
          )
        }

        return [8, 16, 32, 64].map { bitwidth in
          """

          struct \(raw: prefix)\(raw: String(bitwidth)) { }
          """
        }
      }
    }

    assertMacroExpansion(
      """
      #bitwidthNumberedStructs("MyInt")
      """,
      expandedSource: """
        struct MyInt8 {
        }
        struct MyInt16 {
        }
        struct MyInt32 {
        }
        struct MyInt64 {
        }
        """,
      macros: ["bitwidthNumberedStructs": DefineBitwidthNumberedStructsMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testPropertyWrapper() {
    struct PropertyWrapper: AccessorMacro, PeerMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [AccessorDeclSyntax] {
        guard let binding = declaration.as(VariableDeclSyntax.self)?.bindings.first,
          let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier,
          binding.accessorBlock == nil
        else {
          return []
        }

        return [
          """
          get {
            _\(identifier).wrappedValue
          }
          """,
          """
          set {
            _\(identifier).wrappedValue = newValue
          }
          """,
        ]
      }

      static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [SwiftSyntax.DeclSyntax] {
        guard let binding = declaration.as(VariableDeclSyntax.self)?.bindings.first,
          let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier,
          let type = binding.typeAnnotation?.type,
          binding.accessorBlock == nil
        else {
          return []
        }

        guard case .argumentList(let arguments) = node.arguments,
          let stringLiteral = arguments.first?.expression.as(StringLiteralExprSyntax.self),
          stringLiteral.segments.count == 1,
          case let .stringSegment(wrapperTypeNameSegment)? = stringLiteral.segments.first
        else {
          return []
        }

        let storageType: TypeSyntax = "\(wrapperTypeNameSegment.content)<\(type)>"
        let storageName = "_\(identifier)"

        return [
          """

          private var \(raw: storageName): \(storageType)

          """
        ]
      }
    }

    assertMacroExpansion(
      """
      @wrapProperty("MyWrapperType")
      var x: Int
      """,
      expandedSource: """
        var x: Int {
          get {
            _x.wrappedValue
          }
          set {
            _x.wrappedValue = newValue
          }
        }

        private var _x: MyWrapperType<Int>
        """,
      macros: ["wrapProperty": PropertyWrapper.self],
      indentationWidth: indentationWidth
    )
  }

  func testAccessorOnVariableDeclWithExistingGetter() {
    assertMacroExpansion(
      """
      @constantOne
      var x: Int {
        return 42
      }
      """,
      expandedSource: """
        var x: Int {
          get {
            return 42
          }
          get {
            return 1
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      struct Foo {
        @constantOne
        var x: Int {
          return 42
        }
      }
      """,
      expandedSource: """
        struct Foo {
          var x: Int {
            get {
              return 42
            }
            get {
              return 1
            }
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      @constantOne
      var x: Int {
        get {
          return 42
        }
      }
      """,
      expandedSource: """
        var x: Int {
          get {
            return 42
          }
          get {
            return 1
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )
  }

  func testAccessorOnSubscript() {
    // Adding an accessor to a subscript without an accessor isn't supported by
    // the compiler (it complains that the subscript should have a body) but we
    // can stil make the most reasonable syntactic expansion.
    assertMacroExpansion(
      """
      struct Foo {
        @constantOne
        subscript() -> Int
      }
      """,
      expandedSource: """
        struct Foo {
          subscript() -> Int {
            get {
              return 1
            }
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )
  }

  func testAccessorOnSubscriptDeclWithExistingGetter() {
    assertMacroExpansion(
      """
      struct Foo {
        @constantOne
        subscript() -> Int {
          return 42
        }
      }
      """,
      expandedSource: """
        struct Foo {
          subscript() -> Int {
            get {
              return 42
            }
            get {
              return 1
            }
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      struct Foo {
        @constantOne
        subscript() -> Int {
          return 42
        }
      }
      """,
      expandedSource: """
        struct Foo {
          subscript() -> Int {
            get {
              return 42
            }
            get {
              return 1
            }
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      struct Foo {
        @constantOne
        subscript() -> Int {
          get {
            return 42
          }
        }
      }
      """,
      expandedSource: """
        struct Foo {
          subscript() -> Int {
            get {
              return 42
            }
            get {
              return 1
            }
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )
  }

  func testAccessorOnVariableDeclWithMultipleBindings() {
    assertMacroExpansion(
      """
      @constantOneGetter
      var x: Int, y: Int
      """,
      expandedSource: """
        var x: Int, y: Int
        """,
      diagnostics: [
        DiagnosticSpec(
          message:
            "swift-syntax applies macros syntactically and there is no way to represent a variable declaration with multiple bindings that have accessors syntactically. While the compiler allows this expansion, swift-syntax cannot represent it and thus disallows it.",
          line: 1,
          column: 1,
          severity: .error
        )
      ],
      macros: ["constantOneGetter": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )
  }

  func testMultipleAccessorMacros() {
    assertMacroExpansion(
      """
      @constantOne
      @constantOne
      var x: Int
      """,
      expandedSource: """
        var x: Int {
          get {
            return 1
          }
          get {
            return 1
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )
  }

  func testAddCompletionHandler() {
    struct AddCompletionHandler: PeerMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        // Only on functions at the moment. We could handle initializers as well
        // with a bit of work.
        guard let funcDecl = declaration.as(FunctionDeclSyntax.self) else {
          throw MacroExpansionErrorMessage("@addCompletionHandler only works on functions")
        }

        // This only makes sense for async functions.
        if funcDecl.signature.effectSpecifiers?.asyncSpecifier == nil {
          throw MacroExpansionErrorMessage(
            "@addCompletionHandler requires an async function"
          )
        }

        // Form the completion handler parameter.
        let resultType: TypeSyntax? = funcDecl.signature.returnClause?.type.trimmed

        let completionHandlerParam =
          FunctionParameterSyntax(
            firstName: .identifier("completionHandler"),
            colon: .colonToken(trailingTrivia: .space),
            type: TypeSyntax("(\(resultType ?? "")) -> Void")
          )

        // Add the completion handler parameter to the parameter list.
        let parameterList = funcDecl.signature.parameterClause.parameters
        var newParameterList = parameterList
        if !parameterList.isEmpty {
          // We need to add a trailing comma to the preceding list.
          newParameterList[newParameterList.index(before: newParameterList.endIndex)].trailingComma = .commaToken(trailingTrivia: .space)
        }
        newParameterList.append(completionHandlerParam)

        let callArguments: [String] = parameterList.map { param in
          let argName = param.secondName ?? param.firstName

          if param.firstName.text != "_" {
            return "\(param.firstName.text): \(argName.text)"
          }

          return "\(argName.text)"
        }

        let call: ExprSyntax =
          "\(funcDecl.name)(\(raw: callArguments.joined(separator: ", ")))"

        // FIXME: We should make CodeBlockSyntax ExpressibleByStringInterpolation,
        // so that the full body could go here.
        let newBody: ExprSyntax =
          """

            Task {
              completionHandler(await \(call))
            }

          """

        // Drop the @addCompletionHandler attribute from the new declaration.
        let newAttributeList = funcDecl.attributes.filter {
          guard case let .attribute(attribute) = $0 else {
            return true
          }
          return attribute.attributeName.as(IdentifierTypeSyntax.self)?.name == "addCompletionHandler"
        }

        var newFunc = funcDecl
        newFunc.signature.effectSpecifiers?.asyncSpecifier = nil  // drop async
        newFunc.signature.returnClause = nil  // drop result type
        newFunc.signature.parameterClause.parameters = newParameterList
        newFunc.signature.parameterClause.trailingTrivia = []
        newFunc.body = CodeBlockSyntax { newBody }
        newFunc.attributes = newAttributeList

        return [DeclSyntax(newFunc)]
      }
    }

    assertMacroExpansion(
      """
      @addCompletionHandler
      func f(a: Int, for b: String, _ value: Double) async -> String { }
      """,
      expandedSource: """
        func f(a: Int, for b: String, _ value: Double) async -> String { }

        func f(a: Int, for b: String, _ value: Double, completionHandler: (String) -> Void) {
          Task {
            completionHandler(await f(a: a, for: b, value))
          }
        }
        """,
      macros: ["addCompletionHandler": AddCompletionHandler.self],
      indentationWidth: indentationWidth
    )
  }

  func testAddBackingStorage() {
    struct AddBackingStorage: MemberMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingMembersOf decl: some DeclGroupSyntax,
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        return ["var _storage: Storage<Self>"]
      }
    }

    assertMacroExpansion(
      """
      @addBackingStorage
      struct S {
        var value: Int
      }
      """,
      expandedSource: """
        struct S {
          var value: Int

          var _storage: Storage<Self>
        }
        """,
      macros: ["addBackingStorage": AddBackingStorage.self],
      indentationWidth: indentationWidth
    )
  }

  func testCommentAroundeAttachedMacro() {
    struct TestMacro: MemberMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        return []
      }
    }

    assertMacroExpansion(
      """
      /// Some doc comment
      @Test /* trailing */
      struct S {
        var value: Int
      }
      """,
      expandedSource: """
        /// Some doc comment
        /* trailing */
        struct S {
          var value: Int
        }
        """,
      macros: ["Test": TestMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testWrapAllProperties() {
    assertMacroExpansion(
      """
      @wrapAllProperties
      struct Point {
        var x: Int
        var y: Int
        var description: String { "" }
        var computed: Int {
          get { 0 }
          set {}
        }

        func test() {}
      }
      """,
      expandedSource: """
        struct Point {
          @Wrapper
          var x: Int
          @Wrapper
          var y: Int
          @Wrapper
          var description: String { "" }
          @Wrapper
          var computed: Int {
            get { 0 }
            set {}
          }

          func test() {}
        }
        """,
      macros: ["wrapAllProperties": WrapAllProperties.self],
      indentationWidth: indentationWidth
    )
  }

  func testWrapStoredProperties() {
    struct WrapStoredProperties: MemberAttributeMacro {
      static func expansion(
        of node: AttributeSyntax,
        attachedTo decl: some DeclGroupSyntax,
        providingAttributesFor member: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [AttributeSyntax] {
        guard let property = member.as(VariableDeclSyntax.self),
          property.bindings.count == 1
        else {
          return []
        }

        let binding = property.bindings.first!
        switch binding.accessorBlock?.accessors {
        case .none:
          break
        case .accessors(let node):
          for accessor in node {
            switch accessor.accessorSpecifier.tokenKind {
            case .keyword(.get), .keyword(.set):
              return []
            default:
              break
            }
          }
          break
        case .getter:
          return []
        }

        return ["@Wrapper"]
      }
    }

    assertMacroExpansion(
      """
      @wrapStoredProperties
      struct Point {
        var x: Int
        var y: Int

        var description: String { "" }

        var computed: Int {
          get { 0 }
          set {}
        }

        func test() {}
      }
      """,
      expandedSource: """
        struct Point {
          @Wrapper
          var x: Int
          @Wrapper
          var y: Int

          var description: String { "" }

          var computed: Int {
            get { 0 }
            set {}
          }

          func test() {}
        }
        """,
      macros: ["wrapStoredProperties": WrapStoredProperties.self],
      indentationWidth: indentationWidth
    )
  }

  func testMemberAttributeMacroOnPropertyThatAlreadyHasAttribute() {
    struct TestMacro: MemberAttributeMacro {
      static func expansion(
        of node: AttributeSyntax,
        attachedTo decl: some DeclGroupSyntax,
        providingAttributesFor member: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [AttributeSyntax] {
        return ["@Wrapper"]
      }
    }

    assertMacroExpansion(
      """
      @Test
      struct Foo {
        @available(*, deprecated) var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @available(*, deprecated)
          @Wrapper var x: Int
        }
        """,
      macros: ["Test": TestMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      @Test
      struct Foo {
        @available(*, deprecated) /* x */ var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @available(*, deprecated)
          @Wrapper /* x */ var x: Int
        }
        """,
      macros: ["Test": TestMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      @Test
      struct Foo {
        @available(*, deprecated)

        var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @available(*, deprecated)
          @Wrapper

          var x: Int
        }
        """,
      macros: ["Test": TestMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      @Test
      struct Foo {
        @available(*, deprecated) // some comment

        var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @available(*, deprecated)
          @Wrapper // some comment

          var x: Int
        }
        """,
      macros: ["Test": TestMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testMemberAttributeWithTriviaMacroOnPropertyThatAlreadyHasAttribute() {
    struct TestMacro: MemberAttributeMacro {
      static func expansion(
        of node: AttributeSyntax,
        attachedTo decl: some DeclGroupSyntax,
        providingAttributesFor member: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [AttributeSyntax] {
        return ["/* start */@Wrapper/* end */"]
      }
    }

    assertMacroExpansion(
      """
      @Test
      struct Foo {
        @available(*, deprecated) var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @available(*, deprecated)
          /* start */@Wrapper/* end */ var x: Int
        }
        """,
      macros: ["Test": TestMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      @Test
      struct Foo {
        @available(*, deprecated) /* x */ var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @available(*, deprecated)
          /* start */@Wrapper/* end */ /* x */ var x: Int
        }
        """,
      macros: ["Test": TestMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      @Test
      struct Foo {
        @available(*, deprecated)

        var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @available(*, deprecated)
          /* start */@Wrapper/* end */

          var x: Int
        }
        """,
      macros: ["Test": TestMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      @Test
      struct Foo {
        @available(*, deprecated) // some comment

        var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @available(*, deprecated)
          /* start */@Wrapper/* end */ // some comment

          var x: Int
        }
        """,
      macros: ["Test": TestMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testTypeWrapperTransform() {
    struct CustomTypeWrapperMacro: MemberMacro, MemberAttributeMacro, AccessorMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        return ["var _storage: Wrapper<Self>"]
      }

      static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingAttributesFor member: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [AttributeSyntax] {
        return ["@customTypeWrapper"]
      }

      static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [AccessorDeclSyntax] {
        guard let property = declaration.as(VariableDeclSyntax.self),
          let binding = property.bindings.first,
          let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier,
          binding.accessorBlock == nil
        else {
          return []
        }

        if identifier.text == "_storage" { return [] }

        return [
          """
          get {
            _storage[wrappedKeyPath: \\.\(identifier)]
          }
          """,
          """
          set {
            _storage[wrappedKeyPath: \\.\(identifier)] = newValue
          }
          """,
        ]
      }
    }

    assertMacroExpansion(
      """
      @customTypeWrapper
      struct Point {
        var x: Int
        var y: Int
      }
      """,
      expandedSource: """

        struct Point {
          var x: Int {
            get {
              _storage[wrappedKeyPath: \\.x]
            }
            set {
              _storage[wrappedKeyPath: \\.x] = newValue
            }
          }
          var y: Int {
            get {
              _storage[wrappedKeyPath: \\.y]
            }
            set {
              _storage[wrappedKeyPath: \\.y] = newValue
            }
          }

          var _storage: Wrapper<Self>
        }
        """,
      macros: ["customTypeWrapper": CustomTypeWrapperMacro.self],
      indentationWidth: indentationWidth
    )

  }

  func testUnwrap() {
    struct UnwrapMacro: CodeItemMacro {
      static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
      ) throws -> [CodeBlockItemSyntax] {
        guard !node.argumentList.isEmpty else {
          throw MacroExpansionErrorMessage("'#unwrap' requires arguments")
        }
        let errorThrower = node.trailingClosure
        let identifiers = try node.argumentList.map { argument in
          guard let tupleElement = argument.as(LabeledExprSyntax.self),
            let declReferenceExpr = tupleElement.expression.as(DeclReferenceExprSyntax.self)
          else {
            throw MacroExpansionErrorMessage("Arguments must be identifiers")
          }
          return declReferenceExpr.baseName
        }

        func elseBlock(_ token: TokenSyntax) -> CodeBlockSyntax {
          let expr: ExprSyntax
          if let errorThrower {
            expr = """
              \(errorThrower)("\(raw: token.text)")
              """
          } else {
            expr = """
              fatalError("'\(raw: token.text)' is nil")
              """
          }
          return .init(
            statements: .init([
              .init(
                leadingTrivia: " ",
                item: .expr(expr),
                trailingTrivia: " "
              )
            ])
          )
        }

        return identifiers.map { (identifier) -> CodeBlockItemSyntax in
          "guard let \(raw: identifier.text) else \(elseBlock(identifier))"
        }
      }
    }

    assertMacroExpansion(
      #"""
      let x: Int? = 1
      let y: Int? = nil
      let z: Int? = 3
      #unwrap(x, y, z)
      #unwrap(x, y, z) {
        fatalError("nil is \\($0)")
      }
      """#,
      expandedSource: #"""
        let x: Int? = 1
        let y: Int? = nil
        let z: Int? = 3
        guard let x else {
          fatalError("'x' is nil")
        }
        guard let y else {
          fatalError("'y' is nil")
        }
        guard let z else {
          fatalError("'z' is nil")
        }
        guard let x else {
          {
            fatalError("nil is \\($0)")
          }("x")
        }
        guard let y else {
          {
            fatalError("nil is \\($0)")
          }("y")
        }
        guard let z else {
          {
            fatalError("nil is \\($0)")
          }("z")
        }
        """#,
      macros: ["unwrap": UnwrapMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testDeclsFromStringLiterals() {
    struct DeclsFromStringsMacroNoAttrs: DeclarationMacro {
      static var propagateFreestandingMacroAttributes: Bool { false }
      static var propagateFreestandingMacroModifiers: Bool { false }

      static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        var strings: [String] = []
        for arg in node.argumentList {
          guard let value = arg.expression.as(StringLiteralExprSyntax.self)?.representedLiteralValue else {
            continue
          }
          strings.append(value)
        }

        return strings.map { "\(raw: $0)" }
      }
    }

    assertMacroExpansion(
      #"""
      #decls(
        """
        static func foo() {
        print("value") }
        """,
        "struct Inner {\n\n}"
      )
      """#,
      expandedSource: #"""
        static func foo() {
          print("value")
        }
        struct Inner {

        }
        """#,
      macros: ["decls": DeclsFromStringsMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      #"""
      struct S {
        public #decls(
          """
          static func foo() {
          print("value") }
          """,
          "struct Inner {\n\n}"
        )
      }
      """#,
      expandedSource: #"""
        struct S {
          public static func foo() {
            print("value")
          }
          public struct Inner {

          }
        }
        """#,
      macros: ["decls": DeclsFromStringsMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      #"""
      struct S {
        @attr static #decls("var value1 = 1", "typealias A = B")
      }
      """#,
      expandedSource: #"""
        struct S {
          @attr static var value1 = 1
          @attr static typealias A = B
        }
        """#,
      macros: ["decls": DeclsFromStringsMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      #"""
      @attribute
      @otherAttribute(x: 1) #decls("@moreAttibute var global = 42")
      """#,
      expandedSource: #"""
        @attribute
        @otherAttribute(x: 1) @moreAttibute var global = 42
        """#,
      macros: ["decls": DeclsFromStringsMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      #"""
      @attribute
      @otherAttribute(x: 1)
      public #decls("@moreAttibute var global = 42",
                    "private func foo() {}")
      """#,
      expandedSource: #"""
        @moreAttibute var global = 42
        private func foo() {
        }
        """#,
      macros: ["decls": DeclsFromStringsMacroNoAttrs.self],
      indentationWidth: indentationWidth
    )
  }

  func testMemberDeclsFromStringLiterals() {
    assertMacroExpansion(
      """
      @decls("func foo() {}", "func bar() {}"
      struct Foo {
        var member: Int
      }
      """,
      expandedSource: """
        struct Foo {
          var member: Int

          func foo() {
          }

          func bar() {
          }
        }
        """,
      macros: ["decls": DeclsFromStringsMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testIndentationOfMultipleModifiers() {
    assertMacroExpansion(
      """
      struct Foo {
        public
        static #decls("func foo() {}")
      }
      """,
      expandedSource: """
        struct Foo {
          public
          static func foo() {
          }
        }
        """,
      macros: ["decls": DeclsFromStringsMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testCommentsOnFreestandingDeclsExpansions() {
    assertMacroExpansion(
      """
      // some comment
      #decls(
        "func foo() {}",
        "func bar() {}"
      ) /* trailing comment */
      """,
      expandedSource: """
        // some comment
        func foo() {
        }
        func bar() {
        } /* trailing comment */
        """,
      macros: ["decls": DeclsFromStringsMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testCommentsOnFreestandingDeclsExpansionsInMemberDeclList() {
    assertMacroExpansion(
      """
      struct Foo {
        // some comment
        #decls(
          "func foo() {}",
          "func bar() {}"
        ) /* trailing comment */
      }
      """,
      expandedSource: """
        struct Foo {
          // some comment
          func foo() {
          }
          func bar() {
          } /* trailing comment */
        }
        """,
      macros: ["decls": DeclsFromStringsMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testFreestandingDeclThatIncludesDocComment() {
    assertMacroExpansion(
      #"""
      struct Foo {
        #decls(
          """
          /// Some doc comment
          func foo() {}
          """
        )
      }
      """#,
      expandedSource: """
        struct Foo {
          /// Some doc comment
          func foo() {
          }
        }
        """,
      macros: ["decls": DeclsFromStringsMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testExtensionExpansion() {
    struct SendableExtensionMacro: ExtensionMacro {
      static func expansion(
        of node: AttributeSyntax,
        attachedTo: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
      ) throws -> [ExtensionDeclSyntax] {
        let sendableExtension: DeclSyntax =
          """
          extension \(type.trimmed): Sendable {}
          """

        guard let extensionDecl = sendableExtension.as(ExtensionDeclSyntax.self) else {
          return []
        }

        return [extensionDecl]
      }
    }

    assertMacroExpansion(
      """
      @AddSendableExtension
      struct MyType {
      }
      """,
      expandedSource: """

        struct MyType {
        }

        extension MyType: Sendable {
        }
        """,
      macros: ["AddSendableExtension": SendableExtensionMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      struct Wrapper {
        @AddSendableExtension
        struct MyType {
        }
      }
      """,
      expandedSource: """
        struct Wrapper {
          struct MyType {
          }
        }

        extension MyType: Sendable {
        }
        """,
      macros: ["AddSendableExtension": SendableExtensionMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testAttributeWithComment() {
    assertMacroExpansion(
      """
      @wrapAllProperties struct S {
        // Var value
        var value = 1
      }
      """,
      expandedSource: """
        struct S {
          @Wrapper
          // Var value
          var value = 1
        }
        """,
      macros: ["wrapAllProperties": WrapAllProperties.self],
      indentationWidth: indentationWidth
    )
  }

}
