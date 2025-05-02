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
//
// This file implements inference of "nonisolated" on the conformances that
// occur within macro-expanded code. It's meant to provide source compatibility
//

import SwiftSyntax

extension SyntaxProtocol {
  /// Given some Swift syntax that may contain type definitions and extensions,
  /// add "nonisolated" to protocol conformances when there are nonisolated
  /// members. For example, given:
  ///
  ///     extension X: P {
  ///       nonisolated func f() { }
  ///     }
  ///
  /// this operation will produce:
  ///
  ///     extension X: nonisolated P {
  ///       nonisolated func f() { }
  ///     }
  @_spi(Testing) @_spi(Compiler)
  public func inferNonisolatedConformances() -> Syntax {
    let rewriter = NonisolatedConformanceRewriter()
    return rewriter.rewrite(self)
  }
}

fileprivate class NonisolatedConformanceRewriter: SyntaxRewriter {
  override func visitAny(_ node: Syntax) -> Syntax? {
    // We only care about decl groups (non-protocol nominal types + extensions)
    // that have nonisolated members and an inheritance clause.
    guard let declGroup = node.asProtocol(DeclGroupSyntax.self),
      !declGroup.is(ProtocolDeclSyntax.self),
      declGroup.containsNonisolatedMembers,
      let inheritanceClause = declGroup.inheritanceClause
    else {
      return nil
    }

    var skipFirst =
      declGroup.is(ClassDeclSyntax.self)
      || (declGroup.is(EnumDeclSyntax.self) && inheritanceClause.inheritedTypes.first?.looksLikeEnumRawType ?? false)
    let inheritedTypes = inheritanceClause.inheritedTypes.map { inheritedType in
      // If there's already a 'nonisolated' or some kind of custom attribute
      if inheritedType.type.hasNonisolatedOrCustomAttribute {
        return inheritedType
      }

      if skipFirst {
        skipFirst = false
        return inheritedType
      }

      return inheritedType.with(\.type, "nonisolated \(inheritedType.type)")
    }

    return Syntax(
      fromProtocol: declGroup.with(
        \.inheritanceClause,
        inheritanceClause.with(
          \.inheritedTypes,
          InheritedTypeListSyntax(inheritedTypes)
        )
      )
    )
  }
}

extension TypeSyntax {
  /// Determine whether the given type has a 'nonisolated' specifier or a
  /// custom attribute (that could be a global actor).
  fileprivate var hasNonisolatedOrCustomAttribute: Bool {
    var type = self
    while let attributedType = type.as(AttributedTypeSyntax.self) {
      // nonisolated
      let hasNonisolated = attributedType.specifiers.contains { specifier in
        if case .nonisolatedTypeSpecifier = specifier {
          return true
        }

        return false
      }
      if hasNonisolated {
        return true
      }

      // Any attribute will do.
      if !attributedType.attributes.isEmpty {
        return true
      }

      type = attributedType.baseType
    }

    return false
  }
}

extension InheritedTypeSyntax {
  /// Determine whether this inherited type "looks like" a raw type, e.g.,
  /// if it's one of the integer types or String. This can only be an heuristic,
  /// because it does not
  fileprivate var looksLikeEnumRawType: Bool {
    // TODO: We could probably use a utility to syntactically recognize types
    // from the
    var text = type.trimmed.description[...]
    if text.starts(with: "Swift.") {
      text = text.dropFirst(6)
    }

    switch text {
    case "Int", "Int8", "Int16", "Int32", "Int64",
      "UInt", "UInt8", "UInt16", "UInt32", "UInt64",
      "String":
      return true

    default: return false
    }
  }
}
extension DeclModifierListSyntax {
  /// Whether the modifier list contains "nonisolated".
  fileprivate var hasNonisolated: Bool {
    contains { $0.name.tokenKind == .keyword(.nonisolated) }
  }
}

extension DeclGroupSyntax {
  /// Determine whether any of members is marked "nonisolated.
  fileprivate var containsNonisolatedMembers: Bool {
    memberBlock.members.lazy.map(\.decl).contains {
      $0.asProtocol(WithModifiersSyntax.self)?.modifiers.hasNonisolated ?? false
    }
  }
}
