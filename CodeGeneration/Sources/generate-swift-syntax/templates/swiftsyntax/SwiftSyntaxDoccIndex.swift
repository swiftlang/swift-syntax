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

  var nodeKinds: [(SyntaxNodeKind, String)] = [
    (.decl, "Declarations"),
    (.expr, "Expressions"),
    (.pattern, "Patterns"),
    (.stmt, "Statements"),
    (.type, "Types"),
  ]

  for (baseKind, heading) in nodeKinds {
    let baseTypes = ["\(baseKind.syntaxType)", "\(baseKind.syntaxType)Protocol", "Missing\(baseKind.syntaxType)"]
    let leafTypes =
      SYNTAX_NODES
      .filter({ $0.base == baseKind && !$0.kind.isMissing && !$0.isExperimental && !$0.kind.isDeprecated })
      .map(\.kind.syntaxType.description)
    addSection(heading: heading, types: baseTypes + leafTypes)
  }

  addSection(
    heading: "Collections",
    types: [
      "SyntaxChildren",
      "SyntaxChildrenIndex",
    ]
      + SYNTAX_NODES.flatMap({ (node: Node) -> [String] in
        guard let node = node.collectionNode, !node.isExperimental else {
          return []
        }
        return [node.kind.syntaxType.description]
          + node.elementChoices
          .filter { SYNTAX_NODE_MAP[$0] != nil && !SYNTAX_NODE_MAP[$0]!.isExperimental && !$0.isDeprecated }
          .map(\.syntaxType.description)
          .filter { !handledSyntaxTypes.contains($0) }
      })
  )

  addSection(
    heading: "Attributes",
    types: ATTRIBUTE_NODES.filter({ !$0.isExperimental && !$0.kind.isDeprecated }).map(\.kind.syntaxType.description)
      .sorted()
  )

  addSection(
    heading: "Miscellaneous Syntax",
    types: SYNTAX_NODES.filter({ !$0.isExperimental && !$0.kind.isDeprecated }).map(\.kind.syntaxType.description)
      .filter({
        !handledSyntaxTypes.contains($0)
      })
  )

  addSection(heading: "Traits", types: TRAITS.map { "\($0.protocolName)" })

  return result
}()

var contributingDocs: String = {
  let contributingDocsFolder = URL(fileURLWithPath: #filePath)
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .appendingPathComponent("Sources")
    .appendingPathComponent("SwiftSyntax")
    .appendingPathComponent("Documentation.docc")
    .appendingPathComponent("Contributing")

  let files =
    (try? FileManager.default.contentsOfDirectory(at: contributingDocsFolder, includingPropertiesForKeys: nil)) ?? []

  return files.compactMap { file in
    if file.pathExtension != "md" {
      return nil
    }
    let doccName = file.lastPathComponent
      .replacingOccurrences(of: ".md", with: "")
      .replacingOccurrences(of: " ", with: "-")
    return "- <doc:\(doccName)>"
  }.sorted().joined(separator: "\n")
}()

let swiftSyntaxDoccIndex: String = {
  let templateURL = URL(fileURLWithPath: #filePath)
    .deletingLastPathComponent()
    .appendingPathComponent("SwiftSyntaxDoccIndexTemplate.md")
  let template = try! String(contentsOf: templateURL)

  return
    template
    .replacingOccurrences(of: "{{Nodes}}", with: nodesSections)
    .replacingOccurrences(of: "{{ContributingDocs}}", with: contributingDocs)
}()
