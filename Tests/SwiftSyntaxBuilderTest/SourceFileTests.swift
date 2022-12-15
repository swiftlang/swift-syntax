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

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class SourceFileTests: XCTestCase {
  func testSourceFile() {
    let source = SourceFile {
      ImportDecl("import Foundation")
      ImportDecl("import UIKit")
      ClassDecl(
        classKeyword: .class,
        identifier: "SomeViewController",
        membersBuilder: {
          VariableDecl("let tableView: UITableView")
        }
      )
    }

    AssertBuildResult(
      source,
      """

      import Foundation
      import UIKit
      class SomeViewController {
          let tableView: UITableView
      }
      """
    )
  }
}
