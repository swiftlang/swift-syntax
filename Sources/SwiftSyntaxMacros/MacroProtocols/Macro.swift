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

/// Describes a macro.
public protocol Macro {
  /// How the resulting expansion should be formatted, `.auto` by default.
  /// Use `.disabled` for the expansion to be used as is.
  static var formatMode: FormatMode { get }

  /// Whether to infer "nonisolated" on protocol conformances introduced in
  /// the macro expansion when there are some nonisolated members in the
  /// corresponding declaration group. When true, macro expansion will adjust
  /// expanded code such as
  ///
  ///     extension C: P {
  ///       nonisolated func f() { }
  ///     }
  ///
  /// to
  ///
  ///     extension C: nonisolated P {
  ///       nonisolated func f() { }
  ///     }
  ///
  /// This operation defaults to `true`. Macros can implement it to return
  /// `false` to prevent this adjustment to the macro-expanded code.
  static var inferNonisolatedConformances: Bool { get }
}

extension Macro {
  /// Default implementation of the Macro protocol's
  /// `inferNonisolatedConformances` that returns `true`.
  public static var inferNonisolatedConformances: Bool { true }
}
