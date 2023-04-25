# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

add_swift_host_library(SwiftSyntax
  AbsolutePosition.swift
  Assert.swift
  BumpPtrAllocator.swift
  CommonAncestor.swift
  IncrementalParseTransition.swift
  MemoryLayout.swift
  MissingNodeInitializers.swift
  Trivia.swift
  SourceLength.swift
  SourceLocation.swift
  SourcePresence.swift
  SwiftSyntaxCompatibility.swift
  Syntax.swift
  SyntaxArena.swift
  SyntaxChildren.swift
  SyntaxData.swift
  SyntaxText.swift
  SyntaxTreeViewMode.swift
  TokenDiagnostic.swift
  TokenSyntax.swift
  Utils.swift

  Raw/RawSyntax.swift
  Raw/RawSyntaxLayoutView.swift
  Raw/RawSyntaxNodeProtocol.swift
  Raw/RawSyntaxTokenView.swift

  generated/raw/RawSyntaxNodes.swift
  generated/raw/RawSyntaxValidation.swift

  generated/ChildNameForKeyPath.swift
  generated/Keyword.swift
  generated/SyntaxAnyVisitor.swift
  generated/SyntaxBaseNodes.swift
  generated/SyntaxCollections.swift
  generated/SyntaxEnum.swift
  generated/SyntaxKind.swift
  generated/SyntaxRewriter.swift
  generated/SyntaxTraits.swift
  generated/SyntaxTransform.swift
  generated/SyntaxVisitor.swift
  generated/TokenKind.swift
  generated/Tokens.swift
  generated/TriviaPieces.swift

  generated/syntaxNodes/SyntaxDeclNodes.swift
  generated/syntaxNodes/SyntaxExprNodes.swift
  generated/syntaxNodes/SyntaxNodes.swift
  generated/syntaxNodes/SyntaxPatternNodes.swift
  generated/syntaxNodes/SyntaxStmtNodes.swift
  generated/syntaxNodes/SyntaxTypeNodes.swift
)
