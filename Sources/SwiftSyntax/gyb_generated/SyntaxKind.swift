// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 10)
//// Automatically Generated From SyntaxKind.swift.gyb.
//// Do Not Edit Directly!
//===--------------- SyntaxKind.swift - Syntax Kind definitions -----------===//
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

import Foundation

/// Enumerates the known kinds of Syntax represented in the Syntax tree.
internal enum SyntaxKind: String, Codable {
  case token = "Token"
  case unknown = "Unknown"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case decl = "Decl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case expr = "Expr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case stmt = "Stmt"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case type = "Type"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case pattern = "Pattern"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case unknownDecl = "UnknownDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case unknownExpr = "UnknownExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case unknownStmt = "UnknownStmt"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case unknownType = "UnknownType"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case unknownPattern = "UnknownPattern"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case codeBlockItem = "CodeBlockItem"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case codeBlockItemList = "CodeBlockItemList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case codeBlock = "CodeBlock"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case inOutExpr = "InOutExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case poundColumnExpr = "PoundColumnExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case functionCallArgumentList = "FunctionCallArgumentList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case tupleElementList = "TupleElementList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case arrayElementList = "ArrayElementList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case dictionaryElementList = "DictionaryElementList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case stringInterpolationSegments = "StringInterpolationSegments"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case tryExpr = "TryExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case declNameArgument = "DeclNameArgument"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case declNameArgumentList = "DeclNameArgumentList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case declNameArguments = "DeclNameArguments"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case identifierExpr = "IdentifierExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case superRefExpr = "SuperRefExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case nilLiteralExpr = "NilLiteralExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case discardAssignmentExpr = "DiscardAssignmentExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case assignmentExpr = "AssignmentExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case sequenceExpr = "SequenceExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case exprList = "ExprList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case poundLineExpr = "PoundLineExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case poundFileExpr = "PoundFileExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case poundFunctionExpr = "PoundFunctionExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case poundDsohandleExpr = "PoundDsohandleExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case symbolicReferenceExpr = "SymbolicReferenceExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case prefixOperatorExpr = "PrefixOperatorExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case binaryOperatorExpr = "BinaryOperatorExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case arrowExpr = "ArrowExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case floatLiteralExpr = "FloatLiteralExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case tupleExpr = "TupleExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case arrayExpr = "ArrayExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case dictionaryExpr = "DictionaryExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case implicitMemberExpr = "ImplicitMemberExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case functionCallArgument = "FunctionCallArgument"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case tupleElement = "TupleElement"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case arrayElement = "ArrayElement"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case dictionaryElement = "DictionaryElement"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case integerLiteralExpr = "IntegerLiteralExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case stringLiteralExpr = "StringLiteralExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case booleanLiteralExpr = "BooleanLiteralExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case ternaryExpr = "TernaryExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case memberAccessExpr = "MemberAccessExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case dotSelfExpr = "DotSelfExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case isExpr = "IsExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case asExpr = "AsExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case typeExpr = "TypeExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case closureCaptureItem = "ClosureCaptureItem"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case closureCaptureItemList = "ClosureCaptureItemList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case closureCaptureSignature = "ClosureCaptureSignature"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case closureParam = "ClosureParam"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case closureParamList = "ClosureParamList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case closureSignature = "ClosureSignature"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case closureExpr = "ClosureExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case unresolvedPatternExpr = "UnresolvedPatternExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case functionCallExpr = "FunctionCallExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case subscriptExpr = "SubscriptExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case optionalChainingExpr = "OptionalChainingExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case forcedValueExpr = "ForcedValueExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case postfixUnaryExpr = "PostfixUnaryExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case specializeExpr = "SpecializeExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case stringSegment = "StringSegment"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case expressionSegment = "ExpressionSegment"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case stringInterpolationExpr = "StringInterpolationExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case keyPathExpr = "KeyPathExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case keyPathBaseExpr = "KeyPathBaseExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case objcNamePiece = "ObjcNamePiece"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case objcName = "ObjcName"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case objcKeyPathExpr = "ObjcKeyPathExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case objcSelectorExpr = "ObjcSelectorExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case editorPlaceholderExpr = "EditorPlaceholderExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case objectLiteralExpr = "ObjectLiteralExpr"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case typeInitializerClause = "TypeInitializerClause"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case typealiasDecl = "TypealiasDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case associatedtypeDecl = "AssociatedtypeDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case functionParameterList = "FunctionParameterList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case parameterClause = "ParameterClause"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case returnClause = "ReturnClause"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case functionSignature = "FunctionSignature"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case ifConfigClause = "IfConfigClause"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case ifConfigClauseList = "IfConfigClauseList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case ifConfigDecl = "IfConfigDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case poundErrorDecl = "PoundErrorDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case poundWarningDecl = "PoundWarningDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case poundSourceLocation = "PoundSourceLocation"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case poundSourceLocationArgs = "PoundSourceLocationArgs"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case declModifier = "DeclModifier"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case inheritedType = "InheritedType"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case inheritedTypeList = "InheritedTypeList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case typeInheritanceClause = "TypeInheritanceClause"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case classDecl = "ClassDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case structDecl = "StructDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case protocolDecl = "ProtocolDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case extensionDecl = "ExtensionDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case memberDeclBlock = "MemberDeclBlock"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case memberDeclList = "MemberDeclList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case memberDeclListItem = "MemberDeclListItem"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case sourceFile = "SourceFile"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case initializerClause = "InitializerClause"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case functionParameter = "FunctionParameter"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case modifierList = "ModifierList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case functionDecl = "FunctionDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case initializerDecl = "InitializerDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case deinitializerDecl = "DeinitializerDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case subscriptDecl = "SubscriptDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case accessLevelModifier = "AccessLevelModifier"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case accessPathComponent = "AccessPathComponent"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case accessPath = "AccessPath"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case importDecl = "ImportDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case accessorParameter = "AccessorParameter"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case accessorDecl = "AccessorDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case accessorList = "AccessorList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case accessorBlock = "AccessorBlock"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case patternBinding = "PatternBinding"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case patternBindingList = "PatternBindingList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case variableDecl = "VariableDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case enumCaseElement = "EnumCaseElement"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case enumCaseElementList = "EnumCaseElementList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case enumCaseDecl = "EnumCaseDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case enumDecl = "EnumDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case operatorDecl = "OperatorDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case infixOperatorGroup = "InfixOperatorGroup"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case precedenceGroupDecl = "PrecedenceGroupDecl"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case precedenceGroupAttributeList = "PrecedenceGroupAttributeList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case precedenceGroupRelation = "PrecedenceGroupRelation"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case precedenceGroupNameList = "PrecedenceGroupNameList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case precedenceGroupNameElement = "PrecedenceGroupNameElement"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case precedenceGroupAssignment = "PrecedenceGroupAssignment"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case precedenceGroupAssociativity = "PrecedenceGroupAssociativity"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case tokenList = "TokenList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case nonEmptyTokenList = "NonEmptyTokenList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case attribute = "Attribute"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case attributeList = "AttributeList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case specializeAttributeSpecList = "SpecializeAttributeSpecList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case labeledSpecializeEntry = "LabeledSpecializeEntry"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case implementsAttributeArguments = "ImplementsAttributeArguments"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case objCSelectorPiece = "ObjCSelectorPiece"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case objCSelector = "ObjCSelector"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case continueStmt = "ContinueStmt"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case whileStmt = "WhileStmt"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case deferStmt = "DeferStmt"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case expressionStmt = "ExpressionStmt"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case switchCaseList = "SwitchCaseList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case repeatWhileStmt = "RepeatWhileStmt"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case guardStmt = "GuardStmt"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case whereClause = "WhereClause"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case forInStmt = "ForInStmt"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case switchStmt = "SwitchStmt"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case catchClauseList = "CatchClauseList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case doStmt = "DoStmt"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case returnStmt = "ReturnStmt"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case yieldStmt = "YieldStmt"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case fallthroughStmt = "FallthroughStmt"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case breakStmt = "BreakStmt"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case caseItemList = "CaseItemList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case conditionElement = "ConditionElement"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case availabilityCondition = "AvailabilityCondition"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case matchingPatternCondition = "MatchingPatternCondition"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case optionalBindingCondition = "OptionalBindingCondition"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case conditionElementList = "ConditionElementList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case declarationStmt = "DeclarationStmt"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case throwStmt = "ThrowStmt"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case ifStmt = "IfStmt"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case elseIfContinuation = "ElseIfContinuation"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case elseBlock = "ElseBlock"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case switchCase = "SwitchCase"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case switchDefaultLabel = "SwitchDefaultLabel"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case caseItem = "CaseItem"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case switchCaseLabel = "SwitchCaseLabel"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case catchClause = "CatchClause"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case genericWhereClause = "GenericWhereClause"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case genericRequirementList = "GenericRequirementList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case sameTypeRequirement = "SameTypeRequirement"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case genericParameterList = "GenericParameterList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case genericParameter = "GenericParameter"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case genericParameterClause = "GenericParameterClause"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case conformanceRequirement = "ConformanceRequirement"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case simpleTypeIdentifier = "SimpleTypeIdentifier"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case memberTypeIdentifier = "MemberTypeIdentifier"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case classRestrictionType = "ClassRestrictionType"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case arrayType = "ArrayType"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case dictionaryType = "DictionaryType"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case metatypeType = "MetatypeType"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case optionalType = "OptionalType"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case implicitlyUnwrappedOptionalType = "ImplicitlyUnwrappedOptionalType"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case compositionTypeElement = "CompositionTypeElement"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case compositionTypeElementList = "CompositionTypeElementList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case compositionType = "CompositionType"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case tupleTypeElement = "TupleTypeElement"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case tupleTypeElementList = "TupleTypeElementList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case tupleType = "TupleType"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case functionType = "FunctionType"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case attributedType = "AttributedType"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case genericArgumentList = "GenericArgumentList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case genericArgument = "GenericArgument"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case genericArgumentClause = "GenericArgumentClause"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case typeAnnotation = "TypeAnnotation"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case enumCasePattern = "EnumCasePattern"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case isTypePattern = "IsTypePattern"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case optionalPattern = "OptionalPattern"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case identifierPattern = "IdentifierPattern"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case asTypePattern = "AsTypePattern"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case tuplePattern = "TuplePattern"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case wildcardPattern = "WildcardPattern"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case tuplePatternElement = "TuplePatternElement"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case expressionPattern = "ExpressionPattern"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case tuplePatternElementList = "TuplePatternElementList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case valueBindingPattern = "ValueBindingPattern"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case availabilitySpecList = "AvailabilitySpecList"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case availabilityArgument = "AvailabilityArgument"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case availabilityLabeledArgument = "AvailabilityLabeledArgument"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case availabilityVersionRestriction = "AvailabilityVersionRestriction"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 31)
  case versionTuple = "VersionTuple"
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 33)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 36)
  /// Whether the underlying kind is a sub-kind of DeclSyntax.
  public var isDecl: Bool {
    switch self {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .unknownDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .typealiasDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .associatedtypeDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .ifConfigDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .poundErrorDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .poundWarningDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .poundSourceLocation: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .classDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .structDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .protocolDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .extensionDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .functionDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .initializerDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .deinitializerDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .subscriptDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .importDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .accessorDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .variableDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .enumCaseDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .enumDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .operatorDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .precedenceGroupDecl: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 42)
    default: return false
    }
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 36)
  /// Whether the underlying kind is a sub-kind of ExprSyntax.
  public var isExpr: Bool {
    switch self {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .unknownExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .inOutExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .poundColumnExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .tryExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .identifierExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .superRefExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .nilLiteralExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .discardAssignmentExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .assignmentExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .sequenceExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .poundLineExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .poundFileExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .poundFunctionExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .poundDsohandleExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .symbolicReferenceExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .prefixOperatorExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .binaryOperatorExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .arrowExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .floatLiteralExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .tupleExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .arrayExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .dictionaryExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .implicitMemberExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .integerLiteralExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .stringLiteralExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .booleanLiteralExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .ternaryExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .memberAccessExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .dotSelfExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .isExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .asExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .typeExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .closureExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .unresolvedPatternExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .functionCallExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .subscriptExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .optionalChainingExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .forcedValueExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .postfixUnaryExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .specializeExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .stringInterpolationExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .keyPathExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .keyPathBaseExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .objcKeyPathExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .objcSelectorExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .editorPlaceholderExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .objectLiteralExpr: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 42)
    default: return false
    }
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 36)
  /// Whether the underlying kind is a sub-kind of StmtSyntax.
  public var isStmt: Bool {
    switch self {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .unknownStmt: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .continueStmt: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .whileStmt: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .deferStmt: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .expressionStmt: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .repeatWhileStmt: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .guardStmt: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .forInStmt: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .switchStmt: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .doStmt: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .returnStmt: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .yieldStmt: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .fallthroughStmt: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .breakStmt: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .declarationStmt: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .throwStmt: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .ifStmt: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 42)
    default: return false
    }
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 36)
  /// Whether the underlying kind is a sub-kind of PatternSyntax.
  public var isPattern: Bool {
    switch self {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .unknownPattern: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .enumCasePattern: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .isTypePattern: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .optionalPattern: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .identifierPattern: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .asTypePattern: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .tuplePattern: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .wildcardPattern: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .expressionPattern: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .valueBindingPattern: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 42)
    default: return false
    }
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 36)
  /// Whether the underlying kind is a sub-kind of TypeSyntax.
  public var isType: Bool {
    switch self {
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .unknownType: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .simpleTypeIdentifier: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .memberTypeIdentifier: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .classRestrictionType: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .arrayType: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .dictionaryType: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .metatypeType: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .optionalType: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .implicitlyUnwrappedOptionalType: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .compositionType: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .tupleType: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .functionType: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 40)
    case .attributedType: return true
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 42)
    default: return false
    }
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 47)

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let kind = try container.decode(String.self)
    self = SyntaxKind(rawValue: kind) ?? .unknown
  }
}

/// Creates a Syntax node from the provided RawSyntax using the appropriate
/// Syntax type, as specified by its kind.
/// - Parameters:
///   - raw: The raw syntax with which to create this node.
///   - root: The root of this tree, or `nil` if the new node is the root.
internal func makeSyntax(_ raw: RawSyntax) -> Syntax {
  let data = SyntaxData(raw: raw)
  return makeSyntax(root: nil, data: data)
}

/// Creates a Syntax node from the provided SyntaxData using the appropriate
/// Syntax type, as specified by its kind.
/// - Parameters:
///   - root: The root of this tree, or `nil` if the new node is the root.
///   - data: The data for this new node.
internal func makeSyntax(root: SyntaxData?, data: SyntaxData) -> Syntax {
  let root = root ?? data
  switch data.raw.kind {
  case .token: return TokenSyntax(root: root, data: data)
  case .unknown: return UnknownSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .decl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 78)
    return UnknownDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .expr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 78)
    return UnknownExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .stmt:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 78)
    return UnknownStmtSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .type:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 78)
    return UnknownTypeSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .pattern:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 78)
    return UnknownPatternSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .unknownDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return UnknownDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .unknownExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return UnknownExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .unknownStmt:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return UnknownStmtSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .unknownType:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return UnknownTypeSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .unknownPattern:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return UnknownPatternSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .codeBlockItem:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return CodeBlockItemSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .codeBlockItemList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return CodeBlockItemListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .codeBlock:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return CodeBlockSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .inOutExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return InOutExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .poundColumnExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return PoundColumnExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .functionCallArgumentList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return FunctionCallArgumentListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .tupleElementList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return TupleElementListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .arrayElementList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ArrayElementListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .dictionaryElementList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return DictionaryElementListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .stringInterpolationSegments:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return StringInterpolationSegmentsSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .tryExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return TryExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .declNameArgument:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return DeclNameArgumentSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .declNameArgumentList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return DeclNameArgumentListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .declNameArguments:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return DeclNameArgumentsSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .identifierExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return IdentifierExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .superRefExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return SuperRefExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .nilLiteralExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return NilLiteralExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .discardAssignmentExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return DiscardAssignmentExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .assignmentExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return AssignmentExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .sequenceExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return SequenceExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .exprList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ExprListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .poundLineExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return PoundLineExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .poundFileExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return PoundFileExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .poundFunctionExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return PoundFunctionExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .poundDsohandleExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return PoundDsohandleExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .symbolicReferenceExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return SymbolicReferenceExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .prefixOperatorExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return PrefixOperatorExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .binaryOperatorExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return BinaryOperatorExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .arrowExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ArrowExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .floatLiteralExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return FloatLiteralExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .tupleExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return TupleExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .arrayExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ArrayExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .dictionaryExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return DictionaryExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .implicitMemberExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ImplicitMemberExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .functionCallArgument:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return FunctionCallArgumentSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .tupleElement:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return TupleElementSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .arrayElement:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ArrayElementSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .dictionaryElement:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return DictionaryElementSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .integerLiteralExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return IntegerLiteralExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .stringLiteralExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return StringLiteralExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .booleanLiteralExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return BooleanLiteralExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .ternaryExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return TernaryExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .memberAccessExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return MemberAccessExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .dotSelfExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return DotSelfExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .isExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return IsExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .asExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return AsExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .typeExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return TypeExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .closureCaptureItem:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ClosureCaptureItemSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .closureCaptureItemList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ClosureCaptureItemListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .closureCaptureSignature:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ClosureCaptureSignatureSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .closureParam:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ClosureParamSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .closureParamList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ClosureParamListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .closureSignature:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ClosureSignatureSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .closureExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ClosureExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .unresolvedPatternExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return UnresolvedPatternExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .functionCallExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return FunctionCallExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .subscriptExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return SubscriptExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .optionalChainingExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return OptionalChainingExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .forcedValueExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ForcedValueExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .postfixUnaryExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return PostfixUnaryExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .specializeExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return SpecializeExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .stringSegment:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return StringSegmentSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .expressionSegment:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ExpressionSegmentSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .stringInterpolationExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return StringInterpolationExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .keyPathExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return KeyPathExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .keyPathBaseExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return KeyPathBaseExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .objcNamePiece:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ObjcNamePieceSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .objcName:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ObjcNameSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .objcKeyPathExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ObjcKeyPathExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .objcSelectorExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ObjcSelectorExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .editorPlaceholderExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return EditorPlaceholderExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .objectLiteralExpr:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ObjectLiteralExprSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .typeInitializerClause:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return TypeInitializerClauseSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .typealiasDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return TypealiasDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .associatedtypeDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return AssociatedtypeDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .functionParameterList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return FunctionParameterListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .parameterClause:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ParameterClauseSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .returnClause:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ReturnClauseSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .functionSignature:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return FunctionSignatureSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .ifConfigClause:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return IfConfigClauseSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .ifConfigClauseList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return IfConfigClauseListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .ifConfigDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return IfConfigDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .poundErrorDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return PoundErrorDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .poundWarningDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return PoundWarningDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .poundSourceLocation:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return PoundSourceLocationSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .poundSourceLocationArgs:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return PoundSourceLocationArgsSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .declModifier:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return DeclModifierSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .inheritedType:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return InheritedTypeSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .inheritedTypeList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return InheritedTypeListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .typeInheritanceClause:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return TypeInheritanceClauseSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .classDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ClassDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .structDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return StructDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .protocolDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ProtocolDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .extensionDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ExtensionDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .memberDeclBlock:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return MemberDeclBlockSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .memberDeclList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return MemberDeclListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .memberDeclListItem:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return MemberDeclListItemSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .sourceFile:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return SourceFileSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .initializerClause:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return InitializerClauseSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .functionParameter:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return FunctionParameterSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .modifierList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ModifierListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .functionDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return FunctionDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .initializerDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return InitializerDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .deinitializerDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return DeinitializerDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .subscriptDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return SubscriptDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .accessLevelModifier:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return AccessLevelModifierSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .accessPathComponent:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return AccessPathComponentSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .accessPath:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return AccessPathSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .importDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ImportDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .accessorParameter:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return AccessorParameterSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .accessorDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return AccessorDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .accessorList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return AccessorListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .accessorBlock:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return AccessorBlockSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .patternBinding:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return PatternBindingSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .patternBindingList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return PatternBindingListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .variableDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return VariableDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .enumCaseElement:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return EnumCaseElementSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .enumCaseElementList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return EnumCaseElementListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .enumCaseDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return EnumCaseDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .enumDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return EnumDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .operatorDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return OperatorDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .infixOperatorGroup:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return InfixOperatorGroupSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .precedenceGroupDecl:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return PrecedenceGroupDeclSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .precedenceGroupAttributeList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return PrecedenceGroupAttributeListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .precedenceGroupRelation:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return PrecedenceGroupRelationSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .precedenceGroupNameList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return PrecedenceGroupNameListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .precedenceGroupNameElement:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return PrecedenceGroupNameElementSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .precedenceGroupAssignment:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return PrecedenceGroupAssignmentSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .precedenceGroupAssociativity:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return PrecedenceGroupAssociativitySyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .tokenList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return TokenListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .nonEmptyTokenList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return NonEmptyTokenListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .attribute:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return AttributeSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .attributeList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return AttributeListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .specializeAttributeSpecList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return SpecializeAttributeSpecListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .labeledSpecializeEntry:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return LabeledSpecializeEntrySyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .implementsAttributeArguments:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ImplementsAttributeArgumentsSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .objCSelectorPiece:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ObjCSelectorPieceSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .objCSelector:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ObjCSelectorSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .continueStmt:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ContinueStmtSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .whileStmt:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return WhileStmtSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .deferStmt:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return DeferStmtSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .expressionStmt:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ExpressionStmtSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .switchCaseList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return SwitchCaseListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .repeatWhileStmt:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return RepeatWhileStmtSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .guardStmt:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return GuardStmtSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .whereClause:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return WhereClauseSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .forInStmt:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ForInStmtSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .switchStmt:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return SwitchStmtSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .catchClauseList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return CatchClauseListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .doStmt:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return DoStmtSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .returnStmt:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ReturnStmtSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .yieldStmt:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return YieldStmtSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .fallthroughStmt:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return FallthroughStmtSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .breakStmt:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return BreakStmtSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .caseItemList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return CaseItemListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .conditionElement:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ConditionElementSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .availabilityCondition:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return AvailabilityConditionSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .matchingPatternCondition:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return MatchingPatternConditionSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .optionalBindingCondition:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return OptionalBindingConditionSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .conditionElementList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ConditionElementListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .declarationStmt:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return DeclarationStmtSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .throwStmt:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ThrowStmtSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .ifStmt:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return IfStmtSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .elseIfContinuation:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ElseIfContinuationSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .elseBlock:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ElseBlockSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .switchCase:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return SwitchCaseSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .switchDefaultLabel:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return SwitchDefaultLabelSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .caseItem:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return CaseItemSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .switchCaseLabel:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return SwitchCaseLabelSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .catchClause:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return CatchClauseSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .genericWhereClause:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return GenericWhereClauseSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .genericRequirementList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return GenericRequirementListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .sameTypeRequirement:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return SameTypeRequirementSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .genericParameterList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return GenericParameterListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .genericParameter:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return GenericParameterSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .genericParameterClause:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return GenericParameterClauseSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .conformanceRequirement:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ConformanceRequirementSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .simpleTypeIdentifier:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return SimpleTypeIdentifierSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .memberTypeIdentifier:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return MemberTypeIdentifierSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .classRestrictionType:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ClassRestrictionTypeSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .arrayType:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ArrayTypeSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .dictionaryType:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return DictionaryTypeSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .metatypeType:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return MetatypeTypeSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .optionalType:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return OptionalTypeSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .implicitlyUnwrappedOptionalType:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ImplicitlyUnwrappedOptionalTypeSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .compositionTypeElement:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return CompositionTypeElementSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .compositionTypeElementList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return CompositionTypeElementListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .compositionType:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return CompositionTypeSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .tupleTypeElement:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return TupleTypeElementSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .tupleTypeElementList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return TupleTypeElementListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .tupleType:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return TupleTypeSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .functionType:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return FunctionTypeSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .attributedType:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return AttributedTypeSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .genericArgumentList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return GenericArgumentListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .genericArgument:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return GenericArgumentSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .genericArgumentClause:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return GenericArgumentClauseSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .typeAnnotation:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return TypeAnnotationSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .enumCasePattern:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return EnumCasePatternSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .isTypePattern:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return IsTypePatternSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .optionalPattern:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return OptionalPatternSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .identifierPattern:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return IdentifierPatternSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .asTypePattern:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return AsTypePatternSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .tuplePattern:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return TuplePatternSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .wildcardPattern:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return WildcardPatternSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .tuplePatternElement:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return TuplePatternElementSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .expressionPattern:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ExpressionPatternSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .tuplePatternElementList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return TuplePatternElementListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .valueBindingPattern:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return ValueBindingPatternSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .availabilitySpecList:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return AvailabilitySpecListSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .availabilityArgument:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return AvailabilityArgumentSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .availabilityLabeledArgument:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return AvailabilityLabeledArgumentSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .availabilityVersionRestriction:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return AvailabilityVersionRestrictionSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 76)
  case .versionTuple:
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 80)
    return VersionTupleSyntax(root: root, data: data)
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxKind.swift.gyb", line: 83)
  }
}