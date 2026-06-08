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

/// A declaration scope is basically any ``CodeBlockItemListSyntax``, whose
/// child declarations can only be referenced within said scope's block
/// items (with the exception of ``SourceFileSyntax``). Usually accessed
/// through ``ValueDeclSyntax/declScope``.
///
/// The most common declaration scope is the code block of the source file
/// itself:
///   // File.swift
///   struct MyStruct {}
/// Here, `MyStruct` is accessible within the entire file and --because
/// source files are special-- within the rest of the module.
///
/// Here's a more elaborate example:
///   // File.swift
///   struct A {
///     struct B {}
///     func myFunc() { struct C {} }
///   }
/// In this example there are two declarations scope: (1) the source file
/// itself (like in any valid syntax tree) and (2) the body of `myFunc`.
/// Because structs `A` and `B` are in the same scope, which happens to be
/// a file scope, they're accessible in the entire module as `A` and `A.B`.
/// However, they're no way to refer to `C` outside of the body of `myFunc`.
@_spi(_QualifiedLookup) public struct DeclScope {
  /// The code items, some of which are (scoped) declarations.
  public let codeItems: CodeBlockItemListSyntax
  /// Whether this declaration scope is file scope. `nil` if unknown.
  public let isFileScope: Bool?
}

extension SyntaxProtocol {
  /// Try to convert this syntax to a declaration scope consisting of the
  /// underlying codeblock list item list and a flag for whether this is file scope.
  ///
  /// If this declaration isn't a declaration scope, we return `nil`. If it
  /// is a declaration scope (code block item list syntax) without a parent,
  /// we set `isFileScope` to `nil`. We only get `isFileScope == true`
  /// when the scope is the direct child of ``SourceFileSyntax``.
  fileprivate var _asDeclScope: DeclScope? {
    // Check we a code block with a parent.
    guard let codeItems = self.as(CodeBlockItemListSyntax.self) else { return nil }

    // There's one ``SourceFileSyntax`` per syntax tree with exactly one
    // ``CodeBlockItemListSyntax`` child.
    //
    // If the code block doesn't have a parent, the syntax tree is likely
    // invalid so we set `isSourceFile` to nil.
    let isFileScope = codeItems.parent?.is(SourceFileSyntax.self)

    return DeclScope(codeItems: codeItems, isFileScope: isFileScope)
  }

  /// Finds the declaration scope of the current value declaration by looking
  /// through its recursive parents.
  @_spi(_QualifiedLookup) public var declScope: DeclScope? {
    // No parent means no scope.
    //
    // In this case, if `self` isn't a `SourceFileSyntax`, the syntax tree
    // is likely invalid
    guard let parent else { return nil }

    // See if parent is a declaration context; otherwise, get its context.
    return parent._asDeclScope ?? parent.declScope
  }
}
