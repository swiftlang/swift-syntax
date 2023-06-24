add_swift_host_library(SwiftSyntaxMacroExpansion
  FunctionParameterUtils.swift
  MacroExpansion.swift
  MacroReplacement.swift
)

target_link_libraries(SwiftSyntaxMacroExpansion PUBLIC
  SwiftSyntax
  SwiftSyntaxMacros
)
