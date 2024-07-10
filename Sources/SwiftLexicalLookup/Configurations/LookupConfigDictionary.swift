//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

/// Stores and provides easy access for lookup configuration.
@_spi(Experimental) public struct LookupConfigDictionary {
  private var dictionary: [ObjectIdentifier: LookupConfig]

  /// Creates a new lookup configuration dictionary
  /// from a given array of configurations.
  init(from configArray: [LookupConfig]) {
    dictionary = [:]

    for config in configArray {
      dictionary[config.identifier] = config
    }
  }

  subscript<T: LookupConfig>(key: T.Type) -> T? {
    get {
      return dictionary[ObjectIdentifier(key)] as? T
    }
    set {
      dictionary[ObjectIdentifier(key)] = newValue
    }
  }
}
