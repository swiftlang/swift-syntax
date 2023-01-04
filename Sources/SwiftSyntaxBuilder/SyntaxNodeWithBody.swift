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

// MARK: - HasCodeBlock

// TODO: Consider removing `HasTrailingCodeBlock` and friends
// It'd be much nicer if we didn't have any builder APIs taking strings. We
// should just make convenvience inits where needed such that we could write:
//   `IfStmt("if foo")` -> `IfStmt(conditions: [.expression("foo")])`
//   `ProtocolDecl("public protocol SomeProto") -> `ProtocolDecl(modifiers: [.public], identifier: "SomeProto")`
//
// This is sort of what we used to have, but there weren't enough convenience
// initializers.
//   `SwitchCase(label: SwitchCaseLabel(caseItems: [CaseItem(pattern: ExpressionPattern(expression: MemberAccessExpr(name: "keyword")))]))`
// is currently
//   `SwitchCase("case .keyword:")`
// but ideally we'd have enough convenience initializers such that we could have:
//   `SwitchCase(pattern: ".keyword") { }`
//
// Another example is that we now have
//   `ExtensionDecl("\(docComment)extension \(node.type.shorthandName): ExpressibleByArrayLiteral")`
// which could be
//   `ExtensionDecl(leadingTrivia: docComment, extendedType: "\(node.type.shorthandName)", inheritances: ["ExpressibleByArrayLiteral"])`
public protocol HasTrailingCodeBlock {
  var body: CodeBlockSyntax { get set }
}

public extension HasTrailingCodeBlock where Self: SyntaxExpressibleByStringInterpolation {
  init(_ signature: String, @CodeBlockItemListBuilder bodyBuilder: () -> CodeBlockItemListSyntax) {
    self = "\(raw: signature) {}"
    self.body = CodeBlockSyntax(statements: bodyBuilder())
  }
}

extension CatchClauseSyntax: HasTrailingCodeBlock {}
extension DeferStmtSyntax: HasTrailingCodeBlock {}
extension DoStmtSyntax: HasTrailingCodeBlock {}
extension ForInStmtSyntax: HasTrailingCodeBlock {}
extension GuardStmtSyntax: HasTrailingCodeBlock {}
extension WhileStmtSyntax: HasTrailingCodeBlock {}

// MARK: - HasOptionalCodeBlock

public protocol HasTrailingOptionalCodeBlock {
  var body: CodeBlockSyntax? { get set }
}

public extension HasTrailingOptionalCodeBlock where Self: SyntaxExpressibleByStringInterpolation {
  init(_ signature: String, @CodeBlockItemListBuilder bodyBuilder: () -> CodeBlockItemListSyntax) {
    self = "\(raw: signature) {}"
    self.body = CodeBlockSyntax(statements: bodyBuilder())
  }
}

extension AccessorDeclSyntax: HasTrailingOptionalCodeBlock {}
extension DeinitializerDeclSyntax: HasTrailingOptionalCodeBlock {}
extension FunctionDeclSyntax: HasTrailingOptionalCodeBlock {}
extension InitializerDeclSyntax: HasTrailingOptionalCodeBlock {}

// MARK: HasTrailingMemberDeclBlock

public protocol HasTrailingMemberDeclBlock {
  var members: MemberDeclBlockSyntax { get set }
}

public extension HasTrailingMemberDeclBlock where Self: SyntaxExpressibleByStringInterpolation {
  init(_ signature: String, @MemberDeclListBuilder membersBuilder: () -> MemberDeclListSyntax) {
    self = "\(raw: signature) {}"
    self.members = MemberDeclBlockSyntax(members: membersBuilder())
  }
}

extension ActorDeclSyntax: HasTrailingMemberDeclBlock {}
extension ClassDeclSyntax: HasTrailingMemberDeclBlock {}
extension EnumDeclSyntax: HasTrailingMemberDeclBlock {}
extension ExtensionDeclSyntax: HasTrailingMemberDeclBlock {}
extension ProtocolDeclSyntax: HasTrailingMemberDeclBlock {}
extension StructDeclSyntax: HasTrailingMemberDeclBlock {}

// MARK: - IfStmt
// IfStmtSyntax is a special scenario as we also have the `else` body or an if-else
// So we cannot conform to `HasTrailingCodeBlock`

public extension IfStmtSyntax {
  init(_ signature: String, @CodeBlockItemListBuilder bodyBuilder: () -> CodeBlockItemListSyntax, @CodeBlockItemListBuilder `else` elseBuilder: () -> CodeBlockItemListSyntax? = { nil }) {
    self = "\(raw: signature) {}"
    self.body = CodeBlockSyntax(statements: bodyBuilder())
    self.elseBody = elseBuilder().map { .codeBlock(CodeBlockSyntax(statements: $0)) }
    self.elseKeyword = elseBody != nil ? .keyword(.else) : nil
  }

  init(_ signature: String, @CodeBlockItemListBuilder bodyBuilder: () -> CodeBlockItemListSyntax, elseIf: IfStmtSyntax) {
    self = "\(raw: signature) {}"
    self.body = CodeBlockSyntax(statements: bodyBuilder())
    self.elseBody = .ifStmt(elseIf)
    self.elseKeyword = elseBody != nil ? .keyword(.else) : nil
  }
}
