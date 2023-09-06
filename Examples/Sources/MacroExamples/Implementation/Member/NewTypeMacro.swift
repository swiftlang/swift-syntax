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
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public enum NewTypeMacro {}

extension NewTypeMacro: MemberMacro {
  public static func expansion<Declaration, Context>(
    of node: AttributeSyntax,
    providingMembersOf declaration: Declaration,
    in context: Context
  ) throws -> [DeclSyntax] where Declaration: DeclGroupSyntax, Context: MacroExpansionContext {
    do {
      guard
        case .argumentList(let arguments) = node.arguments,
        arguments.count == 1,
        let memberAccessExn = arguments.first?
          .expression.as(MemberAccessExprSyntax.self),
        let rawType = memberAccessExn.base?.as(DeclReferenceExprSyntax.self)
      else {
        throw CustomError.message(#"@NewType requires the raw type as an argument, in the form "RawType.self"."#)
      }

      guard let declaration = declaration.as(StructDeclSyntax.self) else {
        throw CustomError.message("@NewType can only be applied to a struct declarations.")
      }

      let access = declaration.modifiers.first(where: \.isNeededAccessLevelModifier)

      return [
        "\(access)typealias RawValue = \(rawType)",
        "\(access)var rawValue: RawValue",
        "\(access)init(_ rawValue: RawValue) { self.rawValue = rawValue }",
      ]
    } catch {
      print("--------------- throwing \(error)")
      throw error
    }
  }
}

extension DeclModifierSyntax {
  var isNeededAccessLevelModifier: Bool {
    switch self.name.tokenKind {
    case .keyword(.public): return true
    default: return false
    }
  }
}

extension SyntaxStringInterpolation {
  // It would be nice for SwiftSyntaxBuilder to provide this out-of-the-box.
  mutating func appendInterpolation<Node: SyntaxProtocol>(_ node: Node?) {
    if let node {
      appendInterpolation(node)
    }
  }
}
