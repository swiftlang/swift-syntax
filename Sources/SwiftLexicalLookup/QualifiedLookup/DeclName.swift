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

import SwiftSyntax

// MARK: DeclName

/// The labels of function / subscript / enum element arguments used for lookup.//
/// A `nil` identifier indicates a `_` or nonexistent label, e.g. `init(_ param: Int)`
/// or `case myCase(Int)`.
/// TODO: Think about how to handle variadic (parameters + param packs) and trailing closures
@_spi(_QualifiedLookup) public typealias DeclNameArguments = [Identifier?]

/// The "canonical" name of a value declaration, accessible through
/// ``ValueDeclSyntax/declName``.
///
/// We use ``DeclName`` because it strips away low-level information, such as a
/// node's trivia, leaving us with a `Hashable` name that we can use in lookup.
@_spi(_QualifiedLookup) public indirect enum DeclName: Hashable, CustomDebugStringConvertible {
  /// A macro can be freestanding and/or attached.
  ///
  /// Both flags are off when the user failed to specify
  /// their macro's type.
  @_spi(_QualifiedLookup) public struct MacroType: Hashable {
    public let isFreestanding: Bool
    public let isAttached: Bool

    public init(isFreestanding: Bool, isAttached: Bool) {
      self.isFreestanding = isFreestanding
      self.isAttached = isAttached
    }
  }

  /// A macro declaration name formed by an identifier and, possibly, an argument list.
  case macro(type: MacroType, identifier: Identifier, arguments: DeclNameArguments?)

  /// A declaration name formed by an identifier and, possibly, an argument list.
  case identifier(identifier: Identifier, arguments: DeclNameArguments?)

  /// A declaration name formed by token syntax that isn't a valid identifier
  /// and, possibly, an argument list.
  ///
  /// Note that `nonIdentifier` is a ``TokenKind`` instead of `TokenSyntax`
  /// because the latter tracks things like leading and trailing trivia which
  /// makes comparisons harder.
  case invalid(nonIdentifier: TokenKind, macro: MacroType? = nil, arguments: DeclNameArguments?)

  /// An instance method named `callAsFunction` can be applied called as
  /// `instance.callAsFunction(...)`, or equivalently `instance(...)`.
  /// See [proposal](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0253-callable.md)
  case callAsFunction(arguments: DeclNameArguments)
  case `init`(arguments: DeclNameArguments)

  // Special names, i.e. names the user can't directly look up.

  /// Deinit can't be looked up via a user query, e.g. `MyClass.deinit` ❌.
  /// However, tooling may look for deinits in a class.
  case `deinit`
  /// Similar to deinits, subscripts can't be referenced directly. Tooling
  /// may look them up by getting the name of a SubscriptCallExpr.
  case `subscript`(arguments: DeclNameArguments)

  /// Tries to construct a regular name by extracting an identifier from the given token
  /// and attaching the given arguments. Returns invalid name otherwise.
  static func fromToken(
    _ token: TokenSyntax,
    macro: MacroType? = nil,
    arguments: DeclNameArguments?
  ) -> DeclName {
    guard let identifier = Identifier(validating: token) else {
      return DeclName.invalid(nonIdentifier: token.tokenKind, macro: macro, arguments: arguments)
    }
    if let macroType = macro {
      return DeclName.macro(type: macroType, identifier: identifier, arguments: arguments)
    } else {
      return DeclName.identifier(identifier: identifier, arguments: arguments)
    }
  }

  @_spi(_QualifiedLookup) public var debugDescription: String {
    /// Create a debug string for the given arguments. The argument list is
    /// empty when `argyments == nil`. Enclose in parentheses if `withParens == true`.
    func describeArguments(_ arguments: DeclNameArguments?, withParentheses: Bool = true) -> String {
      guard let arguments else { return "" }
      // Arguments have the form `(arg1:arg2:...)`. Arguments without labels
      // use an underscore.
      let argumentList = arguments.map({ ($0?.name ?? "_") + ":" }).joined(separator: "")
      return if withParentheses { "(\(argumentList))" } else { argumentList }
    }

    /// If not `nil`, generate prefix for macro type.
    func describeMacro(_ macroType: MacroType?) -> String {
      guard let macroType else { return "" }
      // Match freestanding/attached
      return switch (macroType.isFreestanding, macroType.isAttached) {
      case (true, true): "(#/@)"
      case (true, false): "#"
      case (false, true): "@"
      case (false, false): "(??)"
      }
    }

    let baseName: String =
      switch self {
      case .macro(let macroType, let identifier, let arguments):
        "\(describeMacro(macroType))\(identifier.name)\(describeArguments(arguments))"
      case .identifier(let identifier, let arguments):
        "\(identifier.name)\(describeArguments(arguments))"
      case .invalid(let nonIdentifier, let macro, let arguments):
        "\(describeMacro(macro))<?\(nonIdentifier)?>\(describeArguments(arguments))"
      case .callAsFunction(let arguments):
        "*callAsFunction*\(describeArguments(arguments))"
      case .subscript(let arguments):
        "[\(describeArguments(arguments, withParentheses: false))]"
      case .`init`(let arguments):
        "*init*\(describeArguments(arguments))"
      // Trivial cases
      case .deinit:
        "*deinit*"
      }

    return "''\(baseName)''"
  }
}

// MARK: DeclNameReference

/// Similar to `DeclNameReference` but allows referring to a declaration by writing
/// non-compound name, e.g. we can refer to the init in `struct A { init(a: Int) {} }`
/// both as `A.init(a:)` and `A.init`.
@_spi(_QualifiedLookup) public indirect enum DeclNameReferenceBase: Hashable, CustomDebugStringConvertible {
  /// A macro reference is either freestanding or attached
  public enum MacroReference: Hashable {
    case freestanding
    case attached
  }

  case macro(reference: MacroReference, identifier: Identifier, arguments: DeclNameArguments? = nil)

  /// Like `DeclName/identifier` but with a specific macro reference.
  ///
  /// Unlike `DeclName`, this could include `callAsFunction`.
  case identifier(identifier: Identifier, arguments: DeclNameArguments? = nil)

  /// An explicit reference to init. E.g. `MyType.init`. Note that the user
  /// may not specify arguments when just referencing init.
  case `init`(arguments: DeclNameArguments?)

  /// An unnamed call could refer to an init in a static context
  /// or a `callAsFunction` if it's an instance. It could also
  /// refer to `@dynamicallyCallable` or `@dynamicMemberLookup`.
  case unnamedCall(arguments: DeclNameArguments)

  // Special names, i.e. names the user can't directly look up.

  /// Only tooling can reference deinits.
  case `deinit`

  case `self`
  case `Type`
  case `Protocol`

  /// Similar to deinits, subscripts can't be referenced directly. Tooling
  /// may look them up by getting the name of a SubscriptCallExpr.
  case `subscript`(arguments: DeclNameArguments)

  public var debugDescription: String {
    /// Create a debug string for the given arguments. The argument list is
    /// empty when `argyments == nil`. Enclose in parentheses if `withParens == true`.
    func describeArguments(_ arguments: DeclNameArguments?, withParentheses: Bool = true) -> String {
      guard let arguments else { return "" }
      // Argyments have the form `(arg1:arg2:...)`. Arguments without labels
      // use an underscore.
      let argumentList = arguments.map({ ($0?.name ?? "_") + ":" }).joined(separator: "")
      return if withParentheses { "(\(argumentList))" } else { argumentList }
    }

    let baseName: String
    switch self {
    case .macro(let macroRef, let identifier, let args):
      let prefix =
        switch macroRef {
        case .attached: "@"  // e.g. `@Observable`
        case .freestanding: "#"  // e.g. `#file`
        }
      baseName = "\(prefix)\(identifier.name)\(describeArguments(args))"
    case .identifier(let identifier, let args):
      baseName = "\(identifier.name)\(describeArguments(args))"

    case .subscript(let args): baseName = "[\(describeArguments(args, withParentheses: false))]"
    case .unnamedCall(let args): baseName = describeArguments(args)
    case .`init`(let args): baseName = "*init*\(describeArguments(args))"
    // Trivial cases
    case .deinit: baseName = "*deinit*"
    case .self: baseName = "*self*"
    case .Type: baseName = "*Type*"
    case .Protocol: baseName = "*Protocol*"
    }

    return "`\(baseName)`"
  }
}

/// A named reference to a declaration, consisting of a possible module selector and the
/// actual declaration name reference.
///
/// This type is used in queries, such as qualified name lookup.
@_spi(_QualifiedLookup) public struct DeclNameReference: Hashable, CustomDebugStringConvertible {
  /// A possible module identifier corresponding to a ``ModuleSelectorSyntax``.
  ///
  /// Examples include "Swift" in `Swift::String`
  public let moduleIdentifier: Identifier?
  /// The base name reference.
  public let baseName: DeclNameReferenceBase

  public init(moduleIdentifier: Identifier? = nil, baseName: DeclNameReferenceBase) {
    self.moduleIdentifier = moduleIdentifier
    self.baseName = baseName
  }

  public var debugDescription: String {
    let modulePrefix = if let moduleIdentifier { "\(moduleIdentifier.name)::" } else { "" }
    return "\(modulePrefix)\(baseName.debugDescription)"
  }
}

// MARK: Name Matching

// Check whether a declaration name matches a reference.
extension DeclName {
  /// The reason the given reference doesn't match the declaration name.
  public enum MatchFailure: Error {
    case idMismatch
    case noMatch
    case wrongMacroType
    case argumentMismatch
    case macroMismatch
    case missingMacroArguments
  }
  /// Try to match this declaration's name with the given reference.
  /// - Returns: `.success` for a positive match, or `.failure` with the reason
  ///            the match failed.
  public func tryMatch(reference: DeclNameReferenceBase) -> Result<Void, MatchFailure> {
    let callAsFunctionId = Identifier(canonicalName: "callAsFunction")

    switch (self, reference) {
    // Deinits always match
    case (.deinit, .deinit):
      return .success(())

    // Match init if reference doesn't provide arguments.
    case (.`init`(_), .`init`(arguments: nil)),
      (.callAsFunction(arguments: _), .identifier(identifier: callAsFunctionId, arguments: nil)):
      return .success(())
    // For inits (named and unnamed), subscripts and `callAsFunction` (named and unnamed),
    // check that arguments match.
    //
    // Recall that init can be referenced both as `<Type>.init(...)` and
    // as `<Type>(...)` (represented by ``unnamedCall``).
    //
    // Similarly, we can do both `<myValue>.callAsFunction(...)` and `<myValue>(...)`
    case (.`init`(let argsA), .unnamedCall(let argsB)),
      (.`init`(let argsA), .`init`(let argsB?)),
      (.subscript(let argsA), .subscript(let argsB)),
      (.callAsFunction(let argsA), .unnamedCall(let argsB)),
      (
        .callAsFunction(let argsA),
        .identifier(identifier: callAsFunctionId, let argsB?)
      ):
      guard argsA == argsB else { return .failure(MatchFailure.argumentMismatch) }
      return .success(())
    // Macros need to have matching type, identifiers and arguments
    case let (.macro(macroType, idA, declaredArgs), .macro(macroRef, idB, providedArgs)):
      // Check macro type
      //
      // E.g. We can't match `@Observable` with `#Observable`.
      let macroMatches =
        switch macroRef {
        case .freestanding: macroType.isFreestanding
        case .attached: macroType.isAttached
        }
      guard macroMatches else { return .failure(MatchFailure.wrongMacroType) }

      // Check ids
      guard idA == idB else { return .failure(MatchFailure.idMismatch) }

      // Only check arguments if the declaration requires them
      //
      // Note that if the macro takes no arguments, we could still supply arguments
      // to the result type if it's callable. For instance, imagine a macro
      // `#myMacro() = ...` returning `(Int) -> Void`. We could write `#myMacro(5)`.
      //
      // Further, if the macro declaration has arguments, we do need the caller to
      // pass those in to perform the expansion. This behavior differs from functions
      // as we can have a function `f(a: Int)` and legally reference `f` of
      // type `(Int) -> Void`.
      if let declaredArgs = declaredArgs, declaredArgs != providedArgs {
        return .failure(MatchFailure.missingMacroArguments)
      }

      return .success(())
    // Identifiers need to check macro type, identifiers and arguments
    case let (.identifier(idA, declaredArgs), .identifier(idB, providedArgs)):
      // Check ids match
      guard idA == idB else { return .failure(MatchFailure.idMismatch) }

      // Check args only if both the declaration and reference specify them.
      //
      // Here are some valid examples:
      // 1. Neither declaration nor reference have args:
      //      let a = 5
      //      a // Reference "a" has type "Int"
      // 2. Declaration has args, but reference doesn't:
      //      func f(x: Int) {}
      //      let ref = f // Reference "f" has type "(Int) -> Void"
      // 3. Declaration has no args, but reference does:
      //      let f = { 5 }
      //      f(5) // Reference "f" has type Int
      //    Note that in this example there's one, unlabeled argument.
      // func f(x: Int) {}
      if let argsA = declaredArgs, let argsB = providedArgs, argsA != argsB {
        return .failure(MatchFailure.argumentMismatch)
      }

      return .success(())
    default:
      return .failure(MatchFailure.noMatch)
    }
  }
}
