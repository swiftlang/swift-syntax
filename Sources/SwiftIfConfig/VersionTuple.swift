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

/// Describes a version such as `5.9`.
public struct VersionTuple {
  /// The components of the version tuple, start with the major version.
  public var components: [Int]
}

extension VersionTuple {
  /// Create a version tuple from its components.
  public init(_ components: Int...) {
    self.components = components
  }

  /// Parse a string into a version tuple, returning `nil` if any errors were
  /// present.
  public init?(parsing string: String) {
    self.components = []

    for componentText in string.split(separator: ".") {
      guard let component = Int(componentText) else {
        return nil
      }

      components.append(component)
    }
  }
}

extension VersionTuple {
  /// Normalize the version tuple by removing trailing zeroes.
  var normalized: VersionTuple {
    var newComponents = components
    while newComponents.count > 1 && newComponents.last == 0 {
      newComponents.removeLast()
    }

    return VersionTuple(components: newComponents)
  }
}

extension VersionTuple: Equatable, Hashable { }

extension VersionTuple: Comparable {
  public static func <(lhs: VersionTuple, rhs: VersionTuple) -> Bool {
    return lhs.normalized.components.lexicographicallyPrecedes(rhs.normalized.components)
  }
}
