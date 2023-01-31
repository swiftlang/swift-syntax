//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

// MARK: - PartialSyntaxNode

/// A type that is expressible by string interpolation the same way that syntax
/// nodes are, but instead of producing a node, it stores the string interpolation
/// text. Used to represent partial syntax nodes in initializers that take a
/// trailing code block.
///
/// This type should always be constructed using string interpolation.
public struct PartialSyntaxNodeString: SyntaxExpressibleByStringInterpolation {
  let sourceText: [UInt8]

  public init(stringInterpolation: SyntaxStringInterpolation) {
    self.sourceText = stringInterpolation.sourceText
  }
}

extension SyntaxStringInterpolation {
  public mutating func appendInterpolation(_ value: PartialSyntaxNodeString) {
    sourceText.append(contentsOf: value.sourceText)
    self.lastIndentation = nil
  }
}

// MARK: - HasCodeBlock

public protocol HasTrailingCodeBlock {
  var body: CodeBlockSyntax { get set }

  init(_ header: PartialSyntaxNodeString, @CodeBlockItemListBuilder bodyBuilder: () throws -> CodeBlockItemListSyntax) throws
}

public extension HasTrailingCodeBlock where Self: StmtSyntaxProtocol {
  init(_ header: PartialSyntaxNodeString, @CodeBlockItemListBuilder bodyBuilder: () throws -> CodeBlockItemListSyntax) throws {
    let stmt = StmtSyntax("\(header) {}")
    guard let castedStmt = stmt.as(Self.self) else {
      throw SyntaxStringInterpolationError.producedInvalidNodeType(expectedType: Self.self, actualNode: stmt)
    }
    self = castedStmt
    self.body = try CodeBlockSyntax(statements: bodyBuilder())
  }
}

extension CatchClauseSyntax: HasTrailingCodeBlock {
  public init(_ header: PartialSyntaxNodeString, @CodeBlockItemListBuilder bodyBuilder: () throws -> CodeBlockItemListSyntax) throws {
    self = CatchClauseSyntax("\(header) {}")
    self.body = try CodeBlockSyntax(statements: bodyBuilder())
  }
}
extension DeferStmtSyntax: HasTrailingCodeBlock {}
extension DoStmtSyntax: HasTrailingCodeBlock {}
extension ForInStmtSyntax: HasTrailingCodeBlock {}
extension GuardStmtSyntax: HasTrailingCodeBlock {}
extension WhileStmtSyntax: HasTrailingCodeBlock {}

// MARK: - HasOptionalCodeBlock

public protocol HasTrailingOptionalCodeBlock {
  var body: CodeBlockSyntax? { get set }

  init(_ header: PartialSyntaxNodeString, @CodeBlockItemListBuilder bodyBuilder: () throws -> CodeBlockItemListSyntax) throws
}

public extension HasTrailingOptionalCodeBlock where Self: DeclSyntaxProtocol {
  init(_ header: PartialSyntaxNodeString, @CodeBlockItemListBuilder bodyBuilder: () throws -> CodeBlockItemListSyntax) throws {
    let decl = DeclSyntax("\(header) {}")
    guard let castedDecl = decl.as(Self.self) else {
      throw SyntaxStringInterpolationError.producedInvalidNodeType(expectedType: Self.self, actualNode: decl)
    }
    self = castedDecl
    self.body = try CodeBlockSyntax(statements: bodyBuilder())
  }
}

extension AccessorDeclSyntax: HasTrailingOptionalCodeBlock {}
extension DeinitializerDeclSyntax: HasTrailingOptionalCodeBlock {}
extension FunctionDeclSyntax: HasTrailingOptionalCodeBlock {}
extension InitializerDeclSyntax: HasTrailingOptionalCodeBlock {}

// MARK: HasTrailingMemberDeclBlock

public protocol HasTrailingMemberDeclBlock {
  var members: MemberDeclBlockSyntax { get set }

  init(_ header: PartialSyntaxNodeString, @MemberDeclListBuilder membersBuilder: () throws -> MemberDeclListSyntax) throws
}

public extension HasTrailingMemberDeclBlock where Self: DeclSyntaxProtocol {
  init(_ header: PartialSyntaxNodeString, @MemberDeclListBuilder membersBuilder: () throws -> MemberDeclListSyntax) throws {
    let decl = DeclSyntax("\(header) {}")
    guard let castedDecl = decl.as(Self.self) else {
      throw SyntaxStringInterpolationError.producedInvalidNodeType(expectedType: Self.self, actualNode: decl)
    }
    self = castedDecl
    self.members = try MemberDeclBlockSyntax(members: membersBuilder())
  }
}

extension ActorDeclSyntax: HasTrailingMemberDeclBlock {}
extension ClassDeclSyntax: HasTrailingMemberDeclBlock {}
extension EnumDeclSyntax: HasTrailingMemberDeclBlock {}
extension ExtensionDeclSyntax: HasTrailingMemberDeclBlock {}
extension ProtocolDeclSyntax: HasTrailingMemberDeclBlock {}
extension StructDeclSyntax: HasTrailingMemberDeclBlock {}

// MARK: - IfStmtSyntax
// IfStmtSyntax is a special scenario as we also have the `else` body or an if-else
// So we cannot conform to `HasTrailingCodeBlock`

public extension IfStmtSyntax {
  init(_ header: PartialSyntaxNodeString, @CodeBlockItemListBuilder bodyBuilder: () throws -> CodeBlockItemListSyntax, @CodeBlockItemListBuilder `else` elseBuilder: () throws -> CodeBlockItemListSyntax? = { nil }) throws {
    let stmt = StmtSyntax("\(header) {}")
    guard let ifStmt = stmt.as(IfStmtSyntax.self) else {
      throw SyntaxStringInterpolationError.producedInvalidNodeType(expectedType: Self.self, actualNode: stmt)
    }
    self = ifStmt
    self.body = try CodeBlockSyntax(statements: bodyBuilder())
    self.elseBody = try elseBuilder().map { .codeBlock(CodeBlockSyntax(statements: $0)) }
    self.elseKeyword = elseBody != nil ? .keyword(.else) : nil
  }

  init(_ header: PartialSyntaxNodeString, @CodeBlockItemListBuilder bodyBuilder: () -> CodeBlockItemListSyntax, elseIf: IfStmtSyntax) throws {
    let stmt = StmtSyntax("\(header) {}")
    guard let ifStmt = stmt.as(IfStmtSyntax.self) else {
      throw SyntaxStringInterpolationError.producedInvalidNodeType(expectedType: Self.self, actualNode: stmt)
    }
    self = ifStmt
    self.body = CodeBlockSyntax(statements: bodyBuilder())
    self.elseBody = .ifStmt(elseIf)
    self.elseKeyword = elseBody != nil ? .keyword(.else) : nil
  }
}

// MARK: - SwitchStmtSyntax
// SwitchStmtSyntax is a special scenario as it don't have body or members
// So we cannot conform to `HasTrailingCodeBlock` or `HasTrailingMemberDeclBlock`

public extension SwitchStmtSyntax {
  init(_ header: PartialSyntaxNodeString, @SwitchCaseListBuilder casesBuilder: () throws -> SwitchCaseListSyntax = { SwitchCaseListSyntax([]) }) throws {
    let stmt = StmtSyntax("\(header) {}")
    guard let castedStmt = stmt.as(Self.self) else {
      throw SyntaxStringInterpolationError.producedInvalidNodeType(expectedType: Self.self, actualNode: stmt)
    }
    self = castedStmt
    self.cases = try casesBuilder()
  }
}

// MARK: - VariableDeclSyntax
// VariableDeclSyntax is a special scenario as it don't have body or members
// So we cannot conform to `HasTrailingCodeBlock` or `HasTrailingMemberDeclBlock`

public extension VariableDeclSyntax {
  init(_ header: PartialSyntaxNodeString, @CodeBlockItemListBuilder accessor: () throws -> CodeBlockItemListSyntax) throws {
    let decl = DeclSyntax("\(header) {}")
    guard let castedDecl = decl.as(Self.self) else {
      throw SyntaxStringInterpolationError.producedInvalidNodeType(expectedType: Self.self, actualNode: decl)
    }
    self = castedDecl
    assert(self.bindings.count == 1)
    var binding: PatternBindingSyntax? = self.bindings.last
    binding?.accessor = try .getter(CodeBlockSyntax(statements: accessor()))
    bindings = PatternBindingListSyntax([binding].compactMap { $0 })
  }
}
