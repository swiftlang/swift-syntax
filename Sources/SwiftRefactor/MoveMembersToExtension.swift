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

#if compiler(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

public struct MoveMembersToExtension: SyntaxRefactoringProvider {
  public struct Context {
    public let range: Range<AbsolutePosition>

    public init(range: Range<AbsolutePosition>) {
      self.range = range
    }
  }

  public static func refactor(syntax: SourceFileSyntax, in context: Context) throws -> SourceFileSyntax {
    guard
      let statement = syntax.statements.first(where: { $0.item.range.contains(context.range) }),
      let decl = statement.item.asProtocol(NamedDeclSyntax.self),
      let declGroup = statement.item.asProtocol(DeclGroupSyntax.self),
      let statementIndex = syntax.statements.index(of: statement)
    else {
      throw RefactoringNotApplicableError("Type declaration not found")
    }

    var selectedMembers = [MemberBlockItemSyntax]()
    var selectedIdentifiers = [SyntaxIdentifier]()

    var notMovedMembers: [MemberBlockItemSyntax] = []

    declGroup.memberBlock.members.forEach {
      if context.range.overlaps($0.trimmedRange) {
        if validateMember($0) {
          selectedMembers.append($0)
          selectedIdentifiers.append($0.id)
        } else {
          notMovedMembers.append($0)
        }
      }
    }

    guard !selectedMembers.isEmpty else {
      throw RefactoringNotApplicableError("No members to move")
    }

    var updatedDeclGroup = declGroup
    updatedDeclGroup.memberBlock.members = declGroup.memberBlock.members.filter { !selectedIdentifiers.contains($0.id) }
    let updatedItem = statement.with(\.item, .decl(DeclSyntax(updatedDeclGroup)))

    let extensionMemberBlockSyntax = declGroup.memberBlock.with(\.members, MemberBlockItemListSyntax(selectedMembers))

    var declName = decl.name
    declName.trailingTrivia = declName.trailingTrivia.merging(.space)

    let extensionDecl = ExtensionDeclSyntax(
      leadingTrivia: .newlines(2),
      extendedType: IdentifierTypeSyntax(
        leadingTrivia: .space,
        name: declName
      ),
      memberBlock: extensionMemberBlockSyntax
    )

    var syntax = syntax
    syntax.statements[statementIndex] = updatedItem
    syntax.statements.insert(
      CodeBlockItemSyntax(item: .decl(DeclSyntax(extensionDecl))),
      at: syntax.statements.index(after: statementIndex)
    )
    return syntax
  }

  private static func validateMember(_ member: MemberBlockItemSyntax) -> Bool {

    if member.decl.is(AccessorDeclSyntax.self) || member.decl.is(DeinitializerDeclSyntax.self)
      || member.decl.is(EnumCaseDeclSyntax.self)
    {
      return false
    }

    if let varDecl = member.decl.as(VariableDeclSyntax.self),
      varDecl.bindings.contains(where: { $0.accessorBlock == nil || $0.initializer != nil })
    {
      return false
    }

    return true
  }
}
