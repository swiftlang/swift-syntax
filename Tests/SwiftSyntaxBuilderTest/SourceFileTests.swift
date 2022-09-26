import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class SourceFileTests: XCTestCase {
  func testSourceFile() {
    let source = SourceFile {
      ImportDecl(path: "Foundation")
      ImportDecl(path: "UIKit")
      ClassDecl(classKeyword: .class, identifier: "SomeViewController", membersBuilder: {
        VariableDecl(.let, name: "tableView", type: "UITableView")
      })
    }

    let syntax = source.buildSyntax()

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """

      import Foundation
      import UIKit
      class SomeViewController {
          let tableView: UITableView
      }
      """)
  }
}
