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

  public init(stringInterpolationOrThrow stringInterpolation: SyntaxStringInterpolation) throws {
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
}

public extension HasTrailingCodeBlock where Self: SyntaxExpressibleByStringInterpolation {
  init(_ signature: PartialSyntaxNodeString, @CodeBlockItemListBuilder bodyBuilder: () -> CodeBlockItemListSyntax) {
    self = "\(signature) {}"
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
  init(_ signature: PartialSyntaxNodeString, @CodeBlockItemListBuilder bodyBuilder: () -> CodeBlockItemListSyntax) {
    self = "\(signature) {}"
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
  init(_ signature: PartialSyntaxNodeString, @MemberDeclListBuilder membersBuilder: () -> MemberDeclListSyntax) {
    self = "\(signature) {}"
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
  init(_ signature: PartialSyntaxNodeString, @CodeBlockItemListBuilder bodyBuilder: () -> CodeBlockItemListSyntax, @CodeBlockItemListBuilder `else` elseBuilder: () -> CodeBlockItemListSyntax? = { nil }) {
    self = "\(signature) {}"
    self.body = CodeBlockSyntax(statements: bodyBuilder())
    self.elseBody = elseBuilder().map { .codeBlock(CodeBlockSyntax(statements: $0)) }
    self.elseKeyword = elseBody != nil ? .keyword(.else) : nil
  }

  init(_ signature: String, @CodeBlockItemListBuilder bodyBuilder: () -> CodeBlockItemListSyntax, elseIf: IfStmtSyntax) {
    self = "\(signature) {}"
    self.body = CodeBlockSyntax(statements: bodyBuilder())
    self.elseBody = .ifStmt(elseIf)
    self.elseKeyword = elseBody != nil ? .keyword(.else) : nil
  }
}
