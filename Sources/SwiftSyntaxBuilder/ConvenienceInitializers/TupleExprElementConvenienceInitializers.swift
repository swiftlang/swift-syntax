//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

public extension TupleExprElement {
  /// A convenience initializer that allows passing in label as an optional string.
  /// The presence of the colon will be inferred based on the presence of the label.
  init(label: String? = nil, expression: ExpressibleAsExprBuildable) {
    self.init(
      label: label.map { Token.identifier($0) }, colon: label == nil ? nil : Token.colon, expression: expression)
  }
}
