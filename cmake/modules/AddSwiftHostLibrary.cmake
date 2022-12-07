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

  # Create the library target.
  add_library(${name} ${ASHL_SOURCES})

  # Add this to the list of exported targets.
  set_property(GLOBAL APPEND PROPERTY SWIFTSYNTAX_EXPORTS ${name})

  # Determine where Swift modules will be built and installed.
  set(module_dir ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
  set(module_base "${module_dir}/${name}.swiftmodule")
  set(module_file "${module_base}/${SWIFT_MODULE_TRIPLE}.swiftmodule")
  set(module_interface_file "${module_base}/${SWIFT_MODULE_TRIPLE}.swiftinterface")
  set(module_sourceinfo_file "${module_base}/${SWIFT_MODULE_TRIPLE}.swiftsourceinfo")

  # Add a custom target to create the module directory.
  add_custom_command(
      TARGET ${name}
      PRE_BUILD
      COMMAND "${CMAKE_COMMAND}" -E make_directory ${module_base}
      COMMENT "Generating module directory for ${name}")

  # Install the Swift module into the appropriate location.
  set_target_properties(${name}
    PROPERTIES Swift_MODULE_DIRECTORY ${module_base}
  )

  # Configure the emission of the Swift module files.
  target_compile_options("${name}" PRIVATE
    $<$<COMPILE_LANGUAGE:Swift>:
      -module-name;${name};
      -enable-library-evolution;
      -emit-module-path;${module_file};
      -emit-module-source-info-path;${module_sourceinfo_file};
      -emit-module-interface-path;${module_interface_file}
      >)

  # NOTE: workaround for CMake not setting up include flags yet
  set_target_properties(${name} PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES ${module_dir}
  )

  set_target_properties(${name} PROPERTIES
    BUILD_WITH_INSTALL_RPATH YES
  )

  # Install this target
  install(TARGETS ${name}
    EXPORT SwiftSyntaxTargets
    ARCHIVE DESTINATION lib/${SWIFT_HOST_LIBRARIES_SUBDIRECTORY}
    LIBRARY DESTINATION lib/${SWIFT_HOST_LIBRARIES_SUBDIRECTORY}
    RUNTIME DESTINATION bin
  )

  # Install the module files.
  install(
    DIRECTORY ${module_base}
    DESTINATION lib/${SWIFT_HOST_LIBRARIES_SUBDIRECTORY}
    FILES_MATCHING PATTERN "*.swiftinterface"
  )
endfunction()
