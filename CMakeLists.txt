# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

cmake_minimum_required(VERSION 3.19.6)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules)

project(SwiftSyntax LANGUAGES C Swift)

set(SWIFT_VERSION 5)
set(CMAKE_Swift_LANGUAGE_VERSION ${SWIFT_VERSION})

if(CMAKE_VERSION VERSION_LESS 3.21)
  get_property(parent_dir DIRECTORY PROPERTY PARENT_DIRECTORY)
  if(NOT parent_dir)
    set(PROJECT_IS_TOP_LEVEL TRUE)
  endif()
endif()

# The subdirectory into which host libraries will be installed.
set(SWIFT_HOST_LIBRARIES_SUBDIRECTORY "swift/host")

if(NOT CMAKE_ARCHIVE_OUTPUT_DIRECTORY)
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib/${SWIFT_HOST_LIBRARIES_SUBDIRECTORY}")
endif()
if(NOT CMAKE_LIBRARY_OUTPUT_DIRECTORY)
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib/${SWIFT_HOST_LIBRARIES_SUBDIRECTORY}")
endif()
if(NOT CMAKE_RUNTIME_OUTPUT_DIRECTORY)
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
endif()

set(CMAKE_MACOSX_RPATH YES)

option(SWIFT_SYNTAX_ENABLE_WMO_PRE_3_26
       "Enable Whole Module Optimization (WMO) - requires swift-driver"
       $<IF:$<AND:$<NOT:$<CONFIG:Debug>>,$<PLATFORM_ID:Darwin>>,YES,NO>)

include(AddSwiftHostLibrary)
include(SwiftCompilerCapability)

# Don't link with 'string-processing' and 'backtracing'.
swift_supports_implicit_module("string-processing" SWIFT_SUPPORTS_DISABLE_IMPLICIT_STRING_PROCESSING_MODULE_IMPORT)
swift_supports_implicit_module("backtracing" SWIFT_SUPPORTS_DISABLE_IMPLICIT_BACKTRACING_MODULE_IMPORT)
if(SWIFT_SUPPORTS_DISABLE_IMPLICIT_STRING_PROCESSING_MODULE_IMPORT)
  add_compile_options("$<$<COMPILE_LANGUAGE:Swift>:SHELL:-Xfrontend -disable-implicit-string-processing-module-import>")
endif()
if(SWIFT_SUPPORTS_DISABLE_IMPLICIT_BACKTRACING_MODULE_IMPORT)
  add_compile_options("$<$<COMPILE_LANGUAGE:Swift>:SHELL:-Xfrontend -disable-implicit-backtracing-module-import>")
endif()

# SWIFTSYNTAX_EMIT_MODULE is TRUE by default
if(NOT DEFINED SWIFTSYNTAX_EMIT_MODULE)
  set(SWIFTSYNTAX_EMIT_MODULE TRUE)
endif()
if(SWIFTSYNTAX_EMIT_MODULE)
  swift_get_package_cmo_support(SWIFT_PACKAGE_CMO_SUPPORT)
endif()

# Determine the module triple.
if("${SWIFT_HOST_MODULE_TRIPLE}" STREQUAL "")
  set(module_triple_command "${CMAKE_Swift_COMPILER}" -print-target-info)
  if(CMAKE_Swift_COMPILER_TARGET)
    list(APPEND module_triple_command -target ${CMAKE_Swift_COMPILER_TARGET})
  endif()
  execute_process(COMMAND ${module_triple_command} OUTPUT_VARIABLE target_info_json)
  string(JSON SWIFT_HOST_MODULE_TRIPLE GET "${target_info_json}" "target" "moduleTriple")
endif()
message(STATUS "Module triple: ${SWIFT_HOST_MODULE_TRIPLE}")

if (SWIFTSYNTAX_ENABLE_ASSERTIONS)
  add_compile_definitions(
    $<$<COMPILE_LANGUAGE:Swift>:SWIFTSYNTAX_ENABLE_ASSERTIONS>
  )
endif()

add_compile_definitions(
  $<$<COMPILE_LANGUAGE:Swift>:SWIFT_SYNTAX_BUILD_USING_CMAKE>
)

add_subdirectory(Sources)
add_subdirectory(cmake/modules)
