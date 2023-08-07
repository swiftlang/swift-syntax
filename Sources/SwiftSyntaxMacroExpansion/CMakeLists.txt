add_swift_host_library(SwiftSyntaxMacroExpansion
  BasicMacroExpansionContext.swift
  FunctionParameterUtils.swift
  IndentationUtils.swift
  MacroExpansion.swift
  MacroExpansionDiagnosticMessages.swift
  MacroReplacement.swift
  MacroSystem.swift
)

target_link_libraries(SwiftSyntaxMacroExpansion PUBLIC
  SwiftSyntax
  SwiftSyntaxMacros
)
