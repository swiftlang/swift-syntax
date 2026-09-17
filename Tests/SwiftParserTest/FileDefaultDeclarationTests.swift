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

@_spi(ExperimentalLanguageFeatures) import SwiftParser
@_spi(ExperimentalLanguageFeatures) import SwiftSyntax
import XCTest

final class FileDefaultDeclarationTests: ParserTestCase {
  override var languageFeatures: Parser.LanguageFeatures {
    [.defaultIsolationPerFile]
  }

  func testSpecifiers() {
    assertParse(
      "default @MainActor",
      substructure: FileDefaultDeclSyntax(
        defaultKeyword: .keyword(.default),
        specifier: .attribute(
          AttributeSyntax(
            attributeName: IdentifierTypeSyntax(
              name: .identifier("MainActor")
            )
          )
        )
      )
    )

    assertParse(
      "default nonisolated",
      substructure: FileDefaultDeclSyntax(
        defaultKeyword: .keyword(.default),
        specifier: .modifier(.identifier("nonisolated"))
      )
    )

    // Which specifiers are valid is only known to ASTGen.
    assertParse(
      "default @Test",
      substructure: FileDefaultDeclSyntax(
        defaultKeyword: .keyword(.default),
        specifier: .attribute(
          AttributeSyntax(
            attributeName: IdentifierTypeSyntax(
              name: .identifier("Test")
            )
          )
        )
      )
    )

    assertParse(
      "default test",
      substructure: FileDefaultDeclSyntax(
        defaultKeyword: .keyword(.default),
        specifier: .modifier(.identifier("test"))
      )
    )

    assertParse(
      "default @diagnose(DiagGroupID, as: error)",
      substructure: FileDefaultDeclSyntax(
        defaultKeyword: .keyword(.default),
        specifier: .attribute(
          AttributeSyntax(
            attributeName: IdentifierTypeSyntax(
              name: .identifier("diagnose")
            ),
            leftParen: .leftParenToken(),
            arguments: .argumentList(
              LabeledExprListSyntax([
                LabeledExprSyntax(
                  expression: DeclReferenceExprSyntax(
                    baseName: .identifier("DiagGroupID")
                  ),
                  trailingComma: .commaToken()
                ),
                LabeledExprSyntax(
                  label: .identifier("as"),
                  colon: .colonToken(),
                  expression: DeclReferenceExprSyntax(
                    baseName: .identifier("error")
                  )
                ),
              ])
            ),
            rightParen: .rightParenToken()
          )
        )
      )
    )

    assertParse("default @available(*, deprecated, message: \"deprecation message\")")
  }

  func testBacktickedSpecifier() {
    assertParse(
      "default `nonisolated`",
      substructure: FileDefaultDeclSyntax(
        defaultKeyword: .keyword(.default),
        specifier: .modifier(.identifier("`nonisolated`"))
      )
    )
  }

  func testTerminatesAfterSpecifier() {
    assertParse("foo(); default nonisolated; foo()")

    assertParse(
      "default @diagnose(StrictMemorySafety, as: error)1️⃣ func frog() {}",
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      fixedSource: """
        default @diagnose(StrictMemorySafety, as: error)
        func frog() {}
        """
    )
  }

  func testSpecifierMustBeOnSameLine() {
    assertParse(
      """
      default1️⃣
      @MainActor func foo() {}
      """,
      substructure: FileDefaultDeclSyntax(
        defaultKeyword: .keyword(.default),
        specifier: .modifier(.identifier("", presence: .missing))
      ),
      diagnostics: [
        DiagnosticSpec(
          message: "expected identifier in file-level default",
          fixIts: ["insert identifier"]
        )
      ],
      fixedSource: """
        default <#identifier#>
        @MainActor func foo() {}
        """
    )

    assertParse(
      """
      default1️⃣
      nonisolated func bar() {}
      """,
      substructure: FileDefaultDeclSyntax(
        defaultKeyword: .keyword(.default),
        specifier: .modifier(.identifier("", presence: .missing))
      ),
      diagnostics: [
        DiagnosticSpec(
          message: "expected identifier in file-level default",
          fixIts: ["insert identifier"]
        )
      ],
      fixedSource: """
        default <#identifier#>
        nonisolated func bar() {}
        """
    )

    assertParse(
      "default1️⃣",
      substructure: FileDefaultDeclSyntax(
        defaultKeyword: .keyword(.default),
        specifier: .modifier(.identifier("", presence: .missing))
      ),
      diagnostics: [
        DiagnosticSpec(
          message: "expected identifier in file-level default",
          fixIts: ["insert identifier"]
        )
      ],
      fixedSource: "default <#identifier#>"
    )
  }

  func testInvalidSpecifier() {
    assertParse(
      "default 1️⃣func bizarre() {}",
      substructure: FileDefaultDeclSyntax(
        defaultKeyword: .keyword(.default),
        specifier: .modifier(.identifier("", presence: .missing))
      ),
      diagnostics: [
        DiagnosticSpec(
          message: "expected identifier in file-level default",
          fixIts: ["insert identifier"]
        )
      ],
      fixedSource: "default <#identifier#>func bizarre() {}"
    )

    assertParse(
      "default 1️⃣break",
      substructure: FileDefaultDeclSyntax(
        defaultKeyword: .keyword(.default),
        specifier: .modifier(.identifier("", presence: .missing))
      ),
      diagnostics: [
        DiagnosticSpec(
          message: "expected identifier in file-level default",
          fixIts: ["insert identifier"]
        )
      ],
      fixedSource: "default <#identifier#>break"
    )

    assertParse(
      "default 1️⃣= @MainActor2️⃣",
      substructure: FileDefaultDeclSyntax(
        defaultKeyword: .keyword(.default),
        specifier: .modifier(.identifier("", presence: .missing))
      ),
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected identifier in file-level default",
          fixIts: ["insert identifier"]
        ),
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '=' in source file"),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected declaration after attribute",
          fixIts: ["insert declaration"]
        ),
      ],
      fixedSource: "default <#identifier#>= @MainActor <#declaration#>"
    )
  }

  func testColonMeansSwitchLabel() {
    assertParse(
      "1️⃣default: foo",
      diagnostics: [
        DiagnosticSpec(message: "'default' label can only appear inside a 'switch' statement")
      ]
    )

    assertParse(
      "1️⃣default: break",
      diagnostics: [
        DiagnosticSpec(message: "'default' label can only appear inside a 'switch' statement")
      ]
    )

    assertParse(
      "1️⃣default: @MainActor",
      diagnostics: [
        DiagnosticSpec(message: "'default' label can only appear inside a 'switch' statement")
      ]
    )

    assertParse(
      "1️⃣default: nonisolated",
      diagnostics: [
        DiagnosticSpec(message: "'default' label can only appear inside a 'switch' statement")
      ]
    )

    assertParse(
      """
      1️⃣default:
        foo()
      """,
      diagnostics: [
        DiagnosticSpec(message: "'default' label can only appear inside a 'switch' statement")
      ]
    )

    assertParse(
      "1️⃣@unknown default: foo",
      diagnostics: [
        DiagnosticSpec(message: "'default' label can only appear inside a 'switch' statement")
      ]
    )

    assertParse(
      """
      1️⃣default
      : nonisolated
      """,
      diagnostics: [
        DiagnosticSpec(message: "'default' label can only appear inside a 'switch' statement")
      ]
    )
  }

  func testRejectedAttributesAndModifiers() {
    assertParse(
      "1️⃣private default @MainActor",
      substructure: FileDefaultDeclSyntax(
        UnexpectedNodesSyntax([
          Syntax(DeclModifierSyntax(name: .keyword(.private)))
        ]),
        defaultKeyword: .keyword(.default),
        specifier: .attribute(
          AttributeSyntax(
            attributeName: IdentifierTypeSyntax(
              name: .identifier("MainActor")
            )
          )
        )
      ),
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'private' before file-level default")
      ]
    )

    assertParse(
      """
      1️⃣@MainActor
      default nonisolated
      """,
      substructure: FileDefaultDeclSyntax(
        UnexpectedNodesSyntax([
          Syntax(
            AttributeSyntax(
              atSign: .atSignToken(),
              attributeName: TypeSyntax(IdentifierTypeSyntax(name: .identifier("MainActor")))
            )
          )
        ]),
        defaultKeyword: .keyword(.default),
        specifier: .modifier(.identifier("nonisolated"))
      ),
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '@MainActor' before file-level default")
      ]
    )
  }

  func testInsideSwitch() {
    assertParse(
      """
      switch x {
      case 1: break
      @unknown default: break
      }
      """
    )

    assertParse(
      """
      switch x {
      case 1: break
      default: nonisolated
      }
      """
    )

    assertParse(
      """
      switch x {
      case 1: break
      default1️⃣ nonisolated
      }
      """,
      substructure: SwitchDefaultLabelSyntax(
        defaultKeyword: .keyword(.default),
        colon: .colonToken(presence: .missing)
      ),
      diagnostics: [
        DiagnosticSpec(message: "expected ':' in switch case", fixIts: ["insert ':'"])
      ],
      fixedSource: """
        switch x {
        case 1: break
        default: nonisolated
        }
        """
    )

    assertParse(
      """
      switch x {
      case 1: break
      default1️⃣ @MainActor2️⃣
      }
      """,
      substructure: SwitchDefaultLabelSyntax(
        defaultKeyword: .keyword(.default),
        colon: .colonToken(presence: .missing)
      ),
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ':' in switch case", fixIts: ["insert ':'"]),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected label in switch case",
          fixIts: ["insert label"]
        ),
      ],
      fixedSource: """
        switch x {
        case 1: break
        default: @MainActor case <#identifier#>:
        }
        """
    )
  }

  func testMemberBlock() {
    assertParse(
      """
      struct S {
        default @MainActor
      }
      """,
      substructure: FileDefaultDeclSyntax(
        defaultKeyword: .keyword(.default),
        specifier: .attribute(
          AttributeSyntax(
            attributeName: IdentifierTypeSyntax(
              name: .identifier("MainActor")
            )
          )
        )
      )
    )

    assertParse(
      """
      struct S {
        1️⃣default: func lamb() {}
      }
      """,
      substructure: UnexpectedCodeDeclSyntax(
        unexpectedCode: UnexpectedNodesSyntax([TokenSyntax.keyword(.default), TokenSyntax.colonToken()])
      ),
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'default:' in struct")
      ]
    )
  }

  func testNestedContexts() {
    let mainActorDefault = FileDefaultDeclSyntax(
      defaultKeyword: .keyword(.default),
      specifier: .attribute(
        AttributeSyntax(
          attributeName: IdentifierTypeSyntax(
            name: .identifier("MainActor")
          )
        )
      )
    )

    assertParse(
      """
      do {
        default @MainActor
      }
      """,
      substructure: mainActorDefault
    )

    assertParse(
      """
      func test() {
        default @MainActor
      }
      """,
      substructure: mainActorDefault
    )

    assertParse(
      """
      struct S {
        var x: Int {
          default @MainActor
        }
      }
      """,
      substructure: mainActorDefault
    )

    assertParse(
      """
      let c = {
        default @MainActor
      }
      """,
      substructure: mainActorDefault
    )

    assertParse(
      """
      func test() {
        default1️⃣
      }
      """,
      substructure: FileDefaultDeclSyntax(
        defaultKeyword: .keyword(.default),
        specifier: .modifier(.identifier("", presence: .missing))
      ),
      diagnostics: [
        DiagnosticSpec(
          message: "expected identifier in file-level default",
          fixIts: ["insert identifier"]
        )
      ],
      fixedSource: """
        func test() {
          default <#identifier#>
        }
        """
    )

    assertParse(
      """
      do {
        1️⃣default: nonisolated
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'default' label can only appear inside a 'switch' statement")
      ]
    )

    assertParse(
      """
      func test() {
        1️⃣default: nonisolated
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'default' label can only appear inside a 'switch' statement")
      ]
    )

    assertParse(
      """
      struct S {
        var x: Int {
          1️⃣default: nonisolated
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'default' label can only appear inside a 'switch' statement")
      ]
    )

    assertParse(
      """
      let c = {
        1️⃣default: nonisolated
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'default' label can only appear inside a 'switch' statement")
      ]
    )
  }
}

final class FileDefaultDeclarationWithoutFeatureTests: ParserTestCase {
  func testDefaultIsOnlyASwitchLabel() {
    assertParse(
      "1️⃣default @MainActor",
      diagnostics: [
        DiagnosticSpec(message: "'default' label can only appear inside a 'switch' statement")
      ]
    )

    assertParse(
      "1️⃣default nonisolated",
      diagnostics: [
        DiagnosticSpec(message: "'default' label can only appear inside a 'switch' statement")
      ]
    )

    assertParse(
      "1️⃣default: nonisolated",
      diagnostics: [
        DiagnosticSpec(message: "'default' label can only appear inside a 'switch' statement")
      ]
    )
  }
}
