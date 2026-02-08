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

import SwiftParser
import SwiftRefactor
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest
import _SwiftSyntaxTestSupport

final class MoveMembersToExtensionTests: XCTestCase {
  func testMoveFunctionToExtension() throws {
    let baseline: String = """
      class Foo {1️⃣
        func foo() {
          print("Hello world!")
        }2️⃣

        func bar() {
          print("Hello world!")
        }
      }
      """

    let expected: SourceFileSyntax = """
      class Foo {

        func bar() {
          print("Hello world!")
        }
      }

      extension Foo {
        func foo() {
          print("Hello world!")
        }
      }
      """

    let (markers, source) = extractMarkers(baseline)

    var parser = Parser(source)
    let tree = SourceFileSyntax.parse(from: &parser)
    let context = makeContextFromClass(markers: markers, source: tree)
    try assertRefactorConvert(tree, expected: expected, context: context)
  }
}

private func makeContextFromClass(markers: [String: Int], source: SourceFileSyntax) -> MoveMembersToExtension.Context {
  let classDecl = source.statements
    .first(where: { $0.item.is(ClassDeclSyntax.self) })!
    .item.cast(ClassDeclSyntax.self)
  let members = classDecl.memberBlock.members

  let selectedMembersId: [SyntaxIdentifier] = members.compactMap({
    let offset = $0.positionAfterSkippingLeadingTrivia.utf8Offset
    if let start = markers["1️⃣"], let end = markers["2️⃣"], offset > start && offset < end {
      return $0.id
    }
    return nil
  })

  return MoveMembersToExtension.Context(declName: classDecl.name, selectedIdentifiers: selectedMembersId)
}

private func assertRefactorConvert(
  _ callDecl: SourceFileSyntax,
  expected: SourceFileSyntax?,
  context: MoveMembersToExtension.Context,
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  try assertRefactor(
    callDecl,
    context: context,
    provider: MoveMembersToExtension.self,
    expected: expected,
    file: file,
    line: line
  )
}
