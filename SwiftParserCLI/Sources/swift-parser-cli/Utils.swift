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

import Foundation

func getContentsOfSourceFile(at path: String?) throws -> [UInt8] {
  let source: Data
  if let path {
    let sourceURL = URL(fileURLWithPath: path)
    source = try Data(contentsOf: sourceURL)
  } else {
    source = FileHandle.standardInput.readDataToEndOfFile()
  }
  return [UInt8](source)
}

/// Print the given message to stderr
func printerr(_ message: String, terminator: String = "\n") {
  FileHandle.standardError.write((message + terminator).data(using: .utf8)!)
}
