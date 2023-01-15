# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

add_swift_host_library(SwiftSyntax
  AbsolutePosition.swift
  BumpPtrAllocator.swift
  CommonAncestor.swift
  IncrementalParseTransition.swift
  LexerError.swift
  SourceLength.swift
  SourceLocation.swift
  SourcePresence.swift
  Syntax.swift
  SyntaxArena.swift
  SyntaxChildren.swift
  SyntaxData.swift
  SyntaxOtherNodes.swift
  SyntaxText.swift
  SyntaxTreeViewMode.swift
  Utils.swift

  Raw/RawSyntax.swift
  Raw/RawSyntaxLayoutView.swift
  Raw/RawSyntaxNodeProtocol.swift
  Raw/RawSyntaxTokenView.swift

  Raw/gyb_generated/RawSyntaxNodes.swift
  Raw/gyb_generated/RawSyntaxValidation.swift

  generated/Keyword.swift
  generated/Misc.swift
  generated/SyntaxAnyVisitor.swift
  generated/SyntaxBaseNodes.swift
  generated/SyntaxCollections.swift
  generated/SyntaxEnum.swift
  gyb_generated/SyntaxFactory.swift
  generated/SyntaxKind.swift
  generated/SyntaxRewriter.swift
  generated/SyntaxTraits.swift
  generated/SyntaxTransform.swift
  generated/SyntaxVisitor.swift
  generated/TokenKind.swift
  generated/Tokens.swift
  gyb_generated/Trivia.swift

  gyb_generated/syntax_nodes/SyntaxDeclNodes.swift
  gyb_generated/syntax_nodes/SyntaxExprNodes.swift
  gyb_generated/syntax_nodes/SyntaxNodes.swift
  gyb_generated/syntax_nodes/SyntaxPatternNodes.swift
  gyb_generated/syntax_nodes/SyntaxStmtNodes.swift
  gyb_generated/syntax_nodes/SyntaxTypeNodes.swift
)
