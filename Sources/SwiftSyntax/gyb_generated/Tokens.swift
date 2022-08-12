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
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .associatedtypeKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func classKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .classKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func deinitKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .deinitKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func enumKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .enumKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func extensionKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .extensionKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func funcKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .funcKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func importKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .importKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func initKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .initKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func inoutKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .inoutKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func letKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .letKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func operatorKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .operatorKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func precedencegroupKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .precedencegroupKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func protocolKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .protocolKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func structKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .structKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func subscriptKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .subscriptKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func typealiasKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .typealiasKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func varKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .varKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func fileprivateKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .fileprivateKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func internalKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .internalKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func privateKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .privateKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func publicKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .publicKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func staticKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .staticKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func deferKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .deferKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func ifKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .ifKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func guardKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .guardKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func doKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .doKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func repeatKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .repeatKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func elseKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .elseKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func forKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .forKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func inKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .inKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func whileKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .whileKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func returnKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .returnKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func breakKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .breakKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func continueKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .continueKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func fallthroughKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .fallthroughKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func switchKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .switchKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func caseKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .caseKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func defaultKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .defaultKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func whereKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .whereKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func catchKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .catchKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func throwKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .throwKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func asKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .asKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func anyKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .anyKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func falseKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .falseKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func isKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .isKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func nilKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .nilKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func rethrowsKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .rethrowsKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func superKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .superKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func selfKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .selfKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func capitalSelfKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .capitalSelfKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func trueKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .trueKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func tryKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .tryKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func throwsKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .throwsKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func __file__Keyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .__file__Keyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func __line__Keyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .__line__Keyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func __column__Keyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .__column__Keyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func __function__Keyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .__function__Keyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func __dso_handle__Keyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .__dso_handle__Keyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func wildcardKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .wildcardKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func leftParenToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .leftParen,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func rightParenToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .rightParen,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func leftBraceToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .leftBrace,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func rightBraceToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .rightBrace,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func leftSquareBracketToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .leftSquareBracket,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func rightSquareBracketToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .rightSquareBracket,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func leftAngleToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .leftAngle,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func rightAngleToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .rightAngle,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func periodToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .period,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func prefixPeriodToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .prefixPeriod,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func commaToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .comma,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func ellipsisToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .ellipsis,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func colonToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .colon,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func semicolonToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .semicolon,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func equalToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .equal,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func atSignToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .atSign,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func poundToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .pound,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func prefixAmpersandToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .prefixAmpersand,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func arrowToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .arrow,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func backtickToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .backtick,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func backslashToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .backslash,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func exclamationMarkToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .exclamationMark,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func postfixQuestionMarkToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .postfixQuestionMark,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func infixQuestionMarkToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .infixQuestionMark,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func stringQuoteToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .stringQuote,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func singleQuoteToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .singleQuote,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func multilineStringQuoteToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .multilineStringQuote,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func poundKeyPathKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundKeyPathKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundLineKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundLineKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundSelectorKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundSelectorKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundFileKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundFileKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundFileIDKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundFileIDKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundFilePathKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundFilePathKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundColumnKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundColumnKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundFunctionKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundFunctionKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundDsohandleKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundDsohandleKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundAssertKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundAssertKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundSourceLocationKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundSourceLocationKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundWarningKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundWarningKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundErrorKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundErrorKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundIfKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundIfKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundElseKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundElseKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundElseifKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundElseifKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundEndifKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundEndifKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundAvailableKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundAvailableKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundUnavailableKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundUnavailableKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundFileLiteralKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundFileLiteralKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundImageLiteralKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundImageLiteralKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func poundColorLiteralKeyword(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .poundColorLiteralKeyword,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func integerLiteral(
    _ text: String,
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .integerLiteral(text),
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func floatingLiteral(
    _ text: String,
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .floatingLiteral(text),
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func stringLiteral(
    _ text: String,
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .stringLiteral(text),
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func regexLiteral(
    _ text: String,
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .regexLiteral(text),
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func unknown(
    _ text: String,
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .unknown(text),
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func identifier(
    _ text: String,
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .identifier(text),
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func unspacedBinaryOperator(
    _ text: String,
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .unspacedBinaryOperator(text),
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func spacedBinaryOperator(
    _ text: String,
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .spacedBinaryOperator(text),
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: .space),
      presence: presence
    )
  }
  public static func postfixOperator(
    _ text: String,
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .postfixOperator(text),
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func prefixOperator(
    _ text: String,
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .prefixOperator(text),
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func dollarIdentifier(
    _ text: String,
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .dollarIdentifier(text),
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func contextualKeyword(
    _ text: String,
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .contextualKeyword(text),
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func rawStringDelimiter(
    _ text: String,
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .rawStringDelimiter(text),
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func stringSegment(
    _ text: String,
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .stringSegment(text),
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func stringInterpolationAnchorToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .stringInterpolationAnchor,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func yieldToken(
    leadingTrivia: Trivia? = nil,
    trailingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .yield,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: trailingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      presence: presence
    )
  }
  public static func eof(
    leadingTrivia: Trivia? = nil,
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return TokenSyntax(
      .eof,
      leadingTrivia: leadingTrivia ?? defaultTrivia(presence: presence, trivia: []),
      trailingTrivia: [],
      presence: presence
    )
  }
}
