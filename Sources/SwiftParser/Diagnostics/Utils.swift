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
  func trimmingSpaces() -> String {
    var result: Substring = Substring(self)
    result = result.drop(while: { $0 == " " })
    while result.last == " " {
      result = result.dropLast(1)
    }
    return String(result)
  }
}
