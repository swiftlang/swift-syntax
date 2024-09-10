//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

/// Implementations should provide necessary information for generating code of a parameter.
public protocol ParameterConvertible {
  /// The type that is used for parameters in SwiftSyntaxBuilder that take this
  /// type of syntax node and expect an existential type if the parameter type is a protocol.
  var parameterAnyType: TypeSyntax {
    get
  }

  /// The type that is used for parameters in SwiftSyntaxBuilder that take this
  /// type of syntax node and expect a generic type if the parameter type is a protocol.
  var parameterSomeType: TypeSyntax {
    get
  }

  /// If the type has a default value (because it is optional or a token
  /// with fixed test), return an expression that can be used as the
  /// default value for a function parameter. Otherwise, return `nil`.
  var defaultValue: ExprSyntax? {
    get
  }
}
