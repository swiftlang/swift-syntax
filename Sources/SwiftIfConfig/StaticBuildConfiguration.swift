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

#if compiler(>=6)
@_spi(ExperimentalLanguageFeatures) public import SwiftParser
public import SwiftSyntax
#else
@_spi(ExperimentalLanguageFeatures) import SwiftParser
import SwiftSyntax
#endif

/// A statically-determined build configuration that can be used with any
/// API that requires a build configuration. Static build configurations can
/// be (de-)serialized via Codable.
///
/// Static build configurations can not be used for canImport checks, because
/// such checks require deeper integration with the compiler itself.
public struct StaticBuildConfiguration: Codable {
  public init(
    customConditions: Set<String> = [],
    features: Set<String> = [],
    attributes: Set<String> = [],
    targetOSs: Set<String> = [],
    targetArchitectures: Set<String> = [],
    targetEnvironments: Set<String> = [],
    targetRuntimes: Set<String> = [],
    targetPointerAuthenticationSchemes: Set<String> = [],
    targetObjectFileFormats: Set<String> = [],
    targetPointerBitWidth: Int = 64,
    targetAtomicBitWidths: [Int] = [],
    endianness: Endianness = .little,
    languageVersion: VersionTuple,
    compilerVersion: VersionTuple
  ) {
    self.customConditions = customConditions
    self.features = features
    self.attributes = attributes
    self.targetOSs = targetOSs
    self.targetArchitectures = targetArchitectures
    self.targetEnvironments = targetEnvironments
    self.targetRuntimes = targetRuntimes
    self.targetPointerAuthenticationSchemes = targetPointerAuthenticationSchemes
    self.targetObjectFileFormats = targetObjectFileFormats
    self.targetPointerBitWidth = targetPointerBitWidth
    self.targetAtomicBitWidths = targetAtomicBitWidths
    self.endianness = endianness
    self.languageMode = languageVersion
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

  /// The active target OS, e.g., "Windows", "iOS".
  ///
  /// The target operating system can be queried with `os(<name>)`, e.g.,
  ///
  /// ```swift
  /// #if os(Linux)
  /// // Linux-specific implementation
  /// #endif
  /// ```
  public var targetOSs: Set<String> = []

  /// The active target architectures, e.g., "x64_64".
  ///
  /// The target processor architecture can be queried with `arch(<name>)`, e.g.,
  ///
  /// ```swift
  /// #if arch(x86_64)
  /// // 64-bit x86 Intel-specific code
  /// #endif
  /// ```
  public var targetArchitectures: Set<String> = []

  /// The active target environments, e.g., "simulator".
  ///
  /// The target environment can be queried with `targetEnvironment(<name>)`,
  /// e.g.,
  ///
  /// ```swift
  /// #if targetEnvironment(simulator)
  /// // Simulator-specific code
  /// #endif
  /// ```
  public var targetEnvironments: Set<String> = []

  /// The active target runtimes, e.g., _ObjC.
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
  public var targetRuntimes: Set<String> = []

  /// The active target's pointer authentication schemes, e.g., "arm64e".
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
  public var targetPointerAuthenticationSchemes: Set<String> = []

  /// The active target's object file formats, e.g., "COFF"
  ///
  /// The target object file format can only be queried by an experimental
  /// syntax `_objectFileFormat(<name>)`, e.g.,
  ///
  /// ```swift
  /// #if _objectFileFormat(ELF)
  /// // Special logic for ELF object file formats
  /// #endif
  /// ```
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

  /// The effective language mode, which can be set by the user (e.g., 5.0).
  ///
  /// The language version can be queried with the `swift` directive that checks
  /// how the supported language version compares, as described by
  /// [SE-0212](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0212-compiler-version-directive.md). For example:
  ///
  /// ```swift
  /// #if swift(>=6.0)
  /// // Hooray, we can use tasks!
  /// ```
  public var languageMode: VersionTuple

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
  public var compilerVersion: VersionTuple
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
  /// This implementation always throws an error, because static build
  /// configurations cannot evaluate canImport checks.
  public func canImport(importPath: [(TokenSyntax, String)], version: CanImportVersion) throws -> Bool {
    throw StaticBuildConfiguration.Error.canImportUnavailable
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
    targetOSs.contains(name)
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
  public func isActiveTargetObjectFormat(name: String) -> Bool {
    targetObjectFileFormats.contains(name)
  }

  /// Equivalent to `languageMode`, but required for conformance to the
  /// `BuildConfiguration` protocol.
  public var languageVersion: VersionTuple {
    languageMode
  }
}

extension StaticBuildConfiguration {
  enum Error: Swift.Error {
    /// Indicates when the static build configuration was asked to evaluate
    /// canImport, which it cannot do correctly.
    case canImportUnavailable
  }
}

extension StaticBuildConfiguration {
  /// The Swift version that can be set for the parser.
  public var parserSwiftVersion: Parser.SwiftVersion {
    if languageMode < VersionTuple(5) {
      return .v4
    } else if languageMode < VersionTuple(6) {
      return .v5
    } else if languageMode < VersionTuple(7) {
      return .v6
    } else {
      return Parser.defaultSwiftVersion
    }
  }

  /// Determine the set of experimental features that are enabled by this
  /// static build configuration.
  @_spi(ExperimentalLanguageFeatures)
  public var experimentalFeatures: Parser.ExperimentalFeatures {
    var result: Parser.ExperimentalFeatures = []
    for feature in features {
      if let experimentalFeature = Parser.ExperimentalFeatures(name: feature) {
        result.insert(experimentalFeature)
      }
    }
    return result
  }
}
