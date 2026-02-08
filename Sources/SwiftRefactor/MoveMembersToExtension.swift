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
    public let declName: TokenSyntax
    public let selectedIdentifiers: [SyntaxIdentifier]

    public init(declName: TokenSyntax, selectedIdentifiers: [SyntaxIdentifier]) {
      self.declName = declName
      self.selectedIdentifiers = selectedIdentifiers
    }
  }

  public static func refactor(syntax: SourceFileSyntax, in context: Context) throws -> SourceFileSyntax {
    guard
      let decl = syntax.statements.first(where: {
        $0.item.asProtocol(NamedDeclSyntax.self)?.name == context.declName
      }),
      let declGroup = decl.item.asProtocol(DeclGroupSyntax.self),
      let index = syntax.statements.index(of: decl)
    else {
      throw RefactoringNotApplicableError("Type declaration not found")
    }

    let selectedMembers = declGroup.memberBlock.members.filter { context.selectedIdentifiers.contains($0.id) }

    for member in selectedMembers {
      try validateMember(member)
    }

    let remainingMembers = declGroup.memberBlock.members.filter { !context.selectedIdentifiers.contains($0.id) }

    let updatedMemberBlock = declGroup.memberBlock.with(\.members, remainingMembers)
    let updatedDeclGroup = declGroup.with(\.memberBlock, updatedMemberBlock)
    let updatedItem = decl.with(\.item, .decl(DeclSyntax(updatedDeclGroup)))

    let extensionMemberBlockSyntax = declGroup.memberBlock.with(\.members, selectedMembers)

    let extensionDecl = ExtensionDeclSyntax(
      leadingTrivia: .newlines(2),
      extendedType: IdentifierTypeSyntax(
        leadingTrivia: .space,
        name: context.declName
      ),
      memberBlock: extensionMemberBlockSyntax
    )

    var updatedStatements = syntax.statements
    updatedStatements.remove(at: index)
    updatedStatements.insert(updatedItem, at: index)
    updatedStatements.append(CodeBlockItemSyntax(item: .decl(DeclSyntax(extensionDecl))))

    return syntax.with(\.statements, updatedStatements)
  }

  private static func validateMember(_ member: MemberBlockItemSyntax) throws {
    if member.decl.is(AccessorDeclSyntax.self) || member.decl.is(DeinitializerDeclSyntax.self)
      || member.decl.is(EnumCaseDeclSyntax.self)
    {
      throw RefactoringNotApplicableError("Cannot move this type of declaration")
    }

    if let varDecl = member.decl.as(VariableDeclSyntax.self),
      varDecl.bindings.contains(where: { $0.initializer == nil })
    {
      throw RefactoringNotApplicableError("Cannot move stored properties to extension")
    }
  }
}
