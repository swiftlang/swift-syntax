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

// MARK: GlobalResolvedTypeSyntax

extension TypeResolver {
  /// A `GlobalNominalTypeRef` and the syntax that was resolved.
  @_spi(_QualifiedLookupTests)
  public struct GloballyResolvedTypeSyntax: CustomDebugStringConvertible, Sendable {
    public let type: TypeGraph.GlobalTypeRef
    public let syntax: Attached<TypeLikeSyntax>

    public var debugDescription: String {
      type.debugDescription
    }
  }
}

// MARK: ResolvedTypeSyntax

extension TypeResolver {
  /// A `NominalTypeRef` and the syntax that was resolved.
  @_spi(_QualifiedLookupTests)
  public struct ResolvedTypeSyntax: Sendable, CustomDebugStringConvertible {
    public let type: TypeGraph.TypeRef
    public let syntax: Attached<TypeLikeSyntax>

    public var debugDescription: String {
      type._succinctDescription
    }
  }
}

extension TypeResolver.ResolvedTypeSyntax {
  /// Map from a `GlobalNominalTypeRef` to a `NominalTypeRef`
  init(global: TypeResolver.GloballyResolvedTypeSyntax) {
    self.init(
      type: TypeGraph.TypeRef.global(global.type),
      syntax: global.syntax
    )
  }
}

// MARK: ResolvedType

extension TypeResolver {
  /// The type result of structural type resolution. `Result`
  /// represents a nominal type.
  @_spi(_QualifiedLookupTests)
  public enum TypeResult: Sendable {
    /// E.g. `(A) -> ()`
    case function(argumentCount: Int)
    /// E.g. `(a: A, _: B)`
    case tuple(labels: [Identifier?])
    /// Either a single type or a composition of protocols/classes.
    case nominalTypes([ResolvedTypeSyntax])
    /// `Any` or suppressed types like `~Copyable`
    case anyType
    /// E.g. `A.Type`, `((A, B).Type).Type`
    indirect case metatype(base: TypeResult)
    // E.g. no type `A` in scope
    indirect case failure(Failure)

    /// Maps the nominal types in `nominalTypes`.
    @_spi(_QualifiedLookupTests)
    public func _visitNominals(
      _ visit: (TypeGraph.TypeRef) -> Void
    ) {
      switch self {
      case .function, .tuple, .anyType:
        break
      case .metatype(let base):
        base._visitNominals(visit)
      case .nominalTypes(let results):
        for result in results {
          visit(result.type)
        }
      case .failure(let failure):
        failure._visitNominals(visit)
      }
    }
  }
}

// MARK: Debug Description

extension TypeResolver.TypeResult: CustomDebugStringConvertible {
  @_spi(_QualifiedLookupTests)
  public var debugDescription: String {
    switch self {
    case .function(let argumentCount):
      return ".function(argumentCount: \(argumentCount))"
    case .tuple(let labels):
      return ".tuple(\(labels.map({ $0?.name ?? "_"})))"
    case .anyType:
      return ".anyType"
    case .metatype(let base):
      return ".metatype(base: \(base.debugDescription))"
    case .nominalTypes(let members):
      return ".nominalTypes([\(members.map(\.debugDescription).joined(separator: ", "))])"
    case .failure(let failure):
      return ".failure(\(failure.debugDescription))"
    }
  }

  /// A succinct description focusing on the produced nominal types.
  var _succinctDescription: String {
    switch self {
    case .nominalTypes(let baseTypes):
      return baseTypes.map(\.type._succinctDescription).joined(separator: " & ")
    case .function:
      return "<function>"
    case .tuple:
      return "<tuple>"
    case .anyType:
      return "<any>"
    case .metatype:
      return "<metatype>"
    case .failure:
      return "<failure>"
    }
  }
}

// MARK: ResolvedTypeSyntax + Test Hook

extension TypeResolver.ResolvedTypeSyntax {
  /// Creates a mock `ResolvedTypeSyntax` where `unusedNominalDecl` can be any
  /// `Attached<NominalTypeDeclSyntax>` instance and isn't used to produce a
  /// description.
  @_spi(_QualifiedLookupTests)
  public static func _mock(
    typeRef: TypeGraph.TypeRef,
    unusedNominalDecl: Attached<NominalTypeDeclSyntax>
  ) -> TypeResolver.ResolvedTypeSyntax {
    TypeResolver.ResolvedTypeSyntax(
      type: typeRef,
      syntax: Attached<TypeLikeSyntax>(unusedNominalDecl)
    )
  }
}
