//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

/// A statically-determined build configuration that can be used with any
/// API that requires a build configuration. Static build configurations can
/// be (de-)serialized via Codable.
public struct StaticBuildConfiguration: Codable {
  public init(
    customConditions: Set<String> = [],
    features: Set<String> = [],
    attributes: Set<String> = [],
    importedModules: [String: [VersionedImportModule]] = [:],
    targetOSNames: Set<String> = [],
    targetArchitectures: Set<String> = [],
    targetEnvironments: Set<String> = [],
    targetRuntimes: Set<String> = [],
    targetPointerAuthenticationSchemes: Set<String> = [],
    targetObjectFileFormats: Set<String> = [],
    targetPointerBitWidth: Int = 64,
    targetAtomicBitWidths: [Int] = [],
    endianness: Endianness = .little,
    languageVersion: VersionTuple = VersionTuple(6),
    compilerVersion: VersionTuple = VersionTuple(6, 2)
  ) {
    self.customConditions = customConditions
    self.features = features
    self.attributes = attributes
    self.importedModules = importedModules
    self.targetOSNames = targetOSNames
    self.targetArchitectures = targetArchitectures
    self.targetEnvironments = targetEnvironments
    self.targetRuntimes = targetRuntimes
    self.targetPointerAuthenticationSchemes = targetPointerAuthenticationSchemes
    self.targetObjectFileFormats = targetObjectFileFormats
    self.targetPointerBitWidth = targetPointerBitWidth
    self.targetAtomicBitWidths = targetAtomicBitWidths
    self.endianness = endianness
    self.languageVersion = languageVersion
    self.compilerVersion = compilerVersion
  }

  /// The set of custom conditions that are present and can be used with `#if`.
  ///
  /// Custom build conditions can be set by the `-D` command line option to
  /// the Swift compiler. For example, `-DDEBUG` sets the custom condition
  /// named `DEBUG`, which could be checked with, e.g.,
  ///
  /// ```swift
  /// #if DEBUG
  /// // ...
  /// #endif
  /// ```
  public var customConditions: Set<String> = []

  /// The set of language features that are enabled.
  ///
  /// Features are determined by the Swift compiler, language mode, and other
  /// options such as `--enable-upcoming-feature`, and can be checked with
  /// the `hasFeature` syntax, e.g.,
  ///
  /// ```swift
  /// #if hasFeature(VariadicGenerics)
  /// // ...
  /// #endif
  /// ```
  public var features: Set<String> = []

  /// The set of attributes that are available.
  ///
  /// Attributes are determined by the Swift compiler. They can be checked
  /// with `hasAttribute` syntax, e.g.,
  ///
  /// ```swift
  /// #if hasAttribute(available)
  /// // ...
  /// #endif
  /// ```
  public var attributes: Set<String> = []

  /// The set of modules that can be imported, and their version and underlying
  /// versions (if known). These are organized by top-level module name,
  /// with paths (to submodules) handled internally.
  public var importedModules: [String: [VersionedImportModule]] = [:]

  /// The active target OS names, e.g., "Windows", "iOS".
  public var targetOSNames: Set<String> = []

  /// The active target architectures, e.g., "x64_64".
  public var targetArchitectures: Set<String> = []

  /// The active target environments, e.g., "simulator".
  public var targetEnvironments: Set<String> = []

  /// The active target runtimes, e.g., _ObjC.
  public var targetRuntimes: Set<String> = []

  /// The active target's pointer authentication schemes, e.g., "arm64e".
  public var targetPointerAuthenticationSchemes: Set<String> = []

  /// The active target's object file formats, e.g., "COFF"
  public var targetObjectFileFormats: Set<String> = []

  /// The bit width of a data pointer for the target architecture.
  ///
  /// The target's pointer bit width (which also corresponds to the number of
  /// bits in `Int`/`UInt`) can only be queried with the experimental syntax
  /// `_pointerBitWidth(_<bitwidth>)`, e.g.,
  ///
  /// ```swift
  /// #if _pointerBitWidth(_32)
  /// // 32-bit system
  /// #endif
  /// ```
  public var targetPointerBitWidth: Int = 64

  /// The atomic bit widths that are natively supported by the target
  /// architecture.
  ///
  /// This lists all of the bit widths for which the target provides support
  /// for atomic operations. It can be queried with
  /// `_hasAtomicBitWidth(_<bitwidth>)`, e.g.
  ///
  /// ```swift
  /// #if _hasAtomicBitWidth(_64)
  /// // 64-bit atomics are available
  /// #endif
  public var targetAtomicBitWidths: [Int] = []

  /// The endianness of the target architecture.
  ///
  /// The target's endianness can onyl be queried with the experimental syntax
  /// `_endian(<name>)`, where `<name>` can be either "big" or "little", e.g.,
  ///
  /// ```swift
  /// #if _endian(little)
  /// // Swap some bytes around for network byte order
  /// #endif
  /// ```
  public var endianness: Endianness = .little

  /// The effective language version, which can be set by the user (e.g., 5.0).
  ///
  /// The language version can be queried with the `swift` directive that checks
  /// how the supported language version compares, as described by
  /// [SE-0212](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0212-compiler-version-directive.md). For example:
  ///
  /// ```swift
  /// #if swift(>=5.5)
  /// // Hooray, we can use tasks!
  /// ```
  public var languageVersion: VersionTuple = VersionTuple(6)

  /// The version of the compiler (e.g., 5.9).
  ///
  /// The compiler version can be queried with the `compiler` directive that
  /// checks the specific version of the compiler being used to process the
  /// code, e.g.,
  ///
  /// ```swift
  /// #if compiler(>=5.7)
  /// // Hoorway, we can implicitly open existentials!
  /// #endif
  public var compilerVersion: VersionTuple = VersionTuple(6, 2)
}

extension StaticBuildConfiguration: BuildConfiguration {
  /// Determine whether a given custom build condition has been set.
  ///
  /// Custom build conditions can be set by the `-D` command line option to
  /// the Swift compiler. For example, `-DDEBUG` sets the custom condition
  /// named `DEBUG`, which could be checked with, e.g.,
  ///
  /// ```swift
  /// #if DEBUG
  /// // ...
  /// #endif
  /// ```
  ///
  /// - Parameters:
  ///   - name: The name of the custom build condition being checked (e.g.,
  ///     `DEBUG`.
  /// - Returns: Whether the custom condition is set.
  public func isCustomConditionSet(name: String) -> Bool {
    // "$FeatureName" can be used to check for a language feature.
    if let firstChar = name.first, firstChar == "$" {
      return features.contains(String(name.dropFirst()))
    }

    return customConditions.contains(name)
  }

  /// Determine whether the given feature is enabled.
  ///
  /// Features are determined by the Swift compiler, language mode, and other
  /// options such as `--enable-upcoming-feature`, and can be checked with
  /// the `hasFeature` syntax, e.g.,
  ///
  /// ```swift
  /// #if hasFeature(VariadicGenerics)
  /// // ...
  /// #endif
  /// ```
  ///
  /// - Parameters:
  ///   - name: The name of the feature being checked.
  /// - Returns: Whether the requested feature is available.
  public func hasFeature(name: String) -> Bool {
    features.contains(name)
  }

  /// Determine whether the given attribute is available.
  ///
  /// Attributes are determined by the Swift compiler. They can be checked
  /// with `hasAttribute` syntax, e.g.,
  ///
  /// ```swift
  /// #if hasAttribute(available)
  /// // ...
  /// #endif
  /// ```
  ///
  /// - Parameters:
  ///   - name: The name of the attribute being queried.
  /// - Returns: Whether the requested attribute is supported.
  public func hasAttribute(name: String) -> Bool {
    attributes.contains(name)
  }

  /// Determine whether a module with the given import path can be imported,
  /// with additional version information.
  ///
  /// The availability of a module for import can be checked with `canImport`,
  /// e.g.,
  ///
  /// ```swift
  /// #if canImport(UIKit)
  /// // ...
  /// #endif
  /// ```
  ///
  /// There is an experimental syntax for providing required module version
  /// information, which will translate into the `version` argument.
  ///
  /// - Parameters:
  ///   - importPath: A nonempty sequence of (token, identifier) pairs
  ///     describing the imported module, which was written in source as a
  ///     dotted sequence, e.g., `UIKit.UIViewController` will be passed in as
  ///     the import path array `[(token, "UIKit"), (token, "UIViewController")]`.
  ///   - version: The version restriction on the imported module. For the
  ///     normal `canImport(<import-path>)` syntax, this will always be
  ///     `CanImportVersion.unversioned`.
  /// - Returns: Whether the module can be imported.
  public func canImport(importPath: [(TokenSyntax, String)], version: CanImportVersion) -> Bool {
    // If we don't have any record of the top-level module, we cannot import it.
    guard let topLevelModuleName = importPath.first?.1,
      let versionedImports = importedModules[topLevelModuleName]
    else {
      return false
    }

    // Match on submodule path.
    let submodulePath = Array(importPath.lazy.map(\.1).dropFirst())
    guard let matchingImport = versionedImports.first(where: { $0.submodulePath == submodulePath }) else {
      return false
    }

    switch version {
    case .unversioned:
      return true

    case .version(let expectedVersion):
      guard let actualVersion = matchingImport.version else {
        return false
      }

      return actualVersion >= expectedVersion

    case .underlyingVersion(let expectedVersion):
      guard let actualVersion = matchingImport.underlyingVersion else {
        return false
      }

      return actualVersion >= expectedVersion
    }
  }

  /// Determine whether the given name is the active target OS (e.g., Linux, iOS).
  ///
  /// The target operating system can be queried with `os(<name>)`, e.g.,
  ///
  /// ```swift
  /// #if os(Linux)
  /// // Linux-specific implementation
  /// #endif
  /// ```
  ///
  /// - Parameters:
  ///   - name: The name of the operating system being queried, such as `Linux`,
  ///   `Windows`, `macOS`, etc.
  /// - Returns: Whether the given operating system name is the target operating
  ///   system, i.e., the operating system for which code is being generated.
  public func isActiveTargetOS(name: String) -> Bool {
    targetOSNames.contains(name)
  }

  /// Determine whether the given name is the active target architecture
  /// (e.g., x86_64, arm64).
  ///
  /// The target processor architecture can be queried with `arch(<name>)`, e.g.,
  ///
  /// ```swift
  /// #if arch(x86_64)
  /// // 64-bit x86 Intel-specific code
  /// #endif
  /// ```
  ///
  /// - Parameters:
  ///   - name: The name of the target architecture to check.
  /// - Returns: Whether the given processor architecture is the target
  ///   architecture.
  public func isActiveTargetArchitecture(name: String) -> Bool {
    targetArchitectures.contains(name)
  }

  /// Determine whether the given name is the active target environment (e.g., simulator)
  ///
  /// The target environment can be queried with `targetEnvironment(<name>)`,
  /// e.g.,
  ///
  /// ```swift
  /// #if targetEnvironment(simulator)
  /// // Simulator-specific code
  /// #endif
  /// ```
  ///
  /// - Parameters:
  ///   - name: The name of the target environment to check.
  /// - Returns: Whether the target platform is for a specific environment,
  ///   such as a simulator or emulator.
  public func isActiveTargetEnvironment(name: String) -> Bool {
    targetEnvironments.contains(name)
  }

  /// Determine whether the given name is the active target runtime (e.g., _ObjC vs. _Native)
  ///
  /// The target runtime can only be queried by an experimental syntax
  /// `_runtime(<name>)`, e.g.,
  ///
  /// ```swift
  /// #if _runtime(_ObjC)
  /// // Code that depends on Swift being built for use with the Objective-C
  /// // runtime, e.g., on Apple platforms.
  /// #endif
  /// ```
  ///
  /// The only other runtime is "none", when Swift isn't tying into any other
  /// specific runtime.
  ///
  /// - Parameters:
  ///   - name: The name of the runtime.
  /// - Returns: Whether the target runtime matches the given name.
  public func isActiveTargetRuntime(name: String) -> Bool {
    targetRuntimes.contains(name)
  }

  /// Determine whether the given name is the active target pointer authentication scheme (e.g., arm64e).
  ///
  /// The target pointer authentication scheme describes how pointers are
  /// signed, as a security mitigation. This scheme can only be queried by
  /// an experimental syntax `_ptrath(<name>)`, e.g.,
  ///
  /// ```swift
  /// #if _ptrauth(arm64e)
  /// // Special logic for arm64e pointer signing
  /// #endif
  /// ```
  /// - Parameters:
  ///   - name: The name of the pointer authentication scheme to check.
  /// - Returns: Whether the code generated for the target will use the given
  /// pointer authentication scheme.
  public func isActiveTargetPointerAuthentication(name: String) -> Bool {
    targetPointerAuthenticationSchemes.contains(name)
  }

  /// Determine whether the given name is the active target object file format (e.g., ELF).
  ///
  /// The target object file format can only be queried by an experimental
  /// syntax `_objectFileFormat(<name>)`, e.g.,
  ///
  /// ```swift
  /// #if _objectFileFormat(ELF)
  /// // Special logic for ELF object file formats
  /// #endif
  /// ```
  /// - Parameters:
  ///   - name: The name of the object file format.
  /// - Returns: Whether the target object file format matches the given name.
  @_spi(ExperimentalLanguageFeatures)
  public func isActiveTargetObjectFileFormat(name: String) -> Bool {
    targetObjectFileFormats.contains(name)
  }
}

/// Information about a potentially-versioned import of a given module.
///
/// Each instance of this struct is associated with a top-level module of some
/// form. When the submodule path is empty, it refers to the top-level module
/// itself.
public struct VersionedImportModule: Codable {
  /// The submodule path (which may be empty) from the top-level module to
  /// this specific import.
  public var submodulePath: [String] = []

  /// The version that was imported, if known.
  public var version: VersionTuple? = nil

  /// The version of the underlying Clang module, if there is one and it is
  /// known.
  public var underlyingVersion: VersionTuple? = nil
}
