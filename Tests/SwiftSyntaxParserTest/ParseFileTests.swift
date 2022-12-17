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
import SwiftSyntaxParser

fileprivate struct Foo {
  public let x: Int
  private(set) var y: [Bool]
}

#if os(macOS)
fileprivate class Test: NSObject {
  @objc var bar: Int = 0
  func test() {
    print(#selector(function))
    print(#keyPath(bar))
  }
  @objc func function() {
  }
}
#endif

enum Animal {
  case cat
  case dog
}

public class ParseFileTests: XCTestCase {

  public func testParseSingleFile() {
    let currentFile = URL(fileURLWithPath: #file)
    XCTAssertNoThrow(
      try {
        let fileContents = try String(contentsOf: currentFile)
        let parsed = try SyntaxParser.parse(currentFile)
        XCTAssertEqual("\(parsed)", fileContents)
      }()
    )
  }

  public func testEnumCaseStructure() {
    class Visitor: SyntaxVisitor {
      var cases: [EnumCaseDeclSyntax] = []
      override func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
        cases.append(
          contentsOf: node.members.members.compactMap {
            $0.decl.as(EnumCaseDeclSyntax.self)
          }
        )
        return .skipChildren
      }
    }
    let v = Visitor(viewMode: .fixedUp)
    let currentFile = URL(fileURLWithPath: #file)
    let parsed = try! SyntaxParser.parse(currentFile)
    v.walk(parsed)
    XCTAssertEqual(v.cases.count, 2)
  }
}
