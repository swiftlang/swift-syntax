if(PROJECT_IS_TOP_LEVEL)
  export(EXPORT SwiftSyntaxTargets
         FILE ${CMAKE_CURRENT_BINARY_DIR}/SwiftSyntaxConfig.cmake
         NAMESPACE SwiftSyntax::)
endif()
