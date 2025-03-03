//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// Syntactic wrapper type that describes an absolute path for refactoring
/// purposes but does not interpret its contents.
public struct AbsolutePath: CustomStringConvertible, Equatable, Hashable, Sendable {
  public private(set) var description: String

  public init(_ description: String) {
    self.description = description
  }
}
