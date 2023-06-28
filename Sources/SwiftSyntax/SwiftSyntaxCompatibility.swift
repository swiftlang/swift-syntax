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

// This file provides compatiblity aliases to keep dependents of SwiftSyntax building.
// All users of the declarations in this file should transition away from them ASAP.

public extension DeclGroupSyntax {
  @available(*, deprecated, renamed: "memberBlock")
  var members: MemberDeclBlockSyntax {
    return self.memberBlock
  }
}

@available(*, deprecated, renamed: "WithAttributesSyntax")
public typealias AttributedSyntax = WithAttributesSyntax

public extension EditorPlaceholderDeclSyntax {
  @available(*, deprecated, renamed: "placeholder")
  var identifier: TokenSyntax { placeholder }

  @available(*, deprecated, renamed: "placeholder")
  init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedAfterIdentifier: UnexpectedNodesSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeIdentifier,
      placeholder: identifier,
      unexpectedAfterIdentifier
    )
  }
}

@available(*, deprecated, renamed: "IncrementalEdit")
public typealias SourceEdit = IncrementalEdit
