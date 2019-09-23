//// Automatically Generated From SyntaxBuilders.swift.gyb.
//// Do Not Edit Directly!
//===------------ SyntaxBuilders.swift - Syntax Builder definitions -------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//


public struct CodeBlockItemSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useItem(_ node: Syntax) {
    let idx = CodeBlockItemSyntax.Cursor.item.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSemicolon(_ node: TokenSyntax) {
    let idx = CodeBlockItemSyntax.Cursor.semicolon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useErrorTokens(_ node: Syntax) {
    let idx = CodeBlockItemSyntax.Cursor.errorTokens.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.unknown)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .codeBlockItem,
      layout: layout, presence: .present))
  }
}

extension CodeBlockItemSyntax {
  /// Creates a `CodeBlockItemSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `CodeBlockItemSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `CodeBlockItemSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout CodeBlockItemSyntaxBuilder) -> Void) {
    var builder = CodeBlockItemSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct CodeBlockSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useLeftBrace(_ node: TokenSyntax) {
    let idx = CodeBlockSyntax.Cursor.leftBrace.rawValue
    layout[idx] = node.raw
  }

  public mutating func addStatement(_ elt: CodeBlockItemSyntax) {
    let idx = CodeBlockSyntax.Cursor.statements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.codeBlockItemList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightBrace(_ node: TokenSyntax) {
    let idx = CodeBlockSyntax.Cursor.rightBrace.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.leftBrace)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.codeBlockItemList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.rightBrace)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .codeBlock,
      layout: layout, presence: .present))
  }
}

extension CodeBlockSyntax {
  /// Creates a `CodeBlockSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `CodeBlockSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `CodeBlockSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout CodeBlockSyntaxBuilder) -> Void) {
    var builder = CodeBlockSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct InOutExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useAmpersand(_ node: TokenSyntax) {
    let idx = InOutExprSyntax.Cursor.ampersand.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = InOutExprSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.prefixAmpersand)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.expr)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .inOutExpr,
      layout: layout, presence: .present))
  }
}

extension InOutExprSyntax {
  /// Creates a `InOutExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `InOutExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `InOutExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout InOutExprSyntaxBuilder) -> Void) {
    var builder = InOutExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct PoundColumnExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func usePoundColumn(_ node: TokenSyntax) {
    let idx = PoundColumnExprSyntax.Cursor.poundColumn.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.poundColumnKeyword)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .poundColumnExpr,
      layout: layout, presence: .present))
  }
}

extension PoundColumnExprSyntax {
  /// Creates a `PoundColumnExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundColumnExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundColumnExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout PoundColumnExprSyntaxBuilder) -> Void) {
    var builder = PoundColumnExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct TryExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useTryKeyword(_ node: TokenSyntax) {
    let idx = TryExprSyntax.Cursor.tryKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useQuestionOrExclamationMark(_ node: TokenSyntax) {
    let idx = TryExprSyntax.Cursor.questionOrExclamationMark.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = TryExprSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.tryKeyword)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.expr)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .tryExpr,
      layout: layout, presence: .present))
  }
}

extension TryExprSyntax {
  /// Creates a `TryExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TryExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TryExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout TryExprSyntaxBuilder) -> Void) {
    var builder = TryExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct DeclNameArgumentSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useName(_ node: TokenSyntax) {
    let idx = DeclNameArgumentSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = DeclNameArgumentSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.unknown(""))
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.colon)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .declNameArgument,
      layout: layout, presence: .present))
  }
}

extension DeclNameArgumentSyntax {
  /// Creates a `DeclNameArgumentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DeclNameArgumentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DeclNameArgumentSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout DeclNameArgumentSyntaxBuilder) -> Void) {
    var builder = DeclNameArgumentSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct DeclNameArgumentsSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = DeclNameArgumentsSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addArgument(_ elt: DeclNameArgumentSyntax) {
    let idx = DeclNameArgumentsSyntax.Cursor.arguments.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.declNameArgumentList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = DeclNameArgumentsSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.leftParen)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.declNameArgumentList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.rightParen)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .declNameArguments,
      layout: layout, presence: .present))
  }
}

extension DeclNameArgumentsSyntax {
  /// Creates a `DeclNameArgumentsSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DeclNameArgumentsSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DeclNameArgumentsSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout DeclNameArgumentsSyntaxBuilder) -> Void) {
    var builder = DeclNameArgumentsSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct IdentifierExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = IdentifierExprSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDeclNameArguments(_ node: DeclNameArgumentsSyntax) {
    let idx = IdentifierExprSyntax.Cursor.declNameArguments.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.identifier(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .identifierExpr,
      layout: layout, presence: .present))
  }
}

extension IdentifierExprSyntax {
  /// Creates a `IdentifierExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IdentifierExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IdentifierExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout IdentifierExprSyntaxBuilder) -> Void) {
    var builder = IdentifierExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct SuperRefExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func useSuperKeyword(_ node: TokenSyntax) {
    let idx = SuperRefExprSyntax.Cursor.superKeyword.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.superKeyword)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .superRefExpr,
      layout: layout, presence: .present))
  }
}

extension SuperRefExprSyntax {
  /// Creates a `SuperRefExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SuperRefExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SuperRefExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout SuperRefExprSyntaxBuilder) -> Void) {
    var builder = SuperRefExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct NilLiteralExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func useNilKeyword(_ node: TokenSyntax) {
    let idx = NilLiteralExprSyntax.Cursor.nilKeyword.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.nilKeyword)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .nilLiteralExpr,
      layout: layout, presence: .present))
  }
}

extension NilLiteralExprSyntax {
  /// Creates a `NilLiteralExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `NilLiteralExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `NilLiteralExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout NilLiteralExprSyntaxBuilder) -> Void) {
    var builder = NilLiteralExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct DiscardAssignmentExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func useWildcard(_ node: TokenSyntax) {
    let idx = DiscardAssignmentExprSyntax.Cursor.wildcard.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.wildcardKeyword)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .discardAssignmentExpr,
      layout: layout, presence: .present))
  }
}

extension DiscardAssignmentExprSyntax {
  /// Creates a `DiscardAssignmentExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DiscardAssignmentExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DiscardAssignmentExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout DiscardAssignmentExprSyntaxBuilder) -> Void) {
    var builder = DiscardAssignmentExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct AssignmentExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func useAssignToken(_ node: TokenSyntax) {
    let idx = AssignmentExprSyntax.Cursor.assignToken.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.equal)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .assignmentExpr,
      layout: layout, presence: .present))
  }
}

extension AssignmentExprSyntax {
  /// Creates a `AssignmentExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AssignmentExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AssignmentExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout AssignmentExprSyntaxBuilder) -> Void) {
    var builder = AssignmentExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct SequenceExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func addElement(_ elt: ExprSyntax) {
    let idx = SequenceExprSyntax.Cursor.elements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.exprList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.exprList)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .sequenceExpr,
      layout: layout, presence: .present))
  }
}

extension SequenceExprSyntax {
  /// Creates a `SequenceExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SequenceExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SequenceExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout SequenceExprSyntaxBuilder) -> Void) {
    var builder = SequenceExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct PoundLineExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func usePoundLine(_ node: TokenSyntax) {
    let idx = PoundLineExprSyntax.Cursor.poundLine.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.poundLineKeyword)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .poundLineExpr,
      layout: layout, presence: .present))
  }
}

extension PoundLineExprSyntax {
  /// Creates a `PoundLineExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundLineExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundLineExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout PoundLineExprSyntaxBuilder) -> Void) {
    var builder = PoundLineExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct PoundFileExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func usePoundFile(_ node: TokenSyntax) {
    let idx = PoundFileExprSyntax.Cursor.poundFile.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.poundFileKeyword)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .poundFileExpr,
      layout: layout, presence: .present))
  }
}

extension PoundFileExprSyntax {
  /// Creates a `PoundFileExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundFileExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundFileExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout PoundFileExprSyntaxBuilder) -> Void) {
    var builder = PoundFileExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct PoundFunctionExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func usePoundFunction(_ node: TokenSyntax) {
    let idx = PoundFunctionExprSyntax.Cursor.poundFunction.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.poundFunctionKeyword)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .poundFunctionExpr,
      layout: layout, presence: .present))
  }
}

extension PoundFunctionExprSyntax {
  /// Creates a `PoundFunctionExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundFunctionExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundFunctionExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout PoundFunctionExprSyntaxBuilder) -> Void) {
    var builder = PoundFunctionExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct PoundDsohandleExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func usePoundDsohandle(_ node: TokenSyntax) {
    let idx = PoundDsohandleExprSyntax.Cursor.poundDsohandle.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.poundDsohandleKeyword)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .poundDsohandleExpr,
      layout: layout, presence: .present))
  }
}

extension PoundDsohandleExprSyntax {
  /// Creates a `PoundDsohandleExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundDsohandleExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundDsohandleExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout PoundDsohandleExprSyntaxBuilder) -> Void) {
    var builder = PoundDsohandleExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct SymbolicReferenceExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = SymbolicReferenceExprSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericArgumentClause(_ node: GenericArgumentClauseSyntax) {
    let idx = SymbolicReferenceExprSyntax.Cursor.genericArgumentClause.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.identifier(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .symbolicReferenceExpr,
      layout: layout, presence: .present))
  }
}

extension SymbolicReferenceExprSyntax {
  /// Creates a `SymbolicReferenceExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SymbolicReferenceExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SymbolicReferenceExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout SymbolicReferenceExprSyntaxBuilder) -> Void) {
    var builder = SymbolicReferenceExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct PrefixOperatorExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useOperatorToken(_ node: TokenSyntax) {
    let idx = PrefixOperatorExprSyntax.Cursor.operatorToken.rawValue
    layout[idx] = node.raw
  }

  public mutating func usePostfixExpression(_ node: ExprSyntax) {
    let idx = PrefixOperatorExprSyntax.Cursor.postfixExpression.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.expr)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .prefixOperatorExpr,
      layout: layout, presence: .present))
  }
}

extension PrefixOperatorExprSyntax {
  /// Creates a `PrefixOperatorExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PrefixOperatorExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PrefixOperatorExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout PrefixOperatorExprSyntaxBuilder) -> Void) {
    var builder = PrefixOperatorExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct BinaryOperatorExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func useOperatorToken(_ node: TokenSyntax) {
    let idx = BinaryOperatorExprSyntax.Cursor.operatorToken.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.unknown(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .binaryOperatorExpr,
      layout: layout, presence: .present))
  }
}

extension BinaryOperatorExprSyntax {
  /// Creates a `BinaryOperatorExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `BinaryOperatorExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `BinaryOperatorExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout BinaryOperatorExprSyntaxBuilder) -> Void) {
    var builder = BinaryOperatorExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ArrowExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useThrowsToken(_ node: TokenSyntax) {
    let idx = ArrowExprSyntax.Cursor.throwsToken.rawValue
    layout[idx] = node.raw
  }

  public mutating func useArrowToken(_ node: TokenSyntax) {
    let idx = ArrowExprSyntax.Cursor.arrowToken.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.arrow)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .arrowExpr,
      layout: layout, presence: .present))
  }
}

extension ArrowExprSyntax {
  /// Creates a `ArrowExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ArrowExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ArrowExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ArrowExprSyntaxBuilder) -> Void) {
    var builder = ArrowExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct FloatLiteralExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func useFloatingDigits(_ node: TokenSyntax) {
    let idx = FloatLiteralExprSyntax.Cursor.floatingDigits.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.floatingLiteral(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .floatLiteralExpr,
      layout: layout, presence: .present))
  }
}

extension FloatLiteralExprSyntax {
  /// Creates a `FloatLiteralExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FloatLiteralExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FloatLiteralExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout FloatLiteralExprSyntaxBuilder) -> Void) {
    var builder = FloatLiteralExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct TupleExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = TupleExprSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addElement(_ elt: TupleElementSyntax) {
    let idx = TupleExprSyntax.Cursor.elementList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.tupleElementList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = TupleExprSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.leftParen)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.tupleElementList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.rightParen)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .tupleExpr,
      layout: layout, presence: .present))
  }
}

extension TupleExprSyntax {
  /// Creates a `TupleExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TupleExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TupleExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout TupleExprSyntaxBuilder) -> Void) {
    var builder = TupleExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ArrayExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useLeftSquare(_ node: TokenSyntax) {
    let idx = ArrayExprSyntax.Cursor.leftSquare.rawValue
    layout[idx] = node.raw
  }

  public mutating func addElement(_ elt: ArrayElementSyntax) {
    let idx = ArrayExprSyntax.Cursor.elements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.arrayElementList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightSquare(_ node: TokenSyntax) {
    let idx = ArrayExprSyntax.Cursor.rightSquare.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.leftSquareBracket)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.arrayElementList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.rightSquareBracket)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .arrayExpr,
      layout: layout, presence: .present))
  }
}

extension ArrayExprSyntax {
  /// Creates a `ArrayExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ArrayExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ArrayExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ArrayExprSyntaxBuilder) -> Void) {
    var builder = ArrayExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct DictionaryExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useLeftSquare(_ node: TokenSyntax) {
    let idx = DictionaryExprSyntax.Cursor.leftSquare.rawValue
    layout[idx] = node.raw
  }

  public mutating func useContent(_ node: Syntax) {
    let idx = DictionaryExprSyntax.Cursor.content.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightSquare(_ node: TokenSyntax) {
    let idx = DictionaryExprSyntax.Cursor.rightSquare.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.leftSquareBracket)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.unknown)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.rightSquareBracket)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .dictionaryExpr,
      layout: layout, presence: .present))
  }
}

extension DictionaryExprSyntax {
  /// Creates a `DictionaryExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DictionaryExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DictionaryExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout DictionaryExprSyntaxBuilder) -> Void) {
    var builder = DictionaryExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct FunctionCallArgumentSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useLabel(_ node: TokenSyntax) {
    let idx = FunctionCallArgumentSyntax.Cursor.label.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = FunctionCallArgumentSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = FunctionCallArgumentSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = FunctionCallArgumentSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.expr)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .functionCallArgument,
      layout: layout, presence: .present))
  }
}

extension FunctionCallArgumentSyntax {
  /// Creates a `FunctionCallArgumentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FunctionCallArgumentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FunctionCallArgumentSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout FunctionCallArgumentSyntaxBuilder) -> Void) {
    var builder = FunctionCallArgumentSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct TupleElementSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useLabel(_ node: TokenSyntax) {
    let idx = TupleElementSyntax.Cursor.label.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = TupleElementSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = TupleElementSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = TupleElementSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.expr)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .tupleElement,
      layout: layout, presence: .present))
  }
}

extension TupleElementSyntax {
  /// Creates a `TupleElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TupleElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TupleElementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout TupleElementSyntaxBuilder) -> Void) {
    var builder = TupleElementSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ArrayElementSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = ArrayElementSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = ArrayElementSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.expr)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .arrayElement,
      layout: layout, presence: .present))
  }
}

extension ArrayElementSyntax {
  /// Creates a `ArrayElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ArrayElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ArrayElementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ArrayElementSyntaxBuilder) -> Void) {
    var builder = ArrayElementSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct DictionaryElementSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useKeyExpression(_ node: ExprSyntax) {
    let idx = DictionaryElementSyntax.Cursor.keyExpression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = DictionaryElementSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useValueExpression(_ node: ExprSyntax) {
    let idx = DictionaryElementSyntax.Cursor.valueExpression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = DictionaryElementSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.expr)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.colon)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.expr)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .dictionaryElement,
      layout: layout, presence: .present))
  }
}

extension DictionaryElementSyntax {
  /// Creates a `DictionaryElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DictionaryElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DictionaryElementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout DictionaryElementSyntaxBuilder) -> Void) {
    var builder = DictionaryElementSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct IntegerLiteralExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func useDigits(_ node: TokenSyntax) {
    let idx = IntegerLiteralExprSyntax.Cursor.digits.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.integerLiteral(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .integerLiteralExpr,
      layout: layout, presence: .present))
  }
}

extension IntegerLiteralExprSyntax {
  /// Creates a `IntegerLiteralExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IntegerLiteralExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IntegerLiteralExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout IntegerLiteralExprSyntaxBuilder) -> Void) {
    var builder = IntegerLiteralExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct BooleanLiteralExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func useBooleanLiteral(_ node: TokenSyntax) {
    let idx = BooleanLiteralExprSyntax.Cursor.booleanLiteral.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.trueKeyword)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .booleanLiteralExpr,
      layout: layout, presence: .present))
  }
}

extension BooleanLiteralExprSyntax {
  /// Creates a `BooleanLiteralExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `BooleanLiteralExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `BooleanLiteralExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout BooleanLiteralExprSyntaxBuilder) -> Void) {
    var builder = BooleanLiteralExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct TernaryExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func useConditionExpression(_ node: ExprSyntax) {
    let idx = TernaryExprSyntax.Cursor.conditionExpression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useQuestionMark(_ node: TokenSyntax) {
    let idx = TernaryExprSyntax.Cursor.questionMark.rawValue
    layout[idx] = node.raw
  }

  public mutating func useFirstChoice(_ node: ExprSyntax) {
    let idx = TernaryExprSyntax.Cursor.firstChoice.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColonMark(_ node: TokenSyntax) {
    let idx = TernaryExprSyntax.Cursor.colonMark.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSecondChoice(_ node: ExprSyntax) {
    let idx = TernaryExprSyntax.Cursor.secondChoice.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.expr)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.infixQuestionMark)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.expr)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.colon)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missing(SyntaxKind.expr)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .ternaryExpr,
      layout: layout, presence: .present))
  }
}

extension TernaryExprSyntax {
  /// Creates a `TernaryExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TernaryExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TernaryExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout TernaryExprSyntaxBuilder) -> Void) {
    var builder = TernaryExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct MemberAccessExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useBase(_ node: ExprSyntax) {
    let idx = MemberAccessExprSyntax.Cursor.base.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDot(_ node: TokenSyntax) {
    let idx = MemberAccessExprSyntax.Cursor.dot.rawValue
    layout[idx] = node.raw
  }

  public mutating func useName(_ node: TokenSyntax) {
    let idx = MemberAccessExprSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDeclNameArguments(_ node: DeclNameArgumentsSyntax) {
    let idx = MemberAccessExprSyntax.Cursor.declNameArguments.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.period)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.unknown(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .memberAccessExpr,
      layout: layout, presence: .present))
  }
}

extension MemberAccessExprSyntax {
  /// Creates a `MemberAccessExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `MemberAccessExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `MemberAccessExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout MemberAccessExprSyntaxBuilder) -> Void) {
    var builder = MemberAccessExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct IsExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useIsTok(_ node: TokenSyntax) {
    let idx = IsExprSyntax.Cursor.isTok.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTypeName(_ node: TypeSyntax) {
    let idx = IsExprSyntax.Cursor.typeName.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.isKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.type)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .isExpr,
      layout: layout, presence: .present))
  }
}

extension IsExprSyntax {
  /// Creates a `IsExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IsExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IsExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout IsExprSyntaxBuilder) -> Void) {
    var builder = IsExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct AsExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useAsTok(_ node: TokenSyntax) {
    let idx = AsExprSyntax.Cursor.asTok.rawValue
    layout[idx] = node.raw
  }

  public mutating func useQuestionOrExclamationMark(_ node: TokenSyntax) {
    let idx = AsExprSyntax.Cursor.questionOrExclamationMark.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTypeName(_ node: TypeSyntax) {
    let idx = AsExprSyntax.Cursor.typeName.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.asKeyword)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.type)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .asExpr,
      layout: layout, presence: .present))
  }
}

extension AsExprSyntax {
  /// Creates a `AsExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AsExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AsExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout AsExprSyntaxBuilder) -> Void) {
    var builder = AsExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct TypeExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func useType(_ node: TypeSyntax) {
    let idx = TypeExprSyntax.Cursor.type.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.type)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .typeExpr,
      layout: layout, presence: .present))
  }
}

extension TypeExprSyntax {
  /// Creates a `TypeExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TypeExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TypeExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout TypeExprSyntaxBuilder) -> Void) {
    var builder = TypeExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ClosureCaptureItemSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func addSpecifierToken(_ elt: TokenSyntax) {
    let idx = ClosureCaptureItemSyntax.Cursor.specifier.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.tokenList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useName(_ node: TokenSyntax) {
    let idx = ClosureCaptureItemSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useAssignToken(_ node: TokenSyntax) {
    let idx = ClosureCaptureItemSyntax.Cursor.assignToken.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = ClosureCaptureItemSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = ClosureCaptureItemSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(SyntaxKind.expr)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .closureCaptureItem,
      layout: layout, presence: .present))
  }
}

extension ClosureCaptureItemSyntax {
  /// Creates a `ClosureCaptureItemSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ClosureCaptureItemSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ClosureCaptureItemSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ClosureCaptureItemSyntaxBuilder) -> Void) {
    var builder = ClosureCaptureItemSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ClosureCaptureSignatureSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useLeftSquare(_ node: TokenSyntax) {
    let idx = ClosureCaptureSignatureSyntax.Cursor.leftSquare.rawValue
    layout[idx] = node.raw
  }

  public mutating func addItem(_ elt: ClosureCaptureItemSyntax) {
    let idx = ClosureCaptureSignatureSyntax.Cursor.items.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.closureCaptureItemList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightSquare(_ node: TokenSyntax) {
    let idx = ClosureCaptureSignatureSyntax.Cursor.rightSquare.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.leftSquareBracket)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.rightSquareBracket)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .closureCaptureSignature,
      layout: layout, presence: .present))
  }
}

extension ClosureCaptureSignatureSyntax {
  /// Creates a `ClosureCaptureSignatureSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ClosureCaptureSignatureSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ClosureCaptureSignatureSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ClosureCaptureSignatureSyntaxBuilder) -> Void) {
    var builder = ClosureCaptureSignatureSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ClosureParamSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useName(_ node: TokenSyntax) {
    let idx = ClosureParamSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = ClosureParamSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.identifier(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .closureParam,
      layout: layout, presence: .present))
  }
}

extension ClosureParamSyntax {
  /// Creates a `ClosureParamSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ClosureParamSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ClosureParamSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ClosureParamSyntaxBuilder) -> Void) {
    var builder = ClosureParamSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ClosureSignatureSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func useCapture(_ node: ClosureCaptureSignatureSyntax) {
    let idx = ClosureSignatureSyntax.Cursor.capture.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInput(_ node: Syntax) {
    let idx = ClosureSignatureSyntax.Cursor.input.rawValue
    layout[idx] = node.raw
  }

  public mutating func useThrowsTok(_ node: TokenSyntax) {
    let idx = ClosureSignatureSyntax.Cursor.throwsTok.rawValue
    layout[idx] = node.raw
  }

  public mutating func useOutput(_ node: ReturnClauseSyntax) {
    let idx = ClosureSignatureSyntax.Cursor.output.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInTok(_ node: TokenSyntax) {
    let idx = ClosureSignatureSyntax.Cursor.inTok.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missingToken(TokenKind.inKeyword)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .closureSignature,
      layout: layout, presence: .present))
  }
}

extension ClosureSignatureSyntax {
  /// Creates a `ClosureSignatureSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ClosureSignatureSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ClosureSignatureSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ClosureSignatureSyntaxBuilder) -> Void) {
    var builder = ClosureSignatureSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ClosureExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useLeftBrace(_ node: TokenSyntax) {
    let idx = ClosureExprSyntax.Cursor.leftBrace.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSignature(_ node: ClosureSignatureSyntax) {
    let idx = ClosureExprSyntax.Cursor.signature.rawValue
    layout[idx] = node.raw
  }

  public mutating func addStatement(_ elt: CodeBlockItemSyntax) {
    let idx = ClosureExprSyntax.Cursor.statements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.codeBlockItemList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightBrace(_ node: TokenSyntax) {
    let idx = ClosureExprSyntax.Cursor.rightBrace.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.leftBrace)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.codeBlockItemList)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.rightBrace)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .closureExpr,
      layout: layout, presence: .present))
  }
}

extension ClosureExprSyntax {
  /// Creates a `ClosureExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ClosureExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ClosureExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ClosureExprSyntaxBuilder) -> Void) {
    var builder = ClosureExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct UnresolvedPatternExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func usePattern(_ node: PatternSyntax) {
    let idx = UnresolvedPatternExprSyntax.Cursor.pattern.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.pattern)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .unresolvedPatternExpr,
      layout: layout, presence: .present))
  }
}

extension UnresolvedPatternExprSyntax {
  /// Creates a `UnresolvedPatternExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `UnresolvedPatternExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `UnresolvedPatternExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout UnresolvedPatternExprSyntaxBuilder) -> Void) {
    var builder = UnresolvedPatternExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct FunctionCallExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func useCalledExpression(_ node: ExprSyntax) {
    let idx = FunctionCallExprSyntax.Cursor.calledExpression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = FunctionCallExprSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addArgument(_ elt: FunctionCallArgumentSyntax) {
    let idx = FunctionCallExprSyntax.Cursor.argumentList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.functionCallArgumentList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = FunctionCallExprSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingClosure(_ node: ClosureExprSyntax) {
    let idx = FunctionCallExprSyntax.Cursor.trailingClosure.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.expr)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.functionCallArgumentList)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .functionCallExpr,
      layout: layout, presence: .present))
  }
}

extension FunctionCallExprSyntax {
  /// Creates a `FunctionCallExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FunctionCallExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FunctionCallExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout FunctionCallExprSyntaxBuilder) -> Void) {
    var builder = FunctionCallExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct SubscriptExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func useCalledExpression(_ node: ExprSyntax) {
    let idx = SubscriptExprSyntax.Cursor.calledExpression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftBracket(_ node: TokenSyntax) {
    let idx = SubscriptExprSyntax.Cursor.leftBracket.rawValue
    layout[idx] = node.raw
  }

  public mutating func addArgument(_ elt: FunctionCallArgumentSyntax) {
    let idx = SubscriptExprSyntax.Cursor.argumentList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.functionCallArgumentList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightBracket(_ node: TokenSyntax) {
    let idx = SubscriptExprSyntax.Cursor.rightBracket.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingClosure(_ node: ClosureExprSyntax) {
    let idx = SubscriptExprSyntax.Cursor.trailingClosure.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.expr)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.leftSquareBracket)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.functionCallArgumentList)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.rightSquareBracket)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .subscriptExpr,
      layout: layout, presence: .present))
  }
}

extension SubscriptExprSyntax {
  /// Creates a `SubscriptExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SubscriptExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SubscriptExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout SubscriptExprSyntaxBuilder) -> Void) {
    var builder = SubscriptExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct OptionalChainingExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = OptionalChainingExprSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useQuestionMark(_ node: TokenSyntax) {
    let idx = OptionalChainingExprSyntax.Cursor.questionMark.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.expr)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.postfixQuestionMark)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .optionalChainingExpr,
      layout: layout, presence: .present))
  }
}

extension OptionalChainingExprSyntax {
  /// Creates a `OptionalChainingExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `OptionalChainingExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `OptionalChainingExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout OptionalChainingExprSyntaxBuilder) -> Void) {
    var builder = OptionalChainingExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ForcedValueExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = ForcedValueExprSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExclamationMark(_ node: TokenSyntax) {
    let idx = ForcedValueExprSyntax.Cursor.exclamationMark.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.expr)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.exclamationMark)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .forcedValueExpr,
      layout: layout, presence: .present))
  }
}

extension ForcedValueExprSyntax {
  /// Creates a `ForcedValueExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ForcedValueExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ForcedValueExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ForcedValueExprSyntaxBuilder) -> Void) {
    var builder = ForcedValueExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct PostfixUnaryExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = PostfixUnaryExprSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useOperatorToken(_ node: TokenSyntax) {
    let idx = PostfixUnaryExprSyntax.Cursor.operatorToken.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.expr)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.postfixOperator(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .postfixUnaryExpr,
      layout: layout, presence: .present))
  }
}

extension PostfixUnaryExprSyntax {
  /// Creates a `PostfixUnaryExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PostfixUnaryExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PostfixUnaryExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout PostfixUnaryExprSyntaxBuilder) -> Void) {
    var builder = PostfixUnaryExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct SpecializeExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = SpecializeExprSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericArgumentClause(_ node: GenericArgumentClauseSyntax) {
    let idx = SpecializeExprSyntax.Cursor.genericArgumentClause.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.expr)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.genericArgumentClause)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .specializeExpr,
      layout: layout, presence: .present))
  }
}

extension SpecializeExprSyntax {
  /// Creates a `SpecializeExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SpecializeExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SpecializeExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout SpecializeExprSyntaxBuilder) -> Void) {
    var builder = SpecializeExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct StringSegmentSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func useContent(_ node: TokenSyntax) {
    let idx = StringSegmentSyntax.Cursor.content.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.stringSegment(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .stringSegment,
      layout: layout, presence: .present))
  }
}

extension StringSegmentSyntax {
  /// Creates a `StringSegmentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `StringSegmentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `StringSegmentSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout StringSegmentSyntaxBuilder) -> Void) {
    var builder = StringSegmentSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ExpressionSegmentSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func useBackslash(_ node: TokenSyntax) {
    let idx = ExpressionSegmentSyntax.Cursor.backslash.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDelimiter(_ node: TokenSyntax) {
    let idx = ExpressionSegmentSyntax.Cursor.delimiter.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = ExpressionSegmentSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addExpression(_ elt: FunctionCallArgumentSyntax) {
    let idx = ExpressionSegmentSyntax.Cursor.expressions.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.functionCallArgumentList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = ExpressionSegmentSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.backslash)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.leftParen)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(SyntaxKind.functionCallArgumentList)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missingToken(TokenKind.stringInterpolationAnchor)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .expressionSegment,
      layout: layout, presence: .present))
  }
}

extension ExpressionSegmentSyntax {
  /// Creates a `ExpressionSegmentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ExpressionSegmentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ExpressionSegmentSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ExpressionSegmentSyntaxBuilder) -> Void) {
    var builder = ExpressionSegmentSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct StringLiteralExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func useOpenDelimiter(_ node: TokenSyntax) {
    let idx = StringLiteralExprSyntax.Cursor.openDelimiter.rawValue
    layout[idx] = node.raw
  }

  public mutating func useOpenQuote(_ node: TokenSyntax) {
    let idx = StringLiteralExprSyntax.Cursor.openQuote.rawValue
    layout[idx] = node.raw
  }

  public mutating func addSegment(_ elt: Syntax) {
    let idx = StringLiteralExprSyntax.Cursor.segments.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.stringLiteralSegments,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useCloseQuote(_ node: TokenSyntax) {
    let idx = StringLiteralExprSyntax.Cursor.closeQuote.rawValue
    layout[idx] = node.raw
  }

  public mutating func useCloseDelimiter(_ node: TokenSyntax) {
    let idx = StringLiteralExprSyntax.Cursor.closeDelimiter.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.stringQuote)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.stringLiteralSegments)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.stringQuote)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .stringLiteralExpr,
      layout: layout, presence: .present))
  }
}

extension StringLiteralExprSyntax {
  /// Creates a `StringLiteralExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `StringLiteralExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `StringLiteralExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout StringLiteralExprSyntaxBuilder) -> Void) {
    var builder = StringLiteralExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct KeyPathExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useBackslash(_ node: TokenSyntax) {
    let idx = KeyPathExprSyntax.Cursor.backslash.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRootExpr(_ node: ExprSyntax) {
    let idx = KeyPathExprSyntax.Cursor.rootExpr.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = KeyPathExprSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.backslash)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.expr)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .keyPathExpr,
      layout: layout, presence: .present))
  }
}

extension KeyPathExprSyntax {
  /// Creates a `KeyPathExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `KeyPathExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `KeyPathExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout KeyPathExprSyntaxBuilder) -> Void) {
    var builder = KeyPathExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct KeyPathBaseExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func usePeriod(_ node: TokenSyntax) {
    let idx = KeyPathBaseExprSyntax.Cursor.period.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.period)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .keyPathBaseExpr,
      layout: layout, presence: .present))
  }
}

extension KeyPathBaseExprSyntax {
  /// Creates a `KeyPathBaseExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `KeyPathBaseExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `KeyPathBaseExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout KeyPathBaseExprSyntaxBuilder) -> Void) {
    var builder = KeyPathBaseExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ObjcNamePieceSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useName(_ node: TokenSyntax) {
    let idx = ObjcNamePieceSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDot(_ node: TokenSyntax) {
    let idx = ObjcNamePieceSyntax.Cursor.dot.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.identifier(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .objcNamePiece,
      layout: layout, presence: .present))
  }
}

extension ObjcNamePieceSyntax {
  /// Creates a `ObjcNamePieceSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ObjcNamePieceSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ObjcNamePieceSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ObjcNamePieceSyntaxBuilder) -> Void) {
    var builder = ObjcNamePieceSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ObjcKeyPathExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useKeyPath(_ node: TokenSyntax) {
    let idx = ObjcKeyPathExprSyntax.Cursor.keyPath.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = ObjcKeyPathExprSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addNamePiece(_ elt: ObjcNamePieceSyntax) {
    let idx = ObjcKeyPathExprSyntax.Cursor.name.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.objcName,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = ObjcKeyPathExprSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.poundKeyPathKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.leftParen)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.objcName)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.rightParen)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .objcKeyPathExpr,
      layout: layout, presence: .present))
  }
}

extension ObjcKeyPathExprSyntax {
  /// Creates a `ObjcKeyPathExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ObjcKeyPathExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ObjcKeyPathExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ObjcKeyPathExprSyntaxBuilder) -> Void) {
    var builder = ObjcKeyPathExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ObjcSelectorExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 6)

  internal init() {}

  public mutating func usePoundSelector(_ node: TokenSyntax) {
    let idx = ObjcSelectorExprSyntax.Cursor.poundSelector.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = ObjcSelectorExprSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func useKind(_ node: TokenSyntax) {
    let idx = ObjcSelectorExprSyntax.Cursor.kind.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = ObjcSelectorExprSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useName(_ node: ExprSyntax) {
    let idx = ObjcSelectorExprSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = ObjcSelectorExprSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.poundSelectorKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.leftParen)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missing(SyntaxKind.expr)
    }
    if (layout[5] == nil) {
      layout[5] = RawSyntax.missingToken(TokenKind.rightParen)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .objcSelectorExpr,
      layout: layout, presence: .present))
  }
}

extension ObjcSelectorExprSyntax {
  /// Creates a `ObjcSelectorExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ObjcSelectorExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ObjcSelectorExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ObjcSelectorExprSyntaxBuilder) -> Void) {
    var builder = ObjcSelectorExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct EditorPlaceholderExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = EditorPlaceholderExprSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.identifier(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .editorPlaceholderExpr,
      layout: layout, presence: .present))
  }
}

extension EditorPlaceholderExprSyntax {
  /// Creates a `EditorPlaceholderExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `EditorPlaceholderExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `EditorPlaceholderExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout EditorPlaceholderExprSyntaxBuilder) -> Void) {
    var builder = EditorPlaceholderExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ObjectLiteralExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = ObjectLiteralExprSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = ObjectLiteralExprSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addArgument(_ elt: FunctionCallArgumentSyntax) {
    let idx = ObjectLiteralExprSyntax.Cursor.arguments.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.functionCallArgumentList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = ObjectLiteralExprSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.poundColorLiteralKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.leftParen)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.functionCallArgumentList)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.rightParen)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .objectLiteralExpr,
      layout: layout, presence: .present))
  }
}

extension ObjectLiteralExprSyntax {
  /// Creates a `ObjectLiteralExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ObjectLiteralExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ObjectLiteralExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ObjectLiteralExprSyntaxBuilder) -> Void) {
    var builder = ObjectLiteralExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct TypeInitializerClauseSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useEqual(_ node: TokenSyntax) {
    let idx = TypeInitializerClauseSyntax.Cursor.equal.rawValue
    layout[idx] = node.raw
  }

  public mutating func useValue(_ node: TypeSyntax) {
    let idx = TypeInitializerClauseSyntax.Cursor.value.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.equal)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.type)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .typeInitializerClause,
      layout: layout, presence: .present))
  }
}

extension TypeInitializerClauseSyntax {
  /// Creates a `TypeInitializerClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TypeInitializerClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TypeInitializerClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout TypeInitializerClauseSyntaxBuilder) -> Void) {
    var builder = TypeInitializerClauseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct TypealiasDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 7)

  internal init() {}

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = TypealiasDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = TypealiasDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useTypealiasKeyword(_ node: TokenSyntax) {
    let idx = TypealiasDeclSyntax.Cursor.typealiasKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = TypealiasDeclSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericParameterClause(_ node: GenericParameterClauseSyntax) {
    let idx = TypealiasDeclSyntax.Cursor.genericParameterClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInitializer(_ node: TypeInitializerClauseSyntax) {
    let idx = TypealiasDeclSyntax.Cursor.initializer.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericWhereClause(_ node: GenericWhereClauseSyntax) {
    let idx = TypealiasDeclSyntax.Cursor.genericWhereClause.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.typealiasKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.identifier(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .typealiasDecl,
      layout: layout, presence: .present))
  }
}

extension TypealiasDeclSyntax {
  /// Creates a `TypealiasDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TypealiasDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TypealiasDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout TypealiasDeclSyntaxBuilder) -> Void) {
    var builder = TypealiasDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct AssociatedtypeDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 7)

  internal init() {}

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = AssociatedtypeDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = AssociatedtypeDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useAssociatedtypeKeyword(_ node: TokenSyntax) {
    let idx = AssociatedtypeDeclSyntax.Cursor.associatedtypeKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = AssociatedtypeDeclSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInheritanceClause(_ node: TypeInheritanceClauseSyntax) {
    let idx = AssociatedtypeDeclSyntax.Cursor.inheritanceClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInitializer(_ node: TypeInitializerClauseSyntax) {
    let idx = AssociatedtypeDeclSyntax.Cursor.initializer.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericWhereClause(_ node: GenericWhereClauseSyntax) {
    let idx = AssociatedtypeDeclSyntax.Cursor.genericWhereClause.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.associatedtypeKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.identifier(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .associatedtypeDecl,
      layout: layout, presence: .present))
  }
}

extension AssociatedtypeDeclSyntax {
  /// Creates a `AssociatedtypeDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AssociatedtypeDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AssociatedtypeDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout AssociatedtypeDeclSyntaxBuilder) -> Void) {
    var builder = AssociatedtypeDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ParameterClauseSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = ParameterClauseSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addParameter(_ elt: FunctionParameterSyntax) {
    let idx = ParameterClauseSyntax.Cursor.parameterList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.functionParameterList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = ParameterClauseSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.leftParen)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.functionParameterList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.rightParen)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .parameterClause,
      layout: layout, presence: .present))
  }
}

extension ParameterClauseSyntax {
  /// Creates a `ParameterClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ParameterClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ParameterClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ParameterClauseSyntaxBuilder) -> Void) {
    var builder = ParameterClauseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ReturnClauseSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useArrow(_ node: TokenSyntax) {
    let idx = ReturnClauseSyntax.Cursor.arrow.rawValue
    layout[idx] = node.raw
  }

  public mutating func useReturnType(_ node: TypeSyntax) {
    let idx = ReturnClauseSyntax.Cursor.returnType.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.arrow)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.type)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .returnClause,
      layout: layout, presence: .present))
  }
}

extension ReturnClauseSyntax {
  /// Creates a `ReturnClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ReturnClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ReturnClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ReturnClauseSyntaxBuilder) -> Void) {
    var builder = ReturnClauseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct FunctionSignatureSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useInput(_ node: ParameterClauseSyntax) {
    let idx = FunctionSignatureSyntax.Cursor.input.rawValue
    layout[idx] = node.raw
  }

  public mutating func useThrowsOrRethrowsKeyword(_ node: TokenSyntax) {
    let idx = FunctionSignatureSyntax.Cursor.throwsOrRethrowsKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useOutput(_ node: ReturnClauseSyntax) {
    let idx = FunctionSignatureSyntax.Cursor.output.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.parameterClause)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .functionSignature,
      layout: layout, presence: .present))
  }
}

extension FunctionSignatureSyntax {
  /// Creates a `FunctionSignatureSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FunctionSignatureSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FunctionSignatureSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout FunctionSignatureSyntaxBuilder) -> Void) {
    var builder = FunctionSignatureSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct IfConfigClauseSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func usePoundKeyword(_ node: TokenSyntax) {
    let idx = IfConfigClauseSyntax.Cursor.poundKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useCondition(_ node: ExprSyntax) {
    let idx = IfConfigClauseSyntax.Cursor.condition.rawValue
    layout[idx] = node.raw
  }

  public mutating func useElements(_ node: Syntax) {
    let idx = IfConfigClauseSyntax.Cursor.elements.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.poundIfKeyword)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.unknown)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .ifConfigClause,
      layout: layout, presence: .present))
  }
}

extension IfConfigClauseSyntax {
  /// Creates a `IfConfigClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IfConfigClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IfConfigClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout IfConfigClauseSyntaxBuilder) -> Void) {
    var builder = IfConfigClauseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct IfConfigDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func addClause(_ elt: IfConfigClauseSyntax) {
    let idx = IfConfigDeclSyntax.Cursor.clauses.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.ifConfigClauseList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func usePoundEndif(_ node: TokenSyntax) {
    let idx = IfConfigDeclSyntax.Cursor.poundEndif.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.ifConfigClauseList)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.poundEndifKeyword)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .ifConfigDecl,
      layout: layout, presence: .present))
  }
}

extension IfConfigDeclSyntax {
  /// Creates a `IfConfigDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IfConfigDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IfConfigDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout IfConfigDeclSyntaxBuilder) -> Void) {
    var builder = IfConfigDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct PoundErrorDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func usePoundError(_ node: TokenSyntax) {
    let idx = PoundErrorDeclSyntax.Cursor.poundError.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = PoundErrorDeclSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func useMessage(_ node: StringLiteralExprSyntax) {
    let idx = PoundErrorDeclSyntax.Cursor.message.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = PoundErrorDeclSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.poundErrorKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.leftParen)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.stringLiteralExpr)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.rightParen)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .poundErrorDecl,
      layout: layout, presence: .present))
  }
}

extension PoundErrorDeclSyntax {
  /// Creates a `PoundErrorDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundErrorDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundErrorDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout PoundErrorDeclSyntaxBuilder) -> Void) {
    var builder = PoundErrorDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct PoundWarningDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func usePoundWarning(_ node: TokenSyntax) {
    let idx = PoundWarningDeclSyntax.Cursor.poundWarning.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = PoundWarningDeclSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func useMessage(_ node: StringLiteralExprSyntax) {
    let idx = PoundWarningDeclSyntax.Cursor.message.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = PoundWarningDeclSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.poundWarningKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.leftParen)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.stringLiteralExpr)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.rightParen)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .poundWarningDecl,
      layout: layout, presence: .present))
  }
}

extension PoundWarningDeclSyntax {
  /// Creates a `PoundWarningDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundWarningDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundWarningDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout PoundWarningDeclSyntaxBuilder) -> Void) {
    var builder = PoundWarningDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct PoundSourceLocationSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func usePoundSourceLocation(_ node: TokenSyntax) {
    let idx = PoundSourceLocationSyntax.Cursor.poundSourceLocation.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = PoundSourceLocationSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func useArgs(_ node: PoundSourceLocationArgsSyntax) {
    let idx = PoundSourceLocationSyntax.Cursor.args.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = PoundSourceLocationSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.poundSourceLocationKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.leftParen)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.rightParen)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .poundSourceLocation,
      layout: layout, presence: .present))
  }
}

extension PoundSourceLocationSyntax {
  /// Creates a `PoundSourceLocationSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundSourceLocationSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundSourceLocationSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout PoundSourceLocationSyntaxBuilder) -> Void) {
    var builder = PoundSourceLocationSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct PoundSourceLocationArgsSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 7)

  internal init() {}

  public mutating func useFileArgLabel(_ node: TokenSyntax) {
    let idx = PoundSourceLocationArgsSyntax.Cursor.fileArgLabel.rawValue
    layout[idx] = node.raw
  }

  public mutating func useFileArgColon(_ node: TokenSyntax) {
    let idx = PoundSourceLocationArgsSyntax.Cursor.fileArgColon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useFileName(_ node: TokenSyntax) {
    let idx = PoundSourceLocationArgsSyntax.Cursor.fileName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useComma(_ node: TokenSyntax) {
    let idx = PoundSourceLocationArgsSyntax.Cursor.comma.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLineArgLabel(_ node: TokenSyntax) {
    let idx = PoundSourceLocationArgsSyntax.Cursor.lineArgLabel.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLineArgColon(_ node: TokenSyntax) {
    let idx = PoundSourceLocationArgsSyntax.Cursor.lineArgColon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLineNumber(_ node: TokenSyntax) {
    let idx = PoundSourceLocationArgsSyntax.Cursor.lineNumber.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.identifier(""))
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.colon)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.stringLiteral(""))
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.comma)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missingToken(TokenKind.identifier(""))
    }
    if (layout[5] == nil) {
      layout[5] = RawSyntax.missingToken(TokenKind.colon)
    }
    if (layout[6] == nil) {
      layout[6] = RawSyntax.missingToken(TokenKind.integerLiteral(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .poundSourceLocationArgs,
      layout: layout, presence: .present))
  }
}

extension PoundSourceLocationArgsSyntax {
  /// Creates a `PoundSourceLocationArgsSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundSourceLocationArgsSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundSourceLocationArgsSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout PoundSourceLocationArgsSyntaxBuilder) -> Void) {
    var builder = PoundSourceLocationArgsSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct DeclModifierSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useName(_ node: TokenSyntax) {
    let idx = DeclModifierSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDetailLeftParen(_ node: TokenSyntax) {
    let idx = DeclModifierSyntax.Cursor.detailLeftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDetail(_ node: TokenSyntax) {
    let idx = DeclModifierSyntax.Cursor.detail.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDetailRightParen(_ node: TokenSyntax) {
    let idx = DeclModifierSyntax.Cursor.detailRightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.unknown(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .declModifier,
      layout: layout, presence: .present))
  }
}

extension DeclModifierSyntax {
  /// Creates a `DeclModifierSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DeclModifierSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DeclModifierSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout DeclModifierSyntaxBuilder) -> Void) {
    var builder = DeclModifierSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct InheritedTypeSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useTypeName(_ node: TypeSyntax) {
    let idx = InheritedTypeSyntax.Cursor.typeName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = InheritedTypeSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.type)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .inheritedType,
      layout: layout, presence: .present))
  }
}

extension InheritedTypeSyntax {
  /// Creates a `InheritedTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `InheritedTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `InheritedTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout InheritedTypeSyntaxBuilder) -> Void) {
    var builder = InheritedTypeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct TypeInheritanceClauseSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = TypeInheritanceClauseSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func addInheritedType(_ elt: InheritedTypeSyntax) {
    let idx = TypeInheritanceClauseSyntax.Cursor.inheritedTypeCollection.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.inheritedTypeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.colon)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.inheritedTypeList)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .typeInheritanceClause,
      layout: layout, presence: .present))
  }
}

extension TypeInheritanceClauseSyntax {
  /// Creates a `TypeInheritanceClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TypeInheritanceClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TypeInheritanceClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout TypeInheritanceClauseSyntaxBuilder) -> Void) {
    var builder = TypeInheritanceClauseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ClassDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 8)

  internal init() {}

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = ClassDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = ClassDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useClassKeyword(_ node: TokenSyntax) {
    let idx = ClassDeclSyntax.Cursor.classKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = ClassDeclSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericParameterClause(_ node: GenericParameterClauseSyntax) {
    let idx = ClassDeclSyntax.Cursor.genericParameterClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInheritanceClause(_ node: TypeInheritanceClauseSyntax) {
    let idx = ClassDeclSyntax.Cursor.inheritanceClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericWhereClause(_ node: GenericWhereClauseSyntax) {
    let idx = ClassDeclSyntax.Cursor.genericWhereClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useMembers(_ node: MemberDeclBlockSyntax) {
    let idx = ClassDeclSyntax.Cursor.members.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.classKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.identifier(""))
    }
    if (layout[7] == nil) {
      layout[7] = RawSyntax.missing(SyntaxKind.memberDeclBlock)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .classDecl,
      layout: layout, presence: .present))
  }
}

extension ClassDeclSyntax {
  /// Creates a `ClassDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ClassDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ClassDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ClassDeclSyntaxBuilder) -> Void) {
    var builder = ClassDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct StructDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 8)

  internal init() {}

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = StructDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = StructDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useStructKeyword(_ node: TokenSyntax) {
    let idx = StructDeclSyntax.Cursor.structKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = StructDeclSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericParameterClause(_ node: GenericParameterClauseSyntax) {
    let idx = StructDeclSyntax.Cursor.genericParameterClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInheritanceClause(_ node: TypeInheritanceClauseSyntax) {
    let idx = StructDeclSyntax.Cursor.inheritanceClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericWhereClause(_ node: GenericWhereClauseSyntax) {
    let idx = StructDeclSyntax.Cursor.genericWhereClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useMembers(_ node: MemberDeclBlockSyntax) {
    let idx = StructDeclSyntax.Cursor.members.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.structKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.identifier(""))
    }
    if (layout[7] == nil) {
      layout[7] = RawSyntax.missing(SyntaxKind.memberDeclBlock)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .structDecl,
      layout: layout, presence: .present))
  }
}

extension StructDeclSyntax {
  /// Creates a `StructDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `StructDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `StructDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout StructDeclSyntaxBuilder) -> Void) {
    var builder = StructDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ProtocolDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 7)

  internal init() {}

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = ProtocolDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = ProtocolDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useProtocolKeyword(_ node: TokenSyntax) {
    let idx = ProtocolDeclSyntax.Cursor.protocolKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = ProtocolDeclSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInheritanceClause(_ node: TypeInheritanceClauseSyntax) {
    let idx = ProtocolDeclSyntax.Cursor.inheritanceClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericWhereClause(_ node: GenericWhereClauseSyntax) {
    let idx = ProtocolDeclSyntax.Cursor.genericWhereClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useMembers(_ node: MemberDeclBlockSyntax) {
    let idx = ProtocolDeclSyntax.Cursor.members.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.protocolKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.identifier(""))
    }
    if (layout[6] == nil) {
      layout[6] = RawSyntax.missing(SyntaxKind.memberDeclBlock)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .protocolDecl,
      layout: layout, presence: .present))
  }
}

extension ProtocolDeclSyntax {
  /// Creates a `ProtocolDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ProtocolDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ProtocolDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ProtocolDeclSyntaxBuilder) -> Void) {
    var builder = ProtocolDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ExtensionDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 7)

  internal init() {}

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = ExtensionDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = ExtensionDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useExtensionKeyword(_ node: TokenSyntax) {
    let idx = ExtensionDeclSyntax.Cursor.extensionKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExtendedType(_ node: TypeSyntax) {
    let idx = ExtensionDeclSyntax.Cursor.extendedType.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInheritanceClause(_ node: TypeInheritanceClauseSyntax) {
    let idx = ExtensionDeclSyntax.Cursor.inheritanceClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericWhereClause(_ node: GenericWhereClauseSyntax) {
    let idx = ExtensionDeclSyntax.Cursor.genericWhereClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useMembers(_ node: MemberDeclBlockSyntax) {
    let idx = ExtensionDeclSyntax.Cursor.members.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.extensionKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(SyntaxKind.type)
    }
    if (layout[6] == nil) {
      layout[6] = RawSyntax.missing(SyntaxKind.memberDeclBlock)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .extensionDecl,
      layout: layout, presence: .present))
  }
}

extension ExtensionDeclSyntax {
  /// Creates a `ExtensionDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ExtensionDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ExtensionDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ExtensionDeclSyntaxBuilder) -> Void) {
    var builder = ExtensionDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct MemberDeclBlockSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useLeftBrace(_ node: TokenSyntax) {
    let idx = MemberDeclBlockSyntax.Cursor.leftBrace.rawValue
    layout[idx] = node.raw
  }

  public mutating func addMember(_ elt: MemberDeclListItemSyntax) {
    let idx = MemberDeclBlockSyntax.Cursor.members.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.memberDeclList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightBrace(_ node: TokenSyntax) {
    let idx = MemberDeclBlockSyntax.Cursor.rightBrace.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.leftBrace)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.memberDeclList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.rightBrace)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .memberDeclBlock,
      layout: layout, presence: .present))
  }
}

extension MemberDeclBlockSyntax {
  /// Creates a `MemberDeclBlockSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `MemberDeclBlockSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `MemberDeclBlockSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout MemberDeclBlockSyntaxBuilder) -> Void) {
    var builder = MemberDeclBlockSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct MemberDeclListItemSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useDecl(_ node: DeclSyntax) {
    let idx = MemberDeclListItemSyntax.Cursor.decl.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSemicolon(_ node: TokenSyntax) {
    let idx = MemberDeclListItemSyntax.Cursor.semicolon.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.decl)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .memberDeclListItem,
      layout: layout, presence: .present))
  }
}

extension MemberDeclListItemSyntax {
  /// Creates a `MemberDeclListItemSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `MemberDeclListItemSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `MemberDeclListItemSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout MemberDeclListItemSyntaxBuilder) -> Void) {
    var builder = MemberDeclListItemSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct SourceFileSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func addStatement(_ elt: CodeBlockItemSyntax) {
    let idx = SourceFileSyntax.Cursor.statements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.codeBlockItemList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useEOFToken(_ node: TokenSyntax) {
    let idx = SourceFileSyntax.Cursor.eofToken.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.codeBlockItemList)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.unknown(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .sourceFile,
      layout: layout, presence: .present))
  }
}

extension SourceFileSyntax {
  /// Creates a `SourceFileSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SourceFileSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SourceFileSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout SourceFileSyntaxBuilder) -> Void) {
    var builder = SourceFileSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct InitializerClauseSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useEqual(_ node: TokenSyntax) {
    let idx = InitializerClauseSyntax.Cursor.equal.rawValue
    layout[idx] = node.raw
  }

  public mutating func useValue(_ node: ExprSyntax) {
    let idx = InitializerClauseSyntax.Cursor.value.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.equal)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.expr)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .initializerClause,
      layout: layout, presence: .present))
  }
}

extension InitializerClauseSyntax {
  /// Creates a `InitializerClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `InitializerClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `InitializerClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout InitializerClauseSyntaxBuilder) -> Void) {
    var builder = InitializerClauseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct FunctionParameterSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 8)

  internal init() {}

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = FunctionParameterSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useFirstName(_ node: TokenSyntax) {
    let idx = FunctionParameterSyntax.Cursor.firstName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSecondName(_ node: TokenSyntax) {
    let idx = FunctionParameterSyntax.Cursor.secondName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = FunctionParameterSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useType(_ node: TypeSyntax) {
    let idx = FunctionParameterSyntax.Cursor.type.rawValue
    layout[idx] = node.raw
  }

  public mutating func useEllipsis(_ node: TokenSyntax) {
    let idx = FunctionParameterSyntax.Cursor.ellipsis.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDefaultArgument(_ node: InitializerClauseSyntax) {
    let idx = FunctionParameterSyntax.Cursor.defaultArgument.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = FunctionParameterSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {

    return .forRoot(RawSyntax.createAndCalcLength(kind: .functionParameter,
      layout: layout, presence: .present))
  }
}

extension FunctionParameterSyntax {
  /// Creates a `FunctionParameterSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FunctionParameterSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FunctionParameterSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout FunctionParameterSyntaxBuilder) -> Void) {
    var builder = FunctionParameterSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct FunctionDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 8)

  internal init() {}

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = FunctionDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = FunctionDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useFuncKeyword(_ node: TokenSyntax) {
    let idx = FunctionDeclSyntax.Cursor.funcKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = FunctionDeclSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericParameterClause(_ node: GenericParameterClauseSyntax) {
    let idx = FunctionDeclSyntax.Cursor.genericParameterClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSignature(_ node: FunctionSignatureSyntax) {
    let idx = FunctionDeclSyntax.Cursor.signature.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericWhereClause(_ node: GenericWhereClauseSyntax) {
    let idx = FunctionDeclSyntax.Cursor.genericWhereClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = FunctionDeclSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.funcKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.identifier(""))
    }
    if (layout[5] == nil) {
      layout[5] = RawSyntax.missing(SyntaxKind.functionSignature)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .functionDecl,
      layout: layout, presence: .present))
  }
}

extension FunctionDeclSyntax {
  /// Creates a `FunctionDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FunctionDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FunctionDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout FunctionDeclSyntaxBuilder) -> Void) {
    var builder = FunctionDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct InitializerDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 9)

  internal init() {}

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = InitializerDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = InitializerDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useInitKeyword(_ node: TokenSyntax) {
    let idx = InitializerDeclSyntax.Cursor.initKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useOptionalMark(_ node: TokenSyntax) {
    let idx = InitializerDeclSyntax.Cursor.optionalMark.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericParameterClause(_ node: GenericParameterClauseSyntax) {
    let idx = InitializerDeclSyntax.Cursor.genericParameterClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useParameters(_ node: ParameterClauseSyntax) {
    let idx = InitializerDeclSyntax.Cursor.parameters.rawValue
    layout[idx] = node.raw
  }

  public mutating func useThrowsOrRethrowsKeyword(_ node: TokenSyntax) {
    let idx = InitializerDeclSyntax.Cursor.throwsOrRethrowsKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericWhereClause(_ node: GenericWhereClauseSyntax) {
    let idx = InitializerDeclSyntax.Cursor.genericWhereClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = InitializerDeclSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.initKeyword)
    }
    if (layout[5] == nil) {
      layout[5] = RawSyntax.missing(SyntaxKind.parameterClause)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .initializerDecl,
      layout: layout, presence: .present))
  }
}

extension InitializerDeclSyntax {
  /// Creates a `InitializerDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `InitializerDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `InitializerDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout InitializerDeclSyntaxBuilder) -> Void) {
    var builder = InitializerDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct DeinitializerDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = DeinitializerDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = DeinitializerDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useDeinitKeyword(_ node: TokenSyntax) {
    let idx = DeinitializerDeclSyntax.Cursor.deinitKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = DeinitializerDeclSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.deinitKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(SyntaxKind.codeBlock)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .deinitializerDecl,
      layout: layout, presence: .present))
  }
}

extension DeinitializerDeclSyntax {
  /// Creates a `DeinitializerDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DeinitializerDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DeinitializerDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout DeinitializerDeclSyntaxBuilder) -> Void) {
    var builder = DeinitializerDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct SubscriptDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 8)

  internal init() {}

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = SubscriptDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = SubscriptDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useSubscriptKeyword(_ node: TokenSyntax) {
    let idx = SubscriptDeclSyntax.Cursor.subscriptKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericParameterClause(_ node: GenericParameterClauseSyntax) {
    let idx = SubscriptDeclSyntax.Cursor.genericParameterClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useIndices(_ node: ParameterClauseSyntax) {
    let idx = SubscriptDeclSyntax.Cursor.indices.rawValue
    layout[idx] = node.raw
  }

  public mutating func useResult(_ node: ReturnClauseSyntax) {
    let idx = SubscriptDeclSyntax.Cursor.result.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericWhereClause(_ node: GenericWhereClauseSyntax) {
    let idx = SubscriptDeclSyntax.Cursor.genericWhereClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useAccessor(_ node: Syntax) {
    let idx = SubscriptDeclSyntax.Cursor.accessor.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.subscriptKeyword)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missing(SyntaxKind.parameterClause)
    }
    if (layout[5] == nil) {
      layout[5] = RawSyntax.missing(SyntaxKind.returnClause)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .subscriptDecl,
      layout: layout, presence: .present))
  }
}

extension SubscriptDeclSyntax {
  /// Creates a `SubscriptDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SubscriptDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SubscriptDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout SubscriptDeclSyntaxBuilder) -> Void) {
    var builder = SubscriptDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct AccessLevelModifierSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useName(_ node: TokenSyntax) {
    let idx = AccessLevelModifierSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = AccessLevelModifierSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func useModifier(_ node: TokenSyntax) {
    let idx = AccessLevelModifierSyntax.Cursor.modifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = AccessLevelModifierSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.identifier(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .accessLevelModifier,
      layout: layout, presence: .present))
  }
}

extension AccessLevelModifierSyntax {
  /// Creates a `AccessLevelModifierSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AccessLevelModifierSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AccessLevelModifierSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout AccessLevelModifierSyntaxBuilder) -> Void) {
    var builder = AccessLevelModifierSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct AccessPathComponentSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useName(_ node: TokenSyntax) {
    let idx = AccessPathComponentSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingDot(_ node: TokenSyntax) {
    let idx = AccessPathComponentSyntax.Cursor.trailingDot.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.identifier(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .accessPathComponent,
      layout: layout, presence: .present))
  }
}

extension AccessPathComponentSyntax {
  /// Creates a `AccessPathComponentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AccessPathComponentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AccessPathComponentSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout AccessPathComponentSyntaxBuilder) -> Void) {
    var builder = AccessPathComponentSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ImportDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = ImportDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = ImportDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useImportTok(_ node: TokenSyntax) {
    let idx = ImportDeclSyntax.Cursor.importTok.rawValue
    layout[idx] = node.raw
  }

  public mutating func useImportKind(_ node: TokenSyntax) {
    let idx = ImportDeclSyntax.Cursor.importKind.rawValue
    layout[idx] = node.raw
  }

  public mutating func addPathComponent(_ elt: AccessPathComponentSyntax) {
    let idx = ImportDeclSyntax.Cursor.path.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.accessPath,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.importKeyword)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missing(SyntaxKind.accessPath)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .importDecl,
      layout: layout, presence: .present))
  }
}

extension ImportDeclSyntax {
  /// Creates a `ImportDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ImportDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ImportDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ImportDeclSyntaxBuilder) -> Void) {
    var builder = ImportDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct AccessorParameterSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = AccessorParameterSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func useName(_ node: TokenSyntax) {
    let idx = AccessorParameterSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = AccessorParameterSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.leftParen)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.identifier(""))
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.rightParen)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .accessorParameter,
      layout: layout, presence: .present))
  }
}

extension AccessorParameterSyntax {
  /// Creates a `AccessorParameterSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AccessorParameterSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AccessorParameterSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout AccessorParameterSyntaxBuilder) -> Void) {
    var builder = AccessorParameterSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct AccessorDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = AccessorDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useModifier(_ node: DeclModifierSyntax) {
    let idx = AccessorDeclSyntax.Cursor.modifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useAccessorKind(_ node: TokenSyntax) {
    let idx = AccessorDeclSyntax.Cursor.accessorKind.rawValue
    layout[idx] = node.raw
  }

  public mutating func useParameter(_ node: AccessorParameterSyntax) {
    let idx = AccessorDeclSyntax.Cursor.parameter.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = AccessorDeclSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.unknown(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .accessorDecl,
      layout: layout, presence: .present))
  }
}

extension AccessorDeclSyntax {
  /// Creates a `AccessorDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AccessorDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AccessorDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout AccessorDeclSyntaxBuilder) -> Void) {
    var builder = AccessorDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct AccessorBlockSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useLeftBrace(_ node: TokenSyntax) {
    let idx = AccessorBlockSyntax.Cursor.leftBrace.rawValue
    layout[idx] = node.raw
  }

  public mutating func addAccessor(_ elt: AccessorDeclSyntax) {
    let idx = AccessorBlockSyntax.Cursor.accessors.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.accessorList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightBrace(_ node: TokenSyntax) {
    let idx = AccessorBlockSyntax.Cursor.rightBrace.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.leftBrace)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.accessorList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.rightBrace)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .accessorBlock,
      layout: layout, presence: .present))
  }
}

extension AccessorBlockSyntax {
  /// Creates a `AccessorBlockSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AccessorBlockSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AccessorBlockSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout AccessorBlockSyntaxBuilder) -> Void) {
    var builder = AccessorBlockSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct PatternBindingSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func usePattern(_ node: PatternSyntax) {
    let idx = PatternBindingSyntax.Cursor.pattern.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTypeAnnotation(_ node: TypeAnnotationSyntax) {
    let idx = PatternBindingSyntax.Cursor.typeAnnotation.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInitializer(_ node: InitializerClauseSyntax) {
    let idx = PatternBindingSyntax.Cursor.initializer.rawValue
    layout[idx] = node.raw
  }

  public mutating func useAccessor(_ node: Syntax) {
    let idx = PatternBindingSyntax.Cursor.accessor.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = PatternBindingSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.pattern)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .patternBinding,
      layout: layout, presence: .present))
  }
}

extension PatternBindingSyntax {
  /// Creates a `PatternBindingSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PatternBindingSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PatternBindingSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout PatternBindingSyntaxBuilder) -> Void) {
    var builder = PatternBindingSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct VariableDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = VariableDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = VariableDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useLetOrVarKeyword(_ node: TokenSyntax) {
    let idx = VariableDeclSyntax.Cursor.letOrVarKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addBinding(_ elt: PatternBindingSyntax) {
    let idx = VariableDeclSyntax.Cursor.bindings.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.patternBindingList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.letKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(SyntaxKind.patternBindingList)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .variableDecl,
      layout: layout, presence: .present))
  }
}

extension VariableDeclSyntax {
  /// Creates a `VariableDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `VariableDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `VariableDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout VariableDeclSyntaxBuilder) -> Void) {
    var builder = VariableDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct EnumCaseElementSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = EnumCaseElementSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useAssociatedValue(_ node: ParameterClauseSyntax) {
    let idx = EnumCaseElementSyntax.Cursor.associatedValue.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRawValue(_ node: InitializerClauseSyntax) {
    let idx = EnumCaseElementSyntax.Cursor.rawValue.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = EnumCaseElementSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.identifier(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .enumCaseElement,
      layout: layout, presence: .present))
  }
}

extension EnumCaseElementSyntax {
  /// Creates a `EnumCaseElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `EnumCaseElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `EnumCaseElementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout EnumCaseElementSyntaxBuilder) -> Void) {
    var builder = EnumCaseElementSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct EnumCaseDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = EnumCaseDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = EnumCaseDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useCaseKeyword(_ node: TokenSyntax) {
    let idx = EnumCaseDeclSyntax.Cursor.caseKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addElement(_ elt: EnumCaseElementSyntax) {
    let idx = EnumCaseDeclSyntax.Cursor.elements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.enumCaseElementList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.caseKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(SyntaxKind.enumCaseElementList)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .enumCaseDecl,
      layout: layout, presence: .present))
  }
}

extension EnumCaseDeclSyntax {
  /// Creates a `EnumCaseDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `EnumCaseDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `EnumCaseDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout EnumCaseDeclSyntaxBuilder) -> Void) {
    var builder = EnumCaseDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct EnumDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 8)

  internal init() {}

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = EnumDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = EnumDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useEnumKeyword(_ node: TokenSyntax) {
    let idx = EnumDeclSyntax.Cursor.enumKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = EnumDeclSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericParameters(_ node: GenericParameterClauseSyntax) {
    let idx = EnumDeclSyntax.Cursor.genericParameters.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInheritanceClause(_ node: TypeInheritanceClauseSyntax) {
    let idx = EnumDeclSyntax.Cursor.inheritanceClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericWhereClause(_ node: GenericWhereClauseSyntax) {
    let idx = EnumDeclSyntax.Cursor.genericWhereClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useMembers(_ node: MemberDeclBlockSyntax) {
    let idx = EnumDeclSyntax.Cursor.members.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.enumKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.identifier(""))
    }
    if (layout[7] == nil) {
      layout[7] = RawSyntax.missing(SyntaxKind.memberDeclBlock)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .enumDecl,
      layout: layout, presence: .present))
  }
}

extension EnumDeclSyntax {
  /// Creates a `EnumDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `EnumDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `EnumDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout EnumDeclSyntaxBuilder) -> Void) {
    var builder = EnumDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct OperatorDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = OperatorDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = OperatorDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useOperatorKeyword(_ node: TokenSyntax) {
    let idx = OperatorDeclSyntax.Cursor.operatorKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = OperatorDeclSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useOperatorPrecedenceAndTypes(_ node: OperatorPrecedenceAndTypesSyntax) {
    let idx = OperatorDeclSyntax.Cursor.operatorPrecedenceAndTypes.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.operatorKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.unspacedBinaryOperator(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .operatorDecl,
      layout: layout, presence: .present))
  }
}

extension OperatorDeclSyntax {
  /// Creates a `OperatorDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `OperatorDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `OperatorDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout OperatorDeclSyntaxBuilder) -> Void) {
    var builder = OperatorDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct OperatorPrecedenceAndTypesSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = OperatorPrecedenceAndTypesSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func addPrecedenceGroupAndDesignatedType(_ elt: TokenSyntax) {
    let idx = OperatorPrecedenceAndTypesSyntax.Cursor.precedenceGroupAndDesignatedTypes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.identifierList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.colon)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.identifierList)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .operatorPrecedenceAndTypes,
      layout: layout, presence: .present))
  }
}

extension OperatorPrecedenceAndTypesSyntax {
  /// Creates a `OperatorPrecedenceAndTypesSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `OperatorPrecedenceAndTypesSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `OperatorPrecedenceAndTypesSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout OperatorPrecedenceAndTypesSyntaxBuilder) -> Void) {
    var builder = OperatorPrecedenceAndTypesSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct PrecedenceGroupDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 7)

  internal init() {}

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = PrecedenceGroupDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = PrecedenceGroupDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func usePrecedencegroupKeyword(_ node: TokenSyntax) {
    let idx = PrecedenceGroupDeclSyntax.Cursor.precedencegroupKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = PrecedenceGroupDeclSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftBrace(_ node: TokenSyntax) {
    let idx = PrecedenceGroupDeclSyntax.Cursor.leftBrace.rawValue
    layout[idx] = node.raw
  }

  public mutating func addGroupAttribute(_ elt: Syntax) {
    let idx = PrecedenceGroupDeclSyntax.Cursor.groupAttributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.precedenceGroupAttributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightBrace(_ node: TokenSyntax) {
    let idx = PrecedenceGroupDeclSyntax.Cursor.rightBrace.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.precedencegroupKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.identifier(""))
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missingToken(TokenKind.leftBrace)
    }
    if (layout[5] == nil) {
      layout[5] = RawSyntax.missing(SyntaxKind.precedenceGroupAttributeList)
    }
    if (layout[6] == nil) {
      layout[6] = RawSyntax.missingToken(TokenKind.rightBrace)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .precedenceGroupDecl,
      layout: layout, presence: .present))
  }
}

extension PrecedenceGroupDeclSyntax {
  /// Creates a `PrecedenceGroupDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PrecedenceGroupDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PrecedenceGroupDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout PrecedenceGroupDeclSyntaxBuilder) -> Void) {
    var builder = PrecedenceGroupDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct PrecedenceGroupRelationSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useHigherThanOrLowerThan(_ node: TokenSyntax) {
    let idx = PrecedenceGroupRelationSyntax.Cursor.higherThanOrLowerThan.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = PrecedenceGroupRelationSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func addOtherName(_ elt: PrecedenceGroupNameElementSyntax) {
    let idx = PrecedenceGroupRelationSyntax.Cursor.otherNames.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.precedenceGroupNameList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.identifier(""))
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.colon)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.precedenceGroupNameList)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .precedenceGroupRelation,
      layout: layout, presence: .present))
  }
}

extension PrecedenceGroupRelationSyntax {
  /// Creates a `PrecedenceGroupRelationSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PrecedenceGroupRelationSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PrecedenceGroupRelationSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout PrecedenceGroupRelationSyntaxBuilder) -> Void) {
    var builder = PrecedenceGroupRelationSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct PrecedenceGroupNameElementSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useName(_ node: TokenSyntax) {
    let idx = PrecedenceGroupNameElementSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = PrecedenceGroupNameElementSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.identifier(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .precedenceGroupNameElement,
      layout: layout, presence: .present))
  }
}

extension PrecedenceGroupNameElementSyntax {
  /// Creates a `PrecedenceGroupNameElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PrecedenceGroupNameElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PrecedenceGroupNameElementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout PrecedenceGroupNameElementSyntaxBuilder) -> Void) {
    var builder = PrecedenceGroupNameElementSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct PrecedenceGroupAssignmentSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useAssignmentKeyword(_ node: TokenSyntax) {
    let idx = PrecedenceGroupAssignmentSyntax.Cursor.assignmentKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = PrecedenceGroupAssignmentSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useFlag(_ node: TokenSyntax) {
    let idx = PrecedenceGroupAssignmentSyntax.Cursor.flag.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.identifier(""))
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.colon)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.trueKeyword)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .precedenceGroupAssignment,
      layout: layout, presence: .present))
  }
}

extension PrecedenceGroupAssignmentSyntax {
  /// Creates a `PrecedenceGroupAssignmentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PrecedenceGroupAssignmentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PrecedenceGroupAssignmentSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout PrecedenceGroupAssignmentSyntaxBuilder) -> Void) {
    var builder = PrecedenceGroupAssignmentSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct PrecedenceGroupAssociativitySyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useAssociativityKeyword(_ node: TokenSyntax) {
    let idx = PrecedenceGroupAssociativitySyntax.Cursor.associativityKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = PrecedenceGroupAssociativitySyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useValue(_ node: TokenSyntax) {
    let idx = PrecedenceGroupAssociativitySyntax.Cursor.value.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.identifier(""))
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.colon)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.identifier(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .precedenceGroupAssociativity,
      layout: layout, presence: .present))
  }
}

extension PrecedenceGroupAssociativitySyntax {
  /// Creates a `PrecedenceGroupAssociativitySyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PrecedenceGroupAssociativitySyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PrecedenceGroupAssociativitySyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout PrecedenceGroupAssociativitySyntaxBuilder) -> Void) {
    var builder = PrecedenceGroupAssociativitySyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct CustomAttributeSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func useAtSignToken(_ node: TokenSyntax) {
    let idx = CustomAttributeSyntax.Cursor.atSignToken.rawValue
    layout[idx] = node.raw
  }

  public mutating func useAttributeName(_ node: TypeSyntax) {
    let idx = CustomAttributeSyntax.Cursor.attributeName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = CustomAttributeSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addArgument(_ elt: FunctionCallArgumentSyntax) {
    let idx = CustomAttributeSyntax.Cursor.argumentList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.functionCallArgumentList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = CustomAttributeSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.atSign)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.type)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .customAttribute,
      layout: layout, presence: .present))
  }
}

extension CustomAttributeSyntax {
  /// Creates a `CustomAttributeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `CustomAttributeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `CustomAttributeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout CustomAttributeSyntaxBuilder) -> Void) {
    var builder = CustomAttributeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct AttributeSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 6)

  internal init() {}

  public mutating func useAtSignToken(_ node: TokenSyntax) {
    let idx = AttributeSyntax.Cursor.atSignToken.rawValue
    layout[idx] = node.raw
  }

  public mutating func useAttributeName(_ node: TokenSyntax) {
    let idx = AttributeSyntax.Cursor.attributeName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = AttributeSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func useArgument(_ node: Syntax) {
    let idx = AttributeSyntax.Cursor.argument.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = AttributeSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addToken(_ elt: TokenSyntax) {
    let idx = AttributeSyntax.Cursor.tokenList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.tokenList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.atSign)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.unknown(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .attribute,
      layout: layout, presence: .present))
  }
}

extension AttributeSyntax {
  /// Creates a `AttributeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AttributeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AttributeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout AttributeSyntaxBuilder) -> Void) {
    var builder = AttributeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct LabeledSpecializeEntrySyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useLabel(_ node: TokenSyntax) {
    let idx = LabeledSpecializeEntrySyntax.Cursor.label.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = LabeledSpecializeEntrySyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useValue(_ node: TokenSyntax) {
    let idx = LabeledSpecializeEntrySyntax.Cursor.value.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = LabeledSpecializeEntrySyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.identifier(""))
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.colon)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.unknown(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .labeledSpecializeEntry,
      layout: layout, presence: .present))
  }
}

extension LabeledSpecializeEntrySyntax {
  /// Creates a `LabeledSpecializeEntrySyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `LabeledSpecializeEntrySyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `LabeledSpecializeEntrySyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout LabeledSpecializeEntrySyntaxBuilder) -> Void) {
    var builder = LabeledSpecializeEntrySyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct NamedAttributeStringArgumentSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useNameTok(_ node: TokenSyntax) {
    let idx = NamedAttributeStringArgumentSyntax.Cursor.nameTok.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = NamedAttributeStringArgumentSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useStringOrDeclname(_ node: Syntax) {
    let idx = NamedAttributeStringArgumentSyntax.Cursor.stringOrDeclname.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.unknown(""))
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.colon)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.unknown)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .namedAttributeStringArgument,
      layout: layout, presence: .present))
  }
}

extension NamedAttributeStringArgumentSyntax {
  /// Creates a `NamedAttributeStringArgumentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `NamedAttributeStringArgumentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `NamedAttributeStringArgumentSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout NamedAttributeStringArgumentSyntaxBuilder) -> Void) {
    var builder = NamedAttributeStringArgumentSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct DeclNameSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useDeclBaseName(_ node: Syntax) {
    let idx = DeclNameSyntax.Cursor.declBaseName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDeclNameArguments(_ node: DeclNameArgumentsSyntax) {
    let idx = DeclNameSyntax.Cursor.declNameArguments.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.unknown)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .declName,
      layout: layout, presence: .present))
  }
}

extension DeclNameSyntax {
  /// Creates a `DeclNameSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DeclNameSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DeclNameSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout DeclNameSyntaxBuilder) -> Void) {
    var builder = DeclNameSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ImplementsAttributeArgumentsSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useType(_ node: SimpleTypeIdentifierSyntax) {
    let idx = ImplementsAttributeArgumentsSyntax.Cursor.type.rawValue
    layout[idx] = node.raw
  }

  public mutating func useComma(_ node: TokenSyntax) {
    let idx = ImplementsAttributeArgumentsSyntax.Cursor.comma.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDeclBaseName(_ node: Syntax) {
    let idx = ImplementsAttributeArgumentsSyntax.Cursor.declBaseName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDeclNameArguments(_ node: DeclNameArgumentsSyntax) {
    let idx = ImplementsAttributeArgumentsSyntax.Cursor.declNameArguments.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.simpleTypeIdentifier)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.comma)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.unknown)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .implementsAttributeArguments,
      layout: layout, presence: .present))
  }
}

extension ImplementsAttributeArgumentsSyntax {
  /// Creates a `ImplementsAttributeArgumentsSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ImplementsAttributeArgumentsSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ImplementsAttributeArgumentsSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ImplementsAttributeArgumentsSyntaxBuilder) -> Void) {
    var builder = ImplementsAttributeArgumentsSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ObjCSelectorPieceSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useName(_ node: TokenSyntax) {
    let idx = ObjCSelectorPieceSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = ObjCSelectorPieceSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {

    return .forRoot(RawSyntax.createAndCalcLength(kind: .objCSelectorPiece,
      layout: layout, presence: .present))
  }
}

extension ObjCSelectorPieceSyntax {
  /// Creates a `ObjCSelectorPieceSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ObjCSelectorPieceSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ObjCSelectorPieceSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ObjCSelectorPieceSyntaxBuilder) -> Void) {
    var builder = ObjCSelectorPieceSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ContinueStmtSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useContinueKeyword(_ node: TokenSyntax) {
    let idx = ContinueStmtSyntax.Cursor.continueKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLabel(_ node: TokenSyntax) {
    let idx = ContinueStmtSyntax.Cursor.label.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.continueKeyword)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .continueStmt,
      layout: layout, presence: .present))
  }
}

extension ContinueStmtSyntax {
  /// Creates a `ContinueStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ContinueStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ContinueStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ContinueStmtSyntaxBuilder) -> Void) {
    var builder = ContinueStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct WhileStmtSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func useLabelName(_ node: TokenSyntax) {
    let idx = WhileStmtSyntax.Cursor.labelName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLabelColon(_ node: TokenSyntax) {
    let idx = WhileStmtSyntax.Cursor.labelColon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useWhileKeyword(_ node: TokenSyntax) {
    let idx = WhileStmtSyntax.Cursor.whileKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addCondition(_ elt: ConditionElementSyntax) {
    let idx = WhileStmtSyntax.Cursor.conditions.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.conditionElementList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = WhileStmtSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.whileKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(SyntaxKind.conditionElementList)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missing(SyntaxKind.codeBlock)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .whileStmt,
      layout: layout, presence: .present))
  }
}

extension WhileStmtSyntax {
  /// Creates a `WhileStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `WhileStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `WhileStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout WhileStmtSyntaxBuilder) -> Void) {
    var builder = WhileStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct DeferStmtSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useDeferKeyword(_ node: TokenSyntax) {
    let idx = DeferStmtSyntax.Cursor.deferKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = DeferStmtSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.deferKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.codeBlock)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .deferStmt,
      layout: layout, presence: .present))
  }
}

extension DeferStmtSyntax {
  /// Creates a `DeferStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DeferStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DeferStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout DeferStmtSyntaxBuilder) -> Void) {
    var builder = DeferStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ExpressionStmtSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = ExpressionStmtSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.expr)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .expressionStmt,
      layout: layout, presence: .present))
  }
}

extension ExpressionStmtSyntax {
  /// Creates a `ExpressionStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ExpressionStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ExpressionStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ExpressionStmtSyntaxBuilder) -> Void) {
    var builder = ExpressionStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct RepeatWhileStmtSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 6)

  internal init() {}

  public mutating func useLabelName(_ node: TokenSyntax) {
    let idx = RepeatWhileStmtSyntax.Cursor.labelName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLabelColon(_ node: TokenSyntax) {
    let idx = RepeatWhileStmtSyntax.Cursor.labelColon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRepeatKeyword(_ node: TokenSyntax) {
    let idx = RepeatWhileStmtSyntax.Cursor.repeatKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = RepeatWhileStmtSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  public mutating func useWhileKeyword(_ node: TokenSyntax) {
    let idx = RepeatWhileStmtSyntax.Cursor.whileKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useCondition(_ node: ExprSyntax) {
    let idx = RepeatWhileStmtSyntax.Cursor.condition.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.repeatKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(SyntaxKind.codeBlock)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missingToken(TokenKind.whileKeyword)
    }
    if (layout[5] == nil) {
      layout[5] = RawSyntax.missing(SyntaxKind.expr)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .repeatWhileStmt,
      layout: layout, presence: .present))
  }
}

extension RepeatWhileStmtSyntax {
  /// Creates a `RepeatWhileStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `RepeatWhileStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `RepeatWhileStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout RepeatWhileStmtSyntaxBuilder) -> Void) {
    var builder = RepeatWhileStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct GuardStmtSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useGuardKeyword(_ node: TokenSyntax) {
    let idx = GuardStmtSyntax.Cursor.guardKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addCondition(_ elt: ConditionElementSyntax) {
    let idx = GuardStmtSyntax.Cursor.conditions.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.conditionElementList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useElseKeyword(_ node: TokenSyntax) {
    let idx = GuardStmtSyntax.Cursor.elseKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = GuardStmtSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.guardKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.conditionElementList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.elseKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(SyntaxKind.codeBlock)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .guardStmt,
      layout: layout, presence: .present))
  }
}

extension GuardStmtSyntax {
  /// Creates a `GuardStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `GuardStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `GuardStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout GuardStmtSyntaxBuilder) -> Void) {
    var builder = GuardStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct WhereClauseSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useWhereKeyword(_ node: TokenSyntax) {
    let idx = WhereClauseSyntax.Cursor.whereKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGuardResult(_ node: ExprSyntax) {
    let idx = WhereClauseSyntax.Cursor.guardResult.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.whereKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.expr)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .whereClause,
      layout: layout, presence: .present))
  }
}

extension WhereClauseSyntax {
  /// Creates a `WhereClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `WhereClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `WhereClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout WhereClauseSyntaxBuilder) -> Void) {
    var builder = WhereClauseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ForInStmtSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 10)

  internal init() {}

  public mutating func useLabelName(_ node: TokenSyntax) {
    let idx = ForInStmtSyntax.Cursor.labelName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLabelColon(_ node: TokenSyntax) {
    let idx = ForInStmtSyntax.Cursor.labelColon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useForKeyword(_ node: TokenSyntax) {
    let idx = ForInStmtSyntax.Cursor.forKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useCaseKeyword(_ node: TokenSyntax) {
    let idx = ForInStmtSyntax.Cursor.caseKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func usePattern(_ node: PatternSyntax) {
    let idx = ForInStmtSyntax.Cursor.pattern.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTypeAnnotation(_ node: TypeAnnotationSyntax) {
    let idx = ForInStmtSyntax.Cursor.typeAnnotation.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInKeyword(_ node: TokenSyntax) {
    let idx = ForInStmtSyntax.Cursor.inKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSequenceExpr(_ node: ExprSyntax) {
    let idx = ForInStmtSyntax.Cursor.sequenceExpr.rawValue
    layout[idx] = node.raw
  }

  public mutating func useWhereClause(_ node: WhereClauseSyntax) {
    let idx = ForInStmtSyntax.Cursor.whereClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = ForInStmtSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.forKeyword)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missing(SyntaxKind.pattern)
    }
    if (layout[6] == nil) {
      layout[6] = RawSyntax.missingToken(TokenKind.inKeyword)
    }
    if (layout[7] == nil) {
      layout[7] = RawSyntax.missing(SyntaxKind.expr)
    }
    if (layout[9] == nil) {
      layout[9] = RawSyntax.missing(SyntaxKind.codeBlock)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .forInStmt,
      layout: layout, presence: .present))
  }
}

extension ForInStmtSyntax {
  /// Creates a `ForInStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ForInStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ForInStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ForInStmtSyntaxBuilder) -> Void) {
    var builder = ForInStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct SwitchStmtSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 7)

  internal init() {}

  public mutating func useLabelName(_ node: TokenSyntax) {
    let idx = SwitchStmtSyntax.Cursor.labelName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLabelColon(_ node: TokenSyntax) {
    let idx = SwitchStmtSyntax.Cursor.labelColon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSwitchKeyword(_ node: TokenSyntax) {
    let idx = SwitchStmtSyntax.Cursor.switchKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = SwitchStmtSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftBrace(_ node: TokenSyntax) {
    let idx = SwitchStmtSyntax.Cursor.leftBrace.rawValue
    layout[idx] = node.raw
  }

  public mutating func addCase(_ elt: Syntax) {
    let idx = SwitchStmtSyntax.Cursor.cases.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.switchCaseList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightBrace(_ node: TokenSyntax) {
    let idx = SwitchStmtSyntax.Cursor.rightBrace.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.switchKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(SyntaxKind.expr)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missingToken(TokenKind.leftBrace)
    }
    if (layout[5] == nil) {
      layout[5] = RawSyntax.missing(SyntaxKind.switchCaseList)
    }
    if (layout[6] == nil) {
      layout[6] = RawSyntax.missingToken(TokenKind.rightBrace)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .switchStmt,
      layout: layout, presence: .present))
  }
}

extension SwitchStmtSyntax {
  /// Creates a `SwitchStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SwitchStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SwitchStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout SwitchStmtSyntaxBuilder) -> Void) {
    var builder = SwitchStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct DoStmtSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func useLabelName(_ node: TokenSyntax) {
    let idx = DoStmtSyntax.Cursor.labelName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLabelColon(_ node: TokenSyntax) {
    let idx = DoStmtSyntax.Cursor.labelColon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDoKeyword(_ node: TokenSyntax) {
    let idx = DoStmtSyntax.Cursor.doKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = DoStmtSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  public mutating func addCatchClause(_ elt: CatchClauseSyntax) {
    let idx = DoStmtSyntax.Cursor.catchClauses.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.catchClauseList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.doKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(SyntaxKind.codeBlock)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .doStmt,
      layout: layout, presence: .present))
  }
}

extension DoStmtSyntax {
  /// Creates a `DoStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DoStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DoStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout DoStmtSyntaxBuilder) -> Void) {
    var builder = DoStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ReturnStmtSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useReturnKeyword(_ node: TokenSyntax) {
    let idx = ReturnStmtSyntax.Cursor.returnKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = ReturnStmtSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.returnKeyword)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .returnStmt,
      layout: layout, presence: .present))
  }
}

extension ReturnStmtSyntax {
  /// Creates a `ReturnStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ReturnStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ReturnStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ReturnStmtSyntaxBuilder) -> Void) {
    var builder = ReturnStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct YieldStmtSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useYieldKeyword(_ node: TokenSyntax) {
    let idx = YieldStmtSyntax.Cursor.yieldKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useYields(_ node: Syntax) {
    let idx = YieldStmtSyntax.Cursor.yields.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.yield)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.unknown)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .yieldStmt,
      layout: layout, presence: .present))
  }
}

extension YieldStmtSyntax {
  /// Creates a `YieldStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `YieldStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `YieldStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout YieldStmtSyntaxBuilder) -> Void) {
    var builder = YieldStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct YieldListSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = YieldListSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addElement(_ elt: ExprSyntax) {
    let idx = YieldListSyntax.Cursor.elementList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.exprList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = YieldListSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = YieldListSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.leftParen)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.exprList)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.rightParen)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .yieldList,
      layout: layout, presence: .present))
  }
}

extension YieldListSyntax {
  /// Creates a `YieldListSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `YieldListSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `YieldListSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout YieldListSyntaxBuilder) -> Void) {
    var builder = YieldListSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct FallthroughStmtSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func useFallthroughKeyword(_ node: TokenSyntax) {
    let idx = FallthroughStmtSyntax.Cursor.fallthroughKeyword.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.fallthroughKeyword)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .fallthroughStmt,
      layout: layout, presence: .present))
  }
}

extension FallthroughStmtSyntax {
  /// Creates a `FallthroughStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FallthroughStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FallthroughStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout FallthroughStmtSyntaxBuilder) -> Void) {
    var builder = FallthroughStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct BreakStmtSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useBreakKeyword(_ node: TokenSyntax) {
    let idx = BreakStmtSyntax.Cursor.breakKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLabel(_ node: TokenSyntax) {
    let idx = BreakStmtSyntax.Cursor.label.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.breakKeyword)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .breakStmt,
      layout: layout, presence: .present))
  }
}

extension BreakStmtSyntax {
  /// Creates a `BreakStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `BreakStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `BreakStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout BreakStmtSyntaxBuilder) -> Void) {
    var builder = BreakStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ConditionElementSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useCondition(_ node: Syntax) {
    let idx = ConditionElementSyntax.Cursor.condition.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = ConditionElementSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.unknown)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .conditionElement,
      layout: layout, presence: .present))
  }
}

extension ConditionElementSyntax {
  /// Creates a `ConditionElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ConditionElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ConditionElementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ConditionElementSyntaxBuilder) -> Void) {
    var builder = ConditionElementSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct AvailabilityConditionSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func usePoundAvailableKeyword(_ node: TokenSyntax) {
    let idx = AvailabilityConditionSyntax.Cursor.poundAvailableKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = AvailabilityConditionSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addAvailabilityArgument(_ elt: AvailabilityArgumentSyntax) {
    let idx = AvailabilityConditionSyntax.Cursor.availabilitySpec.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.availabilitySpecList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = AvailabilityConditionSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.poundAvailableKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.leftParen)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.availabilitySpecList)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(TokenKind.rightParen)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .availabilityCondition,
      layout: layout, presence: .present))
  }
}

extension AvailabilityConditionSyntax {
  /// Creates a `AvailabilityConditionSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AvailabilityConditionSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AvailabilityConditionSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout AvailabilityConditionSyntaxBuilder) -> Void) {
    var builder = AvailabilityConditionSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct MatchingPatternConditionSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useCaseKeyword(_ node: TokenSyntax) {
    let idx = MatchingPatternConditionSyntax.Cursor.caseKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func usePattern(_ node: PatternSyntax) {
    let idx = MatchingPatternConditionSyntax.Cursor.pattern.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTypeAnnotation(_ node: TypeAnnotationSyntax) {
    let idx = MatchingPatternConditionSyntax.Cursor.typeAnnotation.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInitializer(_ node: InitializerClauseSyntax) {
    let idx = MatchingPatternConditionSyntax.Cursor.initializer.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.caseKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.pattern)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(SyntaxKind.initializerClause)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .matchingPatternCondition,
      layout: layout, presence: .present))
  }
}

extension MatchingPatternConditionSyntax {
  /// Creates a `MatchingPatternConditionSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `MatchingPatternConditionSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `MatchingPatternConditionSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout MatchingPatternConditionSyntaxBuilder) -> Void) {
    var builder = MatchingPatternConditionSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct OptionalBindingConditionSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useLetOrVarKeyword(_ node: TokenSyntax) {
    let idx = OptionalBindingConditionSyntax.Cursor.letOrVarKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func usePattern(_ node: PatternSyntax) {
    let idx = OptionalBindingConditionSyntax.Cursor.pattern.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTypeAnnotation(_ node: TypeAnnotationSyntax) {
    let idx = OptionalBindingConditionSyntax.Cursor.typeAnnotation.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInitializer(_ node: InitializerClauseSyntax) {
    let idx = OptionalBindingConditionSyntax.Cursor.initializer.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.letKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.pattern)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(SyntaxKind.initializerClause)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .optionalBindingCondition,
      layout: layout, presence: .present))
  }
}

extension OptionalBindingConditionSyntax {
  /// Creates a `OptionalBindingConditionSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `OptionalBindingConditionSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `OptionalBindingConditionSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout OptionalBindingConditionSyntaxBuilder) -> Void) {
    var builder = OptionalBindingConditionSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct DeclarationStmtSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func useDeclaration(_ node: DeclSyntax) {
    let idx = DeclarationStmtSyntax.Cursor.declaration.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.decl)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .declarationStmt,
      layout: layout, presence: .present))
  }
}

extension DeclarationStmtSyntax {
  /// Creates a `DeclarationStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DeclarationStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DeclarationStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout DeclarationStmtSyntaxBuilder) -> Void) {
    var builder = DeclarationStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ThrowStmtSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useThrowKeyword(_ node: TokenSyntax) {
    let idx = ThrowStmtSyntax.Cursor.throwKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = ThrowStmtSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.throwKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.expr)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .throwStmt,
      layout: layout, presence: .present))
  }
}

extension ThrowStmtSyntax {
  /// Creates a `ThrowStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ThrowStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ThrowStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ThrowStmtSyntaxBuilder) -> Void) {
    var builder = ThrowStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct IfStmtSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 7)

  internal init() {}

  public mutating func useLabelName(_ node: TokenSyntax) {
    let idx = IfStmtSyntax.Cursor.labelName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLabelColon(_ node: TokenSyntax) {
    let idx = IfStmtSyntax.Cursor.labelColon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useIfKeyword(_ node: TokenSyntax) {
    let idx = IfStmtSyntax.Cursor.ifKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addCondition(_ elt: ConditionElementSyntax) {
    let idx = IfStmtSyntax.Cursor.conditions.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.conditionElementList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = IfStmtSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  public mutating func useElseKeyword(_ node: TokenSyntax) {
    let idx = IfStmtSyntax.Cursor.elseKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useElseBody(_ node: Syntax) {
    let idx = IfStmtSyntax.Cursor.elseBody.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.ifKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(SyntaxKind.conditionElementList)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missing(SyntaxKind.codeBlock)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .ifStmt,
      layout: layout, presence: .present))
  }
}

extension IfStmtSyntax {
  /// Creates a `IfStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IfStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IfStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout IfStmtSyntaxBuilder) -> Void) {
    var builder = IfStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ElseIfContinuationSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func useIfStatement(_ node: IfStmtSyntax) {
    let idx = ElseIfContinuationSyntax.Cursor.ifStatement.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.ifStmt)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .elseIfContinuation,
      layout: layout, presence: .present))
  }
}

extension ElseIfContinuationSyntax {
  /// Creates a `ElseIfContinuationSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ElseIfContinuationSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ElseIfContinuationSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ElseIfContinuationSyntaxBuilder) -> Void) {
    var builder = ElseIfContinuationSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ElseBlockSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useElseKeyword(_ node: TokenSyntax) {
    let idx = ElseBlockSyntax.Cursor.elseKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = ElseBlockSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.elseKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.codeBlock)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .elseBlock,
      layout: layout, presence: .present))
  }
}

extension ElseBlockSyntax {
  /// Creates a `ElseBlockSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ElseBlockSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ElseBlockSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ElseBlockSyntaxBuilder) -> Void) {
    var builder = ElseBlockSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct SwitchCaseSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useUnknownAttr(_ node: AttributeSyntax) {
    let idx = SwitchCaseSyntax.Cursor.unknownAttr.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLabel(_ node: Syntax) {
    let idx = SwitchCaseSyntax.Cursor.label.rawValue
    layout[idx] = node.raw
  }

  public mutating func addStatement(_ elt: CodeBlockItemSyntax) {
    let idx = SwitchCaseSyntax.Cursor.statements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.codeBlockItemList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.unknown)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.codeBlockItemList)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .switchCase,
      layout: layout, presence: .present))
  }
}

extension SwitchCaseSyntax {
  /// Creates a `SwitchCaseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SwitchCaseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SwitchCaseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout SwitchCaseSyntaxBuilder) -> Void) {
    var builder = SwitchCaseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct SwitchDefaultLabelSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useDefaultKeyword(_ node: TokenSyntax) {
    let idx = SwitchDefaultLabelSyntax.Cursor.defaultKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = SwitchDefaultLabelSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.defaultKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.colon)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .switchDefaultLabel,
      layout: layout, presence: .present))
  }
}

extension SwitchDefaultLabelSyntax {
  /// Creates a `SwitchDefaultLabelSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SwitchDefaultLabelSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SwitchDefaultLabelSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout SwitchDefaultLabelSyntaxBuilder) -> Void) {
    var builder = SwitchDefaultLabelSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct CaseItemSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func usePattern(_ node: PatternSyntax) {
    let idx = CaseItemSyntax.Cursor.pattern.rawValue
    layout[idx] = node.raw
  }

  public mutating func useWhereClause(_ node: WhereClauseSyntax) {
    let idx = CaseItemSyntax.Cursor.whereClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = CaseItemSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.pattern)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .caseItem,
      layout: layout, presence: .present))
  }
}

extension CaseItemSyntax {
  /// Creates a `CaseItemSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `CaseItemSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `CaseItemSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout CaseItemSyntaxBuilder) -> Void) {
    var builder = CaseItemSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct SwitchCaseLabelSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useCaseKeyword(_ node: TokenSyntax) {
    let idx = SwitchCaseLabelSyntax.Cursor.caseKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addCaseItem(_ elt: CaseItemSyntax) {
    let idx = SwitchCaseLabelSyntax.Cursor.caseItems.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.caseItemList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = SwitchCaseLabelSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.caseKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.caseItemList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.colon)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .switchCaseLabel,
      layout: layout, presence: .present))
  }
}

extension SwitchCaseLabelSyntax {
  /// Creates a `SwitchCaseLabelSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SwitchCaseLabelSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SwitchCaseLabelSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout SwitchCaseLabelSyntaxBuilder) -> Void) {
    var builder = SwitchCaseLabelSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct CatchClauseSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useCatchKeyword(_ node: TokenSyntax) {
    let idx = CatchClauseSyntax.Cursor.catchKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func usePattern(_ node: PatternSyntax) {
    let idx = CatchClauseSyntax.Cursor.pattern.rawValue
    layout[idx] = node.raw
  }

  public mutating func useWhereClause(_ node: WhereClauseSyntax) {
    let idx = CatchClauseSyntax.Cursor.whereClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = CatchClauseSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.catchKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(SyntaxKind.codeBlock)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .catchClause,
      layout: layout, presence: .present))
  }
}

extension CatchClauseSyntax {
  /// Creates a `CatchClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `CatchClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `CatchClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout CatchClauseSyntaxBuilder) -> Void) {
    var builder = CatchClauseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct PoundAssertStmtSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 6)

  internal init() {}

  public mutating func usePoundAssert(_ node: TokenSyntax) {
    let idx = PoundAssertStmtSyntax.Cursor.poundAssert.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = PoundAssertStmtSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func useCondition(_ node: ExprSyntax) {
    let idx = PoundAssertStmtSyntax.Cursor.condition.rawValue
    layout[idx] = node.raw
  }

  public mutating func useComma(_ node: TokenSyntax) {
    let idx = PoundAssertStmtSyntax.Cursor.comma.rawValue
    layout[idx] = node.raw
  }

  public mutating func useMessage(_ node: TokenSyntax) {
    let idx = PoundAssertStmtSyntax.Cursor.message.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = PoundAssertStmtSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.poundAssertKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.leftParen)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.expr)
    }
    if (layout[5] == nil) {
      layout[5] = RawSyntax.missingToken(TokenKind.rightParen)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .poundAssertStmt,
      layout: layout, presence: .present))
  }
}

extension PoundAssertStmtSyntax {
  /// Creates a `PoundAssertStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundAssertStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundAssertStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout PoundAssertStmtSyntaxBuilder) -> Void) {
    var builder = PoundAssertStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct GenericWhereClauseSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useWhereKeyword(_ node: TokenSyntax) {
    let idx = GenericWhereClauseSyntax.Cursor.whereKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addRequirement(_ elt: Syntax) {
    let idx = GenericWhereClauseSyntax.Cursor.requirementList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.genericRequirementList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.whereKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.genericRequirementList)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .genericWhereClause,
      layout: layout, presence: .present))
  }
}

extension GenericWhereClauseSyntax {
  /// Creates a `GenericWhereClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `GenericWhereClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `GenericWhereClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout GenericWhereClauseSyntaxBuilder) -> Void) {
    var builder = GenericWhereClauseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct SameTypeRequirementSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useLeftTypeIdentifier(_ node: TypeSyntax) {
    let idx = SameTypeRequirementSyntax.Cursor.leftTypeIdentifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useEqualityToken(_ node: TokenSyntax) {
    let idx = SameTypeRequirementSyntax.Cursor.equalityToken.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightTypeIdentifier(_ node: TypeSyntax) {
    let idx = SameTypeRequirementSyntax.Cursor.rightTypeIdentifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = SameTypeRequirementSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.type)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.spacedBinaryOperator(""))
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.type)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .sameTypeRequirement,
      layout: layout, presence: .present))
  }
}

extension SameTypeRequirementSyntax {
  /// Creates a `SameTypeRequirementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SameTypeRequirementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SameTypeRequirementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout SameTypeRequirementSyntaxBuilder) -> Void) {
    var builder = SameTypeRequirementSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct GenericParameterSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = GenericParameterSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useName(_ node: TokenSyntax) {
    let idx = GenericParameterSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = GenericParameterSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInheritedType(_ node: TypeSyntax) {
    let idx = GenericParameterSyntax.Cursor.inheritedType.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = GenericParameterSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.identifier(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .genericParameter,
      layout: layout, presence: .present))
  }
}

extension GenericParameterSyntax {
  /// Creates a `GenericParameterSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `GenericParameterSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `GenericParameterSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout GenericParameterSyntaxBuilder) -> Void) {
    var builder = GenericParameterSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct GenericParameterClauseSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useLeftAngleBracket(_ node: TokenSyntax) {
    let idx = GenericParameterClauseSyntax.Cursor.leftAngleBracket.rawValue
    layout[idx] = node.raw
  }

  public mutating func addGenericParameter(_ elt: GenericParameterSyntax) {
    let idx = GenericParameterClauseSyntax.Cursor.genericParameterList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.genericParameterList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightAngleBracket(_ node: TokenSyntax) {
    let idx = GenericParameterClauseSyntax.Cursor.rightAngleBracket.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.leftAngle)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.genericParameterList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.rightAngle)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .genericParameterClause,
      layout: layout, presence: .present))
  }
}

extension GenericParameterClauseSyntax {
  /// Creates a `GenericParameterClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `GenericParameterClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `GenericParameterClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout GenericParameterClauseSyntaxBuilder) -> Void) {
    var builder = GenericParameterClauseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ConformanceRequirementSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useLeftTypeIdentifier(_ node: TypeSyntax) {
    let idx = ConformanceRequirementSyntax.Cursor.leftTypeIdentifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = ConformanceRequirementSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightTypeIdentifier(_ node: TypeSyntax) {
    let idx = ConformanceRequirementSyntax.Cursor.rightTypeIdentifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = ConformanceRequirementSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.type)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.colon)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.type)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .conformanceRequirement,
      layout: layout, presence: .present))
  }
}

extension ConformanceRequirementSyntax {
  /// Creates a `ConformanceRequirementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ConformanceRequirementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ConformanceRequirementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ConformanceRequirementSyntaxBuilder) -> Void) {
    var builder = ConformanceRequirementSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct SimpleTypeIdentifierSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useName(_ node: TokenSyntax) {
    let idx = SimpleTypeIdentifierSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericArgumentClause(_ node: GenericArgumentClauseSyntax) {
    let idx = SimpleTypeIdentifierSyntax.Cursor.genericArgumentClause.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.identifier(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .simpleTypeIdentifier,
      layout: layout, presence: .present))
  }
}

extension SimpleTypeIdentifierSyntax {
  /// Creates a `SimpleTypeIdentifierSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SimpleTypeIdentifierSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SimpleTypeIdentifierSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout SimpleTypeIdentifierSyntaxBuilder) -> Void) {
    var builder = SimpleTypeIdentifierSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct MemberTypeIdentifierSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useBaseType(_ node: TypeSyntax) {
    let idx = MemberTypeIdentifierSyntax.Cursor.baseType.rawValue
    layout[idx] = node.raw
  }

  public mutating func usePeriod(_ node: TokenSyntax) {
    let idx = MemberTypeIdentifierSyntax.Cursor.period.rawValue
    layout[idx] = node.raw
  }

  public mutating func useName(_ node: TokenSyntax) {
    let idx = MemberTypeIdentifierSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericArgumentClause(_ node: GenericArgumentClauseSyntax) {
    let idx = MemberTypeIdentifierSyntax.Cursor.genericArgumentClause.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.type)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.period)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.identifier(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .memberTypeIdentifier,
      layout: layout, presence: .present))
  }
}

extension MemberTypeIdentifierSyntax {
  /// Creates a `MemberTypeIdentifierSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `MemberTypeIdentifierSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `MemberTypeIdentifierSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout MemberTypeIdentifierSyntaxBuilder) -> Void) {
    var builder = MemberTypeIdentifierSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ClassRestrictionTypeSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func useClassKeyword(_ node: TokenSyntax) {
    let idx = ClassRestrictionTypeSyntax.Cursor.classKeyword.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.classKeyword)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .classRestrictionType,
      layout: layout, presence: .present))
  }
}

extension ClassRestrictionTypeSyntax {
  /// Creates a `ClassRestrictionTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ClassRestrictionTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ClassRestrictionTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ClassRestrictionTypeSyntaxBuilder) -> Void) {
    var builder = ClassRestrictionTypeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ArrayTypeSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useLeftSquareBracket(_ node: TokenSyntax) {
    let idx = ArrayTypeSyntax.Cursor.leftSquareBracket.rawValue
    layout[idx] = node.raw
  }

  public mutating func useElementType(_ node: TypeSyntax) {
    let idx = ArrayTypeSyntax.Cursor.elementType.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightSquareBracket(_ node: TokenSyntax) {
    let idx = ArrayTypeSyntax.Cursor.rightSquareBracket.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.leftSquareBracket)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.type)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.rightSquareBracket)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .arrayType,
      layout: layout, presence: .present))
  }
}

extension ArrayTypeSyntax {
  /// Creates a `ArrayTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ArrayTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ArrayTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ArrayTypeSyntaxBuilder) -> Void) {
    var builder = ArrayTypeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct DictionaryTypeSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func useLeftSquareBracket(_ node: TokenSyntax) {
    let idx = DictionaryTypeSyntax.Cursor.leftSquareBracket.rawValue
    layout[idx] = node.raw
  }

  public mutating func useKeyType(_ node: TypeSyntax) {
    let idx = DictionaryTypeSyntax.Cursor.keyType.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = DictionaryTypeSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useValueType(_ node: TypeSyntax) {
    let idx = DictionaryTypeSyntax.Cursor.valueType.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightSquareBracket(_ node: TokenSyntax) {
    let idx = DictionaryTypeSyntax.Cursor.rightSquareBracket.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.leftSquareBracket)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.type)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.colon)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(SyntaxKind.type)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missingToken(TokenKind.rightSquareBracket)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .dictionaryType,
      layout: layout, presence: .present))
  }
}

extension DictionaryTypeSyntax {
  /// Creates a `DictionaryTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DictionaryTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DictionaryTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout DictionaryTypeSyntaxBuilder) -> Void) {
    var builder = DictionaryTypeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct MetatypeTypeSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useBaseType(_ node: TypeSyntax) {
    let idx = MetatypeTypeSyntax.Cursor.baseType.rawValue
    layout[idx] = node.raw
  }

  public mutating func usePeriod(_ node: TokenSyntax) {
    let idx = MetatypeTypeSyntax.Cursor.period.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTypeOrProtocol(_ node: TokenSyntax) {
    let idx = MetatypeTypeSyntax.Cursor.typeOrProtocol.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.type)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.period)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.identifier(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .metatypeType,
      layout: layout, presence: .present))
  }
}

extension MetatypeTypeSyntax {
  /// Creates a `MetatypeTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `MetatypeTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `MetatypeTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout MetatypeTypeSyntaxBuilder) -> Void) {
    var builder = MetatypeTypeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct OptionalTypeSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useWrappedType(_ node: TypeSyntax) {
    let idx = OptionalTypeSyntax.Cursor.wrappedType.rawValue
    layout[idx] = node.raw
  }

  public mutating func useQuestionMark(_ node: TokenSyntax) {
    let idx = OptionalTypeSyntax.Cursor.questionMark.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.type)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.postfixQuestionMark)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .optionalType,
      layout: layout, presence: .present))
  }
}

extension OptionalTypeSyntax {
  /// Creates a `OptionalTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `OptionalTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `OptionalTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout OptionalTypeSyntaxBuilder) -> Void) {
    var builder = OptionalTypeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct SomeTypeSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useSomeSpecifier(_ node: TokenSyntax) {
    let idx = SomeTypeSyntax.Cursor.someSpecifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBaseType(_ node: TypeSyntax) {
    let idx = SomeTypeSyntax.Cursor.baseType.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.identifier(""))
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.type)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .someType,
      layout: layout, presence: .present))
  }
}

extension SomeTypeSyntax {
  /// Creates a `SomeTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SomeTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SomeTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout SomeTypeSyntaxBuilder) -> Void) {
    var builder = SomeTypeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ImplicitlyUnwrappedOptionalTypeSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useWrappedType(_ node: TypeSyntax) {
    let idx = ImplicitlyUnwrappedOptionalTypeSyntax.Cursor.wrappedType.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExclamationMark(_ node: TokenSyntax) {
    let idx = ImplicitlyUnwrappedOptionalTypeSyntax.Cursor.exclamationMark.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.type)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.exclamationMark)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .implicitlyUnwrappedOptionalType,
      layout: layout, presence: .present))
  }
}

extension ImplicitlyUnwrappedOptionalTypeSyntax {
  /// Creates a `ImplicitlyUnwrappedOptionalTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ImplicitlyUnwrappedOptionalTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ImplicitlyUnwrappedOptionalTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ImplicitlyUnwrappedOptionalTypeSyntaxBuilder) -> Void) {
    var builder = ImplicitlyUnwrappedOptionalTypeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct CompositionTypeElementSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useType(_ node: TypeSyntax) {
    let idx = CompositionTypeElementSyntax.Cursor.type.rawValue
    layout[idx] = node.raw
  }

  public mutating func useAmpersand(_ node: TokenSyntax) {
    let idx = CompositionTypeElementSyntax.Cursor.ampersand.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.type)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .compositionTypeElement,
      layout: layout, presence: .present))
  }
}

extension CompositionTypeElementSyntax {
  /// Creates a `CompositionTypeElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `CompositionTypeElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `CompositionTypeElementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout CompositionTypeElementSyntaxBuilder) -> Void) {
    var builder = CompositionTypeElementSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct CompositionTypeSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func addElement(_ elt: CompositionTypeElementSyntax) {
    let idx = CompositionTypeSyntax.Cursor.elements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.compositionTypeElementList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.compositionTypeElementList)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .compositionType,
      layout: layout, presence: .present))
  }
}

extension CompositionTypeSyntax {
  /// Creates a `CompositionTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `CompositionTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `CompositionTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout CompositionTypeSyntaxBuilder) -> Void) {
    var builder = CompositionTypeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct TupleTypeElementSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 8)

  internal init() {}

  public mutating func useInOut(_ node: TokenSyntax) {
    let idx = TupleTypeElementSyntax.Cursor.inOut.rawValue
    layout[idx] = node.raw
  }

  public mutating func useName(_ node: TokenSyntax) {
    let idx = TupleTypeElementSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSecondName(_ node: TokenSyntax) {
    let idx = TupleTypeElementSyntax.Cursor.secondName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = TupleTypeElementSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useType(_ node: TypeSyntax) {
    let idx = TupleTypeElementSyntax.Cursor.type.rawValue
    layout[idx] = node.raw
  }

  public mutating func useEllipsis(_ node: TokenSyntax) {
    let idx = TupleTypeElementSyntax.Cursor.ellipsis.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInitializer(_ node: InitializerClauseSyntax) {
    let idx = TupleTypeElementSyntax.Cursor.initializer.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = TupleTypeElementSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missing(SyntaxKind.type)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .tupleTypeElement,
      layout: layout, presence: .present))
  }
}

extension TupleTypeElementSyntax {
  /// Creates a `TupleTypeElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TupleTypeElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TupleTypeElementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout TupleTypeElementSyntaxBuilder) -> Void) {
    var builder = TupleTypeElementSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct TupleTypeSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = TupleTypeSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addElement(_ elt: TupleTypeElementSyntax) {
    let idx = TupleTypeSyntax.Cursor.elements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.tupleTypeElementList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = TupleTypeSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.leftParen)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.tupleTypeElementList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.rightParen)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .tupleType,
      layout: layout, presence: .present))
  }
}

extension TupleTypeSyntax {
  /// Creates a `TupleTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TupleTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TupleTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout TupleTypeSyntaxBuilder) -> Void) {
    var builder = TupleTypeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct FunctionTypeSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 6)

  internal init() {}

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = FunctionTypeSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addArgument(_ elt: TupleTypeElementSyntax) {
    let idx = FunctionTypeSyntax.Cursor.arguments.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.tupleTypeElementList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = FunctionTypeSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func useThrowsOrRethrowsKeyword(_ node: TokenSyntax) {
    let idx = FunctionTypeSyntax.Cursor.throwsOrRethrowsKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useArrow(_ node: TokenSyntax) {
    let idx = FunctionTypeSyntax.Cursor.arrow.rawValue
    layout[idx] = node.raw
  }

  public mutating func useReturnType(_ node: TypeSyntax) {
    let idx = FunctionTypeSyntax.Cursor.returnType.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.leftParen)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.tupleTypeElementList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.rightParen)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missingToken(TokenKind.arrow)
    }
    if (layout[5] == nil) {
      layout[5] = RawSyntax.missing(SyntaxKind.type)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .functionType,
      layout: layout, presence: .present))
  }
}

extension FunctionTypeSyntax {
  /// Creates a `FunctionTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FunctionTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FunctionTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout FunctionTypeSyntaxBuilder) -> Void) {
    var builder = FunctionTypeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct AttributedTypeSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useSpecifier(_ node: TokenSyntax) {
    let idx = AttributedTypeSyntax.Cursor.specifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = AttributedTypeSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useBaseType(_ node: TypeSyntax) {
    let idx = AttributedTypeSyntax.Cursor.baseType.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.type)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .attributedType,
      layout: layout, presence: .present))
  }
}

extension AttributedTypeSyntax {
  /// Creates a `AttributedTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AttributedTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AttributedTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout AttributedTypeSyntaxBuilder) -> Void) {
    var builder = AttributedTypeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct GenericArgumentSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useArgumentType(_ node: TypeSyntax) {
    let idx = GenericArgumentSyntax.Cursor.argumentType.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = GenericArgumentSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.type)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .genericArgument,
      layout: layout, presence: .present))
  }
}

extension GenericArgumentSyntax {
  /// Creates a `GenericArgumentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `GenericArgumentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `GenericArgumentSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout GenericArgumentSyntaxBuilder) -> Void) {
    var builder = GenericArgumentSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct GenericArgumentClauseSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useLeftAngleBracket(_ node: TokenSyntax) {
    let idx = GenericArgumentClauseSyntax.Cursor.leftAngleBracket.rawValue
    layout[idx] = node.raw
  }

  public mutating func addArgument(_ elt: GenericArgumentSyntax) {
    let idx = GenericArgumentClauseSyntax.Cursor.arguments.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.genericArgumentList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightAngleBracket(_ node: TokenSyntax) {
    let idx = GenericArgumentClauseSyntax.Cursor.rightAngleBracket.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.leftAngle)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.genericArgumentList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.rightAngle)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .genericArgumentClause,
      layout: layout, presence: .present))
  }
}

extension GenericArgumentClauseSyntax {
  /// Creates a `GenericArgumentClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `GenericArgumentClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `GenericArgumentClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout GenericArgumentClauseSyntaxBuilder) -> Void) {
    var builder = GenericArgumentClauseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct TypeAnnotationSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = TypeAnnotationSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useType(_ node: TypeSyntax) {
    let idx = TypeAnnotationSyntax.Cursor.type.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.colon)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.type)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .typeAnnotation,
      layout: layout, presence: .present))
  }
}

extension TypeAnnotationSyntax {
  /// Creates a `TypeAnnotationSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TypeAnnotationSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TypeAnnotationSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout TypeAnnotationSyntaxBuilder) -> Void) {
    var builder = TypeAnnotationSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct EnumCasePatternSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useType(_ node: TypeSyntax) {
    let idx = EnumCasePatternSyntax.Cursor.type.rawValue
    layout[idx] = node.raw
  }

  public mutating func usePeriod(_ node: TokenSyntax) {
    let idx = EnumCasePatternSyntax.Cursor.period.rawValue
    layout[idx] = node.raw
  }

  public mutating func useCaseName(_ node: TokenSyntax) {
    let idx = EnumCasePatternSyntax.Cursor.caseName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useAssociatedTuple(_ node: TuplePatternSyntax) {
    let idx = EnumCasePatternSyntax.Cursor.associatedTuple.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.period)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.identifier(""))
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .enumCasePattern,
      layout: layout, presence: .present))
  }
}

extension EnumCasePatternSyntax {
  /// Creates a `EnumCasePatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `EnumCasePatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `EnumCasePatternSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout EnumCasePatternSyntaxBuilder) -> Void) {
    var builder = EnumCasePatternSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct IsTypePatternSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useIsKeyword(_ node: TokenSyntax) {
    let idx = IsTypePatternSyntax.Cursor.isKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useType(_ node: TypeSyntax) {
    let idx = IsTypePatternSyntax.Cursor.type.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.isKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.type)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .isTypePattern,
      layout: layout, presence: .present))
  }
}

extension IsTypePatternSyntax {
  /// Creates a `IsTypePatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IsTypePatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IsTypePatternSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout IsTypePatternSyntaxBuilder) -> Void) {
    var builder = IsTypePatternSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct OptionalPatternSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useSubPattern(_ node: PatternSyntax) {
    let idx = OptionalPatternSyntax.Cursor.subPattern.rawValue
    layout[idx] = node.raw
  }

  public mutating func useQuestionMark(_ node: TokenSyntax) {
    let idx = OptionalPatternSyntax.Cursor.questionMark.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.pattern)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.postfixQuestionMark)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .optionalPattern,
      layout: layout, presence: .present))
  }
}

extension OptionalPatternSyntax {
  /// Creates a `OptionalPatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `OptionalPatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `OptionalPatternSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout OptionalPatternSyntaxBuilder) -> Void) {
    var builder = OptionalPatternSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct IdentifierPatternSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = IdentifierPatternSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.selfKeyword)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .identifierPattern,
      layout: layout, presence: .present))
  }
}

extension IdentifierPatternSyntax {
  /// Creates a `IdentifierPatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IdentifierPatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IdentifierPatternSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout IdentifierPatternSyntaxBuilder) -> Void) {
    var builder = IdentifierPatternSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct AsTypePatternSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func usePattern(_ node: PatternSyntax) {
    let idx = AsTypePatternSyntax.Cursor.pattern.rawValue
    layout[idx] = node.raw
  }

  public mutating func useAsKeyword(_ node: TokenSyntax) {
    let idx = AsTypePatternSyntax.Cursor.asKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useType(_ node: TypeSyntax) {
    let idx = AsTypePatternSyntax.Cursor.type.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.pattern)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.asKeyword)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.type)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .asTypePattern,
      layout: layout, presence: .present))
  }
}

extension AsTypePatternSyntax {
  /// Creates a `AsTypePatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AsTypePatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AsTypePatternSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout AsTypePatternSyntaxBuilder) -> Void) {
    var builder = AsTypePatternSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct TuplePatternSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = TuplePatternSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addElement(_ elt: TuplePatternElementSyntax) {
    let idx = TuplePatternSyntax.Cursor.elements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax.create(kind: SyntaxKind.tuplePatternElementList,
        layout: [elt.raw], length: elt.raw.totalLength,
        presence: SourcePresence.present)
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = TuplePatternSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.leftParen)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.tuplePatternElementList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(TokenKind.rightParen)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .tuplePattern,
      layout: layout, presence: .present))
  }
}

extension TuplePatternSyntax {
  /// Creates a `TuplePatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TuplePatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TuplePatternSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout TuplePatternSyntaxBuilder) -> Void) {
    var builder = TuplePatternSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct WildcardPatternSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useWildcard(_ node: TokenSyntax) {
    let idx = WildcardPatternSyntax.Cursor.wildcard.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTypeAnnotation(_ node: TypeAnnotationSyntax) {
    let idx = WildcardPatternSyntax.Cursor.typeAnnotation.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.wildcardKeyword)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .wildcardPattern,
      layout: layout, presence: .present))
  }
}

extension WildcardPatternSyntax {
  /// Creates a `WildcardPatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `WildcardPatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `WildcardPatternSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout WildcardPatternSyntaxBuilder) -> Void) {
    var builder = WildcardPatternSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct TuplePatternElementSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useLabelName(_ node: TokenSyntax) {
    let idx = TuplePatternElementSyntax.Cursor.labelName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLabelColon(_ node: TokenSyntax) {
    let idx = TuplePatternElementSyntax.Cursor.labelColon.rawValue
    layout[idx] = node.raw
  }

  public mutating func usePattern(_ node: PatternSyntax) {
    let idx = TuplePatternElementSyntax.Cursor.pattern.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = TuplePatternElementSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.pattern)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .tuplePatternElement,
      layout: layout, presence: .present))
  }
}

extension TuplePatternElementSyntax {
  /// Creates a `TuplePatternElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TuplePatternElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TuplePatternElementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout TuplePatternElementSyntaxBuilder) -> Void) {
    var builder = TuplePatternElementSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ExpressionPatternSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = ExpressionPatternSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.expr)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .expressionPattern,
      layout: layout, presence: .present))
  }
}

extension ExpressionPatternSyntax {
  /// Creates a `ExpressionPatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ExpressionPatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ExpressionPatternSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ExpressionPatternSyntaxBuilder) -> Void) {
    var builder = ExpressionPatternSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct ValueBindingPatternSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useLetOrVarKeyword(_ node: TokenSyntax) {
    let idx = ValueBindingPatternSyntax.Cursor.letOrVarKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useValuePattern(_ node: PatternSyntax) {
    let idx = ValueBindingPatternSyntax.Cursor.valuePattern.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.letKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.pattern)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .valueBindingPattern,
      layout: layout, presence: .present))
  }
}

extension ValueBindingPatternSyntax {
  /// Creates a `ValueBindingPatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ValueBindingPatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ValueBindingPatternSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ValueBindingPatternSyntaxBuilder) -> Void) {
    var builder = ValueBindingPatternSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct AvailabilityArgumentSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useEntry(_ node: Syntax) {
    let idx = AvailabilityArgumentSyntax.Cursor.entry.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = AvailabilityArgumentSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.unknown)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .availabilityArgument,
      layout: layout, presence: .present))
  }
}

extension AvailabilityArgumentSyntax {
  /// Creates a `AvailabilityArgumentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AvailabilityArgumentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AvailabilityArgumentSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout AvailabilityArgumentSyntaxBuilder) -> Void) {
    var builder = AvailabilityArgumentSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct AvailabilityLabeledArgumentSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useLabel(_ node: TokenSyntax) {
    let idx = AvailabilityLabeledArgumentSyntax.Cursor.label.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = AvailabilityLabeledArgumentSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useValue(_ node: Syntax) {
    let idx = AvailabilityLabeledArgumentSyntax.Cursor.value.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.identifier(""))
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(TokenKind.colon)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(SyntaxKind.unknown)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .availabilityLabeledArgument,
      layout: layout, presence: .present))
  }
}

extension AvailabilityLabeledArgumentSyntax {
  /// Creates a `AvailabilityLabeledArgumentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AvailabilityLabeledArgumentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AvailabilityLabeledArgumentSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout AvailabilityLabeledArgumentSyntaxBuilder) -> Void) {
    var builder = AvailabilityLabeledArgumentSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct AvailabilityVersionRestrictionSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func usePlatform(_ node: TokenSyntax) {
    let idx = AvailabilityVersionRestrictionSyntax.Cursor.platform.rawValue
    layout[idx] = node.raw
  }

  public mutating func useVersion(_ node: VersionTupleSyntax) {
    let idx = AvailabilityVersionRestrictionSyntax.Cursor.version.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(TokenKind.identifier(""))
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(SyntaxKind.versionTuple)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .availabilityVersionRestriction,
      layout: layout, presence: .present))
  }
}

extension AvailabilityVersionRestrictionSyntax {
  /// Creates a `AvailabilityVersionRestrictionSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AvailabilityVersionRestrictionSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AvailabilityVersionRestrictionSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout AvailabilityVersionRestrictionSyntaxBuilder) -> Void) {
    var builder = AvailabilityVersionRestrictionSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

public struct VersionTupleSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useMajorMinor(_ node: Syntax) {
    let idx = VersionTupleSyntax.Cursor.majorMinor.rawValue
    layout[idx] = node.raw
  }

  public mutating func usePatchPeriod(_ node: TokenSyntax) {
    let idx = VersionTupleSyntax.Cursor.patchPeriod.rawValue
    layout[idx] = node.raw
  }

  public mutating func usePatchVersion(_ node: TokenSyntax) {
    let idx = VersionTupleSyntax.Cursor.patchVersion.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(SyntaxKind.unknown)
    }

    return .forRoot(RawSyntax.createAndCalcLength(kind: .versionTuple,
      layout: layout, presence: .present))
  }
}

extension VersionTupleSyntax {
  /// Creates a `VersionTupleSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `VersionTupleSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `VersionTupleSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout VersionTupleSyntaxBuilder) -> Void) {
    var builder = VersionTupleSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(data)
  }
}

