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
  case identifier(String, SyntaxProtocol)
  /// Declaration associated with the name.
  /// Could be class, struct, actor, protocol, function and more
  case declaration(String, DeclSyntaxProtocol)

  /// Syntax associated with this name.
  @_spi(Experimental) public var syntax: SyntaxProtocol {
    switch self {
    case .identifier(_, let syntax):
      syntax
    case .declaration(_, let syntax):
      syntax
    }
  }

  /// Introduced name.
  @_spi(Experimental) public var name: String {
    switch self {
    case .identifier(let name, _):
      name
    case .declaration(let name, _):
      name
    }
  }

  /// Checks if this name was introduced before the syntax used for lookup.
  func isBefore(_ lookedUpSyntax: SyntaxProtocol) -> Bool {
    syntax.position < lookedUpSyntax.position
  }

  /// Checks if this name refers to the looked up phrase.
  func refersTo(_ lookedUpName: String) -> Bool {
    name == lookedUpName
  }

  /// Extracts names introduced by the given `from` structure.
  static func getNames(from syntax: SyntaxProtocol) -> [LookupName] {
    switch Syntax(syntax).as(SyntaxEnum.self) {
    case .variableDecl(let variableDecl):
      variableDecl.bindings.flatMap { binding in
        getNames(from: binding.pattern)
      }
    case .tuplePattern(let tuplePattern):
      tuplePattern.elements.flatMap { tupleElement in
        getNames(from: tupleElement.pattern)
      }
    case .valueBindingPattern(let valueBindingPattern):
      getNames(from: valueBindingPattern.pattern)
    case .expressionPattern(let expressionPattern):
      getNames(from: expressionPattern.expression)
    case .sequenceExpr(let sequenceExpr):
      sequenceExpr.elements.flatMap { expression in
        getNames(from: expression)
      }
    case .patternExpr(let patternExpr):
      getNames(from: patternExpr.pattern)
    case .optionalBindingCondition(let optionalBinding):
      getNames(from: optionalBinding.pattern)
    case .identifierPattern(let identifierPattern):
      handle(identifierPattern: identifierPattern)
    case .closureShorthandParameter(let closureShorthandParameter):
      handle(closureShorthandParameter: closureShorthandParameter)
    case .closureParameter(let closureParameter):
      handle(closureParameter: closureParameter)
    case .functionDecl(let functionDecl):
      handle(functionDecl: functionDecl)
    case .classDecl(let classDecl):
      handle(classDecl: classDecl)
    case .structDecl(let structDecl):
      handle(structDecl: structDecl)
    case .actorDecl(let actorDecl):
      handle(actorDecl: actorDecl)
    case .protocolDecl(let protocolDecl):
      handle(protocolDecl: protocolDecl)
    default:
      []
    }
  }

  /// Extracts name introduced by `identifierPattern`.
  private static func handle(identifierPattern: IdentifierPatternSyntax) -> [LookupName] {
    [.identifier(identifierPattern.identifier.text, identifierPattern)]
  }

  /// Extracts name introduced by `closureParameter`.
  private static func handle(closureParameter: ClosureParameterSyntax) -> [LookupName] {
    [.identifier(closureParameter.secondName?.text ?? closureParameter.firstName.text, closureParameter)]
  }

  /// Extracts name introduced by `closureShorthandParameter`.
  private static func handle(closureShorthandParameter: ClosureShorthandParameterSyntax) -> [LookupName] {
    let name = closureShorthandParameter.name.text
    if name != "_" {
      return [.identifier(name, closureShorthandParameter)]
    } else {
      return []
    }
  }

  /// Extracts name introduced by `functionDecl`.
  private static func handle(functionDecl: FunctionDeclSyntax) -> [LookupName] {
    [.declaration(functionDecl.name.text, functionDecl)]
  }

  /// Extracts name introduced by `classDecl`.
  private static func handle(classDecl: ClassDeclSyntax) -> [LookupName] {
    [.declaration(classDecl.name.text, classDecl)]
  }

  /// Extracts name introduced by `structDecl`.
  private static func handle(structDecl: StructDeclSyntax) -> [LookupName] {
    [.declaration(structDecl.name.text, structDecl)]
  }

  /// Extracts name introduced by `actorDecl`.
  private static func handle(actorDecl: ActorDeclSyntax) -> [LookupName] {
    [.declaration(actorDecl.name.text, actorDecl)]
  }

  /// Extracts name introduced by `protocolDecl`.
  private static func handle(protocolDecl: ProtocolDeclSyntax) -> [LookupName] {
    [.declaration(protocolDecl.name.text, protocolDecl)]
  }
}
