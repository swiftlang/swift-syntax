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
  /// `self` keyword representing object instance.
  case `self`(DeclSyntaxProtocol)
  /// `Self` keyword representing object type.
  case `Self`(DeclSyntaxProtocol)
  /// `self` captured by a closure.
  case selfCaptured(ClosureCaptureSyntax)
  /// `error` available inside `catch` clause.
  case error(CatchClauseSyntax)
  /// `newValue` available by default inside `set` and `willSet`.
  case newValue(AccessorDeclSyntax)
  /// `oldValue` available by default inside `didSet`.
  case oldValue(AccessorDeclSyntax)

  /// Syntax associated with this name.
  @_spi(Experimental) public var syntax: SyntaxProtocol {
    switch self {
    case .identifier(let syntax, _):
      syntax
    case .declaration(let syntax, _):
      syntax
    case .self(let syntax):
      syntax
    case .Self(let syntax):
      syntax
    case .selfCaptured(let syntax):
      syntax
    case .error(let syntax):
      syntax
    case .newValue(let syntax):
      syntax
    case .oldValue(let syntax):
      syntax
    }
  }

  /// Introduced name.
  @_spi(Experimental) public var identifier: Identifier? {
    switch self {
    case .identifier(let syntax, _):
      Identifier(syntax.identifier)
    case .declaration(let syntax, _):
      Identifier(syntax.name)
    default:
      nil
    }
  }

  /// Point, after which the name is available in scope.
  /// If set to `nil`, the name is available at any point in scope.
  var accessibleAfter: AbsolutePosition? {
    switch self {
    case .identifier(_, let absolutePosition), .declaration(_, let absolutePosition):
      absolutePosition
    default:
      nil
    }
  }

  /// Used for name comparison.
  var name: String? {
    switch self {
    case .identifier, .declaration:
      identifier?.name
    case .self, .selfCaptured:
      "self"
    case .Self:
      "Self"
    case .error:
      "error"
    case .newValue:
      "newValue"
    case .oldValue:
      "oldValue"
    }
  }

  /// Checks if this name was introduced before the syntax used for lookup.
  func isAccessible(at lookedUpSyntax: SyntaxProtocol) -> Bool {
    guard let accessibleAfter else { return true }
    return accessibleAfter <= lookedUpSyntax.position
  }

  /// Checks if this name refers to the looked up phrase.
  func refersTo(_ lookedUpName: String) -> Bool {
    guard let name else { return false }
    return name == lookedUpName
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
    if let closureCapture = identifiable as? ClosureCaptureSyntax,
      closureCapture.identifier.tokenKind == .keyword(.self)
    {
      return [.selfCaptured(closureCapture)]  // Handle `self` closure capture.
    } else if identifiable.identifier.text != "_" {
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
