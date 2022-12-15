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
//   `SwitchCase(label: SwitchCaseLabel(caseItems: [CaseItem(pattern: ExpressionPattern(expression: MemberAccessExpr(name: "contextualKeyword")))]))`
// is currently
//   `SwitchCase("case .contextualKeyword:")`
// but ideally we'd have enough convenience initializers such that we could have:
//   `SwitchCase(pattern: ".contextualKeyword") { }`
//
// Another example is that we now have
//   `ExtensionDecl("\(docComment)extension \(node.type.shorthandName): ExpressibleByArrayLiteral")`
// which could be
//   `ExtensionDecl(leadingTrivia: docComment, extendedType: "\(node.type.shorthandName)", inheritances: ["ExpressibleByArrayLiteral"])`
public protocol HasTrailingCodeBlock {
  var body: CodeBlock { get set }
}

public extension HasTrailingCodeBlock where Self: SyntaxExpressibleByStringInterpolation {
  init(_ signature: String, @CodeBlockItemListBuilder bodyBuilder: () -> CodeBlockItemListSyntax) {
    self = "\(raw: signature) {}"
    self.body = CodeBlock(statements: bodyBuilder())
  }
}

extension CatchClause: HasTrailingCodeBlock {}
extension DeferStmt: HasTrailingCodeBlock {}
extension DoStmt: HasTrailingCodeBlock {}
extension ForInStmt: HasTrailingCodeBlock {}
extension GuardStmt: HasTrailingCodeBlock {}
extension WhileStmt: HasTrailingCodeBlock {}

// MARK: - HasOptionalCodeBlock

public protocol HasTrailingOptionalCodeBlock {
  var body: CodeBlockSyntax? { get set }
}

public extension HasTrailingOptionalCodeBlock where Self: SyntaxExpressibleByStringInterpolation {
  init(_ signature: String, @CodeBlockItemListBuilder bodyBuilder: () -> CodeBlockItemListSyntax) {
    self = "\(raw: signature) {}"
    self.body = CodeBlock(statements: bodyBuilder())
  }
}

extension AccessorDeclSyntax: HasTrailingOptionalCodeBlock {}
extension DeinitializerDecl: HasTrailingOptionalCodeBlock {}
extension FunctionDecl: HasTrailingOptionalCodeBlock {}
extension InitializerDecl: HasTrailingOptionalCodeBlock {}

// MARK: HasTrailingMemberDeclBlock

public protocol HasTrailingMemberDeclBlock {
  var members: MemberDeclBlock { get set }
}

public extension HasTrailingMemberDeclBlock where Self: SyntaxExpressibleByStringInterpolation {
  init(_ signature: String, @MemberDeclListBuilder membersBuilder: () -> MemberDeclListSyntax) {
    self = "\(raw: signature) {}"
    self.members = MemberDeclBlock(members: membersBuilder())
  }
}

extension ActorDecl: HasTrailingMemberDeclBlock {}
extension ClassDecl: HasTrailingMemberDeclBlock {}
extension EnumDecl: HasTrailingMemberDeclBlock {}
extension ExtensionDecl: HasTrailingMemberDeclBlock {}
extension ProtocolDecl: HasTrailingMemberDeclBlock {}
extension StructDecl: HasTrailingMemberDeclBlock {}
