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

import SwiftIfConfig
import SwiftSyntax

enum BuildConfigurationError: Error, CustomStringConvertible {
  case badAttribute(String)

  var description: String {
    switch self {
    case .badAttribute(let attribute):
      return "unacceptable attribute '\(attribute)'"
    }
  }
}

struct TestingBuildConfiguration: BuildConfiguration {
  var platformName: String = "Linux"
  var customConditions: Set<String> = []
  var features: Set<String> = []
  var attributes: Set<String> = []

  /// A set of attribute names that are "bad", causing the build configuration
  /// to throw an error if queried.
  var badAttributes: Set<String> = []

  func isCustomConditionSet(name: String) -> Bool {
    customConditions.contains(name)
  }

  func hasFeature(name: String) -> Bool {
    features.contains(name)
  }

  func hasAttribute(name: String) throws -> Bool {
    if badAttributes.contains(name) {
      throw BuildConfigurationError.badAttribute(name)
    }

    return attributes.contains(name)
  }

  func canImport(
    importPath: [String],
    version: CanImportVersion
  ) -> Bool {
    guard let moduleName = importPath.first else {
      return false
    }

    guard moduleName == "SwiftSyntax" else { return false }

    switch version {
    case .unversioned:
      return true

    case .version(let expectedVersion):
      return expectedVersion <= VersionTuple(5, 9, 2)

    case .underlyingVersion(let expectedVersion):
      return expectedVersion <= VersionTuple(5009, 2)
    }
  }

  func isActiveTargetOS(name: String) -> Bool {
    name == platformName
  }

  func isActiveTargetArchitecture(name: String) -> Bool {
    name == "arm64"
  }

  func isActiveTargetEnvironment(name: String) -> Bool {
    name == "simulator"
  }

  func isActiveTargetRuntime(name: String) -> Bool {
    name == "_Native"
  }

  func isActiveTargetPointerAuthentication(name: String) -> Bool {
    name == "arm64e"
  }

  var targetPointerBitWidth: Int { 64 }

  var targetAtomicBitWidths: [Int] { [32, 64] }

  var endianness: SwiftIfConfig.Endianness { .little }

  var languageVersion: VersionTuple { VersionTuple(5, 5) }

  var compilerVersion: VersionTuple { VersionTuple(5, 9, 1) }
}
