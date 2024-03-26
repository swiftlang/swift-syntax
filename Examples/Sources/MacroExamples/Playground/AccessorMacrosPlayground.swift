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

// MARK: - EnvironmentValue Accessor

import MacroExamplesInterface

#if canImport(SwiftUI)

import SwiftUI

private struct MyEnvironmentKey: EnvironmentKey {
  static let defaultValue: String = "Default value"
}

extension EnvironmentValues {
  @EnvironmentValue(for: MyEnvironmentKey.self)
  var myCustomValue: String
}

func runEnvironmentValueAccessorMacroPlayground() {
  var environmentValues = EnvironmentValues()
  print("Default myCustomValue: \(environmentValues.myCustomValue)")
  environmentValues.myCustomValue = "New value"
  print("New myCustomValue: \(environmentValues.myCustomValue)")
}

#endif
