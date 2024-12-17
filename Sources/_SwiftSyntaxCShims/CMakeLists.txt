set(target ${SWIFTSYNTAX_TARGET_NAMESPACE}_SwiftSyntaxCShims)
add_library(${target} STATIC
  PlatformMutex.c
)
target_include_directories(${target} PUBLIC "include")
set_property(GLOBAL APPEND PROPERTY SWIFT_EXPORTS ${target})
install(TARGETS ${target} EXPORT SwiftSyntaxTargets)
