# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

add_library(SwiftBasicFormat STATIC
  generated/Format.swift
)

target_link_libraries(SwiftBasicFormat PUBLIC
  SwiftSyntax)

set_property(GLOBAL APPEND PROPERTY SWIFTSYNTAX_EXPORTS SwiftBasicFormat)

# NOTE: workaround for CMake not setting up include flags yet
set_target_properties(SwiftBasicFormat PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})

install(TARGETS SwiftBasicFormat
  EXPORT SwiftSyntaxTargets
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin)
