//===--- ClassifiedSyntaxTreePrinter.swift - Print Syntax colouring info --===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2018 Apple Inc. and the Swift project authors
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
    case .identifier: return ""
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
    var previousClassification: SyntaxClassifiedRange? = nil
    func openTag(_ classify: SyntaxClassifiedRange) {
      result += "<\(classify.kind.tag)>"
      previousClassification = classify
    }
    func closeTag(_ classify: SyntaxClassifiedRange) {
      result += "</\(classify.kind.tag)>"
      previousClassification = nil
    }

    var sourceText = tree.description
    let utf8 = sourceText.utf8
    var curTextPos = utf8.startIndex
    for classify in tree.classifications {
      let classifyBegin = utf8.index(utf8.startIndex, offsetBy: classify.range.offset)
      let classifyEnd = utf8.index(classifyBegin, offsetBy: classify.range.length)
      let classifiedText = String(utf8[classifyBegin..<classifyEnd])!
      let unclassifiedText = String(utf8[curTextPos..<classifyBegin])!

      // Don't print CHECK lines
      var skipCheckLine = false
      if classify.kind == .lineComment && classifiedText.hasPrefix("// CHECK") {
        skipCheckLine = true
        if let previousClassify = previousClassification {
          closeTag(previousClassify)
        }
        result += unclassifiedText

      } else {
        // Try to merge same classification ranges, to make writing tests more convenient.
        if let previousClassify = previousClassification {
          if !unclassifiedText.isEmpty || previousClassify.kind != classify.kind {
            closeTag(previousClassify)
          }
        }
        result += unclassifiedText
        if previousClassification == nil {
          openTag(classify)
        }
        result += "\(classifiedText)"
      }

      curTextPos = classifyEnd
      if skipCheckLine {
        curTextPos = utf8.index(after: curTextPos)
      }
    }

    if let previousClassify = previousClassification {
      closeTag(previousClassify)
    }
    let unclassifiedText = String(utf8[curTextPos..<utf8.endIndex])!
    result += unclassifiedText

    return result
  }
}
