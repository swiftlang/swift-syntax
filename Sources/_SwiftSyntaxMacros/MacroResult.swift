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

import SwiftDiagnostics

/// Describes the result of rewriting a macro, which contains the rewritten
/// syntax nodes along with any additional information, such as diagnostics
/// generated as part of the rewrite.
public struct MacroResult<Rewritten> {
  public let rewritten: Rewritten
  public let diagnostics: [Diagnostic]

  public init(_ rewritten: Rewritten, diagnostics: [Diagnostic] = []) {
    self.rewritten = rewritten
    self.diagnostics = diagnostics
  }
}
