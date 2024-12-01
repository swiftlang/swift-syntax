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

/// Syntactic wrapper type that describes a relative path for refactoring
/// purposes but does not interpret its contents.
public struct RelativePath: CustomStringConvertible, Equatable, Hashable, Sendable {
  public private(set) var description: String

  public init(_ description: String) {
    self.description = description
  }

  #if os(Windows)
  static let pathSeparator: Character = "\\"
  #else
  static let pathSeparator: Character = "/"
  #endif

  public func appending(_ component: String) -> Self {
    Self(description + String(RelativePath.pathSeparator) + component)
  }

  public func appending(components: [String]) -> Self {
    appending(components.joined(separator: String(RelativePath.pathSeparator)))
  }
}
