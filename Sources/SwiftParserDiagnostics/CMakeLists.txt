# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

add_swift_syntax_library(SwiftParserDiagnostics
  DiagnosticExtensions.swift
  LexerDiagnosticMessages.swift
  MissingNodesError.swift
  MissingTokenError.swift
  MultiLineStringLiteralDiagnosticsGenerator.swift
  ParserDiagnosticMessages.swift
  ParseDiagnosticsGenerator.swift
  PresenceUtils.swift
  SyntaxExtensions.swift
  Utils.swift

  generated/ChildNameForDiagnostics.swift
  generated/SyntaxKindNameForDiagnostics.swift
  generated/TokenNameForDiagnostics.swift
)

target_link_swift_syntax_libraries(SwiftParserDiagnostics PUBLIC
  SwiftBasicFormat
  SwiftDiagnostics
  SwiftParser
  SwiftSyntax)
