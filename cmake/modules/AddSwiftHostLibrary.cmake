# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
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

  # Touch the library and objects to workaround their mtime not being updated
  # when there are no real changes (eg. a file was updated with a comment).
  # Ideally this should be done in the driver, which could only update the
  # files that have changed.
  add_custom_command(
      TARGET ${name}
      POST_BUILD
      COMMAND "${CMAKE_COMMAND}" -E touch_nocreate $<TARGET_FILE:${name}> $<TARGET_OBJECTS:${name}>
      COMMAND_EXPAND_LISTS
      COMMENT "Update mtime of library outputs workaround")

  # Install the Swift module into the appropriate location.
  set_target_properties(${name}
    PROPERTIES Swift_MODULE_DIRECTORY ${module_dir}
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

  if(CMAKE_VERSION VERSION_LESS 3.26.0 AND SWIFT_SYNTAX_ENABLE_WMO_PRE_3_26)
    target_compile_options(${name} PRIVATE
        $<$<COMPILE_LANGUAGE:Swift>:-wmo>)
  endif()

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
