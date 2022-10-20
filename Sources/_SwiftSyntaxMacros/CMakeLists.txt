# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

add_library(_SwiftSyntaxMacros STATIC
  ExpressionMacro.swift
  Macro.swift
  MacroEvaluationContext.swift
  MacroResult.swift
  MacroSystem+Builtin.swift
  MacroSystem+Examples.swift
  MacroSystem.swift
  Syntax+MacroEvaluation.swift
)

target_link_libraries(_SwiftSyntaxMacros PUBLIC
  SwiftParser
  SwiftSyntaxBuilder
  )

set_property(GLOBAL APPEND PROPERTY SWIFTSYNTAX_EXPORTS _SwiftSyntaxMacros)

# NOTE: workaround for CMake not setting up include flags yet
set_target_properties(_SwiftSyntaxMacros PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES
  "${CMAKE_Swift_MODULE_DIRECTORY} ${CMAKE_CURRENT_SOURCE_DIR}")

install(TARGETS _SwiftSyntaxMacros
  EXPORT SwiftSyntaxTargets
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin)
