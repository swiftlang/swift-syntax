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
public struct VersionTuple: Sendable {
  /// The components of the version tuple, start with the major version.
  public var components: [Int]

  /// Create a version tuple from a non-empty array of components.
  public init(components: [Int]) {
    precondition(!components.isEmpty)
    self.components = components
  }

  /// Create a version tuple from its components.
  public init(_ firstComponent: Int, _ remainingComponents: Int...) {
    self.components = []
    self.components.append(firstComponent)
    self.components.append(contentsOf: remainingComponents)
  }

  /// Parse a string into a version tuple, returning `nil` if any errors were
  /// present.
  public init?(parsing string: String) {
    self.components = []

    for componentText in string.split(separator: ".", omittingEmptySubsequences: false) {
      guard let component = Int(componentText) else {
        return nil
      }

      components.append(component)
    }

    if components.isEmpty { return nil }
  }

  /// Normalize the version tuple by removing trailing zeroes.
  var normalized: VersionTuple {
    var newComponents = components
    while newComponents.count > 1 && newComponents.last == 0 {
      newComponents.removeLast()
    }

    return VersionTuple(components: newComponents)
  }
}

extension VersionTuple: Equatable, Hashable {}

extension VersionTuple: Comparable {
  public static func < (lhs: VersionTuple, rhs: VersionTuple) -> Bool {
    return lhs.normalized.components.lexicographicallyPrecedes(rhs.normalized.components)
  }
}

extension VersionTuple: CustomStringConvertible {
  public var description: String {
    return components.map { String($0) }.joined(separator: ".")
  }
}
