add_swift_host_library(SwiftSyntaxMacroExpansion
  BasicMacroExpansionContext.swift
  FunctionParameterUtils.swift
  MacroExpansion.swift
  MacroReplacement.swift
  MacroSystem.swift
  Syntax+MacroEvaluation.swift
)

target_link_libraries(SwiftSyntaxMacroExpansion PUBLIC
  SwiftSyntax
  SwiftSyntaxMacros
)
