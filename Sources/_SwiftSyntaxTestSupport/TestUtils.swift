//===--------- TestUtils.swift - Syntax Parsing ---------------------------===//
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
//
// Various utilities to aid in syntax tree testing.
//
//===----------------------------------------------------------------------===//

import Foundation

public func getTestInput(_ file: String, baseFile: String = #file) -> URL {
  var result = URL(fileURLWithPath: baseFile)
  result.deleteLastPathComponent()
  result.appendPathComponent("Inputs")
  result.appendPathComponent(file)
  return result
}
