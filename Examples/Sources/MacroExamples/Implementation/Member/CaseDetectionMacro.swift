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

import SwiftSyntax
import SwiftSyntaxMacros

public enum CaseDetectionMacro: MemberMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    declaration.memberBlock.members
      .compactMap { $0.decl.as(EnumCaseDeclSyntax.self) }
      .map { $0.elements }
      .flatMap { $0 }
      .map { $0.name }
      .map { ($0, $0.pascalcased) }
      .map { original, pascalcased in
        """
        var is\(raw: pascalcased): Bool {
            self == .\(raw: original)
        }
        """
      }
  }
}

extension TokenSyntax {
    fileprivate var pascalcased: String {
        self.text
            .replacingOccurrences(of: "_", with: " ")
            .replacingOccurrences(of: "(?<=.)([A-Z])", with: " $1", options: .regularExpression)
            .lowercased()
            .split(separator: " ")
            .map { $0.capitalized }
            .joined()
    }
}
