# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

add_library(SwiftParser STATIC
  Attributes.swift
  Availability.swift
  CharacterInfo.swift
  Declarations.swift
  Directives.swift
  Expressions.swift
  Lexer.swift
  Lookahead.swift
  LoopProgressCondition.swift
  Modifiers.swift
  Names.swift
  Parser.swift
  Patterns.swift
  RawTokenKindSubset.swift
  Recovery.swift
  Statements.swift
  TokenConsumer.swift
  TokenPrecedence.swift
  TopLevel.swift
  TriviaParser.swift
  Types.swift

  Diagnostics/DiagnosticExtensions.swift
  Diagnostics/MissingNodesError.swift
  Diagnostics/ParserDiagnosticMessages.swift
  Diagnostics/ParseDiagnosticsGenerator.swift
  Diagnostics/PresenceUtils.swift
  Diagnostics/SyntaxExtensions.swift
  Diagnostics/Utils.swift

  gyb_generated/DeclarationAttribute.swift
  gyb_generated/DeclarationModifier.swift
  gyb_generated/TypeAttribute.swift)

target_link_libraries(SwiftParser PUBLIC
  SwiftBasicFormat
  SwiftSyntax
  SwiftDiagnostics)

set_property(GLOBAL APPEND PROPERTY SWIFTSYNTAX_EXPORTS SwiftParser)

# NOTE: workaround for CMake not setting up include flags yet
set_target_properties(SwiftParser PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES
  "${CMAKE_Swift_MODULE_DIRECTORY} ${CMAKE_CURRENT_SOURCE_DIR}")

install(TARGETS SwiftParser
  EXPORT SwiftSyntaxTargets
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin)
