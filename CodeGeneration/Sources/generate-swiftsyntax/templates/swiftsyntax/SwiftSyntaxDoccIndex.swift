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

import Foundation
import SyntaxSupport

let nodesSections: String = {
  var result = ""
  var handledSyntaxTypes: Set<String> = []

  func addSection(heading: String, types: [String]) {
    handledSyntaxTypes.formUnion(types)
    result += "### \(heading)\n\n"

    for type in types {
      result += "- <doc:SwiftSyntax/\(type)>\n"
    }
    result += "\n"
  }

  var nodeKinds = [
    ("Decl", "Declarations"),
    ("Expr", "Expressions"),
    ("Pattern", "Patterns"),
    ("Stmt", "Statements"),
    ("Type", "Types"),
  ]

  for (baseKind, heading) in nodeKinds {
    let baseTypes = ["\(baseKind)Syntax", "\(baseKind)SyntaxProtocol", "Missing\(baseKind)Syntax"]
    let leafTypes = SYNTAX_NODES.filter({ $0.baseKind == baseKind && !$0.isMissing }).map(\.name)
    addSection(heading: heading, types: baseTypes + leafTypes)
  }

  addSection(
    heading: "Collections",
    types: [
      "SyntaxChildren",
      "SyntaxChildrenIndex",
      "SyntaxChildrenIndexData",
    ]
      + SYNTAX_NODES.flatMap({ (node: Node) -> [String] in
        guard node.isSyntaxCollection else {
          return []
        }
        if !handledSyntaxTypes.contains(node.collectionElement) && SYNTAX_NODE_MAP[node.collectionElement] != nil {
          return ["\(node.name)", "\(node.collectionElement)Syntax"]
        } else {
          return ["\(node.name)"]
        }
      })
  )

  addSection(heading: "Miscellaneous Syntax", types: SYNTAX_NODES.map(\.name).filter({ !handledSyntaxTypes.contains($0) }))

  addSection(heading: "Traits", types: TRAITS.map(\.traitName))

  return result
}()

let swiftSyntaxDoccIndex: String = {
  let templateURL = URL(fileURLWithPath: #filePath).deletingLastPathComponent().appendingPathComponent("SwiftSyntaxDoccIndexTemplate.md")
  let template = try! String(contentsOf: templateURL)

  return template.replacingOccurrences(of: "{{Nodes}}", with: nodesSections)
}()
