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
import XCTest
import _SwiftSyntaxTestSupport

fileprivate func intElement(_ int: Int) -> ArrayElementSyntax {
  let literal = TokenSyntax.integerLiteral("\(int)")
  return ArrayElementSyntax(
    expression: IntegerLiteralExprSyntax(literal: literal),
    trailingComma: .commaToken()
  )
}

fileprivate func assertSyntaxCollectionManipulation(
  initialElements: [Int],
  transformation: (_ array: inout ArrayExprSyntax) -> Void,
  expectedElements: [Int],
  file: StaticString = #filePath,
  line: UInt = #line
) {
  var modifiedArray = ArrayExprSyntax {
    for initialElement in initialElements {
      intElement(initialElement)
    }
  }

  transformation(&modifiedArray)

  let expectedArray = ArrayExprSyntax {
    for expectedElement in expectedElements {
      intElement(expectedElement)
    }
  }

  do {
    let subtreeMatcher = SubtreeMatcher(modifiedArray, markers: [:])
    try subtreeMatcher.assertSameStructure(
      expectedArray,
      includeTrivia: true,
      file: file,
      line: line
    )
  } catch {
    XCTFail("Matching for a subtree failed with error: \(error)", file: file, line: line)
  }
}

class SyntaxCollectionsTests: XCTestCase {
  public func testAppendElement() {
    assertSyntaxCollectionManipulation(
      initialElements: [0],
      transformation: {
        $0.elements.append(intElement(1))
      },
      expectedElements: [0, 1]
    )
  }

  public func testAppendMultipleElement() {
    assertSyntaxCollectionManipulation(
      initialElements: [0],
      transformation: {
        $0.elements.append(contentsOf: [intElement(1), intElement(2)])
      },
      expectedElements: [0, 1, 2]
    )
  }

  public func testInsertElement() {
    assertSyntaxCollectionManipulation(
      initialElements: [0, 1, 2],
      transformation: {
        let index = $0.elements.startIndex
        $0.elements.insert(intElement(5), at: index)
      },
      expectedElements: [5, 0, 1, 2]
    )

    assertSyntaxCollectionManipulation(
      initialElements: [0, 1, 2],
      transformation: {
        let index = $0.elements.index(at: 1)
        $0.elements.insert(intElement(5), at: index)
      },
      expectedElements: [0, 5, 1, 2]
    )

    assertSyntaxCollectionManipulation(
      initialElements: [0, 1, 2],
      transformation: {
        let index = $0.elements.endIndex
        $0.elements.insert(intElement(5), at: index)
      },
      expectedElements: [0, 1, 2, 5]
    )
  }

  public func testInsertMultipleElements() {
    assertSyntaxCollectionManipulation(
      initialElements: [0, 1, 2],
      transformation: {
        let index = $0.elements.startIndex
        $0.elements.insert(contentsOf: [intElement(5), intElement(6)], at: index)
      },
      expectedElements: [5, 6, 0, 1, 2]
    )

    assertSyntaxCollectionManipulation(
      initialElements: [0, 1, 2],
      transformation: {
        let index = $0.elements.index(at: 1)
        $0.elements.insert(contentsOf: [intElement(5), intElement(6)], at: index)
      },
      expectedElements: [0, 5, 6, 1, 2]
    )

    assertSyntaxCollectionManipulation(
      initialElements: [0, 1, 2],
      transformation: {
        let index = $0.elements.endIndex
        $0.elements.insert(contentsOf: [intElement(5), intElement(6)], at: index)
      },
      expectedElements: [0, 1, 2, 5, 6]
    )
  }

  public func testRemoveElement() {
    assertSyntaxCollectionManipulation(
      initialElements: [0, 1, 2],
      transformation: {
        let index = $0.elements.startIndex
        $0.elements.remove(at: index)
      },
      expectedElements: [1, 2]
    )

    assertSyntaxCollectionManipulation(
      initialElements: [0, 1, 2],
      transformation: {
        let index = $0.elements.index(at: 1)
        $0.elements.remove(at: index)
      },
      expectedElements: [0, 2]
    )

    assertSyntaxCollectionManipulation(
      initialElements: [0, 1, 2],
      transformation: {
        let index = $0.elements.index(at: 2)
        $0.elements.remove(at: index)
      },
      expectedElements: [0, 1]
    )
  }

  public func testRemoveSubrange() {
    assertSyntaxCollectionManipulation(
      initialElements: [0, 1, 2],
      transformation: {
        let startIndex = $0.elements.startIndex
        let endIndex = $0.elements.index(at: 1)
        $0.elements.removeSubrange(startIndex..<endIndex)
      },
      expectedElements: [1, 2]
    )

    assertSyntaxCollectionManipulation(
      initialElements: [0, 1, 2],
      transformation: {
        let startIndex = $0.elements.startIndex
        let endIndex = $0.elements.index(at: 2)
        $0.elements.removeSubrange(startIndex..<endIndex)
      },
      expectedElements: [2]
    )

    assertSyntaxCollectionManipulation(
      initialElements: [0, 1, 2],
      transformation: {
        let startIndex = $0.elements.startIndex
        let endIndex = $0.elements.endIndex
        $0.elements.removeSubrange(startIndex..<endIndex)
      },
      expectedElements: []
    )
  }

  public func testAddSequenceAtEnd() {
    assertSyntaxCollectionManipulation(
      initialElements: [0],
      transformation: {
        let newElements = (1...2).lazy.map({ intElement($0) })
        $0.elements = $0.elements + newElements
      },
      expectedElements: [0, 1, 2]
    )
  }

  public func testAddArrayAtEnd() {
    assertSyntaxCollectionManipulation(
      initialElements: [0],
      transformation: {
        let newElements = [intElement(1), intElement(2)]
        $0.elements = $0.elements + newElements
      },
      expectedElements: [0, 1, 2]
    )
  }

  public func testAddSequenceAtStart() {
    assertSyntaxCollectionManipulation(
      initialElements: [0],
      transformation: {
        let newElements = (1...2).lazy.map({ intElement($0) })
        $0.elements = newElements + $0.elements
      },
      expectedElements: [1, 2, 0]
    )
  }

  public func testAddArrayAtStart() {
    assertSyntaxCollectionManipulation(
      initialElements: [0],
      transformation: {
        let newElements = [intElement(1), intElement(2)]
        $0.elements = newElements + $0.elements
      },
      expectedElements: [1, 2, 0]
    )
  }

  func testPlusEquals() {
    assertSyntaxCollectionManipulation(
      initialElements: [0],
      transformation: {
        let newElements = [intElement(1), intElement(2)]
        $0.elements += newElements
      },
      expectedElements: [0, 1, 2]
    )
  }

  public func testFilter() {
    let elements = ArrayElementListSyntax([
      intElement(0),
      intElement(1),
      intElement(2),
    ])
    let array = ArrayExprSyntax(elements: elements)

    let filteredElements = array.elements.filter { _ in true }
    // The filtered sequence should have the `ArrayExprSyntax` as a parent
    XCTAssert(filteredElements.parent?.is(ArrayExprSyntax.self) ?? false)
  }
}
