//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2019 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

// MARK: - Protocols

public protocol DeclListBuildable: SyntaxListBuildable {
  func buildDeclList(format: Format, leadingTrivia: Trivia) -> [DeclSyntax]
}

public protocol DeclBuildable: SyntaxBuildable, DeclListBuildable {
  func buildDecl(format: Format, leadingTrivia: Trivia) -> DeclSyntax
}

extension DeclBuildable {
  public func buildSyntax(format: Format, leadingTrivia: Trivia) -> Syntax {
    Syntax(buildDecl(format: format, leadingTrivia: leadingTrivia))
  }

  public func buildDeclList(format: Format, leadingTrivia: Trivia) -> [DeclSyntax] {
    [buildDecl(format: format, leadingTrivia: leadingTrivia)]
  }
}

// MARK: - Function Builder

@_functionBuilder
public struct DeclListBuilder {
  public static func buildBlock(_ builders: DeclListBuildable...) -> DeclListBuildable {
    DeclList(builders: builders)
  }
}

// MARK: - List

public struct DeclList: DeclListBuildable {
  let builders: [DeclListBuildable]

  public func buildDeclList(format: Format, leadingTrivia: Trivia) -> [DeclSyntax] {
    builders.flatMap { $0.buildDeclList(format: format, leadingTrivia: leadingTrivia) }
  }

  public func buildSyntaxList(format: Format, leadingTrivia: Trivia) -> [Syntax] {
    buildDeclList(format: format, leadingTrivia: leadingTrivia).map { Syntax($0) }
  }
}

extension DeclList {
  public static let empty: DeclList = DeclList(builders: [])
}

// MARK: - Buildables

// MARK: Import

public struct Import: DeclBuildable {
  let moduleName: String

  public init(_ moduleName: String) {
    self.moduleName = moduleName
  }

  public func buildDecl(format: Format, leadingTrivia: Trivia) -> DeclSyntax {
    let importToken = Tokens.import.withLeadingTrivia(leadingTrivia)
    let moduleNameToken = SyntaxFactory.makeIdentifier(moduleName)

    let importDecl = ImportDeclSyntax {
      $0.useImportTok(importToken)
      $0.addPathComponent(AccessPathComponentSyntax {
        $0.useName(moduleNameToken)
      })
    }
    return DeclSyntax(importDecl)
  }
}

// MARK: Variables

public protocol VariableMutability {
  static var token: TokenSyntax { get }
}

public enum VariableLetMutability: VariableMutability {
  public static let token = Tokens.let
}

public enum VariableVarMutability: VariableMutability {
  public static let token = Tokens.var
}

public typealias Let = Variable<VariableLetMutability>
public typealias Var = Variable<VariableVarMutability>

public struct Variable<Mutability: VariableMutability>: DeclBuildable {
  let name: String
  let type: String
  let initializer: ExprBuildable?

  public init(_ name: String, of type: String, value: ExprBuildable? = nil) {
    self.name = name
    self.type = type
    self.initializer = value
  }

  public func buildDecl(format: Format, leadingTrivia: Trivia) -> DeclSyntax {
    let mutabilityKeyword = Mutability.token.withLeadingTrivia(leadingTrivia)

    let nameIdentifier = SyntaxFactory.makeIdentifier(name)
    let namePattern = SyntaxFactory.makeIdentifierPattern(identifier: nameIdentifier)

    let typeIdentifier = SyntaxFactory.makeTypeIdentifier(type)
    let typeAnnotation = SyntaxFactory.makeTypeAnnotation(
      colon: Tokens.colon,
      type: typeIdentifier
    )

    let initClause = initializer.flatMap { builder -> InitializerClauseSyntax in
      let expr = builder.buildExpr(format: format, leadingTrivia: .zero)
      return SyntaxFactory.makeInitializerClause(equal: Tokens.equal, value: expr)
    }

    let variableDecl = VariableDeclSyntax {
      $0.useLetOrVarKeyword(mutabilityKeyword)
      $0.addBinding(PatternBindingSyntax {
        $0.usePattern(PatternSyntax(namePattern))
        $0.useTypeAnnotation(typeAnnotation)

        if let initClause = initClause {
          $0.useInitializer(initClause)
        }
      })
    }
    return DeclSyntax(variableDecl)
  }
}

// MARK: Struct

public struct Struct: DeclBuildable {
  let name: String
  let memberList: DeclListBuildable

  public init(
    _ name: String,
    @DeclListBuilder buildMemberList: () -> DeclListBuildable = { DeclList.empty }
  ) {
    self.name = name
    self.memberList = buildMemberList()
  }

  public func buildDecl(format: Format, leadingTrivia: Trivia) -> DeclSyntax {
    let structKeyword = Tokens.struct.withLeadingTrivia(leadingTrivia)

    let declList = memberList.buildDeclList(
      format: format._indented(),
      leadingTrivia: .zero
    )

    let structDecl = StructDeclSyntax {
      $0.useStructKeyword(structKeyword)
      $0.useIdentifier(SyntaxFactory.makeIdentifier(name))
      $0.useMembers(MemberDeclBlockSyntax {
        $0.useLeftBrace(Tokens.leftBrace.withLeadingTrivia(.spaces(1)))
        $0.useRightBrace(Tokens.rightBrace.withLeadingTrivia(.newlines(1) + format._makeIndent()))

        let format = format._indented()
        for decl in declList {
          let member = SyntaxFactory
            .makeMemberDeclListItem(decl: decl, semicolon: nil)
            .withLeadingTrivia(.newlines(1) + format._makeIndent())
          $0.addMember(member)
        }
      })
    }
    return DeclSyntax(structDecl)
  }
}

// MARK: - Extension

public struct Extension: DeclBuildable {
  let name: String
  let memberList: DeclListBuildable

  public init(
    _ name: String,
    @DeclListBuilder buildMemberList: () -> DeclListBuildable = { DeclList.empty }
  ) {
    self.name = name
    self.memberList = buildMemberList()
  }

  public func buildDecl(format: Format, leadingTrivia: Trivia) -> DeclSyntax {
    let extensionKeyword = SyntaxFactory.makeExtensionKeyword().withTrailingTrivia(.spaces(1))

    let declList = memberList.buildDeclList(
      format: format._indented(),
      leadingTrivia: .zero
    )

    let extensionDecl = ExtensionDeclSyntax {
      $0.useExtensionKeyword(extensionKeyword)
      $0.useExtendedType(SyntaxFactory.makeTypeIdentifier(name))
      $0.useMembers(MemberDeclBlockSyntax {
        $0.useLeftBrace(SyntaxFactory.makeLeftBraceToken().withLeadingTrivia(.spaces(1)))
        $0.useRightBrace(SyntaxFactory.makeRightBraceToken().withLeadingTrivia(.newlines(1) + format._makeIndent()))

        let format = format._indented()
        for decl in declList {
          let member = SyntaxFactory
            .makeMemberDeclListItem(decl: decl, semicolon: nil)
            .withLeadingTrivia(.newlines(1) + format._makeIndent())
          $0.addMember(member)
        }
      })
    }
    return DeclSyntax(extensionDecl)
  }
}
