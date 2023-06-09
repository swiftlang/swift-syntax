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

import SwiftDiagnostics
import SwiftOperators
import SwiftSyntax

/// Fold all of the sequences in the given source file.
func foldAllSequences(_ tree: SourceFileSyntax) -> (Syntax, [Diagnostic]) {
  var diags: [Diagnostic] = []

  let recordOperatorError: (OperatorError) -> Void = { error in
    diags.append(error.asDiagnostic)
  }
  var operatorTable = OperatorTable.standardOperators
  operatorTable.addSourceFile(tree, errorHandler: recordOperatorError)
  let resultTree = operatorTable.foldAll(tree, errorHandler: recordOperatorError)
  return (resultTree, diags)
}
