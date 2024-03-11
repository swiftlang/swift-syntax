//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if swift(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

/// Adds an initializer that allows the creation of declaration from string
/// interpolations.
///
/// - Warning: This protocol is considered an implementation detail. Do not rely
///   on it, only the initializer that it adds.
public protocol DeclSyntaxParseable: DeclSyntaxProtocol {}
public extension DeclSyntaxParseable {
  /// Create a syntax node from the given string interpolation.
  ///
  /// This initializer throws if the syntax node was not able to be parsed as
  /// this type, e.g. when calling `ClassDeclSyntax("actor Foo {})`.
  ///
  /// If there are syntax errors in the string, the initializer will return a
  /// node that contains errors without throwing.
  init(_ stringInterpolation: SyntaxNodeString) throws {
    let node: DeclSyntax = "\(stringInterpolation)"
    if let castedDecl = node.as(Self.self) {
      self = castedDecl
    } else {
      throw SyntaxStringInterpolationInvalidNodeTypeError(expectedType: Self.self, actualNode: node)
    }
  }
}

// These are all the declarations that get parsed from `parseDecl`
extension ActorDeclSyntax: DeclSyntaxParseable {}
extension AssociatedTypeDeclSyntax: DeclSyntaxParseable {}
extension EnumCaseDeclSyntax: DeclSyntaxParseable {}
extension ClassDeclSyntax: DeclSyntaxParseable {}
extension DeinitializerDeclSyntax: DeclSyntaxParseable {}
extension EnumDeclSyntax: DeclSyntaxParseable {}
extension ExtensionDeclSyntax: DeclSyntaxParseable {}
extension FunctionDeclSyntax: DeclSyntaxParseable {}
extension ImportDeclSyntax: DeclSyntaxParseable {}
extension VariableDeclSyntax: DeclSyntaxParseable {}
extension MacroDeclSyntax: DeclSyntaxParseable {}
extension OperatorDeclSyntax: DeclSyntaxParseable {}
extension MacroExpansionDeclSyntax: DeclSyntaxParseable {}
extension PrecedenceGroupDeclSyntax: DeclSyntaxParseable {}
extension ProtocolDeclSyntax: DeclSyntaxParseable {}
extension StructDeclSyntax: DeclSyntaxParseable {}
extension SubscriptDeclSyntax: DeclSyntaxParseable {}
extension TypeAliasDeclSyntax: DeclSyntaxParseable {}
