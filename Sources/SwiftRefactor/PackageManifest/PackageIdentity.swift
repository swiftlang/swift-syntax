//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2014-2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// Describes a package identity for refactoring purposes. This is a syntactic
/// subset of the full package manifest's notion of package identity.
public struct PackageIdentity: CustomStringConvertible, Equatable, Hashable, Sendable {
  public private(set) var description: String

  public init(_ description: String) {
    self.description = description
  }
}
