//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2014-2020 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// Syntactic wrapper type that describes a product type for refactoring
/// purposes but does not interpret its contents.
public enum ProductType {
  /// The type of library.
  public enum LibraryType: String, Codable, Sendable {

    /// Static library.
    case `static`

    /// Dynamic library.
    case `dynamic`

    /// The type of library is unspecified and should be decided by package manager.
    case automatic
  }

  /// A library product.
  case library(LibraryType)

  /// An executable product.
  case executable

  /// An executable code snippet.
  case snippet

  /// An plugin product.
  case plugin

  /// A test product.
  case test

  /// A macro product.
  case `macro`
}
