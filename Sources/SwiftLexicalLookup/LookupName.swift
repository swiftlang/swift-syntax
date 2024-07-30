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

@_spi(Experimental) public enum LookupImplicitNameKind {
  /// `self` keyword representing object instance.
  case `self`(SyntaxProtocol)
  /// `Self` keyword representing object type.
  case `Self`(DeclSyntaxProtocol)
  /// `self` captured by a closure.
  case error(CatchClauseSyntax)
  /// `newValue` available by default inside `set` and `willSet`.
  case newValue(AccessorDeclSyntax)
  /// `oldValue` available by default inside `didSet`.
  case oldValue(AccessorDeclSyntax)

  /// Syntax associated with this name.
  @_spi(Experimental) public var syntax: SyntaxProtocol {
    switch self {
    case .self(let syntax):
      syntax
    case .Self(let syntax):
      syntax
    case .error(let syntax):
      syntax
    case .newValue(let syntax):
      syntax
    case .oldValue(let syntax):
      syntax
    }
  }

  /// Used for name comparison.
  var name: String {
    switch self {
    case .self:
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
}

@_spi(Experimental) public enum LookupName {
  /// Identifier associated with the name.
  /// Could be an identifier of a variable, function or closure parameter and more.
  case identifier(IdentifiableSyntax, accessibleAfter: AbsolutePosition?)
  /// Declaration associated with the name.
  /// Could be class, struct, actor, protocol, function and more.
  case declaration(NamedDeclSyntax)
  /// Name introduced implicitly by certain syntax nodes.
  case implicit(LookupImplicitNameKind)

  /// Syntax associated with this name.
  @_spi(Experimental) public var syntax: SyntaxProtocol {
    switch self {
    case .identifier(let syntax, _):
      syntax
    case .declaration(let syntax):
      syntax
    case .implicit(let implicitName):
      implicitName.syntax
    }
  }

  /// Introduced name.
  @_spi(Experimental) public var identifier: Identifier? {
    switch self {
    case .identifier(let syntax, _):
      Identifier(syntax.identifier)
    case .declaration(let syntax):
      Identifier(syntax.name)
    default:
      nil
    }
  }

  /// Point, after which the name is available in scope.
  /// If set to `nil`, the name is available at any point in scope.
  var accessibleAfter: AbsolutePosition? {
    switch self {
    case .identifier(_, let absolutePosition):
      return absolutePosition
    default:
      return nil
    }
  }

  /// Used for name comparison.
  var name: String? {
    switch self {
    case .identifier, .declaration:
      identifier?.name
    case .implicit(let implicitName):
      implicitName.name
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

  /// Extracts names introduced by the given `syntax` structure.
  ///
  /// When e.g. looking up a variable declaration like `let a = a`,
  /// we expect `a` to be visible after the whole declaration.
  /// That's why we can't just use `syntax.endPosition` for the `a` identifier pattern,
  /// as the name would already be visible at the `a` reference withing the declaration.
  /// That’s why code block and file scopes have to set
  /// `accessibleAfter` to be the end position of the entire declaration syntax node.
  static func getNames(
    from syntax: SyntaxProtocol,
    accessibleAfter: AbsolutePosition? = nil
  ) -> [LookupName] {
    switch Syntax(syntax).as(SyntaxEnum.self) {
    case .variableDecl(let variableDecl):
      return variableDecl.bindings.flatMap { binding in
        getNames(
          from: binding.pattern,
          accessibleAfter: accessibleAfter != nil ? binding.endPositionBeforeTrailingTrivia : nil
        )
      }
    case .tuplePattern(let tuplePattern):
      return tuplePattern.elements.flatMap { tupleElement in
        getNames(from: tupleElement.pattern, accessibleAfter: accessibleAfter)
      }
    case .valueBindingPattern(let valueBindingPattern):
      return getNames(from: valueBindingPattern.pattern, accessibleAfter: accessibleAfter)
    case .expressionPattern(let expressionPattern):
      return getNames(from: expressionPattern.expression, accessibleAfter: accessibleAfter)
    case .sequenceExpr(let sequenceExpr):
      return sequenceExpr.elements.flatMap { expression in
        getNames(from: expression, accessibleAfter: accessibleAfter)
      }
    case .patternExpr(let patternExpr):
      return getNames(from: patternExpr.pattern, accessibleAfter: accessibleAfter)
    case .optionalBindingCondition(let optionalBinding):
      return getNames(from: optionalBinding.pattern, accessibleAfter: accessibleAfter)
    case .matchingPatternCondition(let matchingPatternCondition):
      return getNames(from: matchingPatternCondition.pattern, accessibleAfter: accessibleAfter)
    case .functionCallExpr(let functionCallExpr):
      return functionCallExpr.arguments.flatMap { argument in
        getNames(from: argument.expression, accessibleAfter: accessibleAfter)
      }
    default:
      if let namedDecl = Syntax(syntax).asProtocol(SyntaxProtocol.self) as? NamedDeclSyntax {
        return handle(namedDecl: namedDecl, accessibleAfter: accessibleAfter)
      } else if let identifiable = Syntax(syntax).asProtocol(SyntaxProtocol.self) as? IdentifiableSyntax {
        return handle(identifiable: identifiable, accessibleAfter: accessibleAfter)
      } else {
        return []
      }
    }
  }

  /// Extracts name introduced by `IdentifiableSyntax` node.
  private static func handle(
    identifiable: IdentifiableSyntax,
    accessibleAfter: AbsolutePosition? = nil
  ) -> [LookupName] {
    if let closureCapture = identifiable as? ClosureCaptureSyntax,
      closureCapture.identifier.tokenKind == .keyword(.self)
    {
      return [.implicit(.self(closureCapture))]  // Handle `self` closure capture.
    } else if identifiable.identifier.tokenKind != .wildcard {
      return [.identifier(identifiable, accessibleAfter: accessibleAfter)]
    } else {
      return []
    }
  }

  /// Extracts name introduced by `NamedDeclSyntax` node.
  private static func handle(
    namedDecl: NamedDeclSyntax,
    accessibleAfter: AbsolutePosition? = nil
  ) -> [LookupName] {
    [.declaration(namedDecl)]
  }
}
