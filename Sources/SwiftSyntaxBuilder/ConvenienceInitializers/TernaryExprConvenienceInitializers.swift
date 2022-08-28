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

extension TernaryExpr {
  public init(
    if condition: ExpressibleAsExprBuildable,
    then firstChoice: ExpressibleAsExprBuildable,
    else secondChoice: ExpressibleAsExprBuildable
  ) {
    self.init(
      conditionExpression: condition,
      questionMark: .infixQuestionMark.withLeadingTrivia(.space).withTrailingTrivia(.space),
      firstChoice: firstChoice,
      colonMark: .colon.withLeadingTrivia(.space),
      secondChoice: secondChoice
    )
  }
}

