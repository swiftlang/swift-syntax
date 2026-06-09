//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation
@_spi(Experimental) @_spi(_QualifiedLookup) import SwiftLexicalLookup
import SwiftParser
import SwiftSyntax
import XCTest

/// Visitor class helper used in ``SyntaxProtocol/children``
private class SyntaxAsTypeVisitor<T: SyntaxProtocol>: SyntaxAnyVisitor {
  var collectedNodes = [T]()

  override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    if let castNode = node.as(T.self) {
      collectedNodes.append(castNode)
    }
    return .visitChildren
  }
}
extension SyntaxProtocol {
  /// Helper for tests that want to get the child nodes of a particular type.
  ///
  /// This is particularly useful for tests that require that some syntax have
  /// parent nodes for context. For instance, to determine if the name introduced
  /// by an identifier pattern is accessible from a static context, we need to
  /// see if the parent variable declaration is static. Here's an example:
  ///   DeclSyntax("var myVar: Int").children(ofType: IdentifierPatternSyntax.self)[0]
  func children<T: SyntaxProtocol>(ofType: T.Type) -> [T] {
    let visitor = SyntaxAsTypeVisitor<T>(viewMode: .all)
    visitor.walk(self)
    return visitor.collectedNodes
  }
}

final class TestValueDeclSyntax: XCTestCase {
  /// Assert the given declaration syntax can be cast to a ``ValueDeclSyntax``,
  /// exhibiting the given properties.
  ///
  /// Most tests pass a DeclSyntax initialized with a string literal for `syntax`.
  ///
  /// Parameters:
  /// - isStatic: As documented in `ValueDeclSyntax/isStatic`, this
  ///             query doesn't care use the declaration's parent
  ///             as context.
  func assertValueDecl(
    of syntax: some SyntaxProtocol,
    name: DeclName,
    isStatic: Result<Bool, ValueDeclSyntax.StaticLookupFailure>,
    isTypeDecl: Bool,
    scopeKind: SyntaxKind?,
    file: StaticString = #file,
    line: UInt = #line
  ) {
    // Cast to value declaration
    guard let valueDecl = ValueDeclSyntax(syntax) else {
      XCTFail(
        "Couldn't initialize a value declaration from decl of kind '\(syntax.kind)'",
        file: file,
        line: line
      )
      return
    }

    // Check equivalent type casting/checking methods
    XCTAssert(
      syntax.as(ValueDeclSyntax.self) != nil,
      "Couldn't cast decl of kind '\(syntax.kind)' to a value declaration.",
      file: file,
      line: line
    )
    XCTAssert(
      syntax.is(ValueDeclSyntax.self),
      "Type check reports that decl of kind '\(syntax.kind)' isn't a value declaration",
      file: file,
      line: line
    )

    // Check properties
    //
    // Name
    XCTAssertEqual(
      valueDecl.declName,
      name,
      "Value declaration returned an invalid name",
      file: file,
      line: line
    )
    // isStatic
    XCTAssertEqual(
      valueDecl.isStatic,
      isStatic,
      "Value declaration doesn't match expected `isStatic` property",
      file: file,
      line: line
    )
    // isTypeDecl
    XCTAssertEqual(
      valueDecl.isTypeDecl,
      isTypeDecl,
      "Value declaration doesn't match expected `isTypeDecl` property",
      file: file,
      line: line
    )
    // Scope
    XCTAssertEqual(
      valueDecl.scope?.kind,
      scopeKind,
      "Value declaration doesn't match expected `scope` kind",
      file: file,
      line: line
    )
  }

  func testTypes() {
    // Nominal types + Protocols
    assertValueDecl(
      of: DeclSyntax("struct MyStruct {}"),
      name: DeclName.identifier(identifier: Identifier(canonicalName: "MyStruct"), args: nil),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: true,
      scopeKind: .structDecl
    )

    assertValueDecl(
      of: DeclSyntax("enum _ {}"),
      name: DeclName.invalid(nonIdentifier: .identifier(""), args: nil),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: true,
      scopeKind: .enumDecl
    )

    assertValueDecl(
      of: DeclSyntax("class Self {}"),
      name: DeclName.invalid(nonIdentifier: .identifier(""), args: nil),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: true,
      scopeKind: .classDecl
    )

    assertValueDecl(
      of: DeclSyntax("extension { actor `My Actor` {} }")
        .children(ofType: ActorDeclSyntax.self)[0],
      name: DeclName.identifier(identifier: Identifier(canonicalName: "My Actor"), args: nil),
      isStatic: .success(true),
      isTypeDecl: true,
      scopeKind: .actorDecl
    )

    assertValueDecl(
      of: DeclSyntax("protocol $MyProto {}"),
      name: DeclName.identifier(identifier: Identifier(canonicalName: "$MyProto"), args: nil),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: true,
      scopeKind: .protocolDecl
    )

    // Type Aliases
    assertValueDecl(
      of: DeclSyntax("protocol { typealias Num = Int }")
        .children(ofType: TypeAliasDeclSyntax.self)[0],
      name: DeclName.identifier(identifier: Identifier(canonicalName: "Num"), args: nil),
      isStatic: .success(true),
      isTypeDecl: true,
      // type aliases introduce a scope for potential generic parameters
      scopeKind: .typeAliasDecl
    )

    // Associated Types
    assertValueDecl(
      of: DeclSyntax("associatedtype Element"),
      name: DeclName.identifier(identifier: Identifier(canonicalName: "Element"), args: nil),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: true,
      // associated types don't introduce their own scope
      scopeKind: nil
    )
  }

  func testNonTypes() {
    // Functions, inits, deinits, subscripts, enum elements, macros, vars
    assertValueDecl(
      of: DeclSyntax("func myFunc() {}"),
      name: DeclName.identifier(identifier: Identifier(canonicalName: "myFunc"), args: []),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: false,
      scopeKind: .functionDecl
    )
    assertValueDecl(
      of: DeclSyntax("extension Type { init () }")
        .children(ofType: InitializerDeclSyntax.self)[0],
      name: DeclName.`init`(args: []),
      isStatic: .success(true),
      isTypeDecl: false,
      scopeKind: .initializerDecl
    )
    assertValueDecl(
      // Test resilience against missing syntax
      of: DeclSyntax("class { deinit }")
        .children(ofType: DeinitializerDeclSyntax.self)[0],
      name: DeclName.`deinit`,
      isStatic: .success(false),
      isTypeDecl: false,
      scopeKind: .deinitializerDecl
    )
    assertValueDecl(
      // E.g. In a protocol
      of: DeclSyntax("protocol { subscript() -> Int }")
        .children(ofType: SubscriptDeclSyntax.self)[0],
      name: DeclName.subscript(args: []),
      isStatic: .success(false),
      isTypeDecl: false,
      scopeKind: .subscriptDecl
    )
    assertValueDecl(
      of: DeclSyntax("enum A { case myCase }")
        .children(ofType: EnumCaseElementSyntax.self)[0],
      // An enum case without arguments has `nil` arguments, not `[]`.
      name: DeclName.identifier(identifier: Identifier(canonicalName: "myCase"), args: nil),
      isStatic: .success(true),
      isTypeDecl: false,
      scopeKind: .memberBlock  //Enum case decl isn't a scope
    )
    assertValueDecl(
      of: DeclSyntax("public macro fileID<T: ExpressibleByStringLiteral>() -> T = Builtin.FileIDMacro"),
      name: DeclName.identifier(
        macro: DeclName.MacroType(isFreestanding: false, isAttached: false),
        identifier: Identifier(canonicalName: "fileID"),
        args: []
      ),
      isStatic: .failure(.macrosOnlyAtFileScope),
      isTypeDecl: false,
      scopeKind: .macroDecl
    )
    assertValueDecl(
      // Extract the identifier pattern from the variable declaration
      of: DeclSyntax(stringLiteral: "var myVar")
        .children(ofType: IdentifierPatternSyntax.self)[0],
      name: DeclName.identifier(identifier: Identifier(canonicalName: "myVar"), args: nil),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: false,
      scopeKind: .variableDecl
    )
  }

  func testStatic() {
    // Note that static/class doesn't care about parent context, (e.g. global
    // funcs are 'nonstatic')

    // Simple cases (types tested above)
    assertValueDecl(
      of: DeclSyntax("struct { static func $myFunc() }")
        .children(ofType: FunctionDeclSyntax.self)[0],
      name: DeclName.identifier(identifier: Identifier(canonicalName: "$myFunc"), args: []),
      isStatic: .success(true),
      isTypeDecl: false,
      scopeKind: .functionDecl
    )
    assertValueDecl(
      of: DeclSyntax("class subscript() {}"),
      name: DeclName.subscript(args: []),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: false,
      scopeKind: .subscriptDecl
    )

    // Deinits can't be static
    assertValueDecl(
      of: DeclSyntax("class { static deinit }")
        .children(ofType: DeinitializerDeclSyntax.self)[0],
      name: DeclName.deinit,
      isStatic: .success(false),
      isTypeDecl: false,
      scopeKind: .deinitializerDecl
    )

    // Identifier pattern in variable declaration (scope tests)
    assertValueDecl(
      of: DeclSyntax("extension { let $myConst = 5 }")
        .children(ofType: IdentifierPatternSyntax.self)[0],
      name: DeclName.identifier(identifier: Identifier(canonicalName: "$myConst"), args: nil),
      isStatic: .success(false),
      isTypeDecl: false,
      scopeKind: .variableDecl
    )
    // Add static
    assertValueDecl(
      of: DeclSyntax("actor { static var myVar }")
        .children(ofType: IdentifierPatternSyntax.self)[0],
      name: DeclName.identifier(identifier: Identifier(canonicalName: "myVar"), args: nil),
      isStatic: .success(true),
      isTypeDecl: false,
      scopeKind: .variableDecl
    )

    // Failures
    //
    // Top-level
    assertValueDecl(
      of: DeclSyntax("static func $myFunc()"),
      name: DeclName.identifier(identifier: Identifier(canonicalName: "$myFunc"), args: []),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: false,
      scopeKind: .functionDecl
    )
    assertValueDecl(
      of: DeclSyntax("class subscript() {}"),
      name: DeclName.subscript(args: []),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: false,
      scopeKind: .subscriptDecl
    )
    assertValueDecl(
      of: DeclSyntax("let a: Int")
        .children(ofType: IdentifierPatternSyntax.self)[0],
      name: DeclName.identifier(identifier: Identifier(canonicalName: "a"), args: nil),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: false,
      scopeKind: .variableDecl
    )
    assertValueDecl(
      of: DeclSyntax("case x")
        .children(ofType: EnumCaseElementSyntax.self)[0],
      name: DeclName.identifier(identifier: Identifier(canonicalName: "x"), args: nil),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: false,
      scopeKind: nil
    )
    // Macro failure
    assertValueDecl(
      of: DeclSyntax("macro myMacro"),
      // Macros never have `nil` args. E.g. We can always write `@Observable`
      name: DeclName.identifier(
        macro: DeclName.MacroType(isFreestanding: false, isAttached: false),
        identifier: Identifier(canonicalName: "myMacro"),
        args: []
      ),
      isStatic: .failure(.macrosOnlyAtFileScope),
      isTypeDecl: false,
      scopeKind: .macroDecl
    )
    // Scope-lookup failure
    assertValueDecl(
      // Detached => no scope
      of: DeclSyntax("let x")
        .children(ofType: IdentifierPatternSyntax.self)[0]
        .detached,
      name: DeclName.identifier(identifier: Identifier(canonicalName: "x"), args: nil),
      isStatic: .failure(.scopeFailure),
      isTypeDecl: false,
      scopeKind: nil
    )
    assertValueDecl(
      // Attached but wrong scope (IfExprSyntax)
      of: ExprSyntax("if let myVar = optionalValue {}")
        .children(ofType: IdentifierPatternSyntax.self)[0],
      name: DeclName.identifier(identifier: Identifier(canonicalName: "myVar"), args: nil),
      isStatic: .failure(.scopeFailure),
      isTypeDecl: false,
      scopeKind: .ifExpr
    )
    assertValueDecl(
      // Detached enum elements can't find their enum case parent
      of: EnumCaseElementSyntax(name: .identifier("x")),
      name: DeclName.identifier(identifier: Identifier(canonicalName: "x"), args: nil),
      isStatic: .failure(.scopeFailure),
      isTypeDecl: false,
      scopeKind: nil
    )
  }

  /// Test macro names, `callAsFunction`, and names with arguments
  func testComplexNames() {
    // Generic parameter's aren't part of the name (at least for now)
    assertValueDecl(
      of: DeclSyntax("protocol MyProto<T>"),
      name: DeclName.identifier(identifier: Identifier(canonicalName: "MyProto"), args: nil),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: true,
      scopeKind: .protocolDecl
    )

    // Even though a function missing the parameter clause syntax,
    // should have an empty arguments array to distinguish it from
    // a variable. For instance, if an autocompletition tool finds
    // this function through, it will still insert the parentheses
    // (since this is a function).
    assertValueDecl(
      of: DeclSyntax("func 5 {}"),
      name: DeclName.invalid(nonIdentifier: .identifier(""), args: []),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: false,
      scopeKind: .functionDecl
    )

    // Test function labels
    assertValueDecl(
      of: DeclSyntax("func hi(_: Int, _ a: Int, x y: Int)"),
      name: DeclName.identifier(
        identifier: Identifier(canonicalName: "hi"),
        args: [nil, nil, Identifier(canonicalName: "x")]
      ),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: false,
      scopeKind: .functionDecl
    )
    assertValueDecl(
      of: DeclSyntax("init?(_: Int, _ a: Int, x y: Int)"),
      name: DeclName.`init`(args: [nil, nil, Identifier(canonicalName: "x")]),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: false,
      scopeKind: .initializerDecl
    )
    assertValueDecl(
      of: DeclSyntax("macro myMacro(_: Int, _ a: Int, x y: Int)"),
      name: DeclName.identifier(
        macro: DeclName.MacroType(isFreestanding: false, isAttached: false),
        identifier: Identifier(canonicalName: "myMacro"),
        args: [nil, nil, Identifier(canonicalName: "x")]
      ),
      isStatic: .failure(.macrosOnlyAtFileScope),
      isTypeDecl: false,
      scopeKind: .macroDecl
    )

    // Enums have different argument syntax
    //
    // FIXME: Compiler surfaces "invalid_token" as the argument name.
    // I think it makes more sense to use `label2` because most people
    // get tripped up from functions and assume that's the actual label.
    assertValueDecl(
      of: DeclSyntax("case _, withArgs(Bool, label1: Int, label2 invalid_token: Int)")
        .children(ofType: EnumCaseElementSyntax.self)[1],
      name: DeclName.identifier(
        identifier: Identifier(canonicalName: "withArgs"),
        args: [nil, Identifier(canonicalName: "label1"), Identifier(canonicalName: "label2")]
      ),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: false,
      // Enum case decls aren't scopes
      scopeKind: nil
    )
    // Enums with no associated values aren't allowed (even with parentheses), so interpret
    // them as no-argument identifiers
    assertValueDecl(
      of: DeclSyntax("case noAssociatedVals()")
        .children(ofType: EnumCaseElementSyntax.self)[0],
      name: DeclName.identifier(
        identifier: Identifier(canonicalName: "noAssociatedVals"),
        args: nil  // Not []
      ),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: false,
      scopeKind: nil
    )
    // Check for resilience: enum cases with labels but no type
    assertValueDecl(
      of: DeclSyntax("case caseWithoutTypes(a:, b:)")
        .children(ofType: EnumCaseElementSyntax.self)[0],
      name: DeclName.identifier(
        identifier: Identifier(canonicalName: "caseWithoutTypes"),
        args: [Identifier(canonicalName: "a"), Identifier(canonicalName: "b")]
      ),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: false,
      scopeKind: nil
    )

    // Subscripts don't have argument labels by default :(
    assertValueDecl(
      of: DeclSyntax("subscript unexpectedName(_: Int, _ n: Int, x: Int, x y: Int) -> Int"),
      name: DeclName.subscript(
        args: [nil, nil, nil, Identifier(canonicalName: "x")]
      ),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: false,
      scopeKind: .subscriptDecl
    )

    // Test invalid arg label
    assertValueDecl(
      of: DeclSyntax("func myFunc(5y: Int)"),
      name: DeclName.identifier(
        identifier: Identifier(canonicalName: "myFunc"),
        args: [nil]
      ),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: false,
      scopeKind: .functionDecl
    )

    // Call as function only works for instance methods of any
    // declaration group (including protocols and extensions)
    assertValueDecl(
      of: DeclSyntax("extension MyNominalType { func callAsFunction }")
        .children(ofType: FunctionDeclSyntax.self)[0],
      name: DeclName.callAsFunction(args: []),
      isStatic: .success(false),
      isTypeDecl: false,
      scopeKind: .functionDecl
    )
    assertValueDecl(
      of: DeclSyntax("protocol MyProto { func callAsFunction (a: Int) }")
        .children(ofType: FunctionDeclSyntax.self)[0],
      name: DeclName.callAsFunction(args: [Identifier(canonicalName: "a")]),
      isStatic: .success(false),
      isTypeDecl: false,
      scopeKind: .functionDecl
    )
    // callAsFunction doesn't work at the top-level
    assertValueDecl(
      of: DeclSyntax("func callAsFunction"),
      name: DeclName.identifier(
        identifier: Identifier(canonicalName: "callAsFunction"),
        args: []
      ),
      isStatic: .failure(.unsupportedAtTopLevel),
      isTypeDecl: false,
      scopeKind: .functionDecl
    )
    // callAsFunction doesn't work for static functions, enum elements,
    // or variables
    assertValueDecl(
      of: DeclSyntax("class A { static func callAsFunction }")
        .children(ofType: FunctionDeclSyntax.self)[0],
      name: DeclName.identifier(
        identifier: Identifier(canonicalName: "callAsFunction"),
        args: []
      ),
      isStatic: .success(true),
      isTypeDecl: false,
      scopeKind: .functionDecl
    )
    assertValueDecl(
      of: DeclSyntax("actor A { var callAsFunction: () -> Void }")
        .children(ofType: IdentifierPatternSyntax.self)[0],
      name: DeclName.identifier(
        identifier: Identifier(canonicalName: "callAsFunction"),
        args: nil
      ),
      isStatic: .success(false),
      isTypeDecl: false,
      scopeKind: .variableDecl
    )
    assertValueDecl(
      of: DeclSyntax("enum A { case callAsFunction }")
        .children(ofType: EnumCaseElementSyntax.self)[0],
      name: DeclName.identifier(
        identifier: Identifier(canonicalName: "callAsFunction"),
        args: nil
      ),
      isStatic: .success(true),
      isTypeDecl: false,
      scopeKind: .memberBlock  // enum cases aren't scopes
    )

    // Macro names depend on the attached/freestanding attributes
    // TODO: Implement
    assertValueDecl(
      of: DeclSyntax("macro myMacro(_: Int, _ n: Int, x: Int, x y: Int)"),
      name: DeclName.identifier(
        macro: DeclName.MacroType(isFreestanding: false, isAttached: false),
        identifier: Identifier(canonicalName: "myMacro"),
        args: [nil, nil, Identifier(canonicalName: "x"), Identifier(canonicalName: "x")]
      ),
      isStatic: .failure(.macrosOnlyAtFileScope),
      isTypeDecl: false,
      scopeKind: .macroDecl
    )
  }

  // Certain declarations aren't value declarations.
  //
  // In particular, check for enum case and var declarations,
  // which one may assume produce names directly (their children do).
  func testNonValueDecls() {
    XCTAssert(
      ValueDeclSyntax(DeclSyntax("case myCase")) == nil,
      "Expected initialization to value declaration to fail: case declarations aren't values; case elements are."
    )
    XCTAssert(
      ValueDeclSyntax(DeclSyntax("var myVar")) == nil,
      "Expected initialization to value declaration to fail: var declarations aren't values; patter identifiers are."
    )
  }

  // TODO: Add name matching
}
