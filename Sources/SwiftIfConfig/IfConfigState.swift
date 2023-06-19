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

/// Describes the state of a particular region guarded by `#if` or similar.
public enum IfConfigState {
  /// The region is not parsed, and may contain syntax that is invalid.
  ///
  /// TODO: For now, the IfConfig library does not distinguish between
  /// inactive and unparsed regions, so this case is never used.
  case unparsed
  /// The region is parsed but is not part of the compiled program.
  case inactive
  /// The region is active and is part of the compiled program.
  case active
}
