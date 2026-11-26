//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax
import XCTest

final class AccessorBlockTests: ParserTestCase {
  func testAccessorBlockDisambiguationMarker() {
    assertParse(
      """
      var value = initialValue { @_accessorBlock
        get
      }
      """,
      substructure: VariableDeclSyntax(
        bindingSpecifier: .keyword(.var),
        bindings: [
          PatternBindingSyntax(
            pattern: IdentifierPatternSyntax(identifier: .identifier("value")),
            initializer: InitializerClauseSyntax(
              value: DeclReferenceExprSyntax(baseName: .identifier("initialValue"))
            ),
            accessorBlock: AccessorBlockSyntax(
              leftBrace: .leftBraceToken(),
              accessors: .accessors([
                AccessorDeclSyntax(
                  attributes: [
                    .attribute(
                      AttributeSyntax(
                        atSign: .atSignToken(),
                        attributeName: IdentifierTypeSyntax(name: .identifier("_accessorBlock"))
                      )
                    )
                  ],
                  accessorSpecifier: .keyword(.get)
                )
              ])
            )
          )
        ]
      )
    )
  }

  func testAccessorBlockAfterPatternBindingDeclWithAttribute() {
    assertParse(
      """
      var x: Int = foo()
      {
        @available(*, deprecated)
        didSet {}
      }
      """
    )
  }
}
