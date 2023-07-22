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
import SwiftDiagnostics
import SwiftParser
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacrosTestSupport
import XCTest

enum CustomError: Error, CustomStringConvertible {
  case message(String)

  var description: String {
    switch self {
    case .message(let text):
      return text
    }
  }
}

// MARK: Example macros
public struct StringifyMacro: ExpressionMacro {
  public static func expansion<
    Node: FreestandingMacroExpansionSyntax,
    Context: MacroExpansionContext
  >(
    of macro: Node,
    in context: Context
  ) throws -> ExprSyntax {
    guard let argument = macro.argumentList.first?.expression else {
      throw CustomError.message("missing argument")
    }

    return "(\(argument), \(StringLiteralExprSyntax(content: argument.description)))"
  }
}

/// Replace the label of the first element in the tuple with the given
/// new label.
private func replaceFirstLabel(
  of tuple: TupleExprElementListSyntax,
  with newLabel: String
) -> TupleExprElementListSyntax {
  guard let firstElement = tuple.first else {
    return tuple
  }

  return tuple.replacing(
    childAt: 0,
    with: firstElement.with(\.label, .identifier(newLabel))
  )
}

public struct ColorLiteralMacro: ExpressionMacro {
  public static func expansion<
    Node: FreestandingMacroExpansionSyntax,
    Context: MacroExpansionContext
  >(
    of macro: Node,
    in context: Context
  ) -> ExprSyntax {
    let argList = replaceFirstLabel(
      of: macro.argumentList,
      with: "_colorLiteralRed"
    )
    let initSyntax: ExprSyntax = ".init(\(argList))"
    return initSyntax.with(\.leadingTrivia, macro.leadingTrivia)
  }
}

public struct FileLiteralMacro: ExpressionMacro {
  public static func expansion<
    Node: FreestandingMacroExpansionSyntax,
    Context: MacroExpansionContext
  >(
    of macro: Node,
    in context: Context
  ) -> ExprSyntax {
    let argList = replaceFirstLabel(
      of: macro.argumentList,
      with: "fileReferenceLiteralResourceName"
    )
    let initSyntax: ExprSyntax = ".init(\(argList))"
    return initSyntax.with(\.leadingTrivia, macro.leadingTrivia)
  }
}

public struct ImageLiteralMacro: ExpressionMacro {
  public static func expansion<
    Node: FreestandingMacroExpansionSyntax,
    Context: MacroExpansionContext
  >(
    of macro: Node,
    in context: Context
  ) -> ExprSyntax {
    let argList = replaceFirstLabel(
      of: macro.argumentList,
      with: "imageLiteralResourceName"
    )
    let initSyntax: ExprSyntax = ".init(\(argList))"
    return initSyntax.with(\.leadingTrivia, macro.leadingTrivia)
  }
}

public struct ColumnMacro: ExpressionMacro {
  public static func expansion<
    Node: FreestandingMacroExpansionSyntax,
    Context: MacroExpansionContext
  >(
    of macro: Node,
    in context: Context
  ) throws -> ExprSyntax {
    guard let sourceLoc: AbstractSourceLocation = context.location(of: macro)
    else {
      throw CustomError.message("can't find location for macro")
    }
    return sourceLoc.column.with(\.leadingTrivia, macro.leadingTrivia)
  }
}

public struct FileIDMacro: ExpressionMacro {
  public static func expansion<
    Node: FreestandingMacroExpansionSyntax,
    Context: MacroExpansionContext
  >(
    of macro: Node,
    in context: Context
  ) throws -> ExprSyntax {
    guard let sourceLoc: AbstractSourceLocation = context.location(of: macro)
    else {
      throw CustomError.message("can't find location for macro")
    }
    return sourceLoc.file.with(\.leadingTrivia, macro.leadingTrivia)
  }
}

/// Macro whose only purpose is to ensure that we cannot see "out" of the
/// macro expansion syntax node we were given.
struct CheckContextIndependenceMacro: ExpressionMacro {
  static func expansion<
    Node: FreestandingMacroExpansionSyntax,
    Context: MacroExpansionContext
  >(
    of macro: Node,
    in context: Context
  ) -> ExprSyntax {

    // Should not have a parent.
    XCTAssertNil(macro.parent)

    // Absolute starting position should be zero.
    XCTAssertEqual(macro.position.utf8Offset, 0)

    return "()"
  }
}

struct SimpleDiagnosticMessage: DiagnosticMessage {
  let message: String
  let diagnosticID: MessageID
  let severity: DiagnosticSeverity
}

extension SimpleDiagnosticMessage: FixItMessage {
  var fixItID: MessageID { diagnosticID }
}

public struct ErrorMacro: DeclarationMacro {
  public static func expansion<
    Node: FreestandingMacroExpansionSyntax,
    Context: MacroExpansionContext
  >(
    of node: Node,
    in context: Context
  ) throws -> [DeclSyntax] {
    guard let firstElement = node.argumentList.first,
      let stringLiteral = firstElement.expression
        .as(StringLiteralExprSyntax.self),
      stringLiteral.segments.count == 1,
      case let .stringSegment(messageString) = stringLiteral.segments[0]
    else {
      throw CustomError.message("#error macro requires a string literal")
    }

    context.diagnose(
      Diagnostic(
        node: Syntax(node),
        message: SimpleDiagnosticMessage(
          message: messageString.content.description,
          diagnosticID: MessageID(domain: "test", id: "error"),
          severity: .error
        )
      )
    )

    return []
  }
}

struct DefineBitwidthNumberedStructsMacro: DeclarationMacro {
  static func expansion<
    Node: FreestandingMacroExpansionSyntax,
    Context: MacroExpansionContext
  >(
    of node: Node,
    in context: Context
  ) throws -> [DeclSyntax] {
    guard let firstElement = node.argumentList.first,
      let stringLiteral = firstElement.expression
        .as(StringLiteralExprSyntax.self),
      stringLiteral.segments.count == 1,
      case let .stringSegment(prefix) = stringLiteral.segments[0]
    else {
      throw CustomError.message(
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

public struct PropertyWrapper {}

extension PropertyWrapper: AccessorMacro {
  public static func expansion<
    Context: MacroExpansionContext,
    Declaration: DeclSyntaxProtocol
  >(
    of node: AttributeSyntax,
    providingAccessorsOf declaration: Declaration,
    in context: Context
  ) throws -> [AccessorDeclSyntax] {
    guard let varDecl = declaration.as(VariableDeclSyntax.self),
      let binding = varDecl.bindings.first,
      let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier,
      binding.accessor == nil
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
}

extension PropertyWrapper: PeerMacro {
  public static func expansion<
    Context: MacroExpansionContext,
    Declaration: DeclSyntaxProtocol
  >(
    of node: AttributeSyntax,
    providingPeersOf declaration: Declaration,
    in context: Context
  ) throws -> [SwiftSyntax.DeclSyntax] {
    guard let varDecl = declaration.as(VariableDeclSyntax.self),
      let binding = varDecl.bindings.first,
      let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier,
      let type = binding.typeAnnotation?.type,
      binding.accessor == nil
    else {
      return []
    }

    guard case .argumentList(let arguments) = node.argument,
      let wrapperTypeNameExpr = arguments.first?.expression,
      let stringLiteral = wrapperTypeNameExpr.as(StringLiteralExprSyntax.self),
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

public struct AddCompletionHandler: PeerMacro {
  public static func expansion<
    Context: MacroExpansionContext,
    Declaration: DeclSyntaxProtocol
  >(
    of node: AttributeSyntax,
    providingPeersOf declaration: Declaration,
    in context: Context
  ) throws -> [DeclSyntax] {
    // Only on functions at the moment. We could handle initializers as well
    // with a bit of work.
    guard let funcDecl = declaration.as(FunctionDeclSyntax.self) else {
      throw CustomError.message("@addCompletionHandler only works on functions")
    }

    // This only makes sense for async functions.
    if funcDecl.signature.effectSpecifiers?.asyncSpecifier == nil {
      throw CustomError.message(
        "@addCompletionHandler requires an async function"
      )
    }

    // Form the completion handler parameter.
    let resultType: TypeSyntax? = funcDecl.signature.output?.returnType.with(\.leadingTrivia, []).with(\.trailingTrivia, [])

    let completionHandlerParam =
      FunctionParameterSyntax(
        firstName: .identifier("completionHandler"),
        colon: .colonToken(trailingTrivia: .space),
        type: "(\(resultType ?? "")) -> Void" as TypeSyntax
      )

    // Add the completion handler parameter to the parameter list.
    let parameterList = funcDecl.signature.input.parameterList
    let newParameterList: FunctionParameterListSyntax
    if let lastParam = parameterList.last {
      // We need to add a trailing comma to the preceding list.
      newParameterList = parameterList.removingLast()
        .appending(
          lastParam.with(
            \.trailingComma,
            .commaToken(trailingTrivia: .space)
          )
        )
        .appending(completionHandlerParam)
    } else {
      newParameterList = parameterList.appending(completionHandlerParam)
    }

    let callArguments: [String] = parameterList.map { param in
      let argName = param.secondName ?? param.firstName

      if param.firstName.text != "_" {
        return "\(param.firstName.text): \(argName.text)"
      }

      return "\(argName.text)"
    }

    let call: ExprSyntax =
      "\(funcDecl.identifier)(\(raw: callArguments.joined(separator: ", ")))"

    // FIXME: We should make CodeBlockSyntax ExpressibleByStringInterpolation,
    // so that the full body could go here.
    let newBody: ExprSyntax =
      """

        Task {
          completionHandler(await \(call))
        }

      """

    // Drop the @addCompletionHandler attribute from the new declaration.
    let newAttributeList = AttributeListSyntax(
      funcDecl.attributes?.filter {
        guard case let .attribute(attribute) = $0 else {
          return true
        }

        return attribute != node
      } ?? []
    )

    let newFunc =
      funcDecl
      .with(
        \.signature,
        funcDecl.signature
          .with(
            \.effectSpecifiers,
            funcDecl.signature.effectSpecifiers?.with(\.asyncSpecifier, nil)  // drop async
          )
          .with(\.output, nil)  // drop result type
          .with(
            \.input,  // add completion handler parameter
            funcDecl.signature.input.with(\.parameterList, newParameterList)
              .with(\.trailingTrivia, [])
          )
      )
      .with(
        \.body,
        CodeBlockSyntax(
          leftBrace: .leftBraceToken(leadingTrivia: .space),
          statements: CodeBlockItemListSyntax(
            [CodeBlockItemSyntax(item: .expr(newBody))]
          ),
          rightBrace: .rightBraceToken(leadingTrivia: .newline)
        )
      )
      .with(\.attributes, newAttributeList)
      .with(\.leadingTrivia, .newlines(2))

    return [DeclSyntax(newFunc)]
  }
}

public struct AddBackingStorage: MemberMacro {
  public static func expansion<
    Declaration: DeclGroupSyntax,
    Context: MacroExpansionContext
  >(
    of node: AttributeSyntax,
    providingMembersOf decl: Declaration,
    in context: Context
  )
    throws -> [DeclSyntax]
  {
    let storage: DeclSyntax = "var _storage: Storage<Self>"
    return [
      storage.with(\.leadingTrivia, [.newlines(1), .spaces(2)])
    ]
  }
}

public struct WrapAllProperties: MemberAttributeMacro {
  public static func expansion<
    Declaration: DeclGroupSyntax,
    MemberDeclaration: DeclSyntaxProtocol,
    Context: MacroExpansionContext
  >(
    of node: AttributeSyntax,
    attachedTo decl: Declaration,
    providingAttributesFor member: MemberDeclaration,
    in context: Context
  ) throws -> [AttributeSyntax] {
    guard member.is(VariableDeclSyntax.self) else {
      return []
    }

    return [
      AttributeSyntax(
        attributeName: SimpleTypeIdentifierSyntax(
          name: .identifier("Wrapper")
        )
      )
      .with(\.leadingTrivia, [.newlines(1), .spaces(2)])
    ]
  }
}

public struct WrapStoredProperties: MemberAttributeMacro {
  public static func expansion<
    Declaration: DeclGroupSyntax,
    MemberDeclaration: DeclSyntaxProtocol,
    Context: MacroExpansionContext
  >(
    of node: AttributeSyntax,
    attachedTo decl: Declaration,
    providingAttributesFor member: MemberDeclaration,
    in context: Context
  ) throws -> [AttributeSyntax] {
    guard let property = member.as(VariableDeclSyntax.self),
      property.bindings.count == 1
    else {
      return []
    }

    let binding = property.bindings.first!
    switch binding.accessor {
    case .none:
      break
    case .accessors(let node):
      for accessor in node.accessors {
        switch accessor.accessorKind.tokenKind {
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

    return [
      AttributeSyntax(
        attributeName: SimpleTypeIdentifierSyntax(
          name: .identifier("Wrapper")
        )
      )
      .with(\.leadingTrivia, [.newlines(1), .spaces(2)])
    ]
  }
}

struct CustomTypeWrapperMacro {}

extension CustomTypeWrapperMacro: MemberMacro {
  static func expansion<
    Declaration: DeclGroupSyntax,
    Context: MacroExpansionContext
  >(
    of node: AttributeSyntax,
    providingMembersOf declaration: Declaration,
    in context: Context
  ) throws -> [DeclSyntax] {
    return [
      """

        var _storage: Wrapper<Self>
      """
    ]
  }
}

extension CustomTypeWrapperMacro: MemberAttributeMacro {
  static func expansion<
    Declaration: DeclGroupSyntax,
    MemberDeclaration: DeclSyntaxProtocol,
    Context: MacroExpansionContext
  >(
    of node: AttributeSyntax,
    attachedTo declaration: Declaration,
    providingAttributesFor member: MemberDeclaration,
    in context: Context
  ) throws -> [AttributeSyntax] {
    return [
      AttributeSyntax(
        attributeName: SimpleTypeIdentifierSyntax(
          name: .identifier("customTypeWrapper")
        )
      )
      .with(\.leadingTrivia, [.newlines(1), .spaces(2)])
    ]
  }
}

extension CustomTypeWrapperMacro: AccessorMacro {
  static func expansion<
    Context: MacroExpansionContext,
    Declaration: DeclSyntaxProtocol
  >(
    of node: AttributeSyntax,
    providingAccessorsOf declaration: Declaration,
    in context: Context
  ) throws -> [AccessorDeclSyntax] {
    guard let property = declaration.as(VariableDeclSyntax.self),
      let binding = property.bindings.first,
      let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier,
      binding.accessor == nil
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

public struct UnwrapMacro: CodeItemMacro {
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> [CodeBlockItemSyntax] {
    guard !node.argumentList.isEmpty else {
      throw CustomError.message("'#unwrap' requires arguments")
    }
    let errorThrower = node.trailingClosure
    let identifiers = try node.argumentList.map { argument in
      guard let tupleElement = argument.as(TupleExprElementSyntax.self),
        let identifierExpr = tupleElement.expression.as(IdentifierExprSyntax.self)
      else {
        throw CustomError.message("Arguments must be identifiers")
      }
      return identifierExpr.identifier
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

    return identifiers.map { identifier in
      CodeBlockItemSyntax(
        item: CodeBlockItemSyntax.Item.stmt(
          """

          guard let \(raw: identifier.text) else \(elseBlock(identifier))
          """
        )
      )
    }
  }
}

public struct DeclsFromStringsMacro: DeclarationMacro {
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    var strings: [String] = []
    for arg in node.argumentList {
      guard
        let value = arg.expression.as(StringLiteralExprSyntax.self)?.representedLiteralValue
      else {
        continue
      }
      strings.append(value)
    }

    return strings.map {
      "\(raw: $0)"
    }
  }
}

public struct SendableConformanceMacro: ConformanceMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingConformancesOf declaration: some DeclGroupSyntax,
    in context: some MacroExpansionContext
  ) throws -> [(TypeSyntax, GenericWhereClauseSyntax?)] {
    return [("Sendable", nil)]
  }
}

public struct SendableExtensionMacro: ExtensionMacro {
  public static func expansion(
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

public struct DeclsFromStringsMacroNoAttrs: DeclarationMacro {
  public static var propagateFreestandingMacroAttributes: Bool { false }
  public static var propagateFreestandingMacroModifiers: Bool { false }

  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    var strings: [String] = []
    for arg in node.argumentList {
      guard
        let value = arg.expression.as(StringLiteralExprSyntax.self)?.representedLiteralValue
      else {
        continue
      }
      strings.append(value)
    }

    return strings.map {
      "\(raw: $0)"
    }
  }
}

// MARK: Tests

/// The set of test macros we use here.
public let testMacros: [String: Macro.Type] = [
  "checkContext": CheckContextIndependenceMacro.self,
  "colorLiteral": ColorLiteralMacro.self,
  "column": ColumnMacro.self,
  "fileID": FileIDMacro.self,
  "imageLiteral": ImageLiteralMacro.self,
  "stringify": StringifyMacro.self,
  "myError": ErrorMacro.self,
  "bitwidthNumberedStructs": DefineBitwidthNumberedStructsMacro.self,
  "wrapProperty": PropertyWrapper.self,
  "addCompletionHandler": AddCompletionHandler.self,
  "addBackingStorage": AddBackingStorage.self,
  "wrapAllProperties": WrapAllProperties.self,
  "wrapStoredProperties": WrapStoredProperties.self,
  "customTypeWrapper": CustomTypeWrapperMacro.self,
  "unwrap": UnwrapMacro.self,
  "AddSendable": SendableConformanceMacro.self,
  "AddSendableExtension": SendableExtensionMacro.self,
]

final class MacroSystemTests: XCTestCase {
  private let indentationWidth: Trivia = .spaces(2)

  func testExpressionExpansion() {
    assertMacroExpansion(
      """
      let b = #stringify(x + y)
      #colorLiteral(red: 0.5, green: 0.5, blue: 0.25, alpha: 1.0)
      """,
      expandedSource: """
        let b = (x + y, "x + y")
        .init(_colorLiteralRed: 0.5, green: 0.5, blue: 0.25, alpha: 1.0)
        """,
      macros: testMacros,
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
    assertMacroExpansion(
      """
      let b = #fileID
      let c = #column
      """,
      expandedSource: """
        let b = "MyModule/taylor.swift"
        let c = 9
        """,
      macros: testMacros,
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
          func f() {
          }
          func g() {
          }
        }
        """,
      diagnostics: [
        DiagnosticSpec(message: "please don't do that", line: 1, column: 1, highlight: #"#myError("please don't do that")"#),
        DiagnosticSpec(message: "#error macro requires a string literal", line: 4, column: 3, highlight: #"#myError(bad)"#),
        DiagnosticSpec(message: "worse", line: 6, column: 5, highlight: #"#myError("worse")"#),
      ],
      macros: testMacros,
      indentationWidth: indentationWidth
    )
  }

  func testBitwidthNumberedStructsExpansion() {
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
      macros: testMacros,
      indentationWidth: indentationWidth
    )
  }

  func testPropertyWrapper() {
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
      macros: testMacros,
      indentationWidth: indentationWidth
    )
  }

  func testAddCompletionHandler() {
    assertMacroExpansion(
      """
      @addCompletionHandler
      func f(a: Int, for b: String, _ value: Double) async -> String { }
      """,
      expandedSource: """
        func f(a: Int, for b: String, _ value: Double) async -> String {
        }

        func f(a: Int, for b: String, _ value: Double, completionHandler: (String) -> Void) {
          Task {
            completionHandler(await f(a: a, for: b, value))
          }
        }
        """,
      macros: testMacros,
      indentationWidth: indentationWidth
    )
  }

  func testAddBackingStorage() {
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
      macros: testMacros,
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
          var description: String {
            ""
          }
          @Wrapper
          var computed: Int {
            get {
              0
            }
            set {
            }
          }

          func test() {
          }
        }
        """,
      macros: testMacros,
      indentationWidth: indentationWidth
    )

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

          var description: String {
            ""
          }

          var computed: Int {
            get {
              0
            }
            set {
            }
          }

          func test() {
          }
        }
        """,
      macros: testMacros,
      indentationWidth: indentationWidth
    )
  }

  func testTypeWrapperTransform() {
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
      macros: testMacros,
      indentationWidth: indentationWidth
    )

  }

  func testUnwrap() {
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
      macros: testMacros,
      indentationWidth: indentationWidth
    )
  }

  func testDeclsFromStringLiterals() {
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

  func testConformanceExpansion() {
    assertMacroExpansion(
      """
      @AddSendable
      struct MyType {
      }
      """,
      expandedSource: """

        struct MyType {
        }
        extension MyType: Sendable {
        }
        """,
      macros: testMacros,
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      @AddSendable
      extension A.B {
      }
      """,
      expandedSource: """

        extension A.B {
        }
        extension A.B: Sendable {
        }
        """,
      macros: testMacros,
      indentationWidth: indentationWidth
    )
  }

  func testExtensionExpansion() {
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
      macros: testMacros,
      indentationWidth: indentationWidth
    )
  }
}
