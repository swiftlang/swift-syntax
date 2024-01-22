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
  MemoryLayout.swift
  MissingNodeInitializers.swift
  SourceEdit.swift
  SourceLength.swift
  SourceLocation.swift
  SourcePresence.swift
  SwiftSyntaxCompatibility.swift
  Syntax.swift
  SyntaxArena.swift
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

  Lexer/Cursor.swift
  Lexer/Lexeme.swift
  Lexer/LexemeSequence.swift
  Lexer/Lexer.swift
  Lexer/RegexLiteralLexer.swift
  Lexer/UnicodeScalarExtensions.swift

  Parser/Attributes.swift
  Parser/Availability.swift
  Parser/CharacterInfo.swift
  Parser/CollectionNodes+Parsable.swift
  Parser/Declarations.swift
  Parser/Directives.swift
  Parser/Expressions.swift
  Parser/IncrementalParseTransition.swift
  Parser/Lookahead.swift
  Parser/LoopProgressCondition.swift
  Parser/Modifiers.swift
  Parser/Names.swift
  Parser/Nominals.swift
  Parser/Parameters.swift
  Parser/Parser.swift
  Parser/ParseSourceFile.swift
  Parser/Patterns.swift
  Parser/TokenSpec.swift
  Parser/TokenSpecSet.swift
  Parser/Recovery.swift
  Parser/Specifiers.swift
  Parser/Statements.swift
  Parser/StringLiterals.swift
  Parser/StringLiteralRepresentedLiteralValue.swift
  Parser/SyntaxUtils.swift
  Parser/TokenConsumer.swift
  Parser/TokenPrecedence.swift
  Parser/TopLevel.swift
  Parser/TriviaParser.swift
  Parser/Types.swift

  Raw/RawSyntax.swift
  Raw/RawSyntaxLayoutView.swift
  Raw/RawSyntaxNodeProtocol.swift
  Raw/RawSyntaxTokenView.swift

  generated/Parser/ExperimentalFeatures.swift
  generated/Parser/IsLexerClassified.swift
  generated/Parser/LayoutNodes+Parsable.swift
  generated/Parser/Parser+TokenSpecSet.swift
  generated/Parser/TokenSpecStaticMembers.swift

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
