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

#if swift(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

extension FunctionParameterSyntax {
  /// Retrieve the name of the parameter as it is used in source.
  ///
  /// Example:
  ///
  ///     func f(a: Int, _ b: Int, c see: Int) { ... }
  ///
  /// The parameter names for these three parameters are `a`, `b`, and `see`,
  /// respectively.
  @_spi(Testing)
  public var parameterName: TokenSyntax? {
    // If there were two names, the second is the parameter name.
    if let secondName {
      if secondName.text == "_" {
        return nil
      }

      return secondName
    }

    if firstName.text == "_" {
      return nil
    }

    return firstName
  }
}
