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

# The subdirectory into which host libraries will be installed.
set(SWIFT_HOST_LIBRARIES_SUBDIRECTORY "swift/host")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib/${SWIFT_HOST_LIBRARIES_SUBDIRECTORY}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib/${SWIFT_HOST_LIBRARIES_SUBDIRECTORY}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")

set(CMAKE_MACOSX_RPATH YES)

include(AddSwiftHostLibrary)

# Ensure that we do not link the _StringProcessing module. But we can
# only pass this flag for new-enough compilers that support it.
file(WRITE "${CMAKE_BINARY_DIR}/tmp/empty-check-string-processing.swift" "")
execute_process(
  COMMAND
    "${CMAKE_Swift_COMPILER}"
    -Xfrontend -disable-implicit-string-processing-module-import
    -Xfrontend -parse-stdlib
    -c - -o /dev/null
  INPUT_FILE
    "${CMAKE_BINARY_DIR}/tmp/empty-check-string-processing.swift"
  OUTPUT_QUIET ERROR_QUIET
  RESULT_VARIABLE
    SWIFT_SUPPORTS_DISABLE_IMPLICIT_STRING_PROCESSING_MODULE_IMPORT)
if (NOT SWIFT_SUPPORTS_DISABLE_IMPLICIT_STRING_PROCESSING_MODULE_IMPORT)
  add_compile_options(
    $<$<COMPILE_LANGUAGE:Swift>:-Xfrontend>
    $<$<COMPILE_LANGUAGE:Swift>:-disable-implicit-string-processing-module-import>)
endif()

# Determine the module triple.
# FIXME: This is a hack. It's all a hack. Windows isn't setting
# CMAKE_Swift_COMPILER_TARGET.
if(CMAKE_Swift_COMPILER_TARGET)
  string(REGEX REPLACE "macosx[0-9]+([.][0-9]+)?" "macos" SWIFT_MODULE_TRIPLE
    ${CMAKE_Swift_COMPILER_TARGET})
elseif("${CMAKE_SYSTEM_NAME}" STREQUAL "Windows")
  if(CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64|AMD64")
    set(SWIFT_MODULE_TRIPLE "x86_64-unknown-windows-msvc")
  elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64|ARM64|arm64")
    set(SWIFT_MODULE_TRIPLE "aarch64-unknown-windows-msvc")
  else()
    message(FATAL_ERROR "Unrecognized architecture for Windows host")
  endif()
endif()

message(STATUS "Module triple: ${SWIFT_MODULE_TRIPLE}")

# Force single-threaded-only syntax trees to eliminate the Darwin
# dependency in the compiler.
add_compile_definitions(
  $<$<COMPILE_LANGUAGE:Swift>:SWIFT_SYNTAX_ALWAYS_SINGLE_THREADED>
)
if (SWIFTSYNTAX_ENABLE_ASSERTIONS)
  add_compile_definitions(
    $<$<COMPILE_LANGUAGE:Swift>:SWIFTSYNTAX_ENABLE_ASSERTIONS>
  )
endif()

add_subdirectory(Sources)

export(EXPORT SwiftSyntaxTargets
       FILE "${CMAKE_CURRENT_BINARY_DIR}/cmake/SwiftSyntaxTargets.cmake"
       NAMESPACE SwiftSyntax::
)

add_subdirectory(cmake/modules)
