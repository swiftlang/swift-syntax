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

/// An indicator of whether a Syntax node was found or written in the source.
///
/// A `missing` node does not mean, necessarily, that the source item is
/// considered "implicit", but rather that it was not found in the source.
public enum SourcePresence: Sendable {
  /// The syntax was authored by a human and found, or was generated.
  case present

  /// The syntax was expected or optional, but not found in the source.
  case missing
}
