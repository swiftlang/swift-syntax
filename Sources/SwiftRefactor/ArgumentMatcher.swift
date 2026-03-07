//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if compiler(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

/// An error produced by ``ArgumentMatcher`` when a call cannot be matched
/// to the given parameter list.
public enum ArgumentMatchError: Error, CustomStringConvertible {
  /// A labeled argument was provided but no parameter with that external label
  /// exists in the parameter list.
  case unexpectedLabel(label: TokenSyntax, parameter: FunctionParameterSyntax)

  /// A required argument (one with no default value) was not supplied by the
  /// call. Default-parameter handling is not performed in this phase; callers
  /// should handle the missing-argument case themselves, or use a later phase
  /// that synthesises default values.
  case missingArgument(parameter: FunctionParameterSyntax)

  /// The call provides more arguments than the parameter list has parameters.
  /// `from` is the zero-based index of the first extra argument.
  case extraArguments(from: Int)

  public var description: String {
    switch self {
    case .unexpectedLabel(let label, let parameter):
      return
        "unexpected argument label '\(label.text):' in call; parameter has label '\(parameter.firstName.text)'"
    case .missingArgument(let parameter):
      return "missing argument for parameter '\(parameter.firstName.text)' in call"
    case .extraArguments(let index):
      return "extra argument at position #\(index + 1) in call"
    }
  }
}

/// A resolved mapping between a single call-site argument and its corresponding
/// function parameter.
///
/// Use ``ArgumentMatcher/match(call:parameters:)`` to produce an array of
/// these from a ``FunctionCallExprSyntax`` and a ``FunctionParameterListSyntax``.
///
/// ## Example
///
/// Given:
/// ```swift
/// func move(to destination: CGPoint) { … }
/// move(to: target)
/// ```
///
/// The resolved ``ArgumentMatch`` has:
/// - `parameter`: the `to destination: CGPoint` node
/// - `argument`: the `target` expression
/// - `internalName`: the token `destination` (used inside the function body)
/// - `isLabeled`: `true` (matched by the external label `to`)
public struct ArgumentMatch {
  /// The function parameter this argument was matched to.
  public let parameter: FunctionParameterSyntax

  /// The expression at the call site that should be substituted for uses of
  /// ``internalName`` in the function body.
  public let argument: ExprSyntax

  /// The name used to reference this parameter *inside* the function body.
  ///
  /// This is the parameter's second name when one is present (e.g.
  /// `destination` in `to destination: CGPoint`), or its first name otherwise
  /// (e.g. `width` in `width: Int`).
  public let internalName: TokenSyntax

  /// Whether this argument was matched to its parameter via a label (`true`)
  /// or by its position in the argument list (`false`).
  ///
  /// An argument is positional when the parameter's external label is `_`.
  public let isLabeled: Bool
}

/// A utility for matching the arguments of a function call to the corresponding
/// parameters of a function declaration.
///
/// This type covers the first phase of argument resolution:
/// - **Labeled arguments**: matched by external label name.
/// - **Positional arguments**: matched in declaration order when the
///   parameter's external label is `_`.
/// - **External vs. internal names**: the ``ArgumentMatch/internalName``
///   returned for each match reflects the name used inside the function body,
///   not the label visible at the call site.
///
/// Later phases (default parameters, trailing closures, variadic parameters,
/// `inout` and `@autoclosure` handling) are handled by separate extensions
/// on this type.
///
/// ## Example — all labeled
///
/// ```swift
/// func configure(width: Int, height: Int) { … }
/// configure(width: 100, height: 200)
/// // → [width → 100 (internalName: width), height → 200 (internalName: height)]
/// ```
///
/// ## Example — positional
///
/// ```swift
/// func greet(_ name: String) -> String { … }
/// greet("World")
/// // → [name → "World"  (internalName: name, isLabeled: false)]
/// ```
///
/// ## Example — external / internal names
///
/// ```swift
/// func move(to destination: CGPoint) { … }
/// move(to: target)
/// // → [internalName: destination, argument: target, isLabeled: true]
/// ```
public enum ArgumentMatcher {
  /// Match the arguments of a call expression against the parameter list of a
  /// function declaration.
  ///
  /// - Parameters:
  ///   - call: The call expression whose arguments will be matched.
  ///   - parameters: The parameter list of the function being called.
  /// - Returns: An array of ``ArgumentMatch`` values, one per argument in
  ///   `call.arguments`, in the order they appear at the call site.
  /// - Throws: ``ArgumentMatchError`` if the arguments cannot be unambiguously
  ///   matched to the parameter list.
  public static func match(
    call: FunctionCallExprSyntax,
    parameters: FunctionParameterListSyntax
  ) throws -> [ArgumentMatch] {
    let arguments = Array(call.arguments)
    let params = Array(parameters)

    if arguments.isEmpty && params.isEmpty {
      return []
    }

    // More arguments than parameters is always an error (variadic handling is
    // deferred to a later phase).
    if arguments.count > params.count {
      throw ArgumentMatchError.extraArguments(from: params.count)
    }

    var matches: [ArgumentMatch] = []
    matches.reserveCapacity(arguments.count)

    // Tracks which parameter index to try next for positional (unlabeled)
    // matching. Labeled arguments can match any parameter regardless of
    // position, so we scan forward to find the right one.
    var nextPositionalIndex = 0

    // Records which parameter indices have been consumed by an argument.
    // Used below to detect required parameters that were never supplied.
    var matchedParamIndices = Set<Int>()

    for (argIndex, argument) in arguments.enumerated() {
      let paramIndex: Int
      let isLabeled: Bool

      if let label = argument.label {
        // Labeled argument: find the parameter whose external label (firstName)
        // matches the label at the call site.
        guard
          let foundIndex = params.indices.first(where: {
            params[$0].firstName.text == label.text
          })
        else {
          let nearestParam = params[min(argIndex, params.count - 1)]
          throw ArgumentMatchError.unexpectedLabel(label: label, parameter: nearestParam)
        }
        paramIndex = foundIndex
        isLabeled = true

        // Advance the positional cursor past this parameter so that subsequent
        // positional arguments do not attempt to consume it.
        if paramIndex >= nextPositionalIndex {
          nextPositionalIndex = paramIndex + 1
        }
      } else {
        // Positional argument: consume the next parameter declared with `_` as
        // its external label. Parameters with an explicit external label cannot
        // be matched positionally.
        guard
          let foundIndex = (nextPositionalIndex..<params.count).first(where: {
            params[$0].firstName.tokenKind == .wildcard
          })
        else {
          throw ArgumentMatchError.extraArguments(from: argIndex)
        }
        paramIndex = foundIndex
        isLabeled = false
        nextPositionalIndex = paramIndex + 1
      }

      let param = params[paramIndex]
      matchedParamIndices.insert(paramIndex)
      matches.append(
        ArgumentMatch(
          parameter: param,
          argument: argument.expression,
          internalName: internalName(for: param),
          isLabeled: isLabeled
        )
      )
    }

    // Verify every non-default parameter was supplied. Parameters with a
    // default value may be omitted; default synthesis is handled in a later
    // phase.
    for (index, param) in params.enumerated() {
      guard !matchedParamIndices.contains(index) else { continue }
      if param.defaultValue != nil { continue }
      throw ArgumentMatchError.missingArgument(parameter: param)
    }

    return matches
  }
}

/// Returns the name used to reference `parameter` inside the function body.
///
/// Swift parameters have an optional second (internal) name:
/// ```
/// func move(to destination: CGPoint)
///           ^^  ^^^^^^^^^^^
///   external    internal
/// ```
/// When a second name is present it is the internal name; otherwise the first
/// name serves as both external and internal name.
private func internalName(for parameter: FunctionParameterSyntax) -> TokenSyntax {
  if let secondName = parameter.secondName {
    return secondName
  }
  return parameter.firstName
}
