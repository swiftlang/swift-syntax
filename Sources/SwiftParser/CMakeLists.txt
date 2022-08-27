# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

add_library(SwiftParser STATIC
  Names.swift
  Lexer.swift
  Declarations.swift
  Directives.swift
  CharacterInfo.swift
  Attributes.swift
  Lookahead.swift
  Expressions.swift
  LoopProgressCondition.swift
  Statements.swift
  TokenPrecedence.swift
  Modifiers.swift
  Patterns.swift
  Availability.swift
  TriviaParser.swift
  TokenConsumer.swift
  Parser.swift
  Recovery.swift
  TopLevel.swift
  Types.swift

  Diagnostics/ParserDiagnosticMessages.swift
  Diagnostics/ParseDiagnosticsGenerator.swift)

target_link_libraries(SwiftParser PUBLIC
  SwiftSyntax
  SwiftDiagnostics)

set_property(GLOBAL APPEND PROPERTY SWIFTSYNTAX_EXPORTS SwiftParser)

# NOTE: workaround for CMake not setting up include flags yet
set_target_properties(SwiftParser PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})

install(TARGETS SwiftParser
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin)
