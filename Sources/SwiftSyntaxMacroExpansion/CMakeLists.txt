add_swift_host_library(SwiftSyntaxMacroExpansion
  MacroExpansion.swift
)

target_link_libraries(SwiftSyntaxMacroExpansion PUBLIC
  SwiftSyntax
  SwiftSyntaxMacros
)
