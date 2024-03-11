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
public import SwiftSyntax
#else
import SwiftSyntax
#endif

/// Describes errors that can occur when working with user-defined operators.
public enum OperatorError: Error, Sendable {
  /// Error produced when a given precedence group already exists in the
  /// precedence graph.
  case groupAlreadyExists(existing: PrecedenceGroup, new: PrecedenceGroup)

  /// The named precedence group is missing from the precedence graph.
  case missingGroup(PrecedenceGroupName, referencedFrom: Syntax)

  /// Error produced when a given operator already exists.
  case operatorAlreadyExists(existing: Operator, new: Operator)

  /// The named operator is missing from the precedence graph.
  case missingOperator(OperatorName, referencedFrom: Syntax)

  /// No associativity relationship between operators.
  case incomparableOperators(
    leftOperator: ExprSyntax,
    leftPrecedenceGroup: PrecedenceGroupName,
    rightOperator: ExprSyntax,
    rightPrecedenceGroup: PrecedenceGroupName
  )
}

/// A function that receives an operator precedence error and may do with it
/// whatever it likes.
///
/// Operator precedence error handlers are passed into each function in the
/// operator-precedence parser that can produce a failure. The handler
/// may choose to throw (in which case the error will propagate outward) or
/// may separately record/drop the error and return without throwing (in
/// which case the operator-precedence parser will recover).
public typealias OperatorErrorHandler =
  (OperatorError) throws -> Void
