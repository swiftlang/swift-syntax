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

import SwiftSyntax

public struct Format {
  public let indentWidth: Int

  private var indents: Int = 0

  public init(indentWidth: Int = 4) {
    self.indentWidth = indentWidth
  }
}

extension Format {
  public func _indented() -> Format {
    var copy = self
    copy.indents += 1
    return copy
  }

  public func _makeIndent() -> Trivia {
    return indents == 0 ? .zero : Trivia.spaces(indents * indentWidth)
  }
}
