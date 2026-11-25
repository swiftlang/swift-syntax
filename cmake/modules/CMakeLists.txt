if(PROJECT_IS_TOP_LEVEL OR SWIFT_SYNTAX_INSTALL_TARGETS)
  export(EXPORT SwiftSyntaxTargets
         FILE ${CMAKE_CURRENT_BINARY_DIR}/SwiftSyntaxConfig.cmake
         NAMESPACE SwiftSyntax::)

  include(CMakePackageConfigHelpers)
  configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/SwiftSyntaxConfig.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/cmake/SwiftSyntaxConfig.cmake"
    INSTALL_DESTINATION lib/cmake/SwiftSyntax
  )

  install(EXPORT SwiftSyntaxTargets
          FILE SwiftSyntaxTargets.cmake
          DESTINATION lib/cmake/SwiftSyntax
          NAMESPACE SwiftSyntax::)

  install(FILES "${CMAKE_CURRENT_BINARY_DIR}/cmake/SwiftSyntaxConfig.cmake"
          DESTINATION lib/cmake/SwiftSyntax)
endif()
