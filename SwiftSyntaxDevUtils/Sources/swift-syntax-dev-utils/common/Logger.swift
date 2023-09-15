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

func logSection(_ text: String) {
  print("** \(text) **")
}

extension Process {
  var command: String {
    var message = ""

    for (key, value) in environment?.sorted(by: { $0.key < $1.key }) ?? [] {
      message += "\(key)='\(value)' "
    }

    if let executableURL = executableURL {
      message += executableURL.path
    }

    if let arguments = arguments {
      message += " \(arguments.joined(separator: " "))"
    }

    return message
  }
}
