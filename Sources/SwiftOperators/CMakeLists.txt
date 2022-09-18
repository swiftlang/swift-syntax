# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

add_library(SwiftOperators STATIC
  Operator.swift
  OperatorError+Diagnostics.swift
  OperatorError.swift
  OperatorTable+Defaults.swift
  OperatorTable+Folding.swift
  OperatorTable+Semantics.swift
  OperatorTable.swift
  PrecedenceGraph.swift
  PrecedenceGroup.swift
  SyntaxSynthesis.swift
)

target_link_libraries(SwiftOperators PUBLIC
  SwiftSyntax
  SwiftDiagnostics
  SwiftParser)

set_property(GLOBAL APPEND PROPERTY SWIFTSYNTAX_EXPORTS SwiftOperators)

# NOTE: workaround for CMake not setting up include flags yet
set_target_properties(SwiftOperators PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES
  "${CMAKE_Swift_MODULE_DIRECTORY} ${CMAKE_CURRENT_SOURCE_DIR}")

install(TARGETS SwiftOperators
  EXPORT SwiftSyntaxTargets
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin)
