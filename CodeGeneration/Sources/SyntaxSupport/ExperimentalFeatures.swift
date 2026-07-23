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
  case keypathWithMethodMembers
  case oldOwnershipOperatorSpellings
  case defaultIsolationPerFile
  case borrowAndMutateAccessors
  case _test_EverythingUnexpected

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
    case .keypathWithMethodMembers:
      return "KeypathWithMethodMembers"
    case .oldOwnershipOperatorSpellings:
      return "OldOwnershipOperatorSpellings"
    case .defaultIsolationPerFile:
      return "DefaultIsolationPerFile"
    case .borrowAndMutateAccessors:
      return "BorrowAndMutateAccessors"
    case ._test_EverythingUnexpected:
      return "_test_EverythingUnexpected"
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
    case .keypathWithMethodMembers:
      return "keypaths with method members"
    case .oldOwnershipOperatorSpellings:
      return "`_move` and `_borrow` as ownership operators"
    case .defaultIsolationPerFile:
      return "set default actor isolation for a file"
    case .borrowAndMutateAccessors:
      return "borrow and mutate accessors"
    case ._test_EverythingUnexpected:
      return "a test feature that parses everything as unexpected"
    }
  }

  /// The token that represents the experimental feature case name.
  public var token: TokenSyntax {
    .identifier(rawValue)
  }
}
