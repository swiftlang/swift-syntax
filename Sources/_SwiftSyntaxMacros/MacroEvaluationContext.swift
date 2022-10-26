//===----------------------------------------------------------------------===//
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

import SwiftSyntax

/// System-supplied structure that provides information about the context in
/// which a given macro is being expanded.
public struct MacroEvaluationContext {
  /// The name of the module in which the macro is being evaluated.
  public let moduleName: String

  /// Used to map the provided syntax nodes into source locations.
  public let sourceLocationConverter: SourceLocationConverter

  @_spi(Testing)
  public init(
    moduleName: String,
    sourceLocationConverter: SourceLocationConverter
  ) {
    self.moduleName = moduleName
    self.sourceLocationConverter = sourceLocationConverter
  }
}
