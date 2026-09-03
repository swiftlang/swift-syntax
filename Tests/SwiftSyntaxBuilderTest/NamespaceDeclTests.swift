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

@_spi(ExperimentalLanguageFeatures) import SwiftSyntax
@_spi(ExperimentalLanguageFeatures) import SwiftSyntaxBuilder
import XCTest

final class NamespaceDeclTests: XCTestCase {
  func testNamespaceDeclBuilder() {
    let declaration = NamespaceDeclSyntax(name: "HTTP") {
      StructDeclSyntax(name: "Request") {}
    }

    assertBuildResult(
      declaration,
      """
      namespace HTTP {
          struct Request {
          }
      }
      """
    )
  }

  func testNestedNamespaceDeclBuilder() {
    let declaration = NamespaceDeclSyntax(name: "Network") {
      NamespaceDeclSyntax(name: "HTTP") {}
    }

    assertBuildResult(
      declaration,
      """
      namespace Network {
          namespace HTTP {
          }
      }
      """
    )
  }

  func testNamespaceDeclRewriterDispatch() {
    final class NamespaceRenamer: SyntaxRewriter {
      override func visit(_ node: NamespaceDeclSyntax) -> DeclSyntax {
        DeclSyntax(node.with(\.name, .identifier("Transport")))
      }
    }

    let declaration = NamespaceDeclSyntax(name: "HTTP") {}
    let rewritten = NamespaceRenamer(viewMode: .sourceAccurate).rewrite(declaration)

    assertBuildResult(
      rewritten,
      """
      namespace Transport {
      }
      """
    )
  }
}
