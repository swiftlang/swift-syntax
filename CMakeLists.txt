# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

cmake_minimum_required(VERSION 3.19.6)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules)

project(SwiftSyntax LANGUAGES C Swift)

set(SWIFT_VERSION 5)
set(CMAKE_Swift_LANGUAGE_VERSION ${SWIFT_VERSION})

set(CMAKE_Swift_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/swift)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(CMAKE_MACOSX_RPATH YES)

# Ensure that we do not link the _StringProcessing module. But we can
# only pass this flag for new-enough compilers that support it.
file(WRITE "${CMAKE_BINARY_DIR}/tmp/empty-check-string-processing.swift" "")
execute_process(
  COMMAND
    "${CMAKE_Swift_COMPILER}"
    -Xfrontend -disable-implicit-string-processing-module-import
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

add_subdirectory(Sources)

export(EXPORT SwiftSyntaxTargets
       FILE "${CMAKE_CURRENT_BINARY_DIR}/cmake/SwiftSyntaxTargets.cmake"
       NAMESPACE SwiftSyntax::
)

add_subdirectory(cmake/modules)
