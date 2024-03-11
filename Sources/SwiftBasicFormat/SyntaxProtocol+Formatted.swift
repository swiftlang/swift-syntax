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

#if swift(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

public extension SyntaxProtocol {
  /// Build a syntax node from this `Buildable` and format it with the given format.
  func formatted(using format: BasicFormat = BasicFormat()) -> Syntax {
    format.reset()
    return format.rewrite(self)
  }
}
