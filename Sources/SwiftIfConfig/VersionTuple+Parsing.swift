//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftDiagnostics
import SwiftSyntax

extension VersionTuple {
  /// Parse a compiler build version of the form "5007.*.1.2.3*", which is
  /// used by an older if configuration form `_compiler_version("...")`.
  /// - Parameters:
  ///   - versionString: The version string for the compiler build version that
  ///   we are parsing.
  ///   - versionSyntax: The syntax node that contains the version string, used
  ///   only for diagnostic purposes.
  static func parseCompilerBuildVersion(
    _ versionString: String,
    _ versionSyntax: ExprSyntax
  ) -> (version: VersionTuple?, diagnostics: [Diagnostic]) {
    var extraDiagnostics: [Diagnostic] = []
    let version: VersionTuple?
    do {
      version = try parseCompilerBuildVersion(versionString, versionSyntax, extraDiagnostics: &extraDiagnostics)
    } catch {
      version = nil
      extraDiagnostics.append(contentsOf: error.asDiagnostics(at: versionSyntax))
    }

    return (version, extraDiagnostics)
  }

  /// Parse a compiler build version of the form "5007.*.1.2.3*", which is
  /// used by an older if configuration form `_compiler_version("...")`.
  /// - Parameters:
  ///   - versionString: The version string for the compiler build version that
  ///   we are parsing.
  ///   - versionSyntax: The syntax node that contains the version string, used
  ///   only for diagnostic purposes.
  static func parseCompilerBuildVersion(
    _ versionString: String,
    _ versionSyntax: ExprSyntax,
    extraDiagnostics: inout [Diagnostic]
  ) throws -> VersionTuple {
    var components: [Int] = []

    // Version value are separated by periods.
    let componentStrings = versionString.split(separator: ".", omittingEmptySubsequences: false)

    /// Record a component after checking its value.
    func recordComponent(_ value: Int) throws {
      let limit = components.isEmpty ? 9223371 : 999
      if value < 0 || value > limit {
        throw IfConfigDiagnostic.compilerVersionOutOfRange(value: value, upperLimit: limit, syntax: versionSyntax)
      }

      components.append(value)
    }

    // Parse the components into version values.
    for (index, componentString) in componentStrings.enumerated() {
      // Check ahead of time for empty version components
      if componentString.isEmpty {
        throw IfConfigDiagnostic.emptyVersionComponent(syntax: versionSyntax)
      }

      // The second component is always "*", and is never used for comparison.
      if index == 1 {
        if componentString != "*" {
          extraDiagnostics.append(
            IfConfigDiagnostic.compilerVersionSecondComponentNotWildcard(syntax: versionSyntax).asDiagnostic
          )
        }
        try recordComponent(0)
        continue
      }

      // Every other component must be an integer value.
      guard let component = Int(componentString) else {
        throw IfConfigDiagnostic.invalidVersionOperand(name: "_compiler_version", syntax: versionSyntax)
      }

      try recordComponent(component)
    }

    // Only allowed to specify up to 5 version components.
    if components.count > 5 {
      throw IfConfigDiagnostic.compilerVersionTooManyComponents(syntax: versionSyntax)
    }

    // In the beginning, '_compiler_version(string-literal)' was designed for a
    // different version scheme where the major was fairly large and the minor
    // was ignored; now we use one where the minor is significant and major and
    // minor match the Swift language version. Specifically, majors 600-1300
    // were used for Swift 1.0-5.5 (based on clang versions), but then we reset
    // the numbering based on Swift versions, so 5.6 had major 5. We assume
    // that majors below 600 use the new scheme and equal/above it use the old
    // scheme.
    //
    // However, we want the string literal variant of '_compiler_version' to
    // maintain source compatibility with old checks; that means checks for new
    // versions have to be written so that old compilers will think they represent
    // newer versions, while new compilers have to interpret old version number
    // strings in a way that will compare correctly to the new versions compiled
    // into them.
    //
    // To achieve this, modern compilers divide the major by 1000 and overwrite
    // the wildcard component with the remainder, effectively shifting the last
    // three digits of the major into the minor, before comparing it to the
    // compiler version:
    //
    //     _compiler_version("5007.*.1.2.3") -> 5.7.1.2.3
    //     _compiler_version("1300.*.1.2.3") -> 1.300.1.2.3 (smaller than 5.6)
    //     _compiler_version( "600.*.1.2.3") -> 0.600.1.2.3 (smaller than 5.6)
    //
    // So if you want to specify a 5.7.z.a.b version, we ask users to either
    // write it as 5007.*.z.a.b, or to use the new 'compiler(>= version)'
    // syntax instead, which does not perform this conversion.
    if !components.isEmpty {
      if components.count > 1 {
        components[1] = components[0] % 1000
      }
      components[0] = components[0] / 1000
    }

    return VersionTuple(components: components)
  }
}
