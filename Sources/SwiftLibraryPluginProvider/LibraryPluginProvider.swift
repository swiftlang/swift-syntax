//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if swift(>=6.0)
public import SwiftSyntaxMacros
@_spi(PluginMessage) public import SwiftCompilerPluginMessageHandling
private import _SwiftLibraryPluginProviderCShims
// NOTE: Do not use '_SwiftSyntaxCShims' for 'dlopen' and 'LoadLibraryW' (Windows)
// because we don't want other modules depend on 'WinSDK'.
#if canImport(Darwin)
private import Darwin
#elseif canImport(Glibc)
private import Glibc
#elseif canImport(Musl)
private import Musl
#elseif canImport(Android)
private import Android
#endif
#else
import SwiftSyntaxMacros
@_spi(PluginMessage) import SwiftCompilerPluginMessageHandling
@_implementationOnly import _SwiftLibraryPluginProviderCShims
#if canImport(Darwin)
@_implementationOnly import Darwin
#elseif canImport(Glibc)
@_implementationOnly import Glibc
#elseif canImport(Musl)
@_implementationOnly import Musl
#endif
#endif

/// Singleton 'PluginProvider' that can serve shared library plugins.
@_spi(PluginMessage)
public class LibraryPluginProvider: PluginProvider {
  struct LoadedLibraryPlugin {
    var libraryPath: String
    var handle: UnsafeMutableRawPointer
  }

  struct MacroRef: Hashable {
    var moduleName: String
    var typeName: String
  }

  /// Loaded dynamic link library handles associated with the module name.
  var loadedLibraryPlugins: [String: LoadedLibraryPlugin] = [:]

  /// Resolved macros cache.
  var resolvedMacros: [MacroRef: Macro.Type] = [:]

  private init() {}

  /// Singleton.
  @MainActor
  public static let shared: LibraryPluginProvider = LibraryPluginProvider()

  public var features: [PluginFeature] {
    [.loadPluginLibrary]
  }

  public func loadPluginLibrary(libraryPath: String, moduleName: String) throws {
    if let loaded = loadedLibraryPlugins[moduleName] {
      guard loaded.libraryPath == libraryPath else {
        // NOTE: Should be unreachable. Compiler should not load different
        // library for the same module name.
        throw LibraryPluginError(
          message:
            "library plugin for module '\(moduleName)' is already loaded from different path '\(loaded.libraryPath)'"
        )
      }
      return
    }

    let dlHandle = try _loadLibrary(libraryPath)

    loadedLibraryPlugins[moduleName] = LoadedLibraryPlugin(
      libraryPath: libraryPath,
      handle: dlHandle
    )
  }

  public func resolveMacro(moduleName: String, typeName: String) throws -> SwiftSyntaxMacros.Macro.Type {
    let macroRef = MacroRef(moduleName: moduleName, typeName: typeName)
    if let resolved = resolvedMacros[macroRef] {
      return resolved
    }

    // Find 'dlopen'ed library for the module name.
    guard let plugin = loadedLibraryPlugins[moduleName] else {
      // NOTE: Should be unreachable. Compiler should not use this server
      // unless the plugin loading succeeded.
      throw LibraryPluginError(message: "plugin not loaded for module '\(moduleName)'")
    }

    // Lookup the type metadata.
    guard let type = _findAnyType(moduleName, typeName) else {
      throw LibraryPluginError(
        message: "type '\(moduleName).\(typeName)' could not be found in library plugin '\(plugin.libraryPath)'"
      )
    }

    // The type must be a 'Macro' type.
    guard let macro = type as? Macro.Type else {
      throw LibraryPluginError(
        message:
          "type '\(moduleName).\(typeName)' is not a valid macro implementation type in library plugin '\(plugin.libraryPath)'"
      )
    }

    // Cache the resolved type.
    resolvedMacros[macroRef] = macro
    return macro
  }
}

#if os(Windows)
private func _loadLibrary(_ path: String) throws -> UnsafeMutableRawPointer {
  // Create NULL terminated UTF16 string.
  let utf16Path = UnsafeMutableBufferPointer<UInt16>.allocate(capacity: path.utf16.count + 1)
  defer { utf16Path.deallocate() }
  let end = utf16Path.initialize(fromContentsOf: path.utf16)
  utf16Path.initializeElement(at: end, to: 0)

  guard let dlHandle = swiftlibrarypluginprovider_LoadLibraryW(utf16Path.baseAddress) else {
    // FIXME: Format the error code to string.
    throw LibraryPluginError(message: "loader error: \(swiftlibrarypluginprovider_GetLastError())")
  }
  return UnsafeMutableRawPointer(dlHandle)
}
#else
private func _loadLibrary(_ path: String) throws -> UnsafeMutableRawPointer {
  guard let dlHandle = dlopen(path, RTLD_LAZY | RTLD_LOCAL) else {
    throw LibraryPluginError(message: "loader error: \(String(cString: dlerror()!))")
  }
  return dlHandle
}
#endif

private func _findAnyType(_ moduleName: String, _ typeName: String) -> Any.Type? {
  // Create a mangled name for struct, enum, and class. And use a runtime
  // function to find the type. Note that this simple mangling works even if the
  // actual symbol name doesn't match with it. i.e. We don't need to perform
  // punycode encodings or word substitutions.
  // FIXME: This is process global. Can we limit it to a specific .dylib ?
  for suffix in [ /*struct*/"V", /*enum*/ "O", /*class*/ "C"] {
    let mangled = "\(moduleName.utf8.count)\(moduleName)\(typeName.utf8.count)\(typeName)\(suffix)"
    if let type = _typeByName(mangled) {
      return type
    }
  }
  return nil
}

private struct LibraryPluginError: Error, CustomStringConvertible {
  var description: String
  init(message: String) {
    self.description = message
  }
}

// Compatibility shim for SE-0370
#if swift(<5.8)
extension UnsafeMutableBufferPointer {
  private func initialize(fromContentsOf source: some Collection<Element>) -> Index {
    let count = source.withContiguousStorageIfAvailable {
      guard let sourceAddress = $0.baseAddress, !$0.isEmpty else {
        return 0
      }
      precondition(
        $0.count <= self.count,
        "buffer cannot contain every element from source."
      )
      baseAddress?.initialize(from: sourceAddress, count: $0.count)
      return $0.count
    }
    if let count {
      return startIndex.advanced(by: count)
    }

    var (iterator, copied) = self.initialize(from: source)
    precondition(
      iterator.next() == nil,
      "buffer cannot contain every element from source."
    )
    return startIndex.advanced(by: copied)
  }

  private func initializeElement(at index: Index, to value: Element) {
    precondition(startIndex <= index && index < endIndex)
    let p = baseAddress!.advanced(by: index)
    p.initialize(to: value)
  }
}
#endif
