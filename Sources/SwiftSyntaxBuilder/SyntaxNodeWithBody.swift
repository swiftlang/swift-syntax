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

#if compiler(>=6)
public import SwiftSyntax
internal import SwiftParser
#else
import SwiftSyntax
import SwiftParser
#endif

// MARK: - PartialSyntaxNode

@available(*, deprecated, renamed: "SyntaxNodeString")
public typealias PartialSyntaxNodeString = SyntaxNodeString

/// A type that is expressible by string interpolation the same way that syntax
/// nodes are, but instead of producing a node, it stores the string interpolation
/// text.
///
/// Used to represent partial syntax nodes in initializers that take a
/// trailing code block.
///
/// This type should always be constructed using string interpolation.
public struct SyntaxNodeString: SyntaxExpressibleByStringInterpolation {
  let sourceText: [UInt8]

  public init(stringInterpolation: SyntaxStringInterpolation) {
    self.sourceText = stringInterpolation.sourceText
  }
}

extension SyntaxStringInterpolation {
  public mutating func appendInterpolation(_ value: SyntaxNodeString) {
    sourceText.append(contentsOf: value.sourceText)
    self.lastIndentation = nil
  }
}

// MARK: - HasTrailingCodeBlock

public protocol HasTrailingCodeBlock: WithCodeBlockSyntax {
  /// Constructs a syntax node where `header` builds the text of the node before the body in braces and `bodyBuilder` is used to build the node’s body.
  ///
  /// For example, you can construct
  ///
  /// ```swift
  /// while x < 5 {
  ///   x += 1
  /// }
  /// ```
  ///
  /// using this call
  ///
  /// ```swift
  /// try WhileStmtSyntax("while x < 5") {
  ///   ExprSyntax("x += 1")
  /// }
  /// ```
  ///
  /// Throws an error if `header` defines a different node type than the type the initializer is called on. E.g. if calling `try IfStmtSyntax("while x < 5") {}`
  init(_ header: SyntaxNodeString, @CodeBlockItemListBuilder bodyBuilder: () throws -> CodeBlockItemListSyntax) rethrows
}

extension HasTrailingCodeBlock where Self: StmtSyntaxProtocol {
  public init(
    _ header: SyntaxNodeString,
    @CodeBlockItemListBuilder bodyBuilder: () throws -> CodeBlockItemListSyntax
  ) throws {
    let stmt = StmtSyntax("\(header) {}")
    guard let castedStmt = stmt.as(Self.self) else {
      throw SyntaxStringInterpolationInvalidNodeTypeError(expectedType: Self.self, actualNode: stmt)
    }
    self = castedStmt
    self.body = try CodeBlockSyntax(statements: bodyBuilder())
  }
}

extension CatchClauseSyntax: HasTrailingCodeBlock {
  public init(
    _ header: SyntaxNodeString,
    @CodeBlockItemListBuilder bodyBuilder: () throws -> CodeBlockItemListSyntax
  ) rethrows {
    self = CatchClauseSyntax("\(header) {}")
    self.body = try CodeBlockSyntax(statements: bodyBuilder())
  }
}
extension DeferStmtSyntax: HasTrailingCodeBlock {}
extension DoStmtSyntax: HasTrailingCodeBlock {}
extension ForStmtSyntax: HasTrailingCodeBlock {}
extension GuardStmtSyntax: HasTrailingCodeBlock {}
extension WhileStmtSyntax: HasTrailingCodeBlock {}

// MARK: - WithOptionalCodeBlockSyntax

extension WithOptionalCodeBlockSyntax where Self: DeclSyntaxProtocol {
  /// Constructs a syntax node where `header` builds the text of the node before the body in braces and `bodyBuilder` is used to build the node’s body.
  ///
  /// For example, you can construct
  ///
  /// ```swift
  /// func addOne(_ base: Int) -> Int {
  ///   return base + 1
  /// }
  /// ```
  ///
  /// using this call
  ///
  /// ```swift
  /// try FunctionDeclSyntax("func addOne(_ base: Int) -> Int") {
  ///   ExprSyntax("return base + 1")
  /// }
  /// ```
  ///
  /// Throws an error if `header` defines a different node type than the type the initializer is called on. E.g. if calling `try FunctionDeclSyntax("init") {}`
  public init(
    _ header: SyntaxNodeString,
    @CodeBlockItemListBuilder bodyBuilder: () throws -> CodeBlockItemListSyntax
  ) throws {
    // If the type provides a custom `SyntaxParseable` implementation, use that. Otherwise construct it as a
    // `DeclSyntax`.
    // We cannot use normal string interpolation here because the conformance to `ExpressibleByStringInterpolation` is
    // not implied by `SyntaxParsable` but generated for each type by
    // `SyntaxExpressibleByStringInterpolationConformances.swift`. And we can’t use that protocol in the `as?` check
    // because then the compiler complains that `parsableType` is not instantiable. So, manually do the same work that
    // a string literal with interpolation segments would do.
    let decl: DeclSyntax
    var stringInterpolation = SyntaxStringInterpolation(literalCapacity: 1, interpolationCount: 1)
    stringInterpolation.appendInterpolation(header)
    stringInterpolation.appendLiteral(" {}")
    if let parsableType = Self.self as? SyntaxParseable.Type {
      decl = parsableType.init(stringInterpolation: stringInterpolation).cast(DeclSyntax.self)
    } else {
      decl = DeclSyntax(stringInterpolation: stringInterpolation)
    }
    guard let castedDecl = decl.as(Self.self) else {
      throw SyntaxStringInterpolationInvalidNodeTypeError(expectedType: Self.self, actualNode: decl)
    }
    self = castedDecl
    self.body = try CodeBlockSyntax(statements: bodyBuilder())
  }
}

// MARK: HasTrailingMemberDeclBlock

public protocol HasTrailingMemberDeclBlock {
  var memberBlock: MemberBlockSyntax { get set }

  /// Constructs a syntax node where `header` builds the text of the node before the members in braces and `membersBuilder` is used to list the node’s members.
  ///
  /// For example, you can construct
  ///
  /// ```swift
  /// struct Point {
  ///   var x: Int
  ///   var y: Int
  /// }
  /// ```
  ///
  /// using this call
  ///
  /// ```swift
  /// try StructDeclSyntax("struct Point") {
  ///   DeclSyntax("var x: Int")
  ///   DeclSyntax("var y: Int")
  /// }
  /// ```
  ///
  /// Throws an error if `header` defines a different node type than the type the initializer is called on. E.g. if calling `try StructDeclSyntax("class MyClass") {}`
  init(
    _ header: SyntaxNodeString,
    @MemberBlockItemListBuilder membersBuilder: () throws -> MemberBlockItemListSyntax
  ) throws
}

extension HasTrailingMemberDeclBlock where Self: DeclSyntaxProtocol {
  public init(
    _ header: SyntaxNodeString,
    @MemberBlockItemListBuilder membersBuilder: () throws -> MemberBlockItemListSyntax
  ) throws {
    // If the type provides a custom `SyntaxParseable` implementation, use that. Otherwise construct it as a
    // `DeclSyntax`.
    let decl: DeclSyntax
    var stringInterpolation = SyntaxStringInterpolation(literalCapacity: 1, interpolationCount: 1)
    stringInterpolation.appendInterpolation(header)
    stringInterpolation.appendLiteral(" {}")
    if let parsableType = Self.self as? SyntaxParseable.Type {
      decl = parsableType.init(stringInterpolation: stringInterpolation).cast(DeclSyntax.self)
    } else {
      decl = DeclSyntax(stringInterpolation: stringInterpolation)
    }
    guard let castedDecl = decl.as(Self.self) else {
      throw SyntaxStringInterpolationInvalidNodeTypeError(expectedType: Self.self, actualNode: decl)
    }
    self = castedDecl
    self.memberBlock = try MemberBlockSyntax(members: membersBuilder())
  }
}

extension ActorDeclSyntax: HasTrailingMemberDeclBlock {}
extension ClassDeclSyntax: HasTrailingMemberDeclBlock {}
extension EnumDeclSyntax: HasTrailingMemberDeclBlock {}
extension ExtensionDeclSyntax: HasTrailingMemberDeclBlock {}
extension ProtocolDeclSyntax: HasTrailingMemberDeclBlock {}
extension StructDeclSyntax: HasTrailingMemberDeclBlock {}

// MARK: - IfExprSyntax
// IfExprSyntax is a special scenario as we also have the `else` body or an if-else
// So we cannot conform to `HasTrailingCodeBlock`

extension IfExprSyntax {
  /// Constructs an `if` expression with an optional `else` block.
  ///
  /// `header` specifies the part of the `if` expression before the body’s first brace.
  ///
  /// For example, the following `if` expression has the header `if sunny`
  ///
  /// ```swift
  /// if sunny {
  ///   sunbath()
  /// }
  /// ```
  ///
  /// If `elseBuilder` is not `nil`, an `else` keyword will automatically be inserted.
  ///
  /// This function takes care of inserting the braces as well.
  ///
  /// Throws an error if `header` does not start an `if` expression. E.g. if calling `try IfExprSyntax("while true") {}`
  public init(
    _ header: SyntaxNodeString,
    @CodeBlockItemListBuilder bodyBuilder: () throws -> CodeBlockItemListSyntax,
    @CodeBlockItemListBuilder `else` elseBuilder: () throws -> CodeBlockItemListSyntax? = { nil }
  ) throws {
    let expr = ExprSyntax("\(header) {}")
    guard let ifExpr = expr.as(Self.self) else {
      throw SyntaxStringInterpolationInvalidNodeTypeError(expectedType: Self.self, actualNode: expr)
    }
    self = ifExpr
    self.body = try CodeBlockSyntax(statements: bodyBuilder())
    self.elseBody = try elseBuilder().map { .codeBlock(CodeBlockSyntax(statements: $0)) }
    self.elseKeyword = elseBody != nil ? .keyword(.else) : nil
  }

  /// Constructs an `if` expression with a following `else if` clause.
  /// This can be used to create longer chains of `if`, `else if` expressions.
  ///
  /// For example, you can construct
  ///
  /// ```swift
  /// if x == 1 {
  ///     return "one
  /// } else if x == 2 {
  ///     return "two
  /// } else {
  ///     return "many
  /// }
  /// ```
  ///
  /// using this call
  ///
  /// ```swift
  /// try IfExprSyntax(
  ///   "if x == 1",
  ///   bodyBuilder: {
  ///     StmtSyntax(#"return "one""#)
  ///   }, elseIf: IfExprSyntax(
  ///     "if x == 2",
  ///     bodyBuilder: {
  ///       StmtSyntax(#"return "two""#)
  ///     }, else: {
  ///       StmtSyntax(#"return "many""#)
  ///     }
  ///   )
  /// )
  /// ```
  ///
  /// Throws an error if `header` does not start an `if` expression. E.g. if calling `try IfExprSyntax("while true", bodyBuilder: {}, elseIf: {})`
  public init(
    _ header: SyntaxNodeString,
    @CodeBlockItemListBuilder bodyBuilder: () throws -> CodeBlockItemListSyntax,
    elseIf: IfExprSyntax
  ) throws {
    let expr = ExprSyntax("\(header) {}")
    guard let ifExpr = expr.as(Self.self) else {
      throw SyntaxStringInterpolationInvalidNodeTypeError(expectedType: Self.self, actualNode: expr)
    }
    self = ifExpr
    self.body = CodeBlockSyntax(statements: try bodyBuilder())
    self.elseBody = .ifExpr(elseIf)
    self.elseKeyword = elseBody != nil ? .keyword(.else) : nil
  }
}

// MARK: - SwitchCase

extension SwitchCaseSyntax {
  /// Constructs a case item where `header` includes the text between the `case` keyword and the `:` (both inclusive) and `statementsBuilder` can be used to build the statements inside the case item.
  ///
  /// For example, you can construct
  ///
  /// ```swift
  /// default:
  ///   return nil
  /// ```
  ///
  /// using this call
  ///
  /// ```swift
  /// try SwitchCaseSyntax("default:") {
  ///   StmtSyntax("return")
  /// }
  /// ```
  ///
  /// Throws an error if `header` does not start a switch case item. E.g. if calling `try SwitchCaseSyntax("func foo") {}`
  public init(
    _ header: SyntaxNodeString,
    @CodeBlockItemListBuilder statementsBuilder: () throws -> CodeBlockItemListSyntax
  ) rethrows {
    self = SwitchCaseSyntax("\(header)")
    self.statements = try statementsBuilder()
  }
}

// MARK: - SwitchExprSyntax
// SwitchExprSyntax is a special scenario as it don't have body or members
// So we cannot conform to `HasTrailingCodeBlock` or `HasTrailingMemberDeclBlock`

extension SwitchExprSyntax {
  /// Constructs a `switch` expression where `header` builds the text before the opening `{` and `casesBuilder` can be used to build the case items.
  ///
  /// For example, to construct
  ///
  /// ```swift
  /// switch direction {
  /// case .up:
  ///   goUp()
  /// case .down:
  ///   goDown()
  /// }
  /// ```
  ///
  /// using this call
  ///
  /// ```swift
  /// try SwitchExprSyntax("switch direction") {
  ///   SwitchCaseSyntax("case .up: goUp()")
  ///   SwitchCaseSyntax("case .down: goDown()")
  /// }
  /// ```
  ///
  /// Throws an error if `header` does not start a switch expression. E.g. if calling `try SwitchExprSyntax("if x < 42") {}`
  public init(
    _ header: SyntaxNodeString,
    @SwitchCaseListBuilder casesBuilder: () throws -> SwitchCaseListSyntax = { SwitchCaseListSyntax([]) }
  ) throws {
    let expr = ExprSyntax("\(header) {}")
    guard let switchExpr = expr.as(Self.self) else {
      throw SyntaxStringInterpolationInvalidNodeTypeError(expectedType: Self.self, actualNode: expr)
    }
    self = switchExpr
    self.cases = try casesBuilder()
  }
}

// MARK: - VariableDeclSyntax
// VariableDeclSyntax is a special scenario as it don't have body or members
// So we cannot conform to `HasTrailingCodeBlock` or `HasTrailingMemberDeclBlock`

extension VariableDeclSyntax {
  /// Construct a variable with a single `get` accessor where `header` builds the text before the opening `{` and `accessor` builds the accessor body.
  ///
  /// For example, to construct
  ///
  /// ```swift
  /// var x: Int {
  ///   return origin.x
  /// }
  /// ```
  ///
  /// using this call
  ///
  /// ```swift
  /// try VariableDeclSyntax("var x: Int") {
  ///   StmtSyntax("return origin.x")
  /// }
  /// ```
  ///
  /// Throws an error if `header` does not start a variable declaration. E.g. if calling `try VariableDeclSyntax("func foo") {}`
  public init(
    _ header: SyntaxNodeString,
    @CodeBlockItemListBuilder accessor: () throws -> CodeBlockItemListSyntax
  ) throws {
    let decl = DeclSyntax("\(header) {}")
    guard let castedDecl = decl.as(Self.self) else {
      throw SyntaxStringInterpolationInvalidNodeTypeError(expectedType: Self.self, actualNode: decl)
    }
    self = castedDecl
    precondition(self.bindings.count == 1)
    var binding: PatternBindingSyntax? = self.bindings.last
    binding?.accessorBlock = AccessorBlockSyntax(accessors: .getter(try accessor()))
    bindings = PatternBindingListSyntax([binding].compactMap { $0 })
  }
}
