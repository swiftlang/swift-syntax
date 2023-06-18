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

public enum Endianness: String {
  case little
  case big
}

/// Describes the requested version of a module
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
  /// named `DEBUG`.
  func isCustomConditionSet(name: String, syntax: ExprSyntax) -> Bool?

  /// Determine whether the given feature is enabled.
  ///
  /// Features are determined by the Swift compiler, language mode, and other
  /// options such as `--enable-upcoming-feature`.
  func hasFeature(name: String, syntax: ExprSyntax) -> Bool?

  /// Determine whether the given attribute is available.
  ///
  /// Attributes are determined by the Swift compiler.
  func hasAttribute(name: String, syntax: ExprSyntax) -> Bool?

  /// Determine whether a module with the given import path can be imported,
  /// with additional version information.
  func canImport(importPath: [String], version: CanImportVersion, syntax: ExprSyntax) -> Bool?

  /// Determine whether the given name is the active target OS (e.g., Linux, iOS).
  func isActiveTargetOS(name: String, syntax: ExprSyntax) -> Bool?

  /// Determine whether the given name is the active target architecture (e.g., x86_64, arm64)
  func isActiveTargetArchitecture(name: String, syntax: ExprSyntax) -> Bool?

  /// Determine whether the given name is the active target environment (e.g., simulator)
  func isActiveTargetEnvironment(name: String, syntax: ExprSyntax) -> Bool?

  /// Determine whether the given name is the active target runtime (e.g., _ObjC vs. _Native)
  func isActiveTargetRuntime(name: String, syntax: ExprSyntax) -> Bool?

  /// Determine whether the given name is the active target pointer authentication scheme (e.g., arm64e).
  func isActiveTargetPointerAuthentication(name: String, syntax: ExprSyntax) -> Bool?

  /// The bit width of a data pointer for the target architecture.
  var targetPointerBitWidth: Int? { get }

  /// The endianness of the target architecture.
  var endianness: Endianness? { get }

  /// The effective language version, which can be set by the user (e.g., 5.0).
  var languageVersion: VersionTuple? { get }

  /// The version of the compiler (e.g., 5.9).
  var compilerVersion: VersionTuple? { get }
}
