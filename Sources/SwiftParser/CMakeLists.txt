# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

add_swift_host_library(SwiftParser
  Attributes.swift
  Availability.swift
  CharacterInfo.swift
  CollectionNodes+Parsable.swift
  Declarations.swift
  Directives.swift
  ExperimentalFeatures.swift
  Expressions.swift
  IncrementalParseTransition.swift
  Lookahead.swift
  LoopProgressCondition.swift
  Modifiers.swift
  Names.swift
  Nominals.swift
  Parameters.swift
  Parser.swift
  ParseSourceFile.swift
  Patterns.swift
  TokenSpec.swift
  TokenSpecSet.swift
  Recovery.swift
  Specifiers.swift
  Statements.swift
  StringLiterals.swift
  StringLiteralRepresentedLiteralValue.swift
  SyntaxUtils.swift
  TokenConsumer.swift
  TokenPrecedence.swift
  TopLevel.swift
  TriviaParser.swift
  Types.swift

  generated/IsLexerClassified.swift
  generated/LayoutNodes+Parsable.swift
  generated/Parser+TokenSpecSet.swift
  generated/TokenSpecStaticMembers.swift

  Lexer/Cursor.swift
  Lexer/Lexeme.swift
  Lexer/LexemeSequence.swift
  Lexer/Lexer.swift
  Lexer/RegexLiteralLexer.swift
  Lexer/UnicodeScalarExtensions.swift
)

target_link_libraries(SwiftParser PUBLIC
  SwiftSyntax
  SwiftDiagnostics)
