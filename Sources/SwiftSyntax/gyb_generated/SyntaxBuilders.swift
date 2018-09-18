
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
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useItem(_ node: Syntax) {
    let idx = CodeBlockItemSyntax.Cursor.item.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSemicolon(_ node: TokenSyntax) {
    let idx = CodeBlockItemSyntax.Cursor.semicolon.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(.unknown)
    }

    return SyntaxData(raw: RawSyntax(kind: .codeBlockItem,
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
    self.init(root: data, data: data)
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

  public mutating func addCodeBlockItem(_ elt: CodeBlockItemSyntax) {
    let idx = CodeBlockSyntax.Cursor.statements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.codeBlockItemList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useRightBrace(_ node: TokenSyntax) {
    let idx = CodeBlockSyntax.Cursor.rightBrace.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.leftBrace)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.codeBlockItemList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.rightBrace)
    }

    return SyntaxData(raw: RawSyntax(kind: .codeBlock,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.prefixAmpersand)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.expr)
    }

    return SyntaxData(raw: RawSyntax(kind: .inOutExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.poundColumnKeyword)
    }

    return SyntaxData(raw: RawSyntax(kind: .poundColumnExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.tryKeyword)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(.expr)
    }

    return SyntaxData(raw: RawSyntax(kind: .tryExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.unknown(""))
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.colon)
    }

    return SyntaxData(raw: RawSyntax(kind: .declNameArgument,
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
    self.init(root: data, data: data)
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

  public mutating func addDeclNameArgument(_ elt: DeclNameArgumentSyntax) {
    let idx = DeclNameArgumentsSyntax.Cursor.arguments.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.declNameArgumentList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = DeclNameArgumentsSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.leftParen)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.declNameArgumentList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.rightParen)
    }

    return SyntaxData(raw: RawSyntax(kind: .declNameArguments,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.identifier(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .identifierExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.superKeyword)
    }

    return SyntaxData(raw: RawSyntax(kind: .superRefExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.nilKeyword)
    }

    return SyntaxData(raw: RawSyntax(kind: .nilLiteralExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.wildcardKeyword)
    }

    return SyntaxData(raw: RawSyntax(kind: .discardAssignmentExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.equal)
    }

    return SyntaxData(raw: RawSyntax(kind: .assignmentExpr,
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
    self.init(root: data, data: data)
  }
}

public struct SequenceExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func addExpression(_ elt: ExprSyntax) {
    let idx = SequenceExprSyntax.Cursor.elements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.exprList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(.exprList)
    }

    return SyntaxData(raw: RawSyntax(kind: .sequenceExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.poundLineKeyword)
    }

    return SyntaxData(raw: RawSyntax(kind: .poundLineExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.poundFileKeyword)
    }

    return SyntaxData(raw: RawSyntax(kind: .poundFileExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.poundFunctionKeyword)
    }

    return SyntaxData(raw: RawSyntax(kind: .poundFunctionExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.poundDsohandleKeyword)
    }

    return SyntaxData(raw: RawSyntax(kind: .poundDsohandleExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.identifier(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .symbolicReferenceExpr,
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
    self.init(root: data, data: data)
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
      layout[1] = RawSyntax.missing(.expr)
    }

    return SyntaxData(raw: RawSyntax(kind: .prefixOperatorExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.unknown(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .binaryOperatorExpr,
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
    self.init(root: data, data: data)
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
      layout[1] = RawSyntax.missingToken(.arrow)
    }

    return SyntaxData(raw: RawSyntax(kind: .arrowExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.floatingLiteral(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .floatLiteralExpr,
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
    self.init(root: data, data: data)
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

  public mutating func addTupleElement(_ elt: TupleElementSyntax) {
    let idx = TupleExprSyntax.Cursor.elementList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.tupleElementList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = TupleExprSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.leftParen)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.tupleElementList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.rightParen)
    }

    return SyntaxData(raw: RawSyntax(kind: .tupleExpr,
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
    self.init(root: data, data: data)
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

  public mutating func addArrayElement(_ elt: ArrayElementSyntax) {
    let idx = ArrayExprSyntax.Cursor.elements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.arrayElementList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useRightSquare(_ node: TokenSyntax) {
    let idx = ArrayExprSyntax.Cursor.rightSquare.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.leftSquareBracket)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.arrayElementList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.rightSquareBracket)
    }

    return SyntaxData(raw: RawSyntax(kind: .arrayExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.leftSquareBracket)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.unknown)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.rightSquareBracket)
    }

    return SyntaxData(raw: RawSyntax(kind: .dictionaryExpr,
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
    self.init(root: data, data: data)
  }
}

public struct ImplicitMemberExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useDot(_ node: TokenSyntax) {
    let idx = ImplicitMemberExprSyntax.Cursor.dot.rawValue
    layout[idx] = node.raw
  }

  public mutating func useName(_ node: TokenSyntax) {
    let idx = ImplicitMemberExprSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDeclNameArguments(_ node: DeclNameArgumentsSyntax) {
    let idx = ImplicitMemberExprSyntax.Cursor.declNameArguments.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.prefixPeriod)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.unknown(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .implicitMemberExpr,
                                     layout: layout, presence: .present))
  }
}

extension ImplicitMemberExprSyntax {
  /// Creates a `ImplicitMemberExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ImplicitMemberExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ImplicitMemberExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout ImplicitMemberExprSyntaxBuilder) -> Void) {
    var builder = ImplicitMemberExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
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
      layout[2] = RawSyntax.missing(.expr)
    }

    return SyntaxData(raw: RawSyntax(kind: .functionCallArgument,
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
    self.init(root: data, data: data)
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
      layout[2] = RawSyntax.missing(.expr)
    }

    return SyntaxData(raw: RawSyntax(kind: .tupleElement,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.expr)
    }

    return SyntaxData(raw: RawSyntax(kind: .arrayElement,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.expr)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.colon)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(.expr)
    }

    return SyntaxData(raw: RawSyntax(kind: .dictionaryElement,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.integerLiteral(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .integerLiteralExpr,
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
    self.init(root: data, data: data)
  }
}

public struct StringLiteralExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func useStringLiteral(_ node: TokenSyntax) {
    let idx = StringLiteralExprSyntax.Cursor.stringLiteral.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.stringLiteral(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .stringLiteralExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.trueKeyword)
    }

    return SyntaxData(raw: RawSyntax(kind: .booleanLiteralExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.expr)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.infixQuestionMark)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(.expr)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(.colon)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missing(.expr)
    }

    return SyntaxData(raw: RawSyntax(kind: .ternaryExpr,
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
    self.init(root: data, data: data)
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
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(.expr)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.period)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.unknown(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .memberAccessExpr,
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
    self.init(root: data, data: data)
  }
}

public struct DotSelfExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = DotSelfExprSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDot(_ node: TokenSyntax) {
    let idx = DotSelfExprSyntax.Cursor.dot.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSelfKeyword(_ node: TokenSyntax) {
    let idx = DotSelfExprSyntax.Cursor.selfKeyword.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(.expr)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.period)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.selfKeyword)
    }

    return SyntaxData(raw: RawSyntax(kind: .dotSelfExpr,
                                     layout: layout, presence: .present))
  }
}

extension DotSelfExprSyntax {
  /// Creates a `DotSelfExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DotSelfExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DotSelfExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout DotSelfExprSyntaxBuilder) -> Void) {
    var builder = DotSelfExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.isKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.type)
    }

    return SyntaxData(raw: RawSyntax(kind: .isExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.asKeyword)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(.type)
    }

    return SyntaxData(raw: RawSyntax(kind: .asExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.type)
    }

    return SyntaxData(raw: RawSyntax(kind: .typeExpr,
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
    self.init(root: data, data: data)
  }
}

public struct ClosureCaptureItemSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func addToken(_ elt: TokenSyntax) {
    let idx = ClosureCaptureItemSyntax.Cursor.specifier.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.tokenList,
                              layout: [elt.raw],
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
      layout[3] = RawSyntax.missing(.expr)
    }

    return SyntaxData(raw: RawSyntax(kind: .closureCaptureItem,
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
    self.init(root: data, data: data)
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

  public mutating func addClosureCaptureItem(_ elt: ClosureCaptureItemSyntax) {
    let idx = ClosureCaptureSignatureSyntax.Cursor.items.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.closureCaptureItemList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useRightSquare(_ node: TokenSyntax) {
    let idx = ClosureCaptureSignatureSyntax.Cursor.rightSquare.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.leftSquareBracket)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.rightSquareBracket)
    }

    return SyntaxData(raw: RawSyntax(kind: .closureCaptureSignature,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.identifier(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .closureParam,
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
    self.init(root: data, data: data)
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
      layout[4] = RawSyntax.missingToken(.inKeyword)
    }

    return SyntaxData(raw: RawSyntax(kind: .closureSignature,
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
    self.init(root: data, data: data)
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

  public mutating func addCodeBlockItem(_ elt: CodeBlockItemSyntax) {
    let idx = ClosureExprSyntax.Cursor.statements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.codeBlockItemList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useRightBrace(_ node: TokenSyntax) {
    let idx = ClosureExprSyntax.Cursor.rightBrace.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.leftBrace)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(.codeBlockItemList)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(.rightBrace)
    }

    return SyntaxData(raw: RawSyntax(kind: .closureExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.pattern)
    }

    return SyntaxData(raw: RawSyntax(kind: .unresolvedPatternExpr,
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
    self.init(root: data, data: data)
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

  public mutating func addFunctionCallArgument(_ elt: FunctionCallArgumentSyntax) {
    let idx = FunctionCallExprSyntax.Cursor.argumentList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.functionCallArgumentList,
                              layout: [elt.raw],
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
      layout[0] = RawSyntax.missing(.expr)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(.functionCallArgumentList)
    }

    return SyntaxData(raw: RawSyntax(kind: .functionCallExpr,
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
    self.init(root: data, data: data)
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

  public mutating func addFunctionCallArgument(_ elt: FunctionCallArgumentSyntax) {
    let idx = SubscriptExprSyntax.Cursor.argumentList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.functionCallArgumentList,
                              layout: [elt.raw],
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
      layout[0] = RawSyntax.missing(.expr)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.leftSquareBracket)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(.functionCallArgumentList)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(.rightSquareBracket)
    }

    return SyntaxData(raw: RawSyntax(kind: .subscriptExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.expr)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.postfixQuestionMark)
    }

    return SyntaxData(raw: RawSyntax(kind: .optionalChainingExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.expr)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.exclamationMark)
    }

    return SyntaxData(raw: RawSyntax(kind: .forcedValueExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.expr)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.postfixOperator(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .postfixUnaryExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.expr)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.genericArgumentClause)
    }

    return SyntaxData(raw: RawSyntax(kind: .specializeExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.stringSegment(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .stringSegment,
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
    self.init(root: data, data: data)
  }
}

public struct ExpressionSegmentSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func useBackslash(_ node: TokenSyntax) {
    let idx = ExpressionSegmentSyntax.Cursor.backslash.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = ExpressionSegmentSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = ExpressionSegmentSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = ExpressionSegmentSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.backslash)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.leftParen)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(.expr)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(.stringInterpolationAnchor)
    }

    return SyntaxData(raw: RawSyntax(kind: .expressionSegment,
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
    self.init(root: data, data: data)
  }
}

public struct StringInterpolationExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useOpenQuote(_ node: TokenSyntax) {
    let idx = StringInterpolationExprSyntax.Cursor.openQuote.rawValue
    layout[idx] = node.raw
  }

  public mutating func addSegment(_ elt: Syntax) {
    let idx = StringInterpolationExprSyntax.Cursor.segments.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.stringInterpolationSegments,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useCloseQuote(_ node: TokenSyntax) {
    let idx = StringInterpolationExprSyntax.Cursor.closeQuote.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.stringQuote)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.stringInterpolationSegments)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.stringQuote)
    }

    return SyntaxData(raw: RawSyntax(kind: .stringInterpolationExpr,
                                     layout: layout, presence: .present))
  }
}

extension StringInterpolationExprSyntax {
  /// Creates a `StringInterpolationExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `StringInterpolationExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `StringInterpolationExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout StringInterpolationExprSyntaxBuilder) -> Void) {
    var builder = StringInterpolationExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct KeyPathExprSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useBackslash(_ node: TokenSyntax) {
    let idx = KeyPathExprSyntax.Cursor.backslash.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = KeyPathExprSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.backslash)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.expr)
    }

    return SyntaxData(raw: RawSyntax(kind: .keyPathExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.identifier(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .objcNamePiece,
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
    self.init(root: data, data: data)
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

  public mutating func addObjcNamePiece(_ elt: ObjcNamePieceSyntax) {
    let idx = ObjcKeyPathExprSyntax.Cursor.name.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.objcName,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = ObjcKeyPathExprSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.poundKeyPathKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.leftParen)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(.objcName)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(.rightParen)
    }

    return SyntaxData(raw: RawSyntax(kind: .objcKeyPathExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.poundSelectorKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.leftParen)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missing(.expr)
    }
    if (layout[5] == nil) {
      layout[5] = RawSyntax.missingToken(.rightParen)
    }

    return SyntaxData(raw: RawSyntax(kind: .objcSelectorExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.identifier(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .editorPlaceholderExpr,
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
    self.init(root: data, data: data)
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

  public mutating func addFunctionCallArgument(_ elt: FunctionCallArgumentSyntax) {
    let idx = ObjectLiteralExprSyntax.Cursor.arguments.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.functionCallArgumentList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = ObjectLiteralExprSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.poundColorLiteralKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.leftParen)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(.functionCallArgumentList)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(.rightParen)
    }

    return SyntaxData(raw: RawSyntax(kind: .objectLiteralExpr,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.equal)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.type)
    }

    return SyntaxData(raw: RawSyntax(kind: .typeInitializerClause,
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
    self.init(root: data, data: data)
  }
}

public struct TypealiasDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 7)

  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = TypealiasDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.attributeList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = TypealiasDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.modifierList,
                              layout: [elt.raw],
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
      layout[2] = RawSyntax.missingToken(.typealiasKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(.identifier(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .typealiasDecl,
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
    self.init(root: data, data: data)
  }
}

public struct AssociatedtypeDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 7)

  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = AssociatedtypeDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.attributeList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = AssociatedtypeDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.modifierList,
                              layout: [elt.raw],
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
      layout[2] = RawSyntax.missingToken(.associatedtypeKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(.identifier(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .associatedtypeDecl,
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
    self.init(root: data, data: data)
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

  public mutating func addFunctionParameter(_ elt: FunctionParameterSyntax) {
    let idx = ParameterClauseSyntax.Cursor.parameterList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.functionParameterList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = ParameterClauseSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.leftParen)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.functionParameterList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.rightParen)
    }

    return SyntaxData(raw: RawSyntax(kind: .parameterClause,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.arrow)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.type)
    }

    return SyntaxData(raw: RawSyntax(kind: .returnClause,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.parameterClause)
    }

    return SyntaxData(raw: RawSyntax(kind: .functionSignature,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.poundIfKeyword)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(.unknown)
    }

    return SyntaxData(raw: RawSyntax(kind: .ifConfigClause,
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
    self.init(root: data, data: data)
  }
}

public struct IfConfigDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func addIfConfigClause(_ elt: IfConfigClauseSyntax) {
    let idx = IfConfigDeclSyntax.Cursor.clauses.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.ifConfigClauseList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func usePoundEndif(_ node: TokenSyntax) {
    let idx = IfConfigDeclSyntax.Cursor.poundEndif.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(.ifConfigClauseList)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.poundEndifKeyword)
    }

    return SyntaxData(raw: RawSyntax(kind: .ifConfigDecl,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.unknown(""))
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.leftParen)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(.stringLiteralExpr)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(.rightParen)
    }

    return SyntaxData(raw: RawSyntax(kind: .poundErrorDecl,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.unknown(""))
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.leftParen)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(.stringLiteralExpr)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(.rightParen)
    }

    return SyntaxData(raw: RawSyntax(kind: .poundWarningDecl,
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
    self.init(root: data, data: data)
  }
}

public struct DeclModifierSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useName(_ node: TokenSyntax) {
    let idx = DeclModifierSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func addToken(_ elt: TokenSyntax) {
    let idx = DeclModifierSyntax.Cursor.detail.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.tokenList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.unknown(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .declModifier,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.type)
    }

    return SyntaxData(raw: RawSyntax(kind: .inheritedType,
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
    self.init(root: data, data: data)
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
      layout[idx] = RawSyntax(kind: SyntaxKind.inheritedTypeList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.colon)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.inheritedTypeList)
    }

    return SyntaxData(raw: RawSyntax(kind: .typeInheritanceClause,
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
    self.init(root: data, data: data)
  }
}

public struct ClassDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 8)

  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = ClassDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.attributeList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = ClassDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.modifierList,
                              layout: [elt.raw],
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
      layout[2] = RawSyntax.missingToken(.classKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(.identifier(""))
    }
    if (layout[7] == nil) {
      layout[7] = RawSyntax.missing(.memberDeclBlock)
    }

    return SyntaxData(raw: RawSyntax(kind: .classDecl,
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
    self.init(root: data, data: data)
  }
}

public struct StructDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 8)

  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = StructDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.attributeList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = StructDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.modifierList,
                              layout: [elt.raw],
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
      layout[2] = RawSyntax.missingToken(.structKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(.identifier(""))
    }
    if (layout[7] == nil) {
      layout[7] = RawSyntax.missing(.memberDeclBlock)
    }

    return SyntaxData(raw: RawSyntax(kind: .structDecl,
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
    self.init(root: data, data: data)
  }
}

public struct ProtocolDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 7)

  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = ProtocolDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.attributeList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = ProtocolDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.modifierList,
                              layout: [elt.raw],
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
      layout[2] = RawSyntax.missingToken(.protocolKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(.identifier(""))
    }
    if (layout[6] == nil) {
      layout[6] = RawSyntax.missing(.memberDeclBlock)
    }

    return SyntaxData(raw: RawSyntax(kind: .protocolDecl,
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
    self.init(root: data, data: data)
  }
}

public struct ExtensionDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 7)

  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = ExtensionDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.attributeList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = ExtensionDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.modifierList,
                              layout: [elt.raw],
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
      layout[2] = RawSyntax.missingToken(.extensionKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(.type)
    }
    if (layout[6] == nil) {
      layout[6] = RawSyntax.missing(.memberDeclBlock)
    }

    return SyntaxData(raw: RawSyntax(kind: .extensionDecl,
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
    self.init(root: data, data: data)
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

  public mutating func addDecl(_ elt: DeclSyntax) {
    let idx = MemberDeclBlockSyntax.Cursor.members.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.declList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useRightBrace(_ node: TokenSyntax) {
    let idx = MemberDeclBlockSyntax.Cursor.rightBrace.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.leftBrace)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.declList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.rightBrace)
    }

    return SyntaxData(raw: RawSyntax(kind: .memberDeclBlock,
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
    self.init(root: data, data: data)
  }
}

public struct SourceFileSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func addCodeBlockItem(_ elt: CodeBlockItemSyntax) {
    let idx = SourceFileSyntax.Cursor.statements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.codeBlockItemList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useEOFToken(_ node: TokenSyntax) {
    let idx = SourceFileSyntax.Cursor.eofToken.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(.codeBlockItemList)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.unknown(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .sourceFile,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.equal)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.expr)
    }

    return SyntaxData(raw: RawSyntax(kind: .initializerClause,
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
    self.init(root: data, data: data)
  }
}

public struct FunctionParameterSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 8)

  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = FunctionParameterSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.attributeList,
                              layout: [elt.raw],
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

    return SyntaxData(raw: RawSyntax(kind: .functionParameter,
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
    self.init(root: data, data: data)
  }
}

public struct FunctionDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 8)

  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = FunctionDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.attributeList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = FunctionDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.modifierList,
                              layout: [elt.raw],
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
      layout[2] = RawSyntax.missingToken(.funcKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(.identifier(""))
    }
    if (layout[5] == nil) {
      layout[5] = RawSyntax.missing(.functionSignature)
    }

    return SyntaxData(raw: RawSyntax(kind: .functionDecl,
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
    self.init(root: data, data: data)
  }
}

public struct InitializerDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 9)

  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = InitializerDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.attributeList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = InitializerDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.modifierList,
                              layout: [elt.raw],
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
      layout[2] = RawSyntax.missingToken(.initKeyword)
    }
    if (layout[5] == nil) {
      layout[5] = RawSyntax.missing(.parameterClause)
    }

    return SyntaxData(raw: RawSyntax(kind: .initializerDecl,
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
    self.init(root: data, data: data)
  }
}

public struct DeinitializerDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = DeinitializerDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.attributeList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = DeinitializerDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.modifierList,
                              layout: [elt.raw],
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
      layout[2] = RawSyntax.missingToken(.deinitKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(.codeBlock)
    }

    return SyntaxData(raw: RawSyntax(kind: .deinitializerDecl,
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
    self.init(root: data, data: data)
  }
}

public struct SubscriptDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 8)

  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = SubscriptDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.attributeList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = SubscriptDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.modifierList,
                              layout: [elt.raw],
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

  public mutating func useAccessor(_ node: AccessorBlockSyntax) {
    let idx = SubscriptDeclSyntax.Cursor.accessor.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.subscriptKeyword)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missing(.parameterClause)
    }
    if (layout[5] == nil) {
      layout[5] = RawSyntax.missing(.returnClause)
    }

    return SyntaxData(raw: RawSyntax(kind: .subscriptDecl,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.identifier(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .accessLevelModifier,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.identifier(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .accessPathComponent,
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
    self.init(root: data, data: data)
  }
}

public struct ImportDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = ImportDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.attributeList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = ImportDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.modifierList,
                              layout: [elt.raw],
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

  public mutating func addAccessPathComponent(_ elt: AccessPathComponentSyntax) {
    let idx = ImportDeclSyntax.Cursor.path.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.accessPath,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.importKeyword)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missing(.accessPath)
    }

    return SyntaxData(raw: RawSyntax(kind: .importDecl,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.leftParen)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.identifier(""))
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.rightParen)
    }

    return SyntaxData(raw: RawSyntax(kind: .accessorParameter,
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
    self.init(root: data, data: data)
  }
}

public struct AccessorDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = AccessorDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.attributeList,
                              layout: [elt.raw],
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
      layout[2] = RawSyntax.missingToken(.unknown(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .accessorDecl,
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
    self.init(root: data, data: data)
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

  public mutating func useAccessorListOrStmtList(_ node: Syntax) {
    let idx = AccessorBlockSyntax.Cursor.accessorListOrStmtList.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightBrace(_ node: TokenSyntax) {
    let idx = AccessorBlockSyntax.Cursor.rightBrace.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.leftBrace)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.unknown)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.rightBrace)
    }

    return SyntaxData(raw: RawSyntax(kind: .accessorBlock,
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
    self.init(root: data, data: data)
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

  public mutating func useAccessor(_ node: AccessorBlockSyntax) {
    let idx = PatternBindingSyntax.Cursor.accessor.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = PatternBindingSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(.pattern)
    }

    return SyntaxData(raw: RawSyntax(kind: .patternBinding,
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
    self.init(root: data, data: data)
  }
}

public struct VariableDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = VariableDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.attributeList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = VariableDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.modifierList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useLetOrVarKeyword(_ node: TokenSyntax) {
    let idx = VariableDeclSyntax.Cursor.letOrVarKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addPatternBinding(_ elt: PatternBindingSyntax) {
    let idx = VariableDeclSyntax.Cursor.bindings.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.patternBindingList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.letKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(.patternBindingList)
    }

    return SyntaxData(raw: RawSyntax(kind: .variableDecl,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.identifier(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .enumCaseElement,
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
    self.init(root: data, data: data)
  }
}

public struct EnumCaseDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 4)

  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = EnumCaseDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.attributeList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = EnumCaseDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.modifierList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useCaseKeyword(_ node: TokenSyntax) {
    let idx = EnumCaseDeclSyntax.Cursor.caseKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addEnumCaseElement(_ elt: EnumCaseElementSyntax) {
    let idx = EnumCaseDeclSyntax.Cursor.elements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.enumCaseElementList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.caseKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(.enumCaseElementList)
    }

    return SyntaxData(raw: RawSyntax(kind: .enumCaseDecl,
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
    self.init(root: data, data: data)
  }
}

public struct EnumDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 8)

  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = EnumDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.attributeList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = EnumDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.modifierList,
                              layout: [elt.raw],
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
      layout[2] = RawSyntax.missingToken(.enumKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(.identifier(""))
    }
    if (layout[7] == nil) {
      layout[7] = RawSyntax.missing(.memberDeclBlock)
    }

    return SyntaxData(raw: RawSyntax(kind: .enumDecl,
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
    self.init(root: data, data: data)
  }
}

public struct OperatorDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = OperatorDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.attributeList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = OperatorDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.modifierList,
                              layout: [elt.raw],
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

  public mutating func useInfixOperatorGroup(_ node: InfixOperatorGroupSyntax) {
    let idx = OperatorDeclSyntax.Cursor.infixOperatorGroup.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.operatorKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(.unspacedBinaryOperator(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .operatorDecl,
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
    self.init(root: data, data: data)
  }
}

public struct InfixOperatorGroupSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = InfixOperatorGroupSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func usePrecedenceGroupName(_ node: TokenSyntax) {
    let idx = InfixOperatorGroupSyntax.Cursor.precedenceGroupName.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.colon)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.identifier(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .infixOperatorGroup,
                                     layout: layout, presence: .present))
  }
}

extension InfixOperatorGroupSyntax {
  /// Creates a `InfixOperatorGroupSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `InfixOperatorGroupSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `InfixOperatorGroupSyntax` with all the fields populated in the builder
  ///            closure.
  public init(_ build: (inout InfixOperatorGroupSyntaxBuilder) -> Void) {
    var builder = InfixOperatorGroupSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct PrecedenceGroupDeclSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 7)

  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = PrecedenceGroupDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.attributeList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = PrecedenceGroupDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.modifierList,
                              layout: [elt.raw],
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

  public mutating func addSyntax(_ elt: Syntax) {
    let idx = PrecedenceGroupDeclSyntax.Cursor.groupAttributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.precedenceGroupAttributeList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useRightBrace(_ node: TokenSyntax) {
    let idx = PrecedenceGroupDeclSyntax.Cursor.rightBrace.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.precedencegroupKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missingToken(.identifier(""))
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missingToken(.leftBrace)
    }
    if (layout[5] == nil) {
      layout[5] = RawSyntax.missing(.precedenceGroupAttributeList)
    }
    if (layout[6] == nil) {
      layout[6] = RawSyntax.missingToken(.rightBrace)
    }

    return SyntaxData(raw: RawSyntax(kind: .precedenceGroupDecl,
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
    self.init(root: data, data: data)
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

  public mutating func addPrecedenceGroupNameElement(_ elt: PrecedenceGroupNameElementSyntax) {
    let idx = PrecedenceGroupRelationSyntax.Cursor.otherNames.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.precedenceGroupNameList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.identifier(""))
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.colon)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(.precedenceGroupNameList)
    }

    return SyntaxData(raw: RawSyntax(kind: .precedenceGroupRelation,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.identifier(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .precedenceGroupNameElement,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.identifier(""))
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.colon)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.trueKeyword)
    }

    return SyntaxData(raw: RawSyntax(kind: .precedenceGroupAssignment,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.identifier(""))
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.colon)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.identifier(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .precedenceGroupAssociativity,
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
    self.init(root: data, data: data)
  }
}

public struct AttributeSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 3)

  internal init() {}

  public mutating func useAtSignToken(_ node: TokenSyntax) {
    let idx = AttributeSyntax.Cursor.atSignToken.rawValue
    layout[idx] = node.raw
  }

  public mutating func useAttributeName(_ node: TokenSyntax) {
    let idx = AttributeSyntax.Cursor.attributeName.rawValue
    layout[idx] = node.raw
  }

  public mutating func addToken(_ elt: TokenSyntax) {
    let idx = AttributeSyntax.Cursor.balancedTokens.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.tokenList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.atSign)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.unknown(""))
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.unknown(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .attribute,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.continueKeyword)
    }

    return SyntaxData(raw: RawSyntax(kind: .continueStmt,
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
    self.init(root: data, data: data)
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

  public mutating func addConditionElement(_ elt: ConditionElementSyntax) {
    let idx = WhileStmtSyntax.Cursor.conditions.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.conditionElementList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = WhileStmtSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.whileKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(.conditionElementList)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missing(.codeBlock)
    }

    return SyntaxData(raw: RawSyntax(kind: .whileStmt,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.deferKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.codeBlock)
    }

    return SyntaxData(raw: RawSyntax(kind: .deferStmt,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.expr)
    }

    return SyntaxData(raw: RawSyntax(kind: .expressionStmt,
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
    self.init(root: data, data: data)
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
      layout[2] = RawSyntax.missingToken(.repeatKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(.codeBlock)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missingToken(.whileKeyword)
    }
    if (layout[5] == nil) {
      layout[5] = RawSyntax.missing(.expr)
    }

    return SyntaxData(raw: RawSyntax(kind: .repeatWhileStmt,
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
    self.init(root: data, data: data)
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

  public mutating func addConditionElement(_ elt: ConditionElementSyntax) {
    let idx = GuardStmtSyntax.Cursor.conditions.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.conditionElementList,
                              layout: [elt.raw],
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
      layout[0] = RawSyntax.missingToken(.guardKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.conditionElementList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.elseKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(.codeBlock)
    }

    return SyntaxData(raw: RawSyntax(kind: .guardStmt,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.whereKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.expr)
    }

    return SyntaxData(raw: RawSyntax(kind: .whereClause,
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
    self.init(root: data, data: data)
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
      layout[2] = RawSyntax.missingToken(.forKeyword)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missing(.pattern)
    }
    if (layout[6] == nil) {
      layout[6] = RawSyntax.missingToken(.inKeyword)
    }
    if (layout[7] == nil) {
      layout[7] = RawSyntax.missing(.expr)
    }
    if (layout[9] == nil) {
      layout[9] = RawSyntax.missing(.codeBlock)
    }

    return SyntaxData(raw: RawSyntax(kind: .forInStmt,
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
    self.init(root: data, data: data)
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

  public mutating func addSyntax(_ elt: Syntax) {
    let idx = SwitchStmtSyntax.Cursor.cases.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.switchCaseList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useRightBrace(_ node: TokenSyntax) {
    let idx = SwitchStmtSyntax.Cursor.rightBrace.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.switchKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(.expr)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missingToken(.leftBrace)
    }
    if (layout[5] == nil) {
      layout[5] = RawSyntax.missing(.switchCaseList)
    }
    if (layout[6] == nil) {
      layout[6] = RawSyntax.missingToken(.rightBrace)
    }

    return SyntaxData(raw: RawSyntax(kind: .switchStmt,
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
    self.init(root: data, data: data)
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
      layout[idx] = RawSyntax(kind: SyntaxKind.catchClauseList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.doKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(.codeBlock)
    }

    return SyntaxData(raw: RawSyntax(kind: .doStmt,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.returnKeyword)
    }

    return SyntaxData(raw: RawSyntax(kind: .returnStmt,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.fallthroughKeyword)
    }

    return SyntaxData(raw: RawSyntax(kind: .fallthroughStmt,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.breakKeyword)
    }

    return SyntaxData(raw: RawSyntax(kind: .breakStmt,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.unknown)
    }

    return SyntaxData(raw: RawSyntax(kind: .conditionElement,
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
    self.init(root: data, data: data)
  }
}

public struct AvailabilityConditionSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 2)

  internal init() {}

  public mutating func usePoundAvailableKeyword(_ node: TokenSyntax) {
    let idx = AvailabilityConditionSyntax.Cursor.poundAvailableKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addToken(_ elt: TokenSyntax) {
    let idx = AvailabilityConditionSyntax.Cursor.arguments.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.tokenList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.poundAvailableKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.unknown(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .availabilityCondition,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.caseKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.pattern)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(.initializerClause)
    }

    return SyntaxData(raw: RawSyntax(kind: .matchingPatternCondition,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.letKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.pattern)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(.initializerClause)
    }

    return SyntaxData(raw: RawSyntax(kind: .optionalBindingCondition,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.decl)
    }

    return SyntaxData(raw: RawSyntax(kind: .declarationStmt,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.throwKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.expr)
    }

    return SyntaxData(raw: RawSyntax(kind: .throwStmt,
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
    self.init(root: data, data: data)
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

  public mutating func addConditionElement(_ elt: ConditionElementSyntax) {
    let idx = IfStmtSyntax.Cursor.conditions.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.conditionElementList,
                              layout: [elt.raw],
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
      layout[2] = RawSyntax.missingToken(.ifKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(.conditionElementList)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missing(.codeBlock)
    }

    return SyntaxData(raw: RawSyntax(kind: .ifStmt,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.ifStmt)
    }

    return SyntaxData(raw: RawSyntax(kind: .elseIfContinuation,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.elseKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.codeBlock)
    }

    return SyntaxData(raw: RawSyntax(kind: .elseBlock,
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
    self.init(root: data, data: data)
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

  public mutating func addCodeBlockItem(_ elt: CodeBlockItemSyntax) {
    let idx = SwitchCaseSyntax.Cursor.statements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.codeBlockItemList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.unknown)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(.codeBlockItemList)
    }

    return SyntaxData(raw: RawSyntax(kind: .switchCase,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.defaultKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.colon)
    }

    return SyntaxData(raw: RawSyntax(kind: .switchDefaultLabel,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.pattern)
    }

    return SyntaxData(raw: RawSyntax(kind: .caseItem,
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
    self.init(root: data, data: data)
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
      layout[idx] = RawSyntax(kind: SyntaxKind.caseItemList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = SwitchCaseLabelSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.caseKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.caseItemList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.colon)
    }

    return SyntaxData(raw: RawSyntax(kind: .switchCaseLabel,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.catchKeyword)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(.codeBlock)
    }

    return SyntaxData(raw: RawSyntax(kind: .catchClause,
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
    self.init(root: data, data: data)
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

  public mutating func addGenericRequirement(_ elt: Syntax) {
    let idx = GenericWhereClauseSyntax.Cursor.requirementList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.genericRequirementList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.whereKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.genericRequirementList)
    }

    return SyntaxData(raw: RawSyntax(kind: .genericWhereClause,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.type)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.spacedBinaryOperator(""))
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(.type)
    }

    return SyntaxData(raw: RawSyntax(kind: .sameTypeRequirement,
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
    self.init(root: data, data: data)
  }
}

public struct GenericParameterSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 5)

  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = GenericParameterSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.attributeList,
                              layout: [elt.raw],
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
      layout[1] = RawSyntax.missingToken(.identifier(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .genericParameter,
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
    self.init(root: data, data: data)
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
      layout[idx] = RawSyntax(kind: SyntaxKind.genericParameterList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useRightAngleBracket(_ node: TokenSyntax) {
    let idx = GenericParameterClauseSyntax.Cursor.rightAngleBracket.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.leftAngle)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.genericParameterList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.rightAngle)
    }

    return SyntaxData(raw: RawSyntax(kind: .genericParameterClause,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.type)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.colon)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(.type)
    }

    return SyntaxData(raw: RawSyntax(kind: .conformanceRequirement,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.identifier(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .simpleTypeIdentifier,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.type)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.period)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.identifier(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .memberTypeIdentifier,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.leftSquareBracket)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.type)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.rightSquareBracket)
    }

    return SyntaxData(raw: RawSyntax(kind: .arrayType,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.leftSquareBracket)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.type)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.colon)
    }
    if (layout[3] == nil) {
      layout[3] = RawSyntax.missing(.type)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missingToken(.rightSquareBracket)
    }

    return SyntaxData(raw: RawSyntax(kind: .dictionaryType,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.type)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.period)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.identifier(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .metatypeType,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.type)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.postfixQuestionMark)
    }

    return SyntaxData(raw: RawSyntax(kind: .optionalType,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.type)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.exclamationMark)
    }

    return SyntaxData(raw: RawSyntax(kind: .implicitlyUnwrappedOptionalType,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.type)
    }

    return SyntaxData(raw: RawSyntax(kind: .compositionTypeElement,
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
    self.init(root: data, data: data)
  }
}

public struct CompositionTypeSyntaxBuilder {
  private var layout =
    Array<RawSyntax?>(repeating: nil, count: 1)

  internal init() {}

  public mutating func addCompositionTypeElement(_ elt: CompositionTypeElementSyntax) {
    let idx = CompositionTypeSyntax.Cursor.elements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.compositionTypeElementList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missing(.compositionTypeElementList)
    }

    return SyntaxData(raw: RawSyntax(kind: .compositionType,
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
    self.init(root: data, data: data)
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
      layout[4] = RawSyntax.missing(.type)
    }

    return SyntaxData(raw: RawSyntax(kind: .tupleTypeElement,
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
    self.init(root: data, data: data)
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

  public mutating func addTupleTypeElement(_ elt: TupleTypeElementSyntax) {
    let idx = TupleTypeSyntax.Cursor.elements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.tupleTypeElementList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = TupleTypeSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.leftParen)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.tupleTypeElementList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.rightParen)
    }

    return SyntaxData(raw: RawSyntax(kind: .tupleType,
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
    self.init(root: data, data: data)
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

  public mutating func addTupleTypeElement(_ elt: TupleTypeElementSyntax) {
    let idx = FunctionTypeSyntax.Cursor.arguments.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.tupleTypeElementList,
                              layout: [elt.raw],
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
      layout[0] = RawSyntax.missingToken(.leftParen)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.tupleTypeElementList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.rightParen)
    }
    if (layout[4] == nil) {
      layout[4] = RawSyntax.missingToken(.arrow)
    }
    if (layout[5] == nil) {
      layout[5] = RawSyntax.missing(.type)
    }

    return SyntaxData(raw: RawSyntax(kind: .functionType,
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
    self.init(root: data, data: data)
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

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = AttributedTypeSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.attributeList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useBaseType(_ node: TypeSyntax) {
    let idx = AttributedTypeSyntax.Cursor.baseType.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(.type)
    }

    return SyntaxData(raw: RawSyntax(kind: .attributedType,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.type)
    }

    return SyntaxData(raw: RawSyntax(kind: .genericArgument,
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
    self.init(root: data, data: data)
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

  public mutating func addGenericArgument(_ elt: GenericArgumentSyntax) {
    let idx = GenericArgumentClauseSyntax.Cursor.arguments.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.genericArgumentList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useRightAngleBracket(_ node: TokenSyntax) {
    let idx = GenericArgumentClauseSyntax.Cursor.rightAngleBracket.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.leftAngle)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.genericArgumentList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.rightAngle)
    }

    return SyntaxData(raw: RawSyntax(kind: .genericArgumentClause,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.colon)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.type)
    }

    return SyntaxData(raw: RawSyntax(kind: .typeAnnotation,
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
    self.init(root: data, data: data)
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
      layout[1] = RawSyntax.missingToken(.period)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.identifier(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .enumCasePattern,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.isKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.type)
    }

    return SyntaxData(raw: RawSyntax(kind: .isTypePattern,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.pattern)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.postfixQuestionMark)
    }

    return SyntaxData(raw: RawSyntax(kind: .optionalPattern,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.identifier(""))
    }

    return SyntaxData(raw: RawSyntax(kind: .identifierPattern,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.pattern)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missingToken(.asKeyword)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missing(.type)
    }

    return SyntaxData(raw: RawSyntax(kind: .asTypePattern,
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
    self.init(root: data, data: data)
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

  public mutating func addTuplePatternElement(_ elt: TuplePatternElementSyntax) {
    let idx = TuplePatternSyntax.Cursor.elements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.appending(elt.raw)
    } else {
      layout[idx] = RawSyntax(kind: SyntaxKind.tuplePatternElementList,
                              layout: [elt.raw],
                              presence: SourcePresence.present)
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = TuplePatternSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.missingToken(.leftParen)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.tuplePatternElementList)
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.missingToken(.rightParen)
    }

    return SyntaxData(raw: RawSyntax(kind: .tuplePattern,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.wildcardKeyword)
    }

    return SyntaxData(raw: RawSyntax(kind: .wildcardPattern,
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
    self.init(root: data, data: data)
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
      layout[2] = RawSyntax.missing(.pattern)
    }

    return SyntaxData(raw: RawSyntax(kind: .tuplePatternElement,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missing(.expr)
    }

    return SyntaxData(raw: RawSyntax(kind: .expressionPattern,
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
    self.init(root: data, data: data)
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
      layout[0] = RawSyntax.missingToken(.letKeyword)
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.missing(.pattern)
    }

    return SyntaxData(raw: RawSyntax(kind: .valueBindingPattern,
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
    self.init(root: data, data: data)
  }
}

