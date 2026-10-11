set(target ${SWIFTSYNTAX_TARGET_NAMESPACE}_SwiftSyntaxCShims)
add_library(${target} STATIC
  PlatformMutex.c
)
target_include_directories(${target} PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:include/_SwiftSyntaxCShims>
)

if(PROJECT_IS_TOP_LEVEL OR SWIFT_SYNTAX_INSTALL_TARGETS)
  install(TARGETS ${target}
    EXPORT SwiftSyntaxTargets
    ARCHIVE DESTINATION lib/${SWIFT_HOST_LIBRARIES_SUBDIRECTORY}
    LIBRARY DESTINATION lib/${SWIFT_HOST_LIBRARIES_SUBDIRECTORY}
    RUNTIME DESTINATION bin
  )
  install(DIRECTORY include/ DESTINATION include/_SwiftSyntaxCShims)
else()
  set_property(GLOBAL APPEND PROPERTY SWIFT_EXPORTS ${target})
endif()
