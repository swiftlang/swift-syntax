set(target ${SWIFTSYNTAX_TARGET_NAMESPACE}_SwiftLibraryPluginProviderCShims)
add_library(${target} STATIC
  LoadLibrary.c
)
target_include_directories(${target} PUBLIC "include")
set_property(GLOBAL APPEND PROPERTY SWIFT_EXPORTS ${target})
install(TARGETS ${target} EXPORT SwiftSyntaxTargets)
