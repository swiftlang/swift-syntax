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

// MARK: - ArgumentSource

/// The source of an argument value in a function call.
///
/// This enum models where an argument value comes from, which may not always
/// correspond to written syntax. For example, default argument values are
/// copied from the parameter declaration, and synthesized functions may not
/// have syntax at all.
public enum ArgumentSource {
  /// An explicit argument written at the call site.
  ///
  /// The associated `ExprSyntax` is the expression from the call's argument
  /// list or trailing closure.
  case explicit(ExprSyntax)

  /// A default value from the parameter declaration.
  ///
  /// The associated `ExprSyntax` is the default value expression from the
  /// parameter's `defaultValue` clause. Note that this syntax belongs to the
  /// declaration, not the call site.
  case defaultValue(ExprSyntax)

  /// A synthesized value with no corresponding syntax.
  ///
  /// This is used for cases where an argument must be synthesized (e.g.,
  /// for synthesized initializers or other compiler-generated code).
  case synthesized

  /// The expression for this argument source, if one exists.
  ///
  /// Returns `nil` for `.synthesized` cases.
  public var expression: ExprSyntax? {
    switch self {
    case .explicit(let expr), .defaultValue(let expr):
      return expr
    case .synthesized:
      return nil
    }
  }

  /// Whether this argument was explicitly provided at the call site.
  public var isExplicit: Bool {
    if case .explicit = self { return true }
    return false
  }

  /// Whether this argument uses a default value from the parameter declaration.
  public var isDefaultValue: Bool {
    if case .defaultValue = self { return true }
    return false
  }

  /// Whether this argument was synthesized with no corresponding syntax.
  public var isSynthesized: Bool {
    if case .synthesized = self { return true }
    return false
  }
}

// MARK: - ParameterInfo

/// Information about a parameter extracted from a parameter syntax node.
///
/// This struct provides a uniform representation of parameter information
/// that works across different parameter syntax types (function parameters,
/// closure parameters, etc.).
public struct ParameterInfo {
  /// The external label used at the call site.
  ///
  /// This is the first name in the parameter declaration. A label of `_`
  /// indicates a positional parameter.
  public let externalLabel: TokenSyntax

  /// The internal name used inside the function body.
  ///
  /// This is the second name if present, otherwise the first name.
  public let internalName: TokenSyntax

  /// The type of the parameter, if available.
  public let type: TypeSyntax?

  /// Whether this parameter is variadic (`...`).
  public let isVariadic: Bool

  /// The default value expression, if one exists.
  public let defaultValue: ExprSyntax?

  /// Creates parameter info from a function parameter.
  public init(from parameter: FunctionParameterSyntax) {
    self.externalLabel = parameter.firstName
    self.internalName = parameter.secondName ?? parameter.firstName
    self.type = parameter.type
    self.isVariadic = parameter.ellipsis != nil
    self.defaultValue = parameter.defaultValue?.value
  }

  /// Creates parameter info from a closure parameter.
  public init(from parameter: ClosureParameterSyntax) {
    self.externalLabel = parameter.firstName
    self.internalName = parameter.secondName ?? parameter.firstName
    self.type = parameter.type
    self.isVariadic = parameter.ellipsis != nil
    self.defaultValue = nil
  }

  /// Creates parameter info with explicit values.
  public init(
    externalLabel: TokenSyntax,
    internalName: TokenSyntax,
    type: TypeSyntax?,
    isVariadic: Bool,
    defaultValue: ExprSyntax?
  ) {
    self.externalLabel = externalLabel
    self.internalName = internalName
    self.type = type
    self.isVariadic = isVariadic
    self.defaultValue = defaultValue
  }

  /// Whether this parameter has a positional (unlabeled) external name.
  public var isPositional: Bool {
    externalLabel.tokenKind == .wildcard
  }
}

// MARK: - ArgumentMatchError

/// An error produced by ``ArgumentMatcher`` when a call cannot be matched
/// to the given parameter list.
public enum ArgumentMatchError: Error, CustomStringConvertible {
  /// A labeled argument was provided but no parameter with that external label
  /// exists in the parameter list.
  case unexpectedLabel(label: TokenSyntax, parameterLabel: String)

  /// A required argument (one with no default value) was not supplied by the
  /// call. Default-parameter handling is not performed in this phase; callers
  /// should handle the missing-argument case themselves, or use a later phase
  /// that synthesises default values.
  case missingArgument(parameterName: String)

  /// The call provides more arguments than the parameter list has parameters.
  /// `from` is the zero-based index of the first extra argument.
  case extraArguments(from: Int)

  /// A variadic parameter received arguments after labeled arguments that
  /// should have come later in the parameter list.
  case variadicArgumentAfterLabel(variadicParameter: String, label: String)

  public var description: String {
    switch self {
    case .unexpectedLabel(let label, let parameterLabel):
      return
        "unexpected argument label '\(label.text):' in call; parameter has label '\(parameterLabel)'"
    case .missingArgument(let parameterName):
      return "missing argument for parameter '\(parameterName)' in call"
    case .extraArguments(let index):
      return "extra argument at position #\(index + 1) in call"
    case .variadicArgumentAfterLabel(let variadicParameter, let label):
      return
        "variadic parameter '\(variadicParameter)' cannot receive arguments after labeled argument '\(label):'"
    }
  }
}

// MARK: - ArgumentMatch

/// A resolved mapping between a single call-site argument and its corresponding
/// function parameter.
///
/// Use ``ArgumentMatcher/match(call:parameters:)`` to produce an array of
/// these from a ``FunctionCallExprSyntax`` and a ``FunctionParameterListSyntax``.
///
/// For variadic parameters that accept multiple arguments, use
/// ``VariadicArgumentMatch`` instead.
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
/// - `source`: `.explicit(target)` — the expression from the call site
/// - `internalName`: the token `destination` (used inside the function body)
/// - `isLabeled`: `true` (matched by the external label `to`)
public struct ArgumentMatch {
  /// The function parameter this argument was matched to.
  public let parameter: FunctionParameterSyntax

  /// The source of the argument value.
  ///
  /// This may be an explicit call-site expression, a default value from the
  /// parameter declaration, or a synthesized value with no syntax.
  public let source: ArgumentSource

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

  /// Whether this argument was provided via trailing closure syntax.
  ///
  /// Trailing closures are syntactically separate from the argument list
  /// (`FunctionCallExprSyntax.trailingClosure` and
  /// `FunctionCallExprSyntax.additionalTrailingClosures`) but are matched
  /// to closure-typed parameters.
  public let isTrailingClosure: Bool

  /// The expression at the call site that should be substituted for uses of
  /// ``internalName`` in the function body.
  ///
  /// This is a convenience accessor that returns the expression from ``source``.
  /// Returns `nil` for synthesized arguments.
  public var argument: ExprSyntax? {
    source.expression
  }

  /// Whether this match was synthesized from a default parameter value because
  /// the call site omitted the argument.
  public var isDefaulted: Bool {
    source.isDefaultValue
  }

  /// Creates an argument match.
  public init(
    parameter: FunctionParameterSyntax,
    source: ArgumentSource,
    internalName: TokenSyntax,
    isLabeled: Bool,
    isTrailingClosure: Bool = false
  ) {
    self.parameter = parameter
    self.source = source
    self.internalName = internalName
    self.isLabeled = isLabeled
    self.isTrailingClosure = isTrailingClosure
  }

  /// Creates an argument match with an explicit expression.
  ///
  /// This is a convenience initializer for the common case of matching
  /// an explicit call-site argument.
  public init(
    parameter: FunctionParameterSyntax,
    argument: ExprSyntax,
    internalName: TokenSyntax,
    isLabeled: Bool,
    isDefaulted: Bool = false,
    isTrailingClosure: Bool = false
  ) {
    self.parameter = parameter
    self.source = isDefaulted ? .defaultValue(argument) : .explicit(argument)
    self.internalName = internalName
    self.isLabeled = isLabeled
    self.isTrailingClosure = isTrailingClosure
  }
}

// MARK: - VariadicArgumentMatch

/// A resolved mapping between a variadic parameter and its matched arguments.
///
/// Unlike ``ArgumentMatch`` which represents a 1:1 relationship, this type
/// represents a 1:n relationship where a single variadic parameter can accept
/// zero or more arguments.
///
/// ## Example
///
/// Given:
/// ```swift
/// func log(_ items: Any...) { … }
/// log("Hello", 42, true)
/// ```
///
/// The resolved ``VariadicArgumentMatch`` has:
/// - `parameter`: the `_ items: Any...` node
/// - `arguments`: `[.explicit("Hello"), .explicit(42), .explicit(true)]`
/// - `internalName`: the token `items`
public struct VariadicArgumentMatch {
  /// The variadic function parameter.
  public let parameter: FunctionParameterSyntax

  /// The arguments matched to this variadic parameter.
  ///
  /// May be empty if no arguments were provided for this variadic parameter.
  public let arguments: [ArgumentSource]

  /// The name used to reference this parameter inside the function body.
  public let internalName: TokenSyntax

  /// Whether this parameter was matched via a label.
  public let isLabeled: Bool

  /// Creates a variadic argument match.
  public init(
    parameter: FunctionParameterSyntax,
    arguments: [ArgumentSource],
    internalName: TokenSyntax,
    isLabeled: Bool
  ) {
    self.parameter = parameter
    self.arguments = arguments
    self.internalName = internalName
    self.isLabeled = isLabeled
  }
}

// MARK: - MatchResult

/// The result of matching call arguments to function parameters.
///
/// This type supports both regular 1:1 matches and variadic 1:n matches
/// in a unified result.
public enum ParameterMatch {
  /// A regular 1:1 argument-to-parameter match.
  case single(ArgumentMatch)

  /// A variadic 1:n arguments-to-parameter match.
  case variadic(VariadicArgumentMatch)

  /// The parameter for this match.
  public var parameter: FunctionParameterSyntax {
    switch self {
    case .single(let match):
      return match.parameter
    case .variadic(let match):
      return match.parameter
    }
  }

  /// The internal name for this parameter.
  public var internalName: TokenSyntax {
    switch self {
    case .single(let match):
      return match.internalName
    case .variadic(let match):
      return match.internalName
    }
  }

  /// Whether this parameter was matched via a label.
  public var isLabeled: Bool {
    switch self {
    case .single(let match):
      return match.isLabeled
    case .variadic(let match):
      return match.isLabeled
    }
  }
}

/// A utility for matching the arguments of a function call to the corresponding
/// parameters of a function declaration.
///
/// This type provides multiple matching methods with increasing levels of
/// completeness:
///
/// - ``match(call:parameters:)`` — Matches explicit arguments only. Throws if
///   a required parameter is missing. Useful when you only need to process
///   arguments that were actually written at the call site.
///
/// - ``matchWithDefaults(call:parameters:)`` — Also synthesizes matches for
///   omitted parameters that have default values.
///
/// - ``matchWithTrailingClosures(call:parameters:)`` — Full matching including
///   trailing closures (SE-0279).
///
/// ## Matching rules
///
/// - **Labeled arguments**: matched by external label name.
/// - **Positional arguments**: matched in declaration order when the
///   parameter's external label is `_`.
/// - **External vs. internal names**: the ``ArgumentMatch/internalName``
///   returned for each match reflects the name used inside the function body,
///   not the label visible at the call site.
/// - **Trailing closures**: The first trailing closure matches the first
///   unmatched closure-accepting parameter; additional trailing closures are
///   matched by their labels (SE-0279).
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
///
/// ## Example — default values
///
/// ```swift
/// func toast(message: String, duration: Double = 2.0) { … }
/// toast(message: "Saved")
/// // matchWithDefaults → [message → "Saved", duration → 2.0 (isDefaulted: true)]
/// ```
///
/// ## Example — trailing closures
///
/// ```swift
/// func animate(duration: Double, _ animations: () -> Void) { … }
/// animate(duration: 0.3) { view.alpha = 0 }
/// // matchWithTrailingClosures → [duration → 0.3, animations → { ... } (isTrailingClosure: true)]
/// ```
///
/// ## Example — variadic parameters
///
/// ```swift
/// func log(_ items: Any...) { … }
/// log("Hello", 42)
/// // matchFull → [items → VariadicArgumentMatch with ["Hello", 42]]
/// ```
public enum ArgumentMatcher {
  /// Match the arguments of a call expression against the parameter list of a
  /// function declaration.
  ///
  /// This method matches explicit arguments only and does not handle variadic
  /// parameters specially. For variadic support, use ``matchFull(call:parameters:)``.
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

    // Check for variadic parameters - they can accept any number of args
    let hasVariadic = params.contains { $0.ellipsis != nil }

    // Without variadic params, more args than params is an error
    if !hasVariadic && arguments.count > params.count {
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

    // Track if we're currently consuming arguments for a variadic parameter
    var currentVariadicIndex: Int?

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
          throw ArgumentMatchError.unexpectedLabel(
            label: label,
            parameterLabel: nearestParam.firstName.text
          )
        }
        paramIndex = foundIndex
        isLabeled = true
        currentVariadicIndex = nil  // Labeled arg ends any variadic sequence

        // Advance the positional cursor past this parameter so that subsequent
        // positional arguments do not attempt to consume it.
        if paramIndex >= nextPositionalIndex {
          nextPositionalIndex = paramIndex + 1
        }
      } else {
        // Check if we're continuing a variadic sequence
        if let variadicIdx = currentVariadicIndex {
          paramIndex = variadicIdx
          isLabeled = false
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

          // If this is a variadic parameter, mark it for subsequent args
          if params[paramIndex].ellipsis != nil {
            currentVariadicIndex = paramIndex
          } else {
            nextPositionalIndex = paramIndex + 1
          }
        }
      }

      let param = params[paramIndex]
      if param.ellipsis == nil && matchedParamIndices.contains(paramIndex) {
        throw ArgumentMatchError.extraArguments(from: argIndex)
      }
      matchedParamIndices.insert(paramIndex)
      matches.append(
        ArgumentMatch(
          parameter: param,
          argument: argument.expression,
          internalName: internalName(for: param),
          isLabeled: isLabeled,
          isDefaulted: false,
          isTrailingClosure: false
        )
      )
    }

    // Verify every non-default, non-variadic parameter was supplied.
    // Parameters with a default value may be omitted; default synthesis is
    // handled in a later phase. Variadic parameters may receive zero arguments.
    for (index, param) in params.enumerated() {
      guard !matchedParamIndices.contains(index) else { continue }
      if param.defaultValue != nil { continue }
      if param.ellipsis != nil { continue }  // Variadic can be empty
      throw ArgumentMatchError.missingArgument(parameterName: param.firstName.text)
    }

    return matches
  }

  /// Match arguments including synthesized default values for omitted
  /// parameters.
  ///
  /// This method extends ``match(call:parameters:)`` by also returning matches
  /// for parameters that were omitted at the call site but have default values.
  /// The ``ArgumentMatch/isDefaulted`` property is `true` for these synthesized
  /// matches.
  ///
  /// - Parameters:
  ///   - call: The call expression whose arguments will be matched.
  ///   - parameters: The parameter list of the function being called.
  /// - Returns: An array of ``ArgumentMatch`` values in parameter declaration
  ///   order. Variadic parameters may contribute multiple matches.
  /// - Throws: ``ArgumentMatchError`` if the arguments cannot be unambiguously
  ///   matched to the parameter list.
  public static func matchWithDefaults(
    call: FunctionCallExprSyntax,
    parameters: FunctionParameterListSyntax
  ) throws -> [ArgumentMatch] {
    let arguments = Array(call.arguments)
    let params = Array(parameters)

    if arguments.isEmpty && params.isEmpty {
      return []
    }

    // Check for variadic parameters
    let hasVariadic = params.contains { $0.ellipsis != nil }

    // Without variadic params, more args than params is an error
    if !hasVariadic && arguments.count > params.count {
      throw ArgumentMatchError.extraArguments(from: params.count)
    }

    // Build matches for explicit arguments first, tracking which params are
    // consumed. For variadic params, we collect multiple matches.
    var matchesByParamIndex: [Int: [ArgumentMatch]] = [:]
    var nextPositionalIndex = 0
    var currentVariadicIndex: Int?

    for (argIndex, argument) in arguments.enumerated() {
      let paramIndex: Int
      let isLabeled: Bool

      if let label = argument.label {
        guard
          let foundIndex = params.indices.first(where: {
            params[$0].firstName.text == label.text
          })
        else {
          let nearestParam = params[min(argIndex, params.count - 1)]
          throw ArgumentMatchError.unexpectedLabel(
            label: label,
            parameterLabel: nearestParam.firstName.text
          )
        }
        paramIndex = foundIndex
        isLabeled = true
        currentVariadicIndex = nil

        if paramIndex >= nextPositionalIndex {
          nextPositionalIndex = paramIndex + 1
        }
      } else {
        // Check if we're continuing a variadic sequence
        if let variadicIdx = currentVariadicIndex {
          paramIndex = variadicIdx
          isLabeled = false
        } else {
          guard
            let foundIndex = (nextPositionalIndex..<params.count).first(where: {
              params[$0].firstName.tokenKind == .wildcard
            })
          else {
            throw ArgumentMatchError.extraArguments(from: argIndex)
          }
          paramIndex = foundIndex
          isLabeled = false

          if params[paramIndex].ellipsis != nil {
            currentVariadicIndex = paramIndex
          } else {
            nextPositionalIndex = paramIndex + 1
          }
        }
      }

      let param = params[paramIndex]
      if param.ellipsis == nil && matchesByParamIndex[paramIndex] != nil {
        throw ArgumentMatchError.extraArguments(from: argIndex)
      }
      let match = ArgumentMatch(
        parameter: param,
        argument: argument.expression,
        internalName: internalName(for: param),
        isLabeled: isLabeled,
        isDefaulted: false,
        isTrailingClosure: false
      )
      matchesByParamIndex[paramIndex, default: []].append(match)
    }

    // Synthesize matches for omitted defaulted parameters.
    var result: [ArgumentMatch] = []
    result.reserveCapacity(params.count)

    for (index, param) in params.enumerated() {
      if let existingMatches = matchesByParamIndex[index] {
        // For variadic, we return all matches; for non-variadic, just the one
        result.append(contentsOf: existingMatches)
      } else if let defaultValue = param.defaultValue {
        result.append(
          ArgumentMatch(
            parameter: param,
            argument: defaultValue.value,
            internalName: internalName(for: param),
            isLabeled: param.firstName.tokenKind != .wildcard,
            isDefaulted: true,
            isTrailingClosure: false
          )
        )
      } else if param.ellipsis != nil {
        // Variadic parameter with no arguments - no match needed
        continue
      } else {
        throw ArgumentMatchError.missingArgument(parameterName: param.firstName.text)
      }
    }

    return result
  }

  /// Match arguments including trailing closures and synthesized default
  /// values.
  ///
  /// This is the most complete matching method. It handles:
  /// - Labeled and positional arguments from the argument list
  /// - The first trailing closure (matched to the first unmatched
  ///   closure-accepting parameter)
  /// - Additional trailing closures (SE-0279, matched by label)
  /// - Synthesized default values for any remaining omitted parameters
  /// - Variadic parameters (collecting multiple arguments into one param)
  ///
  /// - Parameters:
  ///   - call: The call expression whose arguments will be matched.
  ///   - parameters: The parameter list of the function being called.
  /// - Returns: An array of ``ArgumentMatch`` values in parameter declaration
  ///   order. Variadic parameters may contribute multiple matches.
  /// - Throws: ``ArgumentMatchError`` if the arguments cannot be unambiguously
  ///   matched to the parameter list.
  public static func matchWithTrailingClosures(
    call: FunctionCallExprSyntax,
    parameters: FunctionParameterListSyntax
  ) throws -> [ArgumentMatch] {
    let params = Array(parameters)

    if params.isEmpty {
      // If there are trailing closures but no parameters, that's an error.
      if call.trailingClosure != nil {
        throw ArgumentMatchError.extraArguments(from: 0)
      }
      if call.arguments.isEmpty {
        return []
      }
      throw ArgumentMatchError.extraArguments(from: 0)
    }

    // Count total arguments: inline + trailing closures.
    let inlineArgCount = call.arguments.count
    let trailingCount =
      (call.trailingClosure != nil ? 1 : 0)
      + call.additionalTrailingClosures.count

    // Check for variadic parameters
    let hasVariadic = params.contains { $0.ellipsis != nil }

    if !hasVariadic && inlineArgCount + trailingCount > params.count {
      throw ArgumentMatchError.extraArguments(from: params.count)
    }

    // Build matches for explicit inline arguments first.
    var matchesByParamIndex: [Int: [ArgumentMatch]] = [:]
    var nextPositionalIndex = 0
    var currentVariadicIndex: Int?

    for (argIndex, argument) in call.arguments.enumerated() {
      let paramIndex: Int
      let isLabeled: Bool

      if let label = argument.label {
        guard
          let foundIndex = params.indices.first(where: {
            params[$0].firstName.text == label.text
          })
        else {
          let nearestParam = params[min(argIndex, params.count - 1)]
          throw ArgumentMatchError.unexpectedLabel(
            label: label,
            parameterLabel: nearestParam.firstName.text
          )
        }
        paramIndex = foundIndex
        isLabeled = true
        currentVariadicIndex = nil

        if paramIndex >= nextPositionalIndex {
          nextPositionalIndex = paramIndex + 1
        }
      } else {
        if let variadicIdx = currentVariadicIndex {
          paramIndex = variadicIdx
          isLabeled = false
        } else {
          guard
            let foundIndex = (nextPositionalIndex..<params.count).first(where: {
              params[$0].firstName.tokenKind == .wildcard
            })
          else {
            throw ArgumentMatchError.extraArguments(from: argIndex)
          }
          paramIndex = foundIndex
          isLabeled = false

          if params[paramIndex].ellipsis != nil {
            currentVariadicIndex = paramIndex
          } else {
            nextPositionalIndex = paramIndex + 1
          }
        }
      }

      let param = params[paramIndex]
      if param.ellipsis == nil && matchesByParamIndex[paramIndex] != nil {
        throw ArgumentMatchError.extraArguments(from: argIndex)
      }
      let match = ArgumentMatch(
        parameter: param,
        argument: argument.expression,
        internalName: internalName(for: param),
        isLabeled: isLabeled,
        isDefaulted: false,
        isTrailingClosure: false
      )
      matchesByParamIndex[paramIndex, default: []].append(match)
    }

    // Match the first trailing closure. The matching strategy:
    // 1. First, try to match to an unmatched positional (`_`) parameter,
    //    since trailing closures are syntactically unlabeled.
    // 2. If no positional params remain, fall back to the first unmatched
    //    parameter (which may be a labeled closure parameter).
    if let trailingClosure = call.trailingClosure {
      let unmatchedIndices = params.indices.filter {
        !matchesByParamIndex.keys.contains($0)
      }
      guard !unmatchedIndices.isEmpty else {
        throw ArgumentMatchError.extraArguments(from: inlineArgCount)
      }

      // Prefer positional parameters; fall back to first unmatched.
      let targetIndex =
        unmatchedIndices.first(where: { params[$0].firstName.tokenKind == .wildcard })
        ?? unmatchedIndices.first!

      let param = params[targetIndex]
      if param.ellipsis == nil && matchesByParamIndex[targetIndex] != nil {
        throw ArgumentMatchError.extraArguments(from: inlineArgCount)
      }
      let match = ArgumentMatch(
        parameter: param,
        argument: ExprSyntax(trailingClosure),
        internalName: internalName(for: param),
        isLabeled: false,
        isDefaulted: false,
        isTrailingClosure: true
      )
      matchesByParamIndex[targetIndex, default: []].append(match)
    }

    // Match additional trailing closures by their labels (SE-0279).
    for additionalClosure in call.additionalTrailingClosures {
      let label = additionalClosure.label

      guard
        let foundIndex = params.indices.first(where: {
          params[$0].firstName.text == label.text
        })
      else {
        let nearestParam = params.last!
        throw ArgumentMatchError.unexpectedLabel(
          label: label,
          parameterLabel: nearestParam.firstName.text
        )
      }

      let param = params[foundIndex]
      if param.ellipsis == nil && matchesByParamIndex[foundIndex] != nil {
        throw ArgumentMatchError.extraArguments(from: inlineArgCount)
      }
      let match = ArgumentMatch(
        parameter: param,
        argument: ExprSyntax(additionalClosure.closure),
        internalName: internalName(for: param),
        isLabeled: true,
        isDefaulted: false,
        isTrailingClosure: true
      )
      matchesByParamIndex[foundIndex, default: []].append(match)
    }

    // Synthesize matches for remaining omitted defaulted parameters.
    var result: [ArgumentMatch] = []
    result.reserveCapacity(params.count)

    for (index, param) in params.enumerated() {
      if let existingMatches = matchesByParamIndex[index] {
        result.append(contentsOf: existingMatches)
      } else if let defaultValue = param.defaultValue {
        result.append(
          ArgumentMatch(
            parameter: param,
            argument: defaultValue.value,
            internalName: internalName(for: param),
            isLabeled: param.firstName.tokenKind != .wildcard,
            isDefaulted: true,
            isTrailingClosure: false
          )
        )
      } else if param.ellipsis != nil {
        // Variadic parameter with no arguments - no match needed
        continue
      } else {
        throw ArgumentMatchError.missingArgument(parameterName: param.firstName.text)
      }
    }

    return result
  }

  // MARK: - Full Match with ParameterMatch

  /// Perform a complete match returning one result per parameter.
  ///
  /// Unlike the other matching methods which return one ``ArgumentMatch``
  /// per argument, this method returns one ``ParameterMatch`` per parameter.
  /// This properly models variadic parameters where a single parameter can
  /// receive multiple arguments.
  ///
  /// This method includes:
  /// - All inline arguments
  /// - Trailing closures (SE-0279)
  /// - Synthesized default values
  /// - Variadic parameter handling (1:n matching)
  ///
  /// - Parameters:
  ///   - call: The call expression whose arguments will be matched.
  ///   - parameters: The parameter list of the function being called.
  /// - Returns: An array of ``ParameterMatch`` values, one per parameter in
  ///   `parameters`, in parameter declaration order.
  /// - Throws: ``ArgumentMatchError`` if the arguments cannot be unambiguously
  ///   matched to the parameter list.
  public static func matchFull(
    call: FunctionCallExprSyntax,
    parameters: FunctionParameterListSyntax
  ) throws -> [ParameterMatch] {
    let params = Array(parameters)

    if params.isEmpty {
      if call.trailingClosure != nil || !call.arguments.isEmpty {
        throw ArgumentMatchError.extraArguments(from: 0)
      }
      return []
    }

    // Collect argument sources by parameter index
    var sourcesByParamIndex: [Int: [ArgumentSource]] = [:]
    var isLabeledByParamIndex: [Int: Bool] = [:]
    var isTrailingClosureByParamIndex: [Int: Bool] = [:]
    var nextPositionalIndex = 0
    var currentVariadicIndex: Int?

    // Process inline arguments
    for (argIndex, argument) in call.arguments.enumerated() {
      let paramIndex: Int
      let isLabeled: Bool

      if let label = argument.label {
        guard
          let foundIndex = params.indices.first(where: {
            params[$0].firstName.text == label.text
          })
        else {
          let nearestParam = params[min(argIndex, params.count - 1)]
          throw ArgumentMatchError.unexpectedLabel(
            label: label,
            parameterLabel: nearestParam.firstName.text
          )
        }
        paramIndex = foundIndex
        isLabeled = true
        currentVariadicIndex = nil

        if paramIndex >= nextPositionalIndex {
          nextPositionalIndex = paramIndex + 1
        }
      } else {
        if let variadicIdx = currentVariadicIndex {
          paramIndex = variadicIdx
          isLabeled = false
        } else {
          guard
            let foundIndex = (nextPositionalIndex..<params.count).first(where: {
              params[$0].firstName.tokenKind == .wildcard
            })
          else {
            throw ArgumentMatchError.extraArguments(from: argIndex)
          }
          paramIndex = foundIndex
          isLabeled = false

          if params[paramIndex].ellipsis != nil {
            currentVariadicIndex = paramIndex
          } else {
            nextPositionalIndex = paramIndex + 1
          }
        }
      }

      let param = params[paramIndex]
      if param.ellipsis == nil && sourcesByParamIndex[paramIndex] != nil {
        throw ArgumentMatchError.extraArguments(from: argIndex)
      }
      sourcesByParamIndex[paramIndex, default: []].append(.explicit(argument.expression))
      if isLabeledByParamIndex[paramIndex] == nil {
        isLabeledByParamIndex[paramIndex] = isLabeled
      }
      isTrailingClosureByParamIndex[paramIndex] = false
    }

    // Process trailing closure
    if let trailingClosure = call.trailingClosure {
      let unmatchedIndices = params.indices.filter {
        sourcesByParamIndex[$0] == nil
      }
      guard !unmatchedIndices.isEmpty else {
        throw ArgumentMatchError.extraArguments(from: call.arguments.count)
      }

      let targetIndex =
        unmatchedIndices.first(where: { params[$0].firstName.tokenKind == .wildcard })
        ?? unmatchedIndices.first!

      let param = params[targetIndex]
      if param.ellipsis == nil && sourcesByParamIndex[targetIndex] != nil {
        throw ArgumentMatchError.extraArguments(from: call.arguments.count)
      }
      sourcesByParamIndex[targetIndex, default: []].append(.explicit(ExprSyntax(trailingClosure)))
      isLabeledByParamIndex[targetIndex] = false
      isTrailingClosureByParamIndex[targetIndex] = true
    }

    // Process additional trailing closures
    for additionalClosure in call.additionalTrailingClosures {
      let label = additionalClosure.label

      guard
        let foundIndex = params.indices.first(where: {
          params[$0].firstName.text == label.text
        })
      else {
        let nearestParam = params.last!
        throw ArgumentMatchError.unexpectedLabel(
          label: label,
          parameterLabel: nearestParam.firstName.text
        )
      }

      let param = params[foundIndex]
      if param.ellipsis == nil && sourcesByParamIndex[foundIndex] != nil {
        throw ArgumentMatchError.extraArguments(from: call.arguments.count)
      }
      sourcesByParamIndex[foundIndex, default: []].append(
        .explicit(ExprSyntax(additionalClosure.closure))
      )
      isLabeledByParamIndex[foundIndex] = true
      isTrailingClosureByParamIndex[foundIndex] = true
    }

    // Build final results
    var result: [ParameterMatch] = []
    result.reserveCapacity(params.count)

    for (index, param) in params.enumerated() {
      let intName = internalName(for: param)

      if let sources = sourcesByParamIndex[index] {
        let isLabeled = isLabeledByParamIndex[index] ?? false
        let isTrailingClosure = isTrailingClosureByParamIndex[index] ?? false

        if param.ellipsis != nil {
          // Variadic parameter - return as VariadicArgumentMatch
          result.append(
            .variadic(
              VariadicArgumentMatch(
                parameter: param,
                arguments: sources,
                internalName: intName,
                isLabeled: isLabeled
              )
            )
          )
        } else {
          // Non-variadic - should have exactly one source
          guard let source = sources.first else {
            throw ArgumentMatchError.missingArgument(parameterName: param.firstName.text)
          }
          result.append(
            .single(
              ArgumentMatch(
                parameter: param,
                source: source,
                internalName: intName,
                isLabeled: isLabeled,
                isTrailingClosure: isTrailingClosure
              )
            )
          )
        }
      } else if let defaultValue = param.defaultValue {
        // Synthesize default value
        result.append(
          .single(
            ArgumentMatch(
              parameter: param,
              source: .defaultValue(defaultValue.value),
              internalName: intName,
              isLabeled: param.firstName.tokenKind != .wildcard,
              isTrailingClosure: false
            )
          )
        )
      } else if param.ellipsis != nil {
        // Variadic parameter with no arguments
        result.append(
          .variadic(
            VariadicArgumentMatch(
              parameter: param,
              arguments: [],
              internalName: intName,
              isLabeled: param.firstName.tokenKind != .wildcard
            )
          )
        )
      } else {
        throw ArgumentMatchError.missingArgument(parameterName: param.firstName.text)
      }
    }

    return result
  }

  // MARK: - Subscript Support

  /// Match arguments of a subscript call against a subscript's parameter list.
  ///
  /// Subscript calls use `[]` syntax with arguments that match against the
  /// subscript declaration's parameter list, similar to function calls.
  ///
  /// - Parameters:
  ///   - arguments: The arguments inside the subscript brackets.
  ///   - parameters: The parameter list from the subscript declaration.
  /// - Returns: An array of ``ParameterMatch`` values, one per parameter.
  /// - Throws: ``ArgumentMatchError`` if the arguments cannot be matched.
  public static func matchSubscript(
    arguments: LabeledExprListSyntax,
    parameters: FunctionParameterListSyntax
  ) throws -> [ParameterMatch] {
    let args = Array(arguments)
    let params = Array(parameters)

    if params.isEmpty {
      if !args.isEmpty {
        throw ArgumentMatchError.extraArguments(from: 0)
      }
      return []
    }

    var sourcesByParamIndex: [Int: [ArgumentSource]] = [:]
    var isLabeledByParamIndex: [Int: Bool] = [:]
    var nextPositionalIndex = 0
    var currentVariadicIndex: Int?

    for (argIndex, argument) in args.enumerated() {
      let paramIndex: Int
      let isLabeled: Bool

      if let label = argument.label {
        guard
          let foundIndex = params.indices.first(where: {
            params[$0].firstName.text == label.text
          })
        else {
          let nearestParam = params[min(argIndex, params.count - 1)]
          throw ArgumentMatchError.unexpectedLabel(
            label: label,
            parameterLabel: nearestParam.firstName.text
          )
        }
        paramIndex = foundIndex
        isLabeled = true
        currentVariadicIndex = nil

        if paramIndex >= nextPositionalIndex {
          nextPositionalIndex = paramIndex + 1
        }
      } else {
        if let variadicIdx = currentVariadicIndex {
          paramIndex = variadicIdx
          isLabeled = false
        } else {
          guard
            let foundIndex = (nextPositionalIndex..<params.count).first(where: {
              params[$0].firstName.tokenKind == .wildcard
            })
          else {
            throw ArgumentMatchError.extraArguments(from: argIndex)
          }
          paramIndex = foundIndex
          isLabeled = false

          if params[paramIndex].ellipsis != nil {
            currentVariadicIndex = paramIndex
          } else {
            nextPositionalIndex = paramIndex + 1
          }
        }
      }

      let param = params[paramIndex]
      if param.ellipsis == nil && sourcesByParamIndex[paramIndex] != nil {
        throw ArgumentMatchError.extraArguments(from: argIndex)
      }
      sourcesByParamIndex[paramIndex, default: []].append(.explicit(argument.expression))
      if isLabeledByParamIndex[paramIndex] == nil {
        isLabeledByParamIndex[paramIndex] = isLabeled
      }
    }

    // Build final results
    var result: [ParameterMatch] = []
    result.reserveCapacity(params.count)

    for (index, param) in params.enumerated() {
      let intName = internalName(for: param)

      if let sources = sourcesByParamIndex[index] {
        let isLabeled = isLabeledByParamIndex[index] ?? false

        if param.ellipsis != nil {
          result.append(
            .variadic(
              VariadicArgumentMatch(
                parameter: param,
                arguments: sources,
                internalName: intName,
                isLabeled: isLabeled
              )
            )
          )
        } else {
          guard let source = sources.first else {
            throw ArgumentMatchError.missingArgument(parameterName: param.firstName.text)
          }
          result.append(
            .single(
              ArgumentMatch(
                parameter: param,
                source: source,
                internalName: intName,
                isLabeled: isLabeled,
                isTrailingClosure: false
              )
            )
          )
        }
      } else if let defaultValue = param.defaultValue {
        result.append(
          .single(
            ArgumentMatch(
              parameter: param,
              source: .defaultValue(defaultValue.value),
              internalName: intName,
              isLabeled: param.firstName.tokenKind != .wildcard,
              isTrailingClosure: false
            )
          )
        )
      } else if param.ellipsis != nil {
        result.append(
          .variadic(
            VariadicArgumentMatch(
              parameter: param,
              arguments: [],
              internalName: intName,
              isLabeled: param.firstName.tokenKind != .wildcard
            )
          )
        )
      } else {
        throw ArgumentMatchError.missingArgument(parameterName: param.firstName.text)
      }
    }

    return result
  }

  // MARK: - Closure Parameter Support

  /// Match arguments against a closure's parameter list.
  ///
  /// Closure parameters may have simpler syntax than function parameters
  /// (e.g., no default values). This method handles matching call arguments
  /// to closure parameter declarations.
  ///
  /// - Parameters:
  ///   - call: The call expression invoking the closure.
  ///   - parameters: The parameter list from the closure signature.
  /// - Returns: An array of ``ArgumentMatch`` values.
  /// - Throws: ``ArgumentMatchError`` if the arguments cannot be matched.
  public static func matchClosureCall(
    call: FunctionCallExprSyntax,
    parameters: ClosureParameterListSyntax
  ) throws -> [ArgumentMatch] {
    let arguments = Array(call.arguments)
    let params = Array(parameters)

    if arguments.isEmpty && params.isEmpty {
      return []
    }

    let hasVariadic = params.contains { $0.ellipsis != nil }

    if !hasVariadic && arguments.count > params.count {
      throw ArgumentMatchError.extraArguments(from: params.count)
    }

    var matches: [ArgumentMatch] = []
    matches.reserveCapacity(arguments.count)

    var nextPositionalIndex = 0
    var matchedParamIndices = Set<Int>()
    var currentVariadicIndex: Int?

    for (argIndex, argument) in arguments.enumerated() {
      let paramIndex: Int
      let isLabeled: Bool

      if let label = argument.label {
        guard
          let foundIndex = params.indices.first(where: {
            params[$0].firstName.text == label.text
          })
        else {
          let nearestParam = params[min(argIndex, params.count - 1)]
          throw ArgumentMatchError.unexpectedLabel(
            label: label,
            parameterLabel: nearestParam.firstName.text
          )
        }
        paramIndex = foundIndex
        isLabeled = true
        currentVariadicIndex = nil

        if paramIndex >= nextPositionalIndex {
          nextPositionalIndex = paramIndex + 1
        }
      } else {
        if let variadicIdx = currentVariadicIndex {
          paramIndex = variadicIdx
          isLabeled = false
        } else {
          guard
            let foundIndex = (nextPositionalIndex..<params.count).first(where: {
              params[$0].firstName.tokenKind == .wildcard
            })
          else {
            throw ArgumentMatchError.extraArguments(from: argIndex)
          }
          paramIndex = foundIndex
          isLabeled = false

          if params[paramIndex].ellipsis != nil {
            currentVariadicIndex = paramIndex
          } else {
            nextPositionalIndex = paramIndex + 1
          }
        }
      }

      let param = params[paramIndex]
      if param.ellipsis == nil && matchedParamIndices.contains(paramIndex) {
        throw ArgumentMatchError.extraArguments(from: argIndex)
      }
      matchedParamIndices.insert(paramIndex)

      matches.append(
        ArgumentMatch(
          parameter: closureParamToFunctionParam(param),
          argument: argument.expression,
          internalName: closureInternalName(for: param),
          isLabeled: isLabeled,
          isDefaulted: false,
          isTrailingClosure: false
        )
      )
    }

    // Verify all non-variadic parameters were supplied (closures don't have defaults)
    for (index, param) in params.enumerated() {
      guard !matchedParamIndices.contains(index) else { continue }
      if param.ellipsis != nil { continue }
      throw ArgumentMatchError.missingArgument(parameterName: param.firstName.text)
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

/// Returns the internal name for a closure parameter.
private func closureInternalName(for parameter: ClosureParameterSyntax) -> TokenSyntax {
  if let secondName = parameter.secondName {
    return secondName
  }
  return parameter.firstName
}

/// Converts a closure parameter to a function parameter for uniform handling.
///
/// This creates a minimal FunctionParameterSyntax that can be used in
/// ArgumentMatch for closure parameters.
private func closureParamToFunctionParam(_ param: ClosureParameterSyntax) -> FunctionParameterSyntax {
  FunctionParameterSyntax(
    firstName: param.firstName,
    secondName: param.secondName,
    colon: param.colon ?? TokenSyntax(.colon, presence: .missing),
    type: param.type ?? TypeSyntax(IdentifierTypeSyntax(name: .identifier("Any"))),
    ellipsis: param.ellipsis,
    trailingComma: param.trailingComma
  )
}
