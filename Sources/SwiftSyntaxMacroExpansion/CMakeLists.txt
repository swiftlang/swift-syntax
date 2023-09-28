add_swift_syntax_library(SwiftSyntaxMacroExpansion
  BasicMacroExpansionContext.swift
  FunctionParameterUtils.swift
  MacroExpansion.swift
  MacroReplacement.swift
  MacroSystem.swift
  Syntax+MacroEvaluation.swift
)

target_link_swift_syntax_libraries(SwiftSyntaxMacroExpansion PUBLIC
  SwiftSyntax
  SwiftSyntaxMacros
)
