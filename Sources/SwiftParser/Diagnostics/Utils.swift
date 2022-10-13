//===--- Utils.swift ------------------------------------------------------===//
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

extension String {
  /// Remove any leading or trailing spaces.
  /// This is necessary to avoid depending SwiftParser on Foundation.
  func trimmingWhitespace() -> String {
    let charactersToDrop: [Character] = [" ", "\t", "\n", "\r"]
    var result: Substring = Substring(self)
    result = result.drop(while: { charactersToDrop.contains($0) })
    while let lastCharacter = result.last, charactersToDrop.contains(lastCharacter) {
      result = result.dropLast(1)
    }
    return String(result)
  }
}

extension Collection {
  /// If the collection contains a single element, return it, otherwise `nil`.
  var only: Element? {
    if !isEmpty && index(after: startIndex) == endIndex {
      return self.first!
    } else {
      return nil
    }
  }
}
