//// Automatically Generated From BuildableCollectionNodes.swift.gyb.
//// Do Not Edit Directly!
//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

/// `CodeBlockItemList` represents a collection of `CodeBlockItem`s.
public struct CodeBlockItemList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsCodeBlockItemList {
  let elements: [CodeBlockItem]

  /// Creates a `CodeBlockItemList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsCodeBlockItem`
  public init(_ elements: [ExpressibleAsCodeBlockItem]) {
    self.elements = elements.map { $0.createCodeBlockItem() }
  }

  public init(arrayLiteral elements: ExpressibleAsCodeBlockItem...) {
    self.init(elements)
  }

  public func buildCodeBlockItemList(format: Format, leadingTrivia: Trivia? = nil) -> CodeBlockItemListSyntax {
    let result = SyntaxFactory.makeCodeBlockItemList(elements.map {
      $0.buildCodeBlockItem(format: format, leadingTrivia: Trivia.newlines(1) + format._makeIndent())
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildCodeBlockItemList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsCodeBlockItemList`.
  public func createCodeBlockItemList() -> CodeBlockItemList {
    return self
  }

  /// `CodeBlockItemList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `TupleExprElementList` represents a collection of `TupleExprElement`s.
public struct TupleExprElementList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsTupleExprElementList {
  let elements: [TupleExprElement]

  /// Creates a `TupleExprElementList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsTupleExprElement`
  public init(_ elements: [ExpressibleAsTupleExprElement]) {
    self.elements = elements.map { $0.createTupleExprElement() }
  }

  public init(arrayLiteral elements: ExpressibleAsTupleExprElement...) {
    self.init(elements)
  }

  public func buildTupleExprElementList(format: Format, leadingTrivia: Trivia? = nil) -> TupleExprElementListSyntax {
    let result = SyntaxFactory.makeTupleExprElementList(elements.map {
      $0.buildTupleExprElement(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildTupleExprElementList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsTupleExprElementList`.
  public func createTupleExprElementList() -> TupleExprElementList {
    return self
  }

  /// `TupleExprElementList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `ArrayElementList` represents a collection of `ArrayElement`s.
public struct ArrayElementList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsArrayElementList {
  let elements: [ArrayElement]

  /// Creates a `ArrayElementList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsArrayElement`
  public init(_ elements: [ExpressibleAsArrayElement]) {
    self.elements = elements.map { $0.createArrayElement() }
  }

  public init(arrayLiteral elements: ExpressibleAsArrayElement...) {
    self.init(elements)
  }

  public func buildArrayElementList(format: Format, leadingTrivia: Trivia? = nil) -> ArrayElementListSyntax {
    let result = SyntaxFactory.makeArrayElementList(elements.map {
      $0.buildArrayElement(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildArrayElementList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsArrayElementList`.
  public func createArrayElementList() -> ArrayElementList {
    return self
  }

  /// `ArrayElementList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `DictionaryElementList` represents a collection of `DictionaryElement`s.
public struct DictionaryElementList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsDictionaryElementList {
  let elements: [DictionaryElement]

  /// Creates a `DictionaryElementList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsDictionaryElement`
  public init(_ elements: [ExpressibleAsDictionaryElement]) {
    self.elements = elements.map { $0.createDictionaryElement() }
  }

  public init(arrayLiteral elements: ExpressibleAsDictionaryElement...) {
    self.init(elements)
  }

  public func buildDictionaryElementList(format: Format, leadingTrivia: Trivia? = nil) -> DictionaryElementListSyntax {
    let result = SyntaxFactory.makeDictionaryElementList(elements.map {
      $0.buildDictionaryElement(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildDictionaryElementList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsDictionaryElementList`.
  public func createDictionaryElementList() -> DictionaryElementList {
    return self
  }

  /// `DictionaryElementList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `StringLiteralSegments` represents a collection of `SyntaxBuildable`s.
public struct StringLiteralSegments: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsStringLiteralSegments {
  let elements: [SyntaxBuildable]

  /// Creates a `StringLiteralSegments` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsSyntaxBuildable`
  public init(_ elements: [ExpressibleAsSyntaxBuildable]) {
    self.elements = elements.map { $0.createSyntaxBuildable() }
  }

  public init(arrayLiteral elements: ExpressibleAsSyntaxBuildable...) {
    self.init(elements)
  }

  public func buildStringLiteralSegments(format: Format, leadingTrivia: Trivia? = nil) -> StringLiteralSegmentsSyntax {
    let result = SyntaxFactory.makeStringLiteralSegments(elements.map {
      $0.buildSyntax(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildStringLiteralSegments(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsStringLiteralSegments`.
  public func createStringLiteralSegments() -> StringLiteralSegments {
    return self
  }

  /// `StringLiteralSegments` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `DeclNameArgumentList` represents a collection of `DeclNameArgument`s.
public struct DeclNameArgumentList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsDeclNameArgumentList {
  let elements: [DeclNameArgument]

  /// Creates a `DeclNameArgumentList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsDeclNameArgument`
  public init(_ elements: [ExpressibleAsDeclNameArgument]) {
    self.elements = elements.map { $0.createDeclNameArgument() }
  }

  public init(arrayLiteral elements: ExpressibleAsDeclNameArgument...) {
    self.init(elements)
  }

  public func buildDeclNameArgumentList(format: Format, leadingTrivia: Trivia? = nil) -> DeclNameArgumentListSyntax {
    let result = SyntaxFactory.makeDeclNameArgumentList(elements.map {
      $0.buildDeclNameArgument(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildDeclNameArgumentList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsDeclNameArgumentList`.
  public func createDeclNameArgumentList() -> DeclNameArgumentList {
    return self
  }

  /// `DeclNameArgumentList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// A list of expressions connected by operators. This list is containedby a `SequenceExprSyntax`.
public struct ExprList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsExprList {
  let elements: [ExprBuildable]

  /// Creates a `ExprList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsExprBuildable`
  public init(_ elements: [ExpressibleAsExprBuildable]) {
    self.elements = elements.map { $0.createExprBuildable() }
  }

  public init(arrayLiteral elements: ExpressibleAsExprBuildable...) {
    self.init(elements)
  }

  public func buildExprList(format: Format, leadingTrivia: Trivia? = nil) -> ExprListSyntax {
    let result = SyntaxFactory.makeExprList(elements.map {
      $0.buildExpr(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildExprList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsExprList`.
  public func createExprList() -> ExprList {
    return self
  }

  /// `ExprList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `ClosureCaptureItemList` represents a collection of `ClosureCaptureItem`s.
public struct ClosureCaptureItemList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsClosureCaptureItemList {
  let elements: [ClosureCaptureItem]

  /// Creates a `ClosureCaptureItemList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsClosureCaptureItem`
  public init(_ elements: [ExpressibleAsClosureCaptureItem]) {
    self.elements = elements.map { $0.createClosureCaptureItem() }
  }

  public init(arrayLiteral elements: ExpressibleAsClosureCaptureItem...) {
    self.init(elements)
  }

  public func buildClosureCaptureItemList(format: Format, leadingTrivia: Trivia? = nil) -> ClosureCaptureItemListSyntax {
    let result = SyntaxFactory.makeClosureCaptureItemList(elements.map {
      $0.buildClosureCaptureItem(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildClosureCaptureItemList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsClosureCaptureItemList`.
  public func createClosureCaptureItemList() -> ClosureCaptureItemList {
    return self
  }

  /// `ClosureCaptureItemList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `ClosureParamList` represents a collection of `ClosureParam`s.
public struct ClosureParamList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsClosureParamList {
  let elements: [ClosureParam]

  /// Creates a `ClosureParamList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsClosureParam`
  public init(_ elements: [ExpressibleAsClosureParam]) {
    self.elements = elements.map { $0.createClosureParam() }
  }

  public init(arrayLiteral elements: ExpressibleAsClosureParam...) {
    self.init(elements)
  }

  public func buildClosureParamList(format: Format, leadingTrivia: Trivia? = nil) -> ClosureParamListSyntax {
    let result = SyntaxFactory.makeClosureParamList(elements.map {
      $0.buildClosureParam(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildClosureParamList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsClosureParamList`.
  public func createClosureParamList() -> ClosureParamList {
    return self
  }

  /// `ClosureParamList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `MultipleTrailingClosureElementList` represents a collection of `MultipleTrailingClosureElement`s.
public struct MultipleTrailingClosureElementList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsMultipleTrailingClosureElementList {
  let elements: [MultipleTrailingClosureElement]

  /// Creates a `MultipleTrailingClosureElementList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsMultipleTrailingClosureElement`
  public init(_ elements: [ExpressibleAsMultipleTrailingClosureElement]) {
    self.elements = elements.map { $0.createMultipleTrailingClosureElement() }
  }

  public init(arrayLiteral elements: ExpressibleAsMultipleTrailingClosureElement...) {
    self.init(elements)
  }

  public func buildMultipleTrailingClosureElementList(format: Format, leadingTrivia: Trivia? = nil) -> MultipleTrailingClosureElementListSyntax {
    let result = SyntaxFactory.makeMultipleTrailingClosureElementList(elements.map {
      $0.buildMultipleTrailingClosureElement(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildMultipleTrailingClosureElementList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsMultipleTrailingClosureElementList`.
  public func createMultipleTrailingClosureElementList() -> MultipleTrailingClosureElementList {
    return self
  }

  /// `MultipleTrailingClosureElementList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `ObjcName` represents a collection of `ObjcNamePiece`s.
public struct ObjcName: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsObjcName {
  let elements: [ObjcNamePiece]

  /// Creates a `ObjcName` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsObjcNamePiece`
  public init(_ elements: [ExpressibleAsObjcNamePiece]) {
    self.elements = elements.map { $0.createObjcNamePiece() }
  }

  public init(arrayLiteral elements: ExpressibleAsObjcNamePiece...) {
    self.init(elements)
  }

  public func buildObjcName(format: Format, leadingTrivia: Trivia? = nil) -> ObjcNameSyntax {
    let result = SyntaxFactory.makeObjcName(elements.map {
      $0.buildObjcNamePiece(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildObjcName(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsObjcName`.
  public func createObjcName() -> ObjcName {
    return self
  }

  /// `ObjcName` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `FunctionParameterList` represents a collection of `FunctionParameter`s.
public struct FunctionParameterList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsFunctionParameterList {
  let elements: [FunctionParameter]

  /// Creates a `FunctionParameterList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsFunctionParameter`
  public init(_ elements: [ExpressibleAsFunctionParameter]) {
    self.elements = elements.map { $0.createFunctionParameter() }
  }

  public init(arrayLiteral elements: ExpressibleAsFunctionParameter...) {
    self.init(elements)
  }

  public func buildFunctionParameterList(format: Format, leadingTrivia: Trivia? = nil) -> FunctionParameterListSyntax {
    let result = SyntaxFactory.makeFunctionParameterList(elements.map {
      $0.buildFunctionParameter(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildFunctionParameterList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsFunctionParameterList`.
  public func createFunctionParameterList() -> FunctionParameterList {
    return self
  }

  /// `FunctionParameterList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `IfConfigClauseList` represents a collection of `IfConfigClause`s.
public struct IfConfigClauseList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsIfConfigClauseList {
  let elements: [IfConfigClause]

  /// Creates a `IfConfigClauseList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsIfConfigClause`
  public init(_ elements: [ExpressibleAsIfConfigClause]) {
    self.elements = elements.map { $0.createIfConfigClause() }
  }

  public init(arrayLiteral elements: ExpressibleAsIfConfigClause...) {
    self.init(elements)
  }

  public func buildIfConfigClauseList(format: Format, leadingTrivia: Trivia? = nil) -> IfConfigClauseListSyntax {
    let result = SyntaxFactory.makeIfConfigClauseList(elements.map {
      $0.buildIfConfigClause(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildIfConfigClauseList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsIfConfigClauseList`.
  public func createIfConfigClauseList() -> IfConfigClauseList {
    return self
  }

  /// `IfConfigClauseList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `InheritedTypeList` represents a collection of `InheritedType`s.
public struct InheritedTypeList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsInheritedTypeList {
  let elements: [InheritedType]

  /// Creates a `InheritedTypeList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsInheritedType`
  public init(_ elements: [ExpressibleAsInheritedType]) {
    self.elements = elements.map { $0.createInheritedType() }
  }

  public init(arrayLiteral elements: ExpressibleAsInheritedType...) {
    self.init(elements)
  }

  public func buildInheritedTypeList(format: Format, leadingTrivia: Trivia? = nil) -> InheritedTypeListSyntax {
    let result = SyntaxFactory.makeInheritedTypeList(elements.map {
      $0.buildInheritedType(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildInheritedTypeList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsInheritedTypeList`.
  public func createInheritedTypeList() -> InheritedTypeList {
    return self
  }

  /// `InheritedTypeList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `MemberDeclList` represents a collection of `MemberDeclListItem`s.
public struct MemberDeclList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsMemberDeclList {
  let elements: [MemberDeclListItem]

  /// Creates a `MemberDeclList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsMemberDeclListItem`
  public init(_ elements: [ExpressibleAsMemberDeclListItem]) {
    self.elements = elements.map { $0.createMemberDeclListItem() }
  }

  public init(arrayLiteral elements: ExpressibleAsMemberDeclListItem...) {
    self.init(elements)
  }

  public func buildMemberDeclList(format: Format, leadingTrivia: Trivia? = nil) -> MemberDeclListSyntax {
    let result = SyntaxFactory.makeMemberDeclList(elements.map {
      $0.buildMemberDeclListItem(format: format, leadingTrivia: Trivia.newlines(1) + format._makeIndent())
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildMemberDeclList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsMemberDeclList`.
  public func createMemberDeclList() -> MemberDeclList {
    return self
  }

  /// `MemberDeclList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `ModifierList` represents a collection of `DeclModifier`s.
public struct ModifierList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsModifierList {
  let elements: [DeclModifier]

  /// Creates a `ModifierList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsDeclModifier`
  public init(_ elements: [ExpressibleAsDeclModifier]) {
    self.elements = elements.map { $0.createDeclModifier() }
  }

  public init(arrayLiteral elements: ExpressibleAsDeclModifier...) {
    self.init(elements)
  }

  public func buildModifierList(format: Format, leadingTrivia: Trivia? = nil) -> ModifierListSyntax {
    let result = SyntaxFactory.makeModifierList(elements.map {
      $0.buildDeclModifier(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildModifierList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsModifierList`.
  public func createModifierList() -> ModifierList {
    return self
  }

  /// `ModifierList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `AccessPath` represents a collection of `AccessPathComponent`s.
public struct AccessPath: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsAccessPath {
  let elements: [AccessPathComponent]

  /// Creates a `AccessPath` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsAccessPathComponent`
  public init(_ elements: [ExpressibleAsAccessPathComponent]) {
    self.elements = elements.map { $0.createAccessPathComponent() }
  }

  public init(arrayLiteral elements: ExpressibleAsAccessPathComponent...) {
    self.init(elements)
  }

  public func buildAccessPath(format: Format, leadingTrivia: Trivia? = nil) -> AccessPathSyntax {
    let result = SyntaxFactory.makeAccessPath(elements.map {
      $0.buildAccessPathComponent(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildAccessPath(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsAccessPath`.
  public func createAccessPath() -> AccessPath {
    return self
  }

  /// `AccessPath` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `AccessorList` represents a collection of `AccessorDecl`s.
public struct AccessorList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsAccessorList {
  let elements: [AccessorDecl]

  /// Creates a `AccessorList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsAccessorDecl`
  public init(_ elements: [ExpressibleAsAccessorDecl]) {
    self.elements = elements.map { $0.createAccessorDecl() }
  }

  public init(arrayLiteral elements: ExpressibleAsAccessorDecl...) {
    self.init(elements)
  }

  public func buildAccessorList(format: Format, leadingTrivia: Trivia? = nil) -> AccessorListSyntax {
    let result = SyntaxFactory.makeAccessorList(elements.map {
      $0.buildAccessorDecl(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildAccessorList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsAccessorList`.
  public func createAccessorList() -> AccessorList {
    return self
  }

  /// `AccessorList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `PatternBindingList` represents a collection of `PatternBinding`s.
public struct PatternBindingList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsPatternBindingList {
  let elements: [PatternBinding]

  /// Creates a `PatternBindingList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsPatternBinding`
  public init(_ elements: [ExpressibleAsPatternBinding]) {
    self.elements = elements.map { $0.createPatternBinding() }
  }

  public init(arrayLiteral elements: ExpressibleAsPatternBinding...) {
    self.init(elements)
  }

  public func buildPatternBindingList(format: Format, leadingTrivia: Trivia? = nil) -> PatternBindingListSyntax {
    let result = SyntaxFactory.makePatternBindingList(elements.map {
      $0.buildPatternBinding(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildPatternBindingList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsPatternBindingList`.
  public func createPatternBindingList() -> PatternBindingList {
    return self
  }

  /// `PatternBindingList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// A collection of 0 or more `EnumCaseElement`s.
public struct EnumCaseElementList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsEnumCaseElementList {
  let elements: [EnumCaseElement]

  /// Creates a `EnumCaseElementList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsEnumCaseElement`
  public init(_ elements: [ExpressibleAsEnumCaseElement]) {
    self.elements = elements.map { $0.createEnumCaseElement() }
  }

  public init(arrayLiteral elements: ExpressibleAsEnumCaseElement...) {
    self.init(elements)
  }

  public func buildEnumCaseElementList(format: Format, leadingTrivia: Trivia? = nil) -> EnumCaseElementListSyntax {
    let result = SyntaxFactory.makeEnumCaseElementList(elements.map {
      $0.buildEnumCaseElement(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildEnumCaseElementList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsEnumCaseElementList`.
  public func createEnumCaseElementList() -> EnumCaseElementList {
    return self
  }

  /// `EnumCaseElementList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `IdentifierList` represents a collection of `TokenSyntax`s.
public struct IdentifierList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsIdentifierList {
  let elements: [TokenSyntax]

  /// Creates a `IdentifierList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `TokenSyntax`
  public init(_ elements: [TokenSyntax]) {
    self.elements = elements
  }

  public init(arrayLiteral elements: TokenSyntax...) {
    self.init(elements)
  }

  public func buildIdentifierList(format: Format, leadingTrivia: Trivia? = nil) -> IdentifierListSyntax {
    let result = SyntaxFactory.makeIdentifierList(elements)
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildIdentifierList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsIdentifierList`.
  public func createIdentifierList() -> IdentifierList {
    return self
  }

  /// `IdentifierList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `PrecedenceGroupAttributeList` represents a collection of `SyntaxBuildable`s.
public struct PrecedenceGroupAttributeList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsPrecedenceGroupAttributeList {
  let elements: [SyntaxBuildable]

  /// Creates a `PrecedenceGroupAttributeList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsSyntaxBuildable`
  public init(_ elements: [ExpressibleAsSyntaxBuildable]) {
    self.elements = elements.map { $0.createSyntaxBuildable() }
  }

  public init(arrayLiteral elements: ExpressibleAsSyntaxBuildable...) {
    self.init(elements)
  }

  public func buildPrecedenceGroupAttributeList(format: Format, leadingTrivia: Trivia? = nil) -> PrecedenceGroupAttributeListSyntax {
    let result = SyntaxFactory.makePrecedenceGroupAttributeList(elements.map {
      $0.buildSyntax(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildPrecedenceGroupAttributeList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsPrecedenceGroupAttributeList`.
  public func createPrecedenceGroupAttributeList() -> PrecedenceGroupAttributeList {
    return self
  }

  /// `PrecedenceGroupAttributeList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `PrecedenceGroupNameList` represents a collection of `PrecedenceGroupNameElement`s.
public struct PrecedenceGroupNameList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsPrecedenceGroupNameList {
  let elements: [PrecedenceGroupNameElement]

  /// Creates a `PrecedenceGroupNameList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsPrecedenceGroupNameElement`
  public init(_ elements: [ExpressibleAsPrecedenceGroupNameElement]) {
    self.elements = elements.map { $0.createPrecedenceGroupNameElement() }
  }

  public init(arrayLiteral elements: ExpressibleAsPrecedenceGroupNameElement...) {
    self.init(elements)
  }

  public func buildPrecedenceGroupNameList(format: Format, leadingTrivia: Trivia? = nil) -> PrecedenceGroupNameListSyntax {
    let result = SyntaxFactory.makePrecedenceGroupNameList(elements.map {
      $0.buildPrecedenceGroupNameElement(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildPrecedenceGroupNameList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsPrecedenceGroupNameList`.
  public func createPrecedenceGroupNameList() -> PrecedenceGroupNameList {
    return self
  }

  /// `PrecedenceGroupNameList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `TokenList` represents a collection of `TokenSyntax`s.
public struct TokenList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsTokenList {
  let elements: [TokenSyntax]

  /// Creates a `TokenList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `TokenSyntax`
  public init(_ elements: [TokenSyntax]) {
    self.elements = elements
  }

  public init(arrayLiteral elements: TokenSyntax...) {
    self.init(elements)
  }

  public func buildTokenList(format: Format, leadingTrivia: Trivia? = nil) -> TokenListSyntax {
    let result = SyntaxFactory.makeTokenList(elements)
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildTokenList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsTokenList`.
  public func createTokenList() -> TokenList {
    return self
  }

  /// `TokenList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `NonEmptyTokenList` represents a collection of `TokenSyntax`s.
public struct NonEmptyTokenList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsNonEmptyTokenList {
  let elements: [TokenSyntax]

  /// Creates a `NonEmptyTokenList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `TokenSyntax`
  public init(_ elements: [TokenSyntax]) {
    self.elements = elements
  }

  public init(arrayLiteral elements: TokenSyntax...) {
    self.init(elements)
  }

  public func buildNonEmptyTokenList(format: Format, leadingTrivia: Trivia? = nil) -> NonEmptyTokenListSyntax {
    let result = SyntaxFactory.makeNonEmptyTokenList(elements)
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildNonEmptyTokenList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsNonEmptyTokenList`.
  public func createNonEmptyTokenList() -> NonEmptyTokenList {
    return self
  }

  /// `NonEmptyTokenList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `AttributeList` represents a collection of `SyntaxBuildable`s.
public struct AttributeList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsAttributeList {
  let elements: [SyntaxBuildable]

  /// Creates a `AttributeList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsSyntaxBuildable`
  public init(_ elements: [ExpressibleAsSyntaxBuildable]) {
    self.elements = elements.map { $0.createSyntaxBuildable() }
  }

  public init(arrayLiteral elements: ExpressibleAsSyntaxBuildable...) {
    self.init(elements)
  }

  public func buildAttributeList(format: Format, leadingTrivia: Trivia? = nil) -> AttributeListSyntax {
    let result = SyntaxFactory.makeAttributeList(elements.map {
      $0.buildSyntax(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildAttributeList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsAttributeList`.
  public func createAttributeList() -> AttributeList {
    return self
  }

  /// `AttributeList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// A collection of arguments for the `@_specialize` attribute
public struct SpecializeAttributeSpecList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsSpecializeAttributeSpecList {
  let elements: [SyntaxBuildable]

  /// Creates a `SpecializeAttributeSpecList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsSyntaxBuildable`
  public init(_ elements: [ExpressibleAsSyntaxBuildable]) {
    self.elements = elements.map { $0.createSyntaxBuildable() }
  }

  public init(arrayLiteral elements: ExpressibleAsSyntaxBuildable...) {
    self.init(elements)
  }

  public func buildSpecializeAttributeSpecList(format: Format, leadingTrivia: Trivia? = nil) -> SpecializeAttributeSpecListSyntax {
    let result = SyntaxFactory.makeSpecializeAttributeSpecList(elements.map {
      $0.buildSyntax(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildSpecializeAttributeSpecList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsSpecializeAttributeSpecList`.
  public func createSpecializeAttributeSpecList() -> SpecializeAttributeSpecList {
    return self
  }

  /// `SpecializeAttributeSpecList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `ObjCSelector` represents a collection of `ObjCSelectorPiece`s.
public struct ObjCSelector: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsObjCSelector {
  let elements: [ObjCSelectorPiece]

  /// Creates a `ObjCSelector` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsObjCSelectorPiece`
  public init(_ elements: [ExpressibleAsObjCSelectorPiece]) {
    self.elements = elements.map { $0.createObjCSelectorPiece() }
  }

  public init(arrayLiteral elements: ExpressibleAsObjCSelectorPiece...) {
    self.init(elements)
  }

  public func buildObjCSelector(format: Format, leadingTrivia: Trivia? = nil) -> ObjCSelectorSyntax {
    let result = SyntaxFactory.makeObjCSelector(elements.map {
      $0.buildObjCSelectorPiece(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildObjCSelector(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsObjCSelector`.
  public func createObjCSelector() -> ObjCSelector {
    return self
  }

  /// `ObjCSelector` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `DifferentiabilityParamList` represents a collection of `DifferentiabilityParam`s.
public struct DifferentiabilityParamList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsDifferentiabilityParamList {
  let elements: [DifferentiabilityParam]

  /// Creates a `DifferentiabilityParamList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsDifferentiabilityParam`
  public init(_ elements: [ExpressibleAsDifferentiabilityParam]) {
    self.elements = elements.map { $0.createDifferentiabilityParam() }
  }

  public init(arrayLiteral elements: ExpressibleAsDifferentiabilityParam...) {
    self.init(elements)
  }

  public func buildDifferentiabilityParamList(format: Format, leadingTrivia: Trivia? = nil) -> DifferentiabilityParamListSyntax {
    let result = SyntaxFactory.makeDifferentiabilityParamList(elements.map {
      $0.buildDifferentiabilityParam(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildDifferentiabilityParamList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsDifferentiabilityParamList`.
  public func createDifferentiabilityParamList() -> DifferentiabilityParamList {
    return self
  }

  /// `DifferentiabilityParamList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `BackDeployVersionList` represents a collection of `BackDeployVersionArgument`s.
public struct BackDeployVersionList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsBackDeployVersionList {
  let elements: [BackDeployVersionArgument]

  /// Creates a `BackDeployVersionList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsBackDeployVersionArgument`
  public init(_ elements: [ExpressibleAsBackDeployVersionArgument]) {
    self.elements = elements.map { $0.createBackDeployVersionArgument() }
  }

  public init(arrayLiteral elements: ExpressibleAsBackDeployVersionArgument...) {
    self.init(elements)
  }

  public func buildBackDeployVersionList(format: Format, leadingTrivia: Trivia? = nil) -> BackDeployVersionListSyntax {
    let result = SyntaxFactory.makeBackDeployVersionList(elements.map {
      $0.buildBackDeployVersionArgument(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildBackDeployVersionList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsBackDeployVersionList`.
  public func createBackDeployVersionList() -> BackDeployVersionList {
    return self
  }

  /// `BackDeployVersionList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `SwitchCaseList` represents a collection of `SyntaxBuildable`s.
public struct SwitchCaseList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsSwitchCaseList {
  let elements: [SyntaxBuildable]

  /// Creates a `SwitchCaseList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsSyntaxBuildable`
  public init(_ elements: [ExpressibleAsSyntaxBuildable]) {
    self.elements = elements.map { $0.createSyntaxBuildable() }
  }

  public init(arrayLiteral elements: ExpressibleAsSyntaxBuildable...) {
    self.init(elements)
  }

  public func buildSwitchCaseList(format: Format, leadingTrivia: Trivia? = nil) -> SwitchCaseListSyntax {
    let result = SyntaxFactory.makeSwitchCaseList(elements.map {
      $0.buildSyntax(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildSwitchCaseList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsSwitchCaseList`.
  public func createSwitchCaseList() -> SwitchCaseList {
    return self
  }

  /// `SwitchCaseList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `CatchClauseList` represents a collection of `CatchClause`s.
public struct CatchClauseList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsCatchClauseList {
  let elements: [CatchClause]

  /// Creates a `CatchClauseList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsCatchClause`
  public init(_ elements: [ExpressibleAsCatchClause]) {
    self.elements = elements.map { $0.createCatchClause() }
  }

  public init(arrayLiteral elements: ExpressibleAsCatchClause...) {
    self.init(elements)
  }

  public func buildCatchClauseList(format: Format, leadingTrivia: Trivia? = nil) -> CatchClauseListSyntax {
    let result = SyntaxFactory.makeCatchClauseList(elements.map {
      $0.buildCatchClause(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildCatchClauseList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsCatchClauseList`.
  public func createCatchClauseList() -> CatchClauseList {
    return self
  }

  /// `CatchClauseList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `CaseItemList` represents a collection of `CaseItem`s.
public struct CaseItemList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsCaseItemList {
  let elements: [CaseItem]

  /// Creates a `CaseItemList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsCaseItem`
  public init(_ elements: [ExpressibleAsCaseItem]) {
    self.elements = elements.map { $0.createCaseItem() }
  }

  public init(arrayLiteral elements: ExpressibleAsCaseItem...) {
    self.init(elements)
  }

  public func buildCaseItemList(format: Format, leadingTrivia: Trivia? = nil) -> CaseItemListSyntax {
    let result = SyntaxFactory.makeCaseItemList(elements.map {
      $0.buildCaseItem(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildCaseItemList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsCaseItemList`.
  public func createCaseItemList() -> CaseItemList {
    return self
  }

  /// `CaseItemList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `CatchItemList` represents a collection of `CatchItem`s.
public struct CatchItemList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsCatchItemList {
  let elements: [CatchItem]

  /// Creates a `CatchItemList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsCatchItem`
  public init(_ elements: [ExpressibleAsCatchItem]) {
    self.elements = elements.map { $0.createCatchItem() }
  }

  public init(arrayLiteral elements: ExpressibleAsCatchItem...) {
    self.init(elements)
  }

  public func buildCatchItemList(format: Format, leadingTrivia: Trivia? = nil) -> CatchItemListSyntax {
    let result = SyntaxFactory.makeCatchItemList(elements.map {
      $0.buildCatchItem(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildCatchItemList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsCatchItemList`.
  public func createCatchItemList() -> CatchItemList {
    return self
  }

  /// `CatchItemList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `ConditionElementList` represents a collection of `ConditionElement`s.
public struct ConditionElementList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsConditionElementList {
  let elements: [ConditionElement]

  /// Creates a `ConditionElementList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsConditionElement`
  public init(_ elements: [ExpressibleAsConditionElement]) {
    self.elements = elements.map { $0.createConditionElement() }
  }

  public init(arrayLiteral elements: ExpressibleAsConditionElement...) {
    self.init(elements)
  }

  public func buildConditionElementList(format: Format, leadingTrivia: Trivia? = nil) -> ConditionElementListSyntax {
    let result = SyntaxFactory.makeConditionElementList(elements.map {
      $0.buildConditionElement(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildConditionElementList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsConditionElementList`.
  public func createConditionElementList() -> ConditionElementList {
    return self
  }

  /// `ConditionElementList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `GenericRequirementList` represents a collection of `GenericRequirement`s.
public struct GenericRequirementList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsGenericRequirementList {
  let elements: [GenericRequirement]

  /// Creates a `GenericRequirementList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsGenericRequirement`
  public init(_ elements: [ExpressibleAsGenericRequirement]) {
    self.elements = elements.map { $0.createGenericRequirement() }
  }

  public init(arrayLiteral elements: ExpressibleAsGenericRequirement...) {
    self.init(elements)
  }

  public func buildGenericRequirementList(format: Format, leadingTrivia: Trivia? = nil) -> GenericRequirementListSyntax {
    let result = SyntaxFactory.makeGenericRequirementList(elements.map {
      $0.buildGenericRequirement(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildGenericRequirementList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsGenericRequirementList`.
  public func createGenericRequirementList() -> GenericRequirementList {
    return self
  }

  /// `GenericRequirementList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `GenericParameterList` represents a collection of `GenericParameter`s.
public struct GenericParameterList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsGenericParameterList {
  let elements: [GenericParameter]

  /// Creates a `GenericParameterList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsGenericParameter`
  public init(_ elements: [ExpressibleAsGenericParameter]) {
    self.elements = elements.map { $0.createGenericParameter() }
  }

  public init(arrayLiteral elements: ExpressibleAsGenericParameter...) {
    self.init(elements)
  }

  public func buildGenericParameterList(format: Format, leadingTrivia: Trivia? = nil) -> GenericParameterListSyntax {
    let result = SyntaxFactory.makeGenericParameterList(elements.map {
      $0.buildGenericParameter(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildGenericParameterList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsGenericParameterList`.
  public func createGenericParameterList() -> GenericParameterList {
    return self
  }

  /// `GenericParameterList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `PrimaryAssociatedTypeList` represents a collection of `PrimaryAssociatedType`s.
public struct PrimaryAssociatedTypeList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsPrimaryAssociatedTypeList {
  let elements: [PrimaryAssociatedType]

  /// Creates a `PrimaryAssociatedTypeList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsPrimaryAssociatedType`
  public init(_ elements: [ExpressibleAsPrimaryAssociatedType]) {
    self.elements = elements.map { $0.createPrimaryAssociatedType() }
  }

  public init(arrayLiteral elements: ExpressibleAsPrimaryAssociatedType...) {
    self.init(elements)
  }

  public func buildPrimaryAssociatedTypeList(format: Format, leadingTrivia: Trivia? = nil) -> PrimaryAssociatedTypeListSyntax {
    let result = SyntaxFactory.makePrimaryAssociatedTypeList(elements.map {
      $0.buildPrimaryAssociatedType(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildPrimaryAssociatedTypeList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsPrimaryAssociatedTypeList`.
  public func createPrimaryAssociatedTypeList() -> PrimaryAssociatedTypeList {
    return self
  }

  /// `PrimaryAssociatedTypeList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `CompositionTypeElementList` represents a collection of `CompositionTypeElement`s.
public struct CompositionTypeElementList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsCompositionTypeElementList {
  let elements: [CompositionTypeElement]

  /// Creates a `CompositionTypeElementList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsCompositionTypeElement`
  public init(_ elements: [ExpressibleAsCompositionTypeElement]) {
    self.elements = elements.map { $0.createCompositionTypeElement() }
  }

  public init(arrayLiteral elements: ExpressibleAsCompositionTypeElement...) {
    self.init(elements)
  }

  public func buildCompositionTypeElementList(format: Format, leadingTrivia: Trivia? = nil) -> CompositionTypeElementListSyntax {
    let result = SyntaxFactory.makeCompositionTypeElementList(elements.map {
      $0.buildCompositionTypeElement(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildCompositionTypeElementList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsCompositionTypeElementList`.
  public func createCompositionTypeElementList() -> CompositionTypeElementList {
    return self
  }

  /// `CompositionTypeElementList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `TupleTypeElementList` represents a collection of `TupleTypeElement`s.
public struct TupleTypeElementList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsTupleTypeElementList {
  let elements: [TupleTypeElement]

  /// Creates a `TupleTypeElementList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsTupleTypeElement`
  public init(_ elements: [ExpressibleAsTupleTypeElement]) {
    self.elements = elements.map { $0.createTupleTypeElement() }
  }

  public init(arrayLiteral elements: ExpressibleAsTupleTypeElement...) {
    self.init(elements)
  }

  public func buildTupleTypeElementList(format: Format, leadingTrivia: Trivia? = nil) -> TupleTypeElementListSyntax {
    let result = SyntaxFactory.makeTupleTypeElementList(elements.map {
      $0.buildTupleTypeElement(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildTupleTypeElementList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsTupleTypeElementList`.
  public func createTupleTypeElementList() -> TupleTypeElementList {
    return self
  }

  /// `TupleTypeElementList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `GenericArgumentList` represents a collection of `GenericArgument`s.
public struct GenericArgumentList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsGenericArgumentList {
  let elements: [GenericArgument]

  /// Creates a `GenericArgumentList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsGenericArgument`
  public init(_ elements: [ExpressibleAsGenericArgument]) {
    self.elements = elements.map { $0.createGenericArgument() }
  }

  public init(arrayLiteral elements: ExpressibleAsGenericArgument...) {
    self.init(elements)
  }

  public func buildGenericArgumentList(format: Format, leadingTrivia: Trivia? = nil) -> GenericArgumentListSyntax {
    let result = SyntaxFactory.makeGenericArgumentList(elements.map {
      $0.buildGenericArgument(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildGenericArgumentList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsGenericArgumentList`.
  public func createGenericArgumentList() -> GenericArgumentList {
    return self
  }

  /// `GenericArgumentList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `TuplePatternElementList` represents a collection of `TuplePatternElement`s.
public struct TuplePatternElementList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsTuplePatternElementList {
  let elements: [TuplePatternElement]

  /// Creates a `TuplePatternElementList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsTuplePatternElement`
  public init(_ elements: [ExpressibleAsTuplePatternElement]) {
    self.elements = elements.map { $0.createTuplePatternElement() }
  }

  public init(arrayLiteral elements: ExpressibleAsTuplePatternElement...) {
    self.init(elements)
  }

  public func buildTuplePatternElementList(format: Format, leadingTrivia: Trivia? = nil) -> TuplePatternElementListSyntax {
    let result = SyntaxFactory.makeTuplePatternElementList(elements.map {
      $0.buildTuplePatternElement(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildTuplePatternElementList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsTuplePatternElementList`.
  public func createTuplePatternElementList() -> TuplePatternElementList {
    return self
  }

  /// `TuplePatternElementList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

/// `AvailabilitySpecList` represents a collection of `AvailabilityArgument`s.
public struct AvailabilitySpecList: ExpressibleByArrayLiteral, SyntaxBuildable, ExpressibleAsAvailabilitySpecList {
  let elements: [AvailabilityArgument]

  /// Creates a `AvailabilitySpecList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsAvailabilityArgument`
  public init(_ elements: [ExpressibleAsAvailabilityArgument]) {
    self.elements = elements.map { $0.createAvailabilityArgument() }
  }

  public init(arrayLiteral elements: ExpressibleAsAvailabilityArgument...) {
    self.init(elements)
  }

  public func buildAvailabilitySpecList(format: Format, leadingTrivia: Trivia? = nil) -> AvailabilitySpecListSyntax {
    let result = SyntaxFactory.makeAvailabilitySpecList(elements.map {
      $0.buildAvailabilityArgument(format: format, leadingTrivia: nil)
    })
    if let leadingTrivia = leadingTrivia {
      return result.withLeadingTrivia(leadingTrivia + (result.leadingTrivia ?? []))
    } else {
      return result
    }
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    return Syntax(buildAvailabilitySpecList(format: format, leadingTrivia: leadingTrivia))
  }

  /// Conformance to `ExpressibleAsAvailabilitySpecList`.
  public func createAvailabilitySpecList() -> AvailabilitySpecList {
    return self
  }

  /// `AvailabilitySpecList` might conform to `SyntaxBuildable` via different `ExpressibleAs*` paths.
  /// Thus, there are multiple default implementations for `createSyntaxBuildable`, some of which perform conversions through `ExpressibleAs*` protocols.
  /// To resolve the ambiguity, provide a fixed implementation that doesn't perform any conversions.
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return self
  }
}

