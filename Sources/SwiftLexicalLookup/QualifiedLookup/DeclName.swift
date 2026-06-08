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

import SwiftSyntax

// MARK: DeclName

/// The labels of function / subscript / enum element arguments used for lookup.//
/// A `nil` identifier indicates a `_` or nonexistent label, e.g. `init(_ param: Int)`
/// or `case myCase(Int)`.
/// TODO: Think about how to handle variadic (parameters + param packs) and trailing closures
@_spi(_QualifiedLookup) public typealias DeclNameArgs = [Identifier?]

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

  /// A declaration name formed by an identifier and, possibly, an argument list.
  ///
  /// Regular declarations like functions have `macro == nil` and only macros
  /// set `MacroType`.
  case identifier(macro: MacroType? = nil, identifier: Identifier, args: DeclNameArgs?)

  /// A declaration name formed by token syntax that isn't a valid identifier
  /// and, possibly, an argument list.
  ///
  /// Note that `nonIdentifier` is a ``TokenKind`` instead of `TokenSyntax`
  /// because the latter tracks things like leading and trailing trivia which
  /// makes comparisons harder.
  case invalid(nonIdentifier: TokenKind, macro: MacroType? = nil, args: DeclNameArgs?)

  /// An instance method named `callAsFunction` can be applied called as
  /// `instance.callAsFunction(...)`, or equivalently `instance(...)`.
  /// See [proposal](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0253-callable.md)
  case callAsFunction(args: DeclNameArgs)
  case `init`(args: DeclNameArgs)

  // Special names, i.e. names the user can't directly look up.

  /// Deinit can't be looked up via a user query, e.g. `MyClass.deinit` ❌.
  /// However, tooling may look for deinits in a class.
  case `deinit`
  /// Similar to deinits, subscripts can't be referenced directly. Tooling
  /// may look them up by getting the name of a SubscriptCallExpr.
  case `subscript`(args: DeclNameArgs)

  /// Tries to construct a regular name by extracting an identifier from the given token
  /// and attaching the given args. Returns invalid name otherwise.
  static func fromToken(
    _ token: TokenSyntax,
    macro: MacroType? = nil,
    args: DeclNameArgs?
  ) -> DeclName {
    guard let identifier = Identifier(validating: token) else {
      return DeclName.invalid(nonIdentifier: token.tokenKind, macro: macro, args: args)
    }
    return DeclName.identifier(macro: macro, identifier: identifier, args: args)
  }

  @_spi(_QualifiedLookup) public var debugDescription: String {
    /// Create a debug string for the given arguments. The argument list is
    /// empty when `args == nil`. Enclose in parentheses if `withParens == true`.
    func describeArgs(_ args: DeclNameArgs?, withParens: Bool = true) -> String {
      guard let args else { return "" }
      // Args have the form `(arg1:arg2:...)`. Args without labels
      // use an underscore.
      let argList = args.map({ ($0?.name ?? "_") + ":" }).joined(separator: "")
      return if withParens { "(\(argList))" } else { argList }
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
      case .identifier(let macro, let identifier, let args):
        "\(describeMacro(macro))\(identifier.name)\(describeArgs(args))"

      case .invalid(let nonIdentifier, let macro, let args):
        "\(describeMacro(macro))<?\(nonIdentifier)?>\(describeArgs(args))"
      case .callAsFunction(let args): "*callAsFunction*\(describeArgs(args))"

      case .subscript(let args): "[\(describeArgs(args, withParens: false))]"
      case .`init`(let args): "*init*\(describeArgs(args))"
      // Trivial cases
      case .deinit: "*deinit*"
      }

    return "''\(baseName)''"
  }
}

// MARK: DeclNameRef

/// Similar to `DeclNameRef` but allows referring to a declaration by writing
/// non-compound name, e.g. we can refer to the init in `struct A { init(a: Int) {} }`
/// both as `A.init(a:)` and `A.init`.
@_spi(_QualifiedLookup) public indirect enum DeclNameRefBase: Hashable, CustomDebugStringConvertible {
  /// A macro reference is either freestanding or attached
  public enum MacroReference: Hashable {
    case freestanding
    case attached
  }

  /// Like `DeclName/identifier` but with a specific macro reference.
  ///
  /// Unlike `DeclName`, this could include `callAsFunction`.
  case identifier(macro: MacroReference? = nil, identifier: Identifier, args: DeclNameArgs? = nil)

  /// An explicit reference to init. E.g. `MyType.init`. Note that the user
  /// may not specify arguments when just referencing init.
  case `init`(args: DeclNameArgs?)

  /// An unnamed call could refer to an init in a static context
  /// or a `callAsFunction` if it's an instance. It could also
  /// refer to `@dynamicallyCallable` or `@dynamicMemberLookup`.
  case unnamedCall(args: DeclNameArgs)

  // Special names, i.e. names the user can't directly look up.

  /// Only tooling can reference deinits.
  case `deinit`

  case `self`
  case `Type`
  case `Protocol`

  /// Similar to deinits, subscripts can't be referenced directly. Tooling
  /// may look them up by getting the name of a SubscriptCallExpr.
  case `subscript`(args: DeclNameArgs)

  public var debugDescription: String {
    /// Create a debug string for the given arguments. The argument list is
    /// empty when `args == nil`. Enclose in parentheses if `withParens == true`.
    func describeArgs(_ args: DeclNameArgs?, withParens: Bool = true) -> String {
      guard let args else { return "" }
      // Args have the form `(arg1:arg2:...)`. Args without labels
      // use an underscore.
      let argList = args.map({ ($0?.name ?? "_") + ":" }).joined(separator: "")
      return if withParens { "(\(argList))" } else { argList }
    }

    let baseName: String
    switch self {
    case .identifier(let macroRef, let identifier, let args):
      let prefix =
        switch macroRef {
        case nil: ""  // e.g. `Int`
        case .attached: "@"  // e.g. `@Observable`
        case .freestanding: "#"  // e.g. `#file`
        }
      baseName = "\(prefix)\(identifier.name)\(describeArgs(args))"

    case .subscript(let args): baseName = "[\(describeArgs(args, withParens: false))]"
    case .unnamedCall(let args): baseName = describeArgs(args)
    case .`init`(let args): baseName = "*init*\(describeArgs(args))"
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
@_spi(_QualifiedLookup) public struct DeclNameRef: Hashable, CustomDebugStringConvertible {
  /// A possible module identifier corresponding to a ``ModuleSelectorSyntax``.
  ///
  /// Examples include "Swift" in `Swift::String`
  public let moduleIdentifier: Identifier?
  /// The base name reference.
  public let baseName: DeclNameRefBase

  public init(moduleIdentifier: Identifier? = nil, baseName: DeclNameRefBase) {
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
  }
  /// Try to match this declaration's name with the given reference.
  /// - Returns: `.success` for a positive match, or `.failure` with the reason
  ///            the match failed.
  public func tryMatch(reference: DeclNameRefBase) -> Result<Void, MatchFailure> {
    let callAsFunctionId = Identifier(canonicalName: "callAsFunction")

    switch (self, reference) {
    // Deinits always match
    case (.deinit, .deinit):
      return .success(())

    // Match init if reference doesn't provide arguments.
    case (.`init`(_), .`init`(args: nil)),
      (.callAsFunction(args: _), .identifier(macro: nil, identifier: callAsFunctionId, args: nil)):
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
        .identifier(nil, identifier: callAsFunctionId, let argsB?)
      ):
      guard argsA == argsB else { return .failure(MatchFailure.argumentMismatch) }
      return .success(())
    // Identifiers need to check macro type, identifiers and arguments
    case let (.identifier(macroType, idA, optionalArgsA), .identifier(macroRef, idB, optionalArgsB)):
      // Check if macro types match
      //
      // E.g. If we're expecting `@Observable` we can match with neither
      // `#Observable` nor `Observable`
      let macroMatches =
        switch (macroType, macroRef) {
        case (nil, nil): true
        case (let macroType?, .freestanding): macroType.isFreestanding
        case (let macroType?, .attached): macroType.isAttached
        default: false
        }
      guard macroMatches else { return .failure(MatchFailure.wrongMacroType) }

      // Check ids match
      print(
        "[Lookup Debugging] Match between .identifier; id match between '\(idA.name)' and '\(idB.name)': \(idA == idB)"
      )
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
      if let argsA = optionalArgsA, let argsB = optionalArgsB, argsA != argsB {
        return .failure(MatchFailure.argumentMismatch)
      }

      return .success(())
    default:
      return .failure(MatchFailure.noMatch)
    }
  }
}
