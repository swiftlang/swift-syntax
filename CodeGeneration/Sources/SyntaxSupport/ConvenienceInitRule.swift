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
import SwiftSyntax

/// A rule that describes convenienve initialization rules for a ``Node``.
///
/// When generating syntax nodes, SwiftSyntax will make additional
/// convenience initializer for each rule that a Node has.
///
/// The convenience initializer will take a non-optional parameter
/// `nonOptionalChildName`, and when a non-optional value is passed, it'll call
/// the full memberwise initializer with the provided `defaults`.
///
/// For example, when initializing an `EnumCaseParameterSyntax`, the convenience
/// initializer will take a non-optional `firstName` parameter, and when it's
/// passed, it'll call the full memberwise initializer with
/// `colon = .colonToken()`.
public struct ConvenienceInitRule {
  /// The name of the parameter that is required to be present for
  /// this conveniece initializer rule to apply.
  public let nonOptionalChildName: String

  /// A dicrionary of parameter names to their respective default values
  /// to apply when the `nonOptionalChildName` is passed as concrete value.
  public let defaults: [String: Token]
}
