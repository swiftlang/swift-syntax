# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

add_swift_syntax_library(SwiftSyntaxMacros
  MacroProtocols/AccessorMacro.swift
  MacroProtocols/AttachedMacro.swift
  MacroProtocols/BodyMacro.swift
  MacroProtocols/CodeItemMacro.swift
  MacroProtocols/DeclarationMacro.swift
  MacroProtocols/ExpressionMacro.swift
  MacroProtocols/ExtensionMacro.swift
  MacroProtocols/FreestandingMacro.swift
  MacroProtocols/Macro.swift
  MacroProtocols/Macro+Format.swift
  MacroProtocols/MemberAttributeMacro.swift
  MacroProtocols/MemberMacro.swift
  MacroProtocols/PeerMacro.swift
  MacroProtocols/PreambleMacro.swift

  AbstractSourceLocation.swift
  MacroExpansionContext.swift
  MacroExpansionDiagnosticMessages.swift
  Syntax+LexicalContext.swift
)

target_link_swift_syntax_libraries(SwiftSyntaxMacros PUBLIC
  SwiftSyntaxBuilder
  )
