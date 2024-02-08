//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

public enum ExperimentalFeature: String, CaseIterable {
  case referenceBindings
  case thenStatements
  case doExpressions
  case nonescapableTypes
  case transferringArgsAndResults
  case borrowingSwitch

  /// The name of the feature, which is used in the doc comment.
  public var featureName: String {
    switch self {
    case .referenceBindings:
      return "reference bindings"
    case .thenStatements:
      return "'then' statements"
    case .doExpressions:
      return "'do' expressions"
    case .nonescapableTypes:
      return "NonEscableTypes"
    case .transferringArgsAndResults:
      return "TransferringArgsAndResults"
    case .borrowingSwitch:
      return "borrowing pattern matching"
    }
  }

  /// The token that represents the experimental feature case name.
  public var token: TokenSyntax {
    .identifier(rawValue)
  }
}
