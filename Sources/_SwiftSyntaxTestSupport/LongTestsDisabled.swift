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
private import Foundation
#else
import Foundation
#endif

public var longTestsDisabled: Bool {
  if let value = ProcessInfo.processInfo.environment["SKIP_LONG_TESTS"] {
    return value == "1" || value == "YES"
  }
  return false
}
