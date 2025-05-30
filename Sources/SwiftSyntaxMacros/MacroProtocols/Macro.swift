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

#if compiler(>=6.2)
/// Describes a macro.
public protocol Macro: SendableMetatype {
  /// How the resulting expansion should be formatted, `.auto` by default.
  /// Use `.disabled` for the expansion to be used as is.
  static var formatMode: FormatMode { get }
}
#else
/// Describes a macro.
public protocol Macro {
  /// How the resulting expansion should be formatted, `.auto` by default.
  /// Use `.disabled` for the expansion to be used as is.
  static var formatMode: FormatMode { get }
}
#endif
