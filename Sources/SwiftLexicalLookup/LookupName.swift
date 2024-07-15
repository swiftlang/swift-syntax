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

@_spi(Experimental) public enum LookupName {
  /// Identifier associated with the name.
  /// Could be an identifier of a variable, function or closure parameter and more
  case identifier(IdentifiableSyntax, accessibleAfter: AbsolutePosition?)
  /// Declaration associated with the name.
  /// Could be class, struct, actor, protocol, function and more
  case declaration(NamedDeclSyntax, accessibleAfter: AbsolutePosition?)

  /// Syntax associated with this name.
  @_spi(Experimental) public var syntax: SyntaxProtocol {
    switch self {
    case .identifier(let syntax, _):
      syntax
    case .declaration(let syntax, _):
      syntax
    }
  }

  /// Introduced name.
  @_spi(Experimental) public var name: String {
    switch self {
    case .identifier(let syntax, _):
      syntax.identifier.text
    case .declaration(let syntax, _):
      syntax.name.text
    }
  }

  /// Point, after which the name is available in scope.
  /// If set to `nil`, the name is available at any point in scope.
  var accessibleAfter: AbsolutePosition? {
    switch self {
    case .identifier(_, let absolutePosition):
      absolutePosition
    case .declaration(_, let absolutePosition):
      absolutePosition
    }
  }

  /// Checks if this name was introduced before the syntax used for lookup.
  func isAccessible(at lookedUpSyntax: SyntaxProtocol) -> Bool {
    guard let accessibleAfter else { return true }
    return accessibleAfter <= lookedUpSyntax.position
  }

  /// Checks if this name refers to the looked up phrase.
  func refersTo(_ lookedUpName: String) -> Bool {
    name == lookedUpName
  }

  /// Extracts names introduced by the given `from` structure.
  static func getNames(from syntax: SyntaxProtocol, accessibleAfter: AbsolutePosition? = nil) -> [LookupName] {
    switch Syntax(syntax).as(SyntaxEnum.self) {
    case .variableDecl(let variableDecl):
      variableDecl.bindings.flatMap { binding in
        getNames(from: binding.pattern, accessibleAfter: accessibleAfter)
      }
    case .tuplePattern(let tuplePattern):
      tuplePattern.elements.flatMap { tupleElement in
        getNames(from: tupleElement.pattern, accessibleAfter: accessibleAfter)
      }
    case .valueBindingPattern(let valueBindingPattern):
      getNames(from: valueBindingPattern.pattern, accessibleAfter: accessibleAfter)
    case .expressionPattern(let expressionPattern):
      getNames(from: expressionPattern.expression, accessibleAfter: accessibleAfter)
    case .sequenceExpr(let sequenceExpr):
      sequenceExpr.elements.flatMap { expression in
        getNames(from: expression, accessibleAfter: accessibleAfter)
      }
    case .patternExpr(let patternExpr):
      getNames(from: patternExpr.pattern, accessibleAfter: accessibleAfter)
    case .optionalBindingCondition(let optionalBinding):
      getNames(from: optionalBinding.pattern, accessibleAfter: accessibleAfter)
    case .matchingPatternCondition(let matchingPatternCondition):
      getNames(from: matchingPatternCondition.pattern, accessibleAfter: accessibleAfter)
    case .functionCallExpr(let functionCallExpr):
      functionCallExpr.arguments.flatMap { argument in
        getNames(from: argument.expression, accessibleAfter: accessibleAfter)
      }
    default:
      if let namedDecl = Syntax(syntax).asProtocol(SyntaxProtocol.self) as? NamedDeclSyntax {
        handle(namedDecl: namedDecl, accessibleAfter: accessibleAfter)
      } else if let identifiable = Syntax(syntax).asProtocol(SyntaxProtocol.self) as? IdentifiableSyntax {
        handle(identifiable: identifiable, accessibleAfter: accessibleAfter)
      } else {
        []
      }
    }
  }

  /// Extracts name introduced by `IdentifiableSyntax` node.
  private static func handle(identifiable: IdentifiableSyntax, accessibleAfter: AbsolutePosition? = nil) -> [LookupName]
  {
    if identifiable.identifier.text != "_" {
      return [.identifier(identifiable, accessibleAfter: accessibleAfter)]
    } else {
      return []
    }
  }

  /// Extracts name introduced by `NamedDeclSyntax` node.
  private static func handle(namedDecl: NamedDeclSyntax, accessibleAfter: AbsolutePosition? = nil) -> [LookupName] {
    [.declaration(namedDecl, accessibleAfter: accessibleAfter)]
  }
}
