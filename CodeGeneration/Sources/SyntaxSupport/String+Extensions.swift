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

extension StringProtocol {
  public var withFirstCharacterLowercased: String {
    guard first?.isLetter ?? false else {
      return String(first!) + dropFirst().withFirstCharacterLowercased
    }
    return prefix(1).lowercased() + dropFirst()
  }
  public var withFirstCharacterUppercased: String {
    guard first?.isLetter ?? false else {
      return String(first!) + dropFirst().withFirstCharacterUppercased
    }
    return prefix(1).uppercased() + dropFirst()
  }
  public var backtickedIfNeeded: String {
    if Keyword.allCases.map(\.spec).contains(where: {
      $0.name == self && ($0.isLexerClassified || $0.name == "Type" || $0.name == "Protocol")
    }) {
      return "`\(self)`"
    } else {
      return String(self)
    }
  }
}

extension String {
  public var droppingLeadingUnderscores: String {
    if first == "_" {
      return String(self.dropFirst())
    }
    return self
  }
}
