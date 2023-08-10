//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

extension Parser {
  @_spi(ExperimentalLanguageFeatures)
  public struct ExperimentalFeatures: OptionSet {
    public let rawValue: UInt
    public init(rawValue: UInt) {
      self.rawValue = rawValue
    }
  }
}
