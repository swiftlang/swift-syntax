if(PROJECT_IS_TOP_LEVEL OR SWIFT_SYNTAX_INSTALL_TARGETS)
  export(EXPORT SwiftSyntaxTargets
         FILE ${CMAKE_CURRENT_BINARY_DIR}/SwiftSyntaxConfig.cmake
         NAMESPACE SwiftSyntax::)
endif()
