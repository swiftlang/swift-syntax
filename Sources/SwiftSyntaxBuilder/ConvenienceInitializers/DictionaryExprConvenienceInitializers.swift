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

extension DictionaryExpr {
  /// A convenience initializer that allows passing in members using a result builder
  /// instead of having to wrap them in a `DictionaryElementList`.
  public init(
    leftSquare: Token = .`leftSquareBracket`,
    rightSquare: Token = .`rightSquareBracket`,
    @DictionaryElementListBuilder contentBuilder: () -> ExpressibleAsDictionaryElementList = { [] }
  ) {
    let elementList = contentBuilder().createDictionaryElementList()
    self.init(
      leftSquare: leftSquare,
      content: elementList.elements.isEmpty ? Token.colon.withTrailingTrivia([]) : elementList,
      rightSquare: rightSquare
    )
  }
}
