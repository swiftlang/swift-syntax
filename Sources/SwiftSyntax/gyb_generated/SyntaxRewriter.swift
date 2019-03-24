// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 6)
//// Automatically Generated From SyntaxFactory.swift.gyb.
//// Do Not Edit Directly!
//===------------ SyntaxRewriter.swift - Syntax Rewriter class ------------===//
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
//
// This file defines the SyntaxRewriter, a class that performs a standard walk
// and tree-rebuilding pattern.
//
// Subclassers of this class can override the walking behavior for any syntax
// node and transform nodes however they like.
//
//===----------------------------------------------------------------------===//

open class SyntaxRewriter {
  public init() {}
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: UnknownDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: UnknownExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: UnknownStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: UnknownTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: UnknownPatternSyntax) -> PatternSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! PatternSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: CodeBlockItemSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: CodeBlockItemListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: CodeBlockSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: InOutExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PoundColumnExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: FunctionCallArgumentListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TupleElementListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ArrayElementListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DictionaryElementListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: StringInterpolationSegmentsSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TryExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DeclNameArgumentSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DeclNameArgumentListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DeclNameArgumentsSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: IdentifierExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SuperRefExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: NilLiteralExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DiscardAssignmentExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AssignmentExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SequenceExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ExprListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PoundLineExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PoundFileExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PoundFunctionExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PoundDsohandleExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SymbolicReferenceExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PrefixOperatorExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: BinaryOperatorExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ArrowExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: FloatLiteralExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TupleExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ArrayExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DictionaryExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ImplicitMemberExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: FunctionCallArgumentSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TupleElementSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ArrayElementSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DictionaryElementSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: IntegerLiteralExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: StringLiteralExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: BooleanLiteralExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TernaryExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: MemberAccessExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DotSelfExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: IsExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AsExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TypeExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ClosureCaptureItemSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ClosureCaptureItemListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ClosureCaptureSignatureSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ClosureParamSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ClosureParamListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ClosureSignatureSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ClosureExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: UnresolvedPatternExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: FunctionCallExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SubscriptExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: OptionalChainingExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ForcedValueExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PostfixUnaryExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SpecializeExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: StringSegmentSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ExpressionSegmentSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: StringInterpolationExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: KeyPathExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: KeyPathBaseExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ObjcNamePieceSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ObjcNameSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ObjcKeyPathExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ObjcSelectorExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: EditorPlaceholderExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ObjectLiteralExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TypeInitializerClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TypealiasDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AssociatedtypeDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: FunctionParameterListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ParameterClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ReturnClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: FunctionSignatureSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: IfConfigClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: IfConfigClauseListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: IfConfigDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PoundErrorDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PoundWarningDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PoundSourceLocationSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PoundSourceLocationArgsSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DeclModifierSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: InheritedTypeSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: InheritedTypeListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TypeInheritanceClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ClassDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: StructDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ProtocolDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ExtensionDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: MemberDeclBlockSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: MemberDeclListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: MemberDeclListItemSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SourceFileSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: InitializerClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: FunctionParameterSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ModifierListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: InitializerDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DeinitializerDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SubscriptDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AccessLevelModifierSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AccessPathComponentSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AccessPathSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ImportDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AccessorParameterSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AccessorDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AccessorListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AccessorBlockSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PatternBindingSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PatternBindingListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: VariableDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: EnumCaseElementSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: EnumCaseElementListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: EnumCaseDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: EnumDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: OperatorDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: IdentifierListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: OperatorPrecedenceAndTypesSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PrecedenceGroupDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PrecedenceGroupAttributeListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PrecedenceGroupRelationSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PrecedenceGroupNameListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PrecedenceGroupNameElementSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PrecedenceGroupAssignmentSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PrecedenceGroupAssociativitySyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TokenListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: NonEmptyTokenListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AttributeSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AttributeListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SpecializeAttributeSpecListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: LabeledSpecializeEntrySyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: NamedAttributeStringArgumentSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DeclNameSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ImplementsAttributeArgumentsSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ObjCSelectorPieceSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ObjCSelectorSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ContinueStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: WhileStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DeferStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ExpressionStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SwitchCaseListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: RepeatWhileStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: GuardStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: WhereClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ForInStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SwitchStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: CatchClauseListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DoStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ReturnStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: YieldStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: YieldListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: FallthroughStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: BreakStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: CaseItemListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ConditionElementSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AvailabilityConditionSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: MatchingPatternConditionSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: OptionalBindingConditionSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ConditionElementListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DeclarationStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ThrowStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: IfStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ElseIfContinuationSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ElseBlockSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SwitchCaseSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SwitchDefaultLabelSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: CaseItemSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SwitchCaseLabelSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: CatchClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PoundAssertStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: GenericWhereClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: GenericRequirementListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SameTypeRequirementSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: GenericParameterListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: GenericParameterSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: GenericParameterClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ConformanceRequirementSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SimpleTypeIdentifierSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: MemberTypeIdentifierSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ClassRestrictionTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ArrayTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DictionaryTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: MetatypeTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: OptionalTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: CompositionTypeElementSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: CompositionTypeElementListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: CompositionTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TupleTypeElementSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TupleTypeElementListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TupleTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: FunctionTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AttributedTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: GenericArgumentListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: GenericArgumentSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: GenericArgumentClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TypeAnnotationSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: EnumCasePatternSyntax) -> PatternSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! PatternSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: IsTypePatternSyntax) -> PatternSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! PatternSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: OptionalPatternSyntax) -> PatternSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! PatternSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: IdentifierPatternSyntax) -> PatternSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! PatternSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AsTypePatternSyntax) -> PatternSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! PatternSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TuplePatternSyntax) -> PatternSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! PatternSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: WildcardPatternSyntax) -> PatternSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! PatternSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TuplePatternElementSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ExpressionPatternSyntax) -> PatternSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! PatternSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TuplePatternElementListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ValueBindingPatternSyntax) -> PatternSyntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! PatternSyntax
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AvailabilitySpecListSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AvailabilityArgumentSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AvailabilityLabeledArgumentSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AvailabilityVersionRestrictionSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: VersionTupleSyntax) -> Syntax {
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 39)

  open func visit(_ token: TokenSyntax) -> Syntax {
    return token
  }

  /// The function called before visiting the node and its descendents.
  ///   - node: the node we are about to visit.
  open func visitPre(_ node: Syntax) {}

  /// Override point to choose custom visitation dispatch instead of the
  /// specialized `visit(_:)` methods. Use this instead of those methods if
  /// you intend to dynamically dispatch rewriting behavior.
  /// - note: If this method returns a non-nil result, the specialized
  ///         `visit(_:)` methods will not be called for this node.
  open func visitAny(_ node: Syntax) -> Syntax? {
    return nil
  }

  /// The function called after visting the node and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: Syntax) {}

  public func visit(_ node: Syntax) -> Syntax {
    visitPre(node)
    defer { visitPost(node) }

    // If the global visitor returned non-nil, skip specialized dispatch.
    if let newNode = visitAny(node) {
      return newNode
    }

    switch node.raw.kind {
    case .token: return visit(node as! TokenSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .unknownDecl: return visit(node as! UnknownDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .unknownExpr: return visit(node as! UnknownExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .unknownStmt: return visit(node as! UnknownStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .unknownType: return visit(node as! UnknownTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .unknownPattern: return visit(node as! UnknownPatternSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .codeBlockItem: return visit(node as! CodeBlockItemSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .codeBlockItemList: return visit(node as! CodeBlockItemListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .codeBlock: return visit(node as! CodeBlockSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .inOutExpr: return visit(node as! InOutExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .poundColumnExpr: return visit(node as! PoundColumnExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .functionCallArgumentList: return visit(node as! FunctionCallArgumentListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tupleElementList: return visit(node as! TupleElementListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .arrayElementList: return visit(node as! ArrayElementListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .dictionaryElementList: return visit(node as! DictionaryElementListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .stringInterpolationSegments: return visit(node as! StringInterpolationSegmentsSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tryExpr: return visit(node as! TryExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .declNameArgument: return visit(node as! DeclNameArgumentSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .declNameArgumentList: return visit(node as! DeclNameArgumentListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .declNameArguments: return visit(node as! DeclNameArgumentsSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .identifierExpr: return visit(node as! IdentifierExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .superRefExpr: return visit(node as! SuperRefExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .nilLiteralExpr: return visit(node as! NilLiteralExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .discardAssignmentExpr: return visit(node as! DiscardAssignmentExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .assignmentExpr: return visit(node as! AssignmentExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .sequenceExpr: return visit(node as! SequenceExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .exprList: return visit(node as! ExprListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .poundLineExpr: return visit(node as! PoundLineExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .poundFileExpr: return visit(node as! PoundFileExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .poundFunctionExpr: return visit(node as! PoundFunctionExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .poundDsohandleExpr: return visit(node as! PoundDsohandleExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .symbolicReferenceExpr: return visit(node as! SymbolicReferenceExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .prefixOperatorExpr: return visit(node as! PrefixOperatorExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .binaryOperatorExpr: return visit(node as! BinaryOperatorExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .arrowExpr: return visit(node as! ArrowExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .floatLiteralExpr: return visit(node as! FloatLiteralExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tupleExpr: return visit(node as! TupleExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .arrayExpr: return visit(node as! ArrayExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .dictionaryExpr: return visit(node as! DictionaryExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .implicitMemberExpr: return visit(node as! ImplicitMemberExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .functionCallArgument: return visit(node as! FunctionCallArgumentSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tupleElement: return visit(node as! TupleElementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .arrayElement: return visit(node as! ArrayElementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .dictionaryElement: return visit(node as! DictionaryElementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .integerLiteralExpr: return visit(node as! IntegerLiteralExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .stringLiteralExpr: return visit(node as! StringLiteralExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .booleanLiteralExpr: return visit(node as! BooleanLiteralExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .ternaryExpr: return visit(node as! TernaryExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .memberAccessExpr: return visit(node as! MemberAccessExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .dotSelfExpr: return visit(node as! DotSelfExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .isExpr: return visit(node as! IsExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .asExpr: return visit(node as! AsExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .typeExpr: return visit(node as! TypeExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .closureCaptureItem: return visit(node as! ClosureCaptureItemSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .closureCaptureItemList: return visit(node as! ClosureCaptureItemListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .closureCaptureSignature: return visit(node as! ClosureCaptureSignatureSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .closureParam: return visit(node as! ClosureParamSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .closureParamList: return visit(node as! ClosureParamListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .closureSignature: return visit(node as! ClosureSignatureSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .closureExpr: return visit(node as! ClosureExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .unresolvedPatternExpr: return visit(node as! UnresolvedPatternExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .functionCallExpr: return visit(node as! FunctionCallExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .subscriptExpr: return visit(node as! SubscriptExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .optionalChainingExpr: return visit(node as! OptionalChainingExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .forcedValueExpr: return visit(node as! ForcedValueExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .postfixUnaryExpr: return visit(node as! PostfixUnaryExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .specializeExpr: return visit(node as! SpecializeExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .stringSegment: return visit(node as! StringSegmentSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .expressionSegment: return visit(node as! ExpressionSegmentSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .stringInterpolationExpr: return visit(node as! StringInterpolationExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .keyPathExpr: return visit(node as! KeyPathExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .keyPathBaseExpr: return visit(node as! KeyPathBaseExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .objcNamePiece: return visit(node as! ObjcNamePieceSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .objcName: return visit(node as! ObjcNameSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .objcKeyPathExpr: return visit(node as! ObjcKeyPathExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .objcSelectorExpr: return visit(node as! ObjcSelectorExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .editorPlaceholderExpr: return visit(node as! EditorPlaceholderExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .objectLiteralExpr: return visit(node as! ObjectLiteralExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .typeInitializerClause: return visit(node as! TypeInitializerClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .typealiasDecl: return visit(node as! TypealiasDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .associatedtypeDecl: return visit(node as! AssociatedtypeDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .functionParameterList: return visit(node as! FunctionParameterListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .parameterClause: return visit(node as! ParameterClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .returnClause: return visit(node as! ReturnClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .functionSignature: return visit(node as! FunctionSignatureSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .ifConfigClause: return visit(node as! IfConfigClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .ifConfigClauseList: return visit(node as! IfConfigClauseListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .ifConfigDecl: return visit(node as! IfConfigDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .poundErrorDecl: return visit(node as! PoundErrorDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .poundWarningDecl: return visit(node as! PoundWarningDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .poundSourceLocation: return visit(node as! PoundSourceLocationSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .poundSourceLocationArgs: return visit(node as! PoundSourceLocationArgsSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .declModifier: return visit(node as! DeclModifierSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .inheritedType: return visit(node as! InheritedTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .inheritedTypeList: return visit(node as! InheritedTypeListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .typeInheritanceClause: return visit(node as! TypeInheritanceClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .classDecl: return visit(node as! ClassDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .structDecl: return visit(node as! StructDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .protocolDecl: return visit(node as! ProtocolDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .extensionDecl: return visit(node as! ExtensionDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .memberDeclBlock: return visit(node as! MemberDeclBlockSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .memberDeclList: return visit(node as! MemberDeclListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .memberDeclListItem: return visit(node as! MemberDeclListItemSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .sourceFile: return visit(node as! SourceFileSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .initializerClause: return visit(node as! InitializerClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .functionParameter: return visit(node as! FunctionParameterSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .modifierList: return visit(node as! ModifierListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .functionDecl: return visit(node as! FunctionDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .initializerDecl: return visit(node as! InitializerDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .deinitializerDecl: return visit(node as! DeinitializerDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .subscriptDecl: return visit(node as! SubscriptDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .accessLevelModifier: return visit(node as! AccessLevelModifierSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .accessPathComponent: return visit(node as! AccessPathComponentSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .accessPath: return visit(node as! AccessPathSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .importDecl: return visit(node as! ImportDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .accessorParameter: return visit(node as! AccessorParameterSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .accessorDecl: return visit(node as! AccessorDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .accessorList: return visit(node as! AccessorListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .accessorBlock: return visit(node as! AccessorBlockSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .patternBinding: return visit(node as! PatternBindingSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .patternBindingList: return visit(node as! PatternBindingListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .variableDecl: return visit(node as! VariableDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .enumCaseElement: return visit(node as! EnumCaseElementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .enumCaseElementList: return visit(node as! EnumCaseElementListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .enumCaseDecl: return visit(node as! EnumCaseDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .enumDecl: return visit(node as! EnumDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .operatorDecl: return visit(node as! OperatorDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .identifierList: return visit(node as! IdentifierListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .operatorPrecedenceAndTypes: return visit(node as! OperatorPrecedenceAndTypesSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .precedenceGroupDecl: return visit(node as! PrecedenceGroupDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .precedenceGroupAttributeList: return visit(node as! PrecedenceGroupAttributeListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .precedenceGroupRelation: return visit(node as! PrecedenceGroupRelationSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .precedenceGroupNameList: return visit(node as! PrecedenceGroupNameListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .precedenceGroupNameElement: return visit(node as! PrecedenceGroupNameElementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .precedenceGroupAssignment: return visit(node as! PrecedenceGroupAssignmentSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .precedenceGroupAssociativity: return visit(node as! PrecedenceGroupAssociativitySyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tokenList: return visit(node as! TokenListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .nonEmptyTokenList: return visit(node as! NonEmptyTokenListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .attribute: return visit(node as! AttributeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .attributeList: return visit(node as! AttributeListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .specializeAttributeSpecList: return visit(node as! SpecializeAttributeSpecListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .labeledSpecializeEntry: return visit(node as! LabeledSpecializeEntrySyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .namedAttributeStringArgument: return visit(node as! NamedAttributeStringArgumentSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .declName: return visit(node as! DeclNameSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .implementsAttributeArguments: return visit(node as! ImplementsAttributeArgumentsSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .objCSelectorPiece: return visit(node as! ObjCSelectorPieceSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .objCSelector: return visit(node as! ObjCSelectorSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .continueStmt: return visit(node as! ContinueStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .whileStmt: return visit(node as! WhileStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .deferStmt: return visit(node as! DeferStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .expressionStmt: return visit(node as! ExpressionStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .switchCaseList: return visit(node as! SwitchCaseListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .repeatWhileStmt: return visit(node as! RepeatWhileStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .guardStmt: return visit(node as! GuardStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .whereClause: return visit(node as! WhereClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .forInStmt: return visit(node as! ForInStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .switchStmt: return visit(node as! SwitchStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .catchClauseList: return visit(node as! CatchClauseListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .doStmt: return visit(node as! DoStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .returnStmt: return visit(node as! ReturnStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .yieldStmt: return visit(node as! YieldStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .yieldList: return visit(node as! YieldListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .fallthroughStmt: return visit(node as! FallthroughStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .breakStmt: return visit(node as! BreakStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .caseItemList: return visit(node as! CaseItemListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .conditionElement: return visit(node as! ConditionElementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .availabilityCondition: return visit(node as! AvailabilityConditionSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .matchingPatternCondition: return visit(node as! MatchingPatternConditionSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .optionalBindingCondition: return visit(node as! OptionalBindingConditionSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .conditionElementList: return visit(node as! ConditionElementListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .declarationStmt: return visit(node as! DeclarationStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .throwStmt: return visit(node as! ThrowStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .ifStmt: return visit(node as! IfStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .elseIfContinuation: return visit(node as! ElseIfContinuationSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .elseBlock: return visit(node as! ElseBlockSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .switchCase: return visit(node as! SwitchCaseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .switchDefaultLabel: return visit(node as! SwitchDefaultLabelSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .caseItem: return visit(node as! CaseItemSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .switchCaseLabel: return visit(node as! SwitchCaseLabelSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .catchClause: return visit(node as! CatchClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .poundAssertStmt: return visit(node as! PoundAssertStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .genericWhereClause: return visit(node as! GenericWhereClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .genericRequirementList: return visit(node as! GenericRequirementListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .sameTypeRequirement: return visit(node as! SameTypeRequirementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .genericParameterList: return visit(node as! GenericParameterListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .genericParameter: return visit(node as! GenericParameterSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .genericParameterClause: return visit(node as! GenericParameterClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .conformanceRequirement: return visit(node as! ConformanceRequirementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .simpleTypeIdentifier: return visit(node as! SimpleTypeIdentifierSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .memberTypeIdentifier: return visit(node as! MemberTypeIdentifierSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .classRestrictionType: return visit(node as! ClassRestrictionTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .arrayType: return visit(node as! ArrayTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .dictionaryType: return visit(node as! DictionaryTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .metatypeType: return visit(node as! MetatypeTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .optionalType: return visit(node as! OptionalTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .implicitlyUnwrappedOptionalType: return visit(node as! ImplicitlyUnwrappedOptionalTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .compositionTypeElement: return visit(node as! CompositionTypeElementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .compositionTypeElementList: return visit(node as! CompositionTypeElementListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .compositionType: return visit(node as! CompositionTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tupleTypeElement: return visit(node as! TupleTypeElementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tupleTypeElementList: return visit(node as! TupleTypeElementListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tupleType: return visit(node as! TupleTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .functionType: return visit(node as! FunctionTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .attributedType: return visit(node as! AttributedTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .genericArgumentList: return visit(node as! GenericArgumentListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .genericArgument: return visit(node as! GenericArgumentSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .genericArgumentClause: return visit(node as! GenericArgumentClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .typeAnnotation: return visit(node as! TypeAnnotationSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .enumCasePattern: return visit(node as! EnumCasePatternSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .isTypePattern: return visit(node as! IsTypePatternSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .optionalPattern: return visit(node as! OptionalPatternSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .identifierPattern: return visit(node as! IdentifierPatternSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .asTypePattern: return visit(node as! AsTypePatternSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tuplePattern: return visit(node as! TuplePatternSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .wildcardPattern: return visit(node as! WildcardPatternSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tuplePatternElement: return visit(node as! TuplePatternElementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .expressionPattern: return visit(node as! ExpressionPatternSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tuplePatternElementList: return visit(node as! TuplePatternElementListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .valueBindingPattern: return visit(node as! ValueBindingPatternSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .availabilitySpecList: return visit(node as! AvailabilitySpecListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .availabilityArgument: return visit(node as! AvailabilityArgumentSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .availabilityLabeledArgument: return visit(node as! AvailabilityLabeledArgumentSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .availabilityVersionRestriction: return visit(node as! AvailabilityVersionRestrictionSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .versionTuple: return visit(node as! VersionTupleSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 77)
    default: return visitChildren(node)
    }
  }

  func visitChildren(_ node: Syntax) -> Syntax {
    // Visit all children of this node, returning `nil` if child is not
    // present. This will ensure that there are always the same number
    // of children after transforming.
    let newLayout = (0..<node.numberOfChildren).map { (i: Int) -> RawSyntax? in
      guard let child = node.child(at: i) else { return nil }
      return visit(child).raw
    }

    // Sanity check, ensure the new children are the same length.
    assert(newLayout.count == node.raw.layout.count)

    return makeSyntax(node.raw.replacingLayout(newLayout))
  }
}

/// The enum describes how the SyntaxVistor should continue after visiting
/// the current node.
public enum SyntaxVisitorContinueKind {

  /// The visitor should visit the descendents of the current node.
  case visitChildren

  /// The visitor should avoid visiting the descendents of the current node.
  case skipChildren
}

open class SyntaxVisitor {
    public init() {}
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting UnknownDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: UnknownDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting UnknownExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: UnknownExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting UnknownStmtSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: UnknownStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting UnknownTypeSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: UnknownTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting UnknownPatternSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: UnknownPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting CodeBlockItemSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CodeBlockItemSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting CodeBlockItemListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CodeBlockItemListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting CodeBlockSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CodeBlockSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting InOutExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: InOutExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PoundColumnExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundColumnExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting FunctionCallArgumentListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: FunctionCallArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting TupleElementListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TupleElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ArrayElementListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ArrayElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting DictionaryElementListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DictionaryElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting StringInterpolationSegmentsSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: StringInterpolationSegmentsSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting TryExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TryExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting DeclNameArgumentSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DeclNameArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting DeclNameArgumentListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DeclNameArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting DeclNameArgumentsSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DeclNameArgumentsSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting IdentifierExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IdentifierExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting SuperRefExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SuperRefExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting NilLiteralExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: NilLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting DiscardAssignmentExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DiscardAssignmentExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting AssignmentExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AssignmentExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting SequenceExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SequenceExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ExprListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ExprListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PoundLineExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundLineExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PoundFileExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundFileExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PoundFunctionExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundFunctionExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PoundDsohandleExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundDsohandleExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting SymbolicReferenceExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SymbolicReferenceExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PrefixOperatorExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PrefixOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting BinaryOperatorExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: BinaryOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ArrowExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ArrowExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting FloatLiteralExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: FloatLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting TupleExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TupleExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ArrayExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ArrayExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting DictionaryExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DictionaryExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ImplicitMemberExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ImplicitMemberExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting FunctionCallArgumentSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: FunctionCallArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting TupleElementSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TupleElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ArrayElementSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ArrayElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting DictionaryElementSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DictionaryElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting IntegerLiteralExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IntegerLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting StringLiteralExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting BooleanLiteralExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: BooleanLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting TernaryExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TernaryExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting MemberAccessExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MemberAccessExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting DotSelfExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DotSelfExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting IsExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IsExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting AsExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AsExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting TypeExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TypeExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ClosureCaptureItemSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ClosureCaptureItemSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ClosureCaptureItemListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ClosureCaptureItemListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ClosureCaptureSignatureSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ClosureCaptureSignatureSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ClosureParamSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ClosureParamSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ClosureParamListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ClosureParamListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ClosureSignatureSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ClosureSignatureSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ClosureExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ClosureExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting UnresolvedPatternExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: UnresolvedPatternExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting FunctionCallExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: FunctionCallExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting SubscriptExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SubscriptExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting OptionalChainingExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: OptionalChainingExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ForcedValueExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ForcedValueExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PostfixUnaryExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PostfixUnaryExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting SpecializeExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SpecializeExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting StringSegmentSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: StringSegmentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ExpressionSegmentSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ExpressionSegmentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting StringInterpolationExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: StringInterpolationExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting KeyPathExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: KeyPathExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting KeyPathBaseExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: KeyPathBaseExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ObjcNamePieceSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ObjcNamePieceSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ObjcNameSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ObjcNameSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ObjcKeyPathExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ObjcKeyPathExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ObjcSelectorExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ObjcSelectorExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting EditorPlaceholderExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: EditorPlaceholderExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ObjectLiteralExprSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ObjectLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting TypeInitializerClauseSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TypeInitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting TypealiasDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TypealiasDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting AssociatedtypeDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AssociatedtypeDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting FunctionParameterListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: FunctionParameterListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ParameterClauseSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ParameterClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ReturnClauseSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ReturnClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting FunctionSignatureSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: FunctionSignatureSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting IfConfigClauseSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IfConfigClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting IfConfigClauseListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IfConfigClauseListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting IfConfigDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PoundErrorDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundErrorDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PoundWarningDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundWarningDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PoundSourceLocationSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundSourceLocationSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PoundSourceLocationArgsSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundSourceLocationArgsSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting DeclModifierSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DeclModifierSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting InheritedTypeSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: InheritedTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting InheritedTypeListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: InheritedTypeListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting TypeInheritanceClauseSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TypeInheritanceClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ClassDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting StructDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ProtocolDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ExtensionDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ExtensionDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting MemberDeclBlockSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MemberDeclBlockSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting MemberDeclListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MemberDeclListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting MemberDeclListItemSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MemberDeclListItemSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting SourceFileSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SourceFileSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting InitializerClauseSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: InitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting FunctionParameterSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: FunctionParameterSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ModifierListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ModifierListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting FunctionDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting InitializerDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting DeinitializerDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DeinitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting SubscriptDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SubscriptDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting AccessLevelModifierSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AccessLevelModifierSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting AccessPathComponentSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AccessPathComponentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting AccessPathSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AccessPathSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ImportDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting AccessorParameterSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AccessorParameterSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting AccessorDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AccessorDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting AccessorListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AccessorListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting AccessorBlockSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AccessorBlockSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PatternBindingSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PatternBindingSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PatternBindingListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PatternBindingListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting VariableDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting EnumCaseElementSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: EnumCaseElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting EnumCaseElementListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: EnumCaseElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting EnumCaseDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: EnumCaseDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting EnumDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting OperatorDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: OperatorDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting IdentifierListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IdentifierListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting OperatorPrecedenceAndTypesSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: OperatorPrecedenceAndTypesSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PrecedenceGroupDeclSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PrecedenceGroupDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PrecedenceGroupAttributeListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PrecedenceGroupAttributeListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PrecedenceGroupRelationSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PrecedenceGroupRelationSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PrecedenceGroupNameListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PrecedenceGroupNameListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PrecedenceGroupNameElementSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PrecedenceGroupNameElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PrecedenceGroupAssignmentSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PrecedenceGroupAssignmentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PrecedenceGroupAssociativitySyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PrecedenceGroupAssociativitySyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting TokenListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TokenListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting NonEmptyTokenListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: NonEmptyTokenListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting AttributeSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AttributeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting AttributeListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AttributeListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting SpecializeAttributeSpecListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SpecializeAttributeSpecListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting LabeledSpecializeEntrySyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: LabeledSpecializeEntrySyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting NamedAttributeStringArgumentSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: NamedAttributeStringArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting DeclNameSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DeclNameSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ImplementsAttributeArgumentsSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ImplementsAttributeArgumentsSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ObjCSelectorPieceSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ObjCSelectorPieceSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ObjCSelectorSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ObjCSelectorSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ContinueStmtSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ContinueStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting WhileStmtSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: WhileStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting DeferStmtSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DeferStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ExpressionStmtSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ExpressionStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting SwitchCaseListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SwitchCaseListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting RepeatWhileStmtSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: RepeatWhileStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting GuardStmtSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: GuardStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting WhereClauseSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: WhereClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ForInStmtSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ForInStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting SwitchStmtSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SwitchStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting CatchClauseListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CatchClauseListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting DoStmtSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DoStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ReturnStmtSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ReturnStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting YieldStmtSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: YieldStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting YieldListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: YieldListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting FallthroughStmtSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: FallthroughStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting BreakStmtSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: BreakStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting CaseItemListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CaseItemListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ConditionElementSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ConditionElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting AvailabilityConditionSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AvailabilityConditionSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting MatchingPatternConditionSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MatchingPatternConditionSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting OptionalBindingConditionSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: OptionalBindingConditionSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ConditionElementListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ConditionElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting DeclarationStmtSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DeclarationStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ThrowStmtSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ThrowStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting IfStmtSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IfStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ElseIfContinuationSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ElseIfContinuationSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ElseBlockSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ElseBlockSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting SwitchCaseSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SwitchCaseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting SwitchDefaultLabelSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SwitchDefaultLabelSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting CaseItemSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CaseItemSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting SwitchCaseLabelSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SwitchCaseLabelSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting CatchClauseSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CatchClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting PoundAssertStmtSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundAssertStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting GenericWhereClauseSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: GenericWhereClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting GenericRequirementListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: GenericRequirementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting SameTypeRequirementSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SameTypeRequirementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting GenericParameterListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: GenericParameterListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting GenericParameterSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: GenericParameterSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting GenericParameterClauseSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: GenericParameterClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ConformanceRequirementSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ConformanceRequirementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting SimpleTypeIdentifierSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SimpleTypeIdentifierSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting MemberTypeIdentifierSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MemberTypeIdentifierSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ClassRestrictionTypeSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ClassRestrictionTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ArrayTypeSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ArrayTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting DictionaryTypeSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DictionaryTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting MetatypeTypeSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MetatypeTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting OptionalTypeSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: OptionalTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ImplicitlyUnwrappedOptionalTypeSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting CompositionTypeElementSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CompositionTypeElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting CompositionTypeElementListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CompositionTypeElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting CompositionTypeSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CompositionTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting TupleTypeElementSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TupleTypeElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting TupleTypeElementListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TupleTypeElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting TupleTypeSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TupleTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting FunctionTypeSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: FunctionTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting AttributedTypeSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AttributedTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting GenericArgumentListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: GenericArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting GenericArgumentSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: GenericArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting GenericArgumentClauseSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: GenericArgumentClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting TypeAnnotationSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TypeAnnotationSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting EnumCasePatternSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: EnumCasePatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting IsTypePatternSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IsTypePatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting OptionalPatternSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: OptionalPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting IdentifierPatternSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IdentifierPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting AsTypePatternSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AsTypePatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting TuplePatternSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TuplePatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting WildcardPatternSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: WildcardPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting TuplePatternElementSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TuplePatternElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ExpressionPatternSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ExpressionPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting TuplePatternElementListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TuplePatternElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting ValueBindingPatternSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ValueBindingPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting AvailabilitySpecListSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AvailabilitySpecListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting AvailabilityArgumentSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AvailabilityArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting AvailabilityLabeledArgumentSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AvailabilityLabeledArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting AvailabilityVersionRestrictionSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AvailabilityVersionRestrictionSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 112)
  /// Visting VersionTupleSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: VersionTupleSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 120)

  /// Visting UnknownSyntax specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: UnknownSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// Whether we should ever visit a given syntax kind.
  ///   - Parameter kind: the input kind we're checking.
  ///   - Returns: whether we should visit syntax nodes of this kind.
  open func shouldVisit(_ kind: SyntaxKind) -> Bool {
    return true
  }

  /// Whether we should ever visit a given token kind.
  ///   - Parameter kind: the input token kind we're checking.
  ///   - Returns: whether we should visit tokens of this kind.
  open func shouldVisit(_ kind: TokenKind) -> Bool {
    return true
  }

  open func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
    return .skipChildren
  }

  /// The function called before visiting the node and its descendents.
  ///   - node: the node we are about to visit.
  open func visitPre(_ node: Syntax) {}

  /// The function called after visting the node and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: Syntax) {}

  public func visit(_ node: Syntax) -> SyntaxVisitorContinueKind {
    switch node.raw.kind {
    case .token: return visit(node as! TokenSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .unknownDecl: return visit(node as! UnknownDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .unknownExpr: return visit(node as! UnknownExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .unknownStmt: return visit(node as! UnknownStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .unknownType: return visit(node as! UnknownTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .unknownPattern: return visit(node as! UnknownPatternSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .codeBlockItem: return visit(node as! CodeBlockItemSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .codeBlockItemList: return visit(node as! CodeBlockItemListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .codeBlock: return visit(node as! CodeBlockSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .inOutExpr: return visit(node as! InOutExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .poundColumnExpr: return visit(node as! PoundColumnExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .functionCallArgumentList: return visit(node as! FunctionCallArgumentListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .tupleElementList: return visit(node as! TupleElementListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .arrayElementList: return visit(node as! ArrayElementListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .dictionaryElementList: return visit(node as! DictionaryElementListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .stringInterpolationSegments: return visit(node as! StringInterpolationSegmentsSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .tryExpr: return visit(node as! TryExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .declNameArgument: return visit(node as! DeclNameArgumentSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .declNameArgumentList: return visit(node as! DeclNameArgumentListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .declNameArguments: return visit(node as! DeclNameArgumentsSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .identifierExpr: return visit(node as! IdentifierExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .superRefExpr: return visit(node as! SuperRefExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .nilLiteralExpr: return visit(node as! NilLiteralExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .discardAssignmentExpr: return visit(node as! DiscardAssignmentExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .assignmentExpr: return visit(node as! AssignmentExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .sequenceExpr: return visit(node as! SequenceExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .exprList: return visit(node as! ExprListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .poundLineExpr: return visit(node as! PoundLineExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .poundFileExpr: return visit(node as! PoundFileExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .poundFunctionExpr: return visit(node as! PoundFunctionExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .poundDsohandleExpr: return visit(node as! PoundDsohandleExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .symbolicReferenceExpr: return visit(node as! SymbolicReferenceExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .prefixOperatorExpr: return visit(node as! PrefixOperatorExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .binaryOperatorExpr: return visit(node as! BinaryOperatorExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .arrowExpr: return visit(node as! ArrowExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .floatLiteralExpr: return visit(node as! FloatLiteralExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .tupleExpr: return visit(node as! TupleExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .arrayExpr: return visit(node as! ArrayExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .dictionaryExpr: return visit(node as! DictionaryExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .implicitMemberExpr: return visit(node as! ImplicitMemberExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .functionCallArgument: return visit(node as! FunctionCallArgumentSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .tupleElement: return visit(node as! TupleElementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .arrayElement: return visit(node as! ArrayElementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .dictionaryElement: return visit(node as! DictionaryElementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .integerLiteralExpr: return visit(node as! IntegerLiteralExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .stringLiteralExpr: return visit(node as! StringLiteralExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .booleanLiteralExpr: return visit(node as! BooleanLiteralExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .ternaryExpr: return visit(node as! TernaryExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .memberAccessExpr: return visit(node as! MemberAccessExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .dotSelfExpr: return visit(node as! DotSelfExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .isExpr: return visit(node as! IsExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .asExpr: return visit(node as! AsExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .typeExpr: return visit(node as! TypeExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .closureCaptureItem: return visit(node as! ClosureCaptureItemSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .closureCaptureItemList: return visit(node as! ClosureCaptureItemListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .closureCaptureSignature: return visit(node as! ClosureCaptureSignatureSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .closureParam: return visit(node as! ClosureParamSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .closureParamList: return visit(node as! ClosureParamListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .closureSignature: return visit(node as! ClosureSignatureSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .closureExpr: return visit(node as! ClosureExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .unresolvedPatternExpr: return visit(node as! UnresolvedPatternExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .functionCallExpr: return visit(node as! FunctionCallExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .subscriptExpr: return visit(node as! SubscriptExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .optionalChainingExpr: return visit(node as! OptionalChainingExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .forcedValueExpr: return visit(node as! ForcedValueExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .postfixUnaryExpr: return visit(node as! PostfixUnaryExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .specializeExpr: return visit(node as! SpecializeExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .stringSegment: return visit(node as! StringSegmentSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .expressionSegment: return visit(node as! ExpressionSegmentSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .stringInterpolationExpr: return visit(node as! StringInterpolationExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .keyPathExpr: return visit(node as! KeyPathExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .keyPathBaseExpr: return visit(node as! KeyPathBaseExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .objcNamePiece: return visit(node as! ObjcNamePieceSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .objcName: return visit(node as! ObjcNameSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .objcKeyPathExpr: return visit(node as! ObjcKeyPathExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .objcSelectorExpr: return visit(node as! ObjcSelectorExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .editorPlaceholderExpr: return visit(node as! EditorPlaceholderExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .objectLiteralExpr: return visit(node as! ObjectLiteralExprSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .typeInitializerClause: return visit(node as! TypeInitializerClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .typealiasDecl: return visit(node as! TypealiasDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .associatedtypeDecl: return visit(node as! AssociatedtypeDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .functionParameterList: return visit(node as! FunctionParameterListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .parameterClause: return visit(node as! ParameterClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .returnClause: return visit(node as! ReturnClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .functionSignature: return visit(node as! FunctionSignatureSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .ifConfigClause: return visit(node as! IfConfigClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .ifConfigClauseList: return visit(node as! IfConfigClauseListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .ifConfigDecl: return visit(node as! IfConfigDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .poundErrorDecl: return visit(node as! PoundErrorDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .poundWarningDecl: return visit(node as! PoundWarningDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .poundSourceLocation: return visit(node as! PoundSourceLocationSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .poundSourceLocationArgs: return visit(node as! PoundSourceLocationArgsSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .declModifier: return visit(node as! DeclModifierSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .inheritedType: return visit(node as! InheritedTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .inheritedTypeList: return visit(node as! InheritedTypeListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .typeInheritanceClause: return visit(node as! TypeInheritanceClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .classDecl: return visit(node as! ClassDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .structDecl: return visit(node as! StructDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .protocolDecl: return visit(node as! ProtocolDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .extensionDecl: return visit(node as! ExtensionDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .memberDeclBlock: return visit(node as! MemberDeclBlockSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .memberDeclList: return visit(node as! MemberDeclListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .memberDeclListItem: return visit(node as! MemberDeclListItemSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .sourceFile: return visit(node as! SourceFileSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .initializerClause: return visit(node as! InitializerClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .functionParameter: return visit(node as! FunctionParameterSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .modifierList: return visit(node as! ModifierListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .functionDecl: return visit(node as! FunctionDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .initializerDecl: return visit(node as! InitializerDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .deinitializerDecl: return visit(node as! DeinitializerDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .subscriptDecl: return visit(node as! SubscriptDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .accessLevelModifier: return visit(node as! AccessLevelModifierSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .accessPathComponent: return visit(node as! AccessPathComponentSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .accessPath: return visit(node as! AccessPathSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .importDecl: return visit(node as! ImportDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .accessorParameter: return visit(node as! AccessorParameterSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .accessorDecl: return visit(node as! AccessorDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .accessorList: return visit(node as! AccessorListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .accessorBlock: return visit(node as! AccessorBlockSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .patternBinding: return visit(node as! PatternBindingSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .patternBindingList: return visit(node as! PatternBindingListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .variableDecl: return visit(node as! VariableDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .enumCaseElement: return visit(node as! EnumCaseElementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .enumCaseElementList: return visit(node as! EnumCaseElementListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .enumCaseDecl: return visit(node as! EnumCaseDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .enumDecl: return visit(node as! EnumDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .operatorDecl: return visit(node as! OperatorDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .identifierList: return visit(node as! IdentifierListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .operatorPrecedenceAndTypes: return visit(node as! OperatorPrecedenceAndTypesSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .precedenceGroupDecl: return visit(node as! PrecedenceGroupDeclSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .precedenceGroupAttributeList: return visit(node as! PrecedenceGroupAttributeListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .precedenceGroupRelation: return visit(node as! PrecedenceGroupRelationSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .precedenceGroupNameList: return visit(node as! PrecedenceGroupNameListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .precedenceGroupNameElement: return visit(node as! PrecedenceGroupNameElementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .precedenceGroupAssignment: return visit(node as! PrecedenceGroupAssignmentSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .precedenceGroupAssociativity: return visit(node as! PrecedenceGroupAssociativitySyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .tokenList: return visit(node as! TokenListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .nonEmptyTokenList: return visit(node as! NonEmptyTokenListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .attribute: return visit(node as! AttributeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .attributeList: return visit(node as! AttributeListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .specializeAttributeSpecList: return visit(node as! SpecializeAttributeSpecListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .labeledSpecializeEntry: return visit(node as! LabeledSpecializeEntrySyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .namedAttributeStringArgument: return visit(node as! NamedAttributeStringArgumentSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .declName: return visit(node as! DeclNameSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .implementsAttributeArguments: return visit(node as! ImplementsAttributeArgumentsSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .objCSelectorPiece: return visit(node as! ObjCSelectorPieceSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .objCSelector: return visit(node as! ObjCSelectorSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .continueStmt: return visit(node as! ContinueStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .whileStmt: return visit(node as! WhileStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .deferStmt: return visit(node as! DeferStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .expressionStmt: return visit(node as! ExpressionStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .switchCaseList: return visit(node as! SwitchCaseListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .repeatWhileStmt: return visit(node as! RepeatWhileStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .guardStmt: return visit(node as! GuardStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .whereClause: return visit(node as! WhereClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .forInStmt: return visit(node as! ForInStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .switchStmt: return visit(node as! SwitchStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .catchClauseList: return visit(node as! CatchClauseListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .doStmt: return visit(node as! DoStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .returnStmt: return visit(node as! ReturnStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .yieldStmt: return visit(node as! YieldStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .yieldList: return visit(node as! YieldListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .fallthroughStmt: return visit(node as! FallthroughStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .breakStmt: return visit(node as! BreakStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .caseItemList: return visit(node as! CaseItemListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .conditionElement: return visit(node as! ConditionElementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .availabilityCondition: return visit(node as! AvailabilityConditionSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .matchingPatternCondition: return visit(node as! MatchingPatternConditionSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .optionalBindingCondition: return visit(node as! OptionalBindingConditionSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .conditionElementList: return visit(node as! ConditionElementListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .declarationStmt: return visit(node as! DeclarationStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .throwStmt: return visit(node as! ThrowStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .ifStmt: return visit(node as! IfStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .elseIfContinuation: return visit(node as! ElseIfContinuationSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .elseBlock: return visit(node as! ElseBlockSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .switchCase: return visit(node as! SwitchCaseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .switchDefaultLabel: return visit(node as! SwitchDefaultLabelSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .caseItem: return visit(node as! CaseItemSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .switchCaseLabel: return visit(node as! SwitchCaseLabelSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .catchClause: return visit(node as! CatchClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .poundAssertStmt: return visit(node as! PoundAssertStmtSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .genericWhereClause: return visit(node as! GenericWhereClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .genericRequirementList: return visit(node as! GenericRequirementListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .sameTypeRequirement: return visit(node as! SameTypeRequirementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .genericParameterList: return visit(node as! GenericParameterListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .genericParameter: return visit(node as! GenericParameterSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .genericParameterClause: return visit(node as! GenericParameterClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .conformanceRequirement: return visit(node as! ConformanceRequirementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .simpleTypeIdentifier: return visit(node as! SimpleTypeIdentifierSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .memberTypeIdentifier: return visit(node as! MemberTypeIdentifierSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .classRestrictionType: return visit(node as! ClassRestrictionTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .arrayType: return visit(node as! ArrayTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .dictionaryType: return visit(node as! DictionaryTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .metatypeType: return visit(node as! MetatypeTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .optionalType: return visit(node as! OptionalTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .implicitlyUnwrappedOptionalType: return visit(node as! ImplicitlyUnwrappedOptionalTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .compositionTypeElement: return visit(node as! CompositionTypeElementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .compositionTypeElementList: return visit(node as! CompositionTypeElementListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .compositionType: return visit(node as! CompositionTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .tupleTypeElement: return visit(node as! TupleTypeElementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .tupleTypeElementList: return visit(node as! TupleTypeElementListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .tupleType: return visit(node as! TupleTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .functionType: return visit(node as! FunctionTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .attributedType: return visit(node as! AttributedTypeSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .genericArgumentList: return visit(node as! GenericArgumentListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .genericArgument: return visit(node as! GenericArgumentSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .genericArgumentClause: return visit(node as! GenericArgumentClauseSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .typeAnnotation: return visit(node as! TypeAnnotationSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .enumCasePattern: return visit(node as! EnumCasePatternSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .isTypePattern: return visit(node as! IsTypePatternSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .optionalPattern: return visit(node as! OptionalPatternSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .identifierPattern: return visit(node as! IdentifierPatternSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .asTypePattern: return visit(node as! AsTypePatternSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .tuplePattern: return visit(node as! TuplePatternSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .wildcardPattern: return visit(node as! WildcardPatternSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .tuplePatternElement: return visit(node as! TuplePatternElementSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .expressionPattern: return visit(node as! ExpressionPatternSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .tuplePatternElementList: return visit(node as! TuplePatternElementListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .valueBindingPattern: return visit(node as! ValueBindingPatternSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .availabilitySpecList: return visit(node as! AvailabilitySpecListSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .availabilityArgument: return visit(node as! AvailabilityArgumentSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .availabilityLabeledArgument: return visit(node as! AvailabilityLabeledArgumentSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .availabilityVersionRestriction: return visit(node as! AvailabilityVersionRestrictionSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 159)
    case .versionTuple: return visit(node as! VersionTupleSyntax)
// ###sourceLocation(file: "/private/tmp/ss/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 162)
    case .unknown: return visit(node as! UnknownSyntax)
    default: return .skipChildren
    }
  }
}


/// A wrapper over Syntax. A syntax node is only realized when explicitly asked;
/// otherwise the node is represented as a child index list from a realized
/// ancestor.
class PendingSyntaxNode {
  let parent: PendingSyntaxNode!
  private var kind: PendingSyntaxNodeKind

  private enum PendingSyntaxNodeKind {
    /// We already have a `Syntax` node realised for this node
    case realized(node: Syntax)
    /// This node does not have a `Syntax` node instantiated yet. If needed, we
    /// need to compute it from its parent RawSyntax node
    case virtual(index: Int)
  }

  var node: Syntax {
    switch kind {
    case .realized(let node):
      return node
    case .virtual(let index):
      let _node = parent.node.child(at: index)!
      kind = .realized(node: _node)
      return _node
    }
  }

  init(_ root: Syntax) {
    self.parent = nil
    self.kind = .realized(node: root)
  }

  init(_ parent: PendingSyntaxNode, _ idx: Int) {
    self.parent = parent
    self.kind = .virtual(index: idx)
  }
}


/// The raw syntax walker traverses the raw syntax tree to find
/// node kinds the SyntaxVisitor is interested and feed these syntax nodes to
/// SyntaxVisitor.
/// By traversing the raw syntax tree, we avoid realizing syntax nodes that're
/// not interesting to users' SyntaxVisitor.
class RawSyntaxVisitor {
  private let visitor: SyntaxVisitor
  private var currentNode: PendingSyntaxNode!

  required init(_ visitor: SyntaxVisitor, _ root: Syntax) {
    self.visitor = visitor
    self.currentNode = PendingSyntaxNode(root)
  }

  func shouldVisit(_ kind: SyntaxKind) -> Bool {
    return visitor.shouldVisit(kind)
  }

  func shouldVisit(_ kind: TokenKind) -> Bool {
    return visitor.shouldVisit(kind)
  }

  func addChildIdx(_ idx: Int) {
    currentNode = PendingSyntaxNode(currentNode, idx)
  }

  func moveUp() {
    currentNode = currentNode.parent
  }

  func visitPre() {
    visitor.visitPre(currentNode.node)
  }

  func visitPost() {
    visitor.visitPost(currentNode.node)
  }

  // The current raw syntax node is interesting for the user, so realize a
  // correponding syntax node and feed it into the visitor.
  func visit() -> SyntaxVisitorContinueKind {
    return visitor.visit(currentNode.node)
  }
}

extension Syntax {
  public func walk(_ visitor: SyntaxVisitor) {

    // Traverse the raw syntax tree by using the current syntax node as root.
    data.raw.accept(RawSyntaxVisitor(visitor, self))
  }
}

public enum SyntaxVerifierError: Error, CustomStringConvertible {
  case unknownSyntaxFound(node: Syntax)

  public var description: String {
    switch self {
      case .unknownSyntaxFound(let node):
        return "unknown syntax node for \"\(node)\""
    }
  }
}

public class SyntaxVerifier: SyntaxVisitor {

  var unknownNodes: [Syntax] = []

  override public func shouldVisit(_ node: SyntaxKind) -> Bool {
    return node.isUnknown
  }

  override public func shouldVisit(_ node: TokenKind) -> Bool {
    return false
  }

  override public func visitPre(_ node: Syntax) {
    assert(node.isUnknown)
    unknownNodes.append(node)
  }

  private func verify(_ node: Syntax) throws {
    node.walk(self)
    if let unknownNode = unknownNodes.first {
      throw SyntaxVerifierError.unknownSyntaxFound(node: unknownNode)
    }
  }

  private override init() {}

  public static func verify(_ node: Syntax) throws {
    try SyntaxVerifier().verify(node)
  }
}
