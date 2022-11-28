# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

# Add a new host library with the given name.
function(add_swift_host_library name)
  set(ASHL_SOURCES ${ARGN})

  add_library(${name} ${ASHL_SOURCES})

  # Add this to the list of exported targets.
  set_property(GLOBAL APPEND PROPERTY SWIFTSYNTAX_EXPORTS ${name})

  # NOTE: workaround for CMake not setting up include flags yet
  set_target_properties(${name} PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})

  # Install this target
  install(TARGETS ${name}
    EXPORT SwiftSyntaxTargets
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
  )
endfunction()