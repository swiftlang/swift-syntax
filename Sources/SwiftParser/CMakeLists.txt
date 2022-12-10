# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

add_swift_host_library(SwiftParser
  Attributes.swift
  Availability.swift
  CharacterInfo.swift
  Declarations.swift
  Directives.swift
  Expressions.swift
  Lexer.swift
  LexerDiagnosticMessages.swift
  Lookahead.swift
  LoopProgressCondition.swift
  Modifiers.swift
  Names.swift
  Nominals.swift
  Parser.swift
  Patterns.swift
  RawTokenKindSubset.swift
  Recovery.swift
  Statements.swift
  SyntaxUtils.swift
  TokenConsumer.swift
  TokenPrecedence.swift
  TopLevel.swift
  TriviaParser.swift
  Types.swift

  generated/DeclarationAttribute.swift
  generated/DeclarationModifier.swift
  generated/Parser+Entry.swift
  generated/TypeAttribute.swift)

target_link_libraries(SwiftParser PUBLIC
  SwiftSyntax
  SwiftDiagnostics)
