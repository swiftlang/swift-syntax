//===--- ClassifiedSyntaxTreePrinter.swift - Print Syntax colouring info --===//
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

import SwiftSyntax
import Foundation

extension SyntaxClassification {
  var tag: String {
    switch self {
    case .none: return ""
    case .keyword: return "kw"
    case .identifier: return "id"
    case .typeIdentifier: return "type"
    case .dollarIdentifier: return "dollar"
    case .integerLiteral: return "int"
    case .floatingLiteral: return "float"
    case .stringLiteral: return "str"
    case .stringInterpolationAnchor: return "anchor"
    case .poundDirectiveKeyword: return "#kw"
    case .buildConfigId: return "#id"
    case .attribute: return "attr-builtin"
    case .objectLiteral: return "object-literal"
    case .editorPlaceholder: return "placeholder"
    case .lineComment: return "comment-line"
    case .blockComment: return "comment-block"
    case .docLineComment: return "doc-comment-line"
    case .docBlockComment: return "doc-comment-block"
    }
  }
}

enum ClassifiedSyntaxTreePrinter {
  static func print(_ tree: Syntax) -> String {
    var result = ""
    let sourceText = tree.description
    let utf8 = sourceText.utf8
    var skipCheckLine = false
    for classify in tree.classifications {
      var classifyBegin = utf8.index(utf8.startIndex, offsetBy: classify.range.offset)
      let classifyEnd = utf8.index(classifyBegin, offsetBy: classify.range.length)
      if skipCheckLine {
        skipCheckLine = false
        classifyBegin = utf8.index(after: classifyBegin)
      }
      let text = String(utf8[classifyBegin..<classifyEnd])!

      // Don't print CHECK lines
      if classify.kind == .lineComment && text.hasPrefix("// CHECK") {
        skipCheckLine = true
        continue
      }
      if classify.kind == .none {
        result += text
      } else {
        result += "<\(classify.kind.tag)>\(text)</\(classify.kind.tag)>"
      }
    }

    return result
  }
}
