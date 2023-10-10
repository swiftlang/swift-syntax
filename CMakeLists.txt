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

# Ensure that we do not link the _StringProcessing module. But we can
# only pass this flag for new-enough compilers that support it.
file(WRITE "${CMAKE_BINARY_DIR}/tmp/empty-check-string-processing.swift" "")
execute_process(
  COMMAND
    "${CMAKE_Swift_COMPILER}"
    -Xfrontend -disable-implicit-string-processing-module-import
    -Xfrontend -parse-stdlib
    -typecheck "${CMAKE_BINARY_DIR}/tmp/empty-check-string-processing.swift"
  OUTPUT_QUIET ERROR_QUIET
  RESULT_VARIABLE
    SWIFT_SUPPORTS_DISABLE_IMPLICIT_STRING_PROCESSING_MODULE_IMPORT)
if (NOT SWIFT_SUPPORTS_DISABLE_IMPLICIT_STRING_PROCESSING_MODULE_IMPORT)
  add_compile_options(
    $<$<COMPILE_LANGUAGE:Swift>:-Xfrontend>
    $<$<COMPILE_LANGUAGE:Swift>:-disable-implicit-string-processing-module-import>)
endif()

# Determine the module triple.
if("${SWIFT_HOST_MODULE_TRIPLE}" STREQUAL "")
  # FIXME: This is a hack. It's all a hack. Windows isn't setting
  # CMAKE_Swift_COMPILER_TARGET.
  if(CMAKE_Swift_COMPILER_TARGET)
    string(REGEX REPLACE "macosx[0-9]+([.][0-9]+)?" "macos" SWIFT_HOST_MODULE_TRIPLE
      ${CMAKE_Swift_COMPILER_TARGET})
  elseif("${CMAKE_SYSTEM_NAME}" STREQUAL "Windows")
    if(CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64|AMD64")
      set(SWIFT_HOST_MODULE_TRIPLE "x86_64-unknown-windows-msvc")
    elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64|ARM64|arm64")
      set(SWIFT_HOST_MODULE_TRIPLE "aarch64-unknown-windows-msvc")
    else()
      message(FATAL_ERROR "Unrecognized architecture for Windows host")
    endif()
  else()
    message(FATAL_ERROR "Host module triple required")
  endif()
endif()
message(STATUS "Module triple: ${SWIFT_HOST_MODULE_TRIPLE}")

if (SWIFTSYNTAX_ENABLE_ASSERTIONS)
  add_compile_definitions(
    $<$<COMPILE_LANGUAGE:Swift>:SWIFTSYNTAX_ENABLE_ASSERTIONS>
  )
endif()

add_subdirectory(Sources)
add_subdirectory(cmake/modules)
