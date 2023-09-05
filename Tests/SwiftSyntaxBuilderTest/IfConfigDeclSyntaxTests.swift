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

import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest

final class IfConfigDeclSyntaxTests: XCTestCase {
  func testIfConfigClauseSyntax() {
    let buildable = IfConfigDeclSyntax(
      clauses: IfConfigClauseListSyntax {
        IfConfigClauseSyntax(
          poundKeyword: .poundIfToken(),
          condition: ExprSyntax("DEBUG"),
          elements: .statements(
            CodeBlockItemListSyntax {
              DeclSyntax(
                """
                public func debug(_ data: Foo) -> String {
                  return data.debugDescription
                }
                """
              )
            }
          )
        )
        IfConfigClauseSyntax(
          poundKeyword: .poundElseifToken(),
          condition: ExprSyntax("TEST"),
          elements: .statements(
            CodeBlockItemListSyntax {
              DeclSyntax(
                """
                public func debug(_ data: Foo) -> String {
                  return data.description
                }
                """
              )
            }
          )
        )
        IfConfigClauseSyntax(
          poundKeyword: .poundElseToken(),
          elements: .statements(
            CodeBlockItemListSyntax {
              DeclSyntax(
                """
                public func debug(_ data: Foo) -> String {
                  return data.description
                }
                """
              )
            }
          )
        )
      },
      poundEndif: .poundEndifToken()
    )

    assertBuildResult(
      buildable,
      """
      #if DEBUG
      public func debug(_ data: Foo) -> String {
        return data.debugDescription
      }
      #elseif TEST
      public func debug(_ data: Foo) -> String {
        return data.description
      }
      #else
      public func debug(_ data: Foo) -> String {
        return data.description
      }
      #endif
      """
    )
  }
}
