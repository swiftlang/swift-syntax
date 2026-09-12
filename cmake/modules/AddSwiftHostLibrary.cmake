##===----------------------------------------------------------------------===##
##
## This source file is part of the Swift.org open source project
##
## Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
## Licensed under Apache License v2.0 with Runtime Library Exception
##
## See https://swift.org/LICENSE.txt for license information
## See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
##
##===----------------------------------------------------------------------===##

function(target_link_swift_syntax_libraries TARGET)
  cmake_parse_arguments(ARGS "PUBLIC;PRIVATE;INTERFACE" "" "" ${ARGN})
  set(link_type)
  if(ARGS_PUBLIC)
    set(link_type PUBLIC)
  elseif(ARGS_PRIVATE)
    set(link_type PRIVATE)
  elseif(ARGS_INTERFACE)
    set(link_type INTERFACE)
  endif()

  string(PREPEND TARGET ${SWIFTSYNTAX_TARGET_NAMESPACE})
  list(TRANSFORM ARGS_UNPARSED_ARGUMENTS PREPEND "${SWIFTSYNTAX_TARGET_NAMESPACE}" OUTPUT_VARIABLE dependencies)

  target_link_libraries(${TARGET} ${link_type} ${dependencies})
endfunction()

# Add a new host library with the given name.
function(add_swift_syntax_library name)
  set(ASHL_SOURCES ${ARGN})

  set(target ${SWIFTSYNTAX_TARGET_NAMESPACE}${name})

  # Create the library target.
  add_library(${target} ${ASHL_SOURCES})
  if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_link_libraries(${target} PUBLIC swiftSwiftOnoneSupport)
  endif()

  if(SWIFTSYNTAX_EMIT_MODULE)
    # Determine where Swift modules will be built and installed.
    set(module_dir ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(module_base "${module_dir}/${name}.swiftmodule")

    set_target_properties(${target} PROPERTIES
      Swift_MODULE_DIRECTORY ${module_dir}
      Swift_MODULE_NAME ${name}
    )

    if(POLICY CMP0195)
      # CMake 4.1 and later (CMP0195) generates the nested
      # `<name>.swiftmodule/<triple>.swiftmodule` directory layout
      # automatically. Emit the swift interfaces into that directory.
      target_compile_options(${target} PRIVATE
        $<$<COMPILE_LANGUAGE:Swift>:
          "SHELL:-emit-module-interface-path ${module_base}/${CMAKE_Swift_MODULE_TRIPLE}.swiftinterface"
          "SHELL:-emit-private-module-interface-path ${module_base}/${CMAKE_Swift_MODULE_TRIPLE}.private.swiftinterface">)
    else()
      # Older CMake versions emit the flat `<name>.swiftmodule` layout.
      # Explicitly override the output to form the nested directory structure.
      target_compile_options(${target} PRIVATE
        $<$<COMPILE_LANGUAGE:Swift>:
          "SHELL:-emit-module-path  ${module_base}/${SWIFT_HOST_MODULE_TRIPLE}.swiftmodule"
          "SHELL:-emit-module-interface-path  ${module_base}/${SWIFT_HOST_MODULE_TRIPLE}.swiftinterface"
          "SHELL:-emit-private-module-interface-path ${module_base}/${SWIFT_HOST_MODULE_TRIPLE}.private.swiftinterface">)
    endif()

    # Build a resilient library with a stable textual module interface.
    target_compile_definitions(${target} PRIVATE
      $<$<COMPILE_LANGUAGE:Swift>:RESILIENT_LIBRARIES>
    )

    # Enable package CMO if possible.
    if(Swift_COMPILER_PACKAGE_CMO_SUPPORT STREQUAL "IMPLEMENTED")
      target_compile_options("${target}" PRIVATE
        $<$<COMPILE_LANGUAGE:Swift>:-enable-library-evolution>
        $<$<COMPILE_LANGUAGE:Swift>:
          "SHELL:-Xfrontend -package-cmo"
          "SHELL:-Xfrontend -allow-non-resilient-access"
      >)
    elseif(Swift_COMPILER_PACKAGE_CMO_SUPPORT STREQUAL "EXPERIMENTAL")
      target_compile_options("${target}" PRIVATE
        $<$<COMPILE_LANGUAGE:Swift>:-enable-library-evolution>
        $<$<COMPILE_LANGUAGE:Swift>:
          "SHELL:-Xfrontend -experimental-package-cmo"
          "SHELL:-Xfrontend -experimental-allow-non-resilient-access"
          "SHELL:-Xfrontend -experimental-package-bypass-resilience"
      >)
    endif()

  else()
    set(module_dir ${CMAKE_CURRENT_BINARY_DIR})
    set(module_base "${module_dir}/${name}.swiftmodule")
  endif()

  target_compile_options("${target}" PRIVATE
    $<$<COMPILE_LANGUAGE:Swift>:
      "SHELL:-Xfrontend -module-abi-name -Xfrontend ${SWIFT_MODULE_ABI_NAME_PREFIX}${name}"
  >)

  target_compile_options(${target} PRIVATE
    $<$<COMPILE_LANGUAGE:Swift>:-color-diagnostics>
  )

  if(LLVM_USE_LINKER)
    target_link_options(${target} PRIVATE
      "-use-ld=${LLVM_USE_LINKER}"
    )
  endif()

  set_target_properties(${target} PROPERTIES
    BUILD_WITH_INSTALL_RPATH YES
  )

  if(SWIFT_HOST_LIBRARIES_RPATH)
    # Don't add builder's stdlib RPATH automatically.
    target_compile_options(${target} PRIVATE -no-toolchain-stdlib-rpath)
    set_property(TARGET ${target}
      PROPERTY INSTALL_RPATH "${SWIFT_HOST_LIBRARIES_RPATH}"
    )
  endif()

  get_target_property(lib_type ${target} TYPE)
  if(lib_type STREQUAL SHARED_LIBRARY)
    if (CMAKE_SYSTEM_NAME STREQUAL Darwin)
      # Allow install_name_tool to update paths (for rdar://109473564)
      set_property(TARGET ${target} APPEND_STRING PROPERTY
                   LINK_FLAGS " -Xlinker -headerpad_max_install_names")
    endif()
  endif()

  if(PROJECT_IS_TOP_LEVEL OR SWIFT_SYNTAX_INSTALL_TARGETS)
    # Install this target
    install(TARGETS ${target}
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
  else()
    set_property(GLOBAL APPEND PROPERTY SWIFT_EXPORTS ${target})
  endif()
  add_library(SwiftSyntax::${target} ALIAS ${target})
endfunction()
