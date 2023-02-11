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

@_spi(Testing) import SwiftParser

func withParser<T>(source: String, _ body: (inout Parser) throws -> T) rethrows -> T {
  var source = source
  return try source.withUTF8 { buffer in
    var parser = Parser(buffer)
    return try body(&parser)
  }
}
