# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

add_library(IDEUtils STATIC
  gyb_generated/SyntaxClassification.swift
  Syntax+Classifications.swift
  SyntaxClassifier.swift
)

target_link_libraries(IDEUtils PUBLIC
  SwiftSyntax)

set_property(GLOBAL APPEND PROPERTY SWIFTSYNTAX_EXPORTS IDEUtils)

# NOTE: workaround for CMake not setting up include flags yet
set_target_properties(IDEUtils PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})

install(TARGETS IDEUtils
  EXPORT SwiftSyntaxTargets
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin)
