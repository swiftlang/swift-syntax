//// Automatically Generated From SyntaxBuilders.swift.gyb.
//// Do Not Edit Directly!
//===------------ SyntaxBuilders.swift - Syntax Builder definitions -------===//
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


public struct CodeBlockItemSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .codeBlockItem,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension CodeBlockItemSyntax {
  /// Creates a `CodeBlockItemSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `CodeBlockItemSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `CodeBlockItemSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout CodeBlockItemSyntaxBuilder) -> Void) {
    var builder = CodeBlockItemSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct CodeBlockSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLeftBrace(_ node: TokenSyntax) {
    let idx = CodeBlockSyntax.Cursor.leftBrace.rawValue
    layout[idx] = node.raw
  }

  public mutating func addStatement(_ elt: CodeBlockItemSyntax) {
    let idx = CodeBlockSyntax.Cursor.statements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .codeBlockItemList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightBrace(_ node: TokenSyntax) {
    let idx = CodeBlockSyntax.Cursor.rightBrace.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftBrace).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawCodeBlockItemListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightBrace).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .codeBlock,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension CodeBlockSyntax {
  /// Creates a `CodeBlockSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `CodeBlockSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `CodeBlockSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout CodeBlockSyntaxBuilder) -> Void) {
    var builder = CodeBlockSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct InOutExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .prefixAmpersand).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawExprSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .inOutExpr,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension InOutExprSyntax {
  /// Creates a `InOutExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `InOutExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `InOutExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout InOutExprSyntaxBuilder) -> Void) {
    var builder = InOutExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PoundColumnExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func usePoundColumn(_ node: TokenSyntax) {
    let idx = PoundColumnExprSyntax.Cursor.poundColumn.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundColumnKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundColumnExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PoundColumnExprSyntax {
  /// Creates a `PoundColumnExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundColumnExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundColumnExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PoundColumnExprSyntaxBuilder) -> Void) {
    var builder = PoundColumnExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct TryExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .tryKeyword).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawExprSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .tryExpr,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension TryExprSyntax {
  /// Creates a `TryExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TryExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TryExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout TryExprSyntaxBuilder) -> Void) {
    var builder = TryExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct AwaitExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useAwaitKeyword(_ node: TokenSyntax) {
    let idx = AwaitExprSyntax.Cursor.awaitKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = AwaitExprSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawExprSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .awaitExpr,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension AwaitExprSyntax {
  /// Creates a `AwaitExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AwaitExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AwaitExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout AwaitExprSyntaxBuilder) -> Void) {
    var builder = AwaitExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct DeclNameArgumentSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .unknown).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .declNameArgument,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension DeclNameArgumentSyntax {
  /// Creates a `DeclNameArgumentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DeclNameArgumentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DeclNameArgumentSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout DeclNameArgumentSyntaxBuilder) -> Void) {
    var builder = DeclNameArgumentSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct DeclNameArgumentsSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = DeclNameArgumentsSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addArgument(_ elt: DeclNameArgumentSyntax) {
    let idx = DeclNameArgumentsSyntax.Cursor.arguments.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .declNameArgumentList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = DeclNameArgumentsSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawDeclNameArgumentListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .declNameArguments,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension DeclNameArgumentsSyntax {
  /// Creates a `DeclNameArgumentsSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DeclNameArgumentsSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DeclNameArgumentsSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout DeclNameArgumentsSyntaxBuilder) -> Void) {
    var builder = DeclNameArgumentsSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct IdentifierExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .identifierExpr,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension IdentifierExprSyntax {
  /// Creates a `IdentifierExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IdentifierExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IdentifierExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout IdentifierExprSyntaxBuilder) -> Void) {
    var builder = IdentifierExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct SuperRefExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useSuperKeyword(_ node: TokenSyntax) {
    let idx = SuperRefExprSyntax.Cursor.superKeyword.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .superKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .superRefExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension SuperRefExprSyntax {
  /// Creates a `SuperRefExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SuperRefExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SuperRefExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout SuperRefExprSyntaxBuilder) -> Void) {
    var builder = SuperRefExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct NilLiteralExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useNilKeyword(_ node: TokenSyntax) {
    let idx = NilLiteralExprSyntax.Cursor.nilKeyword.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .nilKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .nilLiteralExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension NilLiteralExprSyntax {
  /// Creates a `NilLiteralExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `NilLiteralExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `NilLiteralExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout NilLiteralExprSyntaxBuilder) -> Void) {
    var builder = NilLiteralExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct DiscardAssignmentExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useWildcard(_ node: TokenSyntax) {
    let idx = DiscardAssignmentExprSyntax.Cursor.wildcard.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .wildcardKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .discardAssignmentExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension DiscardAssignmentExprSyntax {
  /// Creates a `DiscardAssignmentExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DiscardAssignmentExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DiscardAssignmentExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout DiscardAssignmentExprSyntaxBuilder) -> Void) {
    var builder = DiscardAssignmentExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct AssignmentExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useAssignToken(_ node: TokenSyntax) {
    let idx = AssignmentExprSyntax.Cursor.assignToken.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .equal).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .assignmentExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension AssignmentExprSyntax {
  /// Creates a `AssignmentExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AssignmentExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AssignmentExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout AssignmentExprSyntaxBuilder) -> Void) {
    var builder = AssignmentExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct SequenceExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addElement(_ elt: ExprSyntax) {
    let idx = SequenceExprSyntax.Cursor.elements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .exprList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawExprListSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .sequenceExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension SequenceExprSyntax {
  /// Creates a `SequenceExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SequenceExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SequenceExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout SequenceExprSyntaxBuilder) -> Void) {
    var builder = SequenceExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PoundLineExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func usePoundLine(_ node: TokenSyntax) {
    let idx = PoundLineExprSyntax.Cursor.poundLine.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundLineKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundLineExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PoundLineExprSyntax {
  /// Creates a `PoundLineExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundLineExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundLineExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PoundLineExprSyntaxBuilder) -> Void) {
    var builder = PoundLineExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PoundFileExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func usePoundFile(_ node: TokenSyntax) {
    let idx = PoundFileExprSyntax.Cursor.poundFile.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundFileKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundFileExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PoundFileExprSyntax {
  /// Creates a `PoundFileExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundFileExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundFileExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PoundFileExprSyntaxBuilder) -> Void) {
    var builder = PoundFileExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PoundFileIDExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func usePoundFileID(_ node: TokenSyntax) {
    let idx = PoundFileIDExprSyntax.Cursor.poundFileID.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundFileIDKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundFileIDExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PoundFileIDExprSyntax {
  /// Creates a `PoundFileIDExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundFileIDExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundFileIDExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PoundFileIDExprSyntaxBuilder) -> Void) {
    var builder = PoundFileIDExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PoundFilePathExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func usePoundFilePath(_ node: TokenSyntax) {
    let idx = PoundFilePathExprSyntax.Cursor.poundFilePath.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundFilePathKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundFilePathExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PoundFilePathExprSyntax {
  /// Creates a `PoundFilePathExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundFilePathExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundFilePathExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PoundFilePathExprSyntaxBuilder) -> Void) {
    var builder = PoundFilePathExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PoundFunctionExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func usePoundFunction(_ node: TokenSyntax) {
    let idx = PoundFunctionExprSyntax.Cursor.poundFunction.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundFunctionKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundFunctionExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PoundFunctionExprSyntax {
  /// Creates a `PoundFunctionExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundFunctionExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundFunctionExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PoundFunctionExprSyntaxBuilder) -> Void) {
    var builder = PoundFunctionExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PoundDsohandleExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func usePoundDsohandle(_ node: TokenSyntax) {
    let idx = PoundDsohandleExprSyntax.Cursor.poundDsohandle.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundDsohandleKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundDsohandleExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PoundDsohandleExprSyntax {
  /// Creates a `PoundDsohandleExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundDsohandleExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundDsohandleExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PoundDsohandleExprSyntaxBuilder) -> Void) {
    var builder = PoundDsohandleExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct SymbolicReferenceExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .symbolicReferenceExpr,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension SymbolicReferenceExprSyntax {
  /// Creates a `SymbolicReferenceExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SymbolicReferenceExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SymbolicReferenceExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout SymbolicReferenceExprSyntaxBuilder) -> Void) {
    var builder = SymbolicReferenceExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PrefixOperatorExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[1] = RawExprSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .prefixOperatorExpr,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PrefixOperatorExprSyntax {
  /// Creates a `PrefixOperatorExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PrefixOperatorExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PrefixOperatorExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PrefixOperatorExprSyntaxBuilder) -> Void) {
    var builder = PrefixOperatorExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct BinaryOperatorExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useOperatorToken(_ node: TokenSyntax) {
    let idx = BinaryOperatorExprSyntax.Cursor.operatorToken.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .unknown).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .binaryOperatorExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension BinaryOperatorExprSyntax {
  /// Creates a `BinaryOperatorExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `BinaryOperatorExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `BinaryOperatorExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout BinaryOperatorExprSyntaxBuilder) -> Void) {
    var builder = BinaryOperatorExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ArrowExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useAsyncKeyword(_ node: TokenSyntax) {
    let idx = ArrowExprSyntax.Cursor.asyncKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useThrowsToken(_ node: TokenSyntax) {
    let idx = ArrowExprSyntax.Cursor.throwsToken.rawValue
    layout[idx] = node.raw
  }

  public mutating func useArrowToken(_ node: TokenSyntax) {
    let idx = ArrowExprSyntax.Cursor.arrowToken.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .arrow).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .arrowExpr,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ArrowExprSyntax {
  /// Creates a `ArrowExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ArrowExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ArrowExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ArrowExprSyntaxBuilder) -> Void) {
    var builder = ArrowExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct FloatLiteralExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useFloatingDigits(_ node: TokenSyntax) {
    let idx = FloatLiteralExprSyntax.Cursor.floatingDigits.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .floatingLiteral).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .floatLiteralExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension FloatLiteralExprSyntax {
  /// Creates a `FloatLiteralExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FloatLiteralExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FloatLiteralExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout FloatLiteralExprSyntaxBuilder) -> Void) {
    var builder = FloatLiteralExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct TupleExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = TupleExprSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addElement(_ elt: TupleExprElementSyntax) {
    let idx = TupleExprSyntax.Cursor.elementList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .tupleExprElementList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = TupleExprSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTupleExprElementListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .tupleExpr,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension TupleExprSyntax {
  /// Creates a `TupleExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TupleExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TupleExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout TupleExprSyntaxBuilder) -> Void) {
    var builder = TupleExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ArrayExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLeftSquare(_ node: TokenSyntax) {
    let idx = ArrayExprSyntax.Cursor.leftSquare.rawValue
    layout[idx] = node.raw
  }

  public mutating func addElement(_ elt: ArrayElementSyntax) {
    let idx = ArrayExprSyntax.Cursor.elements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .arrayElementList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightSquare(_ node: TokenSyntax) {
    let idx = ArrayExprSyntax.Cursor.rightSquare.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftSquareBracket).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawArrayElementListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightSquareBracket).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .arrayExpr,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ArrayExprSyntax {
  /// Creates a `ArrayExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ArrayExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ArrayExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ArrayExprSyntaxBuilder) -> Void) {
    var builder = ArrayExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct DictionaryExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftSquareBracket).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightSquareBracket).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .dictionaryExpr,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension DictionaryExprSyntax {
  /// Creates a `DictionaryExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DictionaryExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DictionaryExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout DictionaryExprSyntaxBuilder) -> Void) {
    var builder = DictionaryExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct TupleExprElementSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLabel(_ node: TokenSyntax) {
    let idx = TupleExprElementSyntax.Cursor.label.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = TupleExprElementSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = TupleExprElementSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = TupleExprElementSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawExprSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .tupleExprElement,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension TupleExprElementSyntax {
  /// Creates a `TupleExprElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TupleExprElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TupleExprElementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout TupleExprElementSyntaxBuilder) -> Void) {
    var builder = TupleExprElementSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ArrayElementSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawExprSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .arrayElement,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ArrayElementSyntax {
  /// Creates a `ArrayElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ArrayElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ArrayElementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ArrayElementSyntaxBuilder) -> Void) {
    var builder = ArrayElementSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct DictionaryElementSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawExprSyntax.makeBlank(arena: arena).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawExprSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .dictionaryElement,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension DictionaryElementSyntax {
  /// Creates a `DictionaryElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DictionaryElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DictionaryElementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout DictionaryElementSyntaxBuilder) -> Void) {
    var builder = DictionaryElementSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct IntegerLiteralExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useDigits(_ node: TokenSyntax) {
    let idx = IntegerLiteralExprSyntax.Cursor.digits.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .integerLiteral).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .integerLiteralExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension IntegerLiteralExprSyntax {
  /// Creates a `IntegerLiteralExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IntegerLiteralExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IntegerLiteralExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout IntegerLiteralExprSyntaxBuilder) -> Void) {
    var builder = IntegerLiteralExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct BooleanLiteralExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useBooleanLiteral(_ node: TokenSyntax) {
    let idx = BooleanLiteralExprSyntax.Cursor.booleanLiteral.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .trueKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .booleanLiteralExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension BooleanLiteralExprSyntax {
  /// Creates a `BooleanLiteralExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `BooleanLiteralExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `BooleanLiteralExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout BooleanLiteralExprSyntaxBuilder) -> Void) {
    var builder = BooleanLiteralExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct TernaryExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 5)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawExprSyntax.makeBlank(arena: arena).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .infixQuestionMark).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawExprSyntax.makeBlank(arena: arena).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[4] == nil) {
      layout[4] = RawExprSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .ternaryExpr,
                                   uninitializedCount: 5) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension TernaryExprSyntax {
  /// Creates a `TernaryExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TernaryExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TernaryExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout TernaryExprSyntaxBuilder) -> Void) {
    var builder = TernaryExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct MemberAccessExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .period).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .unknown).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .memberAccessExpr,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension MemberAccessExprSyntax {
  /// Creates a `MemberAccessExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `MemberAccessExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `MemberAccessExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout MemberAccessExprSyntaxBuilder) -> Void) {
    var builder = MemberAccessExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct IsExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .isKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTypeSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .isExpr,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension IsExprSyntax {
  /// Creates a `IsExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IsExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IsExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout IsExprSyntaxBuilder) -> Void) {
    var builder = IsExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct AsExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .asKeyword).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTypeSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .asExpr,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension AsExprSyntax {
  /// Creates a `AsExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AsExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AsExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout AsExprSyntaxBuilder) -> Void) {
    var builder = AsExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct TypeExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useType(_ node: TypeSyntax) {
    let idx = TypeExprSyntax.Cursor.type.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTypeSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .typeExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension TypeExprSyntax {
  /// Creates a `TypeExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TypeExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TypeExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout TypeExprSyntaxBuilder) -> Void) {
    var builder = TypeExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ClosureCaptureItemSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 5)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addSpecifierToken(_ elt: TokenSyntax) {
    let idx = ClosureCaptureItemSyntax.Cursor.specifier.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .tokenList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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
      layout[3] = RawExprSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .closureCaptureItem,
                                   uninitializedCount: 5) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ClosureCaptureItemSyntax {
  /// Creates a `ClosureCaptureItemSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ClosureCaptureItemSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ClosureCaptureItemSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ClosureCaptureItemSyntaxBuilder) -> Void) {
    var builder = ClosureCaptureItemSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ClosureCaptureSignatureSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLeftSquare(_ node: TokenSyntax) {
    let idx = ClosureCaptureSignatureSyntax.Cursor.leftSquare.rawValue
    layout[idx] = node.raw
  }

  public mutating func addItem(_ elt: ClosureCaptureItemSyntax) {
    let idx = ClosureCaptureSignatureSyntax.Cursor.items.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .closureCaptureItemList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightSquare(_ node: TokenSyntax) {
    let idx = ClosureCaptureSignatureSyntax.Cursor.rightSquare.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftSquareBracket).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightSquareBracket).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .closureCaptureSignature,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ClosureCaptureSignatureSyntax {
  /// Creates a `ClosureCaptureSignatureSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ClosureCaptureSignatureSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ClosureCaptureSignatureSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ClosureCaptureSignatureSyntaxBuilder) -> Void) {
    var builder = ClosureCaptureSignatureSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ClosureParamSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .closureParam,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ClosureParamSyntax {
  /// Creates a `ClosureParamSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ClosureParamSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ClosureParamSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ClosureParamSyntaxBuilder) -> Void) {
    var builder = ClosureParamSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ClosureSignatureSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 7)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = ClosureSignatureSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useCapture(_ node: ClosureCaptureSignatureSyntax) {
    let idx = ClosureSignatureSyntax.Cursor.capture.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInput(_ node: Syntax) {
    let idx = ClosureSignatureSyntax.Cursor.input.rawValue
    layout[idx] = node.raw
  }

  public mutating func useAsyncKeyword(_ node: TokenSyntax) {
    let idx = ClosureSignatureSyntax.Cursor.asyncKeyword.rawValue
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
    if (layout[6] == nil) {
      layout[6] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .inKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .closureSignature,
                                   uninitializedCount: 7) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ClosureSignatureSyntax {
  /// Creates a `ClosureSignatureSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ClosureSignatureSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ClosureSignatureSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ClosureSignatureSyntaxBuilder) -> Void) {
    var builder = ClosureSignatureSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ClosureExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .codeBlockItemList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightBrace(_ node: TokenSyntax) {
    let idx = ClosureExprSyntax.Cursor.rightBrace.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftBrace).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawCodeBlockItemListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightBrace).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .closureExpr,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ClosureExprSyntax {
  /// Creates a `ClosureExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ClosureExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ClosureExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ClosureExprSyntaxBuilder) -> Void) {
    var builder = ClosureExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct UnresolvedPatternExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func usePattern(_ node: PatternSyntax) {
    let idx = UnresolvedPatternExprSyntax.Cursor.pattern.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawPatternSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .unresolvedPatternExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension UnresolvedPatternExprSyntax {
  /// Creates a `UnresolvedPatternExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `UnresolvedPatternExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `UnresolvedPatternExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout UnresolvedPatternExprSyntaxBuilder) -> Void) {
    var builder = UnresolvedPatternExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct MultipleTrailingClosureElementSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLabel(_ node: TokenSyntax) {
    let idx = MultipleTrailingClosureElementSyntax.Cursor.label.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = MultipleTrailingClosureElementSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useClosure(_ node: ClosureExprSyntax) {
    let idx = MultipleTrailingClosureElementSyntax.Cursor.closure.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawClosureExprSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .multipleTrailingClosureElement,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension MultipleTrailingClosureElementSyntax {
  /// Creates a `MultipleTrailingClosureElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `MultipleTrailingClosureElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `MultipleTrailingClosureElementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout MultipleTrailingClosureElementSyntaxBuilder) -> Void) {
    var builder = MultipleTrailingClosureElementSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct FunctionCallExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 6)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useCalledExpression(_ node: ExprSyntax) {
    let idx = FunctionCallExprSyntax.Cursor.calledExpression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = FunctionCallExprSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addArgument(_ elt: TupleExprElementSyntax) {
    let idx = FunctionCallExprSyntax.Cursor.argumentList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .tupleExprElementList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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

  public mutating func addAdditionalTrailingClosure(_ elt: MultipleTrailingClosureElementSyntax) {
    let idx = FunctionCallExprSyntax.Cursor.additionalTrailingClosures.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .multipleTrailingClosureElementList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawExprSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTupleExprElementListSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .functionCallExpr,
                                   uninitializedCount: 6) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension FunctionCallExprSyntax {
  /// Creates a `FunctionCallExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FunctionCallExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FunctionCallExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout FunctionCallExprSyntaxBuilder) -> Void) {
    var builder = FunctionCallExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct SubscriptExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 6)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useCalledExpression(_ node: ExprSyntax) {
    let idx = SubscriptExprSyntax.Cursor.calledExpression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftBracket(_ node: TokenSyntax) {
    let idx = SubscriptExprSyntax.Cursor.leftBracket.rawValue
    layout[idx] = node.raw
  }

  public mutating func addArgument(_ elt: TupleExprElementSyntax) {
    let idx = SubscriptExprSyntax.Cursor.argumentList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .tupleExprElementList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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

  public mutating func addAdditionalTrailingClosure(_ elt: MultipleTrailingClosureElementSyntax) {
    let idx = SubscriptExprSyntax.Cursor.additionalTrailingClosures.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .multipleTrailingClosureElementList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawExprSyntax.makeBlank(arena: arena).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftSquareBracket).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTupleExprElementListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightSquareBracket).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .subscriptExpr,
                                   uninitializedCount: 6) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension SubscriptExprSyntax {
  /// Creates a `SubscriptExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SubscriptExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SubscriptExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout SubscriptExprSyntaxBuilder) -> Void) {
    var builder = SubscriptExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct OptionalChainingExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawExprSyntax.makeBlank(arena: arena).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .postfixQuestionMark).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .optionalChainingExpr,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension OptionalChainingExprSyntax {
  /// Creates a `OptionalChainingExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `OptionalChainingExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `OptionalChainingExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout OptionalChainingExprSyntaxBuilder) -> Void) {
    var builder = OptionalChainingExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ForcedValueExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawExprSyntax.makeBlank(arena: arena).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .exclamationMark).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .forcedValueExpr,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ForcedValueExprSyntax {
  /// Creates a `ForcedValueExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ForcedValueExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ForcedValueExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ForcedValueExprSyntaxBuilder) -> Void) {
    var builder = ForcedValueExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PostfixUnaryExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawExprSyntax.makeBlank(arena: arena).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .postfixOperator).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .postfixUnaryExpr,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PostfixUnaryExprSyntax {
  /// Creates a `PostfixUnaryExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PostfixUnaryExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PostfixUnaryExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PostfixUnaryExprSyntaxBuilder) -> Void) {
    var builder = PostfixUnaryExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct SpecializeExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawExprSyntax.makeBlank(arena: arena).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawGenericArgumentClauseSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .specializeExpr,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension SpecializeExprSyntax {
  /// Creates a `SpecializeExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SpecializeExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SpecializeExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout SpecializeExprSyntaxBuilder) -> Void) {
    var builder = SpecializeExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct StringSegmentSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useContent(_ node: TokenSyntax) {
    let idx = StringSegmentSyntax.Cursor.content.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .stringSegment).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .stringSegment,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension StringSegmentSyntax {
  /// Creates a `StringSegmentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `StringSegmentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `StringSegmentSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout StringSegmentSyntaxBuilder) -> Void) {
    var builder = StringSegmentSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ExpressionSegmentSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 5)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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

  public mutating func addExpression(_ elt: TupleExprElementSyntax) {
    let idx = ExpressionSegmentSyntax.Cursor.expressions.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .tupleExprElementList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = ExpressionSegmentSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .backslash).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTupleExprElementListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[4] == nil) {
      layout[4] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .stringInterpolationAnchor).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .expressionSegment,
                                   uninitializedCount: 5) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ExpressionSegmentSyntax {
  /// Creates a `ExpressionSegmentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ExpressionSegmentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ExpressionSegmentSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ExpressionSegmentSyntaxBuilder) -> Void) {
    var builder = ExpressionSegmentSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct StringLiteralExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 5)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .stringLiteralSegments, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .stringQuote).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawStringLiteralSegmentsSyntax.makeBlank(arena: arena).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .stringQuote).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .stringLiteralExpr,
                                   uninitializedCount: 5) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension StringLiteralExprSyntax {
  /// Creates a `StringLiteralExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `StringLiteralExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `StringLiteralExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout StringLiteralExprSyntaxBuilder) -> Void) {
    var builder = StringLiteralExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct RegexLiteralExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useRegex(_ node: TokenSyntax) {
    let idx = RegexLiteralExprSyntax.Cursor.regex.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .regexLiteral).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .regexLiteralExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension RegexLiteralExprSyntax {
  /// Creates a `RegexLiteralExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `RegexLiteralExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `RegexLiteralExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout RegexLiteralExprSyntaxBuilder) -> Void) {
    var builder = RegexLiteralExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct KeyPathExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .backslash).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawExprSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .keyPathExpr,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension KeyPathExprSyntax {
  /// Creates a `KeyPathExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `KeyPathExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `KeyPathExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout KeyPathExprSyntaxBuilder) -> Void) {
    var builder = KeyPathExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct KeyPathBaseExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func usePeriod(_ node: TokenSyntax) {
    let idx = KeyPathBaseExprSyntax.Cursor.period.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .period).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .keyPathBaseExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension KeyPathBaseExprSyntax {
  /// Creates a `KeyPathBaseExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `KeyPathBaseExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `KeyPathBaseExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout KeyPathBaseExprSyntaxBuilder) -> Void) {
    var builder = KeyPathBaseExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ObjcNamePieceSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .objcNamePiece,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ObjcNamePieceSyntax {
  /// Creates a `ObjcNamePieceSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ObjcNamePieceSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ObjcNamePieceSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ObjcNamePieceSyntaxBuilder) -> Void) {
    var builder = ObjcNamePieceSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ObjcKeyPathExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .objcName, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = ObjcKeyPathExprSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundKeyPathKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawObjcNameSyntax.makeBlank(arena: arena).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .objcKeyPathExpr,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ObjcKeyPathExprSyntax {
  /// Creates a `ObjcKeyPathExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ObjcKeyPathExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ObjcKeyPathExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ObjcKeyPathExprSyntaxBuilder) -> Void) {
    var builder = ObjcKeyPathExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ObjcSelectorExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 6)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundSelectorKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw
    }
    if (layout[4] == nil) {
      layout[4] = RawExprSyntax.makeBlank(arena: arena).raw
    }
    if (layout[5] == nil) {
      layout[5] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .objcSelectorExpr,
                                   uninitializedCount: 6) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ObjcSelectorExprSyntax {
  /// Creates a `ObjcSelectorExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ObjcSelectorExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ObjcSelectorExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ObjcSelectorExprSyntaxBuilder) -> Void) {
    var builder = ObjcSelectorExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PostfixIfConfigExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useBase(_ node: ExprSyntax) {
    let idx = PostfixIfConfigExprSyntax.Cursor.base.rawValue
    layout[idx] = node.raw
  }

  public mutating func useConfig(_ node: IfConfigDeclSyntax) {
    let idx = PostfixIfConfigExprSyntax.Cursor.config.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[1] == nil) {
      layout[1] = RawIfConfigDeclSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .postfixIfConfigExpr,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PostfixIfConfigExprSyntax {
  /// Creates a `PostfixIfConfigExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PostfixIfConfigExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PostfixIfConfigExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PostfixIfConfigExprSyntaxBuilder) -> Void) {
    var builder = PostfixIfConfigExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct EditorPlaceholderExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = EditorPlaceholderExprSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .editorPlaceholderExpr,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension EditorPlaceholderExprSyntax {
  /// Creates a `EditorPlaceholderExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `EditorPlaceholderExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `EditorPlaceholderExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout EditorPlaceholderExprSyntaxBuilder) -> Void) {
    var builder = EditorPlaceholderExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ObjectLiteralExprSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = ObjectLiteralExprSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = ObjectLiteralExprSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addArgument(_ elt: TupleExprElementSyntax) {
    let idx = ObjectLiteralExprSyntax.Cursor.arguments.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .tupleExprElementList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = ObjectLiteralExprSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundColorLiteralKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTupleExprElementListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .objectLiteralExpr,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ObjectLiteralExprSyntax {
  /// Creates a `ObjectLiteralExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ObjectLiteralExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ObjectLiteralExprSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ObjectLiteralExprSyntaxBuilder) -> Void) {
    var builder = ObjectLiteralExprSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct TypeInitializerClauseSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .equal).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTypeSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .typeInitializerClause,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension TypeInitializerClauseSyntax {
  /// Creates a `TypeInitializerClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TypeInitializerClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TypeInitializerClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout TypeInitializerClauseSyntaxBuilder) -> Void) {
    var builder = TypeInitializerClauseSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct TypealiasDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 7)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = TypealiasDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = TypealiasDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .modifierList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .typealiasKeyword).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[5] == nil) {
      layout[5] = RawTypeInitializerClauseSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .typealiasDecl,
                                   uninitializedCount: 7) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension TypealiasDeclSyntax {
  /// Creates a `TypealiasDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TypealiasDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TypealiasDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout TypealiasDeclSyntaxBuilder) -> Void) {
    var builder = TypealiasDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct AssociatedtypeDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 7)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = AssociatedtypeDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = AssociatedtypeDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .modifierList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .associatedtypeKeyword).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .associatedtypeDecl,
                                   uninitializedCount: 7) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension AssociatedtypeDeclSyntax {
  /// Creates a `AssociatedtypeDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AssociatedtypeDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AssociatedtypeDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout AssociatedtypeDeclSyntaxBuilder) -> Void) {
    var builder = AssociatedtypeDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ParameterClauseSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = ParameterClauseSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addParameter(_ elt: FunctionParameterSyntax) {
    let idx = ParameterClauseSyntax.Cursor.parameterList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .functionParameterList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = ParameterClauseSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawFunctionParameterListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .parameterClause,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ParameterClauseSyntax {
  /// Creates a `ParameterClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ParameterClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ParameterClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ParameterClauseSyntaxBuilder) -> Void) {
    var builder = ParameterClauseSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ReturnClauseSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .arrow).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTypeSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .returnClause,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ReturnClauseSyntax {
  /// Creates a `ReturnClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ReturnClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ReturnClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ReturnClauseSyntaxBuilder) -> Void) {
    var builder = ReturnClauseSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct FunctionSignatureSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useInput(_ node: ParameterClauseSyntax) {
    let idx = FunctionSignatureSyntax.Cursor.input.rawValue
    layout[idx] = node.raw
  }

  public mutating func useAsyncOrReasyncKeyword(_ node: TokenSyntax) {
    let idx = FunctionSignatureSyntax.Cursor.asyncOrReasyncKeyword.rawValue
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
      layout[0] = RawParameterClauseSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .functionSignature,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension FunctionSignatureSyntax {
  /// Creates a `FunctionSignatureSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FunctionSignatureSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FunctionSignatureSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout FunctionSignatureSyntaxBuilder) -> Void) {
    var builder = FunctionSignatureSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct IfConfigClauseSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundIfKeyword).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .ifConfigClause,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension IfConfigClauseSyntax {
  /// Creates a `IfConfigClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IfConfigClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IfConfigClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout IfConfigClauseSyntaxBuilder) -> Void) {
    var builder = IfConfigClauseSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct IfConfigDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addClause(_ elt: IfConfigClauseSyntax) {
    let idx = IfConfigDeclSyntax.Cursor.clauses.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .ifConfigClauseList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func usePoundEndif(_ node: TokenSyntax) {
    let idx = IfConfigDeclSyntax.Cursor.poundEndif.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawIfConfigClauseListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundEndifKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .ifConfigDecl,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension IfConfigDeclSyntax {
  /// Creates a `IfConfigDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IfConfigDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IfConfigDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout IfConfigDeclSyntaxBuilder) -> Void) {
    var builder = IfConfigDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PoundErrorDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundErrorKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawStringLiteralExprSyntax.makeBlank(arena: arena).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundErrorDecl,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PoundErrorDeclSyntax {
  /// Creates a `PoundErrorDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundErrorDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundErrorDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PoundErrorDeclSyntaxBuilder) -> Void) {
    var builder = PoundErrorDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PoundWarningDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundWarningKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawStringLiteralExprSyntax.makeBlank(arena: arena).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundWarningDecl,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PoundWarningDeclSyntax {
  /// Creates a `PoundWarningDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundWarningDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundWarningDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PoundWarningDeclSyntaxBuilder) -> Void) {
    var builder = PoundWarningDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PoundSourceLocationSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundSourceLocationKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundSourceLocation,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PoundSourceLocationSyntax {
  /// Creates a `PoundSourceLocationSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundSourceLocationSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundSourceLocationSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PoundSourceLocationSyntaxBuilder) -> Void) {
    var builder = PoundSourceLocationSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PoundSourceLocationArgsSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 7)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .stringLiteral).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .comma).raw
    }
    if (layout[4] == nil) {
      layout[4] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[5] == nil) {
      layout[5] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[6] == nil) {
      layout[6] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .integerLiteral).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundSourceLocationArgs,
                                   uninitializedCount: 7) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PoundSourceLocationArgsSyntax {
  /// Creates a `PoundSourceLocationArgsSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundSourceLocationArgsSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundSourceLocationArgsSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PoundSourceLocationArgsSyntaxBuilder) -> Void) {
    var builder = PoundSourceLocationArgsSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct DeclModifierDetailSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = DeclModifierDetailSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDetail(_ node: TokenSyntax) {
    let idx = DeclModifierDetailSyntax.Cursor.detail.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = DeclModifierDetailSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .declModifierDetail,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension DeclModifierDetailSyntax {
  /// Creates a `DeclModifierDetailSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DeclModifierDetailSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DeclModifierDetailSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout DeclModifierDetailSyntaxBuilder) -> Void) {
    var builder = DeclModifierDetailSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct DeclModifierSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useName(_ node: TokenSyntax) {
    let idx = DeclModifierSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDetail(_ node: DeclModifierDetailSyntax) {
    let idx = DeclModifierSyntax.Cursor.detail.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .unknown).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .declModifier,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension DeclModifierSyntax {
  /// Creates a `DeclModifierSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DeclModifierSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DeclModifierSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout DeclModifierSyntaxBuilder) -> Void) {
    var builder = DeclModifierSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct InheritedTypeSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTypeSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .inheritedType,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension InheritedTypeSyntax {
  /// Creates a `InheritedTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `InheritedTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `InheritedTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout InheritedTypeSyntaxBuilder) -> Void) {
    var builder = InheritedTypeSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct TypeInheritanceClauseSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = TypeInheritanceClauseSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func addInheritedType(_ elt: InheritedTypeSyntax) {
    let idx = TypeInheritanceClauseSyntax.Cursor.inheritedTypeCollection.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .inheritedTypeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawInheritedTypeListSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .typeInheritanceClause,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension TypeInheritanceClauseSyntax {
  /// Creates a `TypeInheritanceClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TypeInheritanceClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TypeInheritanceClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout TypeInheritanceClauseSyntaxBuilder) -> Void) {
    var builder = TypeInheritanceClauseSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ClassDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 8)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = ClassDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = ClassDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .modifierList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .classKeyword).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[7] == nil) {
      layout[7] = RawMemberDeclBlockSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .classDecl,
                                   uninitializedCount: 8) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ClassDeclSyntax {
  /// Creates a `ClassDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ClassDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ClassDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ClassDeclSyntaxBuilder) -> Void) {
    var builder = ClassDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ActorDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 8)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = ActorDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = ActorDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .modifierList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useActorKeyword(_ node: TokenSyntax) {
    let idx = ActorDeclSyntax.Cursor.actorKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = ActorDeclSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericParameterClause(_ node: GenericParameterClauseSyntax) {
    let idx = ActorDeclSyntax.Cursor.genericParameterClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInheritanceClause(_ node: TypeInheritanceClauseSyntax) {
    let idx = ActorDeclSyntax.Cursor.inheritanceClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericWhereClause(_ node: GenericWhereClauseSyntax) {
    let idx = ActorDeclSyntax.Cursor.genericWhereClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useMembers(_ node: MemberDeclBlockSyntax) {
    let idx = ActorDeclSyntax.Cursor.members.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .contextualKeyword).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[7] == nil) {
      layout[7] = RawMemberDeclBlockSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .actorDecl,
                                   uninitializedCount: 8) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ActorDeclSyntax {
  /// Creates a `ActorDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ActorDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ActorDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ActorDeclSyntaxBuilder) -> Void) {
    var builder = ActorDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct StructDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 8)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = StructDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = StructDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .modifierList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .structKeyword).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[7] == nil) {
      layout[7] = RawMemberDeclBlockSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .structDecl,
                                   uninitializedCount: 8) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension StructDeclSyntax {
  /// Creates a `StructDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `StructDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `StructDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout StructDeclSyntaxBuilder) -> Void) {
    var builder = StructDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ProtocolDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 8)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = ProtocolDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = ProtocolDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .modifierList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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

  public mutating func usePrimaryAssociatedTypeClause(_ node: PrimaryAssociatedTypeClauseSyntax) {
    let idx = ProtocolDeclSyntax.Cursor.primaryAssociatedTypeClause.rawValue
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
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .protocolKeyword).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[7] == nil) {
      layout[7] = RawMemberDeclBlockSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .protocolDecl,
                                   uninitializedCount: 8) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ProtocolDeclSyntax {
  /// Creates a `ProtocolDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ProtocolDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ProtocolDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ProtocolDeclSyntaxBuilder) -> Void) {
    var builder = ProtocolDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ExtensionDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 7)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = ExtensionDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = ExtensionDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .modifierList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .extensionKeyword).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTypeSyntax.makeBlank(arena: arena).raw
    }
    if (layout[6] == nil) {
      layout[6] = RawMemberDeclBlockSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .extensionDecl,
                                   uninitializedCount: 7) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ExtensionDeclSyntax {
  /// Creates a `ExtensionDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ExtensionDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ExtensionDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ExtensionDeclSyntaxBuilder) -> Void) {
    var builder = ExtensionDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct MemberDeclBlockSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLeftBrace(_ node: TokenSyntax) {
    let idx = MemberDeclBlockSyntax.Cursor.leftBrace.rawValue
    layout[idx] = node.raw
  }

  public mutating func addMember(_ elt: MemberDeclListItemSyntax) {
    let idx = MemberDeclBlockSyntax.Cursor.members.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .memberDeclList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightBrace(_ node: TokenSyntax) {
    let idx = MemberDeclBlockSyntax.Cursor.rightBrace.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftBrace).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawMemberDeclListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightBrace).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .memberDeclBlock,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension MemberDeclBlockSyntax {
  /// Creates a `MemberDeclBlockSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `MemberDeclBlockSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `MemberDeclBlockSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout MemberDeclBlockSyntaxBuilder) -> Void) {
    var builder = MemberDeclBlockSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct MemberDeclListItemSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawDeclSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .memberDeclListItem,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension MemberDeclListItemSyntax {
  /// Creates a `MemberDeclListItemSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `MemberDeclListItemSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `MemberDeclListItemSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout MemberDeclListItemSyntaxBuilder) -> Void) {
    var builder = MemberDeclListItemSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct SourceFileSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addStatement(_ elt: CodeBlockItemSyntax) {
    let idx = SourceFileSyntax.Cursor.statements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .codeBlockItemList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useEOFToken(_ node: TokenSyntax) {
    let idx = SourceFileSyntax.Cursor.eofToken.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawCodeBlockItemListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .unknown).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .sourceFile,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension SourceFileSyntax {
  /// Creates a `SourceFileSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SourceFileSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SourceFileSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout SourceFileSyntaxBuilder) -> Void) {
    var builder = SourceFileSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct InitializerClauseSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .equal).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawExprSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .initializerClause,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension InitializerClauseSyntax {
  /// Creates a `InitializerClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `InitializerClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `InitializerClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout InitializerClauseSyntaxBuilder) -> Void) {
    var builder = InitializerClauseSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct FunctionParameterSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 8)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = FunctionParameterSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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

    let raw = RawSyntax.makeLayout(arena: arena, kind: .functionParameter,
                                   uninitializedCount: 8) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension FunctionParameterSyntax {
  /// Creates a `FunctionParameterSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FunctionParameterSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FunctionParameterSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout FunctionParameterSyntaxBuilder) -> Void) {
    var builder = FunctionParameterSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct FunctionDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 8)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = FunctionDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = FunctionDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .modifierList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .funcKeyword).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[5] == nil) {
      layout[5] = RawFunctionSignatureSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .functionDecl,
                                   uninitializedCount: 8) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension FunctionDeclSyntax {
  /// Creates a `FunctionDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FunctionDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FunctionDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout FunctionDeclSyntaxBuilder) -> Void) {
    var builder = FunctionDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct InitializerDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 8)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = InitializerDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = InitializerDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .modifierList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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

  public mutating func useSignature(_ node: FunctionSignatureSyntax) {
    let idx = InitializerDeclSyntax.Cursor.signature.rawValue
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
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .initKeyword).raw
    }
    if (layout[5] == nil) {
      layout[5] = RawFunctionSignatureSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .initializerDecl,
                                   uninitializedCount: 8) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension InitializerDeclSyntax {
  /// Creates a `InitializerDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `InitializerDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `InitializerDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout InitializerDeclSyntaxBuilder) -> Void) {
    var builder = InitializerDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct DeinitializerDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = DeinitializerDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = DeinitializerDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .modifierList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .deinitKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .deinitializerDecl,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension DeinitializerDeclSyntax {
  /// Creates a `DeinitializerDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DeinitializerDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DeinitializerDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout DeinitializerDeclSyntaxBuilder) -> Void) {
    var builder = DeinitializerDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct SubscriptDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 8)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = SubscriptDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = SubscriptDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .modifierList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .subscriptKeyword).raw
    }
    if (layout[4] == nil) {
      layout[4] = RawParameterClauseSyntax.makeBlank(arena: arena).raw
    }
    if (layout[5] == nil) {
      layout[5] = RawReturnClauseSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .subscriptDecl,
                                   uninitializedCount: 8) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension SubscriptDeclSyntax {
  /// Creates a `SubscriptDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SubscriptDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SubscriptDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout SubscriptDeclSyntaxBuilder) -> Void) {
    var builder = SubscriptDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct AccessLevelModifierSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useName(_ node: TokenSyntax) {
    let idx = AccessLevelModifierSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useModifier(_ node: DeclModifierDetailSyntax) {
    let idx = AccessLevelModifierSyntax.Cursor.modifier.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .accessLevelModifier,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension AccessLevelModifierSyntax {
  /// Creates a `AccessLevelModifierSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AccessLevelModifierSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AccessLevelModifierSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout AccessLevelModifierSyntaxBuilder) -> Void) {
    var builder = AccessLevelModifierSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct AccessPathComponentSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .accessPathComponent,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension AccessPathComponentSyntax {
  /// Creates a `AccessPathComponentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AccessPathComponentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AccessPathComponentSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout AccessPathComponentSyntaxBuilder) -> Void) {
    var builder = AccessPathComponentSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ImportDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 5)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = ImportDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = ImportDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .modifierList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .accessPath, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .importKeyword).raw
    }
    if (layout[4] == nil) {
      layout[4] = RawAccessPathSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .importDecl,
                                   uninitializedCount: 5) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ImportDeclSyntax {
  /// Creates a `ImportDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ImportDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ImportDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ImportDeclSyntaxBuilder) -> Void) {
    var builder = ImportDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct AccessorParameterSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .accessorParameter,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension AccessorParameterSyntax {
  /// Creates a `AccessorParameterSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AccessorParameterSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AccessorParameterSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout AccessorParameterSyntaxBuilder) -> Void) {
    var builder = AccessorParameterSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct AccessorDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 7)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = AccessorDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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

  public mutating func useAsyncKeyword(_ node: TokenSyntax) {
    let idx = AccessorDeclSyntax.Cursor.asyncKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useThrowsKeyword(_ node: TokenSyntax) {
    let idx = AccessorDeclSyntax.Cursor.throwsKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = AccessorDeclSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .unknown).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .accessorDecl,
                                   uninitializedCount: 7) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension AccessorDeclSyntax {
  /// Creates a `AccessorDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AccessorDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AccessorDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout AccessorDeclSyntaxBuilder) -> Void) {
    var builder = AccessorDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct AccessorBlockSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLeftBrace(_ node: TokenSyntax) {
    let idx = AccessorBlockSyntax.Cursor.leftBrace.rawValue
    layout[idx] = node.raw
  }

  public mutating func addAccessor(_ elt: AccessorDeclSyntax) {
    let idx = AccessorBlockSyntax.Cursor.accessors.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .accessorList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightBrace(_ node: TokenSyntax) {
    let idx = AccessorBlockSyntax.Cursor.rightBrace.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftBrace).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawAccessorListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightBrace).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .accessorBlock,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension AccessorBlockSyntax {
  /// Creates a `AccessorBlockSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AccessorBlockSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AccessorBlockSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout AccessorBlockSyntaxBuilder) -> Void) {
    var builder = AccessorBlockSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PatternBindingSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 5)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawPatternSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .patternBinding,
                                   uninitializedCount: 5) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PatternBindingSyntax {
  /// Creates a `PatternBindingSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PatternBindingSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PatternBindingSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PatternBindingSyntaxBuilder) -> Void) {
    var builder = PatternBindingSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct VariableDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = VariableDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = VariableDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .modifierList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useLetOrVarKeyword(_ node: TokenSyntax) {
    let idx = VariableDeclSyntax.Cursor.letOrVarKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addBinding(_ elt: PatternBindingSyntax) {
    let idx = VariableDeclSyntax.Cursor.bindings.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .patternBindingList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .letKeyword).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawPatternBindingListSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .variableDecl,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension VariableDeclSyntax {
  /// Creates a `VariableDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `VariableDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `VariableDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout VariableDeclSyntaxBuilder) -> Void) {
    var builder = VariableDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct EnumCaseElementSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .enumCaseElement,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension EnumCaseElementSyntax {
  /// Creates a `EnumCaseElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `EnumCaseElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `EnumCaseElementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout EnumCaseElementSyntaxBuilder) -> Void) {
    var builder = EnumCaseElementSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct EnumCaseDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = EnumCaseDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = EnumCaseDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .modifierList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useCaseKeyword(_ node: TokenSyntax) {
    let idx = EnumCaseDeclSyntax.Cursor.caseKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addElement(_ elt: EnumCaseElementSyntax) {
    let idx = EnumCaseDeclSyntax.Cursor.elements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .enumCaseElementList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .caseKeyword).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawEnumCaseElementListSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .enumCaseDecl,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension EnumCaseDeclSyntax {
  /// Creates a `EnumCaseDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `EnumCaseDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `EnumCaseDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout EnumCaseDeclSyntaxBuilder) -> Void) {
    var builder = EnumCaseDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct EnumDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 8)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = EnumDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = EnumDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .modifierList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .enumKeyword).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[7] == nil) {
      layout[7] = RawMemberDeclBlockSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .enumDecl,
                                   uninitializedCount: 8) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension EnumDeclSyntax {
  /// Creates a `EnumDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `EnumDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `EnumDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout EnumDeclSyntaxBuilder) -> Void) {
    var builder = EnumDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct OperatorDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 5)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = OperatorDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = OperatorDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .modifierList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .operatorKeyword).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .unspacedBinaryOperator).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .operatorDecl,
                                   uninitializedCount: 5) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension OperatorDeclSyntax {
  /// Creates a `OperatorDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `OperatorDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `OperatorDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout OperatorDeclSyntaxBuilder) -> Void) {
    var builder = OperatorDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct OperatorPrecedenceAndTypesSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = OperatorPrecedenceAndTypesSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func addPrecedenceGroupAndDesignatedType(_ elt: TokenSyntax) {
    let idx = OperatorPrecedenceAndTypesSyntax.Cursor.precedenceGroupAndDesignatedTypes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .identifierList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawIdentifierListSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .operatorPrecedenceAndTypes,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension OperatorPrecedenceAndTypesSyntax {
  /// Creates a `OperatorPrecedenceAndTypesSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `OperatorPrecedenceAndTypesSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `OperatorPrecedenceAndTypesSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout OperatorPrecedenceAndTypesSyntaxBuilder) -> Void) {
    var builder = OperatorPrecedenceAndTypesSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PrecedenceGroupDeclSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 7)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = PrecedenceGroupDeclSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func addModifier(_ elt: DeclModifierSyntax) {
    let idx = PrecedenceGroupDeclSyntax.Cursor.modifiers.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .modifierList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .precedenceGroupAttributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightBrace(_ node: TokenSyntax) {
    let idx = PrecedenceGroupDeclSyntax.Cursor.rightBrace.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .precedencegroupKeyword).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[4] == nil) {
      layout[4] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftBrace).raw
    }
    if (layout[5] == nil) {
      layout[5] = RawPrecedenceGroupAttributeListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[6] == nil) {
      layout[6] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightBrace).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .precedenceGroupDecl,
                                   uninitializedCount: 7) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PrecedenceGroupDeclSyntax {
  /// Creates a `PrecedenceGroupDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PrecedenceGroupDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PrecedenceGroupDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PrecedenceGroupDeclSyntaxBuilder) -> Void) {
    var builder = PrecedenceGroupDeclSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PrecedenceGroupRelationSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .precedenceGroupNameList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawPrecedenceGroupNameListSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .precedenceGroupRelation,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PrecedenceGroupRelationSyntax {
  /// Creates a `PrecedenceGroupRelationSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PrecedenceGroupRelationSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PrecedenceGroupRelationSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PrecedenceGroupRelationSyntaxBuilder) -> Void) {
    var builder = PrecedenceGroupRelationSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PrecedenceGroupNameElementSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .precedenceGroupNameElement,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PrecedenceGroupNameElementSyntax {
  /// Creates a `PrecedenceGroupNameElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PrecedenceGroupNameElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PrecedenceGroupNameElementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PrecedenceGroupNameElementSyntaxBuilder) -> Void) {
    var builder = PrecedenceGroupNameElementSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PrecedenceGroupAssignmentSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .trueKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .precedenceGroupAssignment,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PrecedenceGroupAssignmentSyntax {
  /// Creates a `PrecedenceGroupAssignmentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PrecedenceGroupAssignmentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PrecedenceGroupAssignmentSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PrecedenceGroupAssignmentSyntaxBuilder) -> Void) {
    var builder = PrecedenceGroupAssignmentSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PrecedenceGroupAssociativitySyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .precedenceGroupAssociativity,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PrecedenceGroupAssociativitySyntax {
  /// Creates a `PrecedenceGroupAssociativitySyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PrecedenceGroupAssociativitySyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PrecedenceGroupAssociativitySyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PrecedenceGroupAssociativitySyntaxBuilder) -> Void) {
    var builder = PrecedenceGroupAssociativitySyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct CustomAttributeSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 5)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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

  public mutating func addArgument(_ elt: TupleExprElementSyntax) {
    let idx = CustomAttributeSyntax.Cursor.argumentList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .tupleExprElementList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = CustomAttributeSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .atSign).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTypeSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .customAttribute,
                                   uninitializedCount: 5) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension CustomAttributeSyntax {
  /// Creates a `CustomAttributeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `CustomAttributeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `CustomAttributeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout CustomAttributeSyntaxBuilder) -> Void) {
    var builder = CustomAttributeSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct AttributeSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 6)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .tokenList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .atSign).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .unknown).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .attribute,
                                   uninitializedCount: 6) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension AttributeSyntax {
  /// Creates a `AttributeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AttributeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AttributeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout AttributeSyntaxBuilder) -> Void) {
    var builder = AttributeSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct AvailabilityEntrySyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLabel(_ node: TokenSyntax) {
    let idx = AvailabilityEntrySyntax.Cursor.label.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = AvailabilityEntrySyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func addAvailability(_ elt: AvailabilityArgumentSyntax) {
    let idx = AvailabilityEntrySyntax.Cursor.availabilityList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .availabilitySpecList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useSemicolon(_ node: TokenSyntax) {
    let idx = AvailabilityEntrySyntax.Cursor.semicolon.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawAvailabilitySpecListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .semicolon).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .availabilityEntry,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension AvailabilityEntrySyntax {
  /// Creates a `AvailabilityEntrySyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AvailabilityEntrySyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AvailabilityEntrySyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout AvailabilityEntrySyntaxBuilder) -> Void) {
    var builder = AvailabilityEntrySyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct LabeledSpecializeEntrySyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .unknown).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .labeledSpecializeEntry,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension LabeledSpecializeEntrySyntax {
  /// Creates a `LabeledSpecializeEntrySyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `LabeledSpecializeEntrySyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `LabeledSpecializeEntrySyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout LabeledSpecializeEntrySyntaxBuilder) -> Void) {
    var builder = LabeledSpecializeEntrySyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct TargetFunctionEntrySyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLabel(_ node: TokenSyntax) {
    let idx = TargetFunctionEntrySyntax.Cursor.label.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = TargetFunctionEntrySyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDeclname(_ node: DeclNameSyntax) {
    let idx = TargetFunctionEntrySyntax.Cursor.declname.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = TargetFunctionEntrySyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawDeclNameSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .targetFunctionEntry,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension TargetFunctionEntrySyntax {
  /// Creates a `TargetFunctionEntrySyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TargetFunctionEntrySyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TargetFunctionEntrySyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout TargetFunctionEntrySyntaxBuilder) -> Void) {
    var builder = TargetFunctionEntrySyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct NamedAttributeStringArgumentSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .unknown).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .namedAttributeStringArgument,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension NamedAttributeStringArgumentSyntax {
  /// Creates a `NamedAttributeStringArgumentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `NamedAttributeStringArgumentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `NamedAttributeStringArgumentSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout NamedAttributeStringArgumentSyntaxBuilder) -> Void) {
    var builder = NamedAttributeStringArgumentSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct DeclNameSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .declName,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension DeclNameSyntax {
  /// Creates a `DeclNameSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DeclNameSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DeclNameSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout DeclNameSyntaxBuilder) -> Void) {
    var builder = DeclNameSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ImplementsAttributeArgumentsSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawSimpleTypeIdentifierSyntax.makeBlank(arena: arena).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .comma).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .implementsAttributeArguments,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ImplementsAttributeArgumentsSyntax {
  /// Creates a `ImplementsAttributeArgumentsSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ImplementsAttributeArgumentsSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ImplementsAttributeArgumentsSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ImplementsAttributeArgumentsSyntaxBuilder) -> Void) {
    var builder = ImplementsAttributeArgumentsSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ObjCSelectorPieceSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useName(_ node: TokenSyntax) {
    let idx = ObjCSelectorPieceSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = ObjCSelectorPieceSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {

    let raw = RawSyntax.makeLayout(arena: arena, kind: .objCSelectorPiece,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ObjCSelectorPieceSyntax {
  /// Creates a `ObjCSelectorPieceSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ObjCSelectorPieceSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ObjCSelectorPieceSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ObjCSelectorPieceSyntaxBuilder) -> Void) {
    var builder = ObjCSelectorPieceSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct DifferentiableAttributeArgumentsSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 5)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useDiffKind(_ node: TokenSyntax) {
    let idx = DifferentiableAttributeArgumentsSyntax.Cursor.diffKind.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDiffKindComma(_ node: TokenSyntax) {
    let idx = DifferentiableAttributeArgumentsSyntax.Cursor.diffKindComma.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDiffParams(_ node: DifferentiabilityParamsClauseSyntax) {
    let idx = DifferentiableAttributeArgumentsSyntax.Cursor.diffParams.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDiffParamsComma(_ node: TokenSyntax) {
    let idx = DifferentiableAttributeArgumentsSyntax.Cursor.diffParamsComma.rawValue
    layout[idx] = node.raw
  }

  public mutating func useWhereClause(_ node: GenericWhereClauseSyntax) {
    let idx = DifferentiableAttributeArgumentsSyntax.Cursor.whereClause.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {

    let raw = RawSyntax.makeLayout(arena: arena, kind: .differentiableAttributeArguments,
                                   uninitializedCount: 5) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension DifferentiableAttributeArgumentsSyntax {
  /// Creates a `DifferentiableAttributeArgumentsSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DifferentiableAttributeArgumentsSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DifferentiableAttributeArgumentsSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout DifferentiableAttributeArgumentsSyntaxBuilder) -> Void) {
    var builder = DifferentiableAttributeArgumentsSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct DifferentiabilityParamsClauseSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useWrtLabel(_ node: TokenSyntax) {
    let idx = DifferentiabilityParamsClauseSyntax.Cursor.wrtLabel.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = DifferentiabilityParamsClauseSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useParameters(_ node: Syntax) {
    let idx = DifferentiabilityParamsClauseSyntax.Cursor.parameters.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .differentiabilityParamsClause,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension DifferentiabilityParamsClauseSyntax {
  /// Creates a `DifferentiabilityParamsClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DifferentiabilityParamsClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DifferentiabilityParamsClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout DifferentiabilityParamsClauseSyntaxBuilder) -> Void) {
    var builder = DifferentiabilityParamsClauseSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct DifferentiabilityParamsSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = DifferentiabilityParamsSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addDifferentiabilityParam(_ elt: DifferentiabilityParamSyntax) {
    let idx = DifferentiabilityParamsSyntax.Cursor.diffParams.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .differentiabilityParamList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = DifferentiabilityParamsSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawDifferentiabilityParamListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .differentiabilityParams,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension DifferentiabilityParamsSyntax {
  /// Creates a `DifferentiabilityParamsSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DifferentiabilityParamsSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DifferentiabilityParamsSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout DifferentiabilityParamsSyntaxBuilder) -> Void) {
    var builder = DifferentiabilityParamsSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct DifferentiabilityParamSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useParameter(_ node: Syntax) {
    let idx = DifferentiabilityParamSyntax.Cursor.parameter.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = DifferentiabilityParamSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .differentiabilityParam,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension DifferentiabilityParamSyntax {
  /// Creates a `DifferentiabilityParamSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DifferentiabilityParamSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DifferentiabilityParamSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout DifferentiabilityParamSyntaxBuilder) -> Void) {
    var builder = DifferentiabilityParamSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct DerivativeRegistrationAttributeArgumentsSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 7)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useOfLabel(_ node: TokenSyntax) {
    let idx = DerivativeRegistrationAttributeArgumentsSyntax.Cursor.ofLabel.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = DerivativeRegistrationAttributeArgumentsSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useOriginalDeclName(_ node: QualifiedDeclNameSyntax) {
    let idx = DerivativeRegistrationAttributeArgumentsSyntax.Cursor.originalDeclName.rawValue
    layout[idx] = node.raw
  }

  public mutating func usePeriod(_ node: TokenSyntax) {
    let idx = DerivativeRegistrationAttributeArgumentsSyntax.Cursor.period.rawValue
    layout[idx] = node.raw
  }

  public mutating func useAccessorKind(_ node: TokenSyntax) {
    let idx = DerivativeRegistrationAttributeArgumentsSyntax.Cursor.accessorKind.rawValue
    layout[idx] = node.raw
  }

  public mutating func useComma(_ node: TokenSyntax) {
    let idx = DerivativeRegistrationAttributeArgumentsSyntax.Cursor.comma.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDiffParams(_ node: DifferentiabilityParamsClauseSyntax) {
    let idx = DerivativeRegistrationAttributeArgumentsSyntax.Cursor.diffParams.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawQualifiedDeclNameSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .derivativeRegistrationAttributeArguments,
                                   uninitializedCount: 7) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension DerivativeRegistrationAttributeArgumentsSyntax {
  /// Creates a `DerivativeRegistrationAttributeArgumentsSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DerivativeRegistrationAttributeArgumentsSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DerivativeRegistrationAttributeArgumentsSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout DerivativeRegistrationAttributeArgumentsSyntaxBuilder) -> Void) {
    var builder = DerivativeRegistrationAttributeArgumentsSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct QualifiedDeclNameSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useBaseType(_ node: TypeSyntax) {
    let idx = QualifiedDeclNameSyntax.Cursor.baseType.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDot(_ node: TokenSyntax) {
    let idx = QualifiedDeclNameSyntax.Cursor.dot.rawValue
    layout[idx] = node.raw
  }

  public mutating func useName(_ node: TokenSyntax) {
    let idx = QualifiedDeclNameSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useArguments(_ node: DeclNameArgumentsSyntax) {
    let idx = QualifiedDeclNameSyntax.Cursor.arguments.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .qualifiedDeclName,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension QualifiedDeclNameSyntax {
  /// Creates a `QualifiedDeclNameSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `QualifiedDeclNameSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `QualifiedDeclNameSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout QualifiedDeclNameSyntaxBuilder) -> Void) {
    var builder = QualifiedDeclNameSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct FunctionDeclNameSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useName(_ node: Syntax) {
    let idx = FunctionDeclNameSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useArguments(_ node: DeclNameArgumentsSyntax) {
    let idx = FunctionDeclNameSyntax.Cursor.arguments.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .functionDeclName,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension FunctionDeclNameSyntax {
  /// Creates a `FunctionDeclNameSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FunctionDeclNameSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FunctionDeclNameSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout FunctionDeclNameSyntaxBuilder) -> Void) {
    var builder = FunctionDeclNameSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct BackDeployAttributeSpecListSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useBeforeLabel(_ node: TokenSyntax) {
    let idx = BackDeployAttributeSpecListSyntax.Cursor.beforeLabel.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = BackDeployAttributeSpecListSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func addAvailability(_ elt: BackDeployVersionArgumentSyntax) {
    let idx = BackDeployAttributeSpecListSyntax.Cursor.versionList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .backDeployVersionList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawBackDeployVersionListSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .backDeployAttributeSpecList,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension BackDeployAttributeSpecListSyntax {
  /// Creates a `BackDeployAttributeSpecListSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `BackDeployAttributeSpecListSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `BackDeployAttributeSpecListSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout BackDeployAttributeSpecListSyntaxBuilder) -> Void) {
    var builder = BackDeployAttributeSpecListSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct BackDeployVersionArgumentSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useAvailabilityVersionRestriction(_ node: AvailabilityVersionRestrictionSyntax) {
    let idx = BackDeployVersionArgumentSyntax.Cursor.availabilityVersionRestriction.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = BackDeployVersionArgumentSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawAvailabilityVersionRestrictionSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .backDeployVersionArgument,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension BackDeployVersionArgumentSyntax {
  /// Creates a `BackDeployVersionArgumentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `BackDeployVersionArgumentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `BackDeployVersionArgumentSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout BackDeployVersionArgumentSyntaxBuilder) -> Void) {
    var builder = BackDeployVersionArgumentSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ContinueStmtSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .continueKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .continueStmt,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ContinueStmtSyntax {
  /// Creates a `ContinueStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ContinueStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ContinueStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ContinueStmtSyntaxBuilder) -> Void) {
    var builder = ContinueStmtSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct WhileStmtSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 5)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .conditionElementList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = WhileStmtSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .whileKeyword).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawConditionElementListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[4] == nil) {
      layout[4] = RawCodeBlockSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .whileStmt,
                                   uninitializedCount: 5) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension WhileStmtSyntax {
  /// Creates a `WhileStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `WhileStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `WhileStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout WhileStmtSyntaxBuilder) -> Void) {
    var builder = WhileStmtSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct DeferStmtSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .deferKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawCodeBlockSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .deferStmt,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension DeferStmtSyntax {
  /// Creates a `DeferStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DeferStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DeferStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout DeferStmtSyntaxBuilder) -> Void) {
    var builder = DeferStmtSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ExpressionStmtSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = ExpressionStmtSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawExprSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .expressionStmt,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ExpressionStmtSyntax {
  /// Creates a `ExpressionStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ExpressionStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ExpressionStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ExpressionStmtSyntaxBuilder) -> Void) {
    var builder = ExpressionStmtSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct RepeatWhileStmtSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 6)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .repeatKeyword).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawCodeBlockSyntax.makeBlank(arena: arena).raw
    }
    if (layout[4] == nil) {
      layout[4] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .whileKeyword).raw
    }
    if (layout[5] == nil) {
      layout[5] = RawExprSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .repeatWhileStmt,
                                   uninitializedCount: 6) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension RepeatWhileStmtSyntax {
  /// Creates a `RepeatWhileStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `RepeatWhileStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `RepeatWhileStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout RepeatWhileStmtSyntaxBuilder) -> Void) {
    var builder = RepeatWhileStmtSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct GuardStmtSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useGuardKeyword(_ node: TokenSyntax) {
    let idx = GuardStmtSyntax.Cursor.guardKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addCondition(_ elt: ConditionElementSyntax) {
    let idx = GuardStmtSyntax.Cursor.conditions.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .conditionElementList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .guardKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawConditionElementListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .elseKeyword).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawCodeBlockSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .guardStmt,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension GuardStmtSyntax {
  /// Creates a `GuardStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `GuardStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `GuardStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout GuardStmtSyntaxBuilder) -> Void) {
    var builder = GuardStmtSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct WhereClauseSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .whereKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawExprSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .whereClause,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension WhereClauseSyntax {
  /// Creates a `WhereClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `WhereClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `WhereClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout WhereClauseSyntaxBuilder) -> Void) {
    var builder = WhereClauseSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ForInStmtSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 12)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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

  public mutating func useTryKeyword(_ node: TokenSyntax) {
    let idx = ForInStmtSyntax.Cursor.tryKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useAwaitKeyword(_ node: TokenSyntax) {
    let idx = ForInStmtSyntax.Cursor.awaitKeyword.rawValue
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
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .forKeyword).raw
    }
    if (layout[6] == nil) {
      layout[6] = RawPatternSyntax.makeBlank(arena: arena).raw
    }
    if (layout[8] == nil) {
      layout[8] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .inKeyword).raw
    }
    if (layout[9] == nil) {
      layout[9] = RawExprSyntax.makeBlank(arena: arena).raw
    }
    if (layout[11] == nil) {
      layout[11] = RawCodeBlockSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .forInStmt,
                                   uninitializedCount: 12) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ForInStmtSyntax {
  /// Creates a `ForInStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ForInStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ForInStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ForInStmtSyntaxBuilder) -> Void) {
    var builder = ForInStmtSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct SwitchStmtSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 7)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .switchCaseList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightBrace(_ node: TokenSyntax) {
    let idx = SwitchStmtSyntax.Cursor.rightBrace.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .switchKeyword).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawExprSyntax.makeBlank(arena: arena).raw
    }
    if (layout[4] == nil) {
      layout[4] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftBrace).raw
    }
    if (layout[5] == nil) {
      layout[5] = RawSwitchCaseListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[6] == nil) {
      layout[6] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightBrace).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .switchStmt,
                                   uninitializedCount: 7) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension SwitchStmtSyntax {
  /// Creates a `SwitchStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SwitchStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SwitchStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout SwitchStmtSyntaxBuilder) -> Void) {
    var builder = SwitchStmtSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct DoStmtSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 5)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .catchClauseList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .doKeyword).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawCodeBlockSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .doStmt,
                                   uninitializedCount: 5) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension DoStmtSyntax {
  /// Creates a `DoStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DoStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DoStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout DoStmtSyntaxBuilder) -> Void) {
    var builder = DoStmtSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ReturnStmtSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .returnKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .returnStmt,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ReturnStmtSyntax {
  /// Creates a `ReturnStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ReturnStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ReturnStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ReturnStmtSyntaxBuilder) -> Void) {
    var builder = ReturnStmtSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct YieldStmtSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .yield).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .yieldStmt,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension YieldStmtSyntax {
  /// Creates a `YieldStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `YieldStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `YieldStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout YieldStmtSyntaxBuilder) -> Void) {
    var builder = YieldStmtSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct YieldListSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = YieldListSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addElement(_ elt: ExprSyntax) {
    let idx = YieldListSyntax.Cursor.elementList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .exprList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawExprListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .yieldList,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension YieldListSyntax {
  /// Creates a `YieldListSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `YieldListSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `YieldListSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout YieldListSyntaxBuilder) -> Void) {
    var builder = YieldListSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct FallthroughStmtSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useFallthroughKeyword(_ node: TokenSyntax) {
    let idx = FallthroughStmtSyntax.Cursor.fallthroughKeyword.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .fallthroughKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .fallthroughStmt,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension FallthroughStmtSyntax {
  /// Creates a `FallthroughStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FallthroughStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FallthroughStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout FallthroughStmtSyntaxBuilder) -> Void) {
    var builder = FallthroughStmtSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct BreakStmtSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .breakKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .breakStmt,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension BreakStmtSyntax {
  /// Creates a `BreakStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `BreakStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `BreakStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout BreakStmtSyntaxBuilder) -> Void) {
    var builder = BreakStmtSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ConditionElementSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .conditionElement,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ConditionElementSyntax {
  /// Creates a `ConditionElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ConditionElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ConditionElementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ConditionElementSyntaxBuilder) -> Void) {
    var builder = ConditionElementSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct AvailabilityConditionSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .availabilitySpecList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = AvailabilityConditionSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundAvailableKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawAvailabilitySpecListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .availabilityCondition,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension AvailabilityConditionSyntax {
  /// Creates a `AvailabilityConditionSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AvailabilityConditionSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AvailabilityConditionSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout AvailabilityConditionSyntaxBuilder) -> Void) {
    var builder = AvailabilityConditionSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct MatchingPatternConditionSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .caseKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawPatternSyntax.makeBlank(arena: arena).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawInitializerClauseSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .matchingPatternCondition,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension MatchingPatternConditionSyntax {
  /// Creates a `MatchingPatternConditionSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `MatchingPatternConditionSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `MatchingPatternConditionSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout MatchingPatternConditionSyntaxBuilder) -> Void) {
    var builder = MatchingPatternConditionSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct OptionalBindingConditionSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .letKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawPatternSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .optionalBindingCondition,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension OptionalBindingConditionSyntax {
  /// Creates a `OptionalBindingConditionSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `OptionalBindingConditionSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `OptionalBindingConditionSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout OptionalBindingConditionSyntaxBuilder) -> Void) {
    var builder = OptionalBindingConditionSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct UnavailabilityConditionSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func usePoundUnavailableKeyword(_ node: TokenSyntax) {
    let idx = UnavailabilityConditionSyntax.Cursor.poundUnavailableKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = UnavailabilityConditionSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addAvailabilityArgument(_ elt: AvailabilityArgumentSyntax) {
    let idx = UnavailabilityConditionSyntax.Cursor.availabilitySpec.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .availabilitySpecList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = UnavailabilityConditionSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundUnavailableKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawAvailabilitySpecListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .unavailabilityCondition,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension UnavailabilityConditionSyntax {
  /// Creates a `UnavailabilityConditionSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `UnavailabilityConditionSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `UnavailabilityConditionSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout UnavailabilityConditionSyntaxBuilder) -> Void) {
    var builder = UnavailabilityConditionSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct DeclarationStmtSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useDeclaration(_ node: DeclSyntax) {
    let idx = DeclarationStmtSyntax.Cursor.declaration.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawDeclSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .declarationStmt,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension DeclarationStmtSyntax {
  /// Creates a `DeclarationStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DeclarationStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DeclarationStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout DeclarationStmtSyntaxBuilder) -> Void) {
    var builder = DeclarationStmtSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ThrowStmtSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .throwKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawExprSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .throwStmt,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ThrowStmtSyntax {
  /// Creates a `ThrowStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ThrowStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ThrowStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ThrowStmtSyntaxBuilder) -> Void) {
    var builder = ThrowStmtSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct IfStmtSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 7)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .conditionElementList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .ifKeyword).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawConditionElementListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[4] == nil) {
      layout[4] = RawCodeBlockSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .ifStmt,
                                   uninitializedCount: 7) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension IfStmtSyntax {
  /// Creates a `IfStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IfStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IfStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout IfStmtSyntaxBuilder) -> Void) {
    var builder = IfStmtSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ElseIfContinuationSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useIfStatement(_ node: IfStmtSyntax) {
    let idx = ElseIfContinuationSyntax.Cursor.ifStatement.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawIfStmtSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .elseIfContinuation,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ElseIfContinuationSyntax {
  /// Creates a `ElseIfContinuationSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ElseIfContinuationSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ElseIfContinuationSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ElseIfContinuationSyntaxBuilder) -> Void) {
    var builder = ElseIfContinuationSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ElseBlockSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .elseKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawCodeBlockSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .elseBlock,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ElseBlockSyntax {
  /// Creates a `ElseBlockSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ElseBlockSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ElseBlockSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ElseBlockSyntaxBuilder) -> Void) {
    var builder = ElseBlockSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct SwitchCaseSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .codeBlockItemList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[1] == nil) {
      layout[1] = RawSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawCodeBlockItemListSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .switchCase,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension SwitchCaseSyntax {
  /// Creates a `SwitchCaseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SwitchCaseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SwitchCaseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout SwitchCaseSyntaxBuilder) -> Void) {
    var builder = SwitchCaseSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct SwitchDefaultLabelSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .defaultKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .switchDefaultLabel,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension SwitchDefaultLabelSyntax {
  /// Creates a `SwitchDefaultLabelSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SwitchDefaultLabelSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SwitchDefaultLabelSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout SwitchDefaultLabelSyntaxBuilder) -> Void) {
    var builder = SwitchDefaultLabelSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct CaseItemSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawPatternSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .caseItem,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension CaseItemSyntax {
  /// Creates a `CaseItemSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `CaseItemSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `CaseItemSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout CaseItemSyntaxBuilder) -> Void) {
    var builder = CaseItemSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct CatchItemSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func usePattern(_ node: PatternSyntax) {
    let idx = CatchItemSyntax.Cursor.pattern.rawValue
    layout[idx] = node.raw
  }

  public mutating func useWhereClause(_ node: WhereClauseSyntax) {
    let idx = CatchItemSyntax.Cursor.whereClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = CatchItemSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {

    let raw = RawSyntax.makeLayout(arena: arena, kind: .catchItem,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension CatchItemSyntax {
  /// Creates a `CatchItemSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `CatchItemSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `CatchItemSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout CatchItemSyntaxBuilder) -> Void) {
    var builder = CatchItemSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct SwitchCaseLabelSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useCaseKeyword(_ node: TokenSyntax) {
    let idx = SwitchCaseLabelSyntax.Cursor.caseKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addCaseItem(_ elt: CaseItemSyntax) {
    let idx = SwitchCaseLabelSyntax.Cursor.caseItems.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .caseItemList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = SwitchCaseLabelSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .caseKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawCaseItemListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .switchCaseLabel,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension SwitchCaseLabelSyntax {
  /// Creates a `SwitchCaseLabelSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SwitchCaseLabelSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SwitchCaseLabelSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout SwitchCaseLabelSyntaxBuilder) -> Void) {
    var builder = SwitchCaseLabelSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct CatchClauseSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useCatchKeyword(_ node: TokenSyntax) {
    let idx = CatchClauseSyntax.Cursor.catchKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addCatchItem(_ elt: CatchItemSyntax) {
    let idx = CatchClauseSyntax.Cursor.catchItems.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .catchItemList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = CatchClauseSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .catchKeyword).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawCodeBlockSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .catchClause,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension CatchClauseSyntax {
  /// Creates a `CatchClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `CatchClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `CatchClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout CatchClauseSyntaxBuilder) -> Void) {
    var builder = CatchClauseSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PoundAssertStmtSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 6)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .poundAssertKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawExprSyntax.makeBlank(arena: arena).raw
    }
    if (layout[5] == nil) {
      layout[5] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundAssertStmt,
                                   uninitializedCount: 6) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PoundAssertStmtSyntax {
  /// Creates a `PoundAssertStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundAssertStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundAssertStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PoundAssertStmtSyntaxBuilder) -> Void) {
    var builder = PoundAssertStmtSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct GenericWhereClauseSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useWhereKeyword(_ node: TokenSyntax) {
    let idx = GenericWhereClauseSyntax.Cursor.whereKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addRequirement(_ elt: GenericRequirementSyntax) {
    let idx = GenericWhereClauseSyntax.Cursor.requirementList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .genericRequirementList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .whereKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawGenericRequirementListSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericWhereClause,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension GenericWhereClauseSyntax {
  /// Creates a `GenericWhereClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `GenericWhereClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `GenericWhereClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout GenericWhereClauseSyntaxBuilder) -> Void) {
    var builder = GenericWhereClauseSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct GenericRequirementSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useBody(_ node: Syntax) {
    let idx = GenericRequirementSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = GenericRequirementSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericRequirement,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension GenericRequirementSyntax {
  /// Creates a `GenericRequirementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `GenericRequirementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `GenericRequirementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout GenericRequirementSyntaxBuilder) -> Void) {
    var builder = GenericRequirementSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct SameTypeRequirementSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTypeSyntax.makeBlank(arena: arena).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .spacedBinaryOperator).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTypeSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .sameTypeRequirement,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension SameTypeRequirementSyntax {
  /// Creates a `SameTypeRequirementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SameTypeRequirementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SameTypeRequirementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout SameTypeRequirementSyntaxBuilder) -> Void) {
    var builder = SameTypeRequirementSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct GenericParameterSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 5)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = GenericParameterSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
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
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericParameter,
                                   uninitializedCount: 5) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension GenericParameterSyntax {
  /// Creates a `GenericParameterSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `GenericParameterSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `GenericParameterSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout GenericParameterSyntaxBuilder) -> Void) {
    var builder = GenericParameterSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PrimaryAssociatedTypeSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useName(_ node: TokenSyntax) {
    let idx = PrimaryAssociatedTypeSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = PrimaryAssociatedTypeSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .primaryAssociatedType,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PrimaryAssociatedTypeSyntax {
  /// Creates a `PrimaryAssociatedTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PrimaryAssociatedTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PrimaryAssociatedTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PrimaryAssociatedTypeSyntaxBuilder) -> Void) {
    var builder = PrimaryAssociatedTypeSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct GenericParameterClauseSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLeftAngleBracket(_ node: TokenSyntax) {
    let idx = GenericParameterClauseSyntax.Cursor.leftAngleBracket.rawValue
    layout[idx] = node.raw
  }

  public mutating func addGenericParameter(_ elt: GenericParameterSyntax) {
    let idx = GenericParameterClauseSyntax.Cursor.genericParameterList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .genericParameterList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightAngleBracket(_ node: TokenSyntax) {
    let idx = GenericParameterClauseSyntax.Cursor.rightAngleBracket.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftAngle).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawGenericParameterListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightAngle).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericParameterClause,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension GenericParameterClauseSyntax {
  /// Creates a `GenericParameterClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `GenericParameterClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `GenericParameterClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout GenericParameterClauseSyntaxBuilder) -> Void) {
    var builder = GenericParameterClauseSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ConformanceRequirementSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTypeSyntax.makeBlank(arena: arena).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTypeSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .conformanceRequirement,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ConformanceRequirementSyntax {
  /// Creates a `ConformanceRequirementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ConformanceRequirementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ConformanceRequirementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ConformanceRequirementSyntaxBuilder) -> Void) {
    var builder = ConformanceRequirementSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct PrimaryAssociatedTypeClauseSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLeftAngleBracket(_ node: TokenSyntax) {
    let idx = PrimaryAssociatedTypeClauseSyntax.Cursor.leftAngleBracket.rawValue
    layout[idx] = node.raw
  }

  public mutating func addPrimaryAssociatedType(_ elt: PrimaryAssociatedTypeSyntax) {
    let idx = PrimaryAssociatedTypeClauseSyntax.Cursor.primaryAssociatedTypeList.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .primaryAssociatedTypeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightAngleBracket(_ node: TokenSyntax) {
    let idx = PrimaryAssociatedTypeClauseSyntax.Cursor.rightAngleBracket.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftAngle).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawPrimaryAssociatedTypeListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightAngle).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .primaryAssociatedTypeClause,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension PrimaryAssociatedTypeClauseSyntax {
  /// Creates a `PrimaryAssociatedTypeClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PrimaryAssociatedTypeClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PrimaryAssociatedTypeClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout PrimaryAssociatedTypeClauseSyntaxBuilder) -> Void) {
    var builder = PrimaryAssociatedTypeClauseSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct SimpleTypeIdentifierSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .simpleTypeIdentifier,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension SimpleTypeIdentifierSyntax {
  /// Creates a `SimpleTypeIdentifierSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SimpleTypeIdentifierSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SimpleTypeIdentifierSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout SimpleTypeIdentifierSyntaxBuilder) -> Void) {
    var builder = SimpleTypeIdentifierSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct MemberTypeIdentifierSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTypeSyntax.makeBlank(arena: arena).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .period).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .memberTypeIdentifier,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension MemberTypeIdentifierSyntax {
  /// Creates a `MemberTypeIdentifierSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `MemberTypeIdentifierSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `MemberTypeIdentifierSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout MemberTypeIdentifierSyntaxBuilder) -> Void) {
    var builder = MemberTypeIdentifierSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ClassRestrictionTypeSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useClassKeyword(_ node: TokenSyntax) {
    let idx = ClassRestrictionTypeSyntax.Cursor.classKeyword.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .classKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .classRestrictionType,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ClassRestrictionTypeSyntax {
  /// Creates a `ClassRestrictionTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ClassRestrictionTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ClassRestrictionTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ClassRestrictionTypeSyntaxBuilder) -> Void) {
    var builder = ClassRestrictionTypeSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ArrayTypeSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftSquareBracket).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTypeSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightSquareBracket).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .arrayType,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ArrayTypeSyntax {
  /// Creates a `ArrayTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ArrayTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ArrayTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ArrayTypeSyntaxBuilder) -> Void) {
    var builder = ArrayTypeSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct DictionaryTypeSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 5)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftSquareBracket).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTypeSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[3] == nil) {
      layout[3] = RawTypeSyntax.makeBlank(arena: arena).raw
    }
    if (layout[4] == nil) {
      layout[4] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightSquareBracket).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .dictionaryType,
                                   uninitializedCount: 5) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension DictionaryTypeSyntax {
  /// Creates a `DictionaryTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DictionaryTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DictionaryTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout DictionaryTypeSyntaxBuilder) -> Void) {
    var builder = DictionaryTypeSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct MetatypeTypeSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTypeSyntax.makeBlank(arena: arena).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .period).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .metatypeType,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension MetatypeTypeSyntax {
  /// Creates a `MetatypeTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `MetatypeTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `MetatypeTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout MetatypeTypeSyntaxBuilder) -> Void) {
    var builder = MetatypeTypeSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct OptionalTypeSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTypeSyntax.makeBlank(arena: arena).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .postfixQuestionMark).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .optionalType,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension OptionalTypeSyntax {
  /// Creates a `OptionalTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `OptionalTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `OptionalTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout OptionalTypeSyntaxBuilder) -> Void) {
    var builder = OptionalTypeSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ConstrainedSugarTypeSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useSomeOrAnySpecifier(_ node: TokenSyntax) {
    let idx = ConstrainedSugarTypeSyntax.Cursor.someOrAnySpecifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBaseType(_ node: TypeSyntax) {
    let idx = ConstrainedSugarTypeSyntax.Cursor.baseType.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTypeSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .constrainedSugarType,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ConstrainedSugarTypeSyntax {
  /// Creates a `ConstrainedSugarTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ConstrainedSugarTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ConstrainedSugarTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ConstrainedSugarTypeSyntaxBuilder) -> Void) {
    var builder = ConstrainedSugarTypeSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ImplicitlyUnwrappedOptionalTypeSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTypeSyntax.makeBlank(arena: arena).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .exclamationMark).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .implicitlyUnwrappedOptionalType,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ImplicitlyUnwrappedOptionalTypeSyntax {
  /// Creates a `ImplicitlyUnwrappedOptionalTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ImplicitlyUnwrappedOptionalTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ImplicitlyUnwrappedOptionalTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ImplicitlyUnwrappedOptionalTypeSyntaxBuilder) -> Void) {
    var builder = ImplicitlyUnwrappedOptionalTypeSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct CompositionTypeElementSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTypeSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .compositionTypeElement,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension CompositionTypeElementSyntax {
  /// Creates a `CompositionTypeElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `CompositionTypeElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `CompositionTypeElementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout CompositionTypeElementSyntaxBuilder) -> Void) {
    var builder = CompositionTypeElementSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct CompositionTypeSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func addElement(_ elt: CompositionTypeElementSyntax) {
    let idx = CompositionTypeSyntax.Cursor.elements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .compositionTypeElementList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawCompositionTypeElementListSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .compositionType,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension CompositionTypeSyntax {
  /// Creates a `CompositionTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `CompositionTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `CompositionTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout CompositionTypeSyntaxBuilder) -> Void) {
    var builder = CompositionTypeSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct TupleTypeElementSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 8)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[4] = RawTypeSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .tupleTypeElement,
                                   uninitializedCount: 8) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension TupleTypeElementSyntax {
  /// Creates a `TupleTypeElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TupleTypeElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TupleTypeElementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout TupleTypeElementSyntaxBuilder) -> Void) {
    var builder = TupleTypeElementSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct TupleTypeSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = TupleTypeSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addElement(_ elt: TupleTypeElementSyntax) {
    let idx = TupleTypeSyntax.Cursor.elements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .tupleTypeElementList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = TupleTypeSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTupleTypeElementListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .tupleType,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension TupleTypeSyntax {
  /// Creates a `TupleTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TupleTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TupleTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout TupleTypeSyntaxBuilder) -> Void) {
    var builder = TupleTypeSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct FunctionTypeSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 7)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = FunctionTypeSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addArgument(_ elt: TupleTypeElementSyntax) {
    let idx = FunctionTypeSyntax.Cursor.arguments.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .tupleTypeElementList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = FunctionTypeSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func useAsyncKeyword(_ node: TokenSyntax) {
    let idx = FunctionTypeSyntax.Cursor.asyncKeyword.rawValue
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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTupleTypeElementListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw
    }
    if (layout[5] == nil) {
      layout[5] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .arrow).raw
    }
    if (layout[6] == nil) {
      layout[6] = RawTypeSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .functionType,
                                   uninitializedCount: 7) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension FunctionTypeSyntax {
  /// Creates a `FunctionTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FunctionTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FunctionTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout FunctionTypeSyntaxBuilder) -> Void) {
    var builder = FunctionTypeSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct AttributedTypeSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useSpecifier(_ node: TokenSyntax) {
    let idx = AttributedTypeSyntax.Cursor.specifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func addAttribute(_ elt: Syntax) {
    let idx = AttributedTypeSyntax.Cursor.attributes.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useBaseType(_ node: TypeSyntax) {
    let idx = AttributedTypeSyntax.Cursor.baseType.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[2] == nil) {
      layout[2] = RawTypeSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .attributedType,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension AttributedTypeSyntax {
  /// Creates a `AttributedTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AttributedTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AttributedTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout AttributedTypeSyntaxBuilder) -> Void) {
    var builder = AttributedTypeSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct GenericArgumentSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTypeSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericArgument,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension GenericArgumentSyntax {
  /// Creates a `GenericArgumentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `GenericArgumentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `GenericArgumentSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout GenericArgumentSyntaxBuilder) -> Void) {
    var builder = GenericArgumentSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct GenericArgumentClauseSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLeftAngleBracket(_ node: TokenSyntax) {
    let idx = GenericArgumentClauseSyntax.Cursor.leftAngleBracket.rawValue
    layout[idx] = node.raw
  }

  public mutating func addArgument(_ elt: GenericArgumentSyntax) {
    let idx = GenericArgumentClauseSyntax.Cursor.arguments.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .genericArgumentList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightAngleBracket(_ node: TokenSyntax) {
    let idx = GenericArgumentClauseSyntax.Cursor.rightAngleBracket.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftAngle).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawGenericArgumentListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightAngle).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericArgumentClause,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension GenericArgumentClauseSyntax {
  /// Creates a `GenericArgumentClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `GenericArgumentClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `GenericArgumentClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout GenericArgumentClauseSyntaxBuilder) -> Void) {
    var builder = GenericArgumentClauseSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct TypeAnnotationSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTypeSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .typeAnnotation,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension TypeAnnotationSyntax {
  /// Creates a `TypeAnnotationSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TypeAnnotationSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TypeAnnotationSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout TypeAnnotationSyntaxBuilder) -> Void) {
    var builder = TypeAnnotationSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct EnumCasePatternSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .period).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .enumCasePattern,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension EnumCasePatternSyntax {
  /// Creates a `EnumCasePatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `EnumCasePatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `EnumCasePatternSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout EnumCasePatternSyntaxBuilder) -> Void) {
    var builder = EnumCasePatternSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct IsTypePatternSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .isKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTypeSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .isTypePattern,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension IsTypePatternSyntax {
  /// Creates a `IsTypePatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IsTypePatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IsTypePatternSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout IsTypePatternSyntaxBuilder) -> Void) {
    var builder = IsTypePatternSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct OptionalPatternSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawPatternSyntax.makeBlank(arena: arena).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .postfixQuestionMark).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .optionalPattern,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension OptionalPatternSyntax {
  /// Creates a `OptionalPatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `OptionalPatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `OptionalPatternSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout OptionalPatternSyntaxBuilder) -> Void) {
    var builder = OptionalPatternSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct IdentifierPatternSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = IdentifierPatternSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .selfKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .identifierPattern,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension IdentifierPatternSyntax {
  /// Creates a `IdentifierPatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IdentifierPatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IdentifierPatternSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout IdentifierPatternSyntaxBuilder) -> Void) {
    var builder = IdentifierPatternSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct AsTypePatternSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawPatternSyntax.makeBlank(arena: arena).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .asKeyword).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTypeSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .asTypePattern,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension AsTypePatternSyntax {
  /// Creates a `AsTypePatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AsTypePatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AsTypePatternSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout AsTypePatternSyntaxBuilder) -> Void) {
    var builder = AsTypePatternSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct TuplePatternSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = TuplePatternSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addElement(_ elt: TuplePatternElementSyntax) {
    let idx = TuplePatternSyntax.Cursor.elements.rawValue
    if let list = layout[idx] {
      layout[idx] = list.insertingChild(elt.raw, at: list.children.count, arena: arena)
    } else {
      layout[idx] = RawSyntax.makeLayout(arena: arena, kind: .tuplePatternElementList, uninitializedCount: 1) { buffer in
        buffer.baseAddress!.initialize(to: elt.raw)
      }
    }
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = TuplePatternSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .leftParen).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTuplePatternElementListSyntax.makeBlank(arena: arena).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .rightParen).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .tuplePattern,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension TuplePatternSyntax {
  /// Creates a `TuplePatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TuplePatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TuplePatternSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout TuplePatternSyntaxBuilder) -> Void) {
    var builder = TuplePatternSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct WildcardPatternSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .wildcardKeyword).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .wildcardPattern,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension WildcardPatternSyntax {
  /// Creates a `WildcardPatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `WildcardPatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `WildcardPatternSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout WildcardPatternSyntaxBuilder) -> Void) {
    var builder = WildcardPatternSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct TuplePatternElementSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 4)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[2] = RawPatternSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .tuplePatternElement,
                                   uninitializedCount: 4) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension TuplePatternElementSyntax {
  /// Creates a `TuplePatternElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TuplePatternElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TuplePatternElementSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout TuplePatternElementSyntaxBuilder) -> Void) {
    var builder = TuplePatternElementSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ExpressionPatternSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 1)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = ExpressionPatternSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  internal mutating func buildData() -> SyntaxData {
    if (layout[0] == nil) {
      layout[0] = RawExprSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .expressionPattern,
                                   uninitializedCount: 1) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ExpressionPatternSyntax {
  /// Creates a `ExpressionPatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ExpressionPatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ExpressionPatternSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ExpressionPatternSyntaxBuilder) -> Void) {
    var builder = ExpressionPatternSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct ValueBindingPatternSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .letKeyword).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawPatternSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .valueBindingPattern,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension ValueBindingPatternSyntax {
  /// Creates a `ValueBindingPatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ValueBindingPatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ValueBindingPatternSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout ValueBindingPatternSyntaxBuilder) -> Void) {
    var builder = ValueBindingPatternSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct AvailabilityArgumentSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .availabilityArgument,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension AvailabilityArgumentSyntax {
  /// Creates a `AvailabilityArgumentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AvailabilityArgumentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AvailabilityArgumentSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout AvailabilityArgumentSyntaxBuilder) -> Void) {
    var builder = AvailabilityArgumentSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct AvailabilityLabeledArgumentSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }
    if (layout[1] == nil) {
      layout[1] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .colon).raw
    }
    if (layout[2] == nil) {
      layout[2] = RawSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .availabilityLabeledArgument,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension AvailabilityLabeledArgumentSyntax {
  /// Creates a `AvailabilityLabeledArgumentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AvailabilityLabeledArgumentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AvailabilityLabeledArgumentSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout AvailabilityLabeledArgumentSyntaxBuilder) -> Void) {
    var builder = AvailabilityLabeledArgumentSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct AvailabilityVersionRestrictionSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 2)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawTokenSyntax.makeBlank(arena: arena, tokenKind: .identifier).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .availabilityVersionRestriction,
                                   uninitializedCount: 2) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension AvailabilityVersionRestrictionSyntax {
  /// Creates a `AvailabilityVersionRestrictionSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AvailabilityVersionRestrictionSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AvailabilityVersionRestrictionSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout AvailabilityVersionRestrictionSyntaxBuilder) -> Void) {
    var builder = AvailabilityVersionRestrictionSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

public struct VersionTupleSyntaxBuilder {
  private var layout: [RawSyntax?] = .init(repeating: nil, count: 3)
  private var arena: SyntaxArena

  internal init(arena: SyntaxArena) { self.arena = arena }

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
      layout[0] = RawSyntax.makeBlank(arena: arena).raw
    }

    let raw = RawSyntax.makeLayout(arena: arena, kind: .versionTuple,
                                   uninitializedCount: 3) { buffer in
      _ = buffer.initialize(from: layout)
    }

    return SyntaxData(rootRaw: raw, arena: arena)
  }
}

extension VersionTupleSyntax {
  /// Creates a `VersionTupleSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that will be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `VersionTupleSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `VersionTupleSyntax` with all the fields populated in the builder
  ///            closure.
  public init(arena: SyntaxArena = .default, _ build: (inout VersionTupleSyntaxBuilder) -> Void) {
    var builder = VersionTupleSyntaxBuilder(arena: arena)
    build(&builder)
    let data = builder.buildData()
    self.init(data: data)
  }
}

