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
import MacroExamplesInterface

func runMemberAttributeMacrosPlayground() {
  // MARK: - Member Deprecated

  @memberDeprecated
  struct SomeStruct {
    typealias MacroName = String

    var oldProperty: Int = 420

    func oldMethod() {
      print("This is an old method.")
    }
  }

  let someStruct = SomeStruct()

  _ = SomeStruct.MacroName("name")
  _ = someStruct.oldProperty
  someStruct.oldMethod()

  // MARK: - Wrap Stored Properties

  // Use the "wrapStoredProperties" macro to deprecate all of the stored
  // properties.b
  @wrapStoredProperties(#"available(*, deprecated, message: "hands off my data")"#)
  struct OldStorage {
    var x: Int
  }

  // The deprecation warning below comes from the deprecation attribute
  // introduced by @wrapStoredProperties on OldStorage.
  _ = OldStorage(x: 5).x
}
