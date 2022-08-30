//===--- Optional+OrMissing.swift -----------------------------------------===//
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


@_spi(RawSyntax) import SwiftSyntax

extension Optional where Wrapped == RawDeclSyntax {
  /// If `self` is not `nil` returns `self`, otherwise returns a `RawMissingDeclSyntax`.
  func orMissing(arena: SyntaxArena) -> RawDeclSyntax {
    if let unwrapped = self {
      return unwrapped
    } else {
      return RawDeclSyntax(RawMissingDeclSyntax(
        attributes: nil,
        modifiers: nil,
        arena: arena
      ))
    }
  }
}

extension Optional where Wrapped == RawExprSyntax {
  /// If `self` is not `nil` returns `self`, otherwise returns a `RawMissingExprSyntax`.
  func orMissing(arena: SyntaxArena) -> RawExprSyntax {
    if let unwrapped = self {
      return unwrapped
    } else {
      return RawExprSyntax(RawMissingExprSyntax(arena: arena))
    }
  }
}

extension Optional where Wrapped == RawPatternSyntax {
  /// If `self` is not `nil` returns `self`, otherwise returns a `RawMissingPatternSyntax`.
  func orMissing(arena: SyntaxArena) -> RawPatternSyntax {
    if let unwrapped = self {
      return unwrapped
    } else {
      return RawPatternSyntax(RawMissingPatternSyntax(arena: arena))
    }
  }
}

extension Optional where Wrapped == RawStmtSyntax {
  /// If `self` is not `nil` returns `self`, otherwise returns a `RawMissingStmtSyntax`.
  func orMissing(arena: SyntaxArena) -> RawStmtSyntax {
    if let unwrapped = self {
      return unwrapped
    } else {
      return RawStmtSyntax(RawMissingStmtSyntax(arena: arena))
    }
  }
}

extension Optional where Wrapped == RawTypeSyntax {
  /// If `self` is not `nil` returns `self`, otherwise returns a `RawMissingTypeSyntax`.
  func orMissing(arena: SyntaxArena) -> RawTypeSyntax {
    if let unwrapped = self {
      return unwrapped
    } else {
      return RawTypeSyntax(RawMissingTypeSyntax(arena: arena))
    }
  }
}

extension Optional where Wrapped == RawSyntax {
  /// If `self` is not `nil` returns `self`, otherwise returns a `RawMissingSyntax`.
  func orMissing(arena: SyntaxArena) -> RawSyntax {
    if let unwrapped = self {
      return unwrapped
    } else {
      return RawSyntax(RawMissingSyntax(arena: arena))
    }
  }
}
