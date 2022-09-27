//===--- ParserIntegration.swift ------------------------------------------===//
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

import SwiftParser
import SwiftBasicFormat

/// Make `SyntaxBuildable` nodes participate in SyntaxStringInterpolation
public extension SyntaxStringInterpolation {
  mutating func appendInterpolation<Buildable: SyntaxBuildable>(
    _ buildable: Buildable
  ) {
    self.appendInterpolation(buildable.buildSyntax())
  }
}
