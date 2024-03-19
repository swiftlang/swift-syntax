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

import SwiftParser
import SwiftSyntax
import XCTest

final class TypeCompositionTests: ParserTestCase {
  func testComponents() {
    let cases: [UInt: String] = [
      // Identifiers and member types
      #line: "X",
      #line: "X<T>",
      #line: "X.Y",
      #line: "X.Y<T>",

      // Metatypes
      #line: "X.Type",
      #line: "X.Protocol",

      // Sugared optionals
      #line: "X?",
      #line: "X!",

      // Sugared collections
      #line: "[X]",
      #line: "[X : Y]",

      // Tuples and paren type
      #line: "()",
      #line: "(X)",
      #line: "(X, X)",

      // Keywords
      #line: "Any",
      #line: "Self",
    ]

    for (line, component) in cases {
      var parser = Parser(component)
      let componentSyntax = TypeSyntax.parse(from: &parser)

      assertParse(
        "\(component) & \(component) & \(component)",
        { TypeSyntax.parse(from: &$0) },
        substructure: CompositionTypeSyntax(
          elements: .init([
            CompositionTypeElementSyntax(type: componentSyntax, ampersand: .binaryOperator("&")),
            CompositionTypeElementSyntax(type: componentSyntax, ampersand: .binaryOperator("&")),
            CompositionTypeElementSyntax(type: componentSyntax),
          ])
        ),
        line: line
      )
    }
  }
}
