// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 6)
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
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: UnknownDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: UnknownExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: UnknownStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: UnknownTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: UnknownPatternSyntax) -> PatternSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! PatternSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: CodeBlockItemSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: CodeBlockItemListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: CodeBlockSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: InOutExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PoundColumnExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: FunctionCallArgumentListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TupleElementListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ArrayElementListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DictionaryElementListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: StringInterpolationSegmentsSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TryExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DeclNameArgumentSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DeclNameArgumentListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DeclNameArgumentsSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: IdentifierExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SuperRefExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: NilLiteralExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DiscardAssignmentExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AssignmentExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SequenceExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ExprListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PoundLineExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PoundFileExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PoundFunctionExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PoundDsohandleExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SymbolicReferenceExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PrefixOperatorExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: BinaryOperatorExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ArrowExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: FloatLiteralExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TupleExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ArrayExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DictionaryExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ImplicitMemberExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: FunctionCallArgumentSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TupleElementSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ArrayElementSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DictionaryElementSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: IntegerLiteralExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: StringLiteralExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: BooleanLiteralExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TernaryExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: MemberAccessExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DotSelfExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: IsExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AsExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TypeExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ClosureCaptureItemSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ClosureCaptureItemListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ClosureCaptureSignatureSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ClosureParamSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ClosureParamListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ClosureSignatureSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ClosureExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: UnresolvedPatternExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: FunctionCallExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SubscriptExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: OptionalChainingExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ForcedValueExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PostfixUnaryExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SpecializeExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: StringSegmentSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ExpressionSegmentSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: StringInterpolationExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: KeyPathExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: KeyPathBaseExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ObjcNamePieceSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ObjcNameSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ObjcKeyPathExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ObjcSelectorExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: EditorPlaceholderExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ObjectLiteralExprSyntax) -> ExprSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! ExprSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TypeInitializerClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TypealiasDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AssociatedtypeDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: FunctionParameterListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ParameterClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ReturnClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: FunctionSignatureSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: IfConfigClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: IfConfigClauseListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: IfConfigDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PoundErrorDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PoundWarningDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PoundSourceLocationSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PoundSourceLocationArgsSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DeclModifierSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: InheritedTypeSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: InheritedTypeListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TypeInheritanceClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ClassDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: StructDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ProtocolDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ExtensionDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: MemberDeclBlockSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: MemberDeclListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: MemberDeclListItemSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SourceFileSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: InitializerClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: FunctionParameterSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ModifierListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: InitializerDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DeinitializerDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SubscriptDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AccessLevelModifierSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AccessPathComponentSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AccessPathSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ImportDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AccessorParameterSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AccessorDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AccessorListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AccessorBlockSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PatternBindingSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PatternBindingListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: VariableDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: EnumCaseElementSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: EnumCaseElementListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: EnumCaseDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: EnumDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: OperatorDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: InfixOperatorGroupSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PrecedenceGroupDeclSyntax) -> DeclSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! DeclSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PrecedenceGroupAttributeListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PrecedenceGroupRelationSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PrecedenceGroupNameListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PrecedenceGroupNameElementSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PrecedenceGroupAssignmentSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: PrecedenceGroupAssociativitySyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TokenListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: NonEmptyTokenListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AttributeSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AttributeListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SpecializeAttributeSpecListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: LabeledSpecializeEntrySyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ImplementsAttributeArgumentsSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ObjCSelectorPieceSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ObjCSelectorSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ContinueStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: WhileStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DeferStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ExpressionStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SwitchCaseListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: RepeatWhileStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: GuardStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: WhereClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ForInStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SwitchStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: CatchClauseListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DoStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ReturnStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: YieldStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: FallthroughStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: BreakStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: CaseItemListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ConditionElementSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AvailabilityConditionSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: MatchingPatternConditionSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: OptionalBindingConditionSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ConditionElementListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DeclarationStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ThrowStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: IfStmtSyntax) -> StmtSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! StmtSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ElseIfContinuationSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ElseBlockSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SwitchCaseSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SwitchDefaultLabelSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: CaseItemSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SwitchCaseLabelSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: CatchClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: GenericWhereClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: GenericRequirementListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SameTypeRequirementSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: GenericParameterListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: GenericParameterSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: GenericParameterClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ConformanceRequirementSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: SimpleTypeIdentifierSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: MemberTypeIdentifierSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ClassRestrictionTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ArrayTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: DictionaryTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: MetatypeTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: OptionalTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: CompositionTypeElementSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: CompositionTypeElementListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: CompositionTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TupleTypeElementSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TupleTypeElementListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TupleTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: FunctionTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AttributedTypeSyntax) -> TypeSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! TypeSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: GenericArgumentListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: GenericArgumentSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: GenericArgumentClauseSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TypeAnnotationSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: EnumCasePatternSyntax) -> PatternSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! PatternSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: IsTypePatternSyntax) -> PatternSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! PatternSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: OptionalPatternSyntax) -> PatternSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! PatternSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: IdentifierPatternSyntax) -> PatternSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! PatternSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AsTypePatternSyntax) -> PatternSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! PatternSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TuplePatternSyntax) -> PatternSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! PatternSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: WildcardPatternSyntax) -> PatternSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! PatternSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TuplePatternElementSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ExpressionPatternSyntax) -> PatternSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! PatternSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: TuplePatternElementListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: ValueBindingPatternSyntax) -> PatternSyntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) as! PatternSyntax
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AvailabilitySpecListSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AvailabilityArgumentSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AvailabilityLabeledArgumentSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: AvailabilityVersionRestrictionSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 32)
  open func visit(_ node: VersionTupleSyntax) -> Syntax {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 34)
    return visitChildren(node) 
  }

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 39)

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
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .unknownDecl: return visit(node as! UnknownDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .unknownExpr: return visit(node as! UnknownExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .unknownStmt: return visit(node as! UnknownStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .unknownType: return visit(node as! UnknownTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .unknownPattern: return visit(node as! UnknownPatternSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .codeBlockItem: return visit(node as! CodeBlockItemSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .codeBlockItemList: return visit(node as! CodeBlockItemListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .codeBlock: return visit(node as! CodeBlockSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .inOutExpr: return visit(node as! InOutExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .poundColumnExpr: return visit(node as! PoundColumnExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .functionCallArgumentList: return visit(node as! FunctionCallArgumentListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tupleElementList: return visit(node as! TupleElementListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .arrayElementList: return visit(node as! ArrayElementListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .dictionaryElementList: return visit(node as! DictionaryElementListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .stringInterpolationSegments: return visit(node as! StringInterpolationSegmentsSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tryExpr: return visit(node as! TryExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .declNameArgument: return visit(node as! DeclNameArgumentSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .declNameArgumentList: return visit(node as! DeclNameArgumentListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .declNameArguments: return visit(node as! DeclNameArgumentsSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .identifierExpr: return visit(node as! IdentifierExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .superRefExpr: return visit(node as! SuperRefExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .nilLiteralExpr: return visit(node as! NilLiteralExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .discardAssignmentExpr: return visit(node as! DiscardAssignmentExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .assignmentExpr: return visit(node as! AssignmentExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .sequenceExpr: return visit(node as! SequenceExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .exprList: return visit(node as! ExprListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .poundLineExpr: return visit(node as! PoundLineExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .poundFileExpr: return visit(node as! PoundFileExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .poundFunctionExpr: return visit(node as! PoundFunctionExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .poundDsohandleExpr: return visit(node as! PoundDsohandleExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .symbolicReferenceExpr: return visit(node as! SymbolicReferenceExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .prefixOperatorExpr: return visit(node as! PrefixOperatorExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .binaryOperatorExpr: return visit(node as! BinaryOperatorExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .arrowExpr: return visit(node as! ArrowExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .floatLiteralExpr: return visit(node as! FloatLiteralExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tupleExpr: return visit(node as! TupleExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .arrayExpr: return visit(node as! ArrayExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .dictionaryExpr: return visit(node as! DictionaryExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .implicitMemberExpr: return visit(node as! ImplicitMemberExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .functionCallArgument: return visit(node as! FunctionCallArgumentSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tupleElement: return visit(node as! TupleElementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .arrayElement: return visit(node as! ArrayElementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .dictionaryElement: return visit(node as! DictionaryElementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .integerLiteralExpr: return visit(node as! IntegerLiteralExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .stringLiteralExpr: return visit(node as! StringLiteralExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .booleanLiteralExpr: return visit(node as! BooleanLiteralExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .ternaryExpr: return visit(node as! TernaryExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .memberAccessExpr: return visit(node as! MemberAccessExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .dotSelfExpr: return visit(node as! DotSelfExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .isExpr: return visit(node as! IsExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .asExpr: return visit(node as! AsExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .typeExpr: return visit(node as! TypeExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .closureCaptureItem: return visit(node as! ClosureCaptureItemSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .closureCaptureItemList: return visit(node as! ClosureCaptureItemListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .closureCaptureSignature: return visit(node as! ClosureCaptureSignatureSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .closureParam: return visit(node as! ClosureParamSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .closureParamList: return visit(node as! ClosureParamListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .closureSignature: return visit(node as! ClosureSignatureSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .closureExpr: return visit(node as! ClosureExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .unresolvedPatternExpr: return visit(node as! UnresolvedPatternExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .functionCallExpr: return visit(node as! FunctionCallExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .subscriptExpr: return visit(node as! SubscriptExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .optionalChainingExpr: return visit(node as! OptionalChainingExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .forcedValueExpr: return visit(node as! ForcedValueExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .postfixUnaryExpr: return visit(node as! PostfixUnaryExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .specializeExpr: return visit(node as! SpecializeExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .stringSegment: return visit(node as! StringSegmentSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .expressionSegment: return visit(node as! ExpressionSegmentSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .stringInterpolationExpr: return visit(node as! StringInterpolationExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .keyPathExpr: return visit(node as! KeyPathExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .keyPathBaseExpr: return visit(node as! KeyPathBaseExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .objcNamePiece: return visit(node as! ObjcNamePieceSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .objcName: return visit(node as! ObjcNameSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .objcKeyPathExpr: return visit(node as! ObjcKeyPathExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .objcSelectorExpr: return visit(node as! ObjcSelectorExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .editorPlaceholderExpr: return visit(node as! EditorPlaceholderExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .objectLiteralExpr: return visit(node as! ObjectLiteralExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .typeInitializerClause: return visit(node as! TypeInitializerClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .typealiasDecl: return visit(node as! TypealiasDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .associatedtypeDecl: return visit(node as! AssociatedtypeDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .functionParameterList: return visit(node as! FunctionParameterListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .parameterClause: return visit(node as! ParameterClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .returnClause: return visit(node as! ReturnClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .functionSignature: return visit(node as! FunctionSignatureSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .ifConfigClause: return visit(node as! IfConfigClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .ifConfigClauseList: return visit(node as! IfConfigClauseListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .ifConfigDecl: return visit(node as! IfConfigDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .poundErrorDecl: return visit(node as! PoundErrorDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .poundWarningDecl: return visit(node as! PoundWarningDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .poundSourceLocation: return visit(node as! PoundSourceLocationSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .poundSourceLocationArgs: return visit(node as! PoundSourceLocationArgsSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .declModifier: return visit(node as! DeclModifierSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .inheritedType: return visit(node as! InheritedTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .inheritedTypeList: return visit(node as! InheritedTypeListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .typeInheritanceClause: return visit(node as! TypeInheritanceClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .classDecl: return visit(node as! ClassDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .structDecl: return visit(node as! StructDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .protocolDecl: return visit(node as! ProtocolDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .extensionDecl: return visit(node as! ExtensionDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .memberDeclBlock: return visit(node as! MemberDeclBlockSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .memberDeclList: return visit(node as! MemberDeclListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .memberDeclListItem: return visit(node as! MemberDeclListItemSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .sourceFile: return visit(node as! SourceFileSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .initializerClause: return visit(node as! InitializerClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .functionParameter: return visit(node as! FunctionParameterSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .modifierList: return visit(node as! ModifierListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .functionDecl: return visit(node as! FunctionDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .initializerDecl: return visit(node as! InitializerDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .deinitializerDecl: return visit(node as! DeinitializerDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .subscriptDecl: return visit(node as! SubscriptDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .accessLevelModifier: return visit(node as! AccessLevelModifierSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .accessPathComponent: return visit(node as! AccessPathComponentSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .accessPath: return visit(node as! AccessPathSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .importDecl: return visit(node as! ImportDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .accessorParameter: return visit(node as! AccessorParameterSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .accessorDecl: return visit(node as! AccessorDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .accessorList: return visit(node as! AccessorListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .accessorBlock: return visit(node as! AccessorBlockSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .patternBinding: return visit(node as! PatternBindingSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .patternBindingList: return visit(node as! PatternBindingListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .variableDecl: return visit(node as! VariableDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .enumCaseElement: return visit(node as! EnumCaseElementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .enumCaseElementList: return visit(node as! EnumCaseElementListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .enumCaseDecl: return visit(node as! EnumCaseDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .enumDecl: return visit(node as! EnumDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .operatorDecl: return visit(node as! OperatorDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .infixOperatorGroup: return visit(node as! InfixOperatorGroupSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .precedenceGroupDecl: return visit(node as! PrecedenceGroupDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .precedenceGroupAttributeList: return visit(node as! PrecedenceGroupAttributeListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .precedenceGroupRelation: return visit(node as! PrecedenceGroupRelationSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .precedenceGroupNameList: return visit(node as! PrecedenceGroupNameListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .precedenceGroupNameElement: return visit(node as! PrecedenceGroupNameElementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .precedenceGroupAssignment: return visit(node as! PrecedenceGroupAssignmentSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .precedenceGroupAssociativity: return visit(node as! PrecedenceGroupAssociativitySyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tokenList: return visit(node as! TokenListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .nonEmptyTokenList: return visit(node as! NonEmptyTokenListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .attribute: return visit(node as! AttributeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .attributeList: return visit(node as! AttributeListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .specializeAttributeSpecList: return visit(node as! SpecializeAttributeSpecListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .labeledSpecializeEntry: return visit(node as! LabeledSpecializeEntrySyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .implementsAttributeArguments: return visit(node as! ImplementsAttributeArgumentsSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .objCSelectorPiece: return visit(node as! ObjCSelectorPieceSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .objCSelector: return visit(node as! ObjCSelectorSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .continueStmt: return visit(node as! ContinueStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .whileStmt: return visit(node as! WhileStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .deferStmt: return visit(node as! DeferStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .expressionStmt: return visit(node as! ExpressionStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .switchCaseList: return visit(node as! SwitchCaseListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .repeatWhileStmt: return visit(node as! RepeatWhileStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .guardStmt: return visit(node as! GuardStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .whereClause: return visit(node as! WhereClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .forInStmt: return visit(node as! ForInStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .switchStmt: return visit(node as! SwitchStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .catchClauseList: return visit(node as! CatchClauseListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .doStmt: return visit(node as! DoStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .returnStmt: return visit(node as! ReturnStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .yieldStmt: return visit(node as! YieldStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .fallthroughStmt: return visit(node as! FallthroughStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .breakStmt: return visit(node as! BreakStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .caseItemList: return visit(node as! CaseItemListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .conditionElement: return visit(node as! ConditionElementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .availabilityCondition: return visit(node as! AvailabilityConditionSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .matchingPatternCondition: return visit(node as! MatchingPatternConditionSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .optionalBindingCondition: return visit(node as! OptionalBindingConditionSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .conditionElementList: return visit(node as! ConditionElementListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .declarationStmt: return visit(node as! DeclarationStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .throwStmt: return visit(node as! ThrowStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .ifStmt: return visit(node as! IfStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .elseIfContinuation: return visit(node as! ElseIfContinuationSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .elseBlock: return visit(node as! ElseBlockSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .switchCase: return visit(node as! SwitchCaseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .switchDefaultLabel: return visit(node as! SwitchDefaultLabelSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .caseItem: return visit(node as! CaseItemSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .switchCaseLabel: return visit(node as! SwitchCaseLabelSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .catchClause: return visit(node as! CatchClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .genericWhereClause: return visit(node as! GenericWhereClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .genericRequirementList: return visit(node as! GenericRequirementListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .sameTypeRequirement: return visit(node as! SameTypeRequirementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .genericParameterList: return visit(node as! GenericParameterListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .genericParameter: return visit(node as! GenericParameterSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .genericParameterClause: return visit(node as! GenericParameterClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .conformanceRequirement: return visit(node as! ConformanceRequirementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .simpleTypeIdentifier: return visit(node as! SimpleTypeIdentifierSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .memberTypeIdentifier: return visit(node as! MemberTypeIdentifierSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .classRestrictionType: return visit(node as! ClassRestrictionTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .arrayType: return visit(node as! ArrayTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .dictionaryType: return visit(node as! DictionaryTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .metatypeType: return visit(node as! MetatypeTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .optionalType: return visit(node as! OptionalTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .implicitlyUnwrappedOptionalType: return visit(node as! ImplicitlyUnwrappedOptionalTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .compositionTypeElement: return visit(node as! CompositionTypeElementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .compositionTypeElementList: return visit(node as! CompositionTypeElementListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .compositionType: return visit(node as! CompositionTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tupleTypeElement: return visit(node as! TupleTypeElementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tupleTypeElementList: return visit(node as! TupleTypeElementListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tupleType: return visit(node as! TupleTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .functionType: return visit(node as! FunctionTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .attributedType: return visit(node as! AttributedTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .genericArgumentList: return visit(node as! GenericArgumentListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .genericArgument: return visit(node as! GenericArgumentSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .genericArgumentClause: return visit(node as! GenericArgumentClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .typeAnnotation: return visit(node as! TypeAnnotationSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .enumCasePattern: return visit(node as! EnumCasePatternSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .isTypePattern: return visit(node as! IsTypePatternSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .optionalPattern: return visit(node as! OptionalPatternSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .identifierPattern: return visit(node as! IdentifierPatternSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .asTypePattern: return visit(node as! AsTypePatternSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tuplePattern: return visit(node as! TuplePatternSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .wildcardPattern: return visit(node as! WildcardPatternSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tuplePatternElement: return visit(node as! TuplePatternElementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .expressionPattern: return visit(node as! ExpressionPatternSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .tuplePatternElementList: return visit(node as! TuplePatternElementListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .valueBindingPattern: return visit(node as! ValueBindingPatternSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .availabilitySpecList: return visit(node as! AvailabilitySpecListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .availabilityArgument: return visit(node as! AvailabilityArgumentSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .availabilityLabeledArgument: return visit(node as! AvailabilityLabeledArgumentSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .availabilityVersionRestriction: return visit(node as! AvailabilityVersionRestrictionSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 74)
    case .versionTuple: return visit(node as! VersionTupleSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 77)
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

open class SyntaxVisitor {
    public init() {}
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: UnknownDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: UnknownExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: UnknownStmtSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: UnknownTypeSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: UnknownPatternSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: CodeBlockItemSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: CodeBlockItemListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: CodeBlockSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: InOutExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: PoundColumnExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: FunctionCallArgumentListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: TupleElementListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ArrayElementListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: DictionaryElementListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: StringInterpolationSegmentsSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: TryExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: DeclNameArgumentSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: DeclNameArgumentListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: DeclNameArgumentsSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: IdentifierExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: SuperRefExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: NilLiteralExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: DiscardAssignmentExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: AssignmentExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: SequenceExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ExprListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: PoundLineExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: PoundFileExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: PoundFunctionExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: PoundDsohandleExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: SymbolicReferenceExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: PrefixOperatorExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: BinaryOperatorExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ArrowExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: FloatLiteralExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: TupleExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ArrayExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: DictionaryExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ImplicitMemberExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: FunctionCallArgumentSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: TupleElementSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ArrayElementSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: DictionaryElementSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: IntegerLiteralExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: StringLiteralExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: BooleanLiteralExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: TernaryExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: MemberAccessExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: DotSelfExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: IsExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: AsExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: TypeExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ClosureCaptureItemSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ClosureCaptureItemListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ClosureCaptureSignatureSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ClosureParamSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ClosureParamListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ClosureSignatureSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ClosureExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: UnresolvedPatternExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: FunctionCallExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: SubscriptExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: OptionalChainingExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ForcedValueExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: PostfixUnaryExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: SpecializeExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: StringSegmentSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ExpressionSegmentSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: StringInterpolationExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: KeyPathExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: KeyPathBaseExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ObjcNamePieceSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ObjcNameSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ObjcKeyPathExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ObjcSelectorExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: EditorPlaceholderExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ObjectLiteralExprSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: TypeInitializerClauseSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: TypealiasDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: AssociatedtypeDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: FunctionParameterListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ParameterClauseSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ReturnClauseSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: FunctionSignatureSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: IfConfigClauseSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: IfConfigClauseListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: IfConfigDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: PoundErrorDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: PoundWarningDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: PoundSourceLocationSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: PoundSourceLocationArgsSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: DeclModifierSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: InheritedTypeSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: InheritedTypeListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: TypeInheritanceClauseSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ClassDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: StructDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ProtocolDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ExtensionDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: MemberDeclBlockSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: MemberDeclListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: MemberDeclListItemSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: SourceFileSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: InitializerClauseSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: FunctionParameterSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ModifierListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: FunctionDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: InitializerDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: DeinitializerDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: SubscriptDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: AccessLevelModifierSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: AccessPathComponentSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: AccessPathSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ImportDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: AccessorParameterSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: AccessorDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: AccessorListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: AccessorBlockSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: PatternBindingSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: PatternBindingListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: VariableDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: EnumCaseElementSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: EnumCaseElementListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: EnumCaseDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: EnumDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: OperatorDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: InfixOperatorGroupSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: PrecedenceGroupDeclSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: PrecedenceGroupAttributeListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: PrecedenceGroupRelationSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: PrecedenceGroupNameListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: PrecedenceGroupNameElementSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: PrecedenceGroupAssignmentSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: PrecedenceGroupAssociativitySyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: TokenListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: NonEmptyTokenListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: AttributeSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: AttributeListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: SpecializeAttributeSpecListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: LabeledSpecializeEntrySyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ImplementsAttributeArgumentsSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ObjCSelectorPieceSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ObjCSelectorSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ContinueStmtSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: WhileStmtSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: DeferStmtSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ExpressionStmtSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: SwitchCaseListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: RepeatWhileStmtSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: GuardStmtSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: WhereClauseSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ForInStmtSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: SwitchStmtSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: CatchClauseListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: DoStmtSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ReturnStmtSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: YieldStmtSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: FallthroughStmtSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: BreakStmtSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: CaseItemListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ConditionElementSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: AvailabilityConditionSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: MatchingPatternConditionSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: OptionalBindingConditionSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ConditionElementListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: DeclarationStmtSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ThrowStmtSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: IfStmtSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ElseIfContinuationSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ElseBlockSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: SwitchCaseSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: SwitchDefaultLabelSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: CaseItemSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: SwitchCaseLabelSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: CatchClauseSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: GenericWhereClauseSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: GenericRequirementListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: SameTypeRequirementSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: GenericParameterListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: GenericParameterSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: GenericParameterClauseSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ConformanceRequirementSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: SimpleTypeIdentifierSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: MemberTypeIdentifierSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ClassRestrictionTypeSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ArrayTypeSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: DictionaryTypeSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: MetatypeTypeSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: OptionalTypeSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: CompositionTypeElementSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: CompositionTypeElementListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: CompositionTypeSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: TupleTypeElementSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: TupleTypeElementListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: TupleTypeSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: FunctionTypeSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: AttributedTypeSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: GenericArgumentListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: GenericArgumentSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: GenericArgumentClauseSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: TypeAnnotationSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: EnumCasePatternSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: IsTypePatternSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: OptionalPatternSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: IdentifierPatternSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: AsTypePatternSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: TuplePatternSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: WildcardPatternSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: TuplePatternElementSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ExpressionPatternSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: TuplePatternElementListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: ValueBindingPatternSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: AvailabilitySpecListSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: AvailabilityArgumentSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: AvailabilityLabeledArgumentSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: AvailabilityVersionRestrictionSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 101)
  open func visit(_ node: VersionTupleSyntax) {
    visitChildren(node)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 106)

  open func visit(_ token: TokenSyntax) {}

  /// The function called before visiting the node and its descendents.
  ///   - node: the node we are about to visit.
  open func visitPre(_ node: Syntax) {}

  /// The function called after visting the node and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: Syntax) {}

  public func visit(_ node: Syntax) {
    visitPre(node)
    defer { visitPost(node) }
    switch node.raw.kind {
    case .token: visit(node as! TokenSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .unknownDecl: visit(node as! UnknownDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .unknownExpr: visit(node as! UnknownExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .unknownStmt: visit(node as! UnknownStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .unknownType: visit(node as! UnknownTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .unknownPattern: visit(node as! UnknownPatternSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .codeBlockItem: visit(node as! CodeBlockItemSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .codeBlockItemList: visit(node as! CodeBlockItemListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .codeBlock: visit(node as! CodeBlockSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .inOutExpr: visit(node as! InOutExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .poundColumnExpr: visit(node as! PoundColumnExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .functionCallArgumentList: visit(node as! FunctionCallArgumentListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .tupleElementList: visit(node as! TupleElementListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .arrayElementList: visit(node as! ArrayElementListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .dictionaryElementList: visit(node as! DictionaryElementListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .stringInterpolationSegments: visit(node as! StringInterpolationSegmentsSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .tryExpr: visit(node as! TryExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .declNameArgument: visit(node as! DeclNameArgumentSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .declNameArgumentList: visit(node as! DeclNameArgumentListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .declNameArguments: visit(node as! DeclNameArgumentsSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .identifierExpr: visit(node as! IdentifierExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .superRefExpr: visit(node as! SuperRefExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .nilLiteralExpr: visit(node as! NilLiteralExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .discardAssignmentExpr: visit(node as! DiscardAssignmentExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .assignmentExpr: visit(node as! AssignmentExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .sequenceExpr: visit(node as! SequenceExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .exprList: visit(node as! ExprListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .poundLineExpr: visit(node as! PoundLineExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .poundFileExpr: visit(node as! PoundFileExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .poundFunctionExpr: visit(node as! PoundFunctionExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .poundDsohandleExpr: visit(node as! PoundDsohandleExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .symbolicReferenceExpr: visit(node as! SymbolicReferenceExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .prefixOperatorExpr: visit(node as! PrefixOperatorExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .binaryOperatorExpr: visit(node as! BinaryOperatorExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .arrowExpr: visit(node as! ArrowExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .floatLiteralExpr: visit(node as! FloatLiteralExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .tupleExpr: visit(node as! TupleExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .arrayExpr: visit(node as! ArrayExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .dictionaryExpr: visit(node as! DictionaryExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .implicitMemberExpr: visit(node as! ImplicitMemberExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .functionCallArgument: visit(node as! FunctionCallArgumentSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .tupleElement: visit(node as! TupleElementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .arrayElement: visit(node as! ArrayElementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .dictionaryElement: visit(node as! DictionaryElementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .integerLiteralExpr: visit(node as! IntegerLiteralExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .stringLiteralExpr: visit(node as! StringLiteralExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .booleanLiteralExpr: visit(node as! BooleanLiteralExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .ternaryExpr: visit(node as! TernaryExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .memberAccessExpr: visit(node as! MemberAccessExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .dotSelfExpr: visit(node as! DotSelfExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .isExpr: visit(node as! IsExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .asExpr: visit(node as! AsExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .typeExpr: visit(node as! TypeExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .closureCaptureItem: visit(node as! ClosureCaptureItemSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .closureCaptureItemList: visit(node as! ClosureCaptureItemListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .closureCaptureSignature: visit(node as! ClosureCaptureSignatureSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .closureParam: visit(node as! ClosureParamSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .closureParamList: visit(node as! ClosureParamListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .closureSignature: visit(node as! ClosureSignatureSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .closureExpr: visit(node as! ClosureExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .unresolvedPatternExpr: visit(node as! UnresolvedPatternExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .functionCallExpr: visit(node as! FunctionCallExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .subscriptExpr: visit(node as! SubscriptExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .optionalChainingExpr: visit(node as! OptionalChainingExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .forcedValueExpr: visit(node as! ForcedValueExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .postfixUnaryExpr: visit(node as! PostfixUnaryExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .specializeExpr: visit(node as! SpecializeExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .stringSegment: visit(node as! StringSegmentSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .expressionSegment: visit(node as! ExpressionSegmentSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .stringInterpolationExpr: visit(node as! StringInterpolationExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .keyPathExpr: visit(node as! KeyPathExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .keyPathBaseExpr: visit(node as! KeyPathBaseExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .objcNamePiece: visit(node as! ObjcNamePieceSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .objcName: visit(node as! ObjcNameSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .objcKeyPathExpr: visit(node as! ObjcKeyPathExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .objcSelectorExpr: visit(node as! ObjcSelectorExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .editorPlaceholderExpr: visit(node as! EditorPlaceholderExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .objectLiteralExpr: visit(node as! ObjectLiteralExprSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .typeInitializerClause: visit(node as! TypeInitializerClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .typealiasDecl: visit(node as! TypealiasDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .associatedtypeDecl: visit(node as! AssociatedtypeDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .functionParameterList: visit(node as! FunctionParameterListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .parameterClause: visit(node as! ParameterClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .returnClause: visit(node as! ReturnClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .functionSignature: visit(node as! FunctionSignatureSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .ifConfigClause: visit(node as! IfConfigClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .ifConfigClauseList: visit(node as! IfConfigClauseListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .ifConfigDecl: visit(node as! IfConfigDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .poundErrorDecl: visit(node as! PoundErrorDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .poundWarningDecl: visit(node as! PoundWarningDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .poundSourceLocation: visit(node as! PoundSourceLocationSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .poundSourceLocationArgs: visit(node as! PoundSourceLocationArgsSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .declModifier: visit(node as! DeclModifierSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .inheritedType: visit(node as! InheritedTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .inheritedTypeList: visit(node as! InheritedTypeListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .typeInheritanceClause: visit(node as! TypeInheritanceClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .classDecl: visit(node as! ClassDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .structDecl: visit(node as! StructDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .protocolDecl: visit(node as! ProtocolDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .extensionDecl: visit(node as! ExtensionDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .memberDeclBlock: visit(node as! MemberDeclBlockSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .memberDeclList: visit(node as! MemberDeclListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .memberDeclListItem: visit(node as! MemberDeclListItemSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .sourceFile: visit(node as! SourceFileSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .initializerClause: visit(node as! InitializerClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .functionParameter: visit(node as! FunctionParameterSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .modifierList: visit(node as! ModifierListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .functionDecl: visit(node as! FunctionDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .initializerDecl: visit(node as! InitializerDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .deinitializerDecl: visit(node as! DeinitializerDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .subscriptDecl: visit(node as! SubscriptDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .accessLevelModifier: visit(node as! AccessLevelModifierSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .accessPathComponent: visit(node as! AccessPathComponentSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .accessPath: visit(node as! AccessPathSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .importDecl: visit(node as! ImportDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .accessorParameter: visit(node as! AccessorParameterSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .accessorDecl: visit(node as! AccessorDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .accessorList: visit(node as! AccessorListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .accessorBlock: visit(node as! AccessorBlockSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .patternBinding: visit(node as! PatternBindingSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .patternBindingList: visit(node as! PatternBindingListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .variableDecl: visit(node as! VariableDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .enumCaseElement: visit(node as! EnumCaseElementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .enumCaseElementList: visit(node as! EnumCaseElementListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .enumCaseDecl: visit(node as! EnumCaseDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .enumDecl: visit(node as! EnumDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .operatorDecl: visit(node as! OperatorDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .infixOperatorGroup: visit(node as! InfixOperatorGroupSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .precedenceGroupDecl: visit(node as! PrecedenceGroupDeclSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .precedenceGroupAttributeList: visit(node as! PrecedenceGroupAttributeListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .precedenceGroupRelation: visit(node as! PrecedenceGroupRelationSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .precedenceGroupNameList: visit(node as! PrecedenceGroupNameListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .precedenceGroupNameElement: visit(node as! PrecedenceGroupNameElementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .precedenceGroupAssignment: visit(node as! PrecedenceGroupAssignmentSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .precedenceGroupAssociativity: visit(node as! PrecedenceGroupAssociativitySyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .tokenList: visit(node as! TokenListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .nonEmptyTokenList: visit(node as! NonEmptyTokenListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .attribute: visit(node as! AttributeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .attributeList: visit(node as! AttributeListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .specializeAttributeSpecList: visit(node as! SpecializeAttributeSpecListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .labeledSpecializeEntry: visit(node as! LabeledSpecializeEntrySyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .implementsAttributeArguments: visit(node as! ImplementsAttributeArgumentsSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .objCSelectorPiece: visit(node as! ObjCSelectorPieceSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .objCSelector: visit(node as! ObjCSelectorSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .continueStmt: visit(node as! ContinueStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .whileStmt: visit(node as! WhileStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .deferStmt: visit(node as! DeferStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .expressionStmt: visit(node as! ExpressionStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .switchCaseList: visit(node as! SwitchCaseListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .repeatWhileStmt: visit(node as! RepeatWhileStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .guardStmt: visit(node as! GuardStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .whereClause: visit(node as! WhereClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .forInStmt: visit(node as! ForInStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .switchStmt: visit(node as! SwitchStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .catchClauseList: visit(node as! CatchClauseListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .doStmt: visit(node as! DoStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .returnStmt: visit(node as! ReturnStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .yieldStmt: visit(node as! YieldStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .fallthroughStmt: visit(node as! FallthroughStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .breakStmt: visit(node as! BreakStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .caseItemList: visit(node as! CaseItemListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .conditionElement: visit(node as! ConditionElementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .availabilityCondition: visit(node as! AvailabilityConditionSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .matchingPatternCondition: visit(node as! MatchingPatternConditionSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .optionalBindingCondition: visit(node as! OptionalBindingConditionSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .conditionElementList: visit(node as! ConditionElementListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .declarationStmt: visit(node as! DeclarationStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .throwStmt: visit(node as! ThrowStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .ifStmt: visit(node as! IfStmtSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .elseIfContinuation: visit(node as! ElseIfContinuationSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .elseBlock: visit(node as! ElseBlockSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .switchCase: visit(node as! SwitchCaseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .switchDefaultLabel: visit(node as! SwitchDefaultLabelSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .caseItem: visit(node as! CaseItemSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .switchCaseLabel: visit(node as! SwitchCaseLabelSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .catchClause: visit(node as! CatchClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .genericWhereClause: visit(node as! GenericWhereClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .genericRequirementList: visit(node as! GenericRequirementListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .sameTypeRequirement: visit(node as! SameTypeRequirementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .genericParameterList: visit(node as! GenericParameterListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .genericParameter: visit(node as! GenericParameterSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .genericParameterClause: visit(node as! GenericParameterClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .conformanceRequirement: visit(node as! ConformanceRequirementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .simpleTypeIdentifier: visit(node as! SimpleTypeIdentifierSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .memberTypeIdentifier: visit(node as! MemberTypeIdentifierSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .classRestrictionType: visit(node as! ClassRestrictionTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .arrayType: visit(node as! ArrayTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .dictionaryType: visit(node as! DictionaryTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .metatypeType: visit(node as! MetatypeTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .optionalType: visit(node as! OptionalTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .implicitlyUnwrappedOptionalType: visit(node as! ImplicitlyUnwrappedOptionalTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .compositionTypeElement: visit(node as! CompositionTypeElementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .compositionTypeElementList: visit(node as! CompositionTypeElementListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .compositionType: visit(node as! CompositionTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .tupleTypeElement: visit(node as! TupleTypeElementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .tupleTypeElementList: visit(node as! TupleTypeElementListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .tupleType: visit(node as! TupleTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .functionType: visit(node as! FunctionTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .attributedType: visit(node as! AttributedTypeSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .genericArgumentList: visit(node as! GenericArgumentListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .genericArgument: visit(node as! GenericArgumentSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .genericArgumentClause: visit(node as! GenericArgumentClauseSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .typeAnnotation: visit(node as! TypeAnnotationSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .enumCasePattern: visit(node as! EnumCasePatternSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .isTypePattern: visit(node as! IsTypePatternSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .optionalPattern: visit(node as! OptionalPatternSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .identifierPattern: visit(node as! IdentifierPatternSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .asTypePattern: visit(node as! AsTypePatternSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .tuplePattern: visit(node as! TuplePatternSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .wildcardPattern: visit(node as! WildcardPatternSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .tuplePatternElement: visit(node as! TuplePatternElementSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .expressionPattern: visit(node as! ExpressionPatternSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .tuplePatternElementList: visit(node as! TuplePatternElementListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .valueBindingPattern: visit(node as! ValueBindingPatternSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .availabilitySpecList: visit(node as! AvailabilitySpecListSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .availabilityArgument: visit(node as! AvailabilityArgumentSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .availabilityLabeledArgument: visit(node as! AvailabilityLabeledArgumentSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .availabilityVersionRestriction: visit(node as! AvailabilityVersionRestrictionSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 124)
    case .versionTuple: visit(node as! VersionTupleSyntax)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxRewriter.swift.gyb", line: 127)
    default: visitChildren(node)
    }
  }

  func visitChildren(_ node: Syntax) {
    node.children.forEach { visit($0) }
  }
}
