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

#if compiler(>=6)
@_spi(RawSyntax) public import SwiftSyntax
#else
@_spi(RawSyntax) import SwiftSyntax
#endif

extension ExprSyntax {
  /// Parse the source code of this node as a `VersionTupleSyntax`.
  ///
  /// In some situations, like the `_version` argument of the `canImport` condition in `#if`, the version gets parsed as a normal expression, which results in
  /// - an integer literal for single-component versions
  /// - a floating point number for two-component versions
  /// - a floating point number with a member accesses for versions with more than three components
  ///
  /// This is done so the parser can parse `canImport` like any other function call, reducing the need for special handling.
  ///
  /// This property re-interprets such an expression as a version tuple in cases where the client know that it should semantically represent a version.
  ///
  /// If the expression cannot be interpreted as a valid version tuple, returns `nil`.
  public var interpretedAsVersionTuple: VersionTupleSyntax? {
    self.syntaxTextBytes.withUnsafeBufferPointer { bytes in
      var parser = Parser(bytes)
      let versionTuple = VersionTupleSyntax.parse(from: &parser)
      if versionTuple.hasError {
        return nil
      }
      return versionTuple
    }
  }
}
