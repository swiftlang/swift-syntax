# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

add_swift_syntax_library(SwiftSyntax
  AbsolutePosition.swift
  AbsoluteRawSyntax.swift
  AbsoluteSyntaxInfo.swift
  Assert.swift
  BumpPtrAllocator.swift
  CommonAncestor.swift
  Convenience.swift
  CustomTraits.swift
  MemoryLayout.swift
  MissingNodeInitializers.swift
  SourceEdit.swift
  SourceLength.swift
  SourceLocation.swift
  SourcePresence.swift
  SwiftSyntaxCompatibility.swift
  Syntax.swift
  SyntaxArena.swift
  SyntaxArenaAllocatedBuffer.swift
  SyntaxChildren.swift
  SyntaxCollection.swift
  SyntaxHashable.swift
  SyntaxIdentifier.swift
  SyntaxNodeStructure.swift
  SyntaxProtocol.swift
  SyntaxText.swift
  SyntaxTreeViewMode.swift
  TokenDiagnostic.swift
  TokenSequence.swift
  TokenSyntax.swift
  Trivia.swift
  Utils.swift

  Raw/RawSyntax.swift
  Raw/RawSyntaxLayoutView.swift
  Raw/RawSyntaxNodeProtocol.swift
  Raw/RawSyntaxTokenView.swift

  generated/raw/RawSyntaxNodesAB.swift
  generated/raw/RawSyntaxNodesC.swift
  generated/raw/RawSyntaxNodesD.swift
  generated/raw/RawSyntaxNodesEF.swift
  generated/raw/RawSyntaxNodesGHI.swift
  generated/raw/RawSyntaxNodesJKLMN.swift
  generated/raw/RawSyntaxNodesOP.swift
  generated/raw/RawSyntaxNodesQRS.swift
  generated/raw/RawSyntaxNodesTUVWXYZ.swift
  generated/raw/RawSyntaxValidation.swift

  generated/ChildNameForKeyPath.swift
  generated/Keyword.swift
  generated/RenamedChildrenCompatibility.swift
  generated/RenamedNodesCompatibility.swift
  generated/SyntaxAnyVisitor.swift
  generated/SyntaxBaseNodes.swift
  generated/SyntaxCollections.swift
  generated/SyntaxEnum.swift
  generated/SyntaxKind.swift
  generated/SyntaxRewriter.swift
  generated/SyntaxTraits.swift
  generated/SyntaxVisitor.swift
  generated/TokenKind.swift
  generated/Tokens.swift
  generated/TriviaPieces.swift

  generated/syntaxNodes/SyntaxNodesAB.swift
  generated/syntaxNodes/SyntaxNodesC.swift
  generated/syntaxNodes/SyntaxNodesD.swift
  generated/syntaxNodes/SyntaxNodesEF.swift
  generated/syntaxNodes/SyntaxNodesGHI.swift
  generated/syntaxNodes/SyntaxNodesJKLMN.swift
  generated/syntaxNodes/SyntaxNodesOP.swift
  generated/syntaxNodes/SyntaxNodesQRS.swift
  generated/syntaxNodes/SyntaxNodesTUVWXYZ.swift
)
