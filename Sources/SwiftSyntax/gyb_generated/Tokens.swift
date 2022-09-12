//// Automatically Generated From Tokens.swift.gyb.
//// Do Not Edit Directly!
//===--- Tokens.swift -----------------------------------------------------===//
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

fileprivate func defaultTrivia(presence: SourcePresence, trivia: Trivia) -> Trivia {
  switch presence {
  case .present:
    return trivia
  case .missing:
    return []
  }
}

extension TokenSyntax {
  public static func associatedtypeKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .associatedtypeKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func classKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .classKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func deinitKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .deinitKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func enumKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .enumKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func extensionKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .extensionKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func funcKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .funcKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func importKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .importKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func initKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .initKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func inoutKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .inoutKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func letKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .letKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func operatorKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .operatorKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func precedencegroupKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .precedencegroupKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func protocolKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .protocolKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func structKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .structKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func subscriptKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .subscriptKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func typealiasKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .typealiasKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func varKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .varKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func fileprivateKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .fileprivateKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func internalKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .internalKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func privateKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .privateKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func publicKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .publicKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func staticKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .staticKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func deferKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .deferKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func ifKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .ifKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func guardKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .guardKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func doKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .doKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func repeatKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .repeatKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func elseKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .elseKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func forKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .forKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func inKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .inKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func whileKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .whileKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func returnKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .returnKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func breakKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .breakKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func continueKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .continueKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func fallthroughKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .fallthroughKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func switchKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .switchKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func caseKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .caseKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func defaultKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .defaultKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func whereKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .whereKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func catchKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .catchKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func throwKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .throwKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func asKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .asKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func anyKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .anyKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func falseKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .falseKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func isKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .isKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func nilKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .nilKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func rethrowsKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .rethrowsKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func superKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .superKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func selfKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .selfKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func capitalSelfKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .capitalSelfKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func trueKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .trueKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func tryKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .tryKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func throwsKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .throwsKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func __file__Keyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .__file__Keyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func __line__Keyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .__line__Keyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func __column__Keyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .__column__Keyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func __function__Keyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .__function__Keyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func __dso_handle__Keyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .__dso_handle__Keyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func wildcardKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .wildcardKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func leftParenToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .leftParen,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func rightParenToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .rightParen,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func leftBraceToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .leftBrace,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func rightBraceToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .rightBrace,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func leftSquareBracketToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .leftSquareBracket,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func rightSquareBracketToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .rightSquareBracket,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func leftAngleToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .leftAngle,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func rightAngleToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .rightAngle,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func periodToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .period,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func prefixPeriodToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .prefixPeriod,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func commaToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .comma,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func ellipsisToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .ellipsis,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func colonToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .colon,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func semicolonToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .semicolon,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func equalToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .equal,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func atSignToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .atSign,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .pound,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func prefixAmpersandToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .prefixAmpersand,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func arrowToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .arrow,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func backtickToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .backtick,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func backslashToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .backslash,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func exclamationMarkToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .exclamationMark,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func postfixQuestionMarkToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .postfixQuestionMark,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func infixQuestionMarkToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .infixQuestionMark,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func stringQuoteToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .stringQuote,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func singleQuoteToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .singleQuote,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func multilineStringQuoteToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .multilineStringQuote,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundKeyPathKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundKeyPathKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundLineKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundLineKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundSelectorKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundSelectorKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundFileKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundFileKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundFileIDKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundFileIDKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundFilePathKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundFilePathKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundColumnKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundColumnKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundFunctionKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundFunctionKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundDsohandleKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundDsohandleKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundAssertKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundAssertKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundSourceLocationKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundSourceLocationKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundWarningKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundWarningKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundErrorKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundErrorKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundIfKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundIfKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundElseKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundElseKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundElseifKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundElseifKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundEndifKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundEndifKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundAvailableKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundAvailableKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundUnavailableKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundUnavailableKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundFileLiteralKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundFileLiteralKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundImageLiteralKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundImageLiteralKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundColorLiteralKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundColorLiteralKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func poundHasSymbolKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundHasSymbolKeyword,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func integerLiteral(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .integerLiteral(text),
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func floatingLiteral(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .floatingLiteral(text),
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func stringLiteral(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .stringLiteral(text),
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func regexLiteral(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .regexLiteral(text),
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func unknown(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .unknown(text),
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func identifier(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .identifier(text),
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func unspacedBinaryOperator(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .unspacedBinaryOperator(text),
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func spacedBinaryOperator(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .spacedBinaryOperator(text),
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func postfixOperator(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .postfixOperator(text),
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func prefixOperator(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .prefixOperator(text),
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func dollarIdentifier(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .dollarIdentifier(text),
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func contextualKeyword(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .contextualKeyword(text),
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func rawStringDelimiter(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .rawStringDelimiter(text),
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func stringSegment(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .stringSegment(text),
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func stringInterpolationAnchorToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .stringInterpolationAnchor,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func yieldToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .yield,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
  public static func eof(
    leadingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .eof,
      leadingTrivia: leadingTrivia,
      trailingTrivia: [],
      presence: presence
    )
  }
}
