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
    set(module_file "${module_base}/${SWIFT_HOST_MODULE_TRIPLE}.swiftmodule")
    set(module_interface_file "${module_base}/${SWIFT_HOST_MODULE_TRIPLE}.swiftinterface")
    set(module_private_interface_file "${module_base}/${SWIFT_HOST_MODULE_TRIPLE}.private.swiftinterface")

    # Make sure the module directory exists before any build step writes
    # the .swiftinterface files into it.
    file(MAKE_DIRECTORY ${module_base})

    # With CMP0157 NEW, CMake appends its own -emit-module-path after our
    # compile options and it wins, so the explicit path below is only
    # effective when CMake's own path agrees with it. The top-level
    # CMakeLists sets CMP0195 NEW in that case (CMake 4+), which makes
    # CMake's path module_base/<triple>.swiftmodule, identical to the
    # explicit path. Where CMP0195 is not NEW (CMake 3.29-3.x, where the
    # policy does not exist, or an explicit OLD setting), point CMake's
    # module output into the module directory instead so
    # the build still succeeds; the binary is then <name>.swiftmodule
    # rather than triple-named. With CMP0157 OLD, CMake appends no
    # -emit-module-path at all, so the explicit path is used as-is.
    cmake_policy(GET CMP0157 _swift_syntax_cmp0157)
    set(_swift_syntax_cmp0195 "")
    if(POLICY CMP0195)
      cmake_policy(GET CMP0195 _swift_syntax_cmp0195)
    endif()
    if(_swift_syntax_cmp0157 STREQUAL "NEW" AND NOT _swift_syntax_cmp0195 STREQUAL "NEW")
      set(swift_module_directory ${module_base})
    else()
      set(swift_module_directory ${module_dir})
      target_compile_options("${target}" PRIVATE
        $<$<COMPILE_LANGUAGE:Swift>:
          -emit-module-path;${module_file}
      >)
    endif()

    # Configure the emission of the Swift module interface files.
    target_compile_options("${target}" PRIVATE
      $<$<COMPILE_LANGUAGE:Swift>:
        -DRESILIENT_LIBRARIES;
        -enable-library-evolution;
        -emit-module-interface-path;${module_interface_file};
        -emit-private-module-interface-path;${module_private_interface_file}
    >)

    # Enable package CMO if possible.
    if(Swift_COMPILER_PACKAGE_CMO_SUPPORT STREQUAL "IMPLEMENTED")
      target_compile_options("${target}" PRIVATE
        $<$<COMPILE_LANGUAGE:Swift>:
          "SHELL:-Xfrontend -package-cmo"
          "SHELL:-Xfrontend -allow-non-resilient-access"
      >)
    elseif(Swift_COMPILER_PACKAGE_CMO_SUPPORT STREQUAL "EXPERIMENTAL")
      target_compile_options("${target}" PRIVATE
        $<$<COMPILE_LANGUAGE:Swift>:
          "SHELL:-Xfrontend -experimental-package-cmo"
          "SHELL:-Xfrontend -experimental-allow-non-resilient-access"
          "SHELL:-Xfrontend -experimental-package-bypass-resilience"
      >)
    endif()

  else()
    set(module_dir ${CMAKE_CURRENT_BINARY_DIR})
    set(module_base "${module_dir}/${name}.swiftmodule")
    set(swift_module_directory ${module_dir})
  endif()

  set_target_properties(${target} PROPERTIES
    Swift_MODULE_NAME ${name}
    Swift_MODULE_DIRECTORY ${swift_module_directory}
    INTERFACE_INCLUDE_DIRECTORIES ${module_dir}
  )

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
