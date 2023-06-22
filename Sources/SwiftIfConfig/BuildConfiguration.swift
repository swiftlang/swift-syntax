//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//
import SwiftSyntax

/// Describes the ordering of a sequence of bytes that make up a word of
/// storage for a particular architecture.
public enum Endianness: String {
  /// Little endian, meaning that the least significant byte of a word is
  /// stored at the lowest address.
  case little

  /// Big endian, meaning that the most significant byte of a word is stored
  /// at the lowest address.
  case big
}

/// Describes the requested version of a module.
public enum CanImportVersion {
  /// Any version of the module will suffice.
  case unversioned

  /// Only modules with the given version or higher will match.
  case version(VersionTuple)

  /// Only modules where the underlying Clang module has the given version or
  /// higher will match.
  case underlyingVersion(VersionTuple)
}

/// Captures information about the build configuration that can be
/// queried in a `#if` expression, including OS, compiler version,
/// enabled language features, and available modules.
///
/// Providing complete build configuration information effectively requires
/// a Swift compiler, because (for example) determining whether a module can
/// be imported is a complicated task only implemented in the Swift compiler.
/// Therefore, many of the queries return `Bool?`, where `nil` indicates
/// that the answer is not known. Clients that don't have a lot of context
/// (such as an IDE that does not have access to the compiler command line)
/// can return `nil`.
public protocol BuildConfiguration {
  /// Determine whether a given custom build condition has been set.
  ///
  /// Custom build conditions can be set by the `-D` command line option to
  /// the Swift compiler. For example, `-DDEBUG` sets the custom condition
  /// named `DEBUG`, which could be checked with, e.g.,
  ///
  /// ```
  /// #if DEBUG
  /// // ...
  /// #endif
  /// ```
  ///
  /// - Parameters:
  ///   - name: The name of the custom build condition being checked (e.g.,
  ///     `DEBUG`.
  ///   - syntax: The syntax node for the name of the custom build
  ///     configuration.
  /// - Returns: Whether the custom condition is set.
  func isCustomConditionSet(name: String, syntax: ExprSyntax) -> Bool?

  /// Determine whether the given feature is enabled.
  ///
  /// Features are determined by the Swift compiler, language mode, and other
  /// options such as `--enable-upcoming-feature`, and can be checked with
  /// the `hasFeature` syntax, e.g.,
  ///
  /// ```
  /// #if hasFeature(VariadicGenerics)
  /// // ...
  /// #endif
  /// ```
  ///
  /// - Parameters:
  ///   - name: The name of the feature being checked.
  ///   - syntax: The syntax node for the `hasFeature(<name>)`.
  /// - Returns: Whether the requested feature is available.
  func hasFeature(name: String, syntax: ExprSyntax) -> Bool?

  /// Determine whether the given attribute is available.
  ///
  /// Attributes are determined by the Swift compiler. They can be checked
  /// with `hasAttribute` syntax, e.g.,
  ///
  /// ```
  /// #if hasAttribute(available)
  /// // ...
  /// #endif
  /// ```
  ///
  /// - Parameters:
  ///   - name: The name of the attribute being queried.
  ///   - syntax: The syntax node for the `hasAttribute(<name>)`.
  /// - Returns: Whether the requested attribute is supported.
  func hasAttribute(name: String, syntax: ExprSyntax) -> Bool?

  /// Determine whether a module with the given import path can be imported,
  /// with additional version information.
  ///
  /// The availability of a module for import can be checked with `canImport`,
  /// e.g.,
  ///
  /// ```
  /// #if canImport(UIKit)
  /// // ...
  /// #endif
  /// ```
  ///
  /// There is an experimental syntax for providing required module version
  /// information, which will translate into the `version` argument.
  ///
  /// - Parameters:
  ///   - importPath: A nonempty sequence of identifiers describing the
  ///     imported module, which was written in source as a dotted sequence,
  ///     e.g., `UIKit.UIViewController` will be passed in as the import path
  ///     array `["UIKit", "UIViewController"]`.
  ///   - version: The version restriction on the imported module. For the
  ///     normal `canImport(<import-path>)` syntax, this will always be
  ///     `CanImportVersion.unversioned`.
  ///   - syntax: The syntax node for the `canImport` expression.
  /// - Returns: Whether the module can be imported.
  func canImport(importPath: [String], version: CanImportVersion, syntax: ExprSyntax) -> Bool?

  /// Determine whether the given name is the active target OS (e.g., Linux, iOS).
  ///
  /// The target operating system can be queried with `os(<name>)`, e.g.,
  ///
  /// ```
  /// #if os(Linux)
  /// // Linux-specific implementation
  /// #endif
  ///
  /// - Parameters:
  ///   - name: The name of the operating system being queried, such as `Linux`,
  ///   `Windows`, `macOS`, etc.
  ///   - syntax: The syntax node for the `os(<name>)` expression.
  /// - Returns: Whether the given operating system name is the target operating
  ///   system, i.e., the operating system for which code is being generated.
  func isActiveTargetOS(name: String, syntax: ExprSyntax) -> Bool?

  /// Determine whether the given name is the active target architecture
  /// (e.g., x86_64, arm64).
  ///
  /// The target processor architecture can be queried with `arch(<name>)`, e.g.,
  ///
  /// ```
  /// #if arch(x86_64)
  /// // 64-bit x86 Intel-specific code
  /// #endif
  ///
  /// - Parameters:
  ///   - name: The name of the target architecture to check.
  ///   - syntax: The syntax node for the `arch(<name>)` expression.
  /// - Returns: Whether the given processor architecture is the target
  ///   architecture.
  func isActiveTargetArchitecture(name: String, syntax: ExprSyntax) -> Bool?

  /// Determine whether the given name is the active target environment (e.g., simulator)
  ///
  /// The target environment can be queried with `targetEnvironment(<name>)`,
  /// e.g.,
  ///
  /// ```
  /// #if targetEnvironment(simulator)
  /// // Simulator-specific code
  /// #endif
  ///
  /// - Parameters:
  ///   - name: The name of the target environment to check.
  ///   - syntax: The syntax node for the `targetEnvironment(<name>)`
  ///     expression.
  /// - Returns: Whether the target platform is for a specific environment,
  ///   such as a simulator or emulator.
  func isActiveTargetEnvironment(name: String, syntax: ExprSyntax) -> Bool?

  /// Determine whether the given name is the active target runtime (e.g., _ObjC vs. _Native)
  ///
  /// The target runtime can only be queried by an experimental syntax
  /// `_runtime(<name>)`, e.g.,
  ///
  /// #if _runtime(_ObjC)
  /// // Code that depends on Swift being built for use with the Objective-C
  /// // runtime, e.g., on Apple platforms.
  /// #endif
  ///
  /// The only other runtime is "none", when Swift isn't tying into any other
  /// specific runtime.
  ///
  /// - Parameters:
  ///   - name: The name of the runtime.
  ///   - syntax: The syntax node for the `_runtime(<name>)` expression.
  /// - Returns: Whether the target runtime matches the given name.
  func isActiveTargetRuntime(name: String, syntax: ExprSyntax) -> Bool?

  /// Determine whether the given name is the active target pointer authentication scheme (e.g., arm64e).
  ///
  /// The target pointer authentication scheme describes how pointers are
  /// signed, as a security mitigation. This scheme can only be queried by
  /// an experimental syntax `_ptrath(<name>)`, e.g.,
  ///
  /// ```
  /// #if _ptrauth(arm64e)
  /// // Special logic for arm64e pointer signing
  /// #endif
  ///
  /// - Parameters:
  ///   - name: The name of the pointer authentication scheme to check.
  ///   - syntax: The syntax node for the `_ptrauth(<name>)` expression.
  /// - Returns: Whether the code generated for the target will use the given
  /// pointer authentication scheme.
  func isActiveTargetPointerAuthentication(name: String, syntax: ExprSyntax) -> Bool?

  /// The bit width of a data pointer for the target architecture.
  ///
  /// The target's pointer bit with (which also corresponds to the number of
  /// bits in `Int`/`UInt`) can only be queried with the experimental syntax
  /// `_pointerBitWidth(_<bitwidth>)`, e.g.,
  ///
  /// ```
  /// #if _pointerBitWidth(32)
  /// // 32-bit system
  /// #endif
  var targetPointerBitWidth: Int? { get }

  /// The endianness of the target architecture.
  ///
  /// The target's endianness can onyl be queried with the experimental syntax
  /// `_endian(<name>)`, where `<name>` can be either "big" or "little", e.g.,
  ///
  /// #if _endian(little)
  /// // Swap some bytes around for network byte order
  /// #endif
  var endianness: Endianness? { get }

  /// The effective language version, which can be set by the user (e.g., 5.0).
  ///
  /// The language version can be queried with the `swift` directive that checks
  /// how the supported language version compares, as described by
  /// [SE-0212](https://github.com/apple/swift-evolution/blob/main/proposals/0212-compiler-version-directive.md). For example:
  ///
  /// ```
  /// #if swift(>=5.5)
  /// // Hooray, we can use tasks!
  /// ```
  var languageVersion: VersionTuple? { get }

  /// The version of the compiler (e.g., 5.9).
  ///
  /// The compiler version can be queried with the `compiler` directive that
  /// checks the specific version of the compiler being used to process the
  /// code, e.g.,
  ///
  /// ```
  /// #if compiler(>=5.7)
  /// // Hoorway, we can implicitly open existentials!
  /// #endif
  var compilerVersion: VersionTuple? { get }
}
