# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

add_swift_syntax_library(SwiftSyntaxBuilder
  ConvenienceInitializers.swift
  DeclSyntaxParseable.swift
  Indenter.swift
  ListBuilder.swift
  ResultBuilderExtensions.swift
  SwiftSyntaxBuilderCompatibility.swift
  Syntax+StringInterpolation.swift
  SyntaxNodeWithBody.swift
  SyntaxParsable+ExpressibleByStringInterpolation.swift
  ValidatingSyntaxNodes.swift
  WithTrailingCommaSyntax+EnsuringTrailingComma.swift


  generated/BuildableNodes.swift
  generated/ResultBuilders.swift
  generated/RenamedChildrenBuilderCompatibility.swift
  generated/SyntaxExpressibleByStringInterpolationConformances.swift
)

# Don't depend on OSLog when we are building for the compiler.
# In that case we don't want any dependencies on the SDK.
target_compile_options(SwiftSyntaxBuilder PRIVATE
  $<$<COMPILE_LANGUAGE:Swift>:-D;SWIFTSYNTAX_NO_OSLOG_DEPENDENCY>)

target_link_swift_syntax_libraries(SwiftSyntaxBuilder PUBLIC
  SwiftBasicFormat
  SwiftParser
  SwiftParserDiagnostics
  SwiftSyntax
  )
