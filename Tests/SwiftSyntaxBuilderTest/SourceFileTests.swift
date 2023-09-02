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

final class SourceFileTests: XCTestCase {
  func testSourceFile() {
    let source = SourceFileSyntax {
      DeclSyntax("import Foundation")
      DeclSyntax("import UIKit")
      ClassDeclSyntax(
        classKeyword: .keyword(.class),
        name: "SomeViewController",
        memberBlockBuilder: {
          DeclSyntax("let tableView: UITableView")
        }
      )
    }

    assertBuildResult(
      source,
      """
      import Foundation
      import UIKit
      class SomeViewController {
          let tableView: UITableView
      }
      """,
      trimTrailingWhitespace: false
    )
  }
}
