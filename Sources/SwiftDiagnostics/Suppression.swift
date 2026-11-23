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

public import SwiftSyntax

public struct Suppression: Sendable {
  /// A syntax construct that introduces a suppression.
  ///
  /// Based on `String`, to make it easier to serialize to SARIF.
  public enum Kind: String, Sendable {
    /// The warning was off by default, and not enabled on the command line.
    case byDefault
    /// The warning was suppressed by a `@diagnosse(Group, as: ignored)`
    case diagnoseAttribute
    /// Unsafe code was within an `unsafe` expression.
    case unsafeExpr
    /// Unsafe code was in a function or type annotated with `@unsafe`.
    case unsafeAttribute
    /// Unsafe code was in a function or type annotated with `@safe`.
    case safeAttribute
  }

  /// The syntax construct that introduced this suppression.
  public let kind: Kind
  /// The source range of the syntax that introduced the suppression, or
  /// `nil` if the suppression was not in source code.
  public let range: Range<AbsolutePosition>?

  public init(kind: Kind, range: Range<AbsolutePosition>?) {
    self.kind = kind
    self.range = range
  }
}
