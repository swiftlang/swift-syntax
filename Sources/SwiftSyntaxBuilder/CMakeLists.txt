# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

add_swift_host_library(SwiftSyntaxBuilder
  ConvenienceInitializers.swift
  HasTrailingComma.swift
  Indenter.swift
  ResultBuilderExtensions.swift
  Syntax+StringInterpolation.swift
  SyntaxNodeWithBody.swift


  generated/BuildableCollectionNodes.swift
  generated/BuildableNodes.swift
  generated/ResultBuilders.swift
  generated/Token.swift
  generated/Typealiases.swift
  generated/SyntaxExpressibleByStringInterpolationConformances.swift
)

target_link_libraries(SwiftSyntaxBuilder PUBLIC
  SwiftBasicFormat
  SwiftParser
  SwiftParserDiagnostics
  SwiftSyntax
  )
