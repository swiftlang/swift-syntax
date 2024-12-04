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

/// An entity that is implicitly declared based on the syntactic structure of the program.
@_spi(Experimental) public enum ImplicitDecl {
  /// `self` keyword representing object instance.
  /// Could be associated with type declaration, extension,
  /// or closure captures. Introduced at function edge.
  case `self`(DeclSyntaxProtocol)
  /// `Self` keyword representing object type.
  /// Could be associated with type declaration or extension.
  case `Self`(DeclSyntaxProtocol)
  /// `error` value caught by a `catch`
  /// block that does not specify a catch pattern.
  case error(CatchClauseSyntax)
  /// `newValue` available by default inside `set` and `willSet`.
  case newValue(AccessorDeclSyntax)
  /// `oldValue` available by default inside `didSet`.
  case oldValue(AccessorDeclSyntax)

  /// Syntax associated with this name.
  @_spi(Experimental) public var syntax: SyntaxProtocol {
    switch self {
    case .self(let syntax):
      return syntax
    case .Self(let syntax):
      return syntax
    case .error(let syntax):
      return syntax
    case .newValue(let syntax):
      return syntax
    case .oldValue(let syntax):
      return syntax
    }
  }

  /// The name of the implicit declaration.
  private var name: StaticString {
    switch self {
    case .self:
      return "self"
    case .Self:
      return "Self"
    case .error:
      return "error"
    case .newValue:
      return "newValue"
    case .oldValue:
      return "oldValue"
    }
  }

  /// Identifier used for name comparison.
  ///
  /// Note that `self` and `Self` are treated as identifiers for name lookup purposes
  /// and that a variable named `self` can shadow the `self` keyword. For example.
  /// ```swift
  /// class Foo {
  ///     func test() {
  ///     let `Self` = "abc"
  ///     print(Self.self)
  ///
  ///     let `self` = "def"
  ///     print(self)
  ///   }
  /// }
  ///
  /// Foo().test()
  /// ```
  /// prints:
  /// ```
  /// abc
  /// def
  /// ```
  /// `self` and `Self` identifers override implicit `self` and `Self` introduced by
  /// the `Foo` class declaration.
  var identifier: Identifier {
    Identifier(canonicalName: name)
  }

  /// Position of this implicit name.
  @_spi(Experimental) public var position: AbsolutePosition {
    switch self {
    case .self(let declSyntax):
      switch Syntax(declSyntax).as(SyntaxEnum.self) {
      case .functionDecl(let functionDecl):
        return functionDecl.name.positionAfterSkippingLeadingTrivia
      case .initializerDecl(let initializerDecl):
        return initializerDecl.initKeyword.positionAfterSkippingLeadingTrivia
      case .subscriptDecl(let subscriptDecl):
        return subscriptDecl.accessorBlock?.positionAfterSkippingLeadingTrivia
          ?? subscriptDecl.endPositionBeforeTrailingTrivia
      case .variableDecl(let variableDecl):
        return variableDecl.bindings.first?.accessorBlock?.positionAfterSkippingLeadingTrivia
          ?? variableDecl.bindings.positionAfterSkippingLeadingTrivia
      case .accessorDecl(let accessorDecl):
        return accessorDecl.accessorSpecifier.positionAfterSkippingLeadingTrivia
      case .deinitializerDecl(let deinitializerDecl):
        return deinitializerDecl.deinitKeyword.positionAfterSkippingLeadingTrivia
      default:
        return declSyntax.positionAfterSkippingLeadingTrivia
      }
    case .Self(let declSyntax):
      switch Syntax(declSyntax).as(SyntaxEnum.self) {
      case .protocolDecl(let protocolDecl):
        return protocolDecl.name.positionAfterSkippingLeadingTrivia
      case .extensionDecl(let extensionDecl):
        return extensionDecl.extensionKeyword.positionAfterSkippingLeadingTrivia
      default:
        return declSyntax.positionAfterSkippingLeadingTrivia
      }
    case .newValue(let accessorDecl), .oldValue(let accessorDecl):
      return accessorDecl.accessorSpecifier.positionAfterSkippingLeadingTrivia
    case .error(let catchClause):
      return catchClause.catchItems.positionAfterSkippingLeadingTrivia
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
  case implicit(ImplicitDecl)
  /// Dollar identifier introduced by a closure without parameters.
  case dollarIdentifier(ClosureExprSyntax, strRepresentation: String)
  /// Represents equivalent names grouped together.
  /// - Important: The array should be non-empty.
  ///
  /// ### Example:
  /// ```swift
  /// switch X {
  /// case .a(let x), .b(let x):
  ///   print(x) // <-- lookup here
  /// }
  /// ```
  /// For lookup at the given position, the result
  /// contains only one name, that represents both `let x` declarations.
  case equivalentNames([LookupName])

  /// Syntax associated with this name.
  @_spi(Experimental) public var syntax: SyntaxProtocol {
    switch self {
    case .identifier(let syntax, _):
      return syntax
    case .declaration(let syntax):
      return syntax
    case .implicit(let implicitName):
      return implicitName.syntax
    case .dollarIdentifier(let closureExpr, _):
      return closureExpr
    case .equivalentNames(let names):
      return names.first!.syntax
    }
  }

  /// Identifier used for name comparison.
  @_spi(Experimental) public var identifier: Identifier? {
    switch self {
    case .identifier(let syntax, _):
      return Identifier(syntax.identifier)
    case .declaration(let syntax):
      return Identifier(syntax.name)
    case .implicit(let kind):
      return kind.identifier
    case .dollarIdentifier(_, strRepresentation: _):
      return nil
    case .equivalentNames(let names):
      return names.first!.identifier
    }
  }

  /// Position of this name.
  ///
  /// For some syntax nodes, their position doesn't reflect
  /// the position at which a particular name was introduced at.
  /// Such cases are function parameters (as they can
  /// contain two identifiers) and function declarations (where name
  /// is precided by access modifiers and `func` keyword).
  @_spi(Experimental) public var position: AbsolutePosition {
    switch self {
    case .identifier(let syntax, _):
      return syntax.identifier.positionAfterSkippingLeadingTrivia
    case .declaration(let syntax):
      return syntax.name.positionAfterSkippingLeadingTrivia
    case .implicit(let implicitName):
      return implicitName.position
    case .dollarIdentifier(let closureExpr, _):
      return closureExpr.positionAfterSkippingLeadingTrivia
    case .equivalentNames(let names):
      return names.first!.position
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

  /// Checks if this name was introduced before the syntax used for lookup.
  func isAccessible(at lookUpPosition: AbsolutePosition) -> Bool {
    guard let accessibleAfter else { return true }
    return accessibleAfter <= lookUpPosition
  }

  func refersTo(_ otherIdentifier: Identifier?) -> Bool {
    guard let otherIdentifier else { return true }

    switch self {
    case .dollarIdentifier(_, let strRepresentation):
      return strRepresentation == otherIdentifier.name
    default:
      return identifier == otherIdentifier
    }
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
      return variableDecl.bindings.reversed().flatMap { binding in
        getNames(
          from: binding.pattern,
          accessibleAfter: accessibleAfter != nil ? binding.endPositionBeforeTrailingTrivia : nil
        )
      }
    case .tuplePattern(let tuplePattern):
      return tuplePattern.elements.flatMap { tupleElement in
        getNames(from: tupleElement.pattern, accessibleAfter: accessibleAfter)
      }
    case .tupleExpr(let tupleExpr):
      return tupleExpr.elements.flatMap { tupleElement in
        getNames(from: tupleElement, accessibleAfter: accessibleAfter)
      }
    case .labeledExpr(let labeledExpr):
      return getNames(from: labeledExpr.expression, accessibleAfter: accessibleAfter)
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
    case .optionalChainingExpr(let optionalChainingExpr):
      return getNames(from: optionalChainingExpr.expression, accessibleAfter: accessibleAfter)
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
    if case .wildcard = identifiable.identifier.tokenKind {
      return []
    }

    return [.identifier(identifiable, accessibleAfter: accessibleAfter)]
  }

  /// Extracts name introduced by `NamedDeclSyntax` node.
  private static func handle(
    namedDecl: NamedDeclSyntax,
    accessibleAfter: AbsolutePosition? = nil
  ) -> [LookupName] {
    [.declaration(namedDecl)]
  }

  /// Debug description of this lookup name.
  @_spi(Experimental) public var debugDescription: String {
    let sourceLocationConverter = SourceLocationConverter(fileName: "", tree: syntax.root)
    let location = sourceLocationConverter.location(for: position)
    let strName = (identifier?.name ?? "NO-NAME") + " at: \(location.line):\(location.column)"

    switch self {
    case .identifier:
      let str = "identifier: \(strName)"

      if let accessibleAfter {
        let location = sourceLocationConverter.location(for: accessibleAfter)
        return str + " after: \(location.line):\(location.column)"
      } else {
        return str
      }
    case .declaration:
      return "declaration: \(strName)"
    case .implicit:
      return "implicit: \(strName)"
    case .dollarIdentifier(_, strRepresentation: let str):
      return "dollarIdentifier: \(str)"
    case .equivalentNames(let names):
      return "Composite name: [ \(names.map(\.debugDescription).joined(separator: ", ")) ]"
    }
  }
}
