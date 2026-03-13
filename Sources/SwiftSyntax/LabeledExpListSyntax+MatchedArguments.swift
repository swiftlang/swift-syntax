//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

extension LabeledExprListSyntax {
  public func matchArguments(
    against parameters: FunctionParameterClauseSyntax,
    isSubscript: Bool = false
  ) -> MatchedArguments {
    var expressions: [[ExprSyntax]] = []

    var iterator = makeIterator()

    var elements: [ExprSyntax] = []
    while let element = iterator.next() {
      elements.append(element.expression)

      guard element.colon != nil else {
        continue
      }

      expressions.append(elements)
    }

    var result: [String: [ExprSyntax]] = [:]
    for (expressions, parameter) in zip(expressions, parameters.parameters) {
      let key = parameter.name

      result[key] = expressions
    }

    return MatchedArguments(matchedArguments: result)
  }
}

public struct MatchedArguments {
  let matchedArguments: [String: [ExprSyntax]]

  public func argument(for internalLabel: String) -> [ExprSyntax]? {
    return matchedArguments[internalLabel]
  }
}

extension FunctionParameterSyntax {
  fileprivate var name: String {
    return secondName?.text ?? firstName.text
  }
}
