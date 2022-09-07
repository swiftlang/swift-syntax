add_library(ASTGen
        ASTGen.swift)

target_compile_options(ASTGen PUBLIC
        "-emit-module-interface")

target_link_libraries(ASTGen PUBLIC
  SwiftSyntax
  SwiftParser
  SwiftDiagnostics)
  
target_include_directories(SwiftParser PUBLIC
  "${CMAKE_CURRENT_BINARY_DIR}/../SwiftSyntax"
  "${CMAKE_CURRENT_BINARY_DIR}/../SwiftDiagnostics"
  "${CMAKE_CURRENT_BINARY_DIR}/../SwiftParser")

set_property(GLOBAL APPEND PROPERTY SWIFTSYNTAX_EXPORTS ASTGen)

# NOTE: workaround for CMake not setting up include flags yet
set_target_properties(ASTGen PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES
  "${CMAKE_Swift_MODULE_DIRECTORY} ${CMAKE_CURRENT_SOURCE_DIR}")

install(TARGETS ASTGen
  EXPORT SwiftSyntaxTargets
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin)
