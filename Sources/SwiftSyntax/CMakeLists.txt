# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

add_library(SwiftSyntax STATIC
  AbsolutePosition.swift
  BumpPtrAllocator.swift
  IncrementalParseTransition.swift
  PlatformMutex.swift
  SourceLength.swift
  SourceLocation.swift
  SourcePresence.swift
  Syntax.swift
  SyntaxArena.swift
  SyntaxChildren.swift
  SyntaxClassifier.swift
  SyntaxData.swift
  SyntaxOtherNodes.swift
  SyntaxText.swift
  SyntaxTreeViewMode.swift
  SyntaxVerifier.swift
  Utils.swift

  Raw/RawSyntax.swift
  Raw/RawSyntaxLayoutView.swift
  Raw/RawSyntaxNodeProtocol.swift
  Raw/RawSyntaxTokenView.swift

  Raw/gyb_generated/RawSyntaxNodes.swift
  Raw/gyb_generated/RawSyntaxValidation.swift

  gyb_generated/Misc.swift
  gyb_generated/SyntaxAnyVisitor.swift
  gyb_generated/SyntaxBaseNodes.swift
  gyb_generated/SyntaxClassification.swift
  gyb_generated/SyntaxCollections.swift
  gyb_generated/SyntaxEnum.swift
  gyb_generated/SyntaxFactory.swift
  gyb_generated/SyntaxKind.swift
  gyb_generated/SyntaxRewriter.swift
  gyb_generated/SyntaxTraits.swift
  gyb_generated/SyntaxTransform.swift
  gyb_generated/SyntaxVisitor.swift
  gyb_generated/TokenKind.swift
  gyb_generated/Tokens.swift
  gyb_generated/Trivia.swift

  gyb_generated/syntax_nodes/SyntaxDeclNodes.swift
  gyb_generated/syntax_nodes/SyntaxExprNodes.swift
  gyb_generated/syntax_nodes/SyntaxNodes.swift
  gyb_generated/syntax_nodes/SyntaxPatternNodes.swift
  gyb_generated/syntax_nodes/SyntaxStmtNodes.swift
  gyb_generated/syntax_nodes/SyntaxTypeNodes.swift
)

set_property(GLOBAL APPEND PROPERTY SWIFTSYNTAX_EXPORTS SwiftSyntax)

# NOTE: workaround for CMake not setting up include flags yet
set_target_properties(SwiftSyntax PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})

install(TARGETS SwiftSyntax
  EXPORT SwiftSyntaxTargets
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin)
