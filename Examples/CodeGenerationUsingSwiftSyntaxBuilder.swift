import SwiftSyntaxBuilder

/// This example will print the following code:
///
/// ```
/// import Foundation
/// import UIKit
/// class SomeViewController{
///    let tableView: UITableView
/// }
/// ```
///
@main
struct Main {
  static func main() {
    let source = SourceFile {
      ImportDecl(path: "Foundation")
      ImportDecl(path: "UIKit")
      ClassDecl(identifier: "SomeViewController") {
        VariableDecl(.let, name: "tableView", type: "UITableView")
      }
    }

    let syntax = source.build()

    var text = ""
    syntax.write(to: &text)

    print(text)
  }
}
