//===------------------ OperatorPrecedence+Defaults.swift -----------------===//
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

/// Prefabricated operator precedence graphs.
extension OperatorPrecedence {
  /// Operator precedence graph for the logical operators '&&' and '||', for
  /// example as it is used in `#if` processing.
  public static var logicalOperators: OperatorPrecedence {
    var opPrecedence = OperatorPrecedence()

    try! opPrecedence.record(
      Operator(kind: .infix, name: "&&",
               precedenceGroup: "LogicalConjunctionPrecedence"))
    try! opPrecedence.record(
      Operator(kind: .infix, name: "||",
               precedenceGroup: "LogicalDisjunctionPrecedence"))
    try! opPrecedence.record(
      PrecedenceGroup(name: "LogicalConjunctionPrecedence",
                      associativity: .left, assignment: false,
                      relations: [.higherThan("LogicalDisjunctionPrecedence")]))
    try! opPrecedence.record(
      PrecedenceGroup(name: "LogicalDisjunctionPrecedence",
                      associativity: .left, assignment: false,
                      relations: []))
    return opPrecedence
  }

  /// Operator precedence graph for the Swift standard library.
  ///
  /// This describes the operators within the Swift standard library at the
  /// type of this writing. It can be used to approximate the behavior one
  /// would get from parsing the actual Swift standard library's operators
  /// without requiring access to the standard library source code. However,
  /// because it does not incorporate user-defined operators, it will only
  /// ever be useful for a quick approximation.
  public static var standardOperators: OperatorPrecedence {
    var opPrecedence = OperatorPrecedence()

    try! opPrecedence.record(
      PrecedenceGroup(
        name: "AssignmentPrecedence",
        associativity: .right,
        assignment: true
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "FunctionArrowPrecedence",
        associativity: .right,
        relations: [.higherThan("AssignmentPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "TernaryPrecedence",
        associativity: .right,
        relations: [.higherThan("FunctionArrowPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "DefaultPrecedence",
        relations: [.higherThan("TernaryPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "LogicalDisjunctionPrecedence",
        associativity: .left,
        relations: [.higherThan("TernaryPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "LogicalConjunctionPrecedence",
        associativity: .left,
        relations: [.higherThan("LogicalDisjunctionPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "ComparisonPrecedence",
        relations: [.higherThan("LogicalConjunctionPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "NilCoalescingPrecedence",
        associativity: .right,
        relations: [.higherThan("ComparisonPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "CastingPrecedence",
        relations: [.higherThan("NilCoalescingPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "RangeFormationPrecedence",
        relations: [.higherThan("CastingPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "AdditionPrecedence",
        associativity: .left,
        relations: [.higherThan("RangeFormationPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "MultiplicationPrecedence",
        associativity: .left,
        relations: [.higherThan("AdditionPrecedence")]
      )
    )
    try! opPrecedence.record(
      PrecedenceGroup(
        name: "BitwiseShiftPrecedence",
        relations: [.higherThan("MultiplicationPrecedence")]
      )
    )

    // "Exponentiative"

    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "<<",
        precedenceGroup: "BitwiseShiftPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&<<",
        precedenceGroup: "BitwiseShiftPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: ">>",
        precedenceGroup: "BitwiseShiftPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&>>",
        precedenceGroup: "BitwiseShiftPrecedence"
      )
    )

    // "Multiplicative"

    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "*",
        precedenceGroup: "MultiplicationPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&*",
        precedenceGroup: "MultiplicationPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "/",
        precedenceGroup: "MultiplicationPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "%",
        precedenceGroup: "MultiplicationPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&",
        precedenceGroup: "MultiplicationPrecedence"
      )
    )

    // "Additive"

    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "+",
        precedenceGroup: "AdditionPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&+",
        precedenceGroup: "AdditionPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "-",
        precedenceGroup: "AdditionPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&-",
        precedenceGroup: "AdditionPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "|",
        precedenceGroup: "AdditionPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "^",
        precedenceGroup: "AdditionPrecedence"
      )
    )

    // FIXME: is this the right precedence level for "..."?
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "...",
        precedenceGroup: "RangeFormationPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "..<",
        precedenceGroup: "RangeFormationPrecedence"
      )
    )

    // "Coalescing"

    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "??",
        precedenceGroup: "NilCoalescingPrecedence"
      )
    )

    // "Comparative"

    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "<",
        precedenceGroup: "ComparisonPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "<=",
        precedenceGroup: "ComparisonPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: ">",
        precedenceGroup: "ComparisonPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: ">=",
        precedenceGroup: "ComparisonPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "==",
        precedenceGroup: "ComparisonPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "!=",
        precedenceGroup: "ComparisonPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "===",
        precedenceGroup: "ComparisonPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "!==",
        precedenceGroup: "ComparisonPrecedence"
      )
    )
    // FIXME: ~= will be built into the compiler.
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "~=",
        precedenceGroup: "ComparisonPrecedence"
      )
    )

    // "Conjunctive"

    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&&",
        precedenceGroup: "LogicalConjunctionPrecedence"
      )
    )

    // "Disjunctive"

    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "||",
        precedenceGroup: "LogicalDisjunctionPrecedence"
      )
    )

    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "*=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&*=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "/=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "%=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "+=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&+=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "-=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&-=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "<<=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&<<=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: ">>=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&>>=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "&=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "^=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )
    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "|=",
        precedenceGroup: "AssignmentPrecedence"
      )
    )

    try! opPrecedence.record(
      Operator(
        kind: .infix,
        name: "~>",
        precedenceGroup: nil
      )
    )

    return opPrecedence
  }
}
