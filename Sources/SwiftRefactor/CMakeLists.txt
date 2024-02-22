# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

add_swift_syntax_library(SwiftRefactor
  AddSeparatorsToIntegerLiteral.swift
  CallToTrailingClosures.swift
  ExpandEditorPlaceholder.swift
  FormatRawStringLiteral.swift
  IntegerLiteralUtilities.swift
  MigrateToNewIfLetSyntax.swift
  OpaqueParameterToGeneric.swift
  RefactoringProvider.swift
  RemoveSeparatorsFromIntegerLiteral.swift
)

target_link_swift_syntax_libraries(SwiftRefactor PUBLIC
  SwiftBasicFormat
  SwiftParser
  SwiftSyntax
  SwiftSyntaxBuilder
)
