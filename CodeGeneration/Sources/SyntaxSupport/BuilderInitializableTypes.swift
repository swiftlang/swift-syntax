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

/// As keys, contains all node kinds that can be initialized using a result
/// builder. If the value is not nil, the result builder construct the value's
/// type and synthesize all other members to form the node.
public let BUILDER_INITIALIZABLE_TYPES: [SyntaxNodeKind: SyntaxNodeKind?] = [
  .arrayElementList: nil,
  .closureCaptureList: nil,
  .codeBlock: .codeBlockItemList,
  .codeBlockItemList: nil,
  .enumCaseElementList: nil,
  .exprList: nil,
  .functionParameterList: nil,
  .genericArgumentList: nil,
  .genericParameterList: nil,
  .genericRequirementList: nil,
  .inheritedTypeList: nil,
  .labeledExprList: nil,
  .memberBlock: .memberBlockItemList,
  .memberBlockItemList: nil,
  .patternBindingList: nil,
  .switchCaseItemList: nil,
  .switchCaseList: nil,
  .tuplePatternElementList: nil,
]
