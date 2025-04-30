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
  case trailingComma
  case coroutineAccessors
  case abiAttribute
  case keypathWithMethodMembers
  case oldOwnershipOperatorSpellings
  case inlineArrayTypeSugar

  /// The name of the feature as it is written in the compiler's `Features.def` file.
  public var featureName: String {
    switch self {
    case .referenceBindings:
      return "ReferenceBindings"
    case .thenStatements:
      return "ThenStatements"
    case .doExpressions:
      return "DoExpressions"
    case .nonescapableTypes:
      return "NonescapableTypes"
    case .trailingComma:
      return "TrailingComma"
    case .coroutineAccessors:
      return "CoroutineAccessors"
    case .abiAttribute:
      return "ABIAttribute"
    case .keypathWithMethodMembers:
      return "KeypathWithMethodMembers"
    case .oldOwnershipOperatorSpellings:
      return "OldOwnershipOperatorSpellings"
    case .inlineArrayTypeSugar:
      return "InlineArrayTypeSugar"
    }
  }

  /// A brief description of the feature that is used in the doc comment.
  public var documentationDescription: String {
    switch self {
    case .referenceBindings:
      return "reference bindings"
    case .thenStatements:
      return "'then' statements"
    case .doExpressions:
      return "'do' expressions"
    case .nonescapableTypes:
      return "non-escapable types"
    case .trailingComma:
      return "trailing commas"
    case .coroutineAccessors:
      return "coroutine accessors"
    case .abiAttribute:
      return "@abi attribute"
    case .keypathWithMethodMembers:
      return "keypaths with method members"
    case .oldOwnershipOperatorSpellings:
      return "`_move` and `_borrow` as ownership operators"
    case .inlineArrayTypeSugar:
      return "sugar type for InlineArray"
    }
  }

  /// The token that represents the experimental feature case name.
  public var token: TokenSyntax {
    .identifier(rawValue)
  }
}
