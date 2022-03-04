import SwiftSyntaxBuilder

/// This example will print the following example:
/// 
///```
/// import Foundation
/// import UIKit
/// class SomeViewController{
///    let tableView: UITableView
/// }
///```

let source = SourceFile {
  ImportDecl(path: "Foundation")
  ImportDecl(path: "UIKit")
  ClassDecl(classOrActorKeyword: .class, identifier: "SomeViewController", membersBuilder: {
    VariableDecl(.let, name: "tableView", type: "UITableView")
  })
}

let syntax = source.buildSyntax(format: Format())

var text = ""
syntax.write(to: &text)

print(text)
